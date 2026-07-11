---
note: true
layout: post
title: "第五章：扩散模型"
permalink: /posts/ai/generative-model/diffusion-models/
categories: generative-model
tags: [generative-model, diffusion-models, ddpm, score-matching, sde, ddim, flow-matching, stable-diffusion, dit]
use_math: true
---

本章从最基础的 DDPM（去噪扩散概率模型）出发，系统地贯穿 SDE/ODE 统一理论、分数匹配（Score Matching）视角，以及加速采样方法（DDIM、DPM-Solver、渐进蒸馏、一致性模型）。后半部分深入最新的流匹配（Flow Matching）范式和工业级应用，包括 DiT（Diffusion Transformer）和 Stable Diffusion 3，全面梳理了扩散模型从理论基础到前沿应用的发展全貌。

# 第5章 扩散模型

## 5.1 去噪扩散概率模型（DDPM）

### 5.1.1 基本框架

DDPM（Denoising Diffusion Probabilistic Models）是扩散模型的基础工作。它包含两个过程：

- **前向扩散过程（固定）**：逐步向数据中添加噪声，直至变为纯噪声
- **反向去噪过程（可学习）**：从噪声逐步恢复出数据

### 5.1.2 前向过程

前向过程是固定的马尔可夫链，逐步添加高斯噪声：

$$
q(\mathbf{x}_{1:T} \mid \mathbf{x}_0) := \prod_{t=1}^{T} q(\mathbf{x}_t \mid \mathbf{x}_{t-1}), \qquad q(\mathbf{x}_t \mid \mathbf{x}_{t-1}) := \mathcal{N}(\mathbf{x}_t; \sqrt{1 - \beta_t}\,\mathbf{x}_{t-1}, \beta_t \mathbf{I})
$$

其中 $\beta_t \in (0, 1)$ 为噪声调度参数。定义 $\alpha_t = 1 - \beta_t$，$\bar{\alpha}_t = \prod_{s=1}^{t} \alpha_s$，通过递推可得任意时间步 $t$ 的闭式解：

$$
q(\mathbf{x}_t \mid \mathbf{x}_0) = \mathcal{N}(\mathbf{x}_t; \sqrt{\bar{\alpha}_t}\,\mathbf{x}_0, (1 - \bar{\alpha}_t)\mathbf{I})
$$

利用重参数化技巧：

$$
\mathbf{x}_t = \sqrt{\bar{\alpha}_t}\,\mathbf{x}_0 + \sqrt{1 - \bar{\alpha}_t}\,\boldsymbol{\epsilon}, \quad \boldsymbol{\epsilon} \sim \mathcal{N}(\mathbf{0}, \mathbf{I})
$$

前向过程的终点设计为：当 $T$ 足够大时，$\sqrt{\bar{\alpha}_T} \to 0$，$1 - \bar{\alpha}_T \to 1$，使得 $p(\mathbf{x}_T) \approx \mathcal{N}(\mathbf{0}, \mathbf{I})$。

### 5.1.3 反向过程

反向过程是一个可学习的去噪马尔可夫链，从纯噪声出发逐步恢复数据：

$$
p_{\theta}(\mathbf{x}_{0:T}) := p(\mathbf{x}_T) \prod_{t=1}^{T} p_{\theta}(\mathbf{x}_{t-1} \mid \mathbf{x}_t), \qquad p_{\theta}(\mathbf{x}_{t-1} \mid \mathbf{x}_t) := \mathcal{N}(\mathbf{x}_{t-1}; \boldsymbol{\mu}_{\theta}(\mathbf{x}_t, t), \sigma_t^2 \mathbf{I})
$$

其中 $\sigma_t^2$ 通常固定（如 $\beta_t$ 或 $\tilde{\beta}_t$），$\boldsymbol{\mu}_{\theta}$ 由神经网络参数化。

### 5.1.4 变分推断与ELBO

DDPM 的训练目标来自变分下界（ELBO），与 VAE 类似。将 $\mathbf{x}_{1:T}$ 视为潜变量，训练目标为最大化 $\log p_{\theta}(\mathbf{x}_0)$ 的 ELBO：

