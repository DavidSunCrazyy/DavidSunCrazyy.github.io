---
note: true
layout: post
title: "Numerical Analysis I 对称矩阵特征值的计算——Jacobi方法与二分法"
permalink: /posts/numerical-analysis-1/13-symmetric-eigenvalue/
categories: numerical-analysis
tags: [numerical-analysis, symmetric-eigenvalue, jacobi-method, bisection-method]
use_math: true
---

QR 方法是求解一般矩阵特征值的通用方法。对于对称矩阵，由于特征值都是实数且特征向量可以正交归一，存在更高效的专用算法。本章介绍三种对称特征值问题的经典方法：Rayleigh 商迭代（局部收敛快）、Jacobi 方法（通过正交旋转逐步对角化）和二分法（适合求解部分特征值）。

## 6.4. 对称矩阵特征值的计算

### 6.4.1 Rayleigh 商迭代

对 $A \in \mathbb{C}^{n \times n}$ 和非零向量 $x \in \mathbb{C}^n$，定义

$$
R(x) = \frac{(Ax, x)}{(x, x)}
$$

称为关于 $A$ 和 $x$ 的 **Rayleigh 商**。如果 $x$ 是 $A$ 的特征向量，则 $R(x)$ 就是对应的特征值；如果 $x$ 只是近似特征向量，$R(x)$ 给出了特征值的最佳最小二乘估计。Rayleigh 商迭代就是将逆幂法的位移取为当前的 Rayleigh 商，从而获得极快的局部收敛：

$$
\begin{aligned}
&v^{(0)} \in \mathbb{R}^n, \quad \|v^{(0)}\|_2 = 1 \\
&\text{for } k = 0, 1, \dots: \\
&\qquad \mu_k = R(v^{(k)}) \\
&\qquad (A - \mu_k I) y^{(k+1)} = v^{(k)} \\
&\qquad v^{(k+1)} = y^{(k+1)} / \|y^{(k+1)}\|_2
\end{aligned}
$$

可以证明，对称矩阵的 Rayleigh 商迭代具有**立方收敛**速度：每步迭代的正确位数大约翻三倍。代价是每步需要求解一个不同的线性方程组（位移 $\mu_k$ 在变化），无法像普通逆幂法那样复用 LU 分解。

### 6.4.2. Jacobi 方法

Jacobi 方法的基本思路非常直观：反复选取非对角元中绝对值最大的那个，通过一个正交旋转将其消为零。虽然后续的旋转可能会重新引入非零元，但非对角元的总能量（$\text{off}(A)$）严格递减，矩阵最终收敛到对角形。

设 $A = [a_{ij}] \in \mathbb{R}^{n \times n}$ 对称，定义非对角元的平方和：

$$
\text{off}(A) = \sum_{i=1}^{n} \sum_{\substack{j=1 \\ j \neq i}}^{n} |a_{ij}|^2
$$

$\text{off}(A) = 0$ 当且仅当 $A$ 为对角矩阵。

考虑一个 $2 \times 2$ 的 Givens 旋转 $J = J(p, q, \theta)$（$p < q$），它仅在 $(p,p), (p,q), (q,p), (q,q)$ 四个位置与单位矩阵不同：

$$
J(p,q,\theta) = \begin{bmatrix}
\cos\theta & -\sin\theta \\
\sin\theta & \cos\theta
\end{bmatrix}
\text{（位于第 $p,q$ 行/列交叉处）}
$$

令 $B = J A J^{-1}$，记 $c = \cos\theta$，$s = \sin\theta$。由于 $J^{-1} = J^T$，这是正交相似变换。$B$ 的元素变化只涉及第 $p, q$ 行和列：

$$
\begin{aligned}
b_{pp} &= a_{pp} c^2 + a_{qq} s^2 + a_{pq} \sin 2\theta \\
b_{qq} &= a_{pp} s^2 + a_{qq} c^2 - a_{pq} \sin 2\theta \\
b_{pq} = b_{qp} &= \frac{1}{2}(a_{qq} - a_{pp}) \sin 2\theta + a_{pq} \cos 2\theta \\
b_{ip} = b_{pi} &= a_{ip} c + a_{iq} s \quad (i \neq p, q) \\
b_{iq} = b_{qi} &= -a_{ip} s + a_{iq} c \quad (i \neq p, q) \\
b_{ij} &= a_{ij} \quad (i \neq p,q,\; j \neq p,q)
\end{aligned}
$$

