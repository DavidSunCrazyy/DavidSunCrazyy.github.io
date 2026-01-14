---
layout: post
title: "Numerical Analysis II 最佳平方逼近"
permalink: /posts/numerical-analysis-2/03-最佳平方逼近/
tags: numerical-analysis
use_math: true
---

# 函数的最佳平方逼近

设
$f \in L_\rho^2[a, b]$，$\varphi_i \in L_\rho^2[a, b]$，$i = 0, 1, \cdots, n$．令
$\Phi = \text{span}\{\varphi_0, \cdots, \varphi_n\}$．

若存在 $s^* \in \Phi$ 使得
$$\|f - s^*\|_{2,\rho} = \inf_{s \in \Phi} \|f - s\|_{2,\rho}$$ 则称
$s^*$ 是 $f$ 在 $\Phi$ 中的[最佳平方逼近函数]{style="color: red"}．

$$\|f\|_{2,\rho} = \left( \int_a^b \rho(x) |f(x)|^2 dx \right)^{1/2}$$

## 最佳平方逼近的计算

令 $$s(x) = \sum_{j=0}^{n} a_j \varphi_j(x),$$
$$F(a_0, \cdots, a_n) = \int_a^b \rho(x) \left[ \sum_{j=0}^{n} a_j \varphi_j(x) - f(x) \right]^2 dx,$$
则有 $$s^*(x) = \sum_{j=0}^{n} a_j^* \varphi_j(x)$$
$$F(a_0^*, \cdots, a_n^*) = \inf_{a_0, \cdots, a_n} F(a_0, \cdots, a_n)$$

利用多元函数极值的必要条件有
$$\frac{\partial F}{\partial a_k} = 0, \quad k = 0, 1, \cdots, n$$
$$\Rightarrow \int_a^b \rho(x) \left( \sum_{j=0}^{n} a_j \varphi_j(x) - f(x) \right) \varphi_k(x) dx = 0$$

$$\sum_{j=0}^{n} (\varphi_k, \varphi_j)_\rho a_j = (f, \varphi_k)_\rho, \quad k=0,1,\cdots,n$$
其中
$$(\varphi_k, \varphi_j)_\rho = \int_a^b \rho(x) \varphi_k(x) \varphi_j(x) \, dx$$
$$(f, \varphi_k)_\rho = \int_a^b \rho(x) f(x) \varphi_k(x) \, dx$$

令 $$A =
\begin{bmatrix}
(\varphi_0, \varphi_2)_\rho & \cdots & (\varphi_0, \varphi_n)_\rho \\
\vdots & \ddots & \vdots \\
\vdots & \ddots & \vdots \\
(\varphi_n, \varphi_0)_\rho & \cdots & (\varphi_n, \varphi_n)_\rho
\end{bmatrix} \in \mathbb{R}^{(n+1) \times (n+1)}$$ 是 Gram 矩阵。由于
$\varphi_0, \ldots, \varphi_n$ 线性无关，所以 $A$ 可逆。于是方程有唯一解
$$(a_0^*, \ldots, a_n^*)$$

若 $(a_0^*, \ldots, a_n^*)$ 满足方程，则有
$$\left( \sum_{j=0}^n a_j^* \varphi_j(x) - f, \varphi_k \right)_\rho = 0$$
$$(s^*-f, s)_\rho = 0 \quad \forall s \in \mathbb{R}$$
$$(s^*-f, s-s^*)_\rho = 0 \quad \forall s \in \mathbb{R}$$
$$\|f-s\|_{2,p}^2 = \|f-s^* + s^* - s\|_{2,p}^2 \quad \forall s \in \mathbb{R}$$

$$= \|f - s^{*}\|_{2,\rho}^{2} + \|s^{*}-s\|_{2,\rho}^{2} \geq \|f - s^{*}\|_{2,\rho}^{2}$$
$\Rightarrow s^{*}$ 为 $f$ 在最佳平方逼近。

