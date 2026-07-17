---
note: true
layout: post
title: "有限差分方法（五）：最大值原理与能量方法"
permalink: /posts/finite-difference/05-maximum-principle-and-energy-method/
categories: finite-difference-method
tags: [numerical-analysis, finite-difference-method, maximum-principle, comparison-theorem, energy-method, stability-analysis, summation-by-parts]
use_math: true
---

本文介绍有限差分格式的两种重要稳定性分析方法——最大值原理与能量方法，通过具体示例展示如何利用这些工具分析差分格式的稳定性。

前四篇文章中，判断稳定性的主要工具是 Fourier 分析。Fourier 方法简洁有力，但它有一个根本性的局限：**只有对线性常系数方程、周期边界条件才严格适用**。遇到变系数方程（如非均匀介质的热传导）、非线性方程或一般边界条件时，Fourier 分析要么不适用，要么只能给出启发式的推测。

本文介绍的两种方法——**最大值原理**和**能量方法**——突破了这些限制：
- **最大值原理**基于 $L^\infty$ 范数，能给出解的逐点界（pointwise bound），适用于相当广泛的一类抛物型方程。
- **能量方法**基于 $L^2$ 范数，核心是分部求和公式（分部积分的离散版本），适用于更一般的边界条件和变系数问题。

这两种方法的思想根源都在于偏微分方程的理论分析（极值原理和能量估计），因此掌握它们不仅有助于数值分析，也有助于理解原方程本身的数学结构。本文通过四个具体示例展示能量方法的应用，从简单到复杂逐步递进。

# 最大值原理与能量方法

## 1. 最大值原理 (Maximum Principle)

### 1.1 变系数抛物方程

第二篇文章用 Fourier 方法分析了常系数热传导方程的稳定性。但当热传导系数 $a(x,t)$ 依赖于空间和时间时（如非均匀介质中的热传导），方程不再是常系数，Fourier 变换无法直接分离变量。此时，**最大值原理**提供了一条替代路径。

对于热传导方程（以及更一般的抛物型方程），精确解满足一个重要的物理性质：**在没有内部热源的情况下，温度的最大值和最小值只能在初始时刻或边界上达到**。一个"好"的数值格式应当保持这个性质——而保持最大值原理的格式通常是稳定的。

考虑变系数抛物方程

$$
u_t = \frac{\partial}{\partial x}\left(a(x,t)u_x\right),\quad a(x,t) \geq a_0 > 0.
$$

向前显式格式：

$$
\begin{aligned}
\frac{1}{\tau}\delta_t^+ u_j^n &= \frac{1}{h}\left(a_{j+\frac{1}{2}}^n \frac{1}{h}\delta_x^+ u_j^n
                                 - a_{j-\frac{1}{2}}^n \frac{1}{h}\delta_x^- u_j^n\right),\quad
a_{j+\frac{1}{2}}^n = a(x_{j+\frac{1}{2}}, t_n) \\[4pt]
&= \frac{1}{h^2}\left(a_{j+\frac{1}{2}}^n u_{j+1}^n
   - (a_{j+\frac{1}{2}}^n + a_{j-\frac{1}{2}}^n)u_j^n
   + a_{j-\frac{1}{2}}^n u_{j-1}^n\right).
\end{aligned}
$$

$$
u_j^{n+1} = (1 - r(a_{j+1/2}^n + a_{j-1/2}^n))u_j^n
           + r a_{j+1/2}^n u_{j+1}^n
           + r a_{j-1/2}^n u_{j-1}^n,\quad r = \frac{\tau}{h^2}.
$$

设 $r\max a(x,t) \leq \frac{1}{2}$，则

$$
\begin{aligned}
\|u^{n+1}\|_\infty &\leq (1 - r(a_{j+1/2}^n + a_{j-1/2}^n))\|u^n\|_\infty
                    + r a_{j+1/2}^n\|u^n\|_\infty
                    + r a_{j-1/2}^n\|u^n\|_\infty \\
                   &= \|u^n\|_\infty,
\end{aligned}
$$

因此当 $r\max a(x,t) \leq \frac{1}{2}$ 时，格式是 $L^\infty$ 稳定的。

