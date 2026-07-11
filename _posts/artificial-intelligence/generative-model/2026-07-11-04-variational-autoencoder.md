---
note: true
layout: post
title: "第四章：变分自编码器"
permalink: /posts/ai/generative-model/variational-autoencoder/
categories: generative-model
tags: [generative-model, variational-autoencoder, vae, elbo, em-algorithm, gmm, reparameterization-trick, vq-vae]
use_math: true
---

本章采用"从具体到抽象"的教学递进策略：先通过高斯混合模型（GMM）和 EM 算法建立潜变量模型的直觉（离散潜变量可精确计算），再发现 EM 在连续潜变量时失效，从而引入变分推断和证据下界（ELBO），最终用神经网络参数化编码器和解码器得到 VAE。涵盖重参数化技巧的完整推导、潜变量空间插值、以及分层潜变量和 VQ-VAE 等扩展方向。

# 第4章 变分自编码器

## 4.1 从生成模型到潜变量模型

### 4.1.1 回顾核心问题

在第1章中我们确立了生成模型的根本目标：**最大化数据的对数似然** $\log p(x)$。给定训练集 $\mathcal{D} = \{x_1, x_2, \dots, x_N\}$，我们希望通过参数 $\theta$ 建模数据分布 $p_\theta(x)$，使得：

$$
\max_\theta \sum_{x \in \mathcal{D}} \log p_\theta(x)
$$

问题在于：如何定义和计算 $p_\theta(x)$？前两章的自回归模型和归一化流分别给出了各自的答案。本章介绍的**变分自编码器（Variational Autoencoder, VAE）**走的是第三条路：**引入潜变量（latent variables）**。

### 4.1.2 潜变量的直觉

数据背后往往存在不可直接观测的"隐藏因素"。例如：

- 一张人脸照片背后有**身份、姿态、光照、表情**等隐藏属性
- 一段语音背后有**说话人、内容、情绪**等隐藏因素
- 手写数字背后有**数字类别、笔画粗细、倾斜角度**等隐藏变化

潜变量 $z$ 正是用来捕捉这些隐藏因素的。生成过程可以理解为：先从潜变量分布中抽取隐藏因素 $z$，再根据 $z$ 生成观测数据 $x$。

### 4.1.3 符号定义

在深入推导之前，先明确本章的核心符号。**养成看到符号就能反应其含义的习惯，是读懂本章的关键**。

| 符号 | 名称 | 含义 |
|------|------|------|
| $p(z)$ | 先验（prior） | 潜变量 $z$ 的初始分布，通常取标准正态 $\mathcal{N}(0, I)$ |
| $p_\theta(x \mid z)$ | 似然 / 解码器（decoder） | 给定潜变量 $z$，生成数据 $x$ 的条件分布 |
| $p_\theta(z \mid x)$ | 后验（posterior） | 给定数据 $x$，推断其对应潜变量 $z$ 的分布 |
| $p_\theta(x)$ | 证据 / 边际似然（evidence） | 数据 $x$ 的分布——**这正是我们要建模的目标** |
| $q_\phi(z \mid x)$ | 变分后验 / 编码器（encoder） | 用神经网络近似的后验分布，$\phi$ 是编码器参数 |
| $\theta$ | 生成参数 | 解码器 $p_\theta(x \mid z)$ 的可学习参数 |
| $\phi$ | 变分参数 | 编码器 $q_\phi(z \mid x)$ 的可学习参数 |

> **关键区分**：$p_\theta(z \mid x)$ 是**真实**后验（通常不可计算），$q_\phi(z \mid x)$ 是**近似**后验（用神经网络实现）。VAE 的核心就是用 $q_\phi$ 去逼近 $p_\theta$。

### 4.1.4 潜变量模型的边际似然

根据全概率公式，数据的边际分布为：

$$
\boxed{p_\theta(x) = \int p_\theta(x, z)\, dz = \int p_\theta(x \mid z)\, p(z)\, dz}
$$

这个公式的含义是：对所有可能的潜变量 $z$ 求积分，把每个 $z$ 生成 $x$ 的概率加权累加起来。

**核心困难**：当 $z$ 是连续高维向量且 $p_\theta(x \mid z)$ 由复杂神经网络定义时，这个积分没有解析解。直接 Monte Carlo 采样 $z \sim p(z)$ 来估计也会因高维度导致方差极大。

### 4.1.5 本章的逻辑路线

VAE 的推导并非一蹴而就，而是沿着一条清晰的逻辑链条展开：

$$
\text{GMM（离散潜变量）} \;\to\; \text{EM算法（通用框架）} \;\to\; \text{ELBO（变分下界）} \;\to\; \text{VAE（神经网络实现）}
$$

- **4.2 节**：先看最简单的情况——$z$ 是离散的（GMM），此时积分退化为求和，一切都可以精确计算
- **4.3 节**：从 GMM 提炼出 EM 算法的通用框架
- **4.4 节**：发现 EM 在连续潜变量时失效，引入变分推断和 ELBO
- **4.5 节**：从重要性采样的角度重新理解 ELBO
- **4.6 节**：用神经网络参数化编码器和解码器，得到 VAE

---

## 4.2 热身：高斯混合模型 —— 离散潜变量

在进入连续潜变量的复杂世界之前，先看一个**所有计算都能精确完成**的特例。这不仅是理解 EM 算法的入口，也是理解 VAE 为何要引入变分下界的必要铺垫。

### 4.2.1 模型定义

**高斯混合模型（Gaussian Mixture Model, GMM）** 假设潜变量 $z$ 只能取 $K$ 个离散值：

$$
p(z = i) = \pi_i, \quad i = 1, 2, \dots, K
$$

其中 $\pi_i \ge 0$ 且 $\sum_i \pi_i = 1$，称为**混合系数（mixing coefficients）**。

给定 $z = i$，数据 $x$ 服从一个高斯分布：

$$
p(x \mid z = i) = \mathcal{N}(x \mid \mu_i, \Sigma_i)
$$

那么数据的边际分布退化为**求和**而非积分：