容易验证对角元的平方和与 $(p,q)$ 元素的平方和保持不变：

$$
b_{pp}^2 + b_{qq}^2 + 2b_{pq}^2 = a_{pp}^2 + a_{qq}^2 + 2a_{pq}^2
$$

结合 $\|B\|_F = \|A\|_F$（正交相似变换保 $F$-范数），可得

$$
\begin{aligned}
\text{off}(B) &= \|B\|_F^2 - \sum_{i=1}^{n} b_{ii}^2 \\
&= \|A\|_F^2 - \sum_{\substack{i=1 \\ i \neq p,q}}^{n} a_{ii}^2 - (b_{pp}^2 + b_{qq}^2) \\
&= \text{off}(A) - 2a_{pq}^2 + 2b_{pq}^2
\end{aligned}
$$

为使 $\text{off}(B)$ 尽可能小，我们选择 $\theta$ 使得 $b_{pq} = 0$（此时 $\text{off}(B)$ 达到极小）。由公式 $b_{pq} = \frac{1}{2}(a_{qq} - a_{pp}) \sin 2\theta + a_{pq} \cos 2\theta = 0$ 得

$$
\cot 2\theta = \frac{a_{pp} - a_{qq}}{2a_{pq}} = \tau
$$

令 $t = \tan\theta$，由倍角公式 $\cot 2\theta = \frac{1-t^2}{2t}$ 可得 $t$ 满足

$$
t^2 + 2t\tau - 1 = 0 \tag{6.4.1}
$$

该二次方程有两个根，乘积为 $-1$。取绝对值较小的根（对应 $|\theta| \leq \frac{\pi}{4}$，保证数值稳定）：

$$
t = \frac{\operatorname{sgn}(\tau)}{|\tau| + \sqrt{1 + \tau^2}} \tag{6.4.2}
$$

然后取 $c = \frac{1}{\sqrt{1 + t^2}}$，$s = tc$。这样就得到了一步 Jacobi 旋转的全部参数。

**经典 Jacobi 方法**每步选取绝对值最大的非对角元：

$$
|a_{pq}| = \max_{1 \leq i < j \leq n} |a_{ij}| \tag{6.4.4}
$$

迭代格式为 $A_k = J_k^T A_{k-1} J_k$，其中 $J_k$ 由 (6.4.1)–(6.4.4) 确定。

**引理 6.4.1** (Weyl 扰动定理) 设 $A, E$ 均为 $n$ 阶对称矩阵，$A, E, A+E$ 的特征值排序为

$$
\begin{aligned}
\lambda_1 &\geq \lambda_2 \geq \cdots \geq \lambda_n \\
\nu_1 &\geq \nu_2 \geq \cdots \geq \nu_n \\
\mu_1 &\geq \mu_2 \geq \cdots \geq \mu_n
\end{aligned}
$$

则有 $\lambda_i + \nu_n \leq \mu_i \leq \lambda_i + \nu_i$，$i = 1, 2, \dots, n$。

**证明：** 记 $x_1, \dots, x_n$ 为 $A$ 的特征向量，令 $W_i = \operatorname{span}\{x_1, \dots, x_i\}$。由 Courant-Fischer 极小极大原理，

$$
\begin{aligned}
\mu_i &\geq \min_{x \in W_i} \frac{((A+E)x, x)}{(x, x)}
      \geq \min_{x \in W_i} \frac{(Ax, x)}{(x, x)} + \min_{x \neq 0} \frac{(Ex, x)}{(x, x)} \\
      &\geq \lambda_i + \nu_n
\end{aligned}
$$

同理可证 $\mu_i \leq \lambda_i + \nu_i$。直观理解：扰动 $E$ 的每个特征值对 $A$ 的特征值偏移的贡献被夹在 $\nu_n$ 和 $\nu_1$ 之间。

**定理 6.4.1** 存在 $A$ 的特征值的一个排列 $\lambda_1, \dots, \lambda_n$，使得

$$
\lim_{k \to \infty} A_k = \operatorname{diag}(\lambda_1, \dots, \lambda_n)
$$

