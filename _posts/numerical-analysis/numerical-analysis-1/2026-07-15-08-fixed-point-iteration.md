---
note: true
layout: post
title: "Numerical Analysis I 不动点迭代一般概念——收敛性、收敛阶与加速方法"
permalink: /posts/numerical-analysis-1/08-fixed-point-iteration/
categories: numerical-analysis
tags: [numerical-analysis, fixed-point-iteration, contraction-mapping, convergence-order]
use_math: true
---

前面我们讨论了线性方程组的各种解法。现在转向非线性方程 $f(x) = 0$。最简单的思路是把方程改写为 $x = \varphi(x)$，然后反复迭代 $x_{k+1} = \varphi(x_k)$——这就是不动点迭代法。本章从压缩映射原理出发，逐步引入收敛阶的概念，最后介绍 Aitken 和 Steffensen 两种加速技巧。

# 非线性方程（组）的数值解法

## 1. 单个方程的不动点迭代法

设 $f$ 是连续函数, 求解方程

$$
f (x) = 0
$$

构造等价方程

$$
x = \varphi (x)
$$

其中 $\varphi$ 是连续函数,并且满足

$$
f (x ^ {*}) = 0 \quad \Leftrightarrow \quad x ^ {*} = \varphi (x ^ {*})
$$

$x^{*}$ 称为 $\varphi$ 的一个不动点.

相应的构造迭代法

$$
x _ {k + 1} = \varphi (x _ {k})
$$

称为不动点迭代， $\varphi$ 称为迭代函数

**例5.1.1** 求 ${x}^{3} + 4{x}^{2} - {10} = 0$ 在 $\left\lbrack {1,2}\right\rbrack$ 上的根

方法1. 改写为 $x = x - {x}^{3} - 4{x}^{2} + {10}$ 即

$$
\varphi_ {1} (x) = x - x ^ {3} - 4 x ^ {2} + 10
$$

方法2. ${\varphi }_{2}\left( x\right) = \frac{1}{2}\left( {10} - {x}^{3}\right)^{\frac{1}{2}}$

方法3. $\varphi_{3}(x)=\left(\frac{10}{x}-4x\right)^{\frac{1}{2}}$

方法4. $\varphi_{4}(x)=\left(\frac{10}{4+x}\right)^{1/2}$

| $k$ | 方法1 | 方法2 | 方法3 | 方法4 |
|-----|-------|-------|-------|-------|
| 0 | 1.5 | 1.5 | 1.5 | 1.5 |
| 1 | −0.875 | 1.286 953 8 | 0.816 5 | 1.348 399 7 |
| 2 | 6.732 | 1.402 540 8 | 2.996 9 | 1.367 376 4 |
| 3 | −469.7 | 1.345 458 4 | $(-8.65)^{1/2}$ | 1.364 957 0 |
| 4 | $1.03\times10^8$ | 1.375 170 3 | | 1.365 264 7 |
| 5 | | 1.360 094 2 | | 1.365 225 6 |
| $\vdots$ | | $\vdots$ | | $\vdots$ |
| 8 | | 1.365 916 7 | | 1.365 230 0 |
| $\vdots$ | | $\vdots$ | | |
| 15 | | 1.365 223 7 | | |
| $\vdots$ | | $\vdots$ | | |
| 20 | | 1.365 230 2 | | |
| $\vdots$ | | $\vdots$ | | |
| 23 | | 1.365 230 0 | | |

**定理 5.1.1** 设 $\varphi \in C[a,b]$ ，且满足
 
$$
a \leq \varphi(x) \leq b, \quad \forall x \in [a,b] \tag{5.1.1}
$$ 

则 $\varphi$ 在 $[a, b]$ 上一定存在不动点.

若又存在 $L \in (0,1)$ 使得
$$
| \varphi (x) - \varphi (y) | \leq L | x - y |, \quad \forall x, y \in [ a, b ] \tag{5.1.2}
$$

则 $\varphi$ 在 $[a,b]$ 上的不动点唯一.

**证明：** 若 $\varphi(a)=a$ 或者 $\varphi(b)=b$ 成立 则不动点存在.

设 $\varphi(a)>a,\quad\varphi(b)<b$ 令

$$
\psi (x) = \varphi (x) - x
$$

则有 $\varphi(a) > 0, \quad \varphi(b) < 0$ 且 $\varphi$ 连续

由介值定理 存在 $x^{*} \in (a, b)$ 使得

