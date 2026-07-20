---
note: true
layout: post
title: "Numerical Analysis I 对称矩阵特征值的计算——Jacobi方法与二分法"
permalink: /posts/numerical-analysis-1/13-symmetric-eigenvalue/
categories: numerical-analysis
tags: [numerical-analysis, symmetric-eigenvalue, jacobi-method, bisection-method]
use_math: true
---

本文介绍对称矩阵特征值的计算方法，包括 Rayleigh 商迭代、经典 Jacobi 方法（基于 Givens 旋转的消去过程与收敛性分析），以及针对对称三对角矩阵的二分法（基于 Sturm 序列和特征值分隔定理）。

## 4. 对称矩阵特征值的计算

### 4.1 Rayleigh 商迭代

$$
A \in \mathbb {C} ^ {n \times n}, \quad x \in \mathbb {C} ^ {n}, \quad x \ne 0
$$

$$
R (x) = \frac {(A x , x)}{(x , x)}
$$

称为关于 $A$ 和 $x$ 的Rayleigh商

Rayleigh 商迭代算法

$$
v ^ {(0)} \in \mathbb {R} ^ {n}, \| v ^ {(0)} \| _ {2} = 1
$$

$$
k = 0, 1, \dots
$$

$$
\mu_ {k} = R (v ^ {(k)})
$$

$$
(A - \mu_ {k} I) y ^ {(k + 1)} = v ^ {(k)}
$$

$$
v ^ {(k + 1)} = y ^ {(k + 1)} / \| y ^ {(k + 1)} \| _ {2}
$$

### 4.2. Jacobi 方法

$$
A = [ a _ {i j} ] \in \mathbb {R} ^ {n \times n}, A ^ {T} = A
$$

$$
\text {off} (A) = \sum_ {i = 1} ^ {n} \sum_ {\substack {j = 1 \\ j \neq i}} ^ {n} | a _ {i j} | ^ {2}
$$

$J = J(p, q, \theta)$ 为旋转角度为 $\theta$ 的 Givens 变换矩阵

$$
B = J A J ^ {- 1} \quad , \quad C = \cos \theta , \quad S = \sin \theta
$$

$$
J = \left[ \begin{array}{l l} \cos \theta & - \sin \theta \\ \sin \theta & \cos \theta \end{array} \right], J ^ {- 1} = \left[ \begin{array}{l l} \cos \theta & \sin \theta \\ - \sin \theta & \cos \theta \end{array} \right]
$$

B 的元素为

$$
b _ {p p} = a _ {p p} c ^ {2} + a _ {q q} s ^ {2} + a _ {p q} \sin 2 \theta
$$

$$
b _ {q q} = a _ {p p} s ^ {2} + a _ {q q} c ^ {2} - a _ {p q} \sin 2 \theta
$$

$$
b _ {p q} = b _ {q p} = \frac {1}{2} (a _ {q q} - a _ {p p}) \sin 2 \theta + a _ {p q} \cos 2 \theta
$$

$$
b _ {i p} = b _ {p i} = a _ {i p} c + a _ {i q} s \quad (i \neq p, q)
$$

$$
b _ {i q} = b _ {q i} = - a _ {i p} s + a _ {i q} c \quad (i \neq p, q)
$$

$$
b _ {i j} = a _ {i j}
$$

$$
(i \neq p, q, j \neq p, q)
$$

容易验证

$$
b _ {p p} ^ {2} + b _ {q q} ^ {2} + 2 b _ {p q} ^ {2} = a _ {p p} ^ {2} + a _ {q q} ^ {2} + 2 a _ {p q} ^ {2}
$$

$$
\begin{array}{r l} {\mathrm{则}} & \\ {o f f (B)} & {= | | B | | _ {F} ^ {2} - \sum_ {i = 1} ^ {n} b _ {i i} ^ {2} = | | A | | _ {F} ^ {2} - \sum_ {\substack {i = 1 \\ i \neq p, q}} ^ {n} a _ {i i} ^ {2} - (b _ {p p} ^ {2} + b _ {q q} ^ {2})} \\ & \\ & {= o f f (A) - 2 a _ {p q} ^ {2} + 2 b _ {p q} ^ {2}} \end{array}
$$

选择 $\theta$ 使得 $b_{pq} = 0$ 此时 $\text{off}(B)$ 达到极小

θ 满足