**证明：** 由 $b_{pq}=0$ 时 $\text{off}(A_{k+1}) = \text{off}(A_k) - 2(a_{pq}^{(k)})^2$，且 $|a_{pq}^{(k)}|$ 是最大的非对角元，故

$$
2(a_{pq}^{(k)})^2 \geq \frac{2}{n(n-1)} \text{off}(A_k)
$$

从而 $\text{off}(A_{k+1}) \leq \bigl(1 - \frac{1}{N}\bigr) \text{off}(A_k)$，其中 $N = \frac{n(n-1)}{2}$。由此得 $\lim_{k \to \infty} \text{off}(A_k) = 0$——非对角元整体趋于零。

接下来证明对角元收敛到特征值。令 $E(A) = (\text{off}(A))^{1/2}$（非对角元的 2-范数），记 $\delta = \min\{|\mu - \lambda| : \lambda, \mu \in \sigma(A), \lambda \neq \mu\}$ 为不同特征值间的最小距离。

任取 $\varepsilon < \frac{\delta}{4}$，由 $\text{off}(A_k) \to 0$ 知存在 $k_0$ 使得 $E(A_k) < \varepsilon$。由引理 6.4.1，存在排列 $\lambda_1, \dots, \lambda_n$ 使得

$$
|\lambda_i - a_{ii}^{(k_0)}| \leq E(A_{k_0}) < \varepsilon < \frac{\delta}{4}, \quad i = 1, \dots, n
$$

接下来用归纳法证明 $\forall k > k_0$ 有 $|\lambda_i - a_{ii}^{(k)}| < \varepsilon$。只需分析从 $k_0$ 到 $k_0+1$ 这一步。设第 $k_0$ 步旋转的是 $(p, q)$ 位置，利用 $t = \tan\theta$ 和关系 $a_{qq}^{(k_0)} - a_{pp}^{(k_0)} = t^{-1}(1 - t^2) a_{pq}^{(k_0)}$（由 $b_{pq}=0$ 导出），

$$
\begin{aligned}
a_{pp}^{(k_0+1)} &= a_{pp}^{(k_0)} + c^2\bigl(-2t a_{pq}^{(k_0)} + t^2(a_{qq}^{(k_0)} - a_{pp}^{(k_0)})\bigr) \\
&= a_{pp}^{(k_0)} + c^2\bigl(-2t a_{pq}^{(k_0)} + t(1-t^2)a_{pq}^{(k_0)}\bigr) \\
&= a_{pp}^{(k_0)} - t a_{pq}^{(k_0)} \\[4pt]
a_{qq}^{(k_0+1)} &= a_{qq}^{(k_0)} + t a_{pq}^{(k_0)}
\end{aligned}
$$

$\forall \lambda_j \neq \lambda_p$，利用 $|t| \leq 1$（因为 $|\theta| \leq \pi/4$）：

$$
\begin{aligned}
|a_{pp}^{(k_0+1)} - \lambda_j|
&\geq |\lambda_p - \lambda_j| - |a_{pp}^{(k_0)} - \lambda_p| - |t a_{pq}^{(k_0)}| \\
&\geq \delta - 2\varepsilon \geq 2\varepsilon
\end{aligned}
$$

这意味着 $a_{pp}^{(k_0+1)}$ 不会「跳」到其他特征值附近。因此 $|a_{pp}^{(k_0+1)} - \lambda_p| < \varepsilon$，同理 $|a_{qq}^{(k_0+1)} - \lambda_q| < \varepsilon$。归纳完成，对角元确实收敛到特征值。

### 6.4.3 二分法

Jacobi 方法求出全部特征值。如果只需要部分特征值（如最小几个），二分法利用 Sturm 序列的性质将问题化为计算特征多项式的变号次数，效率更高。

首先利用对称矩阵的特殊结构：$A \in \mathbb{R}^{n \times n}$ 对称可通过正交相似变换（如 Householder 约化）化为不可约对称三对角矩阵 $T$：

$$
Q A Q^T = T = \begin{bmatrix}
\alpha_1 & \beta_2 & & & \\
\beta_2 & \alpha_2 & \beta_3 & & \\
& \ddots & \ddots & \ddots & \\
& & \ddots & \ddots & \beta_n \\
& & & \beta_n & \alpha_n
\end{bmatrix}
$$

