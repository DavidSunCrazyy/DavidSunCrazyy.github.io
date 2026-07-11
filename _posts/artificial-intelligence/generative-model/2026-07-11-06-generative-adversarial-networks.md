---
note: true
layout: post
title: "第六章：生成对抗网络"
permalink: /posts/ai/generative-model/generative-adversarial-networks/
categories: generative-model
tags: [generative-model, generative-adversarial-networks, gan, minimax-game, mode-collapse, jensen-shannon-divergence, wasserstein-gan]
use_math: true
---

本章聚焦生成对抗网络（GAN）的核心理论：生成器与判别器之间的极小极大博弈的数学形式、最优判别器的闭式解推导及其与 Jensen-Shannon 散度的联系、训练算法设计和梯度下降在双人博弈中不收敛的数学根源分析。同时涵盖半监督学习扩展、模式坍塌（Mode Collapse）问题及其解决方案，以及从 DCGAN 到 StyleGAN 的后续发展概览。

# 第6章 生成对抗网络

## 6.1 GAN 的基本架构

生成对抗网络（Generative Adversarial Networks, GANs）由两个神经网络组成：

- **生成器 $G$**：将随机噪声 $z$ 映射为生成样本 $G(z)$，目标是生成以假乱真的数据
- **判别器 $D$**：判断输入是真实数据还是生成数据，目标是准确区分两者

两者进行对抗博弈：生成器试图"欺骗"判别器，判别器试图"识破"生成器。

## 6.2 极小极大博弈公式

GAN 的训练目标形式化为极小极大博弈（minimax game）：

$$
\min_G \max_D V(D, G)
$$

其中价值函数为：

$$
V(D, G) = \mathbb{E}_{x \sim p_{data}(x)} [\log D(x)] + \mathbb{E}_{z \sim p_z(z)} \left[ \log(1 - D(G(z))) \right]
$$

## 6.3 最优判别器与理论分析

### 6.3.1 最优判别器

**命题**：对于固定的生成器 $G$，最优判别器为：

$$
D_G^*(\boldsymbol{x}) = \frac{p_{data}(\boldsymbol{x})}{p_{data}(\boldsymbol{x}) + p_g(\boldsymbol{x})}
$$

**推导**：将价值函数改写为积分形式：

$$
V(G, D) = \int_{\boldsymbol{x}} \left[ p_{data}(\boldsymbol{x}) \log D(\boldsymbol{x}) + p_g(\boldsymbol{x}) \log(1 - D(\boldsymbol{x})) \right] dx
$$

对被积函数关于 $D$ 求导并令导数为零，可得上述最优判别器。

### 6.3.2 最优生成器的代价

当判别器达到最优时，生成器的代价函数为：

$$
\begin{aligned}
C(G) &= \max_D V(G, D) \\
&= \mathbb{E}_{\boldsymbol{x} \sim p_{data}} [\log D_G^*(\boldsymbol{x})] + \mathbb{E}_{\boldsymbol{x} \sim p_g} [\log(1 - D_G^*(\boldsymbol{x}))] \\
&= \mathbb{E}_{\boldsymbol{x} \sim p_{data}} \left[ \log \frac{p_{data}(\boldsymbol{x})}{p_{data}(\boldsymbol{x}) + p_g(\boldsymbol{x})} \right] + \mathbb{E}_{\boldsymbol{x} \sim p_g} \left[ \log \frac{p_g(\boldsymbol{x})}{p_{data}(\boldsymbol{x}) + p_g(\boldsymbol{x})} \right]
\end{aligned}
$$

$C(G)$ 与 Jensen-Shannon（JS）散度的关系：

$$
C(G) = -\log(4) + KL\left(p_{data} \left\| \frac{p_{data} + p_g}{2}\right) \right. + KL\left(p_g \left\| \frac{p_{data} + p_g}{2}\right) \right.
$$

即 $C(G) = -\log 4 + 2 \cdot JSD(p_{data} \| p_g)$。$C(G)$ 达到全局最小值的充要条件是 $p_g = p_{data}$。

## 6.4 训练算法

GAN 的训练使用小批量随机梯度下降，交替优化判别器和生成器。判别器通过随机梯度上升更新，生成器通过随机梯度下降更新。原始论文中每次更新生成器前更新 $k=1$ 次判别器。


## 6.5 非收敛性问题

### 6.5.1 双人博弈的挑战

GAN 涉及两个参与者：判别器试图最大化其奖励，生成器试图最小化判别器的奖励。随机梯度下降不能保证收敛到纳什均衡（Nash equilibrium）。

### 6.5.2 数学分析

考虑极小极大问题 $\min_x \max_y \, xy$。梯度下降/上升动力学为：

$$
\frac{dx(t)}{dt} = -y, \quad \frac{dy(t)}{dt} = x \quad \Rightarrow \quad \frac{d^2 x(t)}{dt^2} = -x(t)
$$

轨迹 $(x, y)$ 为圆形：

$$
x(t) = x(0) \cos(t) - y(0) \sin(t), \quad y(t) = x(0) \sin(t) + y(0) \cos(t)
$$

**不收敛！** 这揭示了 GAN 训练不稳定性的数学根源：梯度下降在双人博弈中产生循环轨迹，无法收敛到均衡点。

## 6.6 半监督学习

GAN 可扩展到半监督学习场景：将判别器扩展为 $K+1$ 类分类器（$K$ 个真实类别 + 1 个"生成样本"类），从而同时利用标注和未标注数据提升分类性能。

## 6.7 模式坍塌（Mode Collapse）

生成器可能将所有概率质量集中在少数（甚至一种）模式上，忽略数据分布中的其他模式。小批量判别（Minibatch Discrimination）是一种启发式解决方案，通过让判别器检测小批量内样本之间的多样性来激励生成器产生更丰富的输出。


## 6.8 GAN 总结

GAN 通过对抗训练隐式地建模数据分布，其核心优势在于：

- 不需要显式的似然函数
- 采样速度快（单次前向传播）
- 能够生成高质量、清晰的样本

其主要挑战包括：

- 训练不稳定（非收敛性、模式坍塌）
- 难以评估（缺乏统一的评价指标）
- 对超参数敏感

## 6.9 后续发展

GAN 领域经历了快速演进，主要里程碑包括：

- **DCGAN**：将深度卷积网络引入 GAN 架构，以卷积层替代全连接层，大幅提升了生成图像的稳定性和质量
- **WGAN**：用 Wasserstein 距离替代 JS 散度作为分布度量，显著改善了训练稳定性和收敛性
- **BigGAN**：将 GAN 扩展到大规模训练，结合大批量、正交正则化等技术，在 ImageNet 上取得突破性生成效果
- **StyleGAN**：引入风格调制机制和渐进式生成，实现了高质量、可控的图像生成，在人脸生成等任务上达到逼真效果


---

## 导航栏

**生成模型 系列文章**

- [第一章：生成模型概述](/posts/ai/generative-model/overview/)
- [第二章：自回归模型](/posts/ai/generative-model/autoregressive-models/)
- [第三章：归一化流](/posts/ai/generative-model/normalizing-flows/)
- [第四章：变分自编码器](/posts/ai/generative-model/variational-autoencoder/)
- [第五章：扩散模型](/posts/ai/generative-model/diffusion-models/)
- [第六章：生成对抗网络](/posts/ai/generative-model/generative-adversarial-networks/)