$$
\mathbb{E}_q \bigg[ \underbrace{D_{\mathrm{KL}}(q(\mathbf{x}_T \mid \mathbf{x}_0) \parallel p(\mathbf{x}_T))}_{L_T} + \sum_{t > 1} \underbrace{D_{\mathrm{KL}}(q(\mathbf{x}_{t-1} \mid \mathbf{x}_t, \mathbf{x}_0) \parallel p_{\theta}(\mathbf{x}_{t-1} \mid \mathbf{x}_t))}_{L_{t-1}} \underbrace{-\log p_{\theta}(\mathbf{x}_0 \mid \mathbf{x}_1)}_{L_0} \bigg]
$$

关键在于 $q(\mathbf{x}_{t-1} \mid \mathbf{x}_t, \mathbf{x}_0)$ 有闭式解（以 $\mathbf{x}_0$ 为条件时，反向条件分布也是高斯分布）：

$$
q(\mathbf{x}_{t-1} \mid \mathbf{x}_t, \mathbf{x}_0) = \mathcal{N}(\mathbf{x}_{t-1}; \tilde{\boldsymbol{\mu}}_t(\mathbf{x}_t, \mathbf{x}_0), \tilde{\beta}_t \mathbf{I})
$$

其中：

$$
\tilde{\boldsymbol{\mu}}_t(\mathbf{x}_t, \mathbf{x}_0) := \frac{\sqrt{\bar{\alpha}_{t-1}}\beta_t}{1 - \bar{\alpha}_t}\mathbf{x}_0 + \frac{\sqrt{\alpha_t}(1 - \bar{\alpha}_{t-1})}{1 - \bar{\alpha}_t}\mathbf{x}_t, \qquad \tilde{\beta}_t := \frac{1 - \bar{\alpha}_{t-1}}{1 - \bar{\alpha}_t}\beta_t
$$

### 5.1.5 简化的训练损失

由于 $q$ 和 $p_{\theta}$ 都是高斯分布，$L_{t-1}$ 中的 KL 散度有闭式解：

$$
L_{t-1} = \mathbb{E}_q \left[ \frac{1}{2\sigma_t^2} \big\| \tilde{\boldsymbol{\mu}}_t(\mathbf{x}_t, \mathbf{x}_0) - \boldsymbol{\mu}_{\theta}(\mathbf{x}_t, t) \big\|^2 \right] + C
$$

利用 $\mathbf{x}_t = \sqrt{\bar{\alpha}_t}\mathbf{x}_0 + \sqrt{1 - \bar{\alpha}_t}\boldsymbol{\epsilon}$，$\tilde{\boldsymbol{\mu}}_t$ 可重写为：

$$
\tilde{\boldsymbol{\mu}}_t(\mathbf{x}_t, \mathbf{x}_0) = \frac{1}{\sqrt{\alpha_t}} \left(\mathbf{x}_t - \frac{\beta_t}{\sqrt{1 - \bar{\alpha}_t}}\boldsymbol{\epsilon}\right)
$$

对应的，将 $\boldsymbol{\mu}_{\theta}$ 参数化为预测噪声的形式：

$$
\boldsymbol{\mu}_{\theta}(\mathbf{x}_t, t) = \frac{1}{\sqrt{\alpha_t}} \left(\mathbf{x}_t - \frac{\beta_t}{\sqrt{1 - \bar{\alpha}_t}}\boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, t)\right)
$$

代入后，$L_{t-1}$ 化简为噪声预测损失。DDPM 进一步将权重系数置为 1，得到极简的训练目标：

$$
\boxed{L_{\text{simple}}(\theta) := \mathbb{E}_{t, \mathbf{x}_0, \boldsymbol{\epsilon}} \Big[ \big\| \boldsymbol{\epsilon} - \boldsymbol{\epsilon}_{\theta}(\sqrt{\bar{\alpha}_t}\,\mathbf{x}_0 + \sqrt{1 - \bar{\alpha}_t}\,\boldsymbol{\epsilon}, t) \big\|^2 \Big]}
$$