取 $[a,b] = [0,1]$，且 $P_n = \text{span}\{1,x,x^2\}$，$p(x) = 1$，则有
$$(\varphi_k, \varphi_j)_\rho = \int_0^1 x^{k+j} \, dx = \frac{1}{k+j+1}$$
$$(\varphi_k, f)_\rho = \int_0^1 f(x) x^k \, dx$$ Gram 矩阵为 $$A =
\begin{bmatrix}
1 & \frac{1}{2} & \cdots & \frac{1}{n+1} \\
\frac{1}{2} & \frac{1}{3} & \cdots & \frac{1}{n+2} \\
\vdots & \vdots & \ddots & \vdots \\
\frac{1}{n+1} & \frac{1}{n+2} & \cdots & \frac{1}{2n+1}
\end{bmatrix} \quad \text{Hilbert 矩阵, 病态矩阵}$$

设 $\varphi_0, \varphi_1, \ldots, \varphi_n$ 为 $[a,b]$ 上带权函数 $p$
的正交多项式组 $$(\varphi_i, \varphi_j)_\rho =
\begin{cases}
0, & i \neq j \\
\|\varphi_i\|_{2,\rho}^2, & i = j
\end{cases}$$

相应的 Gram 矩阵为
$$A = \text{diag} \left( \|\varphi_1\|_{2,\rho}^2, \ldots, \|\varphi_n\|_{2,\rho}^2 \right)$$
最佳平方逼近函数为
$$s_n^*(x) = \sum_{j=0}^{n} a_j^* \varphi_j(x), \quad a_j^* = \frac{(f, \varphi_j)_\rho}{(\varphi_j, \varphi_j)}$$

### 周期函数的最佳平方逼近 {#周期函数的最佳平方逼近 .unnumbered}

$$f \in C(\mathbb{R}), \quad f(x+2\pi) = f(x) \quad \text{以} \, 2\pi \, \text{为周期}.$$
定义内积 $$(f, g) = \int_0^{2\pi} f(x) g(x) \, dx$$ 取
$$\Phi = \text{span} \{ 1, \cos x, \sin x, \ldots, \cos nx, \sin nx \}$$
满足正交性条件 $$\int_0^{2\pi} \cos kx \, \sin lx \, dx = 0$$
$$\int_0^{2\pi} \cos kx \, \cos lx \, dx =
\begin{cases}
2\pi, & k = l = 0 \\
\pi, & k = l \ne 0 \\
0, & k \ne l
\end{cases}$$ $$\int_0^{2\pi} \sin kx \sin lx \, dx =
\begin{cases}
\pi, & k=l\ne 0 \\
0, & k\ne l
\end{cases}$$

相应的最佳平方逼近函数为
$$s_n(x) = \frac{1}{2} a_0 + \sum_{j=1}^n a_j \cos jx + b_j \sin jx$$
$$a_0 = \frac{1}{\pi} \int_0^{2\pi} f(x) \, dx$$
$$a_j = \frac{1}{\pi} \int_0^{2\pi} f(x) \cos jx \, dx$$
$$b_j = \frac{1}{\pi} \int_0^{2\pi} f(x) \sin jx \, dx$$

## 正交多项式

**Definition**
设 $f, g \in C[a,b]$，$\rho$ 为 $[a,b]$ 上的权函数，若
$$(f, g) = \int_a^b \rho(x) f(x) g(x) \, dx = 0$$ 则称 $f$ 和 $g$ 在
$[a,b]$ 上关于权函数 $\rho$ 正交。


**Definition**
设 $\varphi_n$ 是 $[a,b]$ 上 $n$ 次项系数不为零的 $n$ 次多项式，$\rho$
为 $[a,b]$ 上的权函数。如果多项式序列 $\{\varphi_n, n \geq 0\}$ 满足
$$(\varphi_i, \varphi_j) = \int_a^b \rho(x) \varphi_i(x) \varphi_j(x) \, dx =
\begin{cases}
0, & i \neq j \\
A_j, & i = j
\end{cases}$$ 则称 $\{\varphi_n, n \geq 0\}$ 在 $[a,b]$ 上关于 $\rho$
正交，称 $\varphi_n$ 为 $[a,b]$ 上**带权函数 $\rho$ 的 $n$
次正交多项式**。