$$
\boxed{p(x) = \sum_{i=1}^{K} \pi_i \, \mathcal{N}(x \mid \mu_i, \Sigma_i)}
$$

> **直觉**：数据分布是 $K$ 个高斯分布的加权平均。每个高斯分量对应数据的一种"模式"，$\pi_i$ 是该模式出现的频率。

### 4.2.2 K-means 回顾与局限

K-means 可以视为 GMM 的一个极端退化版本。K-means 的目标是最小化聚类误差：

$$
\min_{\gamma_{ij} \in \{0,1\}, \; c_j} \frac{1}{2N} \sum_{i=1}^{N} \sum_{j=1}^{K} \gamma_{ij} \| x_i - c_j \|_2^2
$$

约束为每个样本只能属于一个类：$\sum_j \gamma_{ij} = 1$，$\gamma_{ij} \in \{0, 1\}$。

K-means 通过交替优化求解：

1. **分配步**：$\gamma_{ij} = 1$ 当 $j = \arg\min_k \|x_i - c_k\|_2^2$，否则 $0$（硬分配）
2. **更新步**：$c_j = \frac{\sum_i \gamma_{ij} x_i}{\sum_i \gamma_{ij}}$（取属于该类的样本均值）

K-means 的局限在于**硬分配（hard assignment）**——每个样本被强制归属于唯一一个类别。但现实中，一个数据点可能同时与多个模式相关（例如：一个人的口音可能介于两种方言之间）。GMM 用**软分配（soft assignment）**解决了这个问题。

### 4.2.3 GMM 的软分配：后验概率

给定数据点 $x_i$，它在各个分量上的归属不再是非此即彼，而是由**后验概率**给出：

$$
\boxed{\gamma_{ij} \equiv p(z_i = j \mid x_i) = \frac{p(z_i = j)\, p(x_i \mid z_i = j)}{p(x_i)} = \frac{\pi_j \, \mathcal{N}(x_i \mid \mu_j, \Sigma_j)}{\sum_{k=1}^{K} \pi_k \, \mathcal{N}(x_i \mid \mu_k, \Sigma_k)}}
$$

> **推导**：第一步是贝叶斯公式 $p(z|x) = p(z)p(x|z)/p(x)$，第二步将分母 $p(x_i)$ 展开为对所有分量的求和 $\sum_k p(z=k)p(x|z=k)$。

**这就是 GMM 的 E 步**：用当前参数 $(\pi, \mu, \Sigma)$ 计算每个数据点属于每个分量的后验概率 $\gamma_{ij}$。

### 4.2.4 GMM 的参数更新：M步

有了软分配 $\gamma_{ij}$ 之后，通过最大化加权对数似然来更新参数。下面给出结论并解释其物理含义。

**混合系数** $\pi_j$ 的更新——分量 $j$ 的"流行度"：

$$
\pi_j = p(z = j) = \int p(z = j \mid x)\, p(x)\, dx \approx \frac{1}{N} \sum_{i=1}^{N} p(z_i = j \mid x_i) = \frac{\sum_i \gamma_{ij}}{N}
$$

> **直觉**：$\pi_j$ 就是所有样本在分量 $j$ 上的平均归属度。如果所有样本在分量 $j$ 上的 $\gamma_{ij}$ 都接近 0，那这个分量就几乎不存在。

**均值** $\mu_j$ 的更新——分量 $j$ 的"中心"：

$$
\mu_j = \frac{\sum_{i=1}^{N} \gamma_{ij}\, x_i}{\sum_{i=1}^{N} \gamma_{ij}}
$$

> **直觉**：这是以 $\gamma_{ij}$ 为权重的加权平均，与 K-means 的更新形式完全一致，只是把 $\{0,1\}$ 的硬分配换成了 $[0,1]$ 的软分配。

**协方差** $\Sigma_j$ 的更新同理，是以 $\gamma_{ij}$ 为权重的加权协方差矩阵。

---

## 4.3 EM 算法：交替优化的通用框架

GMM 的"算后验 → 更新参数"交替模式可以推广到**任意潜变量模型**。这就是期望最大化（Expectation-Maximization, EM）算法。

### 4.3.1 从 GMM 提炼通用模式

回顾 GMM 的做法：

1. 用当前参数计算后验 $p(z \mid x)$（E步）
2. 用后验加权更新参数（M步）

在通用潜变量模型中，我们有参数 $\theta$（在 GMM 中 $\theta = \{\pi_j, \mu_j, \Sigma_j\}_{j=1}^K$），目标是最大化对数似然：

$$
\log p_\theta(x) = \log \int p_\theta(x, z)\, dz = \log \int p_\theta(x \mid z)\, p(z)\, dz
$$

直接优化这个目标很困难，因为对数里面有个积分。EM 的解决策略是：**找一个更容易优化的下界，交替推高这个下界**。

### 4.3.2 Jensen 不等式

> **Jensen 不等式**：对于凸函数 $f$，有 $f(\mathbb{E}[X]) \le \mathbb{E}[f(X)]$。反之，对于凹函数 $f$，有 $f(\mathbb{E}[X]) \ge \mathbb{E}[f(X)]$。

对数函数 $\log(\cdot)$ 是**凹函数**，因此：

$$
\boxed{\log \mathbb{E}[Y] \ge \mathbb{E}[\log Y]}
$$

### 4.3.3 构造 EM 下界

设当前参数为 $\theta^{(t)}$。引入任意一个合法的概率分布 $q(z)$（即 $q(z) \ge 0$ 且 $\int q(z) dz = 1$），对对数似然做如下变形：

$$
\begin{aligned}
\log p_\theta(x) &= \log \int p_\theta(x, z)\, dz \\
&= \log \int q(z) \cdot \frac{p_\theta(x, z)}{q(z)}\, dz \qquad \text{(乘除 } q(z) \text{，恒等变形)} \\
&= \log \mathbb{E}_{z \sim q}\!\left[\frac{p_\theta(x, z)}{q(z)}\right] \qquad \text{(写成期望形式)} \\
&\ge \mathbb{E}_{z \sim q}\!\left[\log \frac{p_\theta(x, z)}{q(z)}\right] \qquad \text{(Jensen 不等式)} \\
&= \int q(z) \log p_\theta(x, z)\, dz - \int q(z) \log q(z)\, dz
\end{aligned}
$$

