---
note: true
layout: post
title: "有限差分方法（一）：网格剖分与差分格式建立"
permalink: /posts/finite-difference/01-basic-concepts-and-schemes/
categories: finite-difference-method
tags: [numerical-analysis, finite-difference-method, grid-meshing, taylor-expansion, difference-schemes, crank-nicolson]
use_math: true
---

本文介绍有限差分方法的基本概念，包括不同类型偏微分方程的网格剖分方法，以及通过 Taylor 级数展开建立差分格式的一般方法。

有限差分方法（finite difference method, FDM）是求解偏微分方程最经典、最直观的数值方法之一。其核心思想很简单：**用差商代替微商**，将连续的偏微分方程转化为离散的代数方程组，从而在计算机上求解。

本系列文章共五篇，按照从具体方法到理论分析的顺序展开：

| 篇次 | 主题 | 核心问题 |
|------|------|---------|
| 第一篇（本文） | 网格剖分与差分格式建立 | 如何离散？如何构造格式？ |
| 第二篇 | 相容性、收敛性与稳定性 | 格式好不好？如何分析？ |
| 第三篇 | 一阶双曲型方程与 CFL 条件 | 双曲型方程有何特殊性？ |
| 第四篇 | 波动方程与对流扩散方程 | 如何处理更复杂的方程？ |
| 第五篇 | 最大值原理与能量方法 | 超越 Fourier 分析的稳定性判据 |

作为开篇，本文聚焦于最基础的问题：如何将求解区域离散化？如何用 Taylor 展开系统地构造差分格式？我们将以抛物型方程为主要示例，建立几种常用的差分格式，为后续的理论分析做好准备。

# 有限差分格式的基本概念

## 1. 网格剖分 (Grid)

### 1.1 发展方程的初值问题

网格剖分是有限差分方法的第一步。连续的问题定义在连续的区域上，而计算机只能处理有限个离散点。我们需要在求解区域上铺设一张"网格"，将原先定义在整个区域上的未知函数 $u(x,t)$ 替换为仅定义在网格节点上的离散近似值 $u_j^n$。网格的粗细（即步长 $h$ 和 $\tau$ 的大小）直接影响计算精度和计算量——步长越小越精确，但需要求解的节点数也越多。

求解区域 $\Omega=\{(x,t)\mid -\infty<x<\infty,\;t\geq 0\}$。

给定空间步长 $\Delta x = h$，时间步长 $\Delta t = \tau$，

$$
x = x_j = j\Delta x = jh,\quad j = 0,\pm 1,\pm 2,\dots,
$$

$$
t = t_n = n\Delta t = n\tau,\quad n = 0,1,2,\dots
$$

$(x_j, t_n)$：网格点或节点 (grid points or nodes)。

### 1.2 初边值问题

与初值问题不同，初边值问题在实际应用中更为常见——物理问题通常发生在有限的空间区域内（如一根有限长度的杆），需要同时给出初始条件和边界条件。此时网格剖分需要考虑边界处的处理方式。

求解区域 $\Omega=\{(x,t)\mid 0\leq x\leq \ell,\;t\geq 0\}$。

给定 $J,M\in\mathbb{N}$，$\Delta t = \tau$，$x_j = j\Delta x = jh$，$h = \frac{\ell}{J}$，$M$；$t_n = n\Delta t = n\tau$。

### 1.3 椭圆型方程的边值问题

求解区域 $\Omega$，$\Gamma = \partial\Omega$。

$$
x = x_i = i\Delta x,\quad i = 0,\pm 1,\pm 2,\dots
$$

$$
y = y_j = j\Delta y,\quad j = 0,\pm 1,\pm 2,\dots
$$

- $\circ$：内部节点（与之相邻的4个节点都 $\in\Omega\cup\Gamma$）
- $\times$：边界节点（至少有一个与之相邻的节点不在 $\Omega$ 内）

## 2. 建立差分格式 (Taylor 级数展开方法)

