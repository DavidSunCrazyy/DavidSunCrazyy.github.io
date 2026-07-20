---
note: true
layout: post
title: "Numerical Analysis I 非线性方程组迭代方法——Newton法与拟Newton法"
permalink: /posts/numerical-analysis-1/10-nonlinear-systems/
categories: numerical-analysis
tags: [numerical-analysis, nonlinear-systems, broyden, quasi-newton]
use_math: true
---

单变量 Newton 法可以自然推广到方程组。但直接推广面临两个新挑战：一是收敛性分析需要向量值函数的 Lipschitz 条件，二是每步都需要计算 Jacobi 矩阵，计算量很大。拟 Newton 法通过近似 Jacobi 矩阵来降低每步成本。本章先建立 $\mathbb{R}^n$ 上的压缩映射理论，再讨论 Newton 法及其变体。

## 5.4. 非线性方程组的不动点迭代法

设 $F: D \subset {\mathbb{R}}^{n} \rightarrow {\mathbb{R}}^{n}$ ,把方程组 $F\left( x\right) = 0$ 改写成

等价的不动点形式

$$
x = \Phi (x)
$$

$\Phi : D \subset \mathbb{R}^{n} \rightarrow \mathbb{R}^{n}$ 为连续函数.

相应的构造不动点迭代

$$
x ^ {k + 1} = \Phi (x ^ {k})
$$

**定义 5.4.1** 设 $\Phi: D \subset \mathbb{R}^{n} \to \mathbb{R}^{n}$ ，若存在 $L \in (0,1)$ 使得

$$
\| \Phi (y) - \Phi (x) \| \leq L \| x - y \|, \quad \forall x, y \in D _ {0} \subset D
$$

则称 $\Phi$ 在 $D_{0}$ 上是一个压缩映射

**定理 5.4.1** 设 $\Phi: D \subset \mathbb{R}^{n} \rightarrow \mathbb{R}^{n}$ ，如果 $\Phi$ 在凸域 $D_{0} \subset D$ 可导

$\Phi(x) = (\varphi_{1}(x), \varphi_{2}(x), \cdots, \varphi_{n}(x))^{\mathrm{T}}$ 满足 存在 $L \in (0,1)$

$$
\left| \frac {\partial \varphi_ {i} (x)}{\partial x _ {j}} \right| \leq \frac {L}{n}, \quad \forall x \in D _ {0}
$$

则 $\Phi$ 在 $D_{0}$ 上对 $\infty$ 范数是压缩的.

**证明：** $\forall x,y\in D_{0}$ 由微分中值定理

$$
\begin{array}{r l} {\Phi (y) - \Phi (x)} & {= \left[ \begin{array}{l} {\nabla \varphi_ {1} (x + \xi_ {1} h)} \\ {\nabla \varphi_ {2} (x + \xi_ {2} h)} \\ {\vdots} \\ {\nabla \varphi_ {n} (x + \xi_ {n} h)} \end{array} \right]} \end{array} \cdot h
$$

其中 $h = y - x,\; \xi_i \in (0,1),\;i = 1,2,\cdots,n$

$$
令 \quad A = [ a _ {i j} ] \in \mathbb {R} ^ {n \times n}, \quad a _ {i j} = \frac {\partial \varphi_ {i} (x + \xi_ {i} h)}{\partial x _ {j}}
$$

因为 $D_{0}$ 是凸集，所以 $x + \xi_{i}h \in D_{0}$ ， $i = 1,2,\dots,n$

$$
\| A \| _ {\infty} = \max _ {1 \leq i \leq n} \left(\sum_ {j = 1} ^ {n} \left| \frac {\partial \varphi_ {i} (x + \xi_ {i} h)}{\partial x _ {j}} \right|\right) \leq n \cdot \frac {L}{n} = L
$$

所以

$$
\| \Phi (y) - \Phi (x) \| _ {\infty} \leq \| A \| _ {\infty} \| y - x \| _ {\infty} \leq L \| y - x \| _ {\infty}
$$

