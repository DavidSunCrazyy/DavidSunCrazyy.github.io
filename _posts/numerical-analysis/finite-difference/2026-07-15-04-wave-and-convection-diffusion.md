---
note: true
layout: post
title: "有限差分方法（四）：波动方程与对流扩散方程"
permalink: /posts/finite-difference/04-wave-and-convection-diffusion/
categories: numerical-analysis
tags: [numerical-analysis, finite-difference-method, wave-equation, convection-diffusion, stability-analysis]
use_math: true
---

本文介绍二阶双曲型方程（波动方程）的有限差分方法以及对流扩散方程的数值格式，包括稳定性分析与初值处理技巧。

上一篇文章研究了一阶双曲型方程（对流方程），介绍了多种差分格式和 CFL 条件。本文继续拓展偏微分方程的"版图"，讨论两类更复杂的方程：**二阶波动方程**（典型的二阶双曲型方程）和**对流扩散方程**（对流与扩散的耦合）。

波动方程在形式上可以看作一阶双曲型方程组的等价形式，因此很多分析技术可以延续使用。对流扩散方程则将抛物型方程（第二篇的主题）和双曲型方程（第三篇的主题）的特征融合在一起——其稳定性条件会同时受到对流项和扩散项的制约。理解这种耦合对于解决实际工程问题（如污染物扩散、大气环流模拟）非常重要。

# 波动方程与对流扩散方程

## 1. 二阶双曲型方程（波动方程）

波动方程 $\partial_{tt}u = a^2 \partial_{xx}u$ 描述的是弦的振动、声波的传播等现象。与一阶对流方程不同，波动方程是时间二阶的，因此天然需要三个时间层的信息。这个额外的自由度带来了新的挑战——初值条件需要同时给出 $u$ 和 $\partial_t u$（即初始位移和初始速度）才能唯一确定解。

$$
\frac{\partial^2 u}{\partial t^2} = a^2\frac{\partial^2 u}{\partial x^2}.
$$

差分格式：

$$
\frac{1}{\tau^2}\delta_t^2 u_j^n = \frac{a^2}{h^2}\delta_x^2 u_j^n,
$$

即

$$
u_j^{n+1} - 2u_j^n + u_j^{n-1} = r(u_{j+1}^n - 2u_j^n + u_{j-1}^n),\quad r = \frac{a^2\tau^2}{h^2}.
$$

截断误差：$R_j^n(u) = O(\tau^2 + h^2)$。

初始条件：

$$
u_j^0 = f_j = f(x_j),\quad \frac{u_j^1 - u_j^0}{\tau} = g_j = g(x_j).
$$

（注：$u_j^1$ 的逼近仅为 $O(\tau)$ 阶精度，可用虚节点法提高精度。）

初值处理是三层格式的一个常见痛点。差分格式在计算 $u_j^2$ 时需要用到 $u_j^0$ 和 $u_j^1$，但我们只知道 $u_j^0$（初始位移 $f_j$）和初始速度 $g_j$，并不知道 $u_j^1$。直接使用向前差商 $\frac{u_j^1-u_j^0}{\tau}=g_j$ 给出 $u_j^1$ 的话，其精度只有 $O(\tau)$——这会污染整个格式的二阶精度。

**虚节点法 (Ghost point)** 的思路是：假想网格在 $n=0$ 之前还有一个时间层 $n=-1$，将中心差商与 $n=0$ 处的差分方程联立，消去不需要的 $u_j^{-1}$，从而得到具有 $O(\tau^2)$ 精度的 $u_j^1$ 表达式。

$$
u_j^1 - u_j^{-1} = 2\tau g_j \;\Rightarrow\; u_j^{-1} = u_j^1 - 2\tau g_j,
$$

结合差分方程在 $n=0$ 处：

$$
\frac{1}{\tau^2}\delta_t^2 u_j^0 = \frac{a^2}{h^2}\delta_x^2 u_j^0,
$$

得

$$
u_j^1 = \frac{a^2}{2}\lambda^2(f_{j+1} + f_{j-1}) + (1 - a^2\lambda^2)f_j + \tau g_j.
$$

### 1.1 稳定性分析

令 $v^n = u_j^n - u_j^{n-1}$，$w_j^n = a\frac{u_j^n - u_{j-1}^n}{h}$，则原方程化为一阶方程组。

特征方程：$x^2 - (2 - 4r\sin^2\frac{h\xi}{2})x + 1 = 0$。