利用 Gram-Schmidt 方法可以构造正交多项式序列：

令 $\psi_j(x) = x^j$，令 $$\varphi_0(x) = 1$$
$$\varphi_k(x) = \psi_k(x) - \sum_{j=0}^{k-1} \frac{(\psi_k, \varphi_j)}{(\varphi_j, \varphi_j)} \varphi_j(x), \quad k=1,2,\cdots,n$$

**Theorem**
设 $\{\varphi_n, n \geq 0\}$ 是 $[a,b]$ 上带权函数 $\rho$
的正交多项式序列，则 $\varphi_n$ 在 $(a,b)$ 内有 $n$ 个不同的零点。



*Proof.* $\varphi_n$ 为正交多项式，所以
$$\int_a^b \rho(x) \varphi_n(x) \varphi_0(x) \, dx = 0$$
$$\Rightarrow \int_a^b \rho(x) \varphi_n(x) \, dx = 0$$
$$\Rightarrow \varphi_n \text{ 在 } (a,b) \text{ 内必有奇数重零点。}$$

若 $\varphi_n$ 无奇数重零点，则有
$$\varphi_n(x) \geq 0 \Rightarrow \int_a^b \rho(x) \varphi_n(x) \, dx > 0$$
矛盾。故 $\varphi_n$ 必有奇数重零点，不妨设
$$a < x_1 < x_2 < \cdots < x_e < b$$ 为 $\varphi_n$ 的所有奇数重零点。

令 $$g(x) = \prod_{j=1}^e (x - x_j)$$ 则
$$\varphi_n(x) g(x) \text{ 无奇数重零点，则有}$$
$$\int_a^b \rho(x) \varphi_n(x) g(x) \, dx > 0$$

若 $e < n$，与 $\varphi_n$ 是 $n$ 次正交多项式矛盾。故有 $e = n$，即
$\varphi_n$ 有 $n$ 个单重零点。 ◻


**Theorem**
$\{\varphi_n: n \geq 0\}$ 是带权 $\rho$ 的正交多项式序列。对于
$n \geq 1$ 有
$$\varphi_{n+1}(x) = (\alpha_n x + \beta_n) \varphi_n(x) + \gamma_{n-1} \varphi_{n-1}(x)$$
其中 $\varphi_1(x) = 0$。



*Proof.* 设 $a_n$ 为 $\varphi_n$ 中 $x^n$ 的系数，取
$\alpha_n = \frac{a_{n+1}}{a_n}$，则
$$\varphi_{n+1} - \alpha_n x \varphi_n \text{ 的次数 } \leq n$$ 则
$$\varphi_{n+1} - \alpha_n x \varphi_n = \beta_n \varphi_n + \sum_{j=0}^{n-1} \gamma_j \varphi_j$$
且
$$\beta_1 = \frac{\alpha_n (\alpha \varphi_n, \varphi_n)}{(\varphi_n, \varphi_n)}$$
$$\gamma_j = -\frac{\alpha_n (\alpha \varphi_n, \varphi_j)}{(\varphi_j, \varphi_j)}, \quad j = 0, 1, \cdots, n-1$$
由于
$(\alpha \varphi_n, \varphi_j) = (\varphi_n, \varphi_j) = 0, \quad j = 0, 1, \cdots, n-2$，设有
$$\varphi_{n+1} - \alpha_n \alpha \varphi_n = \beta_n \varphi_n + \delta_{n-1} \varphi_{n-1}$$
且
$$\gamma_{n-1} = -\frac{\alpha_n (\varphi_n, \alpha \varphi_{n-1})}{(\varphi_{n-1}, \varphi_{n-1})}$$
$$= -\frac{\alpha_n a_{n-1}}{a_n} \frac{(\varphi_n, \varphi_n)}{(\varphi_{n-1}, \varphi_{n-1})}$$
$$= -\frac{a_{n-1} a_{n+1}}{a_n^2} \frac{(\varphi_n, \varphi_n)}{(\varphi_{n-1}, \varphi_{n-1})}$$ ◻