$$
\psi (x ^ {*}) = 0
$$

则 $x^{*}$ 是 $\varphi$ 的不动点

若 $\varphi$ 有两个不动点, $x_{1}^{*}$ , $x_{2}^{*} \in [a,b]$ 且 $x_{1}^{*} \neq x_{2}^{*}$ 则

$$
| x _ {1} ^ {*} - x _ {2} ^ {*} | = | \varphi (x _ {1} ^ {*}) - \varphi (x _ {2} ^ {*}) | \le L | x _ {1} ^ {*} - x _ {2} ^ {*} | < | x _ {1} ^ {*} - x _ {2} ^ {*} |
$$

矛盾.

(5.1.2) 称为 Lipschitz 条件，L 称为 Lipschitz 常数

**推论：** 设 $\varphi \in C'[a,b]$ ，满足 (5.1.1) 且存在常数

$L \in (0,1) \text{ 使}$

$$
| \varphi^ {\prime} (x) | \le L, \quad \forall x \in (a, b)
$$

则 $\varphi$ 在 $[a, b]$ 上存在唯一的不动点.

**定理 5.1.2** 设 $\varphi \in C[a,b]$ 满足 (5.1.1), (5.1.2)

其中 $L \in (0,1)$ 则对任意 $x_0 \in [a,b]$ 由迭代法

$x_{k+1} = \varphi(x_k)$ 产生的序列收敛到 $\varphi$ 在 $[a,b]$ 上

的不动点 $x^{*}$ , 且对整数 $P \geq 1$

$$
| x _ {k + p} - x _ {k} | \leq \frac {1}{1 - L} | x _ {k + 1} - x _ {k} |
$$

$$
| x ^ {*} - x _ {k} | \leq \frac {L}{1 - L} | x _ {k} - x _ {k - 1} |
$$

$$
| x ^ {*} - x _ {k} | \le \frac {L ^ {k}}{1 - L} | x _ {1} - x _ {0} |
$$

**证明：** 由**定理 5.1.1，** $\varphi$ 在 $[a,b]$ 上有唯一的不动点， $x^{*}$ 且

$$
\begin{array}{r l} {| x _ {k} - x ^ {*} |} & {= | \varphi (x _ {k - 1}) - \varphi (x ^ {*}) |} \\ & {\le L | x _ {k - 1} - x ^ {*} | \le \dots \le L ^ {k} | x _ {0} - x ^ {*} |} \end{array}
$$

$\Rightarrow$ $\lim _{k \to \infty} x_k = x^*$

$$
\begin{array}{r l} {| x _ {k + p} - x _ {k} |} & {= | x _ {k + p} - x _ {k + p - 1} + x _ {k + p - 1} - \dots + x _ {k + 1} - x _ {k} |} \\ & {\leq | x _ {k + p} - x _ {k + p - 1} | + \dots + | x _ {k + 1} - x _ {k} |} \\ & {\leq (L ^ {p - 1} + L ^ {p - 2} + \dots + L + 1) | x _ {k + 1} - x _ {k} |} \\ & {\leq \frac {1}{1 - L} | x _ {k + 1} - x _ {k} |} \\ & {\leq \frac {L}{1 - L} | x _ {k} - x _ {k - 1} | \leq \dots \leq \frac {L ^ {k}}{1 - L} | x _ {1} - x _ {0} |} \end{array}
$$

令 $p \to \infty$ 可得

$$
| x ^ {*} - x _ {k} | \leq \frac {L}{1 - L} | x _ {k} - x _ {k - 1} |
$$

$$
| x ^ {*} - x _ {k} | \leq \frac {L ^ {k}}{1 - L} | x _ {1} - x _ {0} |
$$

**例5.1.2** 迭代法1: ${\varphi }_{i}\left( x\right) = x - {x}^{3} - 4{x}^{2} + {10}$

$$
\varphi_ {1} ^ {\prime} (x) = 1 - 3 x ^ {2} - 8 x \quad \mathrm{且}
$$

$$
| \varphi_ {1} ^ {\prime} (x) | > 1, \quad \forall x \in [ 1, 2 ]
$$

迭代法2: $\varphi_{2}(x)=\frac{1}{2}(10-x^{3})^{\frac{1}{2}}$

$$
\varphi_ {2} ^ {\prime} (x) = - \frac {3}{4} x ^ {2} (10 - x ^ {3}) ^ {- \frac {1}{2}}
$$