**定理 5.4.2** $\Phi$: $D \subset \mathbb{R}^{n} \to \mathbb{R}^{n}$ , 在闭集 $D_{0} \subset D$ 中压缩且 $\Phi(x) \in D_{0}, \forall x \in D_{0}$ 则 $\Phi$ 在 $D_0$ 中存在唯一的不动点 $x^*$ ，且对任意 $x^{0} \in D_{0}$ ，不动点迭代收敛到 $x^{*}$ ，并

$$
\| x ^ {k} - x ^ {k} \| \leq \frac {1}{1 - L} \| x ^ {k + 1} - x ^ {k} \| \leq \frac {L ^ {k}}{1 - L} \| x ^ {1} - x ^ {0} \|
$$

**证明:** $\forall x^{0} \in D$ 。因为 $\Phi$ 把 $D_{0}$ 映为自身, 所以有

${x}^{k} \in {D}_{0}$ 并且

$$
\| x ^ {k + 1} - x ^ {k} \| = \| \Phi (x ^ {k}) - \Phi (x ^ {k - 1}) \| \leq L \| x ^ {k} - x ^ {k - 1} \|
$$

$$
\Rightarrow \left\| x ^ {k + 1} - x ^ {k} \right\| \leq L ^ {k} \left\| x ^ {1} - x ^ {0} \right\|
$$

$$
\begin{array}{r l} {\| x ^ {k + p} - x ^ {k} \| \leq \sum_ {j = 1} ^ {p} \| x ^ {k + j} - x ^ {k + j - 1} \|} \\ & {\leq (L ^ {p - 1} + \dots + L + 1) \| x ^ {k + 1} - x ^ {k} \|} \\ & {\leq \frac {1}{1 - L} \| x ^ {k + 1} - x ^ {k} \| \leq \frac {L ^ {k}}{1 - L} \| x ^ {1} - x ^ {0} \|} \end{array}
$$

由此可得 $\{x^{k}\}$ 为 Cauchy 列 所以存在

$x^{*} \in \mathbb{R}^{n}$ , 使得 $\lim _{k \to \infty} x^{k} = x^{*}$

又因为 $D_0$ 为闭集，有 $x^* \in D_0$ 。且

$$
x ^ {*} = \lim _ {k \to \infty} x ^ {k} = \lim _ {k \to \infty} \Phi (x ^ {k - 1}) = \Phi (x ^ {*})
$$

$\Phi$ 连续

**定义 5.4.2** $\Phi$: $D \subset \mathbb{R}^{n} \to \mathbb{R}^{n}$ , $x^{*}$ 为 $\Phi$ 的一个不动点, 若存在 $x^{*}$ 的一个邻域 $S \subset D$ , 对一切 $x^{0} \in S$ 迭代法产生的序列 $\{x^{k}\} \subset S$ , $\lim _{k \to \infty} x^{k} = x^{*}$ , 则称迭代法局部收敛

**定义 5.4.3.** 设向量序列 $\{x^{k}\}$ 收敛于 $x^{*}$ ，若存在 $P \geq 1$ 及 C > 0

使

$$
\lim _ {k \to \infty} \frac {\| x ^ {k + 1} - x ^ {*} \|}{\| x ^ {k} - x ^ {*} \| ^ {p}} = c
$$

则称 $\{x^{k}\}$ $p$ 阶收敛。若存在 $p \geq 1$ 及 $c > 0$ , 以及整数 $k > 0$ , 使得当 $k > k$ 时 ${\left\| {x}^{k + 1} - {x}^{ * }\right\| } \leq C{\left\| {x}^{k} - {x}^{ * }\right\| }^{p}$

则称 $\{x^{k}\}$ 至少 $p$ 阶收敛

**定理 5.4.3** 设 $\Phi$: $D \subset \mathbb{R}^{n} \to \mathbb{R}^{n}$ , $x^{*} \in D$ 是 $\Phi$ 的不动点.

且 $\Phi$ 在 $x^{*}$ 可导满足