### Legendre 多项式 {#legendre-多项式 .unnumbered}

取 $\rho(x) = 1$, $[a, b] = [-1, 1]$，相应的正交多项式为 Legendre
多项式： $$P_0(x) = 1$$
$$P_n(x) = \frac{1}{2^n n!} \frac{d^n}{dx^n} \left[ (x^2 - 1)^n \right], \quad n \geq 1$$

**Proposition**
(1) $$\int_{-1}^{1} P_n(x) P_m(x) \, dx =
    \begin{cases}
    0, & n \neq m \\
    \frac{2}{2n+1}, & n = m
    \end{cases}$$

(2) $$(n+1)P_{n+1} = (2n+1)xP_n - nP_{n-1}, \quad n=0,1,2,\cdots$$ 其中
    $P_1 = 0$

(3) $$P_n(-x) = (-1)^n P_n(x)$$


### Laguerre 多项式 {#laguerre-多项式 .unnumbered}

$$[a, b) = [0, +\infty), \quad \rho(x) = e^{-x}$$
$$L_n(x) = e^x \frac{d^n}{dx^n}(x^n e^{-x}), \quad n=0,1,\cdots$$

### Hermite 多项式 {#hermite-多项式 .unnumbered}

$(-\infty, \infty)$ 上带权函数 $\rho(x) = e^{-x^2}$ 的正交多项式称为
Hermite 多项式： $$H_n(x) = (-1)^n e^{x^2} \frac{d^n}{dx^n} e^{-x^2}$$

### Chebyshev 多项式 {#chebyshev-多项式 .unnumbered}

在区间 $[-1,1]$ 上关于权函数 $P(x) = \frac{1}{\sqrt{1-x^2}}$
的正交多项式序列称为 Chebyshev 多项式，其表达式为

$$T_n(x) = \cos(n \arccos(x)), \quad n \geq 0$$

**性质：**

(1) 正交性：
    $$(T_n, T_m) = \int_{-1}^1 \frac{1}{\sqrt{1-x^2}} T_n(x) T_m(x) \, dx =
        \begin{cases}
        \frac{\pi}{2}, & n \neq m \\
        \pi, & n = m \neq 0
        \end{cases}$$

(2) 奇偶性： $$T_n(-x) = (-1)^n T_n(x)$$

(3) 递推关系： $$T_{n+1}(x) = 2x T_n(x) - T_{n-1}(x)$$

(4) 首项系数： $$T_n \text{ 的首项系数为 } 2^{n-1}$$

(5) 零点：
    $$T_n \text{ 在 } (-1,1) \text{ 内有 } n \text{ 个不同零点：}$$
    $$\chi_k = \cos \frac{(2k-1)\pi}{2n}, \quad k=1,2,\cdots,n$$

(6) 极值点： $$T_n \text{ 的极值点为：}$$
    $$\overline{x}_k = \cos \frac{k\pi}{n}, \quad k=0,1,\cdots,n$$
    $$T_n(\overline{x}_k) = (-1)^k$$

**Theorem**
令
$\tilde{T}_0(x) = T_0(x)$，$\tilde{T}_n(x) = \frac{1}{2^{n-1}} T_n(x)$，$n \geq 1$。

记 $\tilde{T}_n$ 为首项系数为 $1$ 的 $\leq n$ 次多项式全体。

$$\frac{1}{2^{n-1}} = \max_{x \in [t,1]} |\tilde{T}_n(x)| \leq \max_{x \in [t,1]} |\varphi_n(x)|, \forall \varphi_n \in \tilde{P}_n$$

即
$\tilde{T}_n = \argmin_{\varphi \in \tilde{P}_n} ||\varphi||_\infty$。



*Proof.* 反证法。设 $\varphi_n \in \tilde{P}_n$ 有