**训练过程**：对每个训练步，采样 $\mathbf{x}_0 \sim q(\mathbf{x}_0)$，$t \sim \text{Uniform}(\{1, \ldots, T\})$，$\boldsymbol{\epsilon} \sim \mathcal{N}(\mathbf{0}, \mathbf{I})$，然后对 $\nabla_{\theta}\|\boldsymbol{\epsilon} - \boldsymbol{\epsilon}_{\theta}(\sqrt{\bar{\alpha}_t}\mathbf{x}_0 + \sqrt{1 - \bar{\alpha}_t}\boldsymbol{\epsilon}, t)\|^2$ 做梯度下降。

**采样过程**：从 $\mathbf{x}_T \sim \mathcal{N}(\mathbf{0}, \mathbf{I})$ 出发，对 $t = T, \ldots, 1$ 逐步去噪：

$$
\mathbf{x}_{t-1} = \frac{1}{\sqrt{\alpha_t}} \left( \mathbf{x}_t - \frac{1 - \alpha_t}{\sqrt{1 - \bar{\alpha}_t}} \boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, t) \right) + \sigma_t \mathbf{z}
$$

其中 $\mathbf{z} \sim \mathcal{N}(\mathbf{0}, \mathbf{I})$（$t > 1$ 时），$t = 1$ 时 $\mathbf{z} = 0$。

## 5.2 噪声调度与方差学习

噪声调度 $\beta_t$ 控制加噪速率，常见方案包括线性调度和余弦调度。方差 $\sigma_t^2$ 可固定为 $\beta_t$ 或 $\tilde{\beta}_t$，也可通过插值参数 $v$ 学习：$\Sigma_{\theta}(\mathbf{x}_t, t) = \exp(v \log \beta_t + (1 - v) \log \tilde{\beta}_t)$。


## 5.3 DDPM与VAE的对比

DDPM 可视为一种特殊的分层 VAE，其潜变量 $\mathbf{x}_{1:T}$ 与数据同维度。关键区别：

- **编码器固定**：前向过程无参数，训练更稳定，避免了 VAE 中常见的后验坍缩问题
- **多步生成**：采样需顺序经过 $T$ 步（通常 $T = 1000$），推理开销大
- **训练目标**：使用 ELBO 的重新加权形式（$L_{\text{simple}}$ 舍弃了原始权重）

## 5.4 架构设计

DDPM 的去噪网络 $\boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, t)$ 通常采用 U-Net 架构，时间 $t$ 通过正弦位置嵌入注入网络各层。


## 5.5 条件扩散模型

条件扩散模型通过注意力机制将条件信息（如文本、类别标签）注入去噪网络 $\boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, t, \mathbf{y})$，其中 $\mathbf{y}$ 的条件表示 $\tau_{\theta}(\mathbf{y})$ 作为交叉注意力的 key 和 value。


## 5.6 潜扩散模型（LDM）

潜扩散模型（Latent Diffusion Models）在预训练自编码器的潜空间中训练扩散模型。通过将高维图像压缩到低维潜空间，大幅降低了扩散模型的计算量，同时保持了生成质量。Stable Diffusion 是这一方法的代表性实现，通过交叉注意力引入文本条件，实现了文本到图像的高质量生成。


## 5.7 无分类器引导（CFG）

### 5.7.1 分类器引导

分类器引导利用辅助分类器 $p(y \mid \mathbf{x}_t)$ 的梯度来引导生成：

$$
\hat{\boldsymbol{\epsilon}} = \boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t) - \sqrt{1 - \bar{\alpha}_t} \cdot \nabla_{\mathbf{x}_t} \log p(y \mid \mathbf{x}_t)
$$

### 5.7.2 无分类器引导

无分类器引导（Classifier-Free Guidance）避免了额外分类器的训练。核心技巧是训练时以一定概率（如 10%）随机丢弃条件，使同一网络同时学习条件预测 $\boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, \mathbf{c})$ 和无条件预测 $\boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, \varnothing)$。推理时通过外推实现引导：

$$
\boxed{\tilde{\boldsymbol{\epsilon}}_{\theta}(\mathbf{x}_t, \mathbf{c}) = \boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, \varnothing) + w \cdot \big(\boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, \mathbf{c}) - \boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, \varnothing)\big)}
$$

