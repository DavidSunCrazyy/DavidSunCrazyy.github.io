---
layout: post
title: "Numerical Analysis II 有理逼近"
permalink: /posts/numerical-analysis-2-05-有理逼近/
tags: numerical-analysis
use_math: true
---

# 有理逼近

设 $f \in C[a, b]$, $m, n \in \mathbb{N}$，采用有理多项式逼近 $f$。

令
$$R = \frac{P}{Q} = \frac{a_0 + a_1 x + \cdots + a_n x^n}{b_0 + b_1 x + \cdots + b_m x^m},$$
其中 $P, Q$ 除常数外无其它公因子，且 $Q(x) > 0$, $x \in [a, b]$。

令
$$R_m^n[a, b] = \left\{ \frac{P}{Q} : d(P) \leq n, \, d(Q) \leq m, \, Q(x) > 0 \right\}.$$

## 最佳有理逼近的存在性

**Theorem**
设 $f \in C[a, b]$，则 $R_m^n[a, b]$ 中存在至少一个最佳有理逼近。
:::


*Proof.* 设
$\eta = \operatorname{dist}(f, R_m^n) = \inf_{R \in R_m^n} \| f - R \|_\infty$.
取 $\{ R_k \}$ 为极小化序列，即 $R_k \in R_m^n$ 且
$$\lim_{k \to \infty} \| R_k - f \|_\infty = \eta.$$

记
$$R_k = \frac{P_k}{Q_k}, \quad \text{且 } \| Q_k \| = 1, \, Q(x) > 0.$$

可取 $\{ R_k \}$ 的子列（仍记为 $\{ R_k \}$），使得
$$\| R_k - f \|_\infty \leq \eta + 1.$$

由于
$$|P_k(x)| = |Q_k(x)| |R_k(x)| \leq \| Q_k \| \| R_k \| \leq \Theta,$$
$\{ P_k \}$ 和 $\{ Q_k \}$ 分别处在紧集 $\| P_k \| \leq \Theta$ 和
$\| Q_k \| = 1$ 中，故可取收敛子列（仍记为 $\{ P_k \}$,
$\{ Q_k \}$），即有
$$\lim_{k \to \infty} \| P_k - P \| = 0, \quad \lim_{k \to \infty} \| Q_k - Q \| = 0.$$

且 $\| Q \| = 1$, $Q(x) > 0$。

因为 $Q$ 为 $m$ 次多项式，故至多有 $m$ 个零点。令
$$E = \{ x \in [a, b] : Q(x) > 0 \}.$$

则 $\forall x \in E$
$$R_k(x) = \frac{P_k(x)}{Q_k(x)} \to \frac{P(x)}{Q(x)} = R(x).$$

并且 $$\begin{aligned}
|R(x) - f(x)| &\leq |R(x) - R_k(x)| + |R_k(x) - f(x)| \\
&\to \eta.
\end{aligned}$$

因此 $|R(x) - f(x)| \leq \eta$, $x \in E$。

设 $x_i$ 为 $Q(x)$ 的零点，$\forall \varepsilon > 0$,
$\exists \delta > 0$，且 $|x - x_i| < \delta$ 且 $x \neq x_i$ 有
$$|Q(x)| < \varepsilon, \quad |P(x)| \leq \Theta |Q(x)| < \Theta \varepsilon.$$

$\Rightarrow \lim_{x \to x_i} P(x) = 0$，即 $x_i$ 为 $P(x)$ 的零点。

由此可知 $R(x) = \frac{P(x)}{Q(x)}$ 为 $[a, b]$ 上连续函数，故有
$$|R(x) - f(x)| \leq \eta, \quad \forall x \in [a, b].$$

则 $R(x)$ 为 $f$ 的最佳有理逼近。$\Box$ ◻
:::

**Theorem**
$f \in C[a, b]$, $R \in R_m^n$ 是 $f$ 的最佳逼近当且仅当不存在
$\varphi \in P_n + RQ_m$ 使得
$$\varphi(y)(f(y) - R(y)) \geq 0, \quad \forall y \in Y,$$ 其中
$Y = \{ x \in [a, b] : |f(x) - R(x)| = \| f - R \| \}$.
:::

**Theorem**
$f \in C[a, b]$, $R \in R_m^n$ 是 $f$ 的最佳逼近，如果 $P_n + RQ_m$ 为
Haar 空间，则 $R$ 唯一。
:::

**Definition**
存在一组基满足 Haar 条件。
:::

## Padé 逼近

**Definition**
$f \in C[-a, a]$, $f$ 在 $0$ 处充分光滑。如果存在
$$R(x) = \frac{P_n(x)}{Q_m(x)},$$ 满足
$$R(0) = f(0), \quad R^{(j)}(0) = f^{(j)}(0), \quad j = 1, 2, \dots, n+m,$$
则称 $R$ 为 $f$ 在 $x = 0$ 处的 $(n, m)$ 阶 Padé 逼近。
:::