最后一行记为 $\mathcal{L}(q, \theta)$，它就是对数似然 $\log p_\theta(x)$ 的一个**下界**。

### 4.3.4 EM 算法的两步

**E 步（Expectation Step）**：固定当前参数 $\theta^{(t)}$，选择 $q(z)$ 最大化下界 $\mathcal{L}(q, \theta^{(t)})$。

Jensen 不等式取等号的充要条件是 $\frac{p_\theta(x,z)}{q(z)}$ 为常数（与 $z$ 无关）。即：

$$
q(z) \propto p_{\theta^{(t)}}(x, z) \;\Longrightarrow\; q(z) = \frac{p_{\theta^{(t)}}(x, z)}{\int p_{\theta^{(t)}}(x, z)\, dz} = p_{\theta^{(t)}}(z \mid x)
$$

> **E 步的结论**：最优的 $q(z)$ 就是（当前参数下的）真实后验分布。所以 E 步就是计算后验，这也是"Expectation"这个名字的由来——它是求后验期望的步骤。

**M 步（Maximization Step）**：固定 $q(z) = p_{\theta^{(t)}}(z \mid x)$，最大化 $\mathcal{L}(q, \theta)$ 关于 $\theta$ 的部分：

$$
\theta^{(t+1)} = \arg\max_\theta \int p_{\theta^{(t)}}(z \mid x) \log p_\theta(x, z)\, dz
$$

注意 $\log q(z)$ 这一项不依赖 $\theta$，所以在 M 步中可以丢掉。M 步的核心是最大化 **Q 函数**（期望完全数据对数似然）：

$$
Q(\theta \mid \theta^{(t)}) = \mathbb{E}_{z \sim p_{\theta^{(t)}}(\cdot \mid x)}\!\left[\log p_\theta(x, z)\right]
$$

> **直觉**：M 步相当于在有"软标签"（后验概率）的情况下做最大似然估计。你不需要知道每个样本的确切 $z$，只需要知道 $z$ 的分布，就足以更新参数。

### 4.3.5 为什么 EM 有效

EM 算法的一个重要性质是：**每次迭代后，对数似然单调不减**。证明如下：

$$
\log p_{\theta^{(t+1)}}(x) \ge \mathcal{L}(q^{(t+1)}, \theta^{(t+1)}) \ge \mathcal{L}(q^{(t)}, \theta^{(t)}) = \log p_{\theta^{(t)}}(x)
$$

- 第一个 $\ge$：$\mathcal{L}(q, \theta)$ 始终是对数似然的下界（由 Jensen 不等式保证）
- 第二个 $\ge$：M 步最大化了 $\mathcal{L}$，至少不比之前差
- 最后的 $=$：E 步选择的 $q$ 使下界紧贴对数似然（Jensen 等号成立）

### 4.3.6 EM 的关键局限

E 步要求我们能够计算精确的后验 $p_\theta(z \mid x)$。在 GMM 中这是可行的，因为 $z$ 是离散的，贝叶斯公式直接给出闭式解。但当 $z$ 是**连续高维向量**且 $p_\theta(x \mid z)$ 由神经网络定义时，$p_\theta(z \mid x)$ 同样不可计算。

$$
\text{GMM: } z \in \{1,\dots,K\} \;\longrightarrow\; \text{后验可精确计算} \;\longrightarrow\; \text{EM 可行}
$$
$$
\text{VAE: } z \in \mathbb{R}^d \;\longrightarrow\; \text{后验不可计算} \;\longrightarrow\; \text{EM 失效} \;\longrightarrow\; \text{需要变分推断}
$$

这直接引出了下一节的核心思想：**既然精确后验不可求，那就用一个可学习的分布去逼近它。**

---

## 4.4 证据下界（ELBO）—— 变分推断的核心

### 4.4.1 从 EM 到变分推断

EM 算法的阿喀琉斯之踵是：**它需要精确后验**。当 $p_\theta(z \mid x) = \frac{p(z)p_\theta(x \mid z)}{p_\theta(x)}$ 中的分母 $p_\theta(x) = \int p(z)p_\theta(x \mid z)dz$ 不可计算时，后验就无法获取。

**变分推断（Variational Inference）** 的核心思想是退而求其次：不再奢求精确后验，而是引入一个**可处理的分布族** $\mathcal{Q}$，在其中找一个最接近真实后验的分布。这个近似分布记为 $q_\phi(z \mid x)$，称为**变分后验**，参数 $\phi$ 是可学习的。（在 VAE 中，$\phi$ 就是编码器神经网络的权重。）

"变分"（variational）一词来自变分法——我们在一个函数族 $\mathcal{Q}$ 中寻找最优函数 $q^*$，而非仅仅优化参数。

### 4.4.2 ELBO 完整推导

下面逐步推导 ELBO。

> **约定**：以下推导中，$q(z)$ 是 $q_\phi(z \mid x)$ 的简写，$p(x,z)$ 是 $p_\theta(x,z) = p(z)p_\theta(x \mid z)$ 的简写。我们暂时省略 $\theta$ 和 $\phi$ 下标以保持简洁。

---

**第 1 步**：写出对数似然，展开为联合分布的积分。

$$
\log p(x) = \log \int p(x, z)\, dz
\tag{1}
$$

这里 $p(x,z) = p(z)p(x \mid z)$，把潜变量 $z$ 边缘化（marginalize out）得到 $p(x)$。

---

**第 2 步**：引入变分分布 $q(z)$，分子分母同乘 $q(z)$。

$$
\log p(x) = \log \int q(z) \cdot \frac{p(x, z)}{q(z)}\, dz
\tag{2}
$$

$q(z)$ 的唯一要求是：当 $p(x,z) > 0$ 时 $q(z) > 0$（即 $q$ 的支撑集包含 $p$ 的支撑集）。

---

**第 3 步**：将积分写成期望形式。

$$
\log p(x) = \log \mathbb{E}_{z \sim q}\!\left[\frac{p(x, z)}{q(z)}\right]
\tag{3}
$$