> 这里的推导揭示了最大值原理和稳定性之间的直接联系：如果格式的系数都是非负的（即 $u_j^{n+1}$ 是周围 $u^n$ 值的凸组合），那么新时间层的值不会超过旧时间层的最大值——格式在 $L^\infty$ 范数下自动稳定。这个条件（系数非负且系数和不超过 1）比 Fourier 分析的稳定性条件（$C\lambda \leq 1/2$）更具一般性——它同样适用于变系数情形。

### 1.2 椭圆型差分算子的最大值原理

对于稳态问题（椭圆型方程），最大值原理表现为**比较定理**：如果两个解的右端项和边界条件满足一定的不等式，那么解本身在内部也满足相应的不等式。这个性质可以看作抛物型最大值原理在时间导数消失后的极限情形。在数值分析中，比较定理提供了一个强大的工具，可以不必实际求解就能给出数值解的界。

网格 $\overline{\Omega_h} = \Omega_h \cup \Gamma_h$（内部点 $\cup$ 边界点）。

$$
\left\{\begin{aligned}
D_h u_j = d_{jj}u_j - \sum_{k\in N(j)} d_{jk}u_k &= f_j,\quad j\in\Omega_h, \\
u_j &= g_j,\quad j\in\Gamma_h.
\end{aligned}\right.
$$

若 $d_{jj} > 0$，$d_{jk} > 0$，$d_{jj} \geq \sum_{k\in N(j)} d_{jk}$，$\forall j$，则称 $D_h$ 为**椭圆型有限差分算子**。

设 $\overline{\Omega_h}$ 是连通的。若 $\{u_j; j\in\overline{\Omega_h}\}$ 非常数，且 $D_h u_j \leq 0$，$j\in\Omega_h$，则 $u$ 不能在 $\Omega_h$ 内取得正的最大值。

**证明**：设 $u$ 在 $j_0\in\Omega_h$ 处取得正的最大值，则

$$
D_h u_{j_0} = \left(d_{j_0j_0} - \sum_{k\in N(j_0)} d_{j_0k}\right)u_{j_0}
            + \sum_{k\in N(j_0)} d_{j_0k}(u_{j_0} - u_k) \geq 0.
$$

与 $D_h u_{j_0} \leq 0$ 矛盾（除非常数）。

**比较定理 (Comparison Theorem)**：

若 $D_h u_j \leq D_h v_j$（$j\in\Omega_h$）且 $u_j \leq v_j$（$j\in\Gamma_h$），则 $u_j \leq v_j$（$j\in\overline{\Omega_h}$）。

特别地，若 $|D_h u_j| \leq D_h v_j$ 且 $|u_j| \leq v_j$（边界上），则 $|u_j| \leq v_j$。

### 1.3 Crank-Nicolson 格式的最大值原理分析

Crank-Nicolson 格式：

$$
(1 + r_j^{n+1})u_j^{n+1} - \frac{r_j^{n+1}}{2}(u_{j+1}^{n+1} + u_{j-1}^{n+1})
= (1 - r_j^n)u_j^n + \frac{r_j^n}{2}(u_{j+1}^n + u_{j-1}^n).
$$

若 $1 - r_j^n \geq 0$，令 $v_j^{n+1} = \|u^n\|_\infty$，则

$$
D_h(u_j^{n+1} - v_j^{n+1}) = f_j - \|u^n\|_\infty \leq 0,
$$

故 $u_j^{n+1} \leq v_j^{n+1}$。同理可证 $-u_j^{n+1} \leq v_j^{n+1}$，因此

$$
|u_j^{n+1}| \leq \|u^n\|_\infty.
$$

## 2. 能量方法 (Energy Method)

能量方法是最通用的稳定性分析工具之一。它的基本思想来自物理：对于一个保守系统，能量（某种平方和或平方积分）不应随时间增加。对于差分格式，如果我们能证明离散能量 $E^n$ 满足 $E^{n+1} \leq E^n$（或 $E^{n+1} \leq (1+O(\tau)) E^n$），那么格式就是稳定的——因为初始能量给定了后续能量的上界。

能量方法的核心技术是**分部求和公式**——它允许我们在离散求和意义下"转移"差分算子，类似于分部积分在连续情形中转移导数。掌握了这个工具，就可以系统地构造能量估计了。

### 2.1 分部求和公式

分部求和公式（summation by parts）是分部积分公式的**离散类比**。回忆连续情形：

$$
\int_a^b u'(x) v(x) dx = u(b)v(b) - u(a)v(a) - \int_a^b u(x) v'(x) dx.
$$

用向前差分 $\delta_x^+$ 代替导数 $d/dx$，用求和代替积分，就得到了下面的引理 1。边界项 $u_M v_M - u_0 v_0$ 对应于分部积分中的边界项。在许多稳定性分析中，边界条件（如 Dirichlet 零边界 $v_0=v_M=0$ 或周期边界 $u_0=u_M$）会消除这些边界项，极大地简化推导。

**引理 1（分部求和公式）**：对于 $u = (u_0, u_1, \dots, u_M)$，$v = (v_0, v_1, \dots, v_M)$，

$$
\delta_x^+ u_j = u_{j+1} - u_j,\quad \delta_x^- u_j = u_j - u_{j-1}.
$$

定义内积：

$$
[a, b] = \sum_{j=0}^{M} a_j b_j,\quad
[a, b\rangle = \sum_{j=0}^{M-1} a_j b_j,\quad
\langle a, b] = \sum_{j=1}^{M} a_j b_j,\quad
\langle a, b\rangle = \sum_{j=1}^{M-1} a_j b_j.
$$

则有

$$
[\delta_x^+ u, v\rangle = -\langle u, \delta_x^- v] + u_M v_M - u_0 v_0.
$$

**推论**：若 $u_0 = u_M$，$v_0 = v_M$，则 $[\delta_x^+ u, v\rangle = -\langle u, \delta_x^- v]$。或 $u_0v_0 = 0$，$u_Mv_M = 0$。

**引理 2**：

$$
\langle \delta_x^2 u, v\rangle = -[\delta_x^+ u, \delta_x^+ v] + \delta_x^- u_M \cdot v_M - \delta_x^+ u_0 \cdot v_0.
$$

若 $v_0 = v_M = 0$，则 $\langle \delta_x^2 u, v\rangle = -[\delta_x^+ u, \delta_x^+ v]$。

对于周期问题：$u_0 = u_M$，$v_0 = v_M$，有 $[\delta_x^2 u, v] = -[\delta_x^+ u, \delta_x^+ v]$（设 $u_{-1} = u_{M-1}$）。

### 2.2 能量方法示例

#### 例 1：向前差分格式的稳定性（基本示例）

这是能量方法最简单的应用——抛物型方程的向前差分格式。通过将格式乘以适当的测试函数（这里是 $u^{n+1}+u^n$），可以构造出单调递减的能量泛函，从而得到 $r<1/2$ 的稳定性条件——与 Fourier 分析的结果一致，但推导过程不依赖于周期边界假设。

考虑齐次混合问题：

$$
\left\{\begin{aligned}
u_t - a^2 u_{xx} &= 0,\quad x\in(0,\ell)\times(0,T), \\
u(x,0) &= \phi(x), \\
u(0,t) &= u(\ell,t) = 0.
\end{aligned}\right.
$$

向前差分格式：

$$
\frac{1}{\tau}\delta_t^+ u_j^n = \frac{a^2}{h^2}\delta_x^2 u_j^n,\quad j=1,\dots,M-1,
$$

$$
u_0^n = u_M^n = 0.
$$

**解**：将方程乘以 $\tau(u_j^{n+1} + u_j^n)$ 并对 $j=1,\dots,M-1$ 求和：

$$
\begin{aligned}
\|u^{n+1}\|^2 - \|u^n\|^2
&= \frac{a^2\tau}{h^2}\langle \delta_x^2 u^n, u^{n+1} + u^n\rangle
 = -r[\delta_x^+ u^n, \delta_x^+(u^{n+1} + u^n)\rangle \\
&= -\frac{r}{2}\left[\|\delta_x^+ u^n\|^2 + \|\delta_x^+(u^n + u^{n+1})\|^2 - \|\delta_x^+ u^{n+1}\|^2\right].
\end{aligned}
$$

令 $E^n = \|u^n\|^2 - \frac{r}{2}\|\delta_x^+ u^n\|^2$，则

$$
E^{n+1} - E^n = -\frac{r}{2}\|\delta_x^+(u^n + u^{n+1})\|^2 \leq 0,
$$

故 $E^n \leq E^{n-1} \leq \dots \leq E^0 \leq \|u^0\|^2$。

注意到 $\|\delta_x^+ u^n\|^2 = \sum_{j=0}^{M-1} (u_{j+1}^n - u_j^n)^2 \leq 4\|u^n\|^2$，因此

$$
\|u^0\|^2 \geq E^n \geq (1 - 2r)\|u^n\|^2 \;\Rightarrow\;
\|u^n\|^2 \leq \frac{\|u^0\|^2}{1 - 2r},\quad \text{若 } r < \frac{1}{2}.
$$

因此当 $r < 1/2$ 时格式稳定。

#### 例 2：向后差分格式的能量估计（进阶：隐格式与非零边界）

向后差分格式是无条件稳定的（Fourier 分析已证明），但用能量方法处理非零边界条件时需要更细致的技巧。本例展示了当边界条件不为零时，边界项如何贡献到能量不等式中。

$$
\delta_t^+ u_j^n = \lambda\delta_x^2 u_j^{n+1},\quad j=1,\dots,M-1,\quad \lambda = \frac{\tau}{h^2},
$$

$$
u_0^{n+1} = \phi_0,\quad u_M^{n+1} = \phi_1.
$$

**证明：**

$$
\frac{1}{2}\sum_{j=1}^{M-1}\left((u_j^{n+1})^2 - (u_j^n)^2\right)
\leq -\lambda\sum_{j=1}^{M-2}(u_{j+1}^{n+1} - u_j^{n+1})^2
   - \frac{\lambda}{2}\left((u_1^{n+1})^2 + (u_{M-1}^{n+1})^2\right)
   + \frac{\lambda}{2}(\phi_0^2 + \phi_1^2).
$$

**证明**：由 $u_j^n = u_j^{n+1} - \lambda\delta_x^2 u_j^{n+1}$，

$$
\begin{aligned}
\|u^n\|^2 &= \sum_{j=1}^{M-1} |u_j^n|^2
          = \langle u^{n+1} - \lambda\delta_x^2 u^{n+1}, u^{n+1} - \lambda\delta_x^2 u^{n+1}\rangle \\
         &= \|u^{n+1}\|^2 - 2\lambda\langle u^{n+1}, \delta_x^2 u^{n+1}\rangle
            + \lambda^2\|\delta_x^2 u^{n+1}\|^2 \\
         &\geq \|u^{n+1}\|^2 + 2\lambda[\delta_x^+ u^{n+1}, \delta_x^+ u^{n+1}] \\
         &= \|u^{n+1}\|^2 + 2\lambda\sum_{j=1}^{M-2}(u_{j+1}^{n+1} - u_j^{n+1})^2 \\
         &\quad + 2\lambda\delta_x^+ u_0^{n+1}\cdot u_1^{n+1}
            - 2\lambda\delta_x^- u_M^{n+1}\cdot u_{M-1}^{n+1}.
\end{aligned}
$$

经代数运算可得所需不等式。

#### 例 3：一阶双曲方程组的能量稳定性（方程组）

将能量方法推广到一阶双曲型方程组，展示如何同时估计两个变量 $u$ 和 $v$ 的能量。注意这里总能量 $E^n$ 的定义需要同时包含两项，因为系统的总能量是两者之和。本例也展示了最大值原理和能量方法可以在同一问题上得出互补的结论。

$$
\left\{\begin{aligned}
u_t + u_x &= 0, \\
v_t - v_x &= 0, \\
u(-1,t) &= v(-1,t),\quad v(1,t) = u(1,t), \\
u(x,0) &= f(x),\quad v(x,0) = g(x).
\end{aligned}\right.
$$

迎风格式：

$$
\left\{\begin{aligned}
\frac{1}{\tau}\delta_t^+ u_j^n + \frac{1}{h}\delta_x^- u_j^n &= 0,\quad j = -M+1,\dots,M, \\
\frac{1}{\tau}\delta_t^+ v_j^n - \frac{1}{h}\delta_x^+ v_j^n &= 0,\quad j = -M,\dots,M-1, \\
u_{-M}^{n+1} &= v_{-M}^{n+1},\quad u_M^{n+1} = v_M^{n+1}.
\end{aligned}\right.
$$

证明能量稳定性 $E^{n+1} \leq E^n$，其中

$$
E^n = \langle u^n, u^n\rangle + [v^n, v^n]
     = \sum_{j=-M+1}^{M} (u_j^n)^2 + \sum_{j=-M}^{M-1} (v_j^n)^2,
$$

在时间步长限制 $\lambda = \frac{\tau}{h} \leq \lambda_0$ 下。

**解**：由 $u_j^{n+1} = u_j^n - \lambda\delta_x^- u_j^n$，$v_j^{n+1} = v_j^n + \lambda\delta_x^+ v_j^n$，

$$
\begin{aligned}
E^{n+1} &= \langle u^n - \lambda\delta_x^- u^n, u^n - \lambda\delta_x^- u^n\rangle
         + [v^n + \lambda\delta_x^+ v^n, v^n + \lambda\delta_x^+ v^n] \\
        &= E^n - \lambda\left((u_M^n)^2 - (u_{-M}^n)^2 + \langle\delta_x^- u^n, \delta_x^- u^n]\right)
           + \lambda^2\langle\delta_x^- u^n, \delta_x^- u^n] \\
        &\quad + \lambda\left((v_M^n)^2 - (v_{-M}^n)^2 - [\delta_x^+ v^n, \delta_x^+ v^n]\right)
           + \lambda^2[\delta_x^+ v^n, \delta_x^+ v^n] \\
        &= E^n + (\lambda^2 - \lambda)\underbrace{\left(\langle\delta_x^- u^n, \delta_x^- u^n]
           + [\delta_x^+ v^n, \delta_x^+ v^n]\right)}_{\geq 0} \\
        &\leq E^n,\quad \text{若 } 0 \leq \lambda \leq 1.
\end{aligned}
$$

此外，$u_j^{n+1} = (1-\lambda)u_j^n + \lambda u_{j-1}^n$，$v_j^{n+1} = (1-\lambda)v_j^n + \lambda v_{j+1}^n$，当 $0\leq\lambda\leq 1$ 时最大值原理也成立。

#### 例 4：带人工边界条件的蛙跳格式（人工边界条件）

蛙跳格式在有限区域上需要额外的边界条件（因为中心差分会"越界"）。人工边界条件的选择直接影响能量能否递减——这是实际计算中容易被忽视但至关重要的问题。本例展示了如何通过巧妙选择人工边界条件来保证能量不等式成立。

$$
u_t - u_x = 0,\quad x\in\Omega=(0,1),\;t>0,
$$

$$
u(x,0) = u_0(x),\quad u(1,t) = 0,\;t>0.
$$

蛙跳格式：

$$
u_j^{n+1} - u_j^{n-1} = \gamma(u_{j+1}^n - u_{j-1}^n),\quad j=1,\dots,M-1,\quad \gamma = \frac{\tau}{h}.
$$

人工边界条件取 $u_0^n = \frac{u_1^{n+1} + u_1^{n-1}}{2}$，则可证明能量不等式

$$
E^n - E^{n-1} = -\gamma u_0^n(u_1^{n+1} + u_1^{n-1}) \leq 0.
$$

进一步有

$$
(1+\gamma)(\|u^0\|^2 + \|u^1\|^2) \geq E^0 \geq E^n \geq (1-\gamma)(\|u^n\|^2 + \|u^{n+1}\|^2).
$$

当 $\gamma < 1$ 时，格式是 $L^2$ 稳定的。

---

五篇文章下来，我们建立了有限差分方法的完整知识体系：

- **第一篇**：如何剖分网格、用 Taylor 展开构造差分格式。
- **第二篇**：如何用 Fourier 分析判断格式的相容性、收敛性和稳定性，以及 Lax 等价定理这一理论基石。
- **第三篇**：如何针对双曲型方程设计专门的格式，以及 CFL 条件的几何直观。
- **第四篇**：如何扩展到更复杂的方程（波动方程、对流扩散方程），处理多物理效应的耦合。
- **第五篇（本文）**：如何使用最大值原理和能量方法分析更一般的问题，突破 Fourier 分析的适用范围。

回顾整个学习过程，有一条主线贯穿始终：**数值方法的本质是在逼近精度和计算稳定性之间寻找平衡**。高精度的格式可能不稳定（如 Richardson 格式），稳定的格式可能精度不够高或计算量太大（如显式格式的步长限制）。理解了这种权衡，就理解了有限差分方法设计的核心逻辑。

掌握了这些基础知识后，读者可以进一步探索：非线性方程的守恒型格式（如 Godunov 方法）、高分辨率格式（如 TVD、ENO、WENO）、以及有限体积法和有限元方法等现代数值方法——它们都可以看作是对有限差分思想的推广和深化。

[← 波动方程与对流扩散方程](/posts/finite-difference/04-wave-and-convection-diffusion/)