或等价地：

$$
\tilde{\boldsymbol{\epsilon}}_{\theta}(\mathbf{x}_t, \mathbf{c}) = (1 + w)\,\boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, \mathbf{c}) - w \cdot \boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, \varnothing)
$$

其中 $w \geq 0$ 为引导强度。$w = 0$ 退化为无条件生成，$w > 0$ 增强条件一致性（通常 $w \in [2, 5]$ 效果较好）。


## 5.8 DDIM采样

### 5.8.1 非马尔可夫前向过程

DDIM（Denoising Diffusion Implicit Models）将 DDPM 推广到一类非马尔可夫扩散过程，保持相同的边缘分布：

$$
q_{\sigma}(\mathbf{x}_{1:T} \mid \mathbf{x}_0) := q(\mathbf{x}_T \mid \mathbf{x}_0) \prod_{t=2}^{T} q_{\sigma}(\mathbf{x}_{t-1} \mid \mathbf{x}_t, \mathbf{x}_0)
$$

关键是边缘分布 $q(\mathbf{x}_t \mid \mathbf{x}_0) = \mathcal{N}(\sqrt{\bar{\alpha}_t}\mathbf{x}_0, (1 - \bar{\alpha}_t)\mathbf{I})$ 保持不变，因此 DDPM 训练好的模型可直接用于 DDIM 采样，无需重新训练。

### 5.8.2 广义采样公式

给定 $\hat{\mathbf{x}}_0 := (\mathbf{x}_t - \sqrt{1 - \bar{\alpha}_t}\,\boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, t)) / \sqrt{\bar{\alpha}_t}$，反向采样为：

$$
\mathbf{x}_{t-1} = \sqrt{\bar{\alpha}_{t-1}}\,\hat{\mathbf{x}}_0 + \sqrt{1 - \bar{\alpha}_{t-1} - \tilde{\sigma}_t^2} \cdot \frac{\mathbf{x}_t - \sqrt{\bar{\alpha}_t}\,\hat{\mathbf{x}}_0}{\sqrt{1 - \bar{\alpha}_t}} + \tilde{\sigma}_t \mathbf{z}
$$

其中 $\tilde{\sigma}_t^2 = \eta \cdot \frac{1 - \bar{\alpha}_{t-1}}{1 - \bar{\alpha}_t}\beta_t$，参数 $\eta \in [0, 1]$ 控制随机性程度。

### 5.8.3 确定性采样与ODE连接

当 $\eta = 0$（即 $\tilde{\sigma}_t = 0$）时，采样过程变为完全确定性——给定 $\mathbf{x}_T$，生成的 $\mathbf{x}_0$ 唯一确定。此时 DDIM 对应于概率流 ODE 的一种离散化，解轨迹近似线性且曲率低，从而可使用大幅减少的采样步数（如 50-100 步替代 1000 步）获得高质量样本。


## 5.9 SDE/ODE统一框架

### 5.9.1 前向与反向扩散SDE

将离散前向过程取无穷小时间步极限，得到随机微分方程（SDE）。DDPM 的前向过程在连续极限下变为 **VP SDE**（Variance Preserving）：

$$
\boxed{\mathrm{d}\mathbf{x} = -\frac{1}{2}\beta(t)\mathbf{x}\,\mathrm{d}t + \sqrt{\beta(t)}\,\mathrm{d}\boldsymbol{\omega}}
$$

其中 $\boldsymbol{\omega}$ 是标准维纳过程，$\beta(t)$ 是连续噪声调度。

更一般地，前向扩散 SDE 可写为：

$$
\boxed{\mathrm{d}\mathbf{x} = \mathbf{f}(\mathbf{x}, t)\,\mathrm{d}t + g(t)\,\mathrm{d}\boldsymbol{\omega}}
$$

其中 $\mathbf{f}$ 为漂移系数，$g$ 为扩散系数。

Anderson (1982) 的结果给出了时间反演 SDE——这是生成过程的核心：