**Theorem**
$R(x) = \frac{P_n(x)}{Q_m(x)}$ 为 $f$ 在 $x = 0$ 处的 $(n, m)$ 阶 Padé
逼近，则有 $$f(x)Q_m(x) - P_n(x) = \sum_{j=n+m+1}^\infty c_j x^j.$$
:::


*Proof.* 对 $f(x)Q_m(x) - P_n(x)$ 在 $x = 0$ 处作 Taylor 展开：
$$f(x)Q_m(x) - P_n(x) = \sum_{j=0}^\infty c_j x^j.$$

对于 $j = 0, 1, \dots, m+n$，

$$c_j = \frac{1}{j!}  \frac{d^j}{dx^j} \left[ f(x) Q_m(x) - P_n(x) \right] \bigg|_{x=0}$$
$$= \frac{1}{j!} \left( \sum_{i=0}^j \binom{j}{i} f^{(i)}(0) Q_m^{(j-i)}(0) - P_n^{(j)}(0) \right)$$

由 Padé 逼近的定义：
$$f(0) = R(0), \quad f^{(i)}(0) = R^{(i)}(0), \quad i = 1, 2, \dots, m+n,$$
则有 $$\begin{aligned}
c_j &= \frac{1}{j!} \left[ \frac{d^j}{dx^j} \left( f(x)Q_m(x) - P_n(x) \right) \right]_{x=0} \\
&= \frac{1}{j!} \left( \sum_{i=0}^j \binom{j}{i} f^{(i)}(0) Q_m^{(j-i)}(0) - P_n^{(j)}(0) \right).
\end{aligned}$$

由于 $f(0) = R(0)$ 和 $f^{(i)}(0) = R^{(i)}(0)$，可以进一步化简为：
$$\begin{aligned}
c_j &= \frac{1}{j!} \left( \sum_{i=0}^j \binom{j}{i} R^{(i)}(0) Q_m^{(j-i)}(0) - P_n^{(j)}(0) \right) \\
&= \frac{1}{j!} \left[ \frac{d^j}{dx^j} P_n(x) \right]_{x=0} - P_n^{(j)}(0) \\
&= 0.
\end{aligned}$$

因此，$f(x)Q_m(x) - P_n(x)$ 在 $x = 0$ 处的 Taylor 展开中，前 $m+n+1$
项系数均为零。$\Box$

设 $f$ 在 $x = 0$ 处的 Taylor 展开为
$$f(x) = \sum_{j=0}^\infty a_j x^j.$$

令 $$P_n(x) = p_0 + p_1 x + \cdots + p_n x^n,$$
$$Q_m(x) = 1 + q_1 x + q_2 x^2 + \cdots + q_m x^m.$$

根据 Padé 逼近的条件，有： $$\begin{aligned}
a_0 - p_0 &= 0, \\
q_1 a_0 + a_1 - p_1 &= 0, \\
&\vdots \\
q_m a_{n-m} + q_{m-1} a_{n-m+1} + \cdots + q_0 a_n - p_n &= 0, \\
q_m a_{n-m+1} + q_{m-1} a_{n-m+2} + \cdots + q_0 a_{n+1} &= 0, \\
&\vdots \\
q_m a_n + q_{m-1} a_{n+1} + \cdots + q_0 a_{n+m} &= 0.
\end{aligned}$$

先求解后 $m$ 个方程得到 $q_1, \dots, q_m$，然后代入前 $n+1$
个方程即可求得 $p_0, \dots, p_n$。

## 离散点上的有理逼近

设 $x_j \in [a, b]$, $j = 0, 1, \dots, m+n$，不妨设 $n \geq m$。

为求有理逼近，可列方程：
$$\frac{P_n(x_j)}{Q_m(x_j)} = f(x_j), \quad j = 0, 1, \dots, m+n.$$

线性化为： $$P_n(x_j) = Q_m(x_j) f(x_j), \quad j = 0, 1, \dots, m+n.$$

即： $$\begin{bmatrix}
1 & x_0 & x_0^2 & \cdots & x_0^n \\
\vdots & \vdots & \vdots & & \vdots \\
1 & x_{n+m} & x_{n+m}^2 & \cdots & x_{n+m}^n
\end{bmatrix}
\begin{bmatrix}
a_0 \\ \vdots \\ a_n
\end{bmatrix}
=
\begin{bmatrix}
f(x_0) \\ \vdots \\ f(x_{n+m})
\end{bmatrix}.$$

若离散点数目大于 $m+n+1$，即 $x_j \in [a, b]$, $j = 0, 1, \dots, N$,
$N > m+n$，则寻找最小二乘解：
$$\min_{a_0, \dots, a_n, b_0, \dots, b_m} \sum_{j=0}^N \left| P_n(x_j) - f(x_j) Q_m(x_j) \right|^2,$$
约束条件为： $$\sum_{k=0}^m b_k^2 = 1 \quad (\text{避免零解}).$$ ◻
:::