von Neumann 条件 $\Leftrightarrow$ $|2 - 4r\sin^2\frac{h\xi}{2}| \leq 2$ $\Leftrightarrow$ $r \leq 1$。

存在重特征值 $\Leftrightarrow$ $(2 - 4r\sin^2\frac{h\xi}{2})^2 = 4$ $\Leftrightarrow$ $r = 1$ 且 $\sin\frac{h\xi}{2} = 0$ 或 $\sin\frac{h\xi}{2} = \pm 1$。

- 当 $\sin\frac{h\xi}{2} = 0$ 时：$G = \begin{pmatrix} 2 & -1 \\ 1 & 0 \end{pmatrix}$，$x_\pm = 1$（重根），$G^n = Q\begin{pmatrix} 1 & 0 \\ n & 1 \end{pmatrix}Q^{-1}$ 无界。
- 当 $\sin\frac{h\xi}{2} = \pm 1$ 时：$x_\pm = -1$（重根），类似地 $G^n$ 无界。

故稳定条件为 $r < 1$，即 $|a|\lambda < 1$（其中 $\lambda = \tau/h$）。

> 波动方程的稳定性条件 $|a|\lambda < 1$ 与一阶双曲型方程的 CFL 条件形式一致——说明二阶波动方程的波速 $a$ 仍然是决定稳定性的关键参数。注意即使在临界值 $|a|\lambda = 1$ 时格式也不稳定（存在重特征值导致 $\sim n$ 的线性增长），因此实际计算中应严格取 $|a|\lambda < 1$。

### 1.2 用能量方法分析

前文用 Fourier 方法分析了稳定性，但 Fourier 分析需要假设周期边界条件或无穷区域。下面将波动方程写成一阶方程组的形式，然后用迎风-向后样式的差分格式离散。这种方程组形式的推导虽然最终也是用 Fourier 分析判断稳定性，但它本身展示了**能量方法**的视角——即将原方程转化为守恒形式，然后分析离散能量的变化。

令 $V = \frac{\partial u}{\partial t}$，$W = a\frac{\partial u}{\partial x}$，则