这样写是为了更方便地应用 Jensen 不等式。

---

**第 4 步**：应用 Jensen 不等式，将对数"塞进"期望内部。

$$
\log \mathbb{E}_{z \sim q}\!\left[\frac{p(x, z)}{q(z)}\right] \ge \mathbb{E}_{z \sim q}\!\left[\log \frac{p(x, z)}{q(z)}\right]
\tag{4}
$$

等号成立的条件是 $\frac{p(x,z)}{q(z)}$ 对 $z$ 为常数（即 $q(z) \propto p(x,z)$，也就是 $q(z) = p(z \mid x)$）。

---

**第 5 步**：将联合分布拆开 $p(x,z) = p(z)p(x \mid z)$。

$$
\begin{aligned}
\mathbb{E}_{z \sim q}\!\left[\log \frac{p(x, z)}{q(z)}\right]
&= \mathbb{E}_{z \sim q}\!\left[\log \frac{p(z)p(x \mid z)}{q(z)}\right] \\
&= \mathbb{E}_{z \sim q}\!\left[\log p(x \mid z)\right] + \mathbb{E}_{z \sim q}\!\left[\log \frac{p(z)}{q(z)}\right]
\end{aligned}
\tag{5}
$$

---

**第 6 步**：识别第二项为负 KL 散度。

$$
\mathbb{E}_{z \sim q}\!\left[\log \frac{p(z)}{q(z)}\right] = -\mathbb{E}_{z \sim q}\!\left[\log \frac{q(z)}{p(z)}\right] = -D_{\text{KL}}(q(z) \,\|\, p(z))
$$

> **KL 散度回顾**：$D_{\text{KL}}(q \| p) = \int q(z) \log \frac{q(z)}{p(z)} dz$。它度量了用 $p$ 近似 $q$ 时的"信息损失"，总是非负，为零当且仅当 $q = p$ 几乎处处成立。

---

**最终形式**：

$$
\boxed{\log p(x) \ge \underbrace{\mathbb{E}_{z \sim q_\phi(\cdot \mid x)}\!\left[\log p_\theta(x \mid z)\right]}_{\text{重构项（Reconstruction）}} \;-\; \underbrace{D_{\text{KL}}\big(q_\phi(z \mid x) \,\big\|\, p(z)\big)}_{\text{KL 正则项（Regularization）}} \equiv \text{ELBO}}
$$

这个下界称为 **证据下界（Evidence Lower Bound, ELBO）**——"证据"是 $p(x)$ 的别称，"下界"是因为它小于等于对数证据。

### 4.4.3 ELBO 两项的直觉

**重构项** $\mathbb{E}_{q(z|x)}[\log p(x \mid z)]$：
- 衡量"给定编码器输出的 $z$，解码器能否重建出原始 $x$"
- 等价于问：从 $x$ 编码到 $z$，再从 $z$ 解码回去，得到的 $x'$ 和原来的 $x$ 有多像？
- **最大化这一项** → 编解码过程尽可能无损

**KL 正则项** $D_{\text{KL}}(q(z|x) \| p(z))$：
- 衡量编码器输出的 $z$ 分布离先验 $p(z)$（通常为标准正态）有多远
- **最小化这一项**（等价于最大化 $-D_{\text{KL}}$）→ 迫使潜变量空间"规整"，靠近简单先验，便于后续采样生成
- 这一项的存在是 VAE 区别于普通自编码器的关键——没有它，$q(z|x)$ 会塌缩为点质量（每个 $x$ 对应一个确定的 $z$），潜变量空间将支离破碎、无法采样

### 4.4.4 对数似然与 ELBO 的差距

一个关键问题是：优化 ELBO 到底离优化真正的对数似然有多远？答案是——差距恰好是 $q(z|x)$ 与真实后验 $p(z|x)$ 的 KL 散度：

$$
\begin{aligned}
\log p(x) - \text{ELBO}
&= \log p(x) - \mathbb{E}_q[\log p(x \mid z)] + D_{\text{KL}}(q(z|x) \| p(z)) \quad (\text{展开 ELBO}) \\
&= \mathbb{E}_q[\log p(x)] - \mathbb{E}_q[\log p(x \mid z)] + D_{\text{KL}}(q(z|x) \| p(z)) \quad (\log p(x) \text{ 与 } z \text{ 无关}) \\
&= \mathbb{E}_q\!\left[\log \frac{p(x)}{p(x \mid z)}\right] + D_{\text{KL}}(q(z|x) \| p(z)) \\
&= \mathbb{E}_q\!\left[\log \frac{p(z)}{p(z \mid x)}\right] + D_{\text{KL}}(q(z|x) \| p(z)) \quad \left(\text{贝叶斯: } \frac{p(x)}{p(x \mid z)} = \frac{p(z)}{p(z \mid x)}\right) \\
&= \mathbb{E}_q[\log p(z)] - \mathbb{E}_q[\log p(z \mid x)] + \mathbb{E}_q[\log q(z|x)] - \mathbb{E}_q[\log p(z)] \quad (\text{展开 KL}) \\
&= \mathbb{E}_q\!\left[\log \frac{q(z|x)}{p(z \mid x)}\right] \\
&= D_{\text{KL}}\big(q(z|x) \,\big\|\, p(z \mid x)\big)
\end{aligned}
$$

最终得到简洁而重要的结论：

$$
\boxed{\log p(x) - \text{ELBO} = D_{\text{KL}}\big(q_\phi(z \mid x) \,\big\|\, p_\theta(z \mid x)\big) \ge 0}
$$

> **核心洞察**：ELBO 越接近 $\log p(x)$，意味着 $q_\phi(z|x)$ 越接近真实后验 $p_\theta(z|x)$。**最大化 ELBO 同时做了两件事：提高数据的似然，并让变分后验逼近真实后验。** 当 $q_\phi(z|x) = p_\theta(z|x)$ 时，两者相等，ELBO 就等于对数似然。

---

## 4.5 从重要性采样理解 ELBO

