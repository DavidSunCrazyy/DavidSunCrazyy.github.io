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

# 波动方程与对流扩散方程

## 1. 二阶双曲型方程（波动方程）

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

**虚节点法 (Ghost point)：**

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

### 1.2 用能量方法分析

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

[← 一阶双曲型方程与CFL条件](/posts/finite-difference/03-first-order-hyperbolic-equations/) | [最大值原理与能量方法 →](/posts/finite-difference/05-maximum-principle-and-energy-method/)
