---
note: true
layout: post
title: "有限差分方法（二）：相容性、收敛性与Fourier稳定性分析"
permalink: /posts/finite-difference/02-consistency-convergence-stability/
categories: numerical-analysis
tags: [numerical-analysis, finite-difference-method, consistency, convergence, stability, lax-equivalence-theorem, fourier-analysis, von-neumann, du-fort-frankel]
use_math: true
---

本文介绍有限差分格式的相容性、收敛性与稳定性理论，重点阐述 Fourier-von Neumann 稳定性分析方法，并对常见的抛物型方程差分格式进行系统的稳定性分析。

# 相容性、收敛性与稳定性

## 1. 截断误差 (Truncation Error)

对微分方程 $Lu = f$ 的有限差分格式 $L_h^\tau u_j^n = f_j$，定义其截断误差：

$$
R_j^n(u) = L_h^\tau u(x_j, t_n) - f_j = L_h^\tau u(x_j, t_n) - Lu(x_j, t_n) = (L_h^\tau - L)u(x_j, t_n).
$$

称差分格式与原问题是**相容的 (consistent)**，如果 $R_j^n(u)\to 0$ 当 $(h,\tau\to 0)$。差分算子对微分算子的逼近。

$R_j^n(u) = O(\tau^p + h^q)$ ——截断误差的阶 (consistency order)。

**(i) 向前差分格式：**

$$
\begin{aligned}
R_j^n(u) &= \frac{1}{\tau}\delta_t^+ u(x_j, t_n) - \frac{C}{h^2}\delta_x^2 u(x_j, t_n) - f_j \\
&= \left[\frac{\partial u}{\partial t}\right]_j^n + O(\tau) - C\left[\frac{\partial^2 u}{\partial x^2}\right]_j^n + O(h^2) - f_j \\
&= O(\tau + h^2).
\end{aligned}
$$

**(ii) 向后差分格式：** $R_j^n(u) = O(\tau + h^2)$。

**(iii) Crank-Nicolson 格式：** $R_j^n(u) = O(\tau^2 + h^2)$（提示：在 $(x_j, t_n + \frac{\tau}{2})$ 处 Taylor 展开）。

**(iv) Richardson 格式：** $R_j^n(u) = O(\tau^2 + h^2)$。

## 2. 收敛性 (Convergence)

如果 $e_j^n = u_j^n - u(x_j, t_n) \to 0$（当 $h,\tau\to 0$ 时），则称差分格式是**收敛的**。

$e_j^n = O(\tau^p + h^q)$：收敛阶。

## 3. 稳定性 (Stability)

**定义**：设 $u_j^0$ 有一个误差 $\varepsilon_j^0$，则 $u_j^n$ 有误差 $\varepsilon_j^n$。若存在 $K>0$，当 $\tau\leq\tau_0$，$n\tau\leq T$ 时，一致地有

$$
\|\varepsilon^n\| \leq K\|\varepsilon^0\|,
$$

则称差分格式是**稳定的**。

**注**：$\|\varepsilon\|$ 可取 $\|\varepsilon\|_\infty = \max_j |\varepsilon_j^n|$，或 $\|\varepsilon^n\|_h = \left(\sum_{j=-\infty}^{\infty} (\varepsilon_j^n)^2 h\right)^{1/2}$（$L^2$ 稳定性）。

若差分格式 $u_j^{n+1} = P_h u_j^n$ 是线性的，则该格式稳定 $\Leftrightarrow$ $\|P_h^n\| \leq K$。

## 4. Lax 等价定理 (Lax Equivalence Theorem)

给定一个适定的线性初值问题或周期性边界条件的初边值问题，若差分格式与方程**相容**，则**稳定性是收敛性的充要条件**。

> The finite difference approximation converges if and only if it is consistent and stable.

## 5. 判断稳定性的方法

1. Fourier 方法 (von Neumann Analysis)
2. 直接法（矩阵法）(Matrix method)
3. 能量方法 (Energy method)
4. Hirt 启示性方法
5. 最大值原理 (Maximum principle)

### 5.1 Fourier 方法 (von Neumann 分析)

考虑热传导方程 $u_t = C u_{xx}$，$C>0$。

**向前差分格式：**