另一种理解 ELBO 的视角来自 **Monte Carlo 积分**。这可以帮助我们理解为什么需要引入 $q(z)$，以及什么是一个"好"的 $q(z)$。

### 4.5.1 直接 Monte Carlo 的问题

$p(x) = \int p(x \mid z)p(z)dz$ 可以通过从 $p(z)$ 采样来估计：

$$
p(x) \approx \frac{1}{S} \sum_{s=1}^{S} p(x \mid z_s), \quad z_s \sim p(z)
$$

问题在于：对于大多数 $z \sim p(z)$，$p(x \mid z)$ 几乎为零——随机采样的 $z$ 极大概率与给定的 $x$ 毫无关系。这意味着绝大部分样本对估计的贡献为零，而极少数有效样本导致估计**方差极大**。这个现象在 $z$ 维度较高时尤为严重。

### 4.5.2 重要性采样的解决思路

**重要性采样（Importance Sampling）** 换一个角度：与其从 $p(z)$ 盲目采样，不如从一个"知道 $x$ 长什么样"的分布 $q(z)$ 采样，然后用权重修正偏差：

$$
p(x) = \int p(x \mid z)p(z)dz = \int q(z) \cdot \frac{p(x \mid z)p(z)}{q(z)}dz = \mathbb{E}_{z \sim q}\!\left[\frac{p(x \mid z)p(z)}{q(z)}\right]
$$

估计量为 $\frac{1}{S}\sum_s \frac{p(x \mid z_s)p(z_s)}{q(z_s)}$，其中 $z_s \sim q(z)$。

### 4.5.3 最优重要性分布

什么样的 $q(z)$ 是最好的？答案是**使估计量方差为零的分布**，即对任意 $z$ 有 $\frac{p(x \mid z)p(z)}{q(z)} = \text{常数}$。由贝叶斯公式 $p(x) = \frac{p(x \mid z)p(z)}{p(z \mid x)}$ 可知：

$$
\boxed{q^*(z) = p(z \mid x)}
$$

当 $q(z) = p(z \mid x)$ 时，权重 $\frac{p(x \mid z)p(z)}{q(z)} = \frac{p(x \mid z)p(z)}{p(z \mid x)} = p(x)$ 恒为常数——**仅需一个样本即可获得 $p(x)$ 的精确无偏估计**。

这也解释了为什么变分推断中，$q(z|x)$ 的目标是逼真 $p(z|x)$：$q$ 越接近真实后验，重要性采样的方差越小，ELBO 越紧贴对数似然。同时当 $q(z) = p(z|x)$ 时：

$$
\log \mathbb{E}_q\!\left[\frac{p(x,z)}{q(z)}\right] = \mathbb{E}_q\!\left[\log\frac{p(x,z)}{q(z)}\right] = \log p(x)
$$

Jensen 不等式取等号——ELBO 与对数似然完全重合。

---

## 4.6 变分自编码器 —— 用神经网络实现

前几节建立了变分推断的数学框架，但还有一个关键问题未解决：$q_\phi(z \mid x)$ 应当取什么形式？VAE 的答案是：**用神经网络来参数化编码器和解码器**。

### 4.6.1 参数化设定

VAE 由两个神经网络组成，配对成一个"编码—解码"结构。以下将变分参数 $\phi$（编码器权重）和生成参数 $\theta$（解码器权重）显式标出。

**编码器** $q_\phi(z \mid x)$：输入数据 $x$，输出潜变量 $z$ 的分布参数。通常假设 $q_\phi(z \mid x)$ 为对角高斯分布：

$$
q_\phi(z \mid x) = \mathcal{N}\big(z \;\big|\; \mu_\phi(x),\; \operatorname{diag}(\sigma_\phi^2(x))\big)
$$

其中 $\mu_\phi(x)$ 和 $\sigma_\phi^2(x)$（或 $\log\sigma_\phi^2(x)$，出于数值稳定性）由同一个神经网络输出。**对角协方差假设意味着各潜变量维度之间条件独立**——这是一个简化假设，但实践证明效果不错。

**解码器** $p_\theta(x \mid z)$：输入潜变量 $z$，输出数据 $x$ 的分布参数。通常假设：

$$
p_\theta(x \mid z) = \mathcal{N}\big(x \;\big|\; f_\theta(z),\; \beta I\big)
$$

其中 $f_\theta(z)$ 是解码器神经网络的输出（$x$ 的重构），$\beta$ 是固定的噪声方差（可视为超参数或可学习参数）。$\beta I$ 的假设意味着重构误差在各维度独立同分布。

**先验** $p(z)$：取最简单的形式：

$$
p(z) = \mathcal{N}(z \mid 0, I)
$$

即各维度独立标准正态。这个选择有两个好处：(1) KL 散度有闭式解；(2) 采样生成时只需从 $\mathcal{N}(0,I)$ 采样即可。

### 4.6.2 ELBO 的具体形式

将上述高斯假设代入 ELBO，得到可在代码中直接实现的目标函数。

#### 重构项的化简

$$
\begin{aligned}
\mathbb{E}_{z \sim q_\phi(z \mid x)}\!\left[\log p_\theta(x \mid z)\right]
&= \mathbb{E}_{z \sim q_\phi(z \mid x)}\!\left[\log \mathcal{N}(x \mid f_\theta(z), \beta I)\right] \\
&= \mathbb{E}_{z \sim q_\phi(z \mid x)}\!\left[-\frac{D}{2}\log(2\pi\beta) - \frac{1}{2\beta}\|x - f_\theta(z)\|_2^2\right] \\
&= \text{常数} - \frac{1}{2\beta}\,\mathbb{E}_{z \sim q_\phi(z \mid x)}\!\left[\|x - f_\theta(z)\|_2^2\right]
\end{aligned}
$$

> **推导细节**：多元高斯 $\mathcal{N}(y \mid \mu, \Sigma)$ 的对数密度为 $-\frac{D}{2}\log(2\pi) - \frac{1}{2}\log|\Sigma| - \frac{1}{2}(y-\mu)^\top\Sigma^{-1}(y-\mu)$。代入 $\mu = f_\theta(z)$，$\Sigma = \beta I$，得到 $-\frac{D}{2}\log(2\pi\beta) - \frac{1}{2\beta}\|y-\mu\|_2^2$。