$$
\boxed{\mathrm{d}\mathbf{x} = \big[\mathbf{f}(\mathbf{x}, t) - g(t)^2 \nabla_{\mathbf{x}} \log p_t(\mathbf{x})\big]\,\mathrm{d}t + g(t)\,\mathrm{d}\bar{\boldsymbol{\omega}}}
$$

其中 $\bar{\boldsymbol{\omega}}$ 是反向时间的维纳过程。训练目标是用神经网络 $\mathbf{s}_{\theta}(\mathbf{x}_t, t)$ 近似分数函数 $\nabla_{\mathbf{x}} \log p_t(\mathbf{x})$。

### 5.9.2 概率流ODE

与反向 SDE 共享相同边缘分布，存在一个等价的确定性常微分方程——**概率流 ODE**（Probability Flow ODE）：

$$
\boxed{\mathrm{d}\mathbf{x} = \Big[\mathbf{f}(\mathbf{x}, t) - \frac{1}{2}g(t)^2 \nabla_{\mathbf{x}} \log p_t(\mathbf{x})\Big]\,\mathrm{d}t}
$$

该 ODE 定义的轨迹等价于连续归一化流，支持精确似然计算（通过对散度积分）：

$$
\log p_0(\mathbf{x}(0)) = \log p_T(\mathbf{x}(T)) + \int_0^T \nabla \cdot \tilde{\mathbf{f}}_{\theta}(\mathbf{x}(t), t)\,\mathrm{d}t
$$

### 5.9.3 更多SDE类型

除 VP SDE 外，常见的还有 **VE SDE**（Variance Exploding）：

$$
\boxed{\mathrm{d}\mathbf{x} = \sqrt{\frac{\mathrm{d}[\sigma^2(t)]}{\mathrm{d}t}}\,\mathrm{d}\boldsymbol{\omega}}
$$

VE SDE 的方差随 $t$ 增长而爆炸（$\sigma(t)$ 单调递增），与 NCSN 的多尺度噪声扰动对应。

**sub-VP SDE** 则是 VP 和 VE 的混合：

$$
\mathrm{d}\mathbf{x} = -\frac{1}{2}\beta(t)\mathbf{x}\,\mathrm{d}t + \sqrt{\beta(t)(1 - e^{-2\int_0^t \beta(s)\mathrm{d}s})}\,\mathrm{d}\boldsymbol{\omega}
$$


## 5.10 分数匹配（Score Matching）

分数匹配是扩散模型训练的理论基础。其目标是训练神经网络 $\mathbf{s}_{\theta}(\mathbf{x})$ 来逼近数据的分数函数 $\nabla_{\mathbf{x}} \log p(\mathbf{x})$。

### 5.10.1 显式分数匹配

最直接的训练目标是：

$$
\mathcal{L}_{\text{ESM}} = \mathbb{E}_{\mathbf{x} \sim p} \left[ \frac{1}{2} \big\| \mathbf{s}_{\theta}(\mathbf{x}) - \nabla_{\mathbf{x}} \log p(\mathbf{x}) \big\|^2 \right]
$$

展开后：

$$
\mathcal{L}_{\text{ESM}} = \mathbb{E}_{\mathbf{x} \sim p} \left[ \frac{1}{2}\|\mathbf{s}_{\theta}\|^2 - \mathbf{s}_{\theta}^{\mathsf{T}}\nabla \log p + \frac{1}{2}\|\nabla \log p\|^2 \right]
$$

最后一项 $\|\nabla \log p\|^2$（Fisher 信息）与 $\theta$ 无关。但 $\nabla \log p$ 本身未知，因此显式分数匹配不可直接计算。

### 5.10.2 隐式分数匹配

通过对交叉项分部积分，可将未知的 $\nabla \log p$ 消除：

$$
\begin{aligned}
\mathbb{E}_{\mathbf{x} \sim p} \big[ \mathbf{s}_{\theta}^{\mathsf{T}} \nabla \log p \big] &= \int \mathbf{s}_{\theta}(\mathbf{x})^{\mathsf{T}} \nabla \log p(\mathbf{x})\,p(\mathbf{x})\,\mathrm{d}\mathbf{x} \\
&= \int \nabla \cdot (p\,\mathbf{s}_{\theta})\,\mathrm{d}\mathbf{x} - \int p\,\nabla \cdot \mathbf{s}_{\theta}\,\mathrm{d}\mathbf{x} \\
&= -\mathbb{E}_{\mathbf{x} \sim p} \big[ \nabla \cdot \mathbf{s}_{\theta}(\mathbf{x}) \big]
\end{aligned}
$$

