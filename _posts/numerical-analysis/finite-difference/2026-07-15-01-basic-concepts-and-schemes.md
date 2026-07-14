---
note: true
layout: post
title: "有限差分方法（一）：网格剖分与差分格式建立"
permalink: /posts/finite-difference/01-basic-concepts-and-schemes/
categories: numerical-analysis
tags: [numerical-analysis, finite-difference-method, grid-meshing, taylor-expansion, difference-schemes, crank-nicolson]
use_math: true
---

本文介绍有限差分方法的基本概念，包括不同类型偏微分方程的网格剖分方法，以及通过 Taylor 级数展开建立差分格式的一般方法。

# 有限差分格式的基本概念

## 1. 网格剖分 (Grid)

### 1.1 发展方程的初值问题

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

### 2.3 差分算子记号

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

**(i) 向前差分格式 (Forward Difference)**（两层显格式）

$$
\frac{1}{\tau}\delta_t^+ u_j^n = \frac{C}{h^2}\delta_x^2 u_j^n + f_j.
$$

**(ii) 向后差分格式 (Backward Difference)**（隐格式）

$$
\frac{1}{\tau}\delta_t^- u_j^n = \frac{C}{h^2}\delta_x^2 u_j^n + f_j.
$$

**(iii) Crank-Nicolson 格式**（隐格式）

$$
\frac{1}{\tau}\delta_t^+ u_j^n = \frac{C}{2h^2}(\delta_x^2 u_j^n + \delta_x^2 u_j^{n+1}) + f_j.
$$

**(iv) Richardson 格式**（三层格式 / two-step method）

$$
\frac{1}{2\tau}\delta_t^c u_j^n = \frac{C}{h^2}\delta_x^2 u_j^n + f_j.
$$

> **显格式 (Explicit scheme)**：$n\to n+1$ 可逐点计算 $u_j^{n+1}$；
> **隐格式 (Implicit scheme)**：在新的时间层上包含多于一个节点，需求解方程组。

### 2.5 如何选取差分格式？

- **计算量**：显格式还是隐格式？(computational cost)
- **稳定性**：误差无限增长还是可控？(stability)
- **逼近精度**：收敛性及收敛阶 (convergence)

[下一篇：相容性、收敛性与稳定性 →](/posts/finite-difference/02-consistency-convergence-stability/)