$$\max_{x \in [t,1]} |\varphi_n(x)| < \max_{x \in [t,1]} |\tilde{T}_n(x)| = \frac{1}{2^{n-1}}$$

令 $Q = \tilde{T}_n - \varphi_n$，$\tilde{T}_n$ 为首项系数均为 $1$ 故有

$$Q \in \tilde{P}_{n-1}$$

且在 $\tilde{T}_n$ 的极值点 $\overline{x}_k, k=0, \cdots, n$ 有

$$Q(\overline{x}_k) = \tilde{T}_n(\overline{x}_k) - \varphi_n(\overline{x}_k) = \frac{(-1)^k}{2^{n-1}} - \varphi_n(\overline{x}_k)$$

由

$$\max_{x \in [t,1]} |\varphi_n(x)| < \frac{1}{2^{n-1}}$$

当 $k$ 为奇数时 $Q(\overline{x}_k) < 0$，当 $k$ 为偶数时
$Q(\overline{x}_k) > 0$。

由介值定理，$Q$ 在 $[-1,1]$ 中至少有 $n$ 个零点。

所以 $Q \equiv 0$。 ◻


**Theorem**
设插值区间为 $[-1,1]$，插值节点 $x_0, x_1, \ldots, x_n$ 为 $n+1$ 次
Chebyshev 多项式的零点。

被插值函数 $f \in C^{n+1}[-1,1]$，$L_n$ 为 Lagrange 插值多项式，那么

$$\max_{x \in [-1,1]} |f(x) - L_n(x)| \leq \frac{1}{2^n(n+1)!} ||f^{(n+1)}||_\infty$$



*Proof.* 由 Lagrange 插值余项估计

$$\max_{x \in [-1,1]} |f(x) - L_n(x)| \leq \frac{1}{(n+1)!} ||f^{(n+1)}||_\infty ||w^{n+1}||_\infty$$

其中

$$w^{n+1}(x) = (x-x_0) \cdots (x-x_n)$$

$$||w^{n+1}||_\infty = \frac{1}{2^n}$$ ◻


## 多项式最佳平方逼近的收敛性

定义内积

$$\langle f, g \rangle_\omega = \int_a^b f(x)g(x) \omega(x) \, dx$$

设 $\{\overline{Q}_0, \overline{Q}_1, \ldots\}$ 是相应的正交多项式。

令 $S_n f$ 为 $f$ 的 $\leq n$ 次最佳平方逼近多项式

$$S_n f = \sum_{i=0}^n \langle f, Q_i \rangle_\omega \overline{Q}_i$$

**Theorem**
对于所有 $f \in C[a,b]$，有
$$\|f - S_n f\|_\infty \to 0, \quad n \to \infty$$



*Proof.* 设 $T_nf$ 为 $f$ 的 $\le n$ 次最佳逼近多项式，则
$$\|f - S_n f\|_\infty \leq \|f - T_n f\|_\infty$$
$$\leq \|f - T_n f\|_\infty \int_a^b \omega(x)  dx$$ ◻


**Theorem**
若 $f \in C^2[a,b]$，则 $f$ 的 Chebyshev 多项式展开一致收敛到 $f$。



*Proof.* 设 $f$ 的 Chebyshev 多项式展开为
$$\frac{1}{2} A_0 + \sum_{k=1}^\infty A_k T_k$$ 其中
$$A_k = \frac{2}{\pi} \int_{-1}^1 f(x) T_k(x) \frac{dx}{\sqrt{1-x^2}}$$
令 $$\begin{cases}
x = \cos\theta \\
g(\theta) = f(\cos\theta)
\end{cases}$$ 则
$$A_k = \frac{2}{\pi} \int_0^\pi g(\theta) \cos k\theta d\theta$$

由分部积分得
$$A_k = \frac{2}{\pi k^2} \int_0^\pi g''(\theta) \cos k\theta d\theta$$

由于 $f \in C^2$，有 $$|A_k| \leq \frac{M}{k^2}$$ 因此
$$\sum_{k=0}^\infty |A_k| \quad \text{收敛}$$ 从而
$$\frac{1}{2} A_0 + \sum_{k=1}^\infty A_k T_k \quad \text{一致收敛}$$