以下设 $\beta_i \neq 0$（$i = 2, \dots, n$），即 $T$ 不可约。记 $P_i(\lambda)$ 为 $T - \lambda I$ 的 $i$ 阶顺序主子式，有三项递推关系：

$$
P_0(\lambda) = 1, \quad P_1(\lambda) = \alpha_1 - \lambda
$$

$$
P_i(\lambda) = (\alpha_i - \lambda) P_{i-1}(\lambda) - \beta_i^2 P_{i-2}(\lambda), \quad i = 2, \dots, n \tag{6.4.1}
$$

由于 $T$ 实对称，$P_i(\lambda)$ 的根全是实数。$\{P_i(\lambda)\}$ 构成了一个 **Sturm 序列**，具有以下基本性质。

**定理 6.4.2**

1. 存在 $M > 0$ 使得当 $\lambda > M$ 时，$P_i(-\lambda) > 0$ 且 $\operatorname{sgn}(P_i(\lambda)) = (-1)^i$
2. $P_{i-1}(\lambda)$ 与 $P_i(\lambda)$ 无公共根
3. 若 $P_i(\mu) = 0$，则 $P_{i-1}(\mu) P_{i+1}(\mu) < 0$
4. $P_i(\lambda)$ 的根全是单根，且 $P_i(\lambda)$ 的根严格分隔 $P_{i+1}(\lambda)$ 的根

**证明：** (1) $P_i(\lambda)$ 是 $i$ 次多项式，首项为 $(-1)^i \lambda^i$，当 $\lambda \to +\infty$ 时符号为 $(-1)^i$。(2) 反证法。若 $P_{i-1}(\mu) = P_i(\mu) = 0$，由递推公式 $0 = (\alpha_i - \mu) P_{i-1}(\mu) - \beta_i^2 P_{i-2}(\mu) = -\beta_i^2 P_{i-2}(\mu)$，而 $\beta_i \neq 0$，故 $P_{i-2}(\mu) = 0$。依此类推得 $P_0(\mu) = 0$，与 $P_0 \equiv 1$ 矛盾。(3) 由 (6.4.1) 代入 $P_i(\mu) = 0$ 及 (2) 即得 $P_{i+1}(\mu) P_{i-1}(\mu) = -\beta_{i+1}^2 P_{i-1}(\mu)^2 < 0$。(4) 用数学归纳法。对 $P_1(\lambda) = \alpha_1 - \lambda$ 和 $P_2(\lambda)$，$P_2(\alpha_1) = -\beta_2^2 < 0$ 而 $P_2(\lambda) \to +\infty$（$\lambda \to \pm\infty$），故 $P_2$ 在 $(-\infty, \alpha_1)$ 和 $(\alpha_1, +\infty)$ 各有一根。设 $i = k$ 时结论成立，即根交错排列：

$$
\mu_1 < \nu_1 < \mu_2 < \nu_2 < \cdots < \nu_{k-1} < \mu_k
$$

其中 $\nu_j$ 是 $P_{k-1}$ 的根，$\mu_j$ 是 $P_k$ 的根。由 (1) 可确定 $P_{k-1}(\mu_j)$ 的符号为 $(-1)^{j-1} P_{k-1}(\mu_j) > 0$。由递推公式得 $P_{k+1}(\mu_j) = -\beta_{k+1}^2 P_{k-1}(\mu_j)$，因此 $(-1)^j P_{k+1}(\mu_j) > 0$。结合 $P_{k+1}(\lambda)$ 在 $+\infty$ 处的符号，知 $P_{k+1}$ 在 $k+1$ 个区间 $(-\infty, \mu_1), (\mu_1, \mu_2), \dots, (\mu_k, +\infty)$ 各有一根，即 $P_k$ 的根分隔了 $P_{k+1}$ 的根。

这个分隔性质是二分法的核心：它保证了序列 $\{P_i(\lambda)\}$ 的变号次数恰好等于 $\lambda$ 左侧的根的个数。

对任意实数 $\mu$，定义 $S_k(\mu)$ 为序列 $P_0(\mu), P_1(\mu), \dots, P_k(\mu)$ 中相邻两项之间的**变号次数**。若 $P_i(\mu) = 0$，则规定 $P_i(\mu)$ 与 $P_{i-1}(\mu)$ 同号（避免因零值产生歧义）。