有了网格之后，下一个问题是如何将偏微分方程中的导数转换为网格节点上的代数表达式。最自然的想法来自导数的定义：

$$
\frac{\partial u}{\partial t} \approx \frac{u(x,t+\Delta t)-u(x,t)}{\Delta t}.
$$

但这个近似有多好？如何系统地构造更高精度的近似？**Taylor 级数展开**给出了统一的回答——它让我们能够量化差商逼近微商的误差阶数，从而指导差分格式的设计。

### 2.1 Taylor 展开

$$
\begin{array}{rl}
&\frac{u(x_j, t_{n+1}) - u(x_j, t_n)}{\tau} = \left[\frac{\partial u}{\partial t}\right]_j^n + O(\tau), \\[6pt]
&\frac{u(x_j, t_n) - u(x_j, t_{n-1})}{\tau} = \left[\frac{\partial u}{\partial t}\right]_j^n + O(\tau), \\[6pt]
&\frac{u(x_j, t_{n+1}) - u(x_j, t_{n-1})}{2\tau} = \left[\frac{\partial u}{\partial t}\right]_j^n + O(\tau^2), \\[6pt]
&\frac{u(x_j, t_{n+1}) - 2u(x_j, t_n) + u(x_j, t_{n-1})}{\tau^2} = \left[\frac{\partial^2 u}{\partial t^2}\right]_j^n + O(\tau^2).
\end{array}
$$

### 2.2 抛物型方程 (Parabolic Equation)

我们以最典型的抛物型方程——热传导方程——作为具体示例，展示如何用 Taylor 展开系统地建立差分格式。选择热传导方程的原因是它结构简单但性质典型，后续文章中的稳定性分析也都将以它为基础展开。

对抛物方程

