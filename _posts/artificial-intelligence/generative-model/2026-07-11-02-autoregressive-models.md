---
note: true
layout: post
title: "第二章：自回归模型"
permalink: /posts/ai/generative-model/autoregressive-models/
categories: generative-model
tags: [generative-model, autoregressive-models, transformer, teacher-forcing, kv-cache, sampling-strategies, var]
use_math: true
---

本章系统介绍自回归模型——将高维数据的联合分布分解为条件分布乘积的方法。涵盖从基本自回归建模、教师强制（Teacher Forcing）训练策略、Transformer 架构中因果自注意力与 KV Cache 等推理优化技术，到现代大语言模型的后训练范式（SFT、零样本/少样本学习、思维链提示）和采样策略。最后延伸到图像领域的 PixelRNN 和视觉自回归建模（VAR），展示自回归范式从语言到视觉的泛化能力。

# 第2章 自回归模型

## 2.1 自回归建模

### 2.1.1 基本思想

在生成任务中，数据通常具有高维结构化特征。自回归模型将高维数据的联合分布分解为一系列条件分布的乘积。

对于数据 $\boldsymbol{x} \in \mathbb{R}^{N}$，自回归模型将 $p_{model}(\boldsymbol{x})$ 建模为：

$$
p_{model}(\boldsymbol{x}) = \prod_{i=1}^{N} p_{model}(x_i | x_1, \dots, x_{i-1})
$$

自回归（Autoregression）是通过条件分布的乘积来建模联合分布的方法。这一分解形式**始终有效，不做任何妥协或近似**。

### 2.1.2 归纳偏置

一般而言，不同的 $i$ 对应不同的分布 $p(x_i \mid x_1, \dots, x_{i-1})$。但使用共享架构和权重来统一建模这些条件分布，有助于减少模型大小并提升泛化能力：

$$
p_{\theta}(x_i \mid x_1, \dots, x_{i-1})
$$

在自回归语言模型中，$p_{\theta}(x_i \mid x_1, \dots, x_{i-1})$ 是离散的——网络以分类方式预测词汇表中每个词作为下一个词出现的概率。

## 2.2 自回归推理

自回归（Auto）意味着使用模型自己的输出作为下一步预测的输入；回归（Regression）指估计变量之间的关系：

$$
p_{\theta}(\boldsymbol{x}) = \prod_{i=1}^{N} p_{\theta}(x_i | x_1, \dots, x_{i-1})
$$

推理过程中：
- 第一步：建模 $p(x_2 \mid x_1)$，1 个输入，1 个输出
- 第二步：建模 $p(x_3 \mid x_{1,2})$，2 个输入，1 个输出（输入来自之前步骤的输出）
- 第 $i$ 步的输入为之前所有步骤的输出

## 2.3 教师强制（Teacher Forcing）

### 2.3.1 动机

在训练阶段，以自回归方式执行前向传播是不切实际的——计算 $x_6$ 的梯度需要经过所有之前的输出、采样和网络，导致训练极为低效。

### 2.3.2 方法

教师强制在训练时始终喂入正确的 $x_{t-1}$，而非模型自身的预测。

**优点：**

- 允许所有时间步的并行计算
- 避免训练过程中的误差累积
- 高效计算梯度

**缺点：**

- 训练与测试之间存在不匹配（train-test mismatch）：训练时使用真实数据，推理时使用自身预测

## 2.4 架构对比

自回归模型可以使用不同的神经网络架构：

| 架构 | 特点 |
|------|------|
| **RNN** | 顺序处理，不可并行化 |
| **CNN** | 可并行化，但上下文窗口受限 |
| **Attention（Transformer）** | 可并行化，支持长上下文建模 |

Transformer 凭借其并行化能力和长上下文建模能力，成为现代自回归模型的主流架构。GPT 系列模型均基于 Transformer 解码器架构。

## 2.5 因果自注意力与推理优化

### 2.5.1 因果自注意力（Causal Self-Attention）

因果自注意力的核心规则是：每个 token 只能关注自身及之前的 token，不能关注任何未来的 token。通过一个下三角注意力掩码实现，确保自回归性质。

### 2.5.2 KV 缓存（KV Cache）

在自回归推理过程中，每次仅需计算新 token 的表示，而其他 token 的表示保持不变。KV cache 通过缓存之前步骤的 Key 和 Value 来避免重复计算。KV cache 的大小约为：

