---
note: true
layout: post
title: "第三章：归一化流"
permalink: /posts/ai/generative-model/normalizing-flows/
categories: generative-model
tags: [generative-model, normalizing-flows, change-of-variables, coupling-layer, neural-ode, glow, ffjord]
use_math: true
---

本章系统介绍归一化流——通过可逆变换将简单分布"搬运"为复杂数据分布的方法。从变量替换公式的概率质量守恒直觉出发，逐步深入到流的复合、基本网络层设计（线性层行列式瓶颈分析），以及耦合层、Glow 可逆 1×1 卷积等关键创新。后半部分转向连续时间归一化流：Neural ODE、FFJORD 随机迹估计和 iResNet，最后以特性对比表总结各类归一化流的表达能力与计算可控性之间的权衡。

# 第3章 归一化流

## 3.1 整体思路：用可逆变换"搬运"概率

归一化流（Normalizing Flows）解决生成模型核心问题的方式非常直接：**找一个可逆变换 $G$，把简单分布（如标准正态 $\pi(z)$）"搬运"成复杂的数据分布 $p(x)$**。

整个框架有两个使用方向：

- **生成方向（$z \to x$）**：从 $\pi(z)$ 采样 $z_0$，经 $x = G(z_0)$ 得到生成样本。这是生成模型的目标。
- **推断方向（$x \to z$）**：给定数据 $x$，经 $z = G^{-1}(x)$ 得到对应的潜变量。这是训练时计算似然所必需的——只有知道了 $z$，才能用 $\pi(z)$ 来算 $p(x)$。

这两个方向的关键枢纽是**变量替换公式（Change of Variables Formula）**。

## 3.2 变量替换公式：从概率质量守恒出发

### 3.2.1 直观推导

考虑一个小区间 $[z', z' + \Delta z]$，$G$ 将其映射到 $[x', x' + \Delta x]$。概率质量必须守恒——区间内的总概率不会因为坐标变换而改变：

$$
p(x') \Delta x = \pi(z') \Delta z
$$

移项得：

$$
p(x') = \pi(z') \frac{\Delta z}{\Delta x}
$$

当 $\Delta z, \Delta x \to 0$ 时，比率 $\Delta z / \Delta x$ 趋近于导数 $dz/dx$。推广到高维，概率密度的"缩放因子"是 Jacobian 行列式的绝对值：

$$
p(x) = \pi(z) \left| \det\left(\frac{\partial z}{\partial x}\right) \right| = \pi(z) |\det(J_{G^{-1}}(x))|
$$

其中 $z = G^{-1}(x)$，$J_{G^{-1}}$ 是 $G^{-1}$ 在 $x$ 处的 Jacobian 矩阵。行列式度量了变换在每一点对体积的放缩比例，其绝对值确保概率密度非负。

### 3.2.2 对数似然形式

取对数后得到可加的形式：

$$
\log p(x) = \log \pi(G^{-1}(x)) + \log |\det(J_{G^{-1}}(x))|
$$

**直觉解读**：对数似然由两项组成——第一项是潜变量 $z = G^{-1}(x)$ 在先验下的对数概率（这个 $z$ 本身有多"正常"），第二项是变换在 $x$ 处的体积缩放的对数（变换把空间撑开或压缩了多少）。

## 3.3 流的复合：把复杂变换拆成简单步骤

### 3.3.1 网络分解

单个可逆网络表达能力有限。归一化流的做法是将 $G$ 分解为 $K$ 个简单可逆变换的复合。设 $z_0 \sim \pi$ 为初始潜变量，经过 $K$ 步变换后到达数据空间：

$$
z_K = f_{\theta^K} \circ f_{\theta^{K-1}} \circ \dots \circ f_{\theta^1}(z_0)
$$

其中每一步 $f_{\theta^k}$ 都是一个可逆、可微的子网络。令 $G = f_{\theta^K} \circ \dots \circ f_{\theta^1}$，则 $x = z_K = G(z_0)$。

### 3.3.2 链式法则与行列式

对于复合函数 $G = f_K \circ \dots \circ f_1$，其 Jacobian 行列式由链式法则逐层相乘：

$$
|\det(J_G(z_0))| = \prod_{k=1}^{K} \left| \det\left(\frac{\partial f_{\theta^k}}{\partial z_{k-1}}\right) \right|
$$

同时有 $|\det(J_{G^{-1}}(x))| = 1 / |\det(J_G(z_0))|$（逆函数的 Jacobian 是原 Jacobian 的逆，行列式互为倒数）。

### 3.3.3 对数似然的最终形式

将以上代入对数似然公式：

$$
\log p(x) = \log p(z_K) = \log \pi(z_0) - \sum_{k=1}^{K} \log \left| \det\left(\frac{\partial f_{\theta^k}}{\partial z_{k-1}}\right) \right|
$$