$$
\cot 2 \theta = \frac {a _ {p p} - a _ {q q}}{2 a _ {p q}} = \tau
$$

记 $t = \tan \theta$ , $t$ 满足

$$
t ^ {2} + 2 t \tau - 1 = 0
$$

$$
(6, 4, 1)
$$

取绝对值较小的根 (对应 $| \theta | \leq \frac {\pi }{4}$ )

$$
t = \frac {\operatorname{sgn} (\tau)}{| \tau | + \sqrt {1 + \tau^ {2}}}
$$

$$
(6.4.2)
$$

$$
\Rightarrow \quad c = \frac {1}{\sqrt {1 + t ^ {2}}} \quad , \quad s = t c
$$

$$
(6. 4. 3)
$$

在经典 Jacobi 方法中取

$$
| a _ {p q} | = \max _ {1 \leq i <   j \leq n} |a _ {i j}| \tag {6.4.4}
$$

其迭代格式为

$$
A _ {k} = J _ {k} ^ {T} A _ {k - 1} J _ {k}
$$

其为 (6.4.1) - (6.4.4) 确定的 Givens 旋转矩阵

引理 6.4.1 设 $A, E$ 均为 ${\mathbb{R}}^{n \times  n}$ 中的对称矩阵,

A, E, A+E 的特征值分别为

$$
\lambda_ {1} \geq \lambda_ {2} \geq \dots \geq \lambda_ {n}
$$

$$
\nu_ {1} \geq \nu_ {2} \geq \dots \geq \nu_ {n}
$$

$$
\mu_ {1} \ge \mu_ {2} \ge \dots \ge \mu_ {n}
$$

则有

$$
\lambda_ {i} + \nu_ {n} \leq \mu_ {i} \leq \lambda_ {i} + \nu_ {i}, i = 1, 2, \dots , n
$$

证明：记 ${x}_{1}\cdots {x}_{n}$ 为 $A$ 的特征向量

$$
W _ {i} = \operatorname{span} \{x _ {1}, \dots , x _ {i} \} \quad \mathrm{则有}
$$

$$
\begin{array}{r l} {\mu_ {i}} & {\geq \underset {x \in W _ {i}} {\min} \frac {((A + E) x , x)}{(x , x)} \geq \underset {x \neq 0} {\min} \frac {(A x , x)}{(x , x)} + \underset {x \neq 0} {\min} \frac {(E x , x)}{(x , x)}} \\ & {\geq \lambda_ {i} + \underset {x \neq 0} {\min} \frac {(E x , x)}{(x , x)} \geq \lambda_ {i} + \nu_ {n}} \end{array}
$$

同理可证 $\mu_{i} \leq \lambda_{i} + \nu_{i}$

定理 6.4.1 存在 A 的特征值的一个排列 $\lambda_{1}\cdots\lambda_{n}$

使得

$$
\lim _ {k \to \infty} A _ {k} = \text { diag } (\lambda_ {1} \dots \lambda_ {n})
$$

证明: $\text{off}(A_{k+1}) = \text{off}(A_k) - 2(a_{pq}^{(k)})^2$

注意到

$$
| a _ {p q} ^ {(k)} | = \max _ {1 \le i <   j \le n} | a _ {i j} ^ {(k)} |
$$

$\Rightarrow 2(a_{pq}^{(k)})^2 \geq \frac{2}{n(n-1)} \text{off} (A_k)$

$\Rightarrow \text{off} (A_{k+1}) \leq (1 - \frac{1}{N}) \text{off} (A_k), N = \frac{n(n-1)}{2}$