$$
2 \times \text{head dim} \times \text{n heads} \times \text{n layers} \times \text{seq length} \times \text{batch size}
$$

### 2.5.3 分组查询注意力（Grouped-Query Attention, GQA）

在标准多头注意力中，每个注意力头都有独立的 Query、Key 和 Value。GQA 对 Query 保持原有的注意力头数量，而 Key 和 Value 在多个 Query 头之间共享，在保持模型质量的同时显著减小 KV cache。

### 2.5.4 滑动窗口注意力（Sliding Window Attention, SWA）

SWA 将每个 token 的注意力范围限制在前 $w$ 个 token 内，使 KV cache 保持固定大小，从而支持更大的上下文窗口。

### 2.5.5 注意力掩码模式与架构类型

常见的注意力掩码模式：

- **因果掩码（Causal）**：每个 token 只能看到自身及之前的 token，用于解码器
- **带前缀的因果掩码（Causal with prefix）**：前缀部分双向可见，后续部分使用因果掩码
- **双向/全可见注意力（Bidirectional）**：所有 token 之间互相可见，用于编码器

对应的模型架构：

- **仅编码器模型（Encoder-only）**：使用双向自注意力，每次计算考虑整个序列
- **仅解码器模型（Decoder-only）**：使用因果自注意力，每个 token 仅考虑之前的 token

## 2.6 预训练架构变体

### 2.6.1 BERT：仅编码器模型

BERT 使用掩码语言模型（MLM）进行预训练：随机 mask 15% 的 token，让模型根据双向上下文预测被 mask 的 token。BERT 在理解任务上表现优异，但不适合生成任务。


### 2.6.2 编码器-解码器模型

编码器-解码器架构通过交叉注意力（Cross Attention）将编码器输出注入解码器，适用于序列到序列（seq-to-seq）任务。擅长条件生成，但在自由形式生成方面效率较低。


### 2.6.3 T5：文本到文本框架

T5（Text-to-Text Transfer Transformer）将所有 NLP 任务统一为文本到文本格式，使用相同的模型、目标、训练过程和解码过程处理翻译、问答、分类等各类任务。


## 2.7 后训练（Post-training）

大规模预训练之后，模型通常需要经过后训练阶段以适配具体任务。

### 2.7.1 监督微调 SFT（GPT-1）

使用标注数据对预训练语言模型进行继续训练，输入-输出对通常格式化为提示和响应。即使几千个示例也能产生显著效果。

### 2.7.2 零样本学习（GPT-2）

GPT-2 可以在没有微调的情况下仅凭提示执行未见过的任务。架构与 GPT-1 相同（Transformer 解码器），但参数规模从 117M 扩展到 1.5B，训练数据从 4GB 扩展到 40GB 网络文本。

### 2.7.3 少样本学习 / 上下文学习（GPT-3）

通过在提示中提供少量示例，模型可以在不更新权重的情况下"即时学习"任务。这种上下文学习（In-Context Learning, ICL）能力在大规模预训练中涌现。


### 2.7.4 思维链提示（Chain-of-Thought Prompting）

思维链（CoT）提示通过在提示中展示逐步推理过程，使大语言模型能够处理复杂的算术、常识和符号推理任务。CoT 能力随模型规模扩大而涌现。


## 2.8 采样策略

在每个步骤如何从 $p_{\theta}(x_i | x_1, \dots, x_{i-1})$ 中采样？

### 2.8.1 贪心解码（Greedy Decoding）

选择最可能的 token：

$$
\hat{x}_i = \arg\max p_{\theta}(x_i | x_1, \dots, x_{i-1})
$$

- **优点**：确定性，快速
- **缺点**：多样性低，容易重复，陷入循环

### 2.8.2 温度采样（Temperature Sampling）

通过温度参数 $T$ 调节概率分布的"锐度"：

$$
p(v_k) = \frac{e^{\frac{l_k}{T}}}{\sum_{k} e^{\frac{l_k}{T}}}
$$

其中 $v_k$ 为第 $k$ 个词汇 token，$l_k$ 为 token 的 logit。

- **高温（$T \geq 1$）**：生成更多样化、更有创意的输出
- **低温（$T \sim 0$）**：生成更集中、更可预测的响应，接近 argmax