（边界项在适当正则条件下消失。）由此得到隐式分数匹配损失，仅涉及 $\mathbf{s}_{\theta}$ 及其散度。

### 5.10.3 去噪分数匹配

隐式分数匹配中的散度 $\nabla \cdot \mathbf{s}_{\theta}$ 在高维下计算昂贵。关键洞察是利用扰动数据的条件分布来绕过这一困难。去噪分数匹配的核心等价关系：

$$
\boxed{\mathbb{E}_{\mathbf{x}_t} \big\| \mathbf{s}_{\theta}(\mathbf{x}_t) - \nabla \log q(\mathbf{x}_t) \big\|^2 \;=\; \mathbb{E}_{\mathbf{x}_0, \mathbf{x}_t} \big\| \mathbf{s}_{\theta}(\mathbf{x}_t) - \nabla \log q(\mathbf{x}_t \mid \mathbf{x}_0) \big\|^2 + \text{const}}
$$

其中 $\nabla \log q(\mathbf{x}_t \mid \mathbf{x}_0)$ 是解析可计算的——这是将问题从估计未知的 $\nabla \log q(\mathbf{x}_t)$ 转化为估计已知条件分布的分数。

### 5.10.4 与DDPM的重参数化连接

对于 VP SDE，$q(\mathbf{x}_t \mid \mathbf{x}_0) = \mathcal{N}(\mathbf{x}_t; \sqrt{\bar{\alpha}_t}\mathbf{x}_0, (1 - \bar{\alpha}_t)\mathbf{I})$，条件分数为：

$$
\nabla_{\mathbf{x}_t} \log q(\mathbf{x}_t \mid \mathbf{x}_0) = -\frac{\mathbf{x}_t - \sqrt{\bar{\alpha}_t}\mathbf{x}_0}{1 - \bar{\alpha}_t} = -\frac{\boldsymbol{\epsilon}}{\sqrt{1 - \bar{\alpha}_t}}
$$

定义 $\mathbf{s}_{\theta}(\mathbf{x}_t, t) := -\dfrac{\boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, t)}{\sqrt{1 - \bar{\alpha}_t}}$，噪声预测网络与分数网络等价。训练目标为：

$$
\min_{\theta} \mathbb{E}_{t, \mathbf{x}_0, \boldsymbol{\epsilon}} \left[ \frac{1}{1 - \bar{\alpha}_t} \big\| \boldsymbol{\epsilon} - \boldsymbol{\epsilon}_{\theta}(\mathbf{x}_t, t) \big\|_2^2 \right]
$$

DDPM 的 $L_{\text{simple}}$ 正是舍弃了权重 $1/(1 - \bar{\alpha}_t)$ 的特例。这一连接揭示了：**扩散模型的噪声预测本质上等价于学习扰动数据的分数函数**。


## 5.11 基于分数的生成模型回顾

基于分数的生成模型（NCSN）学习分数函数 $\nabla_{\mathbf{x}} \log p(\mathbf{x})$ 而非密度函数本身。采样通过 Langevin 动力学实现：

$$
\mathbf{x}_{t+1} = \mathbf{x}_t + \delta\,\mathbf{s}_{\theta}(\mathbf{x}_t) + \sqrt{2\delta}\,\mathbf{z}_t, \quad \mathbf{z}_t \sim \mathcal{N}(\mathbf{0}, \mathbf{I})
$$

为应对低密度区域分数估计不准的问题，NCSN 在多个噪声尺度上训练并采用退火 Langevin 动力学逐步采样。


## 5.12 DPM-Solver