**定理 6.4.3** $S_k(\mu)$ 等于 $P_k(\lambda)$ 在 $(-\infty, \mu)$ 内的根的个数。

**证明（归纳法）：** $k=1$ 时显然成立。设 $k=\ell$ 时成立。记 $P_\ell$ 的根为 $\mu_1 < \cdots < \mu_\ell$，$P_{\ell+1}$ 的根为 $\lambda_1 < \cdots < \lambda_{\ell+1}$。由定理 6.4.2 有 $\lambda_1 < \mu_1 < \lambda_2 < \mu_2 < \cdots < \mu_\ell < \lambda_{\ell+1}$。设 $S_\ell(\mu) = m$，即 $\mu_m < \mu \leq \mu_{m+1}$。分三种情况：

1. $\lambda_m < \mu_m < \mu \leq \lambda_{m+1}$：此时 $P_\ell(\mu)$ 与 $P_{\ell+1}(\mu)$ 同号，$S_{\ell+1}(\mu) = S_\ell(\mu) = m$
2. $\lambda_{m+1} < \mu < \mu_{m+1}$：此时 $P_\ell(\mu)$ 与 $P_{\ell+1}(\mu)$ 异号，$S_{\ell+1}(\mu) = S_\ell(\mu) + 1 = m + 1$
3. $\mu = \mu_{m+1}$：此时 $P_\ell(\mu) = 0$，按规定 $P_\ell$ 与 $P_{\ell-1}$ 同号。由定理 6.4.2(3) 知 $P_{\ell-1}$ 与 $P_{\ell+1}$ 异号，故 $P_\ell$ 与 $P_{\ell+1}$ 异号，$S_{\ell+1}(\mu) = m + 1$

三种情况下 $S_{\ell+1}(\mu)$ 均等于 $P_{\ell+1}$ 在 $(-\infty, \mu)$ 的根数。

**推论 6.4.1** 若 $T$ 是不可约对称三对角矩阵，则 $S_n(\mu)$ 等于 $T$ 在 $(-\infty, \mu)$ 内特征值的个数。

由此可构造二分法求第 $m$ 个特征值 $\lambda_m$。先估计特征值的范围：

$$
|\lambda_i| \leq \rho(T) \leq \|T\|_\infty
$$

取 $l_0 = -\|T\|_\infty$，$u_0 = \|T\|_\infty$，则 $\lambda_m \in [l_0, u_0]$。每次取中点 $r = (l + u)/2$，计算 $S_n(r)$：

- 若 $S_n(r) \geq m$，则 $\lambda_m \in [l, r]$（区间左缩）
- 否则 $\lambda_m \in [r, u]$（区间右缩）

经过 $k$ 次二分，区间长度缩减为原来的 $2^{-k}$，获得约 $\frac{k}{3.3}$ 位十进制精度。

二分法的主要计算量在于每步计算 $S_n(\mu)$。直接计算多项式 $P_i(\mu)$ 容易因高阶项溢出。为避免溢出，改用比值形式：

$$
g_i(\mu) = \frac{P_i(\mu)}{P_{i-1}(\mu)}, \quad i = 1, \dots, n
$$

递推关系变为

$$
g_1(\mu) = \alpha_1 - \mu, \qquad
g_i(\mu) = \alpha_i - \mu - \frac{\beta_i^2}{g_{i-1}(\mu)}, \quad i = 2, \dots, n
$$

此时 $S_n(\mu)$ 就是 $g_1(\mu), \dots, g_n(\mu)$ 中负数的个数。实现时，若某步 $g_{i-1}$ 为零，用一个小量（如 $\varepsilon \cdot |\beta_i|$）代替以避免除零。

---

**本章小结：** 对称矩阵的特征值问题比一般矩阵更易于处理。Rayleigh 商给出了特征值的最佳单步估计，配合反幂法实现立方收敛。Jacobi 方法通过一系列正交旋转逐步对角化矩阵，算法简单且数值稳定，适合中小规模矩阵。二分法利用 Sturm 序列的性质，将特征值问题化为变号次数的计算，适合只需要部分特征值的场合——比如只求前几个最小特征值。

[← 上一篇：QR方法](/posts/numerical-analysis-1/12-qr-method/)