**关键**：为了高效训练，每一层 $f_{\theta^k}$ 必须满足：

1. **可逆**（invertible）：需要 $G^{-1}$ 来从 $x$ 计算 $z$
2. **可微**（differentiable）：需要 Jacobian 来做梯度优化
3. **行列式计算高效**：$\det(\partial f / \partial z)$ 的计算复杂度必须远低于 $O(d^3)$

第三点是归一化流设计的核心约束——正是这个约束催生了耦合层、$1 \times 1$ 卷积等一系列巧妙的结构。

## 3.4 基本网络层的设计

### 3.4.1 非线性层

使用可逆的激活函数，如 ELU（Exponential Linear Unit）。ELU 是单调的因而是可逆的，其逆和 Jacobian 行列式都有简单的闭式。

### 3.4.2 线性层：行列式复杂度是关键瓶颈

线性变换 $z \mapsto Wz$ 的 Jacobian 就是 $W$ 本身，行列式为 $\det(W)$。不同结构的 $W$，行列式计算的代价差异巨大：

| $W$ 的结构 | 求逆 | 行列式 |
|------------|------|--------|
| 全矩阵 | $O(d^3)$ | $O(d^3)$ |
| 对角矩阵 | $O(d)$ | $O(d)$ |
| 三角矩阵 | $O(d^2)$ | $O(d)$ |
| 块对角（块大小 $c$） | $O(c^3 d)$ | $O(c^3 d)$ |
| LU 分解 | $O(d^2)$ | $O(d)$ |
| 空间卷积 | $O(d \log d)$ | $O(d)$ |
| $1 \times 1$ 卷积（通道数 $c$） | $O(c^3 + c^2 d)$ | $O(c^3)$ |

**权衡分析**：全矩阵表达能力最强，但 $O(d^3)$ 在高维数据（如图像）上完全不可行。对角矩阵最快但几乎无表达能力。三角矩阵是很好的折中——$O(d)$ 行列式，$O(d^2)$ 求逆。LU 分解和空间卷积进一步将求逆降至亚三次方。$1 \times 1$ 卷积在通道维度上做全矩阵，空间维度独立处理，非常适合图像数据。

## 3.5 耦合层：归一化流的关键创新

### 3.5.1 为什么需要耦合层

线性层的表达能力有限，而非线性层虽然可逆但行列式不好求。耦合层（Coupling Layer）给出了一种巧妙的折中——**让变换强非线性，但 Jacobian 保持块三角结构**。

### 3.5.2 核心技巧

将输入 $x$ 拆分为两部分 $x^A$ 和 $x^B$：

$$
f(x) = \begin{bmatrix} x^A \\ \hat{f}(x^B \mid \theta(x^A)) \end{bmatrix}
$$

含义：$x^A$ 原样通过（恒等映射），而 $x^B$ 经由 $\hat{f}$ 变换，**变换的参数 $\theta(x^A)$ 由 $x^A$ 通过一个任意神经网络产生**。

### 3.5.3 为什么 Jacobian 行列式简单

Jacobian 的块结构为：

$$
J_f = \begin{bmatrix} I & 0 \\[4pt] \dfrac{\partial \hat{f}(x^B \mid \theta(x^A))}{\partial x^A} & J_{\hat{f}} \end{bmatrix}
$$

左上角是单位矩阵（$x^A$ 恒等映射），右上角是零矩阵（$x^A$ 的输出不依赖 $x^B$）。这是块三角矩阵，其行列式仅取决于对角块：

$$
\det(J_f) = \det(I) \cdot \det(J_{\hat{f}}) = \det(J_{\hat{f}})
$$

**关键洞察**：那个复杂的神经网络 $\theta(\cdot)$ 只出现在左下角的非对角块中，它的 Jacobian **不影响行列式**！这意味着：

- $\theta(x^A)$ 可以是任意深度的任意神经网络（CNN、Transformer 等），因为它不参与行列式计算
- 只要设计 $\hat{f}$ 本身有简单的 Jacobian 行列式，整个层的行列式就简单
- 拆分策略影响了哪些维度参与变换，对模型的表达能力至关重要

### 3.5.4 逆的计算

由于 $x^A$ 保持不变，只需对 $x^B$ 部分求逆：

$$
x^A = y^A, \quad x^B = \hat{f}^{-1}(y^B \mid \theta(y^A))
$$

只要 $\hat{f}$ 可逆，整个耦合层就是可逆的。

### 3.5.5 两种经典的 $\hat{f}$

- **加法耦合（NICE, Dinh et al. 2014）**：

$$
\hat{f}(x \mid t) = x + t
$$

此时 $\det(J_{\hat{f}}) = 1$，是体积保持（volume-preserving）变换。缺点是表达能力有限——不能缩放。