在 $[1, 1.5]$ 上 $\varphi_{2}$ 为递减函数且

$$
1. 2 8 7 \approx \varphi_ {2} (1.5) \leq \varphi_ {2} (x) \leq \varphi_ {2} (1) = 1.5
$$

即在 $[1,1.5]$ 上 $\varphi_{2}$ 满足 $(5.1.1)$

且在 $[1, 1.5]$ 上有

$$
| \varphi_ {2} ^ {\prime} (x) | \leq | \varphi_ {2} ^ {\prime} (1. 5) | \approx 0. 6 6
$$

满足 $(5.1.2)$

迭代法3: $\varphi_{3}(x)=\left(\frac{10}{x}-4x\right)^{1/2}$

$x^{*} \approx 1.365$ , $|\varphi'(x^{*})| \approx 3.4$

不存在包含 $x^{*}$ 的区间使得 $|{\varphi }_{3}^{\prime }\left( x\right) | < 1$

迭代法 4: $\varphi_{4}(x)=\left(\frac{10}{4+x}\right)^{\frac{1}{2}}$

$$
| \varphi_ {4} ^ {\prime} (x) | = \frac {\sqrt {10}}{2} \frac {1}{(4 + x) ^ {\frac {3}{2}}} \leq \frac {\sqrt {10}}{2} \cdot \frac {1}{5 ^ {\frac {3}{2}}} < 0. 1 5, \forall x \in [ 1, 2 ]
$$

且有 $1 \leq \varphi_{4}(x) \leq 2$ ， $\forall x \in [1, 2]$

**定义 5.1.1.** 设 $\varphi$ 在区间 $I$ 上有不动点 $x^{*}$ , 如果存在 $x^{*}$ 的一个邻域 $S \subset I$ , 对任意 $x_{0} \in S$ , 迭代法产生的序列 $\{x_{k}\} \subset S$ 且 $x_{k}$ 收敛到 $x^{*}$ , 就称迭代法局部收敛

**定理 5.1.3** 设 $x^{*}$ 为 $\varphi$ 的不动点， $\varphi'$ 在 $x^{*}$ 的某个邻域 $S$ 上存在连续且 $|\varphi'(x^*)| < 1$ ，则迭代法局部收敛

**定义 5.1.2.** 设序列 $\{x_k\}$ 收敛到 $x^\ast$ , 记 $e_k = x_k - x^\ast$ .

(1) 若存在 $p \geq 1$ 及 $C \neq 0\;\left( {p = 1\text{时,}0 < c < 1}\right)$

$$
\lim _ {k \to \infty} \frac {\left| e _ {k + 1} \right|}{\left| e _ {k} \right| ^ {p}} = c
$$

则称 $\{x_{k}\}$ 为 $p$ 阶收敛，$C$ 称为渐近误差常数.

(2) 若存在 $p \geq 1$ 及 $C > 0$ ($p = 1$ 时 $0 < C < 1$)

正整数 $k$ ，使得 $k > K$ 时

$$
| e _ {k + 1} | \le C | e _ {k} | ^ {p}
$$

则称 $\{x_{k}\}$ 至少 $p$ 阶收敛

若 $p = 1$ ，称线性收敛 ( $0 < c < 1$ )

$p = 2$ ，称平方收敛

$p > 1$，称超线性收敛.

**定理 5.1.4** 设 $x^{*}$ 是 $\varphi$ 的不动点，整数 $p > 1$

$\varphi^{(p)}$ 在 $x^{*}$ 的邻域上连续，且满足

$$
\varphi^ {\prime} (x ^ {*}) = \varphi^ {\prime \prime} (x ^ {*}) = \dots = \varphi^ {(p - 1)} (x ^ {*}) = 0
$$

$$
\varphi^ {(p)} (x ^ {*}) \neq 0
$$

则由迭代法产生的序列 $\{x_{k}\}$ 在 $x^{*}$ 的邻域 $p$ 阶收敛，且

$$
\lim _ {k \to \infty} \frac {e _ {k + 1}}{e _ {k} ^ {p}} = \frac {\varphi^ {(p)} (x ^ {*})}{p !}
$$

**证明：** 因为 $\varphi'(x^{*})=0$，所以 $\{x_{k}\}$ 局部收敛。

由 Taylor 展开得

$$
\varphi(x_k) = \varphi(x^*) + \frac{\varphi^{(p)}(\xi_k)}{p!}(x_k - x^*)^p, \quad \xi_k \text{ 在 } x_k \text{ 与 } x^* \text{ 之间}.
$$