DPM-Solver 是专为扩散模型设计的快速 ODE 求解器。其核心思想是利用扩散 ODE 的半线性结构——将线性部分（由 $\beta_t$ 决定）精确求解，仅对非线性部分（$\boldsymbol{\epsilon}_{\theta}$）做数值近似。DPM-Solver-1 等价于 DDIM，高阶版本（DPM-Solver-2、DPM-Solver-3）通过多项式近似 $\boldsymbol{\epsilon}_{\theta}$ 在相邻时间步之间的变化，以更少的函数评估次数达到收敛。


## 5.13 DiffFlow

DiffFlow 将扩散模型的前向和反向过程均设为可训练的随机过程，通过最小化前向-反向轨迹分布之间的 KL 散度进行训练。前向传播的微分需要对网络展开 $N$ 次，训练面临梯度计算挑战。


## 5.14 EM交替训练

可通过 EM 算法交替训练前向和反向模型，各自在对方固定的条件下优化同一 KL 散度目标。该方法可视为 DiffFlow 的另一种训练范式。

## 5.15 渐进蒸馏

渐进蒸馏将采样步数逐轮减半：学生模型学习一次步进完成教师模型两步的去噪任务，学生随后成为下一轮教师。经过多轮蒸馏，可将 1000 步采样压缩到个位数步。


## 5.16 一致性模型

一致性模型将概率流 ODE 轨迹上的任意点直接映射到原点（干净数据），实现一步生成。训练方式有两种：一致性蒸馏（CD，依赖预训练扩散模型）和一致性训练（CT，直接从数据训练，无需预训练模型）。


## 5.17 流匹配（Flow Matching）

### 5.17.1 基本思想

流匹配（Flow Matching, FM）是一种无需模拟（simulation-free）的连续归一化流训练方法。给定从 $p_0$ 到 $p_1$ 的概率路径 $p_t$ 和对应的向量场 $u(t, \mathbf{x})$，FM 直接回归：

$$
\mathcal{L}_{\text{FM}}(\theta) = \mathbb{E}_{t \sim \mathcal{U}[0,1], \mathbf{x} \sim p_t} \left[ \big\| \mathbf{v}_{\theta}(t, \mathbf{x}) - \mathbf{u}(t, \mathbf{x}) \big\|^2 \right]
$$

问题是 "真实" 边缘向量场 $\mathbf{u}(t, \mathbf{x})$ 未知。关键突破在于条件流匹配。

### 5.17.2 条件流匹配

定义条件概率路径 $p_t(\mathbf{x} \mid \mathbf{x}_1)$（以数据 $\mathbf{x}_1$ 为条件）和条件向量场 $\mathbf{u}_t(\mathbf{x} \mid \mathbf{x}_1)$，满足边缘化后得到目标 $p_t$。条件流匹配的损失为：

$$
\mathcal{L}_{\text{CFM}}(\theta) = \mathbb{E}_{t \sim \mathcal{U}[0,1], \mathbf{x}_1 \sim q, \mathbf{x}_t \sim p_t(\mathbf{x} \mid \mathbf{x}_1)} \left[ \big\| \mathbf{v}_{\theta}(t, \mathbf{x}_t) - \mathbf{u}_t(\mathbf{x}_t \mid \mathbf{x}_1) \big\|^2 \right]
$$

**核心等价性**：$\mathcal{L}_{\text{FM}}(\theta) = \mathcal{L}_{\text{CFM}}(\theta) + \text{const}$。证明的关键在于验证两个损失内积项的一阶矩相等——这是由于边缘向量场可表达为条件向量场的条件期望：

$$
\mathbf{u}_t(\mathbf{x}) = \int \mathbf{u}_t(\mathbf{x} \mid \mathbf{x}_1) \frac{p_t(\mathbf{x} \mid \mathbf{x}_1) q(\mathbf{x}_1)}{p_t(\mathbf{x})}\,\mathrm{d}\mathbf{x}_1
$$

展开 FM 损失的平方项后，交叉项经条件期望化简即得 CFM 损失。

### 5.17.3 条件向量场的构造

实用中，条件路径常取高斯形式 $p_t(\mathbf{x} \mid \mathbf{x}_1) = \mathcal{N}(\mathbf{x}; \mu_t(\mathbf{x}_1), \sigma_t(\mathbf{x}_1)^2 \mathbf{I})$，对应条件向量场：

