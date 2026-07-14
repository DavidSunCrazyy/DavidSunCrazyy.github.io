---
note: true
layout: post
title: "有限差分方法（五）：最大值原理与能量方法"
permalink: /posts/finite-difference/05-maximum-principle-and-energy-method/
categories: numerical-analysis
tags: [numerical-analysis, finite-difference-method, maximum-principle, comparison-theorem, energy-method, stability-analysis, summation-by-parts]
use_math: true
---

本文介绍有限差分格式的两种重要稳定性分析方法——最大值原理与能量方法，通过具体示例展示如何利用这些工具分析差分格式的稳定性。

# 最大值原理与能量方法

## 1. 最大值原理 (Maximum Principle)

### 1.1 变系数抛物方程

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

### 1.2 椭圆型差分算子的最大值原理

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

### 2.1 分部求和公式

**引理 1（分部求和公式）**：对于 $u = (u_0, u_1, \dots, u_M)$，$v = (v_0, v_1, \dots, v_M)$，

$$
\delta_x^+ u_j = u_{j+1} - u_j,\quad \delta_x^- u_j = u_j - u_{j-1}.
$$

定义内积：

$$
[a, b] = \sum_{j=0}^{M-1} a_j b_j,\quad
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

#### 例 1：向前差分格式的稳定性

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

#### 例 2：向后差分格式的能量估计

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

#### 例 3：一阶双曲方程组的能量稳定性

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

#### 例 4：带人工边界条件的蛙跳格式

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

[← 波动方程与对流扩散方程](/posts/finite-difference/04-wave-and-convection-diffusion/)
