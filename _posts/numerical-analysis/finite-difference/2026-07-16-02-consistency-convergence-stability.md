---
note: true
layout: post
title: "有限差分方法（二）：相容性、收敛性与Fourier稳定性分析"
permalink: /posts/finite-difference/02-consistency-convergence-stability/
categories: finite-difference-method
tags: [numerical-analysis, finite-difference-method, consistency, convergence, stability, lax-equivalence-theorem, fourier-analysis, von-neumann, du-fort-frankel]
use_math: true
---

本文介绍有限差分格式的相容性、收敛性与稳定性理论，重点阐述 Fourier-von Neumann 稳定性分析方法，并对常见的抛物型方程差分格式进行系统的稳定性分析。

上一篇文章我们建立了差分格式，但还留下一个关键问题悬而未决：**怎么判断一个格式好不好用？**"好用"究竟是什么意思？

在数值分析中，"好用"有三个层次的含义。第一，差分方程是否逼近微分方程？——这是**相容性 (consistency)**。第二，数值解是否真的趋近于精确解？——这是**收敛性 (convergence)**。第三，计算过程中的微小误差会不会被无限放大？——这是**稳定性 (stability)**。这三个概念构成了有限差分方法理论分析的核心框架。

本文的组织如下：先分别定义这三个概念，然后引入 **Lax 等价定理**——它将三者联系成了一个完美的逻辑闭环：对于相容的线性格式，稳定性等价于收敛性。接着，我们重点介绍 **Fourier-von Neumann 稳定性分析方法**（最常用、最系统的稳定性分析工具），并逐一分析上一篇文章中各格式的稳定性表现。最后，我们将看到为什么 Richardson 格式虽然精度高却完全不能用、为什么 Crank-Nicolson 格式如此优秀。

# 相容性、收敛性与稳定性

## 1. 截断误差 (Truncation Error)

截断误差衡量的是"差分方程与微分方程差多远"。想象一下，把微分方程的精确解 $u(x_j,t_n)$ 代入差分格式的左边——由于 $u$ 满足的是微分方程而非差分方程，左右两边不会严格相等，这个差值就是截断误差。直观上，截断误差越小（关于 $\tau$ 和 $h$ 的阶数越高），差分格式就越"像"原微分方程。

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

对比这四种格式的截断误差阶数，可以看到：向前和向后格式只有一阶时间精度（$O(\tau)$），而 Crank-Nicolson 和 Richardson 格式都达到了二阶时间精度（$O(\tau^2)$）。从精度的角度看，后两者明显更优。但精度只是故事的一半——下文我们会看到，Richardson 格式的高精度被其不稳定性完全抵消了。

## 2. 收敛性 (Convergence)

如果 $e_j^n = u_j^n - u(x_j, t_n) \to 0$（当 $h,\tau\to 0$ 时），则称差分格式是**收敛的**。

$e_j^n = O(\tau^p + h^q)$：收敛阶。

## 3. 稳定性 (Stability)

相容性保证差分方程"接近"微分方程，但它不保证数值解"接近"精确解。原因在于：实际计算中，每一步都有舍入误差，这些微小的误差会随着时间步的推进而传播。如果误差被持续放大，即使差分格式与方程再"像"，数值解也会偏离精确解，甚至发散到无穷。这就是稳定性要解决的问题。

稳定性的直观含义是：初始时刻的一个小扰动，在后续计算中不会造成灾难性的后果。数学上，我们要求从任意初值误差 $\varepsilon^0$ 出发，后续误差 $\varepsilon^n$ 可以被一个与 $h$ 和 $\tau$ 无关的常数 $K$ 控制。

**定义**：设 $u_j^0$ 有一个误差 $\varepsilon_j^0$，则 $u_j^n$ 有误差 $\varepsilon_j^n$。若存在 $K>0$，当 $\tau\leq\tau_0$，$n\tau\leq T$ 时，一致地有

$$
\|\varepsilon^n\| \leq K\|\varepsilon^0\|,
$$

则称差分格式是**稳定的**。

**注**：$\|\varepsilon\|$ 可取 $\|\varepsilon\|_\infty = \max_j |\varepsilon_j^n|$，或 $\|\varepsilon^n\|_h = \left(\sum_{j=-\infty}^{\infty} (\varepsilon_j^n)^2 h\right)^{1/2}$（$L^2$ 稳定性）。

若差分格式 $u_j^{n+1} = P_h u_j^n$ 是线性的，则该格式稳定 $\Leftrightarrow$ $\|P_h^n\| \leq K$。

## 4. Lax 等价定理 (Lax Equivalence Theorem)

Lax 等价定理是有限差分理论的**基石**。它告诉我们一个非常简洁、非常有力的结论：

给定一个适定的线性初值问题或周期性边界条件的初边值问题，若差分格式与方程**相容**，则**稳定性是收敛性的充要条件**。

> The finite difference approximation converges if and only if it is consistent and stable.

这个定理极大地简化了我们的工作：**收敛性**（$e_j^n \to 0$）通常很难直接验证，因为需要知道精确解。但**稳定性**可以通过代数方法（如下文的 Fourier 分析）来判断，而不需要实际求解微分方程。Lax 定理让我们可以用代数方法回答收敛性问题——只要验证了相容性和稳定性，收敛性就自动成立。

