---
note: true
layout: post
title: "有限差分方法（三）：一阶双曲型方程与CFL条件"
permalink: /posts/finite-difference/03-first-order-hyperbolic-equations/
categories: finite-difference-method
tags: [numerical-analysis, finite-difference-method, hyperbolic-equations, upwind-scheme, lax-friedrichs, leap-frog, lax-wendroff, cfl-condition]
use_math: true
---

本文介绍一阶双曲型方程的有限差分方法，包括迎风格式、Lax-Friedrichs 格式、蛙跳格式和 Lax-Wendroff 格式的构造与稳定性分析，以及 CFL 稳定性必要条件。

前两篇文章以抛物型方程（热传导方程）为主线，建立了有限差分方法的基本框架。从本文开始，我们转向另一类重要的偏微分方程——**双曲型方程**。双曲型方程描述的是波动和输运现象（如声波、水波、流体对流），其数学行为与抛物型方程有本质区别：**双曲型方程没有耗散机制，信息沿特征线以有限速度传播**。

这个区别对数值方法有深远影响：在抛物型方程中表现良好的格式，搬到双曲型方程上可能完全失效。本文将看到一系列专门为双曲型方程设计的格式——迎风格式、Lax-Friedrichs 格式、蛙跳格式、Lax-Wendroff 格式——以及一个对双曲型方程至关重要的概念：**CFL 条件**。

# 一阶双曲型方程与 CFL 条件

## 1. 一阶线性常系数双曲型方程

一阶线性对流方程是最简单的双曲型方程。它的精确解是 $u(x,t) = u_0(x-at)$——初始波形以速度 $a$ 向正 $x$ 方向平移，形状保持不变。这个看似简单的方程却是检验数值格式的"试金石"：如果一个格式连常数速度的平移都模拟不好，那更复杂的波传播问题就更不用说了。