- **仿射耦合（RealNVP, Dinh et al. 2016）**：

$$
\hat{f}(x \mid s, t) = s \odot x + t
$$

此时 $\det(J_{\hat{f}}) = \prod_i s_i$（对角 Jacobian），既允许平移也允许缩放，表达能力显著增强。这是非体积保持的（non-volume preserving），可以产生收缩或膨胀。

## 3.6 Glow：可逆 $1 \times 1$ 卷积

Glow（Kingma & Dhariwal, 2018）在耦合层的基础上引入了可逆 $1 \times 1$ 卷积，在通道间进行可学习的线性混合。对于 $c \times h \times w$ 的特征图，$1 \times 1$ 卷积等价于在每个空间位置独立应用同一个 $c \times c$ 矩阵 $W$，其对数行列式为 $h \cdot w \cdot \log |\det(W)|$。Glow 的一个基本块包含 ActNorm、$1 \times 1$ 可逆卷积和仿射耦合层三个操作。进一步使用 LU 分解参数化 $W$，可将行列式计算从 $O(c^3)$ 降至 $O(c)$。


## 3.7 去量化：让离散数据适配连续模型

图像像素值是离散的（0-255 整数），而归一化流是连续密度模型。直接用连续模型拟合离散数据会导致奇异性——模型可以在每个离散值上放置无限高的概率密度（Dirac delta），使似然趋于无穷大。解决方案是对数据加噪去量化，将每个离散值"涂抹"成一个小邻域内的连续分布，消除奇异性。


## 3.8 连续时间归一化流（Neural ODE）

### 3.8.1 从离散步到连续流

前面讨论的归一化流是离散的：$z_k = f_k(z_{k-1})$，分布经过有限步变换。如果将步数推向无穷、每一步的增量趋于无穷小，就得到了连续时间版本——由神经常微分方程（Neural ODE）描述的变换：

$$
\frac{dz(t)}{dt} = f(z(t), t; \theta)
$$

- **前向过程**（推断，$x \to z_0$）：

$$
z(t_1) = z(t_0) + \int_{t_0}^{t_1} f(z(t), t; \theta) dt
$$

若 $z(t_0)$ 是数据 $x$，则 $z(t_1)$ 是潜变量。注意这与离散流的方向一致。

- **反向过程**（生成，$z_0 \to x$）：ODE 天然可逆——只需反向积分即可：

$$
z(t_0) = z(t_1) + \int_{t_1}^{t_0} f(z(t), t; \theta) dt
$$

**核心优势**：ODE 的解轨迹由向量场 $f$ 唯一确定且互不相交，流映射自动可逆。不需要像离散流那样精心设计每层的结构来保证可逆性。

另外，离散流中 ResNet 的残差块 $z_{k+1} = z_k + f(z_k)$ 恰好是 ODE 的 Euler 离散化，这建立了离散和连续版本之间的桥梁。

### 3.8.2 瞬时变量替换公式

在连续时间下，对数概率的演化由一个简洁的公式描述——瞬时变量替换（Instantaneous Change of Variables）：

$$
\frac{d \log p(z(t))}{dt} = -\text{Tr}\left(\frac{\partial f}{\partial z(t)}\right) = -\text{div}(f)
$$

**直觉**：概率密度的变化率等于向量场散度的负值。散度 $\text{div}(f)$ 度量向量场在某点的"发散"程度——如果 $\text{div}(f) > 0$（向外发散），概率被稀释（密度下降）；如果 $\text{div}(f) < 0$（向内汇聚），概率被压缩（密度上升）。

这个公式可以这样理解：把 $p(z(t))$ 的演化看作一个"概率流"——概率质量在向量场 $f$ 推动下流动，而密度的净变化恰好是流入减去流出，即散度的负值。它推广了离散版本中的 $\log|\det|$ 项。

### 3.8.3 对数似然的计算

从 $t_0$ 到 $t_1$ 积分瞬时变量替换公式，得到总的概率变化：

$$
\log p(z(t_1)) = \log p(z(t_0)) - \int_{t_0}^{t_1} \text{Tr}\left(\frac{\partial f}{\partial z(\tau)}\right) d\tau
$$

对数似然的目标是最大化 $\log p(x)$，即从先验 $\log p(z(t_1))$ 出发反向演化得到的 $\log p(z(t_0))$。整个损失函数把初始值、ODE 动力学和解耦合在一起，可以用一个统一的积分表达。

### 3.8.4 伴随方法：高效计算参数梯度

Neural ODE 的参数梯度不需要通过 ODE 求解器的每一步反向传播（那会消耗巨量内存）。相反，使用**伴随方法（Adjoint Method）**：定义伴随状态 $\mathbf{a}(t) = \partial L / \partial \mathbf{z}(t)$，其动力学为：