> **注意**：定理有两个前提——**线性**问题和**适定性**（well-posedness，即解存在、唯一且连续依赖于初值）。对于非线性问题或不适定问题，不能直接套用此定理。

## 5. 判断稳定性的方法

既然稳定性如此关键，那么如何判断一个差分格式是否稳定？有以下五类方法。其中 **Fourier 方法**是最常用、最系统的方法，也是本文的重点；**能量方法**和**最大值原理**将在第五篇文章中深入讨论。

1. Fourier 方法 (von Neumann Analysis)
2. 直接法（矩阵法）(Matrix method)
3. 能量方法 (Energy method)
4. Hirt 启示性方法
5. 最大值原理 (Maximum principle)

### 5.1 Fourier 方法 (von Neumann 分析)

Fourier 方法的核心思想来自信号处理：任何函数都可以分解为不同频率的正弦波的叠加。由于我们考虑的差分格式是线性的，可以**单独分析每个频率分量的行为**：看格式对某个频率分量是"放大"还是"衰减"。如果存在某个频率分量被无限放大，格式就不稳定。

具体做法是：假设解具有形式 $u_j^n = v^n e^{ijh\xi}$（即空间频率为 $\xi$ 的波），代入差分格式后得到 $v^{n+1} = G(\tau,\xi) v^n$。$G$ 称为**增长因子 (amplification factor)**——它告诉我们，每推进一个时间步，该频率分量的振幅被放大（或衰减）了 $G$ 倍。稳定性条件等价于要求对所有频率都有 $|G| \leq 1$（或更准确地，$|G| \leq 1+O(\tau)$）。下面我们以向前差分格式为例，展示这一分析过程。

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

对于更一般的格式（方程组或多层格式），增长因子变成了**增长矩阵** $G(\tau,\xi)$。von Neumann 条件指出：如果增长矩阵的谱半径（即最大特征值的模）不超过 $1+O(\tau)$，那么稳定性是**可能**的。但这个条件仅是**必要的**，不是充分的——除非增长矩阵是**正规矩阵**（可以被酉对角化）。直观上，非正规矩阵可能产生特征值在单位圆内但矩阵幂次无界的情况（Jordan 块导致的线性增长）。好在对于实践中遇到的大多数格式，von Neumann 条件往往就是充分条件，因此它是**最实用的稳定性判据**。

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

> **总结**：向前差分格式的稳定性条件是 $C\lambda \leq 1/2$，即 $\tau \leq h^2/(2C)$。这个条件的实际含义非常苛刻：若想将空间步长减半以提升精度，时间步长就必须减为原来的**四分之一**。这意味着在细网格上计算量会急剧增加——这是显格式的典型代价。

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

> **总结**：向后格式无条件稳定，可以自由选择时间步长。代价是每个时间步需求解线性方程组。对于大型问题，这个代价可能很大，但相比向前格式极其苛刻的步长限制，隐格式往往是更实用的选择。

#### (3) Crank-Nicolson 格式

无条件稳定。

$$
G(\tau,\xi) = \frac{1 - 2C\lambda\sin^2\frac{h\xi}{2}}{1 + 2C\lambda\sin^2\frac{h\xi}{2}},\quad |G| \leq 1.
$$

> **总结**：Crank-Nicolson 格式兼具二阶精度和无条件稳定性，是求解抛物型方程最流行的格式之一。其核心思想——在时间层之间"取平均"——是构造高精度隐格式的经典范式。

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

> **总结**：Richardson 格式虽然截断误差是 $O(\tau^2+h^2)$，但无论如何选取步长都不稳定——其原因在于使用了三个时间层（$n-1, n, n+1$）的信息，产生了"错位"的不稳定模式。这个例子深刻地说明了稳定性分析的重要性：**唯精度论是不可行的**。

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

> **总结**：Du Fort-Frankel 格式是对 Richardson 格式的成功修正——通过将 $u_j^n$ 替换为 $(u_j^{n+1}+u_j^{n-1})/2$ 消除了不稳定性，换来了无条件稳定。但代价是出现了**相容性问题**：其截断误差中含有 $\tau^2/h^2$ 项，要求 $\tau/h \to 0$ 时才相容。这意味着时间步长必须比空间步长衰减得更快——这是一个隐含的、但可能相当严重的限制。

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

---

本文聚焦于抛物型方程的稳定性分析，可以看到 Fourier 方法是一种非常强大、系统的方法。然而，不同类型方程的稳定性行为差异很大：抛物型方程往往"好脾气"（扩散效应自带稳定化），而双曲型方程则更需要小心对待。下一篇文章我们将转向**一阶双曲型方程**，在那里会遇到一个全新的概念——**CFL 条件**，它从几何的角度给出了稳定性的一个直观判据。

[← 网格剖分与差分格式建立](/posts/finite-difference/01-basic-concepts-and-schemes/) | [一阶双曲型方程与CFL条件 →](/posts/finite-difference/03-first-order-hyperbolic-equations/)