$$
\rho (\Phi^ {\prime} (x ^ {*})) = \sigma < 1
$$

则存在开球 $S = S(x^{*}, s) \subset D$ ， $\forall x^{0} \in S$ ，迭代法产生的序列 $\{x^{k}\}$ 收敛到 $x^{*}$

## 5.5. 方程组的 Newton 法和拟 Newton 法

现在将 Newton 法从单变量推广到方程组。设

$$
F(x) = \begin{pmatrix} f_1(x_1, \dots, x_n) \\ f_2(x_1, \dots, x_n) \\ \vdots \\ f_n(x_1, \dots, x_n) \end{pmatrix} = 0, \quad F: \mathbb{R}^n \to \mathbb{R}^n
$$

**符号说明：** 与单变量情形有两个重要区别：

1. **Jacobi 矩阵：** $F'(x)$ 不再表示标量导数，而是 $n \times n$ 的 **Jacobi 矩阵**：

$$
F'(x) = \begin{bmatrix}
\frac{\partial f_1}{\partial x_1} & \frac{\partial f_1}{\partial x_2} & \cdots & \frac{\partial f_1}{\partial x_n} \\
\frac{\partial f_2}{\partial x_1} & \frac{\partial f_2}{\partial x_2} & \cdots & \frac{\partial f_2}{\partial x_n} \\
\vdots & \vdots & \ddots & \vdots \\
\frac{\partial f_n}{\partial x_1} & \frac{\partial f_n}{\partial x_2} & \cdots & \frac{\partial f_n}{\partial x_n}
\end{bmatrix} \in \mathbb{R}^{n \times n}
$$

2. **迭代指标用上标：** $x^k = (x_1^k, \dots, x_n^k)^T$ 表示第 $k$ 步迭代向量，下标留给分量编号。这与单变量时用 $x_k$ 的习惯不同，但在向量情形是标准记法。

设 $x^k$ 是当前近似解，在 $x^k$ 处对 $F$ 做一阶 Taylor 展开：

$$
0 = F(x^*) \approx F(x^k) + F'(x^k)(x^* - x^k)
$$

这里 $F'(x^k)(x^* - x^k)$ 是 Jacobi 矩阵与向量的乘法。将上式视为关于 $x^*$ 的线性方程组：

$$
F'(x^k)(x^* - x^k) \approx -F(x^k)
$$

若 $F'(x^k)$ 可逆，则解得下一个近似解 $x^{k+1}$：