于是

$$
x_{k+1} - x^* = \varphi(x_k) - \varphi(x^*) = \frac{\varphi^{(p)}(\xi_k)}{p!}(x_k - x^*)^p.
$$

记 $e_k = x_k - x^*$，则

$$
\frac{e_{k+1}}{e_k^p} = \frac{\varphi^{(p)}(\xi_k)}{p!}.
$$

由 $x_k \to x^*$ 可知 $\xi_k \to x^*$，故

$$
\lim_{k \to \infty} \frac{e_{k+1}}{e_k^p} = \frac{\varphi^{(p)}(x^*)}{p!}.
$$

因此收敛阶为 $p$。

**例 5.1.3** 在例 5.1.1 中 ${x}^{ * } \approx {1.365}$

$$
\varphi_ {2} ^ {\prime} (x ^ {*}) \neq 0, \quad \varphi_ {4} ^ {\prime} (x ^ {*}) \neq 0
$$

故均为线性收敛.

## 2. 加速收敛的方法

### Aitken 加速方法

设 $\{x_{k}\}$ 线性收敛到 $x^{*}$ ，记 $e_{k}=x_{k}-x^{*}$ 则有

$$
\lim _ {k \to \infty} \frac {\left| e _ {k + 1} \right|}{\left| e _ {k} \right|} = c, \quad 0 < c < 1
$$

当 $k > 1$ 时有

$$
x _ {k + 1} - x ^ {*} \approx c (x _ {k} - x ^ {*}), x _ {k + 2} - x ^ {*} \approx c (x _ {k + 1} - x ^ {*})
$$

其中 $\left| c\right| = C$ ,即

$$
\frac {x _ {k + 1} - x ^ {*}}{x _ {k} - x ^ {*}} \approx \frac {x _ {k + 2} - x ^ {*}}{x _ {k + 1} - x ^ {*}}
$$

由此可得

$$
x ^ {*} \approx \frac {x _ {k} x _ {k + 2} - x _ {k + 1} ^ {2}}{x _ {k + 2} - 2 x _ {k + 1} + x _ {k}} = \overline {x _ {k}}\tag{5.2.1}
$$

$\overline{x}_k$ 是 $x^*$ 的近似值 从而可得到新的序列 $\{\overline{x}_k\}$

**定理 5.2.1** 设存在 $|\lambda| < 1$ 使得

$$
x _ {k + 1} - x ^ {*} = (\lambda + \delta_ {k}) (x _ {k} - x ^ {*})
$$

其中 $\lim_{k\to\infty}\delta_{k}=0$ ，则对充分大的$k$，(5.2.1) 定义的 $\overline{x}_{k}$ 存在，并且

$$
\lim _ {k \to \infty} \frac {\overline {x} _ {k} - x ^ {*}}{x _ {k} - x ^ {*}} = 0
$$

**证明：** 记 ${e}_{k} = {x}_{k} - {x}^\ast$ ,由定理条件有 
$$
\lim_{k \to \infty}\frac{e_{k + 1}}{e_{k}} = \lambda
$$

$$
\begin{array}{r l} {\Delta^ {2} x _ {k}} & {= x _ {k + 2} - 2 x _ {k + 1} + x _ {k}} \\ & {= e _ {k + 2} - 2 e _ {k + 1} + e _ {k}} \\ & {= e _ {k} \left[ (\lambda + \delta_ {k + 1}) (\lambda + \delta_ {k}) - 2 (\lambda + \delta_ {k}) + 1 \right]} \\ & {= e _ {k} \left[ (\lambda - 1) ^ {2} + \mu_ {k} \right]} \end{array}
$$

其中 $\lim _{k \to \infty} \mu_{k} = 0$

对于充分大的 $k$ , 使得 $|\mu_k| < \frac{1}{2} (1 - (\lambda - 1)^2)$

则有 $\Delta^{2}x_{k}\neq0$ 即 $\overline{x}_{k}$ 有意义.

$$
\overline {x} _ {k} = x _ {k} - \frac {(x _ {k + 1} - x _ {k}) ^ {2}}{\Delta^ {2} x _ {k}} = x _ {k} - \frac {(\lambda - 1 + \delta_ {k}) ^ {2}}{(\lambda - 1) ^ {2} + \mu_ {k}} e _ {k}
$$