$$
\mathbf{u}_t(\mathbf{x} \mid \mathbf{x}_1) = \frac{\dot{\sigma}_t(\mathbf{x}_1)}{\sigma_t(\mathbf{x}_1)}(\mathbf{x} - \mu_t(\mathbf{x}_1)) + \dot{\mu}_t(\mathbf{x}_1)
$$

### 5.17.4 耦合策略

$\mathbf{x}_0$ 和 $\mathbf{x}_1$ 的耦合方式直接影响路径质量：

- **扩散耦合**（单边条件）：$\mathbf{x}_t = \sqrt{\bar{\alpha}_{1-t}}\,\mathbf{x}_1 + \sqrt{1-\bar{\alpha}_{1-t}}\,\boldsymbol{\epsilon}$，对应 DDPM 的扩散路径
- **最优传输耦合（OT coupling）**：通过求解最优传输问题配对 $(\mathbf{x}_0, \mathbf{x}_1)$，构造线性路径 $\mathbf{x}_t = t\mathbf{x}_1 + (1 - t)\mathbf{x}_0$，路径更直、训练方差更低

OT 耦合配合流匹配在更少的函数评估次数（NFE）下即可获得与扩散模型相当甚至更好的采样质量。


## 5.18 k-整流流

整流流（Rectified Flow）通过期望回归 $\mathbb{E}[\dot{\mathbf{X}}_t \mid \mathbf{X}_t = \mathbf{x}]$ 拉直概率路径，降低传输代价。多次应用整流操作（Reflow）可进一步拉直路径，使 ODE 轨迹接近直线，从而支持极少数步采样。


## 5.19 平均流

平均流利用路径上的平均速度替代瞬时速度进行大步长采样，通过 MeanFlow 恒等式建立平均速度与瞬时速度的关系。

## 5.20 Diffusion Transformer（DiT）

DiT 将扩散模型中的 U-Net 替换为 Vision Transformer 架构：输入潜变量被切分为 patch 并作为 token 序列处理，通过自适应层归一化注入时间步和条件信息。DiT 展示了与大型语言模型类似的缩放规律——更大计算量带来显著更高的样本质量。


## 5.21 Stable Diffusion 3

SD3 采用流匹配框架，使用 $z_t = a_t x_0 + b_t \epsilon$ 的参数化，通过 Logit-Normal 时间步采样提升中间时间步的学习权重。SD3 比较了整流流、EDM、余弦等多种轨迹变体，展示了流匹配配合 Logit-Normal 采样在各种设置下的优越性。


## 5.22 扩散模型总结

扩散模型的发展呈现出清晰的演进脉络：

- **DDPM** 作为特殊的分层 VAE，通过噪声预测建立了扩散生成的基础范式
- **分数匹配与 SDE/ODE 框架** 提供了统一的理论视角——将去噪目标解释为分数估计，将采样过程解释为逆向 SDE 或概率流 ODE
- **DDIM** 揭示了非马尔可夫推广与确定性采样的可能性，大幅减少采样步数
- **CFG** 实现了无需额外分类器的条件引导，成为文生图的标准技术
- **LDM** 将扩散模型迁移到潜空间，推动了大尺度生成模型的实用化
- **DPM-Solver、渐进蒸馏、一致性模型** 从不同角度加速采样
- **Flow Matching / Rectified Flow** 代表新一代训练范式——无需模拟、配合 OT 耦合实现高效训练和直路径采样，正在成为扩散模型的替代方案

---

## 导航栏

**生成模型 系列文章**

- [第一章：生成模型概述](/posts/ai/generative-model/overview/)
- [第二章：自回归模型](/posts/ai/generative-model/autoregressive-models/)
- [第三章：归一化流](/posts/ai/generative-model/normalizing-flows/)
- [第四章：变分自编码器](/posts/ai/generative-model/variational-autoencoder/)
- [第五章：扩散模型](/posts/ai/generative-model/diffusion-models/)
- [第六章：生成对抗网络](/posts/ai/generative-model/generative-adversarial-networks/)