$$
x^{k+1} = x^k - \left(F'(x^k)\right)^{-1} F(x^k) \tag{5.5.1}
$$

**实际计算时**并不直接求逆，而是每步解线性方程组 $F'(x^k) \Delta x^k = -F(x^k)$，然后令 $x^{k+1} = x^k + \Delta x^k$。这正是单变量 Newton 公式 $x_{k+1} = x_k - f(x_k)/f'(x_k)$ 的直接推广。

**定理 5.5.1**（方程组 Newton 法的局部收敛性）设

- $F: D \subset \mathbb{R}^n \to \mathbb{R}^n$，$x^* \in D$ 满足 $F(x^*) = 0$；
- 存在 $x^*$ 的开邻域 $S_0 \subset D$，在 $S_0$ 上 $F$ 可导，$F'(x)$ 连续；
- $F'(x^*)$ 可逆。

则以下结论成立：

**(1)** 存在闭球 $\bar{S} = B(x^*, \delta) \subset S_0$，使得 Newton 迭代对任意 $x^0 \in \bar{S}$ 有意义（即每步 $F'(x^k)$ 可逆）。

**(2)** Newton 法产生的序列 $\{x^k\}$ 局部收敛于 $x^*$，且是**超线性收敛**的。

**(3)** 若进一步存在常数 $\gamma > 0$ 使得 $F'$ 在 $x^*$ 附近满足 **Lipschitz 条件**：

$$
\| F'(x) - F'(x^*) \| \leq \gamma \| x - x^* \|, \quad \forall x \in S_0
$$

则 $\{x^k\}$ **至少平方收敛**。

**证明：** 

**(1)** 因为 $F'(x^*)$ 可逆，令 $\alpha = \|F'(x^*)^{-1}\|$（取从属矩阵范数）。

$F'(x)$ 在 $x^*$ 处连续，故存在 $\delta > 0$ 使得 $\forall x \in B(x^*, \delta) \subset S_0$ 有

$$
\| F'(x) - F'(x^*) \| < \frac{1}{2\alpha}
$$

下面证明在此球内 $F'(x)$ 也可逆。将 $F'(x)$ 写为扰动形式：

$$
F'(x) = F'(x^*) \left[ I + F'(x^*)^{-1}\big(F'(x) - F'(x^*)\big) \right]
$$

令 $E = F'(x^*)^{-1}(F'(x) - F'(x^*))$，则

$$
\|E\| \leq \|F'(x^*)^{-1}\| \cdot \|F'(x) - F'(x^*)\| < \alpha \cdot \frac{1}{2\alpha} = \frac{1}{2} < 1
$$

由 **Banach 扰动引理**（Neumann 级数），当 $\|E\| < 1$ 时 $I + E$ 可逆，且 $\|(I + E)^{-1}\| \leq \frac{1}{1 - \|E\|}$。因此 $F'(x) = F'(x^*)(I + E)$ 可逆，并且

$$
\| F'(x)^{-1} \| = \| (I + E)^{-1} F'(x^*)^{-1} \| \leq \frac{\|F'(x^*)^{-1}\|}{1 - \|E\|} \leq \frac{\alpha}{1 - \frac{1}{2}} = 2\alpha, \quad \forall x \in B(x^*, \delta)
$$

取 $\bar{S} = B(x^*, \delta)$，结论 (1) 得证。

**(2)** 先建立误差的基本估计。由 Newton 迭代公式 (5.5.1)：

$$
\begin{aligned}
x^{k+1} - x^* &= x^k - F'(x^k)^{-1} F(x^k) - x^* \\
&= -F'(x^k)^{-1} \Big[ F(x^k) + F'(x^k)(x^* - x^k) \Big]
\end{aligned}
$$

取范数并利用 (1) 中得到的界 $\|F'(x^k)^{-1}\| \leq 2\alpha$（当 $x^k \in B(x^*, \delta)$ 时）：

$$
\begin{aligned}
\|x^{k+1} - x^*\| &= \Big\| F'(x^k)^{-1} \big( F(x^k) + F'(x^k)(x^* - x^k) \big) \Big\| \\
&\leq 2\alpha \; \big\| F(x^*) - F(x^k) - F'(x^k)(x^* - x^k) \big\| \quad (\text{因为 } F(x^*) = 0)
\end{aligned}
$$

将上式括号中的量拆分为两项——一项用 $F'(x^*)$（已知存在）衡量 Taylor 展开误差，另一项衡量 $F'$ 的变化：

$$
\begin{aligned}
&\big\| F(x^*) - F(x^k) - F'(x^k)(x^* - x^k) \big\| \\
=\; &\big\| F(x^*) - F(x^k) - F'(x^*)(x^* - x^k) + \big(F'(x^*) - F'(x^k)\big)(x^* - x^k) \big\| \\
\leq\; &\| F(x^k) - F(x^*) - F'(x^*)(x^k - x^*) \| \;+\; \|F'(x^*) - F'(x^k)\| \cdot \|x^k - x^*\|
\end{aligned}
$$

其中最后一步用了三角不等式。综合以上得核心估计：

$$
\|x^{k+1} - x^*\| \leq 2\alpha \, \| F(x^k) - F(x^*) - F'(x^*)(x^k - x^*) \| \;+\; 2\alpha \, \|F'(x^*) - F'(x^k)\| \cdot \|x^k - x^*\| \tag{*}
$$

下面利用 $F$ 的可导性控制这两项。由 $F'(x^*)$ 的定义，$\forall \varepsilon > 0$，$\exists \delta_1(\varepsilon) > 0$ 使得 $\forall x \in B(x^*, \delta_1(\varepsilon))$：

$$
\| F(x) - F(x^*) - F'(x^*)(x - x^*) \| \leq \varepsilon \| x - x^* \|
$$

由 $F'(x)$ 在 $x^*$ 的连续性，$\exists \delta_2(\varepsilon) > 0$ 使得 $\forall x \in B(x^*, \delta_2(\varepsilon))$：

$$
\| F'(x) - F'(x^*) \| \leq \varepsilon
$$

取 $\varepsilon = \frac{1}{8\alpha}$，令 $\tilde{\delta} = \min\left\{\delta_1(\frac{1}{8\alpha}),\; \delta_2(\frac{1}{8\alpha})\right\}$。若 $x^k \in B(x^*, \tilde{\delta})$，将两个 $\varepsilon$-界代入 $(*)$ 式：

$$
\begin{aligned}
\|x^{k+1} - x^*\| &\leq 2\alpha \cdot \frac{1}{8\alpha} \|x^k - x^*\| \;+\; 2\alpha \cdot \frac{1}{8\alpha} \|x^k - x^*\| \\
&= \frac{1}{2} \|x^k - x^*\|
\end{aligned}
$$

这表明 $\|x^{k+1} - x^*\| \leq \frac{1}{2} \|x^k - x^*\|$，因此一旦 $x^0 \in B(x^*, \tilde{\delta})$，整个序列停留在球内且 $\lim_{k \to \infty} x^k = x^*$，即**局部收敛**。

为证**超线性收敛**，需要更精细的分析。由于 $x^k \to x^*$，对任意 $\varepsilon > 0$，存在 $N > 0$ 使得 $\forall k > N$：

$$
\|x^k - x^*\| < \min\left\{ \delta_1\Big(\frac{\varepsilon}{4\alpha}\Big),\; \delta_2\Big(\frac{\varepsilon}{4\alpha}\Big) \right\}
$$

此时 $x^k$ 满足两个 $\varepsilon$-界（以 $\varepsilon/(4\alpha)$ 为精度），回代 $(*)$ 式：

$$
\|x^{k+1} - x^*\| \leq 2\alpha \cdot \frac{\varepsilon}{4\alpha} \|x^k - x^*\| \;+\; 2\alpha \cdot \frac{\varepsilon}{4\alpha} \|x^k - x^*\| = \varepsilon \|x^k - x^*\|
$$

由于 $\varepsilon > 0$ 可任意小，$\forall k > N$ 有 $\frac{\|x^{k+1} - x^*\|}{\|x^k - x^*\|} \leq \varepsilon$，因此

$$
\lim_{k \to \infty} \frac{\|x^{k+1} - x^*\|}{\|x^k - x^*\|} = 0
$$

即 $\{x^k\}$ **超线性收敛**。

**(3)** 现在加上 $F'$ 的 Lipschitz 条件，证明平方收敛。核心思路是用积分形式的 Taylor 余项来得到 $\|x^k - x^*\|^2$ 阶的界。

引入辅助函数 $g(t) = F(x^* + t(x^k - x^*))$，$t \in [0,1]$。由链式法则：

$$
g'(t) = F'(x^* + t(x^k - x^*)) (x^k - x^*)
$$

首先估计 $g'(t)$ 与 $g'(0)$ 的差。利用 Lipschitz 条件：

$$
\begin{aligned}
\|g'(t) - g'(0)\| &= \big\| \big[ F'(x^* + t(x^k - x^*)) - F'(x^*) \big] (x^k - x^*) \big\| \\
&\leq \| F'(x^* + t(x^k - x^*)) - F'(x^*) \| \cdot \|x^k - x^*\| \\
&\leq \gamma \cdot t\|x^k - x^*\| \cdot \|x^k - x^*\| = \gamma t \|x^k - x^*\|^2
\end{aligned}
$$

其中 Lipschitz 条件给出 $\|F'(x^* + t(x^k - x^*)) - F'(x^*)\| \leq \gamma \|t(x^k - x^*)\| = \gamma t \|x^k - x^*\|$。

现在用积分表示 $F(x^k) - F(x^*)$ 的 Taylor 余项：

$$
\begin{aligned}
\| F(x^k) - F(x^*) - F'(x^*)(x^k - x^*) \|
&= \|g(1) - g(0) - g'(0)\| \\
&= \Big\| \int_0^1 \big(g'(t) - g'(0)\big) \, dt \Big\| \\
&\leq \int_0^1 \|g'(t) - g'(0)\| \, dt \\
&\leq \int_0^1 \gamma t \|x^k - x^*\|^2 \, dt = \frac{1}{2} \gamma \|x^k - x^*\|^2
\end{aligned}
$$

这个 $\frac{1}{2}\gamma\|x^k - x^*\|^2$ 的估计是平方收敛的关键——它比线性估计 $\varepsilon\|x^k - x^*\|$ 高了一阶。

将此估计代入证明 (2) 中的核心不等式 $(*)$，并注意当 $x^k \in B(x^*, \tilde{\delta})$ 时 $\|F'(x^k)^{-1}\| \leq 2\alpha$：

$$
\begin{aligned}
\|x^{k+1} - x^*\| &\leq
\underbrace{2\alpha \cdot \frac{1}{2}\gamma \|x^k - x^*\|^2}_{\text{Taylor 余项估计}} \;+\;
\underbrace{2\alpha \cdot \gamma \|x^k - x^*\| \cdot \|x^k - x^*\|}_{\text{Lipschitz 条件}} \\[4pt]
&= \alpha\gamma \|x^k - x^*\|^2 + 2\alpha\gamma \|x^k - x^*\|^2 \\[4pt]
&= 3\alpha\gamma \|x^k - x^*\|^2
\end{aligned}
$$

其中第二项用到 Lipschitz 条件：$\|F'(x^*) - F'(x^k)\| \leq \gamma \|x^k - x^*\|$。

令 $C = 3\alpha\gamma$，则 $\|x^{k+1} - x^*\| \leq C \|x^k - x^*\|^2$，故 $\{x^k\}$ **至少二阶（平方）收敛**。$\square$

**例 5.5.1**（2 维 Newton 法）求解方程组

$$
\begin{cases}
x_1^2 + x_2^2 = 4 \\
x_1^2 - x_2^2 = 1
\end{cases}
$$

首先写出 $F(x)$ 和 Jacobi 矩阵 $F'(x)$：

$$
F(x) = \begin{pmatrix} x_1^2 + x_2^2 - 4 \\ x_1^2 - x_2^2 - 1 \end{pmatrix}, \quad
F'(x) = \begin{bmatrix} 2x_1 & 2x_2 \\ 2x_1 & -2x_2 \end{bmatrix}
$$

取初始值 $x^0 = (2, 1)^T$，则 $F(x^0) = (1, 2)^T$。第一步迭代：

$$
F'(x^0) = \begin{bmatrix} 4 & 2 \\ 4 & -2 \end{bmatrix}, \quad
\Delta x^0 = -F'(x^0)^{-1} F(x^0) = -\begin{bmatrix} 4 & 2 \\ 4 & -2 \end{bmatrix}^{-1} \begin{pmatrix} 1 \\ 2 \end{pmatrix}
$$

解线性方程组 $F'(x^0) \Delta x^0 = -F(x^0)$：

$$
4 \Delta x_1 + 2 \Delta x_2 = -1, \quad 4 \Delta x_1 - 2 \Delta x_2 = -2
$$

解得 $\Delta x^0 = (-0.375, 0.25)^T$，故

$$
x^1 = x^0 + \Delta x^0 = (1.625, 1.25)^T
$$

验证：$F(x^1) \approx (0.203, -0.078)^T$，残差已显著减小。继续迭代即可收敛到精确解 $x^* = (\sqrt{2.5}, \sqrt{1.5})^T \approx (1.581, 1.225)^T$。

这个例子展示了 Newton 法的实际计算流程：**每步计算 Jacobi 矩阵 → 求解线性方程组 → 更新迭代向量**。当 $n$ 很大时，前两步的代价（$O(n^3)$）成为瓶颈，这就引出了下面要讨论的拟 Newton 法。

### 拟 Newton 法

Newton 法虽然收敛快，但每步需要：
1. 计算 $n^2$ 个偏导数构成 Jacobi 矩阵 $F'(x^k)$；
2. 求解 $n$ 元线性方程组 $F'(x^k) \Delta x^k = -F(x^k)$。

这两步的代价均为 $O(n^3)$（或 $O(n^2)$ 当 Jacobi 矩阵稀疏时），对大规模问题难以承受。

**拟 Newton 法（Quasi-Newton Method）** 的基本思想：用某个矩阵 $A_k$ 近似 $F'(x^k)$，然后通过**低秩更新**从 $A_k$ 得到 $A_{k+1}$，避免每步重新计算 Jacobi 矩阵。迭代格式为：

$$
x^{k+1} = x^k - A_k^{-1} F(x^k) \tag{5.5.2}
$$

其中 $A_k \in \mathbb{R}^{n \times n}$ 是 $F'(x^k)$ 的近似。$A_k$ 的更新需要满足两个自然的要求：

1. **低秩修正：** $A_{k+1} = A_k + \Delta A_k$，其中 $\Delta A_k$ 是某个低秩矩阵（计算代价小）；
2. **割线条件（Secant Condition）：** 

$$
A_{k+1}(x^{k+1} - x^k) = F(x^{k+1}) - F(x^k) \tag{5.5.3}
$$

割线条件是对单变量割线法的直接推广。在标量情形下，割线法用差商 $\frac{f(x_{k+1}) - f(x_k)}{x_{k+1} - x_k}$ 近似 $f'(x_{k+1})$，即要求 $A_{k+1} \cdot (x_{k+1} - x_k) = f(x_{k+1}) - f(x_k)$。这里 (5.5.3) 正是其在向量情形下的自然推广——但此时一个方程不足以唯一确定 $A_{k+1}$（$n^2$ 个未知量，$n$ 个方程），需要额外准则。

**Broyden 秩 1 方法** 的想法：在满足割线条件的所有矩阵中，选择使修正量 $\Delta A_k$ 的 Frobenius 范数最小的那个。这相当于对当前近似 $A_k$ 做"最小的改动"以适应新信息。引入记号

$$
p^k = x^{k+1} - x^k, \quad q^k = F(x^{k+1}) - F(x^k)
$$

则优化问题为：

$$
\begin{aligned}
\Delta A_k &= \operatorname{argmin}_{A \in \mathbb{R}^{n \times n}} \|A\|_F \\
\text{s.t.} \quad &(A_k + A) p^k = q^k
\end{aligned}
$$

令 $\tilde{q}^k = q^k - A_k p^k$，约束变为 $A p^k = \tilde{q}^k$。用 Lagrange 乘子法可解得：

$$
A = \frac{\tilde{q}^k (p^k)^T}{\|p^k\|_2^2} = \frac{(q^k - A_k p^k)(p^k)^T}{\|p^k\|_2^2}
$$

该解的秩为 1，即 **Broyden 秩 1 更新**。

综上，**Broyden 秩 1 方法** 的完整迭代步骤为：

$$
\boxed{
\begin{aligned}
x^{k+1} &= x^k - A_k^{-1} F(x^k) \\
p^k &= x^{k+1} - x^k, \quad q^k = F(x^{k+1}) - F(x^k) \\
A_{k+1} &= A_k + \frac{(q^k - A_k p^k)(p^k)^T}{\|p^k\|_2^2}
\end{aligned}}
$$

每步代价：更新 $A_k$ 只需 $O(n^2)$（秩 1 外积），无需重算 Jacobi 矩阵。但仍需求解 $A_k^{-1} F(x^k)$（$O(n^3)$），这个瓶颈可以通过下面的逆 Broyden 方法消除。

### 逆 Broyden 秩 1 方法

与其存储 $A_k$ 并在每步求解线性方程组，不如直接存储并更新 $A_k$ 的逆矩阵。令

$$
B_k = A_k^{-1} \quad (\text{近似 } F'(x^k)^{-1})
$$

则迭代退化为矩阵-向量乘法：

$$
x^{k+1} = x^k - B_k F(x^k) \tag{5.5.4}
$$

现在需要 $B_{k+1}$ 的更新公式。利用 **Sherman-Morrison 公式**（秩 1 扰动的求逆公式）：

**引理 5.5.1**（Sherman–Morrison）设 $A \in \mathbb{R}^{n \times n}$ 非奇异，$u, v \in \mathbb{R}^n$。当且仅当 $1 + v^T A^{-1} u \neq 0$ 时，$A + uv^T$ 可逆，且

$$
(A + uv^T)^{-1} = A^{-1} - \frac{A^{-1} uv^T A^{-1}}{1 + v^T A^{-1} u}
$$

（更一般地有 **Woodbury 公式**，将秩 1 扰动推广为秩 $k$ 扰动：$(A + U C V^T)^{-1} = A^{-1} - A^{-1} U (C^{-1} + V^T A^{-1} U)^{-1} V^T A^{-1}$，这里暂不需要。）

对 Broyden 更新式 $A_{k+1} = A_k + \frac{(q^k - A_k p^k)(p^k)^T}{\|p^k\|_2^2}$ 应用 Sherman-Morrison 公式，取

$$
u = \frac{q^k - A_k p^k}{\|p^k\|_2^2}, \quad v = p^k
$$

代入计算 $B_{k+1} = A_{k+1}^{-1}$，整理后得 **逆 Broyden 秩 1 方法**：

$$
\boxed{
\begin{aligned}
x^{k+1} &= x^k - B_k F(x^k) \\
p^k &= x^{k+1} - x^k, \quad q^k = F(x^{k+1}) - F(x^k) \\
B_{k+1} &= B_k + \frac{(p^k - B_k q^k)(p^k)^T B_k}{(p^k)^T B_k q^k}
\end{aligned}}
$$

**计算优势：** 每步只需 $O(n^2)$ 的矩阵-向量乘法和秩 1 更新，完全避免了求解线性方程组的 $O(n^3)$ 开销。这使得拟 Newton 法在大规模非线性方程组求解中非常实用。

初始矩阵通常取 $A_0 = F'(x^0)$（第一步仍算 Jacobi）或 $A_0 = I$，对应的 $B_0 = F'(x^0)^{-1}$ 或 $B_0 = I$。

---

**本章小结：** 本章将非线性方程求解从单变量推广到方程组。核心结论：Newton 法在向量情形同样具有局部二阶收敛性，关键条件是 $F'(x^*)$ 可逆且 $F'$ 满足 Lipschitz 条件。证明思路与标量情形类似——利用 Taylor 展开和范数估计，但需要 Banach 扰动引理来保证 Jacobi 矩阵在 $x^*$ 附近的可逆性。

拟 Newton 法解决了 Newton 法在高维时的计算瓶颈。Broyden 秩 1 方法通过最小 Frobenius 范数修正来更新 Jacobi 近似，割线条件 $A_{k+1} p^k = q^k$ 是标量割线法的直接推广。逆 Broyden 方法利用 Sherman-Morrison 公式直接更新 $F'(x^k)^{-1}$ 的近似 $B_k$，将每步代价从 $O(n^3)$ 降至 $O(n^2)$，是工程实践中的常用方案。

下一章我们转向特征值问题——数值代数中另一个核心课题。

[← 上一篇：Newton迭代法](/posts/numerical-analysis-1/09-newton-method/)

[下一篇：幂法 →](/posts/numerical-analysis-1/11-power-method/)