$\Rightarrow  \mathop{\lim }\limits_{k} \to  \infty }{\text{off}\left( {A}_{k}\right)  = 0$

下面证明存在特征值的一个排列 $\lambda_{1}\cdots\lambda_{n}$

使得 $\lim _{k \to \infty} a_{ii}^{(k)} = \lambda_i, i = 1, \cdots, n$

令 $E(A) = (\text{off}(A))^{1/2}$

记 $A$ 的互不相同的特征值之间的最小

距离为 $\delta$ . 即

$$
\delta = \min \{| \mu - \lambda |: \lambda , \mu \in \sigma (A), \lambda \neq \mu \}
$$

$\forall \varepsilon < \frac{\delta}{4}$ $\exists k_{0}$ 使得 $\forall k \geq k_{0}$ 有

$$
E (A _ {k}) <   \varepsilon <   \frac {\delta}{4}
$$

由引理 6.4.1 ，存在一个排列 $\lambda_{1}\cdots\lambda_{n}$ 使得

$$
| \lambda_ {i} - a _ {i i} ^ {(k _ {0})} | \le E (A _ {k}) <   \varepsilon <   \frac {\delta}{4}, i = 1, \dots , n
$$

下面证 $\forall k > k_{0}$ 有

$$
| \lambda_ {i} - a _ {i i} ^ {(k)} | <   \varepsilon
$$

由归纳法只需证

$$
| \lambda_ {i} - a _ {i i} ^ {(k _ {0} + 1)} | <   \varepsilon
$$

$$
\begin{array}{r l} {a _ {p p} ^ {(k _ {0} + 1)}} & {= a _ {p p} ^ {(k _ {0})} + c ^ {2} \left(- 2 t a _ {p q} ^ {(k _ {0})} + t ^ {2} (a _ {q q} ^ {(k _ {0})} - a _ {p p} ^ {(k _ {0})})\right)} \\ & {= a _ {p p} ^ {(k _ {0})} + c ^ {2} \left(- 2 t a _ {p q} ^ {(k _ {0})} + t (1 - t ^ {2}) a _ {p q} ^ {(k _ {0})}\right)} \\ & {= a _ {p p} ^ {(k _ {0})} - t a _ {p q} ^ {(k _ {0})}} \end{array}
$$

同理

$$
a _ {q q} ^ {(k _ {0} + 1)} = a _ {q q} ^ {(k _ {0})} + t a _ {p q} ^ {(k _ {0})}
$$

$\forall \lambda_{j} \neq \lambda_{p} \text{ 有 }$

$$
\begin{array}{r l} {| a _ {p p} ^ {(k _ {0} + 1)} - \lambda_ {j} |} & {\geq | \lambda_ {p} - \lambda_ {j} | - |a _ {p p} ^ {(k _ {0})} - \lambda_ {p}| - | t a _ {p q} ^ {(k _ {0})} |} \\ & {\geq \delta - 2 \varepsilon \geq 2 \varepsilon} \\ & {\uparrow} \\ {| t | \leq 1} \end{array}
$$

由此可得 $\left| {a}_{pp}^{\left( {k}_{0} + 1}\right) } - {\lambda }_{p}\right|  < \varepsilon$

同理可证 $|a_{qq}^{(k_0 + 1)} - \lambda_q| < \varepsilon$

### 4.3 二分法

$A \in \mathbb{R}^{n \times n}$ 对称，则存在正交矩阵 $Q$ 使得

$$
Q A Q ^ {T} = T
$$

其中 $T \in \mathbb{R}^{n \times n}$ 为对称三对角矩阵.

设

$$
T = \left[ \begin{array}{l l l l l} \alpha_ {1} & \beta_ {2} & & & \\ & \beta_ {2} & \alpha_ {2} & \beta_ {3} & \\ & & \ddots & \ddots & \ddots \\ & & & \ddots & \beta_ {n} \\ & & & \beta_ {n} & \alpha_ {n} \end{array} \right]
$$

下面考虑 T 的特征值的计算.

不失一般性 设 $\beta_{i} \neq 0, i = 2, \cdots, n$

记 $P_{i}(\lambda)$ 为 $T-\lambda I$ 的 $i$ 阶顺序主子式, 则有

$$
P _ {0} (\lambda) = 1, \quad P _ {i} (\lambda) = \alpha_ {i} - \lambda
$$

$$
P _ {i} (\lambda) = (\alpha_ {i} - \lambda) P _ {i - 1} (\lambda) - \beta_ {i} ^ {2} P _ {i - 2} (\lambda) (6.4.1)
$$

$$
i = 2, \dots , n
$$

T 实对称, 所以 $P_{i}(\lambda)$ 的根全为实数.

定理 6.4.1.

(1) 存在 M > 0 使得当 $\lambda > M$ 时，

$P_{i}(-\lambda)>0,\quad\operatorname{sgn}(P_{i}(\lambda))=(-1)^{i}$

(2) $P_{i-1}(\lambda)$ , $P_i(\lambda)$ 无公共根

(3) 若 $P_{i}(\mu)=0$ , 则

$$
P _ {i - 1} (\mu) P _ {i + 1} (\mu) <   0
$$