令 $$F(x) = \frac{1}{2} A_0 + \sum_{k=1}^\infty A_k T_k$$

则
$$\|f - f\|_\omega \leq \|f - S_n f\|_\omega + \|S_n f - f\|_\omega \to 0$$
$$\Rightarrow f = F$$ ◻


$S_n$ 可以写成积分算子的形式：
$$(S_n f)(x) = \sum_{t=0}^n \int_a^b f(t) \overline{Q_i}(t) \omega(t) dt \overline{Q_i}(x)$$
$$= \int_a^b f(t) \sum_{t=0}^n \overline{Q_i}(t) Q_i(x) \omega(t) dt$$
$$= \int_a^b f(t) K_n(t,x) w(t) \, dt$$ 其中
$$K_n(t,x) = \sum_{t=0}^n \overline{Q_i}(t) Q_i(x)$$

**Lemma**
$$\sum_{t=0}^n \overline{Q_t}(t) \overline{Q_t}(x) = \lambda_{n+1} \lambda_n^{-1} \frac{\overline{Q_{n+1}}(x) \overline{Q_n}(t) - \overline{Q_n}(x) \overline{Q_{n+1}}(t)}{x-t}$$

其中 $\lambda_n^{-1}$ 为 $Q_n$ 中 $x^n$ 的系数。



*Proof.* 设 $Q_n = \lambda_n \overline{Q_n}$ 为首 $1$
多项式，由递推关系得:
$$Q_{n+1}(x) Q_n(t) = (x - a_{n+1}) Q_n(x) Q_n(t) - b_{n+1} Q_{n-1}(x) Q_n(t)$$
$$Q_{n+1}(t) Q_n(x) = (t - a_{n+1}) Q_n(t) Q_n(x) - b_{n+1} Q_{n-1}(t) Q_n(x)$$

两式相减得：
$$Q_{n+1}(x) Q_n(t) - Q_{n+1}(t) Q_n(x) = (x - t) Q_n(t) Q_n(x) + b_{n+1} [Q_n(x) Q_{n-1}(t) - Q_n(t) Q_{n-1}(x)]$$

由
$\lambda_n^2 = \langle Q_n, Q_n \rangle$，$b_{n+1} Q_{n-1} = x Q_n - a_{n+1} Q_n - Q_{n+1}$，得：
$$b_{n+1} \lambda_{n-1}^2 = \langle x Q_n, Q_{n-1} \rangle = \langle Q_n, x Q_{n-1} \rangle = \langle Q_n, Q_n + a_n Q_{n-1} + b_n Q_{n-2} \rangle = \lambda_n^2$$

由此可得：
$$\lambda_n^{-2} [Q_{n+1}(x) Q_n(t) - Q_{n+1}(t) Q_n(x)] = (x - t) \overline{Q_n}(x) \overline{Q_n}(t) + \lambda_{n-1}^{-2} [Q_n(x) Q_{n-1}(t) - Q_n(t) Q_{n-1}(x)]$$

递推可得：
$$\lambda_n^{-2} [Q_{n+1}(x) Q_n(t) - Q_{n+1}(t) Q_n(x)] = (x - t) \sum_{i=0}^{n} \overline{Q_i}(x) \overline{Q_i}(t)$$ ◻


**Theorem**
设 $x_0 \in [a, b]$，$f$ 在 $x_0$ 处 Lipschitz 连续。
$\overline{Q}_n(x_0)$ 有界(与 $n$ 无关), 则

$$f(x_0) = \sum_{k=0}^{\infty} \langle f, \overline{Q}_k \rangle \overline{Q}_k(x_0)$$