因此，**最大化重构项等价于最小化重构误差的均方期望**（忽略常数和 $\beta$ 因子）。

#### KL 项的化简

需要计算 $D_{\text{KL}}\big(\mathcal{N}(\mu_\phi, \sigma_\phi^2 I) \,\|\, \mathcal{N}(0, I)\big)$。我们从 KL 散度的定义出发，做系统推导。

**第一步：通用高斯 KL 公式的推导。**

设 $q = \mathcal{N}(\mu_1, \Sigma_1)$，$p = \mathcal{N}(\mu_2, \Sigma_2)$，均为一维。由 KL 定义：

$$
\begin{aligned}
D_{\text{KL}}(q \| p) &= \mathbb{E}_{x \sim q}\!\left[\log \frac{q(x)}{p(x)}\right] \\
&= \mathbb{E}_{x \sim q}\!\left[\log q(x) - \log p(x)\right]
\end{aligned}
$$

一维高斯密度函数 $\mathcal{N}(x \mid \mu, \sigma^2) = \frac{1}{\sqrt{2\pi\sigma^2}}\exp\!\big(-\frac{(x-\mu)^2}{2\sigma^2}\big)$，取对数：

$$
\log \mathcal{N}(x \mid \mu, \sigma^2) = -\frac{1}{2}\log(2\pi) - \log\sigma - \frac{(x-\mu)^2}{2\sigma^2}
$$

于是：

$$
\begin{aligned}
\log \frac{q(x)}{p(x)} &= \left[-\log\sigma_1 - \frac{(x-\mu_1)^2}{2\sigma_1^2}\right] - \left[-\log\sigma_2 - \frac{(x-\mu_2)^2}{2\sigma_2^2}\right] \\
&= \log\frac{\sigma_2}{\sigma_1} + \frac{1}{2}\!\left[\frac{(x-\mu_2)^2}{\sigma_2^2} - \frac{(x-\mu_1)^2}{\sigma_1^2}\right]
\end{aligned}
$$

在 $q = \mathcal{N}(\mu_1, \sigma_1^2)$ 下求期望。利用 $\mathbb{E}_q[(x-\mu_1)^2] = \sigma_1^2$（方差的定义），以及：

$$
\mathbb{E}_q[(x-\mu_2)^2] = \mathbb{E}_q[(x-\mu_1 + \mu_1 - \mu_2)^2] = \sigma_1^2 + (\mu_1 - \mu_2)^2 + 2(\mu_1-\mu_2)\underbrace{\mathbb{E}_q[x-\mu_1]}_{=0} = \sigma_1^2 + (\mu_1 - \mu_2)^2
$$

代入：

$$
\begin{aligned}
D_{\text{KL}}(q \| p) &= \log\frac{\sigma_2}{\sigma_1} + \frac{1}{2}\!\left[\frac{\sigma_1^2 + (\mu_1 - \mu_2)^2}{\sigma_2^2} - 1\right] \\
&= \boxed{\log\frac{\sigma_2}{\sigma_1} + \frac{\sigma_1^2 + (\mu_1 - \mu_2)^2}{2\sigma_2^2} - \frac{1}{2}}
\end{aligned}
$$

> **检查**：若 $\mu_1 = \mu_2$，$\sigma_1 = \sigma_2$，KL 散度为 $\log 1 + \frac{\sigma^2 + 0}{2\sigma^2} - \frac{1}{2} = 0 + \frac{1}{2} - \frac{1}{2} = 0$，符合预期。

**第二步：代入 VAE 先验 $\mu_2 = 0, \sigma_2 = 1$。**

$$
\begin{aligned}
D_{\text{KL}}\big(\mathcal{N}(\mu, \sigma^2) \,\|\, \mathcal{N}(0, 1)\big)
&= \log\frac{1}{\sigma} + \frac{\sigma^2 + \mu^2}{2} - \frac{1}{2} \\
&= -\log\sigma + \frac{\sigma^2 + \mu^2}{2} - \frac{1}{2} \\
&= \frac{1}{2}\big(\mu^2 + \sigma^2 - 2\log\sigma - 1\big) \\
&= \frac{1}{2}\big(\mu^2 + \sigma^2 - \log\sigma^2 - 1\big)
\end{aligned}
$$

**第三步：推广到多维对角情况。** 当 $q = \mathcal{N}(\mu, \operatorname{diag}(\sigma_1^2, \dots, \sigma_d^2))$，$p = \mathcal{N}(0, I_d)$ 时，由于各维独立，KL 散度可逐维相加：

$$
\boxed{D_{\text{KL}}\big(q_\phi(z \mid x) \,\big\|\, p(z)\big) = \frac{1}{2}\sum_{j=1}^{d}\Big(\mu_j^2 + \sigma_j^2 - \log\sigma_j^2 - 1\Big)}
$$

其中 $d$ 是潜变量维度，$\mu_j = [\mu_\phi(x)]_j$，$\sigma_j^2 = [\sigma_\phi^2(x)]_j$。

> **直觉解读**：这个 KL 项的每一项由三部分组成——$\mu_j^2$ 惩罚均值偏离零，$\sigma_j^2$ 惩罚方差过大，$-\log\sigma_j^2$ 惩罚方差过小（防止退化为点质量）。当 $\mu_j = 0, \sigma_j = 1$ 时该项取最小值 $0$。

### 4.6.3 VAE 的最终损失函数

综合重构项和 KL 项，**最大化 ELBO 等价于最小化以下损失**：

$$
\boxed{\mathcal{L}_{\text{VAE}}(x; \phi, \theta) = \frac{1}{2\beta}\,\mathbb{E}_{z \sim q_\phi(z \mid x)}\!\left[\|x - f_\theta(z)\|_2^2\right] + \frac{1}{2}\sum_{j=1}^{d}\Big(\mu_{\phi,j}^2(x) + \sigma_{\phi,j}^2(x) - \log\sigma_{\phi,j}^2(x) - 1\Big)}
$$