$$
\left\{\begin{array}{l}
\dfrac{\partial u}{\partial t} = C\dfrac{\partial^2 u}{\partial x^2} + f(x,t),\quad x\in\mathbb{R},\;t>0,\\[8pt]
u(x,0) = g(x),\quad x\in\mathbb{R}.
\end{array}\right.
$$

$$
\begin{array}{rl}
\left[\dfrac{\partial u}{\partial t} - C\dfrac{\partial^2 u}{\partial x^2}\right]_j^n - f_j
&= \dfrac{u(x_j, t_{n+1}) - u(x_j, t_n)}{\tau}
   - C\dfrac{u(x_{j+1}, t_n) - 2u(x_j, t_n) + u(x_{j-1}, t_n)}{h^2} \\[6pt]
&\quad - f_j + O(\tau + h^2).
\end{array}
$$

设 $u_j^n$ 表示 $u(x_j, t_n)$ 的逼近，则差分方程为：

$$
\frac{u_j^{n+1} - u_j^n}{\tau} - C\frac{u_{j+1}^n - 2u_j^n + u_{j-1}^n}{h^2} = f_j,\quad j = 0,\pm1,\pm2,\dots,\;n = 0,1,2,\dots
$$

即

$$
u_j^{n+1} = u_j^n + C\lambda(u_{j+1}^n - 2u_j^n + u_{j-1}^n) + \tau f_j,\quad \lambda = \frac{\tau}{h^2}\; \text{——网格比 (mesh ratio)}.
$$

初始条件：$u_j^0 = g_j = g(x_j)$。

观察上面的推导过程，核心思路是：将微分方程在网格点 $(x_j, t_n)$ 处的精确值代入，用 Taylor 展开将精确值替换为离散近似值 $u_j^n$，同时将导数替换为差分表达式。多余的 Taylor 余项被"丢掉"——这些被丢掉的项构成了**截断误差**，它衡量了差分方程与微分方程之间的差距。下一篇文章将系统研究截断误差和它带来的后果。

### 2.3 差分算子记号

差分格式用原始形式写出来比较繁琐。引入差分算子记号可以大大简化书写，并且能够更清晰地揭示不同格式之间的代数结构关系。这些算子在下文中会反复出现。

$$
\delta_t^+ u_j^n = u_j^{n+1} - u_j^n,\quad
\delta_t^- u_j^n = u_j^n - u_j^{n-1},\quad
\delta_t^c u_j^n = u_j^{n+1} - u_j^{n-1},
$$

$$
\delta_t^2 u_j^n = u_j^{n+1} - 2u_j^n + u_j^{n-1},\quad
\delta_x^2 u_j^n = u_{j+1}^n - 2u_j^n + u_{j-1}^n.
$$

### 2.4 常用差分格式

利用前文的差分算子记号，我们可以将常见的几种差分格式写成非常紧凑的形式。注意这里不是"发明"新格式，而是对同一个微分方程选择不同的差商近似方式——不同的选择会带来不同的计算特性和理论性质。

**(i) 向前差分格式 (Forward Difference)**（两层显格式）

$$
\frac{1}{\tau}\delta_t^+ u_j^n = \frac{C}{h^2}\delta_x^2 u_j^n + f_j.
$$

这个格式最直观：所有空间导数都在已知的 $n$ 层计算，因此可以直接逐点解出 $u_j^{n+1}$，无需求解方程组。代价是时间方向只有一阶精度，且稳定性有条件限制（后文将证明需要 $C\lambda \leq 1/2$）。

**(ii) 向后差分格式 (Backward Difference)**（隐格式）

$$
\frac{1}{\tau}\delta_t^- u_j^n = \frac{C}{h^2}\delta_x^2 u_j^n + f_j.
$$

与向前格式不同，这里空间导数取在未知的 $n+1$ 层，导致每个时间步都需要求解一个线性方程组。计算量虽然更大，但换来了**无条件稳定性**——无论 $\tau$ 和 $h$ 取多大，误差都不会无限增长。

**(iii) Crank-Nicolson 格式**（隐格式）

$$
\frac{1}{\tau}\delta_t^+ u_j^n = \frac{C}{2h^2}(\delta_x^2 u_j^n + \delta_x^2 u_j^{n+1}) + f_j.
$$

这是向前和向后格式的"折中"——将空间导数在 $n$ 层和 $n+1$ 层各取一半。这样做的回报是时间方向精度从一阶提升到了**二阶**，且同样无条件稳定。Crank-Nicolson 是求解抛物型方程最流行的格式之一。

**(iv) Richardson 格式**（三层格式 / two-step method）

$$
\frac{1}{2\tau}\delta_t^c u_j^n = \frac{C}{h^2}\delta_x^2 u_j^n + f_j.
$$

这个格式形式上看精度很高（时间和空间都是二阶），但下文将证明它是**绝对不稳定的**——无论在什么步长下，误差都会指数增长。这是一个很好的警示：**高精度不等于好用**，稳定性同样关键。

> **显格式 (Explicit scheme)**：$n\to n+1$ 可逐点计算 $u_j^{n+1}$；
> **隐格式 (Implicit scheme)**：在新的时间层上包含多于一个节点，需求解方程组。

### 2.5 如何选取差分格式？

面对这几种格式，读者自然会问：我应该用哪个？答案取决于三个核心因素的权衡：

- **计算量 (computational cost)**：显格式每步只需简单代数运算，但步长受限于稳定性条件；隐格式每步需求解方程组、计算量大，但可以使用更大的时间步长。哪种更划算取决于具体问题。
- **稳定性 (stability)**：有些格式（如 Richardson）精度很高但完全不实用，而有些格式（如向前差分）精度一般但在一定条件下稳定可用。稳定性是实用性的前提。
- **逼近精度 (convergence)**：高精度格式可以在较粗的网格上获得满意的结果，但精度高不等于一切——必须同时满足稳定性要求。

这三者之间存在深刻的权衡关系，其中最微妙的是稳定性问题。这就引出了下一篇文章的主题——**定量地分析差分格式的相容性、收敛性与稳定性**，并介绍最常用的稳定性分析工具：Fourier-von Neumann 方法。

[下一篇：相容性、收敛性与稳定性 →](/posts/finite-difference/02-consistency-convergence-stability/)