*Proof.* 
$$\begin{aligned}
    \lambda_n^2 =& \langle Q_n, Q_n \rangle \\
    =& \langle Q_n, xQ_{n-1} - a_nQ_{n-1} - b_nQ_{n-2} \rangle \\
    =& \langle Q_n, xQ_{n-1} \rangle \\
    \leq & \int_a^b |x| |Q_n| |Q_{n-1}| \omega \, dx \\
    \leq & \max\{|a|, |b|\} \langle |Q_n|, |Q_{n-1}| \rangle  \\
    \leq & \max\{|a|, |b|\} ||Q_n|| ||Q_{n-1}|| \\
    = & \max\{|a|, |b|\} \lambda_n \lambda_{n-1} \\
\end{aligned}$$


$$\Rightarrow \lambda_n \lambda_{n-1}^{-1} \leq \max\{|a|, |b|\}$$

$$\epsilon_n = f(x_0) - (\delta_n f)(x_0) = \int_a^b [f(x_0) - f(x)] \sum_{c=0}^n \overline{Q}_c(x_0) \overline{Q}_c(x) \omega(x) \, dx$$

$$= \lambda_{n+1} \lambda_n^{-1} \int_a^b \frac{f(x_0) - f(x)}{x_0 - x} [\overline{Q}_{n+1}(x_0) \overline{Q}_n(x) - \overline{Q}_n (x_0) \overline{Q}_{n+1}(x)]\omega(x) \, dx$$

$$= \lambda_{n+1} \lambda_n^{-1} [\langle h, \overline{Q}_n \rangle, \overline{Q}_{n+1}(x_0) - \langle h, \overline{Q}_{n+1}\rangle \overline{Q}_n(x)]$$

其中

$$h(x) = [f(x_0) - f(x)] / (x_0 - x)$$

$f$ 在 $x_0$ 处 Lipschitz 连续，所以 $$|h(x)| \le L$$
由于$\langle h, \overline{Q}_n \rangle \to 0$, $\overline{Q}_n(x_0)$
有界. 定理可证. ◻


$f \in C_{2\pi}$ 的 Fourier 级数为

$$(S_n f)(x) = \frac{1}{2} a_0 + \sum_{k=1}^n a_k \cos kx + b_k \sin kx$$

其中

$$a_k = \frac{1}{\pi} \int_{-\pi}^{\pi} f(t) \cos kt \, dt, \quad b_k = \frac{1}{\pi} \int_{-\pi}^{\pi} f(t) \sin kt \, dt$$

积分形式为

$$(S_n f)(x) = \frac{1}{\pi} \int_{-\pi}^{\pi} f(t+x) \frac{\sin(u+\frac{1}{2})t}{2 \sin \frac{1}{2}t} \, dt$$

**Theorem**
$f \in C_{2\pi}$ 并且
$\lim_{\delta \to 0} w(\delta,f) \log \delta = 0$，则

$$\lim_{n \to \infty} ||S_n f - f||_\infty = 0$$



*Proof.*
$$||(S_n f)(x)|| \leq ||f||_\infty \int_0^\pi \frac{|\sin(u+\frac{1}{2})t|}{\pi |\sin \frac{1}{2}t|} \, dt$$

$$\frac{2}{\pi} \int_0^{1/n} \left| \frac{\sin (u+\frac{1}{2}) t}{2 \sin \frac{1}{2} t} \right| \, dt = \frac{2}{\pi} \int_0^{1/n} \left| \frac{1}{2} + \cos t + \cdots + \cos n t \right| \, dt \leq \frac{2}{\pi} \cdot \frac{1}{n} \cdot \left( \frac{1}{2} + n \right) < 1$$

另一方面

$$\frac{1}{\pi} \int_{1/n}^{\pi} \left| \frac{\sin (u+\frac{1}{2}) t}{s \sin \frac{1}{2} t} \right| \, dt \leq \frac{1}{\pi} \int_{1/n}^{\pi} \frac{1}{t/\pi} \, dt = \log n - \log \frac{1}{n} < 2 + \log n$$

则有

$$||S_n|| < 3 + \log n$$

因此令 $P$ 为 $f$ 的 $s_n$ 次最佳三角