$$
\frac{u_j^{n+1} - u_j^n}{\tau} = C\frac{u_{j+1}^n - 2u_j^n + u_{j-1}^n}{h^2},
$$

即

$$
u_j^{n+1} = u_j^n + C\lambda(u_{j+1}^n - 2u_j^n + u_{j-1}^n),\quad \lambda = \frac{\tau}{h^2},
$$

$$
u_j^0 = g(x_j) = g_j.
$$

定义 $U(x, t_n) = u_j^n$，$x_j - \frac{h}{2} \leq x \leq x_j + \frac{h}{2}$。

$$
\phi(x) = g(x_j),\quad x_j - \frac{h}{2} \leq x < x_j + \frac{h}{2}.
$$

由 Fourier 变换：

$$
\widehat{U}(x+h, t_n) = \widehat{U}(\xi, t_n) e^{i\xi h},
$$

$$
\frac{1}{\sqrt{2\pi}}\int_{-\infty}^{\infty} U(x, t_{n+1}) e^{-i\xi x} dx =
\frac{1}{\sqrt{2\pi}}\int_{-\infty}^{\infty} U(x, t_n) e^{-i\xi x} dx + \cdots
$$

$$
\begin{aligned}
\widehat{U}(\xi, t_{n+1}) &= \widehat{U}(\xi, t_n) + C\lambda\widehat{U}(\xi, t_n)[e^{ih\xi} + e^{-ih\xi} - 2] \\
&= \underbrace{[1 - 4C\lambda\sin^2(\tfrac{h\xi}{2})]}_{G(\tau,\xi)} \widehat{U}(\xi, t_n).
\end{aligned}
$$

$G(\tau,\xi)$ ——**增长因子 (amplification factor)**。

$$
\widehat{U}(\xi, t_n) = G(\tau, \xi)^n \widehat{U}(\xi, t_0).
$$

若 $|G(\tau, \xi)|^n \leq K$，则由 Parseval 等式有

$$
\begin{aligned}
\|U(t_n)\|^2 &= \int_{-\infty}^{\infty} |U(x, t_n)|^2 dx
            = \int_{-\infty}^{\infty} |\widehat{U}(\xi, t_n)|^2 d\xi \\
            &\leq K^2 \int_{-\infty}^{\infty} |\widehat{U}(\xi, t_0)|^2 d\xi
            = K^2 \|\widehat{U}(t_0)\|^2 = K^2 \|U(t_0)\|^2,
\end{aligned}
$$

$$
\Rightarrow h\sum_{j=-\infty}^{\infty} |u_j^n|^2 \leq K^2 h\sum_{j=-\infty}^{\infty} |u_j^0|^2,\quad \text{即}\;\|u^n\|_h \leq K\|u^0\|_h.
$$

更一般地，对线性常系数微分方程组的差分格式 $u_j^{n+1} = C(\tau) u_j^n$（向量/矩阵形式），由 Fourier 积分得

$$
\widehat{U}(\xi, t_{n+1}) = G(\tau, \xi) \widehat{U}(\xi, t_n),
$$

其中 $G(\tau,\xi)$ 为增长矩阵 (amplification matrix)。

### 5.2 von Neumann 条件

差分格式 $u_j^{n+1} = C(\tau) u_j^n$ 稳定的**必要条件**是：当 $\tau\leq\tau_0$，$n\tau\leq T$ 时，对所有 $\xi\in\mathbb{R}$ 有

$$
|\lambda_j(G(\tau,\xi))| \leq 1 + M\tau,\quad j = 1,2,\dots,P,
$$

其中 $\lambda_j$ 为 $G(\tau,\xi)$ 的特征值。

**定理**：如果差分格式的增长矩阵 $G(\tau,\xi)$ 是正规矩阵（如实对称、酉矩阵、Hermite 矩阵，或 $G(\tau,\xi)$ 仅有一个元素），则 von Neumann 条件是差分格式稳定的**充要条件**。

> 实系数二次方程 $x^2 + bx + c = 0$ 的根在单位圆内 $\Leftrightarrow$ $|b| \leq 1 + c \leq 2$。

### 5.3 各格式的稳定性分析

#### (1) 向前差分格式

增长因子：$G(\tau,\xi) = 1 - 4C\lambda\sin^2(\frac{h\xi}{2})$。

