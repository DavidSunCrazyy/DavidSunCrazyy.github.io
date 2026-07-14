---
note: true
layout: post
title: "有限差分方法（三）：一阶双曲型方程与CFL条件"
permalink: /posts/finite-difference/03-first-order-hyperbolic-equations/
categories: numerical-analysis
tags: [numerical-analysis, finite-difference-method, hyperbolic-equations, upwind-scheme, lax-friedrichs, leap-frog, lax-wendroff, cfl-condition]
use_math: true
---

本文介绍一阶双曲型方程的有限差分方法，包括迎风格式、Lax-Friedrichs 格式、蛙跳格式和 Lax-Wendroff 格式的构造与稳定性分析，以及 CFL 稳定性必要条件。

# 一阶双曲型方程与 CFL 条件

## 1. 一阶线性常系数双曲型方程

$$
\left\{\begin{aligned}
\frac{\partial u}{\partial t} + a\frac{\partial u}{\partial x} &= 0,\quad x\in\mathbb{R},\;t>0,\\
u(x,0) &= u_0(x).
\end{aligned}\right.
$$

设 $a>0$。

### 1.1 迎风格式 (Upwind Scheme)

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

### 1.4 Lax-Friedrichs 格式（对中心差分的修正）

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

## 2. CFL 条件 (Courant-Friedrichs-Lewy Condition)

称区间 $[x_{j-n}, x_{j+n}]$ 上所有节点为差分格式在点 $(x_j, t_n)$ 的**依赖区域 (domain of dependence)**。

差分格式收敛的**必要条件**：数值依赖区域必须包含微分方程的依赖区域，即

$$
x_j - a t_n \in [x_j - nh, x_j + nh].
$$

> The numerical domain of dependence must contain the domain of dependence for the PDE problem.

[← 相容性、收敛性与稳定性](/posts/finite-difference/02-consistency-convergence-stability/) | [波动方程与对流扩散方程 →](/posts/finite-difference/04-wave-and-convection-diffusion/)