$$||S_nf - f|| = ||S_n(f - P) + (f - P)|| \leq ||S_n(f - P)|| + ||f - P|| \leq (4 + \log n) ||f - P|| \leq \frac{3}{2} (4 + \log n) \omega (\frac{\pi}{n+1}) \quad D$$ ◻


$f \in C_{2n}$，令 Cesaro 均值为

$$G_n f = \frac{1}{n} \sum_{k=0}^{n-1} S_k f$$

**Lemma**
$$(G_n f)(x) = \frac{1}{2n\pi} \int_{-\pi}^{\pi} f(t+x) \left( \frac{\sin \frac{1}{2} nt}{\sin \frac{1}{2} t} \right)^2 \, dt$$


（证明留作练习）

**Theorem**
$f \in C_{2\pi}$，则

$$\lim_{n \to \infty} ||G_n f - f||_\infty = 0$$



*Proof.*
$$| (G_n f)(x) - f(x) | = \frac{1}{2n\pi} \left| \int_0^{\pi} \left( f(t+x) + f(x-t) - 2f(x) \right) \left( \frac{\sin \frac{1}{2} nt}{\sin \frac{1}{2} t} \right)^2 \, dt \right|$$

$$\leq \frac{1}{n\pi} \int_0^{\pi} w(t,f) \left( \frac{\sin \frac{1}{2} nt}{\sin \frac{1}{2} t} \right)^2 \, dt \leq \frac{1}{n\pi} w(\frac{1}{n},f) \int_{-\pi}^{\pi} w(t+1) \left( \frac{\sin \frac{1}{2} nt}{\sin \frac{1}{2} t} \right)^2 \, dt$$

直接计算定理可证（留作练习） ◻


**Theorem**
设 $f \in [a,b]$，$Q_0, Q_1, \cdots$ 是 $[a,b]$ 上关于权 $w(x)$
正交的多项式。$L_n f$ 为 $Q_{n+1}$ 的零点对应的 Lagrange
插值多项式，则有

$$\lim_{n \to \infty} ||L_n f - f||_w = 0$$



*Proof.* 设 $x_0, \cdots, x_n$ 为 $Q_{n+1}$ 的零点，则

$$(L_n f)(x) = \sum_{i=0}^n f(x_i) l_i(x)$$

其中

$$l_i(x) = \frac{Q_{n+1}(x)}{(x - x_i) Q_{n+1}^{\prime}(x_i)}$$

另一方面，当 $i \neq j$ 时，

$$\langle l_i, l_j \rangle_w = \frac{1}{Q_{n+1}^{\prime}(x_i) Q_{n+1}^{\prime}(x_j)} \int_a^b Q_{n+1}(x) \frac{Q_{n+1}(x)}{(x - x_i)(x - x_j)} w(x) \, dx = 0$$

所以

$$\int_a^b w(x) \, dx = \int_a^b \left( \sum_{i=0}^n l_i(x) \right)^2 w(x) \, dx = \sum_{i=0}^n \int_a^b l_i(x) w(x) \, dx$$

令 $P_n$ 为 $f$ 的 $\leq n$ 次最佳逼近多项式，则

$$||P_n - f||_w \leq ||P_n - f||_\infty \left( \int_a^b w(x) \, dx \right)^{1/2} \to 0$$

并且


$$\begin{aligned}
||L_n f - P_n||^2_w & = ||L_n (f - P_n)||^2_w  \\
&= \int_a^b \left( \sum_{i=0}^n (f(x_i) - P_n(x_i)) l_i(x) \right)^2 w(x) \, dx \\
&= \sum_{i=0}^n (f(x_i) - P_n(x_i))^2 \int_a^b l_i(x) w(x) \, dx  \\
&\leq ||f - P_n||^2_\infty \sum_{i=0}^n \int_a^b l_i(x) w(x) \, dx \\
&= ||f - P_n||^2_\infty \int_a^b w(x) \, dx \to 0\\
\end{aligned}$$
 ◻


[← 多项式插值](/posts/numerical-analysis-2/02-多项式插值/) | [高维分片多项式逼近 →](/posts/numerical-analysis-2/04-高维分片多项式逼近/)