(4) $P_{i}(\lambda)$ 全是单根，并且 $P_{i}(\lambda)$ 的根严格分隔 $P_{i+1}(\lambda)$ 的根.

证明：

(1). $P_{i}(\lambda)$ 的首项为 $(-1)^{i}\lambda^{i}$ 由此可得 (1)

(2) 反证法. 假设存在 $i$ 使得 $P_{i-1}(\lambda), P_i(\lambda)$

有公共根 $\mu$ . 即 ${P}_{i - 1}\left( \mu \right)  = {P}_{i}\left( \mu \right)  = 0$ ,则

由 $(6.4.1)$ 得

$$
0 = P _ {i} (\mu) = (\alpha_ {i} - \mu) P _ {i - 1} (\mu) - \beta_ {i} ^ {2} P _ {i - 2} (\mu) = - \beta_ {i} ^ {2} P _ {i - 2} (\mu)
$$

由于 ${\beta }_{i} \neq  0$ ,故 ${P}_{i - 2}\left( \mu \right)  = 0$

依此类推 可得 ${P}_{0}\left( \mu \right)  = 0\;$ 与 ${P}_{0}\left( \mu \right)  = 1$ 矛盾(3). 设 $P_{i}(\mu)=0$ 则由 (6.4.1) 及 (2) $P_{i+1}(\mu)$ $P_{i-1}(\mu)=-\beta_{i+1}^{2}$ $P_{i-1}(\mu)^{2}<0$

$$
P _ {1} (\lambda) = \alpha_ {1} - \lambda
$$

$$
P _ {2} (\alpha_ {1}) = - \beta_ {2} ^ {2} <   0
$$

另一方面

$$
p _ {2} (\lambda) \rightarrow + \infty , \quad \lambda \rightarrow \pm \infty
$$

所以在 $(-\infty, \alpha_{1})$ 与 $(\alpha_{1}, +\infty)$ 之间

设 $i = k$ 时结论成立. 设 ${P}_{k - 1},{P}_{k}$

$$
v _ {1} <   v _ {2} <   \dots <   v _ {k - 1}, \quad \mu_ {1} <   \mu_ {2} <   \dots <   \mu_ {k}
$$

由归纳法假设知

$$
\mu_ {1} <   \nu_ {1} <   \mu_ {2} <   \nu_ {2} <   \dots <   \nu_ {k - 1} <   \mu_ {k}
$$

由 (1) 及 ${P}_{k - 1}\left( {k,j}\right)  = 0$ 可得

$$
(- 1) ^ {j - 1} P _ {k - 1} (\mu_ {j}) > 0
$$

由递推公式(6.4.1)得 $P_{k+1}(\mu_j) = -\beta_{k+1}^2 P_{k-1}(\mu_j), j=1,\cdots,k$ 所以 $(-1)^j P_{k+1}(\mu_j) > 0, j=1,\cdots,k$

注意到

$$
\lim _ {\mu \to + \infty} P _ {k + 1} (- \mu) = + \infty
$$

$$
\begin{array}{r l} {\lim _ {\mu \to + \infty} (- 1) ^ {k + 1} P _ {k + 1} (\mu)} & {= + \infty} \end{array}
$$

所以 ${P}_{k + 1}\left( \lambda \right)$ 在区间

$(-∞, μ₁) (μ₁, μ₂) … (μ_{k-1}, μ_k), (μ_k, +∞)$ 各有一个根.

设 $\mu\in R$ ，令 $S_{k}(\mu)$ 为 $P_{0}(\mu),\cdots,P_{k}(\mu)$ 的变号次数。规定

若 ${P}_{i}\left( \mu \right)  = 0$ ,则 ${P}_{i}\left( \mu \right)$ 与 ${P}_{i - 1}\left( \mu \right)$ 同号

定理 6.4.2. $S_{k}(\mu)$ 为 $P_{k}(\lambda)$ 在 $(-\infty, \mu)$ 内根的

个数.

证明：数学归纳法.

k=1 时 结论显然成立.

假设 $k = \ell$ 时成立. 设 ${P}_{\ell }\left( \lambda \right) ,{P}_{\ell +1}\left( \lambda \right)$ 的根

分别为

$$
\mu_ {1} <   \mu_ {2} <   \dots <   \mu_ {l}, \quad \lambda_ {1} <   \lambda_ {2} <   \dots <   \lambda_ {l + 1}
$$

则由定理 6.4.1 知