两项之间存在一个基本张力：
- **重构项**驱使 $q_\phi(z|x)$ 趋向点质量（令 $\sigma \to 0$），此时 $z$ 完全确定，解码器可以最精确地重构 $x$
- **KL 项**阻止 $\sigma \to 0$（因为 $-\log\sigma^2 \to +\infty$）和 $\mu$ 偏离 $0$ 太远，迫使潜变量空间保持平滑和规整

这个张力是 VAE 设计的精髓——它迫使模型在"精确重构"和"规整的潜变量空间"之间找到最优平衡。$\beta$ 超参数控制这个平衡：$\beta$ 越大，KL 项相对越弱，模型更偏向精确重构；$\beta$ 越小，KL 项相对越强，模型更偏向规整的潜变量空间（这引出了后来 $\beta$-VAE 的研究）。

---

## 4.7 重参数化技巧 —— 让随机性可导

### 4.7.1 问题：梯度遇到了随机节点

ELBO 包含期望 $\mathbb{E}_{z \sim q_\phi(z \mid x)}[\cdot]$。要优化 $\phi$，需要计算这个期望关于 $\phi$ 的梯度。直接的做法是 Monte Carlo 估计：

$$
\nabla_\phi \mathbb{E}_{z \sim q_\phi(z \mid x)}[h(z)] \approx \frac{1}{S}\sum_{s=1}^{S} \nabla_\phi\, h(z_s), \quad z_s \sim q_\phi(z \mid x)
$$

但这里有一个致命问题：**采样操作 $z \sim q_\phi(z \mid x)$ 本身依赖 $\phi$，而随机采样是不可微的**——你不能对"从分布中抽取一个随机数"这个操作求梯度。

### 4.7.2 解决：把随机性移到外部

**重参数化技巧（Reparameterization Trick）** 的关键洞察是：一个高斯随机变量可以写成确定性变换加外部噪声的形式。对于 $z \sim \mathcal{N}(\mu, \sigma^2)$：

$$
\boxed{z = \mu + \sigma \odot \varepsilon, \quad \varepsilon \sim \mathcal{N}(0, I)}
$$

其中 $\odot$ 表示逐元素乘法。现在：
- $\mu = \mu_\phi(x)$ 和 $\sigma = \sigma_\phi(x)$ 是 $\phi$ 的确定性函数——**可微**
- $\varepsilon$ 来自固定的标准正态分布——**与 $\phi$ 无关**
- $z$ 是 $\mu$、$\sigma$ 和 $\varepsilon$ 的确定性函数

$$
\boxed{\nabla_\phi \mathbb{E}_{z \sim q_\phi}[\cdot] = \mathbb{E}_{\varepsilon \sim \mathcal{N}(0,I)}\!\big[\nabla_\phi\,(\text{关于 } z = \mu_\phi + \sigma_\phi \odot \varepsilon \text{ 的表达式})\big]}
$$

梯度现在可以顺利地从 $h(z)$ 经 $z$ 流向 $\mu_\phi$ 和 $\sigma_\phi$，再流回编码器参数 $\phi$。$\varepsilon$ 节点不需要梯度。

> **类比**：这就像把随机骰子从"模型内部"移到了"外部输入"——模型本身变成一个确定性函数，随机性来自不参与优化的噪声输入。于是整个计算图变得完全可微。

### 4.7.3 VAE 的前向和反向传播

以单样本 Monte Carlo 估计为例（实践中通常用 $S=1$，因为随机梯度下降本身就带有噪声）：

**前向传播**：
1. 编码器：$x \to (\mu_\phi(x), \log\sigma_\phi^2(x))$
2. 采样噪声：$\varepsilon \sim \mathcal{N}(0, I)$（与模型无关）
3. 重参数化：$z = \mu_\phi(x) + \sigma_\phi(x) \odot \varepsilon$
4. 解码器：$\hat{x} = f_\theta(z)$
5. 计算损失：$\mathcal{L} = \frac{1}{2\beta}\|x - \hat{x}\|^2 + \frac{1}{2}\sum(\mu^2 + \sigma^2 - \log\sigma^2 - 1)$

**反向传播**：梯度从 $\mathcal{L}$ 经 $f_\theta$、$z$、$\mu_\phi$、$\sigma_\phi$ 一路流回编码器（$\varepsilon$ 节点无梯度），同时经 $f_\theta$ 流回解码器参数 $\theta$。

---

## 4.8 训练与生成

### 4.8.1 训练流程

VAE 的训练就是一个标准的神经网络优化循环——最大化 ELBO（等价于最小化负 ELBO）：

1. 从训练集取一个 mini-batch $\{x_1, \dots, x_B\}$
2. 编码：对每个 $x_i$，编码器输出 $\mu_\phi(x_i)$ 和 $\log\sigma_\phi^2(x_i)$
3. 采样 + 重参数化：$z_i = \mu_\phi(x_i) + \sigma_\phi(x_i) \odot \varepsilon_i$，$\varepsilon_i \sim \mathcal{N}(0, I)$
4. 解码：对每个 $z_i$，解码器输出 $f_\theta(z_i)$
5. 计算损失 $\mathcal{L}_{\text{VAE}}$，反向传播，更新 $\phi$ 和 $\theta$

### 4.8.2 生成新样本

训练完成后，解码器 $f_\theta$ 就是一个"从潜变量到数据"的映射。生成新样本非常简单：

$$
z \sim \mathcal{N}(0, I) \;\longrightarrow\; \hat{x} = f_\theta(z)
$$

不再需要编码器——编码器只是训练的"脚手架"，帮助学习到一个规整的潜变量空间。一旦潜变量空间训练好了，采样生成就只需从标准正态中随机抽取 $z$ 再通过解码器。

### 4.8.3 潜变量空间的插值

规整的潜变量空间的另一个妙处是**语义插值**：在两个数据点 $x_A$ 和 $x_B$ 的潜变量编码 $z_A$ 和 $z_B$ 之间做线性插值 $z_\alpha = (1-\alpha)z_A + \alpha z_B$，解码得到的 $\hat{x}_\alpha = f_\theta(z_\alpha)$ 通常会平滑地在两个样本之间过渡。这是因为 KL 正则项迫使潜变量空间连续且光滑——相似的 $z$ 对应相似的 $x$。