$$
|G(\tau,\xi)|_{\max} = \max\{1, |1 - 4C\lambda|\} \leq 1 \;\Leftrightarrow\; C\lambda \leq \frac{1}{2}.
$$

**计算增长因子的方法**：令 $u_j^n = v^n e^{ijh\xi}$ 代入差分格式。

向前差分格式：

$$
\frac{1}{\tau}(v^{n+1} - v^n)e^{ijh\xi} = \frac{C}{h^2}(e^{ih\xi} - 2 + e^{-ih\xi})v^n e^{ijh\xi},
$$

$$
v^{n+1} = \underbrace{(1 - 4C\lambda\sin^2\tfrac{h\xi}{2})}_{G(\tau,\xi)} v^n.
$$

#### (2) 向后差分格式

$$
\frac{1}{\tau}\delta_t^- u_j^n = \frac{C}{h^2}\delta_x^2 u_j^n.
$$

**无条件稳定（绝对稳定）(unconditionally stable)**。

$$
\frac{1}{\tau}(v^n - v^{n-1})e^{ijh\xi} = \frac{C}{h^2}(e^{ih\xi} - 2 + e^{-ih\xi})v^n e^{ijh\xi},
$$

$$
v^n = \frac{1}{1 + 4C\lambda\sin^2\frac{h\xi}{2}} v^{n-1},
$$

$$
G(\tau,\xi) = \frac{1}{1 + 4C\lambda\sin^2(\frac{h\xi}{2})},\quad |G| \leq 1.
$$

#### (3) Crank-Nicolson 格式

无条件稳定。

$$
G(\tau,\xi) = \frac{1 - 2C\lambda\sin^2\frac{h\xi}{2}}{1 + 2C\lambda\sin^2\frac{h\xi}{2}},\quad |G| \leq 1.
$$

#### (4) Richardson 格式

$$
\frac{1}{2\tau}\delta_t^c u_j^n = \frac{C}{h^2}\delta_x^2 u_j^n.
$$

**绝对不稳定（无条件不稳定）(unconditionally unstable)**。

$$
u_j^{n+1} = u_j^{n-1} + 2C\lambda(u_{j+1}^n - 2u_j^n + u_{j-1}^n),\quad \lambda = \frac{\tau}{h^2}.
$$

令 $v_j^n = u_j^{n-1}$，$U_j^n = (u_j^n, v_j^n)^T$，则