$$
\left\{\begin{aligned}
\frac{\partial u}{\partial t} + a\frac{\partial u}{\partial x} &= 0,\quad x\in\mathbb{R},\;t>0,\\
u(x,0) &= u_0(x).
\end{aligned}\right.
$$

设 $a>0$。

### 1.1 迎风格式 (Upwind Scheme)

迎风格式的思想非常自然：既然信息从上游（迎风方向）流向下游，那么空间导数也应该"迎着风"——即用上游的信息来逼近导数。当 $a>0$ 时，信息从左边来，因此用向后差分 $\delta_x^-$ 来逼近 $\partial_x u$（因为 $u_{j-1}$ 在信息传播的上游）。如果 $a<0$ 则应该用向前差分 $\delta_x^+$。**用错了方向**（所谓"顺风格式"），格式就会不稳定。

$$
\frac{1}{\tau}\delta_t^+ u_j^n + \frac{a}{h}\delta_x^- u_j^n = 0.
$$

**截断误差：**

$$
\begin{aligned}
R_j^n(u) &= \frac{1}{\tau}(u(x_j, t_{n+1}) - u(x_j, t_n)) + \frac{a}{h}(u(x_j, t_n) - u(x_{j-1}, t_n)) \\
&= \left[\frac{\partial u}{\partial t}\right]_j^n + O(\tau) + a\left[\frac{\partial u}{\partial x}\right]_j^n + O(h) = O(\tau + h).
\end{aligned}
$$

**稳定性：** 令 $u_j^n = v^n e^{ijh\xi}$ 代入，

$$
\frac{1}{\tau}(v^{n+1} - v^n)e^{ijh\xi} + \frac{a}{h}v^n(1 - e^{-ih\xi})e^{ijh\xi} = 0,
$$

$$
v^{n+1} = \underbrace{[1 - a\lambda(1 - e^{-ih\xi})]}_{G(\tau,\xi)} v^n,\quad \lambda = \frac{\tau}{h}.
$$

$$
|G(\tau,\xi)|^2 = 1 - 4a\lambda(1 - a\lambda)\sin^2\frac{h\xi}{2}.
$$

$|G(\tau,\xi)| \leq 1 \;\Leftrightarrow\; a\lambda \leq 1$。

### 1.2 顺风格式 (Downwind Scheme) —— 绝对不稳定

如果违背迎风原则，用"下游"（顺风方向）的差分来逼近空间导数，会发生什么？答案是**绝对不稳定**——无论步长如何选取，误差都会被无限放大。这有一个直观的物理解释：顺风格式试图用"下游"的信息来预测"上游"的变化，违背了双曲型方程信息沿特征线单向传播的物理规律。

$$
\frac{1}{\tau}\delta_t^+ u_j^n + \frac{a}{h}\delta_x^+ u_j^n = 0.
$$

$$
G(\tau,\xi) = 1 - a\lambda(e^{ih\xi} - 1),
$$

$$
|G(\tau,\xi)|^2 = 1 + 4a\lambda(1 + a\lambda)\sin^2\frac{h\xi}{2} > 1.
$$

### 1.3 中心差分格式 —— 绝对不稳定

$$
\frac{1}{\tau}\delta_t^+ u_j^n + \frac{a}{2h}\delta_x^c u_j^n = 0,\quad R_j^n(u) = O(\tau + h^2).
$$

增长因子：

$$
G(\tau,\xi) = 1 - \frac{a\lambda}{2}(e^{ih\xi} - e^{-ih\xi}) = 1 - ia\lambda\sin h\xi,
$$

$$
|G(\tau,\xi)|^2 = 1 + a^2\lambda^2\sin^2 h\xi > 1\quad(\text{当 }\sin^2 h\xi \neq 0).
$$

> 中心差分格式精度为 $O(h^2)$，比迎风格式（$O(h)$）高，却绝对不稳定。问题出在中心差分没有考虑双曲型方程中信息传播的**单向性**——它对称地使用左右两侧的信息，导致格式产生了虚假的数值振荡。这再次说明：对于双曲型方程，精度不是唯一考量，必须尊重方程的物理特性。

### 1.4 Lax-Friedrichs 格式（对中心差分的修正）

Lax-Friedrichs 格式是对中心差分的一种巧妙修正：将 $u_j^n$ 替换为左右邻居的平均值 $(u_{j+1}^n+u_{j-1}^n)/2$。这个替换看似微小，实则引入了一定量的**数值耗散**——就像在方程中悄悄加了一点扩散项，使得格式稳定了下来。代价有二：精度退化到 $O(h)$（当 $\lambda$ 固定时），且需要满足 CFL 条件 $|a|\lambda \leq 1$。

$$
\frac{1}{\tau}\left(u_j^{n+1} - \frac{u_{j+1}^n + u_{j-1}^n}{2}\right) + \frac{a}{2h}\delta_x^c u_j^n = 0.
$$

截断误差：$R_j^n(u) = O(\tau + h^2) + O(\frac{h^2}{\tau})$。

当 $\lambda = \frac{\tau}{h} = \text{const}$ 时，$R_j^n(u) \sim O(\tau + h)$。

**稳定性：** 令 $u_j^n = v^n e^{ijh\xi}$，

$$
\frac{1}{\tau}\left(v^{n+1} - \frac{1}{2}(e^{ih\xi} + e^{-ih\xi})v^n\right)e^{ijh\xi}
+ \frac{a}{2h}(e^{ih\xi} - e^{-ih\xi})v^n e^{ijh\xi} = 0,
$$

$$
v^{n+1} = v^n[\cos h\xi - a\lambda i\sin h\xi],
$$

$$
|G(\tau,\xi)|^2 = \cos^2 h\xi + a^2\lambda^2\sin^2 h\xi = 1 - (1 - a^2\lambda^2)\sin^2 h\xi.
$$

当 $|a|\lambda \leq 1$ 时 $|G(\tau,\xi)| \leq 1$。与迎风格式的稳定性条件相同，区别在于不考虑特征线的走向。

### 1.5 蛙跳格式 (Leap-frog)

蛙跳格式同时使用中心时间差分和中心空间差分，达到了 $O(\tau^2+h^2)$ 的高精度，且无需隐式求解。它的名字形象地反映了三层格式的特征：奇数时间层和偶数时间层交替"跳跃"，彼此之间没有直接的依赖关系。然而，三层格式的分析远比两层格式复杂——我们需要将其转化为一阶方程组再分析增长矩阵。

$$
\frac{1}{2\tau}\delta_t^c u_j^n + \frac{a}{2h}\delta_x^c u_j^n = 0,\quad R_j^n(u) = O(\tau^2 + h^2).
$$

三层格式：

$$
u_j^{n+1} = u_j^{n-1} - a\lambda(u_{j+1}^n - u_{j-1}^n),
$$

等价于

$$
\left\{\begin{aligned}
u_j^{n+1} &= v_j^n - a\lambda(u_{j+1}^n - u_{j-1}^n), \\
v_j^{n+1} &= u_j^n.
\end{aligned}\right.
$$

$$
U_j^{n+1} = \begin{pmatrix} u_j^{n+1} \\ v_j^{n+1} \end{pmatrix},\quad
U_j^{n+1} = \begin{pmatrix} -a\lambda & 0 \\ 0 & 0 \end{pmatrix} U_{j+1}^n
          + \begin{pmatrix} a\lambda & 0 \\ 0 & 0 \end{pmatrix} U_{j-1}^n
          + \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix} U_j^n.
$$

设 $U_j^n = \begin{pmatrix} w_1^n \\ w_2^n \end{pmatrix} e^{ijh\xi}$，则

$$
\begin{pmatrix} w_1^{n+1} \\ w_2^{n+1} \end{pmatrix}
= \begin{pmatrix} -2a\lambda i\sin h\xi & 1 \\ 1 & 0 \end{pmatrix}
  \begin{pmatrix} w_1^n \\ w_2^n \end{pmatrix}.
$$

$$
G(\tau,\xi) = \begin{pmatrix} -2a\lambda i\sin h\xi & 1 \\ 1 & 0 \end{pmatrix}.
$$

特征方程：$x^2 + 2ia\lambda\sin h\xi\, x - 1 = 0$。

$$
\mu_\pm = -a\lambda i\sin h\xi \pm \sqrt{1 - a^2\lambda^2\sin^2 h\xi}.
$$

当 $|a|\lambda > 1$ 时，取 $\sin h\xi = 1$：

$$
|\mu_-| = |\sqrt{a^2\lambda^2 - 1} + a\lambda| > 1.
$$

当 $|a|\lambda \leq 1$ 时，$|\mu_\pm| = 1$，满足 von Neumann 条件。

> **注意**：$G(\tau,\xi)$ 非正规矩阵，von Neumann 条件非充分条件。

当 $|a|\lambda < 1$ 时，$\mu_+ \neq \mu_-$ 对 $\forall\xi\in\mathbb{R}$。

当 $|a|\lambda = 1$ 时，取 $\sin h\xi = 1$（即 $h\xi = \pi/2$）：

$$
G(\tau,\xi) = \begin{pmatrix} -2i & 1 \\ 1 & 0 \end{pmatrix}
            = \underbrace{\begin{pmatrix} i & 1 \\ 0 & i \end{pmatrix}
                             \begin{pmatrix} -i & 0 \\ 1 & -i \end{pmatrix}}_{Q}
              \underbrace{\begin{pmatrix} -i & 1 \\ 0 & -i \end{pmatrix}}_{Q^{-1}},
$$

$$
G^n = Q\begin{pmatrix} (-i)^n & 0 \\ n(-i)^{n-1} & (-i)^n \end{pmatrix} Q^{-1}
    = (-i)^n \begin{pmatrix} 1+n & in \\ in & 1-n \end{pmatrix},
$$

$$
\|G^n\|_\infty = 2n + 1 \to \infty,
$$

故蛙跳格式当 $|a|\lambda = 1$ 时不稳定，稳定条件为 $|a|\lambda < 1$。

### 1.6 Lax-Wendroff 格式

Lax-Wendroff 格式代表了另一种构造思路：不直接对导数做差分近似，而是先用 **Taylor 展开在时间方向展开到二阶**，再将时间导数利用原方程替换为空间导数。这样得到的格式同时具有**二阶精度**和较好的**稳定性**，且仍然是显格式。Lax-Wendroff 是双曲型方程计算中最重要的格式之一，也是构造高阶格式的典范。

由 Taylor 展开式，

$$
u(x_j, t_{n+1}) = u(x_j, t_n) + \tau\left[\frac{\partial u}{\partial t}\right]_j^n
                + \frac{\tau^2}{2}\left[\frac{\partial^2 u}{\partial t^2}\right]_j^n + O(\tau^3).
$$

利用 $\frac{\partial u}{\partial t} = -a\frac{\partial u}{\partial x}$，
$\frac{\partial^2 u}{\partial t^2} = a^2\frac{\partial^2 u}{\partial x^2}$，得

$$
u(x_j, t_{n+1}) = u(x_j, t_n) - a\tau\left[\frac{\partial u}{\partial x}\right]_j^n
                 + \frac{a^2\tau^2}{2}\left[\frac{\partial^2 u}{\partial x^2}\right]_j^n + O(\tau^3).
$$

差分格式：

$$
u_j^{n+1} = u_j^n - \frac{a\tau}{2h}\delta_x^c u_j^n + \frac{a^2\tau^2}{2h^2}\delta_x^2 u_j^n,
$$

$$
R_j^n(u) = O(\tau^2 + h^2).
$$

增长因子：

$$
G(\tau,\xi) = 1 - 2a^2\lambda^2\sin^2\frac{h\xi}{2} - ia\lambda\sin h\xi,
$$

$$
|G(\tau,\xi)|^2 = 1 - 4a^2\lambda^2(1 - a^2\lambda^2)\sin^4\frac{h\xi}{2} \leq 1
\;\Leftrightarrow\; |a|\lambda \leq 1.
$$

下表总结了本节分析的六种格式。可以看到一个明显的规律：**所有稳定格式都要求 $|a|\lambda \leq 1$**。这不是巧合——这是 CFL 条件的数学表现。

| 格式 | 截断误差 | 稳定性条件 | 特点 |
|------|---------|-----------|------|
| 迎风格式 | $O(\tau+h)$ | $a\lambda \leq 1$ | 尊重物理，简单稳定，一阶精度 |
| 顺风格式 | $O(\tau+h)$ | 绝对不稳定 | 违背物理规律 |
| 中心差分 | $O(\tau+h^2)$ | 绝对不稳定 | 精度高但忽视信息单向性 |
| Lax-Friedrichs | $O(\tau+h)$（$\lambda$固定） | $\|a\|\lambda\leq 1$ | 引入数值耗散换取稳定 |
| 蛙跳格式 | $O(\tau^2+h^2)$ | $\|a\|\lambda<1$ | 高精度三层格式，需初值处理 |
| Lax-Wendroff | $O(\tau^2+h^2)$ | $\|a\|\lambda\leq 1$ | 高精度+稳定，最佳综合性能 |

## 2. CFL 条件 (Courant-Friedrichs-Lewy Condition)

前面六个格式的稳定性分析表明，所有稳定格式都满足 $\|a\|\lambda \leq 1$——即时间步长不能太大。为什么会这样？**CFL 条件**给出了一个优美的几何解释。

核心理念是：微分方程的信息沿特征线 $x-at=\text{const}$ 传播，方程为 $(x_j, t_{n+1})$ 处的值只能在特征线与初始线的交点处确定。在数值计算中，节点 $(x_j, t_{n+1})$ 的值只能依赖于某些已知节点的值（**数值依赖区域**）。如果数值依赖区域不能覆盖微分方程的依赖区域——也就是说，需要的信息在数值上根本"够不着"——那么无论差分格式设计得多巧妙，都不可能收敛到正确解。

这就像盖房子：如果地基的面积不够大，上面的建筑就不可能稳固。CFL 条件是收敛性的**必要条件**：一个格式要想收敛，必须先满足 CFL 条件。但注意，满足 CFL 条件不**保证**稳定——稳定还需要额外的条件（如增长因子不超过 1）。

称区间 $[x_{j-n}, x_{j+n}]$ 上所有节点为差分格式在点 $(x_j, t_n)$ 的**依赖区域 (domain of dependence)**。

差分格式收敛的**必要条件**：数值依赖区域必须包含微分方程的依赖区域，即

$$
x_j - a t_n \in [x_j - nh, x_j + nh].
$$

> The numerical domain of dependence must contain the domain of dependence for the PDE problem.

回顾各格式的稳定性条件：迎风格式的 $a\lambda \leq 1$ 恰好就是 CFL 条件，说明其步长限制已经是最优的——达到了收敛所需的最小步长下限。Lax-Friedrichs 和 Lax-Wendroff 的稳定性条件同样与 CFL 条件吻合，说明这些格式的设计比较"经济"，没有引入不必要的步长约束。

下一篇文章将把一阶双曲型方程推广到**二阶波动方程**，并研究含多个物理效应（对流+扩散）的复合方程。我们将看到，当扩散和对流同时存在时，稳定性条件会变得更为复杂和有趣。

[← 相容性、收敛性与稳定性](/posts/finite-difference/02-consistency-convergence-stability/) | [波动方程与对流扩散方程 →](/posts/finite-difference/04-wave-and-convection-diffusion/)
