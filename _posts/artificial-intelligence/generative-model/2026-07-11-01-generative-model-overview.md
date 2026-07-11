---
note: true
layout: post
title: "第一章：生成模型概述"
permalink: /posts/ai/generative-model/overview/
categories: generative-model
tags: [generative-model, generative-model-overview, kl-divergence, maximum-likelihood]
use_math: true
---

本章是生成模型系列的开篇，介绍生成模型的基本概念——学习真实数据分布并从中采样生成新样本。通过与判别模型的对比阐明生成模型的独特价值，引入 KL 散度与最大似然作为生成模型训练的核心理论基础，并概述后续各章将介绍的六种主流生成模型方法。

# 第1章 生成模型概述

## 1.1 什么是生成模型

生成模型（Generative Models）的核心思想是：**给定一些数据，训练一个模型来生成与之类似的数据**。生成模型试图学习真实数据分布，并能够从学习到的分布中采样出新的样本。

正如理查德·费曼（Richard Feynman）所言：「我不能创造的，我便不能理解。」（"What I cannot create, I do not understand."）这句话深刻揭示了生成模型在人工智能研究中的根本意义——真正理解数据，意味着能够生成数据。

设真实数据分布为 $p_{data}(x)$，生成模型学习到的分布为 $p_{model}(x)$。生成模型的目标是使 $p_{model}$ 尽可能接近 $p_{data}$。

## 1.2 为什么需要生成模型

### 1.2.1 判别模型与生成模型的区别

判别模型的核心是逼近最小均方误差（MMSE）估计量，即后验均值：

$$
x_{0}^{*} = \arg \min_{g(y_{0}) \colon g \in \{f_{\theta}\}} \mathbb{E}_{(x_{0}, y_{0}) \sim p_{data}} \| g(y_{0}) - x_{0} \|_{2}^{2} \approx \mathbb{E}(x | y)
$$

生成模型则直接学习数据的分布 $p(x)$。掌握 $p(x)$ 后，对任意任务，已知条件分布 $p(y|x)$，便可通过贝叶斯定理得到后验分布：

$$
p(x | y) = \frac{p(x) p(y | x)}{p(y)}
$$

此外，生成模型能够学习数据的内在特征（intrinsic characteristics），这对于理解数据本质具有重要意义。

### 1.2.2 应用场景

生成模型在众多领域发挥着重要作用：

- **图像处理**：超分辨率（Super-resolution）、图像压缩（Compression）
- **语音处理**：文本转语音（Text-to-speech）
- **强化学习**：规划（Planning）、探索（Exploration）、内在动机（Intrinsic motivation）、基于模型的强化学习（Model-based RL）
- **科学研究**：蛋白质组学（Proteomics）、药物发现（Drug Discovery）、天文学（Astronomy）、高能物理（High-energy physics）

## 1.3 KL散度与最大似然

### 1.3.1 KL散度

KL散度（Kullback-Leibler Divergence）用于度量两个分布之间的相似程度：

$$
KL(p_{data} \| p_{model}) = \int p_{data} \log p_{model} - \int p_{data} \log p_{data} = \int p _{data} \log \frac{p_{data}}{p_{model}}
$$

最小化 $KL(p_{data} \| p_{model})$ 等价于最大化训练数据的对数似然（log-likelihood）：

$$
\boxed{\sum_{x \in D} \log p_{model}(x | \theta)}
$$

因此，生成模型训练的核心损失函数就是对数似然（likelihood）。

### 1.3.2 核心问题

生成模型的关键问题在于：**如何建模并计算 $p_{model}$？**

不同的生成模型给出了不同的答案：

- **自回归模型（Autoregressive Models）**：将联合分布分解为条件分布的乘积
- **归一化流（Normalizing Flows）**：通过可逆变换将简单分布映射为复杂分布
- **变分自编码器（VAEs）**：引入潜变量，通过变分推断优化证据下界
- **扩散模型（Diffusion Models）**：通过逐步加噪/去噪过程建模数据分布
- **生成对抗网络（GANs）**：通过生成器与判别器的对抗博弈隐式建模分布

这些方法将在后续章节中逐一详细介绍。

---

## 导航栏

**生成模型 系列文章**

- [第一章：生成模型概述](/posts/ai/generative-model/overview/)
- [第二章：自回归模型](/posts/ai/generative-model/autoregressive-models/)
- [第三章：归一化流](/posts/ai/generative-model/normalizing-flows/)
- [第四章：变分自编码器](/posts/ai/generative-model/variational-autoencoder/)
- [第五章：扩散模型](/posts/ai/generative-model/diffusion-models/)
- [第六章：生成对抗网络](/posts/ai/generative-model/generative-adversarial-networks/)