### 2.8.3 Top-K 采样

将选择限制在概率最高的 Top-K 个词内。

### 2.8.4 核采样（Nucleus / Top-P 采样）

选择最小集合的 token，使其累积概率 $\geq p$。

### 2.8.5 束搜索（Beam Search）

在每个解码步骤中维护 $B$ 个最有可能的部分序列（称为束 beams）。路径概率定义为：

$$
p_{\theta}(x_1, \ldots, x_l) = \prod_{i=1}^{l} p_{\theta}(x_i | x_1, \ldots, x_{i-1})
$$

较长序列因每个步骤乘以概率项，自然具有较小的概率。使用长度归一化解决：

$$
\text{score} = \frac{1}{(5 + |\text{seq}|)^a / (5 + 1)^a} \cdot \log P(\text{seq})
$$

## 2.9 PixelRNN：图像的自回归建模

将图像分解为像素，以自回归方式建模：

$$
p_{model}(x) = \prod_{i=1}^{N} p_{model}(x_i | x_1, \ldots, x_{i-1})
$$

其中 $p_{model}(x_i | x_1, \dots, x_{i-1})$ 是 $[0, 1, \dots, 255]$ 上的离散概率分布。从图像某个角开始逐像素生成，对高分辨率图像采样极为缓慢。


## 2.10 联合分布分解

### 2.10.1 任意顺序分解

联合分布可以按**任意顺序**写为条件概率的乘积。例如三变量情形：

$$
\begin{aligned}
p(A, B, C) &= p(A) p(B \mid A) p(C \mid A, B) \\
&= p(C) p(B \mid C) p(A \mid B, C) \\
&= \dots
\end{aligned}
$$

分解的顺序会影响训练的复杂度——不同的依赖顺序可能导致不同难度的学习问题。

### 2.10.2 任意划分分解

联合分布也可以按**任意划分**来分解：

$$
p(A, B, C, D) = p(A, B) p(C, D \mid A, B) = p(C, D) p(A, B \mid C, D) = \dots
$$

### 2.10.3 两种分解范式

- **输入空间划分**（如自回归模型）：

$$
p(x_1, x_2, \dots, x_n) = p(x_1) p(x_2 \mid x_1) \dots p(x_n \mid x_1, x_2, \dots, x_{n-1})
$$

- **潜变量空间划分**（如 VAE）：

$$
p(\mathbf{x}, \mathbf{z}) = p(\mathbf{z}) p(\mathbf{x} \mid \mathbf{z})
$$

其中 $p(\mathbf{z}) = p(z_1) p(z_2 \mid z_1) \dots p(z_n \mid z_1, \dots, z_{n-1})$。

## 2.11 视觉自回归建模（Visual Autoregressive Modeling, VAR）

### 2.11.1 Next-Scale Prediction

VAR 提出了下一尺度预测（Next-scale Prediction）范式。给定多尺度表示 $(r_1, r_2, \ldots, r_K)$：

$$
p(r_1, r_2, \ldots, r_K) = \prod_{k=1}^{K} p(r_k \mid r_1, r_2, \ldots, r_{k-1})
$$

VAR 依次生成从粗糙到精细的多尺度 token 图，避免了逐像素生成的缓慢问题。

### 2.11.2 Next-X Prediction 泛化

X 可以是任意表示形式：Next-Token（标准 AR）、Next-Cell（按单元预测）、Next-Subsample（按下采样预测）、Next-Image（下一张图像预测）、Next-Scale（VAR）等。

### 2.11.3 两阶段训练

VAR 采用两阶段训练流程：首先训练多尺度 VQVAE 将图像编码为离散 token，然后在离散潜变量空间训练自回归 Transformer 学习 token 的联合分布。


---

## 导航栏

**生成模型 系列文章**

- [第一章：生成模型概述](/posts/ai/generative-model/overview/)
- [第二章：自回归模型](/posts/ai/generative-model/autoregressive-models/)
- [第三章：归一化流](/posts/ai/generative-model/normalizing-flows/)
- [第四章：变分自编码器](/posts/ai/generative-model/variational-autoencoder/)
- [第五章：扩散模型](/posts/ai/generative-model/diffusion-models/)
- [第六章：生成对抗网络](/posts/ai/generative-model/generative-adversarial-networks/)