---

## 4.9 扩展：超越基础 VAE

基础 VAE 存在一些已知局限（模糊样本、后验崩塌等），后续研究从以下维度进行了改进。这里做简要概述，详细分析见对应论文阅读笔记。

### 4.9.1 更灵活的先验和编码器

基础 VAE 的先验 $p(z) = \mathcal{N}(0, I)$ 非常朴素，编码器也仅用对角高斯。改进方向包括：

- **归一化流增强先验**：在 $p(z)$ 上叠加归一化流（第3章），使先验本身也可以学习复杂分布
- **更丰富的后验族**：使用 Inverse Autoregressive Flow (IAF) 等技术使 $q_\phi(z|x)$ 不再限于对角高斯

### 4.9.2 分层潜变量结构

将单层潜变量 $z$ 扩展为多层 $(z_1, z_2, \dots, z_L)$，让不同层捕获不同粒度的特征（如顶层捕获全局结构，底层捕获纹理细节）。

- **PixelVAE**：分层分解，先验用 Markov 假设 $p(z_1,\dots,z_L) = p(z_L)\prod_{i=1}^{L-1}p(z_i \mid z_{i+1})$，编码器用条件独立假设简化 KL 项
- **NVAE（Nouveau VAE）**：使用精确逐层条件分解 $q(z) = \prod_l q(z_l \mid z_{<l})$，结合双向编码器和残差生成模型，大幅提升了生成质量


### 4.9.3 VQ-VAE：离散潜变量

**VQ-VAE（Vector Quantized VAE）** 将连续高斯潜变量替换为**离散码本（codebook）**。编码器输出被量化为码本中最近的向量：

$$
k = \arg\min_j \|z_e(x) - e_j\|_2
$$

其中 $\{e_1, \dots, e_K\}$ 是可学习的码本向量。由于量化操作也不可微，VQ-VAE 使用**直通估计器（straight-through estimator）**——反向传播时将量化层的梯度原样复制过去。

损失函数包含三项：
1. **重构损失**：$\|x - \text{decoder}(e_k)\|_2^2$
2. **码本损失**：$\|\text{sg}[z_e(x)] - e_k\|_2^2$，推动码本向量靠近编码器输出（sg = stop gradient）
3. **承诺损失**：$\|z_e(x) - \text{sg}[e_k]\|_2^2$，推动编码器输出靠近码本向量

码本通常使用**指数移动平均（EMA）**更新，类似于 K-means 的在线版本。VQ-VAE 避免了标准 VAE 的"后验崩塌"问题，生成的样本通常更清晰。


### 4.9.4 VQ-VAE-2：多尺度分层离散潜变量

VQ-VAE-2 将 VQ-VAE 扩展到多尺度分层结构：顶层编码捕获全局信息（如物体形状），底层编码补充细节（如纹理）。训练分两阶段：先训练 VQ-VAE 编码器-解码器，再训练 PixelCNN 作为分层潜变量的先验分布。采样时自顶向下逐层生成。


---

## 4.10 总结

### 核心公式

$$
\boxed{\max_{\phi,\theta}\; \text{ELBO} = \mathbb{E}_{z \sim q_\phi(z \mid x)}\!\left[\log p_\theta(x \mid z)\right] - D_{\text{KL}}\big(q_\phi(z \mid x) \,\|\, p(z)\big)}
$$

### 符号速查表

| 符号 | 含义 | 在 VAE 中的具体形式 |
|------|------|---------------------|
| $p(z)$ | 潜变量先验 | $\mathcal{N}(0, I)$ |
| $p_\theta(x \mid z)$ | 解码器 / 似然 | $\mathcal{N}(f_\theta(z), \beta I)$ |
| $q_\phi(z \mid x)$ | 编码器 / 变分后验 | $\mathcal{N}(\mu_\phi(x), \operatorname{diag}(\sigma_\phi^2(x)))$ |
| $\phi$ | 编码器参数 | 神经网络的权重和偏置 |
| $\theta$ | 解码器参数 | 神经网络的权重和偏置 |
| ELBO | 证据下界 | $\mathbb{E}_q[\log p_\theta(x \mid z)] - D_{\text{KL}}(q_\phi \| p)$ |
| $\log p(x)$ | 对数证据 / 对数似然 | $\text{ELBO} + D_{\text{KL}}(q_\phi(z \mid x) \| p_\theta(z \mid x))$ |

### 关键等式

- **对数似然分解**：$\log p(x) = \text{ELBO} + D_{\text{KL}}(q_\phi(z \mid x) \| p_\theta(z \mid x))$
- **ELBO 两项**：重构项（数据保真） $+$ KL 正则项（潜空间规整）
- **最优 $q$**：$q_\phi(z \mid x) = p_\theta(z \mid x)$ 时 ELBO 等于对数似然
- **重参数化**：$z = \mu + \sigma \odot \varepsilon,\; \varepsilon \sim \mathcal{N}(0, I)$，使随机计算图可微

### VAE 设计的两个维度

1. **编码器设计**：如何更好地近似真实后验？→ 分层结构、离散潜变量（VQ-VAE）、更灵活的后验族
2. **先验设计**：如何让 $p(z)$ 更有表达力？→ 自回归先验（PixelCNN）、归一化流增强先验、精确分层分解（NVAE）

这两个维度的任何改进，都必须在"表达能力"和"计算可处理性"之间取得平衡——这始终是变分推断的核心张力。

---

## 导航栏

**生成模型 系列文章**

- [第一章：生成模型概述](/posts/ai/generative-model/overview/)
- [第二章：自回归模型](/posts/ai/generative-model/autoregressive-models/)
- [第三章：归一化流](/posts/ai/generative-model/normalizing-flows/)
- [第四章：变分自编码器](/posts/ai/generative-model/variational-autoencoder/)
- [第五章：扩散模型](/posts/ai/generative-model/diffusion-models/)
- [第六章：生成对抗网络](/posts/ai/generative-model/generative-adversarial-networks/)
