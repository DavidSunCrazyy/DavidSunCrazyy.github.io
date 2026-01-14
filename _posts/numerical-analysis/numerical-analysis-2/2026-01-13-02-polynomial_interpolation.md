---
layout: post
title: "Numerical Analysis II 多项式插值"
permalink: /posts/numerical-analysis-2-02-多项式插值/
tags: numerical-analysis
use_math: true
---

# 多项式插值

$$f: [a, b] \to \mathbb{R}, \quad x_0, \ldots, x_n \in [a, b] \text{ 互异}$$
$$y_i^{(k)} = f^{(k)}(x_i), \quad i = 0, \ldots, n, \quad k = 0, \ldots, m$$

**插值问题：** 寻找 $\varphi \in I$，使得
$$\varphi^{(k)}(x_i) = f^{(k)}(x_i), \quad i = 0, \ldots, n, \quad k = 0, \ldots, m$$

-   **I:** 插值函数空间，本章讨论多项式空间和分段多项式空间

-   $\varphi$: 插值函数

-   $f$: 被插值函数

-   $x_0, \ldots, x_n$: 插值节点

## Lagrange 插值

存在唯一的 (不超过) $n+1$次多项式恰好经过$n$个点.

首先我们定义一个记号.

::: definition
记$$l_i (x) = \prod_{j=0, j\ne i}^n \frac{(x-x_j)}{(x_i-x_j)}$$

$$L_n(x) = \sum_{i=0}^n f(x_i) l_i(x).$$ $L_n$为Lagrange插值多项式.
:::

::: theorem
给定 $n+1$ 个互异节点 $x_0, x_1, \cdots, x_n \in [a, b]$ 和相应的
$f(x_0), \cdots, f(x_n)$，则存在唯一 $n$ 次多项式 $p \in P_n$
满足插值条件： $$p(x_i) = f(x_i), \quad i = 0, 1, \cdots, n$$
:::

Lagrange 插值多项式的误差估计.

::: theorem
$x_0, \cdots, x_n$ 为 $[a, b]$ 上互异节点，$f \in C^{n+1}[a, b]$。$L_n$
为 $n$ 次 Lagrange 插值多项式，则
$\forall x \in [a, b]$，$\exists \xi = \xi(x) \in [a, b]$ 使得：
$$R_n(x) = f(x) - L_n(x) = \frac{f^{(n+1)}(\xi)}{(n+1)!} w_{n+1}(x)$$
其中 $w_{n+1}(x) = (x - x_0) \cdots (x - x_n)$ （微分形式余项）
:::

::: proof
*Proof.* 取定 $x \in [a, b]$，$x \neq x_i$，$i = 0, 1, \cdots, n$，令
$$G(t) = R_n(t) - \frac{w_{n+1}(t)}{w_{n+1}(x)} R_n(x)$$ 则有
$G \in C^{n+1}[a, b]$ 且 $$G(x_i) = 0, \quad i = 0, \cdots, n$$
$$G(x) = 0$$ 由 Rolle 定理 存在
$\xi_j^{(1)} \in [a, b]$，$j = 1, 2, \cdots, n+1$ 使得
$$G'(\xi_j^{(1)}) = 0$$ 重复使用 Rolle 定理 最终可得
$$\exists \xi \in [a, b] \text{ 使得 } G^{(n+1)}(\xi) = 0$$ 另一方面
$$G^{(n+1)}(\xi) = R_n^{(n+1)}(\xi) - \frac{w_{n+1}^{(n+1)}(\xi)}{w_{n+1}(x)} R_n(x)$$
$$= f^{(n+1)}(\xi) - \frac{(n+1)!}{w_{n+1}(x)} R_n(x)$$ 由此可得
$$R_n(x) = \frac{f^{(n+1)}(\xi)}{(n+1)!} w_{n+1}(x)$$ ◻
:::

::: corollary
设 $a=x_0 < x_1 < \cdots < x_n = b$,
$h = \max_{1\le j \le n} (x_j - x_{j-1})$, $f \in C^{n+1} [a,b]$, $L_n$
为 $f$ 的 $n$ 次 插值多项式, 则有
$\|f-L_n\|_\infty \le \frac{h^{n+1}}{4(n+1)} \|f^{(n+1)}\|_\infty$
:::

::: proof
*Proof.* 设 $x \in [x_k, x_{k+1}]$， $$\begin{aligned}
|(x - x_k)(x - x_{k+1})| &\leq \frac{1}{4}h^2 \\
|x - x_{k+2}| &\leq 2h, \dots, |x - x_n| \leq (n-k)h \\
|x - x_{k-1}| &\leq 2h, \dots, |x - x_0| \leq (k+1)h
\end{aligned}$$ 从而 $$|w_{n+1}(x)| \leq \frac{n!}{4} h^{n+1}$$ ◻
:::

## 均差和 Newton 插值多项式

设 $x_0, \dots, x_n$ 为互异节点，定义

零阶均差为： $$f[x_k] = f(x_k)$$

一阶均差为：
$$f[x_k, x_{k+1}] = \frac{f[x_{k+1}] - f[x_k]}{x_{k+1} - x_k}$$

$j$ 阶均差为：
$$f[x_k, x_{k+1}, \dots, x_{k+j}] = \frac{f[x_{k+1}, \dots, x_{k+j}] - f[x_k, \dots, x_{k+j-1}]}{x_{k+j} - x_k}$$

均差的性质：

1.  (线性性) 均差 $f[x_0, x_1, \dots, x_k]$ 是 $f(x_0), \dots, f(x_n)$
    的线性组合。

2.  (对称性) 均差对于节点是对称的。

3.  如果 $f[x, x_0, \dots, x_k]$ 是 $x$ 的 $m$ 次多项式，则
    $$f[x, x_0, \dots, x_k, x_{k+1}]$$ 是 $x$ 的 $m-1$ 次多项式。 如果
    $f \in P_n$，则 $$f[x, x_0, \dots, x_n] \equiv 0$$

4.  如果 $f \in C^n[a, b]$，且 $$x_0, \dots, x_n \in [a, b]$$ 互异，则
    $$f[x_0, \dots, x_n] = \frac{1}{n!} f^{(n)}(\xi)$$ 其中
    $\xi \in [a, b]$。

Newton 插值多项式

利用均差定义有 $$\begin{aligned}
f[x] &= f[x_0] \\
f[x, x_0] &= f[x_0] + f[x, x_0](x - x_0) \\
f[x, x_0, x_1] &= f[x_0, x_1] + f[x, x_0, x_1](x - x_1) \\
f[x, x_0, \dots, x_n] &= f[x_0, \dots, x_n] + f[x, x_0, \dots, x_n](x - x_n)
\end{aligned}$$

$$f(x) = 
\underbrace{
f(x_0) + f[x, x_0](x - x_0) + \cdots + f[x_0, \dots, x_n](x - x_0)\cdots(x - x_{n-1})
}_{N_n(x)}$$ $$+
\underbrace{
f[x, x_0, \dots, x_n](x - x_0)\cdots(x - x_n)
}_{R_n(x)}$$

则有 $N_n(x) \in P_n$ 且 $N_n(x_i) = f(x_i), \quad i = 0, \dots, n$.

故 $$N_n(x) = L_n(x) \quad \textbf{ n  次 Newton 插值多项式}$$

$$R_n(x) = f[x, x_0, \dots, x_n](x - x_0)\cdots(x - x_n) \quad \textbf{均差形式余项}$$

## Hermite 插值

$x_0, \ldots, x_n \in [a, b]$ 互异。求 $2n+1$ 次多项式 $H_{2n+1}$ 使得
$$H_{2n+1}(x_j) = f(x_j), \quad H'_{2n+1}(x_j) = f'(x_j), \quad j=0,1,\ldots,n$$
构造 $\alpha_j, \beta_j \in P_{2n+1}, \quad j=0,1,\ldots,n$ 分别满足
$$\alpha_j(x_k) = \delta_{jk}, \quad \alpha'_j(x_k) = 0$$
$$\beta_j(x_k) = 0, \quad \beta'_j(x_k) = \delta_{jk}$$