$$
\left\{\begin{aligned}
u_j^{n+1} &= v_j^n + 2C\lambda(u_{j+1}^n - 2u_j^n + u_{j-1}^n), \\
v_j^{n+1} &= u_j^n,
\end{aligned}\right.
$$

$$
U_j^{n+1} = \begin{pmatrix} 2C\lambda & 0 \\ 0 & 0 \end{pmatrix} U_{j+1}^n
          + \begin{pmatrix} 2C\lambda & 0 \\ 0 & 0 \end{pmatrix} U_{j-1}^n
          + \begin{pmatrix} -4C\lambda & 1 \\ 1 & 0 \end{pmatrix} U_j^n.
$$

设 $U_j^n = \begin{pmatrix} W_1^n \\ W_2^n \end{pmatrix} e^{ijh\xi}$，则

$$
\begin{pmatrix} W_1^{n+1} \\ W_2^{n+1} \end{pmatrix}
= \begin{pmatrix} -8C\lambda\sin^2\frac{h\xi}{2} & 1 \\ 1 & 0 \end{pmatrix}
  \begin{pmatrix} W_1^n \\ W_2^n \end{pmatrix}.
$$

增长矩阵 $G(\tau,\xi) = \begin{pmatrix} -8C\lambda\sin^2\frac{h\xi}{2} & 1 \\ 1 & 0 \end{pmatrix}$。

特征方程：$\mu^2 + 8C\lambda\sin^2\frac{h\xi}{2}\mu - 1 = 0$。

$$
\mu_\pm = -4C\lambda\sin^2\tfrac{h\xi}{2} \pm \left(1 + 16C^2\lambda^2\sin^4\tfrac{h\xi}{2}\right)^{1/2}.
$$

$$
|\mu_-| = \left| -4C\lambda\sin^2\tfrac{h\xi}{2} - \left(1 + 16C^2\lambda^2\sin^4\tfrac{h\xi}{2}\right)^{1/2} \right|
        > 1 + 4C\lambda\sin^2\tfrac{h\xi}{2}.
$$

$\Rightarrow$ Richardson 格式不稳定。

#### (5) Du Fort-Frankel 格式（对 Richardson 格式的修正）

$$
\frac{1}{2\tau}\delta_t^c u_j^n = \frac{C}{h^2}(u_{j+1}^n - u_j^{n+1} - u_j^{n-1} + u_{j-1}^n).
$$

截断误差：$R_j^n(u) = O(\tau^2 + h^2 + \frac{\tau^2}{h^2})$。

增长矩阵：

$$
G(\tau,\xi) = \begin{pmatrix}
\dfrac{4C\lambda\cos h\xi}{1+2C\lambda} & \dfrac{1-2C\lambda}{1+2C\lambda} \\[10pt]
1 & 0
\end{pmatrix}.
$$

特征方程：$x^2 - \dfrac{4C\lambda\cos h\xi}{1+2C\lambda}x - \dfrac{1-2C\lambda}{1+2C\lambda} = 0$。

$$
\rho(G) \leq 1 \;\Leftrightarrow\; \frac{4C\lambda|\cos h\xi|}{1+2C\lambda} \leq 1 - \frac{1-2C\lambda}{1+2C\lambda} \leq 2
\;\Leftrightarrow\; \frac{4C\lambda}{1+2C\lambda} < 2,
$$

恒成立，故 $\rho(G) \leq 1$。

**定理**：设 $G(\tau,\xi) = \widetilde{G}(\sigma)_{p\times p}$，$\sigma = h\xi$。若对 $\forall\sigma\in\mathbb{R}$，以下之一成立：

1. $\widetilde{G}(\sigma)$ 有 $p$ 个不同的特征值；
2. $\widetilde{G}^{(j)}(\sigma) = \gamma_j I$，$j = 0,1,\dots,S-1$，且 $\widetilde{G}^{(S)}(\sigma)$ 有 $p$ 个不同的特征值；
3. $\rho(\widetilde{G}(\sigma)) < 1$；

则格式稳定 $\Leftrightarrow$ $\rho(G) \leq 1$。

对于三层格式，$G = \begin{pmatrix} * & * \\ 1 & 0 \end{pmatrix}$，故第二种情况不出现，只需考虑 (1) 和 (3)。

对于 Du Fort-Frankel 格式，若 $\widetilde{G}(\sigma)$ 有重特征值，则

$$
\Delta = \frac{16C^2\lambda^2\cos^2 h\xi}{(1+2C\lambda)^2} + \frac{4(1-2C\lambda)}{1+2C\lambda}
       = \frac{4 - 16C^2\lambda^2\sin^2 h\xi}{(1+2C\lambda)^2} = 0,
$$

$$
|\mu_\pm| = \left|\frac{2C\lambda\cos h\xi}{1+2C\lambda}\right| \leq \frac{2C\lambda}{1+2C\lambda} < 1,
$$

因此定理中的条件成立，von Neumann 条件也是稳定的充分条件。**Du Fort-Frankel 格式无条件稳定。**

### 5.4 一阶方程组的 von Neumann 分析示例

考虑方程组

$$
\left\{\begin{aligned}
u_t &= -v_{xx}, \\
v_t &= u_{xx},
\end{aligned}\right.\quad x\in(0,2\pi),
$$

$$
u(x,0) = u_0(x),\quad v(x,0) = v_0(x).
$$

差分格式：

$$
\delta_t^+ u_j^n = -\delta_x^2 v_j^n,\quad \delta_t^+ v_j^n = \delta_x^2 u_j^{n+1}.
$$

令 $u_j^n = \mu_1^n e^{ijh\xi}$，$v_j^n = \mu_2^n e^{ijh\xi}$，则

$$
\mu_1^{n+1} = \mu_1^n - \lambda\mu_2^n(e^{ih\xi} - 2 + e^{-ih\xi})
            = \mu_1^n + 4\lambda\sin^2\tfrac{h\xi}{2}\mu_2^n,
$$

$$
\begin{aligned}
\mu_2^{n+1} &= \mu_2^n + \lambda\mu_1^{n+1}(e^{ih\xi} - 2 + e^{-ih\xi}) \\
            &= \mu_2^n - 4\lambda\sin^2\tfrac{h\xi}{2}\mu_1^{n+1} \\
            &= \mu_2^n - 4\lambda\sin^2\tfrac{h\xi}{2}(\mu_1^n + 4\lambda\sin^2\tfrac{h\xi}{2}\mu_2^n) \\
            &= -4\lambda\sin^2\tfrac{h\xi}{2}\mu_1^n + (1 - 16\lambda^2\sin^4\tfrac{h\xi}{2})\mu_2^n.
\end{aligned}
$$

$$
\begin{bmatrix} \mu_1^{n+1} \\ \mu_2^{n+1} \end{bmatrix}
= G \begin{bmatrix} \mu_1^n \\ \mu_2^n \end{bmatrix},\quad
G = \begin{bmatrix}
1 & 4\lambda\sin^2\frac{h\xi}{2} \\[4pt]
-4\lambda\sin^2\frac{h\xi}{2} & 1 - 16\lambda^2\sin^4\frac{h\xi}{2}
\end{bmatrix}.
$$

特征方程：$x^2 - (2 - 16\lambda^2\sin^4\frac{h\xi}{2})x + 1 = 0$。

$$
|x| \leq 1 \Leftrightarrow |2 - 16\lambda^2\sin^4\tfrac{h\xi}{2}| \leq 1 + 1 = 2,
$$

$$
-1 \leq 1 - 8\lambda^2\sin^4\tfrac{h\xi}{2} \leq 1 \;\Leftrightarrow\; \lambda \leq 1/2.
$$

令 $\sigma = h\xi$，

$$
G = \widetilde{G}(\sigma) = \begin{bmatrix}
1 & 4\lambda\sin^2\sigma/2 \\[4pt]
-4\lambda\sin^2\frac{\sigma}{2} & 1 - 16\lambda^2\sin^4\frac{\sigma}{2}
\end{bmatrix}.
$$

$$
\Delta = 0 \;\Leftrightarrow\; (2 - 16\lambda^2\sin^4\tfrac{h\xi}{2})^2 = 4
\;\Leftrightarrow\; 2 - 16\lambda^2\sin^4\tfrac{\sigma}{2} = \pm 2,
$$

$$
\Leftrightarrow\; \sigma = 0 \;\text{或}\; \lambda = 1/2,\;\sin^2\tfrac{\sigma}{2} = 1.
$$

当 $\lambda < 1/2$ 时：$x^2 - 2x + 1 = 0$，$x_\pm = 1$。

$$
\widetilde{G}(0) = \begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix} = I,\quad
\widetilde{G}'(0) = \begin{bmatrix} 0 & 4\lambda\sin\sigma \\ -4\lambda\sin\sigma & -16\lambda^2\sin\sigma\sin^2\frac{\sigma}{2} \end{bmatrix}_{\sigma=0} = 0,
$$

$\widetilde{G}''(0) = \begin{bmatrix} 0 & 4\lambda\cos\sigma \\ -4\lambda & -16\lambda^2 \end{bmatrix} \cdots$ 有两个不同的特征值。

因此若 $\lambda < 1/2$，格式稳定。

当 $\lambda = 1/2$ 时：$\sin^2\frac{\sigma}{2} = 1 \Leftrightarrow \sin\frac{\sigma}{2} = \pm 1 \Leftrightarrow \sigma = (2k+1)\pi$。

$$
\widetilde{G}(\sigma)\big|_{\sigma=(2k+1)\pi} = \begin{bmatrix} 1 & 2 \\ -2 & -3 \end{bmatrix},\quad
x^2 + 2x + 1 = 0,\; x_\pm = -1.
$$

$$
\widetilde{G}(\sigma)^n = Q\begin{bmatrix} -1 & 0 \\ 1 & -1 \end{bmatrix}^n Q^{-1}
= Q\begin{bmatrix} (-1)^n & 0 \\ n(-1)^{n-1} & (-1)^n \end{bmatrix} Q^{-1}\;\text{无界}.
$$

因此该格式稳定 $\Leftrightarrow$ $\lambda < 1/2$。

[← 网格剖分与差分格式建立](/posts/finite-difference/01-basic-concepts-and-schemes/) | [一阶双曲型方程与CFL条件 →](/posts/finite-difference/03-first-order-hyperbolic-equations/)