$$
\frac{d\mathbf{a}(t)}{dt} = -\mathbf{a}(t)^{\intercal} \frac{\partial f(\mathbf{z}(t), t; \theta)}{\partial \mathbf{z}}
$$

参数梯度通过另一个积分获得：

$$
\frac{dL}{d\theta} = -\int_{t_1}^{t_0} \left(\frac{\partial L}{\partial \mathbf{z}(t)}\right)^T \frac{\partial f(\mathbf{z}(t), t; \theta)}{\partial \theta} dt
$$

**计算流程**：构建增广状态 $s_0 = [\mathbf{z}(t_1), \partial L/\partial \mathbf{z}(t_1), \mathbf{0}_{|\theta|}]$，定义增广动力学函数同时演化 $\mathbf{z}$、$\mathbf{a}$ 和参数梯度，然后调用 ODE 求解器从 $t_1$ 反向积分到 $t_0$，一次性得到所有梯度。这意味着训练 Neural ODE 的内存开销与 ODE 求解器的步数无关——这是相对于传统反向传播的巨大优势。

## 3.9 FFJORD：随机迹估计

FFJORD（Grathwohl et al., 2019）解决了 Neural ODE 中直接计算 Jacobian 迹 $\text{Tr}(\partial f / \partial z)$ 的 $O(d)$ 次前向传播瓶颈。核心思想是使用 Hutchinson 迹估计器 $\text{Tr}(A) = \mathbb{E}_{p(\epsilon)}[\epsilon^T A \epsilon]$，将迹的计算替换为向量-Jacobian 乘积（VJP），只需一次自动微分即可高效近似，使每个时间步的迹估计复杂度降至常数级。FFJORD 的自由形式动力学允许向量场灵活调整，能够处理多模态和不连续密度等复杂分布。


## 3.10 可逆残差网络（iResNet）

iResNet（Behrmann et al., 2019）的核心思想是：如果对 ResNet 残差块 $F(x) = x + g(x)$ 中的 $g$ 施加 Lipschitz 约束 $\text{Lip}(g) < 1$，则 $g$ 成为压缩映射，整个 ResNet 自动可逆。可逆性通过 Banach 不动点定理保证，逆可通过不动点迭代 $x^{i+1} := y - g(x^i)$ 近似计算。对数行列式则利用幂级数展开 $\text{tr}(\log(I + J_g)) = \sum_{k=1}^{\infty} (-1)^{k+1} \text{tr}(J_g^k)/k$ 配合 Hutchinson 迹估计器来近似。

iResNet 在自由形式架构和可逆性之间取得了独特平衡：有解析前向过程（不像 FFJORD 需要 ODE 求解器），但没有解析逆或精确似然（分别需要不动点迭代和随机估计）。


## 3.11 归一化流方法总结

### 3.11.1 特性对比

| 特性 | NICE/i-RevNet | Real-NVP | Glow | FFJORD | i-ResNet |
|------|:---:|:---:|:---:|:---:|:---:|
| 自由形式架构 | ✕ | ✕ | ✕ | ✓ | ✓ |
| 解析前向 | ✓ | ✓ | ✓ | ✕ | ✓ |
| 解析逆 | ✓ | ✓ | ✕ | ✕ | ✕ |
| 非体积保持 | ✕ | ✓ | ✓ | ✓ | ✓ |
| 精确似然计算 | ✓ | ✓ | ✓ | ✕ | ✕ |
| 无偏对数行列式估计 | N/A | N/A | N/A | ✓ | ✕ |

- **自由形式架构**：是否允许使用任意网络结构而非严格受限的可逆设计
- **非体积保持**：变换能否进行收缩和膨胀（而非只能保持体积不变）
- **精确似然**：变量替换公式中的对数行列式是否可以精确计算

### 3.11.2 发展脉络

归一化流从严格可逆的结构化设计（NICE → RealNVP → Glow）逐步演进到更灵活的形式。Neural ODE 和 FFJORD 将离散步骤推广到连续动力学，摆脱了对解析逆和精确似然的依赖；iResNet 则在两者之间找到了平衡——保留解析前向和部分自由形式，以随机估计换取灵活性。这一演进体现了生成模型设计中普遍存在的权衡：**表达能力 vs 计算可控性**。

---

## 导航栏

**生成模型 系列文章**

- [第一章：生成模型概述](/posts/ai/generative-model/overview/)
- [第二章：自回归模型](/posts/ai/generative-model/autoregressive-models/)
- [第三章：归一化流](/posts/ai/generative-model/normalizing-flows/)
- [第四章：变分自编码器](/posts/ai/generative-model/variational-autoencoder/)
- [第五章：扩散模型](/posts/ai/generative-model/diffusion-models/)
- [第六章：生成对抗网络](/posts/ai/generative-model/generative-adversarial-networks/)