$$
\left\{\begin{aligned}
\frac{\partial V}{\partial t} - a\frac{\partial W}{\partial x} &= 0, \\
\frac{\partial W}{\partial t} - a\frac{\partial V}{\partial x} &= 0.
\end{aligned}\right.
$$

差分格式：

$$
\left\{\begin{aligned}
\frac{1}{\tau}\delta_t^+ v_j^n - \frac{a}{h}\delta_x^+ w_j^n &= 0, \\
\frac{1}{\tau}\delta_t^+ w_j^n - \frac{a}{h}\delta_x^- v_j^{n+1} &= 0.
\end{aligned}\right.
$$

增长矩阵：

$$
G(\tau,\xi) = \begin{pmatrix}
1 & iCe^{i\frac{h\xi}{2}} \\[4pt]
iCe^{-i\frac{h\xi}{2}} & 1 - C^2
\end{pmatrix},\quad C = 2a\lambda\sin\frac{h\xi}{2}.
$$

特征方程：$x^2 + (C^2 - 2)x + 1 = 0$。

von Neumann 条件 $\Leftrightarrow$ $|2 - C^2| \leq 2$ $\Leftrightarrow$ $|a\lambda| \leq 1$。

$G(\tau,\xi)$ 非正规矩阵。当 $|a\lambda| < 1$ 且 $h\xi \neq 2k\pi$ 时，$0 < |C| < 2$，$G$ 有两个不同的特征值，格式稳定。

当 $|a\lambda| = 1$ 时，取 $a\lambda = 1$，选取 $V_j^0 = (-1)^j$，$W_j^0 = 0$，则

$$
V_j^n = (-1)^{j+n}(1-2n),\quad W_j^n = -(-1)^{n+j}2n,
$$

$$
\left\|\begin{pmatrix} V^n \\ W^n \end{pmatrix}\right\|_\infty = 2n \to \infty\;(\tau\to 0),
$$

不稳定。

因此该格式稳定 $\Leftrightarrow$ $|a\lambda| < 1$。

## 2. 对流扩散方程 (Convection-Diffusion Equation)

对流扩散方程 $u_t + a u_x = b u_{xx}$ 是工程和物理中最常用的偏微分方程之一。它同时包含对流项（$a u_x$，双曲型特征，描述物质的输运）和扩散项（$b u_{xx}$，抛物型特征，描述物质的扩散）。在实际问题中，往往流速 $a$ 远大于扩散系数 $b$，导致方程呈现**"对流占优"**的特点——此时方程更接近双曲型而非抛物型，需要特别小心的数值处理。

下面的格式采用了一种混合策略：对流项取中心差分（时间显式）、扩散项取向后差分（时间隐式）。隐式处理扩散项可以保持无条件稳定（相对于扩散），而显式处理对流项可以简化计算。

$$
u_t + a u_x = b u_{xx},\quad b > 0,\; a > 0.
$$

差分格式：

$$
\frac{1}{\tau}\delta_t^+ u_j^n + \frac{a}{2h}\delta_x^c u_j^n = \frac{b}{h^2}\delta_x^2 u_j^{n+1}.
$$

令 $u_j^n = v^n e^{ijh\xi}$，

$$
\frac{1}{\tau}(v^{n+1} - v^n) + \frac{a}{2h}v^n(e^{ih\xi} - e^{-ih\xi})
= \frac{b}{h^2}v^{n+1}(e^{ih\xi} - 2 + e^{-ih\xi}),
$$

$$
(1 + 4b\mu\sin^2\tfrac{h\xi}{2})v^{n+1} = (1 - a\lambda i\sin h\xi)v^n,
$$

$$
G(\tau,\xi) = \frac{1 - ia\lambda\sin h\xi}{1 + 4b\mu\sin^2\frac{h\xi}{2}},\quad
\lambda = \frac{\tau}{h},\;\mu = \frac{\tau}{h^2}.
$$

$$
|G(\tau,\xi)| = \frac{\sqrt{1 + a^2\lambda^2\sin^2 h\xi}}{1 + 4b\mu\sin^2\frac{h\xi}{2}}.
$$

$|G(\tau,\xi)| \leq 1$ 等价于

$$
1 + a^2\lambda^2\sin^2 h\xi \leq (1 + 4b\mu\sin^2\tfrac{h\xi}{2})^2.
$$

### 2.1 显式格式的稳定性

考虑更简单的显式格式 $\frac{1}{\tau}\delta_t^+ u_j^n + \frac{a}{2h}\delta_x^c u_j^n = \frac{b}{h^2}\delta_x^2 u_j^n$ 的稳定性。

$$
a^2\lambda^2\sin^2 h\xi - 8b\mu\sin^2\tfrac{h\xi}{2} - 16b^2\mu^2\sin^4\tfrac{h\xi}{2} \leq 0,
$$

$$
\Leftrightarrow a^2\lambda^2(1 - \sin^2\tfrac{h\xi}{2}) - 2b\mu - 4b^2\mu^2\sin^2\tfrac{h\xi}{2} \leq 0,
$$

$$
\Leftarrow \left\{\begin{aligned}
a^2\lambda^2 - 2b\mu &\leq 0, \\
-2b\mu - 4b^2\mu^2 &\leq 0.
\end{aligned}\right.
$$

即 $a^2\lambda^2 \leq 2b\mu$ $\Leftrightarrow$ $\tau \leq \frac{2b}{a^2}$。

> 注意这个显式格式的稳定性条件 $\tau \leq 2b/a^2$：它只涉及对流速度 $a$ 和扩散系数 $b$，而不显含空间步长 $h$。这意味着无论网格多细，时间步长都存在一个与 $h$ 无关的上界。当 $a$ 很大而 $b$ 很小时（对流占优），这个条件可能极其苛刻——这就是为什么对流占优问题通常需要特殊处理（如迎风格式或算子分裂法）。

---

前四篇文章覆盖了有限差分方法的核心技术：格式构造（第一篇）、Fourier 稳定性分析（第二篇）、双曲型方程处理（第三篇）以及复合方程的数值格式（本文）。到目前为止，稳定性分析主要依赖于 Fourier 方法。然而 Fourier 方法有局限性——它只适用于线性常系数问题和周期边界条件。下一篇文章将介绍两种更通用、更具物理洞察力的稳定性分析工具：**最大值原理**（基于 $L^\infty$ 范数）和**能量方法**（基于 $L^2$ 范数）。

[← 一阶双曲型方程与CFL条件](/posts/finite-difference/03-first-order-hyperbolic-equations/) | [最大值原理与能量方法 →](/posts/finite-difference/05-maximum-principle-and-energy-method/)