$$
\lambda_ {1} <   \mu_ {1} <   \lambda_ {2} <   \mu_ {2} <   \dots <   \mu_ {l} <   \lambda_ {l + 1}
$$

设 $S_{\ell}(\mu) = m$ ，由归纳假设有

$$
\mu_ {m} <   \mu \leq \mu_ {m + 1}
$$

下面分情况讨论：

(1). $\lambda_{m} < \mu_{m} < \mu \leq \lambda_{m+1}$

此时 $P_{\ell}(\mu)$ 与 $P_{\ell+1}(\mu)$ 有相同的符号

即 ${S}_{\ell + 1}\left( \mu \right)  = {S}_{\ell }\left( \mu \right)  = m$

与 $P_{\ell+1}(\lambda)$ 在 $(- \infty, \mu)$ 根的个数相同.

(2) $\lambda_{m+1}<\mu<\mu_{m+1}$

此时 $P_{\ell}(\mu)$ 与 $P_{\ell+1}(\mu)$ 异号. 因此

$$
S _ {\ell + 1} (\mu) = S _ {\ell} (\mu) + 1 = m + 1
$$

(3) $\mu = \mu_{m+1}$

此时 $P_{\ell}(\mu)=0$ 则有 $P_{\ell}(\mu)$ 与 $P_{\ell-1}(\mu)$ 同号.

由定理 6.4.1 得 ${P}_{\ell - 1}\left( \mu \right)$ 与 ${P}_{\ell + 1}\left( \mu \right)$ 异号

因此 $P_{\ell}(\mu)$ 与 $P_{\ell+1}(\mu)$ 异号. 即

$$
S _ {\ell + 1} (\mu) = S _ {\ell} (\mu) + 1 = m + 1
$$

推论 6.4.1: T 是不可约对称三对角矩阵. 则

$S_{n}(\mu)$ 是 $T$ 在 $(-\infty, \mu)$ 内特征值的个数.

设 $T$ 的特征值为

$$
\lambda_ {1} <   \lambda_ {2} <   \dots <   \lambda_ {n}
$$

则

$$
| \lambda_ {i} | \leq \rho (T) \leq | | T | | _ {\infty}
$$

取 ${l}_{0} =  - \left| {\left| T\right| \infty }\right| ,\;{u}_{0} = \left| {\left| T\right| \infty }\right|$

则 $\lambda_{m} \in [l_{0}, u_{0}]$

令 ${r}_{1} = \left( {l}_{0} + {u}_{0}\right) /2$

若 ${S}_{n}\left( {r}_{1}\right)  \geq  m$ 则 ${\lambda }_{m} \in  \left\lbrack  {l}_{0},{r}_{1}\right\rbrack$

否则 $\lambda_{m} \in [r_{1}, u_{0}]$

依此类推，可将区间不断二分.

## 二分法的主要计算量为计算 $S_{n}(\mu)$

为了避免高阶多项式溢出. 令

$$
g _ {i} (x) = \frac {p _ {i} (x)}{p _ {i - 1} (x)}, i = 1, \dots , n.
$$

则有

$$
g _ {1} (\lambda) = P _ {1} (\lambda) = \alpha_ {1} - \lambda
$$

$$
g _ {i} (\lambda) = \alpha_ {i} - \lambda - \frac {\beta_ {i} ^ {2}{g _ {i - 1} (\lambda)}, i = 2, \dots , n
$$

$S_{n}(\mu)$ 为 $g_{1}(\mu)$ … $g_{n}(\mu)$ 中负数的个数.

$S_{n}(\mu)$ 计算方法：

$$
x = [ \alpha_ {1}, \alpha_ {2}, \dots , \alpha_ {n} ]
$$

$$
y = [ 0, \beta_ {2}, \dots , \beta_ {n} ]
$$

$$
s = 0, q = x (1) - \mu
$$

$$
k = 1: n
$$

$$
\left[ \begin{array}{l l} \text { if } & q <   0 \\ & s = s + 1 \\ \text { end } \end{array} \right]
$$

$$
i f k <   n
$$

$$
\left\{ \begin{array}{l l} \text { if } & g = 0 \\ & g = | y (k + 1) | \varepsilon \\ \text { end } \end{array} \right.
$$

$$
q = x (k + 1) - \mu - y (k + 1) ^ {2} / q
$$

[← 上一篇：QR方法](/posts/numerical-analysis-1/12-qr-method/)