则
$$H_{2n+1}(x) = \sum_{j=0}^{n}\left( f(x_j) \alpha_j(x) + f'(x_j) \beta_j(x) \right)$$
由 $\alpha_j$ 满足的条件知 $x_k, k \neq j$ 均是 $\alpha_j(x)$
的二重零点，故 $\alpha_j$ 可以写成
$$\alpha_j(x) = \left( \prod_{\substack{k=0 \\ k \neq j}}^{n} (x - x_k)^2 \right) (ax + b)$$

利用 $\alpha_j(x_j) = 1, \quad \alpha'_j(x_j) = 0$ 可解得 $a, b$
$$\alpha_j(x) = [1 - 2l'_j(x_j)(x - x_j)] l^2_j(x)$$ 同理 $\beta_j$ 有
$n$ 个二重零点和 1 个单重零点，故

$$\beta_j(x) = c (x - x_j) \prod_{\substack{k=0 \\ k \neq j}}^{n} (x - x_k)^2$$
利用 $\beta'_j(x_j) = 1$ 可解得 $c$,
$$\Rightarrow \beta_j(x) = (x - x_j) l^2_j(x)$$ $f \in C^{2n+2}[a, b]$,
$x_0, \ldots, x_n \in [a, b]$ 互异

::: proposition
$H_{2n+1}$ 为 $2n+1$ 次 Hermite 插值多项式，则
$\forall x \in [a, b]$，存在 $\xi = \xi(x) \in [a, b]$ 使得
$$R_{2n+1}(x) = f(x) - H_{2n+1}(x) = \frac{f^{(2n+2)}(\xi)}{(2n+2)!} \omega_{n+1}^2(x)$$
:::

::: proof
*Proof.* 固定$x\in [a,b]$,

因为 $R_{2n+1}(x_i) = 0$, $R_{2n+1}'(x_i) = 0$.

取$G(t) = R_{2n+1} (t) - (\omega_{n+1}^2(t)/\omega_{n+1}^2(x)) R_{2n+1}(x)$.

$G(x) =0$,所以利用Rolle定理,
$\exists \xi_i, G'(\xi_i) = 0, \forall 1\le i\le n+1$,
加上$G'(x_i) = 0$, 共有$2n+2$个点,使得$G'(t) = 0$.

所以反复使用Rolle定理, 可得$\xi$, 使得$G^{(2n+2)}(\xi) = 0$.

而$G^{(2n+2)}(\xi) = f_{2n+1}^{(2n+2)}(\xi) - (2n+2)!/(\omega_{n+1}^2(\xi)) R_{2n+1}(\xi)$

故得证. ◻
:::

## 插值的收敛性

::: theorem
若完备距离空间表示为可数个闭集之并，则至少有一个闭集包含一个球。
:::

::: proof
*Proof.* （反证法） 若不成立，则存在一个完备距离空间
$X = \bigcup_{n=1}^{\infty} F_n$，其中 $F_n$ 为闭集，且不含任意球。

令 $O_n = X \setminus F_n$，则 $O_n$ 为开集，且与每个球都相交。则存在
$$S_n = \{ x \in X : d(x, x_n) \leq \varepsilon_n \}$$ 使得
$S_1 \subset O_1$，$S_2 \subset S_1 \cap O_2$，$S_3 \subset S_2 \cap O_3 \cdots$
且
$\varepsilon_1 \geq \varepsilon_2 \geq \cdots \geq \varepsilon_n \to 0$。

则有 $x_1, x_2, \cdots$ 为 Cauchy 列。 设
$\lim_{n \to \infty} x_n = x^*$。

注意到 $\forall n$，若 $i > n$ 则 $x_i \in S_n$。 $S_n$ 为闭球，故
$x^* \in S_n$。 所以 $x^*$ 为 $S_n$ 的公共点，也为 $O_n$
的公共点，矛盾。 ◻
:::

::: theorem
$X, Y$ 为 Banach 空间，$\{ L_\alpha \}$ 为 $X \to Y$
的一族有界线性算子。若 $\forall f \in X$
$$\sup_{\alpha} \| L_\alpha f \| < \infty$$ 则
$$\sup_{\alpha} \| L_\alpha \| < \infty$$
:::

::: proof
*Proof.* 令
$H_n = \{ f \in X : \sup_{\alpha} \| L_\alpha f \| \leq n \}$ 则 $H_n$
为闭集，且 $$X = \bigcup_{n=1}^{\infty} H_n$$

由定理 2.4.1 存在 $H_N$ 包含一个球
$S = \{ f : \| f - g \| \leq \varepsilon \}$ 任意 $\| u \| \leq 1$，则
$g + \varepsilon u \in S$ 从而
$$\| L_\alpha u \| = \| \varepsilon^{-1} L_\alpha (g + \varepsilon u - g) \|$$
$$\leq \| L_\alpha (g + \varepsilon u) \| + \| L_\alpha g \|$$
$$\leq \frac{2N}{\varepsilon}$$
$$\Rightarrow \| L_\alpha \| \leq \frac{2N}{\varepsilon}$$ ◻
:::

### 投影算子和Fourier级数投影 {#投影算子和fourier级数投影 .unnumbered}

若 $L^2 = L$ 则称线性算子 $L$ 为投影。 若 $G$ 是 $L$ 的值域，称 $L$ 是到
$G$ 上的投影。 定义 $S_n$ 为 Fourier 级数投影，即 $f \in C_{2\pi}$
$$(S_n f)(x) = \frac{a_0}{2} + \sum_{k=1}^{n} a_k \cos kx + b_k \sin kx$$
$$a_k = \frac{1}{\pi} \int_{-\pi}^{\pi} f(s) \cos ks \, ds$$
$$b_k = \frac{1}{\pi} \int_{-\pi}^{\pi} f(s) \sin ks \, ds$$

::: theorem
设 $L$ 是 $C_{2\pi}$ 到 $M_n$ 上的投影。 其中$M_n$ 为 $\leq n$
次三角多项式空间。则有 $$\| S_n \| \leq \| L \|$$
:::

::: proof
*Proof.* 定义算子 $T_\lambda$ 和 $\mathbb{A}$
$$(T_\lambda f)(x) = f(x + \lambda)$$
$$(\mathbb{A} f)(x) = \frac{1}{2\pi} \int_{-\pi}^{\pi} (T_{-\lambda} L T_\lambda f)(x) \, d\lambda$$

令 $f_k = e^{ikx}$，$k = 0, \pm 1, \pm 2 \cdots$ 若 $|k| \leq n$ 则有
$S_n f_k = f_k$
另一方面，$T_\lambda f_k \in M_n \Rightarrow L T_\lambda f_k = T_\lambda f_k$
$$\Rightarrow T_{-\lambda} L T_\lambda f_k = f_k \Rightarrow \mathbb{A} f_k = f_k$$

若 $|k| > n$，则 $S_n f_k = 0$ 此时 $T_\lambda f_k = e^{ik\lambda} f_k$
于是
$$(T_{-\lambda} L T_\lambda f_k)(x) = e^{ik\lambda} (L f_k)(x - \lambda)$$
另一方面 $L f_k \in M_n$ 则 $L f_k$ 看作$\lambda$的函数也属于
$M_n$，即作为 $\lambda$ 的函数 $e^{ik\lambda}$ 与 $(L f_k)(x - \lambda)$
正交，所以 $\mathbb{A} f_k = 0$。

由此可得 $\mathbb{A} = S_n$。 所以
$$\| S_n f \| = \| \mathbb{A} f \| = \max_{x \in [0, 2\pi]} \left| \frac{1}{2\pi} \int_{-\pi}^{\pi} (T_{-\lambda} L T_\lambda f)(x) \, d\lambda \right|$$
$$\leq \| T_{-\lambda} L T_\lambda f \| \leq \| L \| \| f \|$$
$$\Rightarrow \| S_n \| \leq \| L \|$$ 证毕. ◻
:::

::: proposition
令 $D_n(t) = \frac{\sin(n + \frac{1}{2})t}{2 \sin \frac{1}{2} t}$ 则
$$(S_n f)(x) = \frac{1}{\pi} \int_{-\pi}^{\pi} f(x + t) D_n(t) \, dt$$

令 $\lambda_n = \frac{1}{\pi} \int_{-\pi}^{\pi} |D_n(t)| \, dt$，**第
$n$ Lebesgue 常数**。

则 $$\| S_n \| \leq \lambda_n$$ 进一步可证 $\| S_n \| = \lambda_n$
:::

::: lemma
$$\lambda_n > \frac{4}{\pi^2} \log n$$
:::

::: proof
*Proof.* $$\begin{aligned}
\lambda_n &= \frac{2}{\pi} \int_{0}^{\frac{\pi}{2}} \frac{|\sin(2n+1)x|}{\sin x} \, dx \\
 &\geq \frac{2}{\pi} \int_{0}^{\frac{\pi}{2}} \frac{|\sin(2n+1)x|}{x} \, dx \\
 &= \frac{2}{\pi} \sum_{k=0}^{n-1} \int_{k}^{k+1} \frac{|\sin(2n+1)x|}{x} \, dx \\
 &= \frac{2}{\pi} \sum_{k=0}^{n-1} \int_{0}^{1} \frac{1}{z+k} \sin \pi z \, dz \\
 &\geq \frac{2}{\pi} \int_{0}^{1} \left( \sum_{k=0}^{n-1} \frac{1}{k+1} \right) \sin \pi z \, dz \\
 &\geq \frac{2}{\pi} \log n \int_{0}^{1} \sin \pi z \, dz \\
 &= \frac{4}{\pi^2} \log n \end{aligned}$$ ◻
:::

我们的目的是为了得到如下定理.

::: theorem
$\forall n \in \mathbb{N}$，$L_n$ 为 $C_{2\pi}$ 到 $M_n$ 上的投影。
则存在 $f \in C_{2\pi}$ 使得
$$\lim_{n \to \infty} \| L_n f \| = \infty$$
:::

::: proof
*Proof.* $$\| L_n \| \geq \| S_n \| \geq \frac{4}{\pi^2} \log n$$ 若
$\| L_n f \|$ 对所有 $f$ 有界，则由定理 2.4.2 $\| L_n \|$ 有界，矛盾。 ◻
:::

::: remark
当我们试图用 $M_n$ 中的函数去逼近 $f$ 时，投影算子 $L_n$
的结果可能变得极其"振荡"或"剧烈变化"，导致其范数趋于无穷大。这表明，即使是简单的连续函数，也可能存在无法通过简单的投影方法稳定逼近的情况。
:::

::: lemma
设 $L$ 是 $C_{2\pi}$ 中的偶函数到 $\leq n$
次偶三角多项式上的有界投影，则

$$\|I - L\| \geq \frac{1}{2} (\lambda_n + 1) > \frac{2}{\pi^2} \log n + \frac{1}{2}$$
:::

::: proof
*Proof.* 令

$$(\Phi f)(x) = \frac{1}{2\pi} \int_{-\pi}^{\pi} [T_\lambda(I-L)(T_{-\lambda} + T_\lambda)f](x) d\lambda$$

可证 $\Phi = I - S_n$

于是 $\|I-S_n\| \le 2\|I-L\|$, $\|I-S_n\| = 1+\lambda$.
(显然$\|I-S_n\|\le 1+\lambda$, 又可以取函数逼近取到) ◻
:::

::: theorem
$\forall n \in \mathbb{N}$，$L_n$ 为 $C[a,b]$ 到 $P_n$ 的投影，$P_n$ 为
$\leq n$ 次多项式空间。

则存在 $f \in C[a,b]$ 使得

$$\lim_{n \to \infty} \|f - L_n f\| = \infty$$
:::

::: proof
*Proof.* $\forall f \in C[a,b]$，令

$$(Tf)(t) = f\left(\frac{a+b}{2} + \frac{b-a}{2} \cos t\right)$$

则 $T$ 为 $C[a,b]$ 到 $C_{2\pi}$ 偶函数部分的等距同构，即 $T$
为双射、线性的并且

$$\|Tf\| = \|f\|$$

令 $$\Lambda_n^* = T \Lambda_n T^{-1}$$ 则 $\Lambda_n^*$ 为 $C_{2n}$
偶部分到 $\leq n$ 次偶三角多项式上的投影。由引理 2.4.2，
$$\| I - \Lambda_n^* \| \to \infty$$ 从而
$$\| I - \Lambda_n \| \to \infty$$ 由定理 2.4.2，存在 $f \in C[a, b]$
使得 $$\| f - \Lambda_n f \| \to \infty$$ ◻
:::

### 单调算子 {#单调算子 .unnumbered}

::: definition
算子 $B$ 称为单调算子若 $\forall f \geq g$ 有 $Bf \geq Bg$
:::

::: theorem
对于 $C[a,b]$ 上的单调线性算子序列 $L_n$，下列条件等价：

(1) $\forall f \in C[a,b]$，$\|L_n f - f\|_\infty \to 0$

(2) 对于 $f(x) = 1, x, x^2$，$\|L_n f - f\|_\infty \to 0$

(3) $\|L_n 1 - 1\|_\infty \to 0$ 且 $(L_n \phi_t)(t) \to 0$ (对
    $t \in [a,b]$ 一致) $\phi_t(x) = (t-x)^2$
:::

::: proof
*Proof.* (1) $\Rightarrow$ (2) 显然

\(2\) $\Rightarrow$ (3). 令 $f_i(x) = x^i$ 则

$$\phi_t(x) = t^2 f_0(x) - 2t f_1(x) + f_2(x)$$
$$(L_n \phi_t)(x) = t^2 (L_n f_0)(x) - 2t (L_n f_1)(x) + (L_n f_2)(x)$$

于是

$$|(L_n \phi_t)(t)| = t^2 ((L_n f_0)(t) - 1) - 2t ((L_n f_1)(t) - t) + (L_n f_2)(t) - t^2$$
$$\leq t^2 \|L_n f_0 - f_0\|_\infty + |2t| \|L_n f_1 - f_1\|_\infty + \|L_n f_2 - f_2\|_\infty$$
$$\leq b^2 \|L_n f_0 - f_0\|_\infty + 2b \|L_n f_1 - f_1\|_\infty + \|L_n f_2 - f_2\|_\infty$$
$$\to 0$$

\(3\) $\Rightarrow$ (1) $\forall f \in C[a,b]$ $\forall \varepsilon > 0$

存在 $\delta > 0$ 使得

$$|x - y| < \delta \Rightarrow |f(x) - f(y)| < \varepsilon$$

取 $t \in [a,b]$，若 $|t - x| < \delta$ 则

$$|f(t) - f(x)| < \varepsilon$$

若 $|t - x| \geq \delta$ 则

$$|f(t) - f(x)| \leq 2 \|f\|_\infty \leq 2 \|f\|_\infty \frac{(t-x)^2}{\delta^2} = \alpha \phi_t(x)$$

于是 $\forall x \in [a,b]$

$$-\varepsilon - \alpha \phi_t(x) \leq f(t) - f(x) \leq \varepsilon + \alpha \phi_t(x)$$

即
$-\varepsilon f_0 - \alpha \phi_t \leq f(t) f_0 - f \leq \varepsilon f_0 + \alpha \phi_t$

由于 $L_n$ 为单调线性算子，

$$-\varepsilon (L_n f_0)(t) - \alpha (L_n \phi_t)(t) \leq f(t) (L_n f_0)(t) - (L_n f)(t)$$
$$\leq \varepsilon (L_n f_0)(t) + \alpha (L_n \phi_t)(t)$$

$\Rightarrow |f(t) (L_n f_0)(t) - (L_n f)(t)| \leq \varepsilon (\|L_n f_0\|_\infty + \alpha L_n \phi_t(t))$

由于 $\|L_n f_0 - f_0\|_\infty \to 0$ 且 $L_n \phi_t(t) \to 0$

由此定理可证. ◻
:::

::: theorem
设 $\{L_n\}$ 是 $C_{2\pi}$ 上的单调线性算子序列，证明：
$$\lim_{n \to \infty} \| L_n f - f \|_{\infty} = 0, \quad \forall f \in C_{2\pi}$$
当且仅当对以下两种情况成立：

(i) $f(x) \equiv 1$

(ii) $f(x) = \sin x, \cos x$ 时，有
     $\lim_{n \to \infty} \| L_n f - f \|_{\infty} = 0$
:::

::: proof
*Proof.* $"\implies"$ 显然成立.

$"\impliedby"$

对于$C_{2\pi}$上的连续函数, 存在三角多项式逼近: $\forall \epsilon >0$,
存在三角多项式$S(f)$ 满足 $$\|S(f) - f\|_{\infty} < \epsilon$$

因为$\|L_n f - f\|_{\infty} \to 0$对于$1,\sin x, \cos x$成立,
所以对于$f$为三角多项式的情形也成立.

$$\begin{aligned}
    \|L_n f - f\|_\infty  &= \|L_nf - L_n S(f) + L_n S(f) - S(f) + S(f) - f\|_\infty \\ 
    & \le \|L_nf - L_n S(f)\|_\infty + \|L_n S(f) - S(f)\|_\infty + \|S(f) - f\|_\infty \\
    \end{aligned}$$

后两项都$\to 0$.

因为单调算子的性质,
$\|L_n (f - S(f))\| \le \|L_n \epsilon\| = \epsilon$. ◻
:::

### Fejér-Hermite 算子 {#fejér-hermite-算子 .unnumbered}

::: definition
在 Hermite 插值中取

$$y_i = f(x_i), \quad y_i' = 0$$

则可得 Fejér-Hermite 算子。

$$(Lf)(x) = \sum_{i=1}^{n} f(x_i) \left[1 - 2(x - x_i) \lambda_i'(x_i) \lambda_i^2(x)\right]$$
$$= \sum_{i=1}^{n} f(x_i) \left[1 - \frac{(x - x_i) \omega''(x_i)}{\omega'(x_i)}\right] \left[\frac{\omega(x)}{(x - x_i) \omega'(x)}\right]^2$$

$\omega(x) = (x - x_1) \cdots (x - x_n)$
:::

::: theorem
令$x_i = \cos \frac{(2i-1)\pi}{2n}$，$i=1,2,\cdots,n$. $L_n$
为以$x_i$为插值节点的Fejér-Hermite 算子。对任意 $f \in C[-1,1]$，都有
$$\|L_n f - f\| \to  0$$
:::

::: proof
*Proof.* 令 $T_n(x) = \cos(n \arccos(x))$，$x \in [-1,1]$

$T_n$ 为 $n$ 次多项式 (Chebyshev 多项式)

则

$$(L_nf)(x) = \frac{1}{n^2} T_n^2(x) \sum_{i=1}^{n} f(x_i) \frac{1 - x x_i}{(x - x_i)^2}$$

由此可得 $L_n$ 为单调算子。

由单调算子定理，只需验证

$$L_n 1 \rightarrow 1, \quad (L_n \phi_t)(t) \rightarrow 0$$

由 Hermite 插值的唯一性有

$$L_n 1 = 1$$
$$|(L_n \phi_t)(t)| = \left| \frac{1}{n^2} T_n^2(t) \sum_{i=1}^{n} (t - x_i)^2 \frac{1 - t x_i}{(t - x_i)^2} \right|$$
$$\leq \frac{1}{n^2} \cdot 2n = \frac{2}{n} \rightarrow 0$$ ◻
:::

### 编者注

::: definition
设插值节点为 $x_0, x_1, \dots, x_n \in [-1, 1]$，Lagrange 基函数为
$\ell_i(x)$（满足 $\ell_i(x_j) = \delta_{ij}$），则 **Lebesgue 常数**
$\Lambda_n$ 定义为：
$$\Lambda_n = \max_{x \in [-1, 1]} \sum_{i=0}^n |\ell_i(x)|.$$
它表示所有插值基函数的绝对值之和在区间 $[-1, 1]$ 上的最大值。
:::

::: proposition
对于任意连续函数 $f$，Lagrange 插值多项式 $L_n f$ 的误差满足：
$$\| L_n f - f \|_\infty \leq (1 + \Lambda_n) \cdot \inf_{p \in \mathcal{P}_n} \| p - f \|_\infty = (1 + \Lambda_n) E_n(f)$$
其中 $\mathcal{P}_n$ 是次数不超过 $n$ 的多项式空间。
:::

::: proof
*Proof.*
$$\|L_n f - f\| = \|L_n(f-p) - (f-p)\| \le \|L_n(f-p)\| + \|f-p\| \le (\Lambda_n+1) \|f-p\|$$ ◻
:::

::: proposition
设函数 $f \in C[-1, 1]$，且满足
$$\lim_{\delta \to 0^+} \omega(\delta, f) \log \delta = 0$$ 其中
$\omega(\delta, f)$ 为 $f$ 的连续模。若 $Q_0, Q_1, \dots$ 为区间
$[-1, 1]$ 上的 Chebyshev 多项式，$L_n$ 是以 $Q_{n+1}$ 的零点为插值节点的
Lagrange 插值多项式，证明：
$$\lim_{n \to \infty} \| L_n f - f \|_{\infty} = 0$$
:::

::: proof
*Proof.* $$\|L_n f - f\| \le (\Lambda_n+1) \|f-p\|.$$

使用$Q_{n+1}$的零点作为插值节点时,
$$\Lambda_n = \max_{x\in[-1,1]} \sum_{i=0}^n |\ell_i(x)| = \max_{\theta\in [0,\pi]} \sum_{i=0}^n \left|\prod_{j\ne i} \frac{\cos \theta-\cos(\theta_j)}{\cos(\theta_i) - \cos(\theta_j)}\right|$$

注意到 $$\ell_k (x) = \frac{T_n(x)}{(x-x_k)T_n'(x_k)}
     = \frac{\cos(n\theta)}{(x-x_k)(-\frac{(-1)^{k-1}}{\sin \theta_k})} = \frac{\sin(n(\theta-\theta_k))\sin\theta_k}{2n\sin\frac{\theta-\theta_k}{2} \sin \frac{\theta+\theta_k}{2}}$$

$$\sum_{i=0}^n |\frac{\sin(n(\theta-\theta_k))\sin\theta_k}{2n\sin\frac{\theta-\theta_k}{2} \sin \frac{\theta+\theta_k}{2}}|$$

$\theta \to \theta_k$时

$$\frac{\sin(n(\theta-\theta_k))\sin\theta_k}{2n\sin\frac{\theta-\theta_k}{2} \sin \frac{\theta+\theta_k}{2}} \to 1$$

在其他$j\ne k$

$$\frac{\sin(n(\theta-\theta_j))\sin\theta_k}{2n\sin\frac{\theta-\theta_j}{2} \sin \frac{\theta+\theta_k}{2}} \le \pi\frac{1}{2n (\theta - \theta_j) }$$

所以$$\sum_{i=0}^n |\frac{\sin(n(\theta-\theta_k))\sin\theta_k}{2n\sin\frac{\theta-\theta_k}{2} \sin \frac{\theta+\theta_k}{2}}| \sim \log n$$

所以
$\|L_n f -f\| \le (\Lambda_n+1)\|f-p\| \le C \log n E_n(f) \le C \log(n) \omega(\frac{1}{n}, f) \to 0$. ◻
:::

## 分段插值, 三次样条插值

$a = x_0 < x_1 < \cdots < x_n = b$

在每个区间 $[x_j, x_{j+1}]$，$j = 0, \cdots, n-1$ 上分别构建插值多项式

-   Lagrange 插值 $\rightarrow$ 分段线性插值

-   Hermite 插值 $\rightarrow$ 分段三次 Hermite 插值

由定理2.1.2和定理2.3.1分别可得分段线性插值误差为

$$|f(x) - \varphi(x)| \leq \frac{h^2}{8} \| f'' \|_{\infty}$$

其中 $\varphi(x)$ 为分段线性插值多项式，

$$h = \max_{0 \leq j \leq n-1} |x_{j+1} - x_j|$$

$$|f(x) - \varphi(x)| \leq \frac{1}{384} h^4 \| f^{(4)} \|_{\infty}$$

其中 $\varphi(x)$ 为分段三次Hermite插值多项式。

### 三次样条插值 {#三次样条插值 .unnumbered}

::: definition
给定剖分：

$$\Delta: a = x_0 < x_1 < \cdots < x_n = b$$

$S$ 为 $[a, b]$ 满足下列条件的函数：

1.  $S \in C^2[a, b]$

2.  $S$ 在 $[x_j, x_{j+1}]$，$j=0,\cdots,n-1$ 上是三次多项式

则称 $S$ 是关于剖分 $\Delta$ 的一个**三次样条函数**。

设 $f: [a, b] \rightarrow \mathbb{R}$，若 $S$ 满足

$$S(x_j) = f(x_j), \quad j=0,\cdots,n$$

则称 $S$ 是 $f$ 关于剖分 $\Delta$ 的一个**三次样条插值函数**。
:::

设 $S(x) = S_j(x) = a_j x^3 + b_j x^2 + c_j x + d_j$
$$x \in [x_j, x_{j+1}], \quad j=0,\cdots,n-1$$ 需确定 $4n$ 个系数。

已有条件：

$$S_j(x_j) = f(x_j), \quad j=0,\cdots,n-1$$
$$S_{j-1}(x_j) = f(x_j), \quad j=1,\cdots,n$$
$$S'_j(x_j) = S'_{j-1}(x_j), \quad j=1,\cdots,n-1$$
$$S''_j(x_j) = S''_{j-1}(x_j), \quad j=1,\cdots,n-1$$

尚缺两个条件，由边界条件补充：

1\. I型边界条件

$$S'(x_0) = f'(x_0), \quad S'(x_n) = f'(x_n)$$

2\. II型边界条件

$$S''(x_0) = f''(x_0), \quad S''(x_n) = f''(x_n)$$

3\. 周期边界条件

$$S(x_0) = S(x_n), \quad S'(x_0) = S'(x_n), \quad S''(x_0) = S''(x_n)$$

### 三次样条插值函数的计算方法 {#三次样条插值函数的计算方法 .unnumbered}

设 $M_j = S''(x_j)$，$S(x) = S_j(x)$ 在 $[x_j, x_{j+1}]$
上为三次多项式，故有 $S''_j(x)$ 在 $[x_j, x_{j+1}]$ 上为线性函数。且有
$S''_j(x_j) = M_j$，$S''_j(x_{j+1}) = M_{j+1}$

$$\Rightarrow S''_j(x) = M_j \frac{x_{j+1} - x}{h_j} + M_{j+1} \frac{x - x_j}{h_j}, \quad x \in [x_j, x_{j+1}]$$

$$\Rightarrow S'_j(x) = -\frac{M_j}{2h_j} (x_{j+1} - x)^2 + \frac{M_{j+1}}{2h_j} (x - x_j)^2 + C_1$$

$$S_j(x) = \frac{M_j}{6h_j} (x_{j+1} - x)^3 + \frac{M_{j+1}}{6h_j} (x - x_j)^3 + C_1 x + C_2$$

利用 $S_j(x_j) = f(x_j)$，$S_j(x_{j+1}) = f(x_{j+1})$

可以得到 $C_1, C_2$ 代入 $S_j(x)$ 可得

$$S_j(x) = \frac{M_j}{6h_j} (x_{j+1} - x)^3 + \frac{M_{j+1}}{6h_j} (x - x_j)^3 + \left(f(x_j) - \frac{M_j h_j^2}{6}\right) \frac{x_{j+1} - x}{h_j}$$

$$+ \left(f(x_{j+1}) - \frac{M_{j+1} h_j^2}{6}\right) \frac{x - x_j}{h_j}, \quad x \in [x_j, x_{j+1}]$$

为确定 $M_j$，利用条件

$$S'_j(x_j) = S'_{j-1}(x_j), \quad j=1,\cdots,n-1$$

$$S'_j(x_j) = -\frac{h_j}{2} M_j + \frac{1}{h_j} (f(x_{j+1}) - f(x_j)) - \frac{M_{j+1} - M_j}{6} h_j$$

$$S'_{j-1}(x_j) = \frac{h_{j-1}}{2} M_j + \frac{1}{h_{j-1}} (f(x_j) - f(x_{j-1})) - \frac{M_j - M_{j-1}}{6} h_{j-1}$$

$$\Rightarrow \mu_j M_{j-1} + 2M_j + \lambda_j M_{j+1} = d_j, \quad j=1,2,\cdots,n-1 \tag{7.4.1}$$

$$\mu_j = \frac{h_{j-1}}{h_{j-1} + h_j}, \quad \lambda_j = 1 - \mu_j, \quad d_j = 6 f[x_{j-1}, x_j, x_{j+1}]$$

$\blacksquare$ II型边界条件

$$M_0 = f''(x_0), \quad M_n = f''(x_n)$$

(7.4.1) 化为

$$\begin{bmatrix}
2 & \lambda_1 & & \\
\mu_2 & 2 & \lambda_2 & \\
& \ddots & \ddots & \ddots \\
& & \mu_{n-2} & 2 & \lambda_{n-2} \\
& & & \mu_{n-1} & 2
\end{bmatrix}
\begin{bmatrix}
M_1 \\
\vdots \\
\vdots \\
\vdots \\
M_{n-1}
\end{bmatrix}
=
\begin{bmatrix}
d_1 - \mu_1 M_0 \\
d_2 \\
\vdots \\
d_{n-2} \\
d_{n-1} - \lambda_{n-1} M_n
\end{bmatrix}$$

$\blacksquare$ I型边界条件：

$$S'(x_0) = -\frac{h_0}{3} M_0 - \frac{h_0}{6} M_1 + f[x_0, x_1] = f'(x_0)$$

$$\Rightarrow 2M_0 + M_1 = \frac{6}{h_0} (f[x_0, x_1] - f'(x_0))$$

同样可得

$$M_{n-1} + 2M_n = \frac{6}{h_{n-1}} (f'(x_n) - f[x_{n-1}, x_n])$$

结合 (7.4.1) 可得

$$\begin{bmatrix}
2 & 1 & & \\
\mu_1 & 2 & \lambda_1 & \\
& \mu_2 & 2 & \lambda_2 & \\
& & \ddots & \ddots & \ddots \\
& & &\mu_{n-1} & 2 & \lambda_{n-1} \\
& & & & 1 & 2
\end{bmatrix}
\begin{bmatrix}
M_0 \\
M_1 \\
\vdots \\
\vdots \\
M_{n-1} \\
M_n
\end{bmatrix}
=
\begin{bmatrix}
d_0 \\
d_1 \\
\vdots \\
\vdots \\
d_{n-1} \\
d_n
\end{bmatrix}$$

$$d_0 = \frac{6}{h_0} (f[x_0, x_1] - f'(x_0))$$

$$d_n = \frac{6}{h_{n-1}} (f'(x_n) - f[x_{n-1}, x_n])$$

$\blacksquare$ 周期边界条件

$$\begin{cases}
M_n = M_0 \\
\mu_n M_{n+1} + 2M_n + \lambda_n M_1 = d_n
\end{cases}$$

$$\lambda_n = \frac{h_0}{h_{n-1} + h_0}, \quad \mu_n = 1 - \lambda_n, \quad d_n = \frac{6(f[x_0, x_1] - f[x_{n-1}, x_n])}{h_0 + h_{n-1}}$$

结合 (7.4.1) 可得

$$\begin{bmatrix}
2 & \lambda_1 & & & \mu_1 \\
\mu_2 & 2 & \lambda_2 & \\
& \ddots & \ddots & \ddots \\
& & \mu_{n-1} & 2 & \lambda_{n-1} \\
\lambda_n & &  &  \mu_n & 2
\end{bmatrix}
\begin{bmatrix}
M_1 \\
\vdots \\
\vdots \\
M_{n-1} \\
M_n
\end{bmatrix}
=
\begin{bmatrix}
d_1 \\
\vdots \\
\vdots \\
d_{n-1} \\
d_n
\end{bmatrix}$$

::: theorem
$f \in C^4[a, b]$，$S$ 为 $f$ 在 $[a, b]$ 上关于剖分 $\Delta$ 满足
I型边界条件的三次样条插值函数，则有

$$\| f - S \|_{\infty} \leq \frac{5}{384} h^4 \| f^{(4)} \|_{\infty}$$

其中 $h = \max_{0 \leq j \leq n-1} |x_{j+1} - x_j|$
:::

::: lemma
设 $A = [a_{ij}] \in \mathbb{R}^{m \times n}$ 严格对角占优，则有
$$||A^{-1}||_{\infty} \leq \left[ \min_{l \leq i \leq n} \left( |a_{ii}| - \sum_{j=1}^{n} |a_{ji}| \right) \right]^{-1}$$
:::

::: proof
*Proof.*
$||A^{-1}||_{\infty} = \max_{|x_i|_\infty = 1} ||A^{-1}x||_{\infty} = \min_{|x_i|_\infty = 1} ||Ax||_{\infty}$

对于任意 $||x||_{\infty} = 1$，设 $|x_k| = 1$，则有
$$||Ax||_{\infty} \geq |a_{kk}| - \sum_{j=1}^{n} |a_{kj}| \geq \min_{l \leq i \leq n} \left( |a_{il}| - \sum_{j=1}^{n} |a_{ij}| \right)$$ ◻
:::

::: lemma
设 $f \in C^4[a,b]$，$S$ 是 $f$ 在 $[a,b]$ 上关于剖分
$\Delta : a = x_0 < x_1 < \cdots < x_n = b$ 的满足 $I$
型边界条件的三次样条插值函数，则有
$$|m_j - f_j'| \leq \frac{1}{24} h^3 ||f^{(4)}||_{\infty}$$ 其中
$m_j = S'(x_j')$，$f_j' = f'(x_j')$，$h = \max_{0 \leq j \leq n-1} (x_{j+1} - x_j)$
:::

::: proof
*Proof.* 首先在 $[x_j, x_{j+1}]$ 上 $S$ 为三次多项式且可以表示为
$$S(x) = f(x_j) \alpha_j(x) + f(x_{j+1}) \alpha_{j+1}(x) + m_j \beta_j(x) + m_{j+1} \beta_{j+1}(x)$$
其中 $\alpha_j, \alpha_{j+1}, \beta_j, \beta_{j+1}$ 为三次 Hermit
插值基函数。

首先来确定 $m_j, j = 0, 1, \dots, n$. 对上式两边求二阶导数：
$$S''(x) = \frac{6x - 2x_j - 4x_{j+1}}{h_j^2} m_j + \frac{6x - 4x_j - 2x_{j+1}}{h_j^2} m_{j+1}
+ \frac{6(x_j + x_{j+1} - 2x)}{h_j^2} [f(x_{j+1}) - f(x_j)].$$

于是
$$S''(x_j^+) = -\frac{4}{h_j} m_j - \frac{2}{h_j} m_{j+1} + \frac{6}{h_j} [f(x_{j+1}) - f(x_j)].$$

同理可以在 $[x_{j-1}, x_j]$ 上考虑 $S$ 的表达式，可以得
$$S''(x_j^-) = \frac{2}{h_{j-1}} m_{j-1} + \frac{4}{h_{j-1}} m_j - \frac{6}{h_{j-1}} [f(x_j) - f(x_{j-1})].$$

由于 $S \in C^2[a, b]$，因此有
$S''(x_j^+) = S''(x_j^-), j = 1, 2, \dots, n-1$. 由此得到线性代数方程组
$$\lambda_j m_{j-1} + 2m_j + \mu_j m_{j+1} = d_j, \quad j = 1, 2, \dots, n-1,$$
其中 $\lambda_j = h_{j-1}$.

利用三次样条插值条件 $S''(x_j^+) = S''(x_j^-)$ 可以得到 $m_j$ 满足的方程
$$\lambda_j m_{j-1} + 2m_j + \mu_j m_{j+1} = d_j, \quad j=1,2,\cdots,n-1 \tag{1}$$

其中
$\lambda_j = \frac{h_j}{h_{j-1}+h_j}, \quad \mu_j = \frac{h_{j-1}}{h_{j-1}+h_j}, \quad h_j = x_{j+1}-x_j$

$$d_j = 3(\lambda_j f[x_{j-1}, x_j] + \mu_j f[x_j, x_{j+1}])$$ 再利用 I
型边界条件： $$m_0 = f'(x_0), \quad m_n = f'(x_n)$$ 由此得到
$m_1, \cdots, m_{n-1}$ 满足的线性方程组 $$A m = b  \tag{2}$$ $$A = 
\begin{bmatrix}
2 & \mu_1 & & \\
\lambda_2 & 2 & \mu_2 & \\
& & \ddots & \\
& & & \ddots  & \mu_{n-2} \\
& & &   \lambda_{n-1} & 2
\end{bmatrix},
\quad m = [m_1, \cdots, m_{n-1}]$$

$$b = (d_1 - \lambda_1 f'(x_0), \quad d_2, \cdots, d_{n-2}, \quad d_{n-1} - \mu_{n-1} f'(x_n))^T$$
令 $q = [m_1 - f_1', \cdots, m_{n-1} - f'_{n-1}]$，由 (2) 可得。
$$A q = \mathbf{c}$$ 其中 $\mathbf{c} = [c_1, \cdots, c_{n-1}]^T$
$$c_j = d_j - \lambda_j f'(x_{j-1}) - 2f'(x_j) - \mu_j f'(x_{j+1})$$

由引理2.5.1得，$$||A^{-1}||_{\infty} \leq 1$$

故有
$$||q||_{\infty} \leq ||A^{-1}||_{\infty} ||\mathbf{c}||_{\infty} \leq ||\mathbf{c}||_{\infty}$$

由于 $f \in C^{4}[a,b]$，利用 Taylor 展开可得

$$\begin{aligned}
    c_j  = &  3\mu_j \frac{1}{h_j} (f_{j+1} - f_j) + 3\lambda_j \frac{1}{h_{j-1}} (f_j - f_{j-1}) -\lambda_j f_{j-1}' - 2f_j' - \mu_j f_{j+1}' \\
    = & 3\mu_j [f_j' + \frac{1}{2} h_j f_j'' + \frac{1}{6} h_j^2 f_j''' + \frac{1}{6h_j} \int_{x_j}^{x_{j+1}} (x_{j+1} - v)^3 f^{(4)} (v) dv] \\
    & + 3\lambda_j [f_j' - \frac{1}{2} h_{j-1} f_j'' + \frac{1}{6} h_{j-1}^2 f_j''' - \frac{1}{6 h_{j-1}}\int_{x_j}^{x_{j+1}} (x_{j+1} - v)^3 f^{(4)} (v) dv] \\
    & - \lambda_j [f_j' - h_{j-1} f_j'' + \frac{1}{2} h_{j-1}^2 f_j''' + \frac{1}{2} \int_{x_j}^{x_{j+1}} (x_{j+1} - v)^2 f^{(4)} (v) dv] - 2 f_j' \\
    & - \mu_j [f_j' + h_j f_j'' + \frac{1}{2} h_j^2 f_j''' + \frac{1}{2} \int_{x_j}^{x_{j+1}} (x_{j+1} - v)^2 f^{(4)} (v) dv] \\
    = & \frac{1}{2} \mu_j \int_{x_j}^{x_{j+1}} \left[ \frac{1}{h_j} (x_{j+1} - v)^3 - (x_{j+1} - v)^2 \right] f^{(4)} (v) dv \\
    & + \frac{1}{2} \lambda_j \int_{x_j}^{x_{j+1}} \left[ -\frac{1}{h_{j-1}} (x_{j+1} - v)^3 - (x_{j+1} - v)^2 \right] f^{(4)} (v) dv \\
    &= -\frac{1}{2} \mu_j h_j^3 \int_0^1 z (1-z)^2 f^{(4)}(x_j + zh_j) \, dz \\
    &+ \frac{1}{2} \lambda_j h_{j-1}^3 \int_0^1 z^2 (1-z) f^{(4)}(x_{j-1} + zh_{j-1}) \, dz \\
\end{aligned}$$

$$\begin{aligned}
    \Rightarrow \quad &|c_j| \leq \frac{1}{2} \mu_j h_j^3 \|f^{(4)}\|_\infty \int_0^1 z (1-z)^2 \, dz \\
    &+ \frac{1}{2} \lambda_j h_{j-1}^3 \|f^{(4)}\|_\infty \int_0^1 z^2 (1-z) \, dz \\
    &= \frac{1}{2} \|f^{(4)}\|_\infty \left( \frac{1}{12} \mu_j h_j^3 + \frac{1}{12} \lambda_j h_{j-1}^3 \right) \\
    &\leq \frac{1}{24} h^3 \|f^{(4)}\|_\infty
\end{aligned}$$ ◻
:::

::: remark
$$\alpha_i(x) = \left(\frac{x-x_{i+1}}{h_i}\right)^2 \left(1+2\frac{x-x_i}{h_i}\right),\quad \alpha_{i+1}(x) = \left(\frac{x-x_i}{h_i}\right)^2 \left(1+2\frac{x_{i+1}-x}{h_i}\right)$$
$$\beta_i(x) = (x-x_i) \left(\frac{x-x_{i+1}}{h_i}\right)^2, \quad \beta_{i+1}(x) = (x-x_{i+1}) \left(\frac{x-x_i}{h_i}\right)^2$$
导数值
:::

::: theorem
设 $f \in C^4[a,b]$，$S$ 为 $f$ 在 $[a,b]$ 上关于剖分
$\Delta$：$a = x_0 < x_1 < \cdots < x_n = b$ 的满足 I
型边界条件的三次样条插值函数，则有
$$||S - f||_{\infty} \leq \frac{5}{384} h^4 ||f^{(4)}||_{\infty}$$
:::

::: proof
*Proof.* 令 $\varphi(x)$ 为 $[a,b]$ 上关于剖分 $\Delta$ 的分段三次
Hermit 插值函数，即
$$\varphi(x) = f(x_j) \alpha_j^\prime (x) + f(x_{j+1}) \alpha_{j+1}^\prime (x) + f^\prime (x_j) \beta_j (x) + f^\prime (x_{j+1}) \beta_{j+1} (x), x \in [x, x_i]$$

利用三次 Hermit 插值多项式的误差估计有
$$| \varphi(x) - f(x) | \leq \frac{1}{384} h^4 ||f^{(4)}||_{\infty}, \quad x \in [x_j, x_{j+1}]$$
另一方面，由引理2.5.2
$$| S(x) - \varphi(x) | = (m_j - f_j') \beta_j(x) + (m_{j+1} - f_{j+1}) \beta_j(x)$$
$$\leq \frac{1}{24} h^3 ||f^{(4)}||_{\infty} (|\beta_j(x)| + |\beta_{j+1}(x)|)$$
由 $\beta_j$、$\beta_{j+1}$ 的表达式可得
$$|\beta_j(x)| + |\beta_{j+1}(x)| \leq \frac{h}{4}, \quad x \in [x_j, x_{j+1}]$$
由此定理得证。
$$|S(x) - f(x)| \leq |S(x) - \varphi(x)| + |\varphi(x) - f(x)|$$
$$\leq \frac{5}{384} h^4 ||f^{(4)}||_{\infty}$$ ◻
:::

### B-样条函数 {#b-样条函数 .unnumbered}

在区间 $[a, b]$ 上给定剖分 $\Delta : a = x_0 < x_1 < \cdots < x_n = b$。

令 $S^n_3$ 为关于剖分 $\Delta$ 的三次样条函数的集合。

容易验证 $S^n_3$ 为线性空间。

::: theorem
$$\dim(S_3^n) = n+3$$
:::

::: proof
*Proof.* $\blacksquare$ 令 $$u_k(x) = (x-x_0)^k, \quad k=0,1,2,3$$

$$v_k(x) = (x-x_0)^3_+ , \quad k=1,2,\cdots,n-1.$$

首先证明其线性无关

$$\sum_{k=0}^3 \alpha_k u_k(x) + \sum_{k=1}^{n-1} \beta_k v_k(x) = 0$$

对于 $x \in [x_0, x_1]$，$v_k(x) = 0$，$k=1,\cdots,n-1$

故
$$\sum_{k=0}^3 \alpha_k u_k(x) = \sum_{k=0}^3 \alpha_k x^k = 0 \implies \alpha_k = 0$$

$$\Rightarrow \sum_{k=1}^{n-1} \beta_k v_k(x) = 0$$

对于 $x \in [x_1, x_2]$，$v_k(x) = 0$，$k=2,\cdots,n-1$

$$\Rightarrow \beta_1 v_1(x) = 0 \implies \beta_1 = 0$$

依次类推可得 $\beta_k = 0$，$k=1,\cdots,n-1$

故有 $u_k, v_j, k=0\cdots3, j=1\cdots n-1$ 线性无关。

$\blacksquare$ 另一方面 $\forall S \in S_3^n$

对于 $x \in [x_0, x_1]$, $S$ 为三项多项式，所以存在

$$\alpha_0 \cdots \alpha_3 \quad 使得$$

$$S(x) = \sum_{k=0}^3 \alpha_k u_k(x), \quad x \in [x_0, x_1]$$

假设对于 $j > 1$ 存在 $\alpha_0 \cdots \alpha_j$,
$\beta_1 \cdots \beta_{j-1}$ 使得

$$S(x) = \sum_{k=0}^3 \alpha_k u_k(x) + \sum_{k=1}^{j-1} \beta_k v_k(x), \quad x \in [x_0, x_j]$$

令
$S_j(x) = S(x) - \sum_{k=0}^3 \alpha_k u_k(x) - \sum_{k=1}^{j-1} \beta_k v_k(x)$

则有 $S_j(x_j) = S_j'(x_j) = S_j''(x_j) = 0$

由于 $S_j(x)$ 在 $[x_j, x_{j+1}]$ 上为三项多项式

设有 $S_j(x) = \beta_j v_j(x), \quad x \in [x_j, x_{j+1}]$

所以存在 $\alpha_0 \cdots \alpha_j$, $\beta_1 \cdots \beta_j$ 使得

$$S(x) = \sum_{k=0}^3 \alpha_k u_k(x) + \sum_{k=1}^{j-1} \beta_k v_k(x), \quad x \in [x_0, x_{j+1}]$$

由数学归纳法知存在 $\alpha_0 \cdots \alpha_j$,
$\beta_1 \cdots \beta_{n-1}$

使得

$$S(x) = \sum_{k=0}^3 \alpha_k u_k(x) + \sum_{k=1}^{n-1} \beta_k v_k(x), \quad x \in [a, b]$$ ◻
:::

B - 样条：

$$B_{0}(x) = 
\begin{cases} 
1, & |x| \leq \frac{1}{2} \\ 
0, & |x| > \frac{1}{2} 
\end{cases}$$

$$B_{m+1}(x) = \int_{x-\frac{1}{2}}^{x+\frac{1}{2}} B_m(x) \, dx$$

容易验证

-   $B_3(x) \in C^2$

-   $B_3(x) = 0, \, |x| \geq 2$

-   $B_3(x)$ 在 $[-2,-1], [-1,0], [0,1], [1,2]$ 上为三次多项式

::: lemma
$B_3(x), \, B_3(x-1), \, B_3(x-2), \, B_3(x-3)$ 在 $[1,2]$
上线性无关。（练习）
:::

::: lemma
对于 $[a,b]$ 上的等距剖分 $x_j = a + jh, \, j = 0 \cdots n$

$$h = \frac{b-a}{n},$$
$$B_3 \left( \frac{x-a-kh}{h} \right), \, k = -1, 0, \cdots n + 1$$

是 $S_3^n$ 的一组基。
:::

::: remark
利用这组基可以计算等距剖分上的三次样条插值函数。
:::

前面介绍的 B-样条函数 $B_3(x)$
是在等距节点下定义的。对于一般节点（即非等距剖分），B-样条的定义和性质会变得更复杂一些，但它们仍然是构建样条函数的强大工具。

对于给定区间 $[a, b]$ 上的任意剖分
$\Delta : a = x_0 < x_1 < \cdots < x_n = b$，三次
B-样条函数通常通过**归一化 B-样条 (Normalized B-splines)** 来定义。

### 节点向量 (Knot Vector) {#节点向量-knot-vector .unnumbered}

在定义一般节点的 B-样条时，我们需要引入一个**节点向量** (knot
vector)。这个向量包含了一系列升序排列的实数，它们决定了
B-样条的形状和支持区间。对于 $k$ 阶 B-样条（对应于 $k-1$
次多项式，例如三次样条是 4 阶，即 $k=4$），我们需要 $n+k$ 个节点来定义
$n$ 个 B-样条。

对于一个 $k$ 阶 B-样条，如果剖分点是
$x_0, x_1, \ldots, x_n$，那么为了定义所有在 $[x_0, x_n]$ 区间上的 $k$ 阶
B-样条，我们需要在两端重复节点，通常做法是：
$$t_0 \le t_1 \le \cdots \le t_{m+k}$$ 其中 $m$ 是
B-样条的个数。为了在区间 $[x_0, x_n]$ 上构建 B-样条基，我们通常选择：

-   **内部节点**: $t_k, t_{k+1}, \ldots, t_m$ 对应于剖分点
    $x_0, x_1, \ldots, x_n$。

-   **边界节点**:
    为了确保在边界上的样条函数能够很好地定义，我们会在两端重复 $k$
    次边界节点。例如，对于 $k$ 阶 B-样条，我们会设置
    $t_0 = t_1 = \cdots = t_{k-1} = x_0$ 和
    $t_{m+1} = \cdots = t_{m+k} = x_n$。

所以，一个 $k$ 阶 B-样条函数的节点向量通常会包含 $n+k$ 个节点，其中 $n$
是内部节点的数量（对应于区间数 $n$），而 $k$ 是 B-样条的阶数。

### B-样条的递归定义 (Cox-De Boor 递推公式) {#b-样条的递归定义-cox-de-boor-递推公式 .unnumbered}

一般节点的 B-样条函数 $N_{i,k}(x)$ 可以通过 Cox-De Boor 递推公式定义：

**0 阶 B-样条（piecewise constant）:**
$$N_{i,0}(x) = \begin{cases} 1 & \text{if } t_i \le x < t_{i+1} \\ 0 & \text{otherwise} \end{cases}$$
（注意：如果 $t_i = t_{i+1}$，则 $N_{i,0}(x)$ 通常定义为 0。）

**$k$ 阶 B-样条:**
$$N_{i,k}(x) = \frac{x - t_i}{t_{i+k} - t_i} N_{i,k-1}(x) + \frac{t_{i+k+1} - x}{t_{i+k+1} - t_{i+1}} N_{i+1,k-1}(x)$$
其中，如果分母为零，对应的项被定义为零。

对于三次样条，我们使用 $k=4$。这意味着 $N_{i,4}(x)$ 是由 $N_{i,3}(x)$ 和
$N_{i+1,3}(x)$ 线性组合而成的，依此类推，直到 $N_{i,0}(x)$。

### 一般节点 B-样条的性质 {#一般节点-b-样条的性质 .unnumbered}

与等距 B-样条类似，一般节点的 B-样条也具有一些重要的性质：

-   **局部支持性**: 每个 $N_{i,k}(x)$ 只在有限的区间 $[t_i, t_{i+k+1}]$
    上非零。这意味着样条函数的改变只会影响局部区域。

-   **非负性**: 对于所有 $i, k, x$，都有 $N_{i,k}(x) \ge 0$。

-   **归一性**: 对于任何
    $x \in [t_k, t_{m+1}]$（如果节点向量是开放的，或者说在边界重复节点的情况下，在
    $[t_{k-1}, t_{m+1}]$ 之间），所有 $k$ 阶 B-样条的和为
    1：$\sum_{i} N_{i,k}(x) = 1$。

-   **光滑性**: 如果节点是单重的（不重复），则 $N_{i,k}(x)$ 在节点处具有
    $k-1$ 阶连续导数。如果节点重复 $r$ 次，那么在该节点处的连续性会降低
    $r$ 阶。例如，对于三次
    B-样条（$k=4$），如果节点是单重的，则在节点处是 $C^3$
    连续的。如果节点重复一次，则在节点处是 $C^2$
    连续的，这正是三次样条所要求的。

### B-样条作为基 {#b-样条作为基 .unnumbered}

对于给定剖分
$\Delta: a = x_0 < x_1 < \cdots < x_n = b$，我们可以构造一组在区间
$[a,b]$ 上定义的三次
B-样条基。具体如何构造这组基取决于如何选择节点向量。

一种常用的方法是构造 $n+3$ 个三次 B-样条作为 $S_3^n$
的基。这是因为我们之前证明了 $\dim(S_3^n) = n+3$。

## 离散点集上的最佳逼近多项式

令 $(X, d)$ 为紧距离空间。 $Y \subset X$。

$$|Y| = \max_{x \in X} \inf_{y \in Y} d(x, y)$$

$$||f||_Y = \sup_{y \in Y} |f(y)|$$

::: lemma
设 $g_1 \cdots g_n \in C(X)$ 则

$$\forall \alpha > 1, \exists \delta > 0 \quad 使得 \quad \forall p = \sum_{i=1}^n c_i g_i$$

以及 $|Y| < \delta$ 有

$$||p||_X \leq \alpha ||p||_Y$$
:::

::: proof
*Proof.* 不妨设 $g_1 \cdots g_n$ 线性无关

设 $\theta = \min_{\sum_{i=1}^n |c_i| = 1} ||\sum_{i=1}^n c_i g_i||$

由于 $g_1 \cdots g_n$ 线性无关，故 $\theta > 0$

令
$$\Omega(\delta) = \max_{1 \leq i \leq n} \max_{d(x,y) \leq \delta} |g_i(x) - g_i(y)|= \max_{1 \leq i \leq 1} w(\delta, g_i)$$

则 $$\lim_{\delta \to 0} \Omega(\delta) = 0$$

取 $\delta$ 充分小，使得 $\Omega(\delta) < \theta$

考虑，$P = \sum_{i=1}^{n} c_i g_i$，取 $x \in X$，使得
$$|P(x)| = ||P||_X.$$

则对 $\forall y \in Y, d(x, y) < \delta$ 有 $$\begin{aligned}
\theta \sum_{i=1}^{n} |c_i| & \leq ||P||_X = |P(x)| \\
&\leq |P(x) - P(y)| + |P(y)| \\
&\leq \sum_i |c_i||g_i(x) - g_i(y)| + ||P||_Y \\
&\leq \Omega(\delta) \sum_i |c_i| + ||P||_Y 
\end{aligned}$$
$$\Rightarrow \sum_i |c_i| \leq \frac{||P||_Y}{\theta - \Omega(\delta)}$$

$$||P||_X \leq \Omega(\delta) \frac{||P||_Y}{\theta - \Omega(\delta)} + ||P||_Y= (1- \frac{\Omega(\delta)}{\theta - \Omega(\delta)}) ||P||_Y$$ ◻
:::

::: lemma
$f, g, \ldots g_n \in C(X)$. $$Y\subset X, |Y| < \delta$$, 则
$\exists \beta > 0$ 与 $f$ 无关

对任意 $P = \sum_i c_i g_i$, 有
$$||f - P||_X \leq ||f - P||_Y + \omega(\delta, f) + \beta ||P||_X \Omega(\delta)$$
:::

::: proof
*Proof.* 不妨设 $g_1 \cdots g_n$ 线性无关

设 $\theta = \min_{\sum_{i=1}^n |c_i| = 1} ||\sum_{i=1}^n c_i g_i||$

由于 $g_1 \cdots g_n$ 线性无关，故 $\theta > 0$

令
$$\Omega(\delta) = \max_{1 \leq i \leq n} \max_{d(x,y) \leq \delta} |g_i(x) - g_i(y)|$$

$$= \max_{1 \leq i \leq 1} w(\delta, g_i)$$

则 $$\lim_{\delta \to 0} \Omega(\delta) = 0$$

取 $\delta$ 充分小，使得 $\Omega(\delta) < \theta$

考虑，$p = \sum_{i=1}^{n} c_i g_i$.

$$\theta \sum_{i=1}^{n} |c_i| \leq ||p||_X$$

$\|f-p\|_X = |f(x_0) - p(x_0)| \le |f(y_0) - p(y_0)| + |f(y_0) - f(x_0)| + |p(x_0) - p(y_0)|, \forall y_0\in Y, d(x_0, y_0) < \delta$

$$|f(y_0) - p(y_0)| \le \|f-p\|_Y$$

$$|f(y_0) - f(x_0)| \le \omega(\delta, f)$$

$$|p(x_0)-p(y_0)| \le \sum_i |c_i| |g_i(x_0) - g_i(y_0)| \le \Omega(\delta) \sum_i |c_i| \le \frac{\|p\|_X}{\theta}\Omega(\delta)$$

综上可得. ◻
:::

::: theorem
$f, g_1 \cdots g_n \in C(X)$, $Y \subset X$.

$P_Y$ 为 $f$ 在 $Y$ 上的最佳逼近广义多项式 $\sum c_i g_i$.

$P_X$ 为 $f$ 在 $X$ 上的最佳逼近广义多项式, 则

$$\lim_{|Y| \to 0} ||f - P_Y||_X = ||f - P_X||_X$$
:::

::: proof
*Proof.* 由于

$$||f - P_Y||_Y \leq ||f - P_X||_Y \leq ||f - P_X||_X \leq ||f - P_Y||_X$$

所以有

$$||f - P_Y||_X - ||f - P_X||_X \leq ||f - P_Y||_X - ||f - P_Y||_Y \leq w(\delta, f) + \beta ||P_Y||_X \Omega(\delta).$$

另一方面

$$||P_Y||_Y \leq ||P_Y - f||_Y + ||f||_Y \leq ||f||_Y + ||f||_X \leq 2||f||_X$$

由引理 2.6.1

$$||P_{Y}||_{X} \leq \alpha ||P_{Y}||_{Y} \leq 2\alpha ||f||_{X}$$

所以

$$||f - P_{Y}||_{X} - ||f - P_{X}||_{X} \leq \omega(\delta, f) + \beta ||f||_{X} \Omega(\delta)$$ ◻
:::

::: lemma
$Y \subset [a, b]$，$f \in C[a, b]$，$P_{n,Y}$为 $f$ 在 $Y$ 上的最佳 $n$
次逼近多项式。

$P_{n}$ 为 $f$ 在 $[a, b]$ 上的最佳 $n$ 次逼近多项式则有

$$\lim_{|Y| \to 0} ||P_{n,Y} - P_{n}|| = 0$$
:::

::: theorem
存在 $Y_1, Y_2, \cdots  \subset X$ 使得对任意 $f \in C[a, b]$，有

$$\lim_{n \to \infty} ||f - P_{Y_n}|| = 0$$

其中 $P_{Y_n}$ 为 $f$ 在 $Y_n$ 上的最佳 $n$ 次逼近多项式。
:::

### 离散集上最佳逼近多项式的计算 {#离散集上最佳逼近多项式的计算 .unnumbered}

$$Y = \{x_1, x_2, \cdots, x_m\}, \quad \{f_0, f_1, \cdots, f_n\}$$

为 $n$ 次多项式空间的一组基，$m > n$

求解

$$\min_{a_k} \max_{1 \leq i \leq m} | \sum_{k=0}^n a_k f_k(x_i) - f(x_i) |$$

::: tcolorbox
大作业：

给出一种求解上述优化问题的最佳分析其收敛性 并展示数值算例

（该问题可化为线性规划问题 也可参考 FISTA、ADMM 等方法）
:::