$$
\lim _ {k \to \infty} \frac {\overline {x} _ {k} - x ^ {*}}{x _ {k} - x ^ {*}} = \lim _ {k \to \infty} \left(1 - \frac {[ \lambda - 1 + \delta_ {k} ] ^ {2}}{(\lambda - 1) ^ {2} + \mu_ {k}}\right) = 0
$$


### Steffensen 迭代法

将 Aitken 加速与不动点迭代结合起来, 可以得到 Steffensen 迭代法:

$$
\begin{cases}
y_k = \varphi(x_k) \\
z_k = \varphi(y_k) \\
x_{k+1} = x_k - \dfrac{(y_k - x_k)^2}{z_k - 2y_k + x_k}
\end{cases}
\tag{5.2.1}
$$

(5.2.1) 可以写成不动点迭代的形式

$$
x _ {k + 1} = \psi (x _ {k})
$$

其中

$$
\begin{array}{r l} {\psi (x) = x - \frac {[ \varphi (x) - x ] ^ {2}}{\varphi (\varphi (x)) - 2 \varphi (x) + x}} \\ {= \frac {x \varphi (\varphi (x)) - \varphi (x) ^ {2}}{\varphi (\varphi (x)) - 2 \varphi (x) + x}} \end{array}\tag{5.2.2}
$$

**定理 5.2.2** 若 $x^{*}$ 是 $\psi$ 的不动点，则 $x^{*}$ 是 $\varphi$ 的不动点。

若 $x^{*}$ 是 $\varphi$ 的不动点，设 $\varphi'$ 存在连续， $\varphi'(x^{*}) \neq 1$，则 $x^{*}$ 是 $\psi$ 的不动点

**证明：** 若 $x^{*}$ 是 $\psi$ 的不动点，代入 (5.2.2) 得

$$
\frac {\left[ \varphi (x ^ {*}) - x ^ {*} \right] ^ {2}}{\varphi (\varphi (x ^ {*})) - 2 \varphi (x ^ {*}) + x ^ {*}} = 0
$$

若分母不为 0 则有 $\varphi(x^{*}) = x^{*}$

若分母为 0 即 $\varphi (\varphi (x^{*})) = 2\varphi (x^{*}) - x^{*}$

利用 (5.2.2) 第二式，有分子为 0

$$
x ^ {*} \varphi (\varphi (x ^ {*})) - \varphi (x ^ {*}) ^ {2} = 0
$$

$\Rightarrow {\left( \varphi \left( {x}^{ * }\right) - {x}^{ * }\right) }^{2} = 0$

$\Rightarrow \varphi \left( {x}^{ * }\right) = {x}^{ * }$

若 $x^{*}$ 是 $\varphi$ 的不动点，代入 (5.2.2) 第一式，利用

洛必达法则及 $\varphi'(x^*) \neq 1$ 有

$$
\lim _ {x \to x ^ {*}} \frac {\left[ \varphi (x) - x \right] ^ {2}}{\varphi (\varphi (x)) - 2 \varphi (x) + x} = \frac {2 \left(\varphi (x ^ {*}) - x ^ {*}\right) \left(\varphi^ {\prime} (x ^ {*}) - 1\right)}{\left(\varphi^ {\prime} (x ^ {*})\right) ^ {2} - 2 \varphi^ {\prime} (x ^ {*}) + 1} = 0
$$

所以有 $\psi(x^{*})=x^{*}$

**定理 5.2.3.** 设 $x^{*}$ 是 $\varphi$ 的不动点，在 $x^{*}$ 邻域 $\varphi$ 有 $p+1$ 阶

导数存在且连续．对 $p=1$ 若 $\varphi'(x^{*}) \neq 1$ ，则

Steffensen 迭代法二阶收敛. 若 $x_{k+1} = \varphi(x_k)$

$p$ 阶收敛 (P>1) 则 Steffensen 迭代法 $2p-1$ 阶收敛.

---

**本章小结：** 不动点迭代是求解非线性方程最基本的工具。压缩映射原理保证了全局收敛性，收敛阶刻画了收敛速度——线性收敛每步固定比例衰减，高阶收敛则越来越快。Aitken 和 Steffensen 方法可以在不增加导数计算的前提下提升收敛速度。下一章介绍的 Newton 法利用导数信息，天然具有二阶收敛。

[← 上一篇：多重网格法](/posts/numerical-analysis-1/07-multigrid/)

[下一篇：Newton迭代法 →](/posts/numerical-analysis-1/09-newton-method/)
