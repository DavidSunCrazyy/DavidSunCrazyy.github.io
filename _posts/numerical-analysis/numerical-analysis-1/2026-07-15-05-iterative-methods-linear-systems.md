---
note: true
layout: post
title: "Numerical Analysis I 线性方程组的迭代解法——Jacobi、Gauss-Seidel与SOR"
permalink: /posts/numerical-analysis-1/05-iterative-methods-linear-systems/
categories: numerical-analysis
tags: [numerical-analysis, iterative-methods, jacobi, gauss-seidel, sor]
use_math: true
---

直接解法（如 Gauss 消去法）对大规模稀疏矩阵效率不高——$O(n^3)$ 的计算量和大量非零元的填充让它在 $n$ 很大时不堪重负。迭代法从初始猜测出发，逐步逼近精确解，每步只需矩阵-向量乘法，计算量远小于直接法。本章从迭代法的一般收敛理论讲起，然后介绍三种经典的定常迭代方法。

## 第四章 线性方程组的迭代解法

迭代法的基本形式是：从 $x^{(0)}$ 出发，按某种规则生成序列 $\{x^{(k)}\}$，希望它收敛到 $Ax = b$ 的真解 $x^*$。根据生成规则的不同，可分为以下几类：

$x^{(k+1)} = F_k(x^{(k)} \cdots x^{(k-m)})$，多步迭代法；

$x^{(k+1)} = F_k(x^{(k)})$，单步迭代法；

$$
x ^ {(k + 1)} = B _ {k} x ^ {(k)} + f _ {k},
$$

单步线性迭代法；

$$
x ^ {(k + 1)} = B x ^ {(k)} + f,
$$

单步定常线性迭代法。

## 4.1 迭代法的基本概念

### 向量序列和矩阵序列的极限

**定义 4.1.1** 定义了范数 $\|\cdot\|$ 的向量空间 $\mathbb{R}^n$ 中，如果

存在向量 $x \in \mathbb{R}^{n}$ 满足

$$
\lim _ {k \to \infty} \| x ^ {(k)} - x \| = 0
$$

则称 $\{x^{(k)}\}$ 收敛于 x，记为 $\lim_{k\to\infty}x^{(k)}=x$

$$
\begin{aligned}
\lim _ {k \to \infty} x ^ {(k)} = x &\Leftrightarrow \lim _ {k \to \infty} \max _ {1 \le i \le n} | x _ {i} ^ {(k)} - x _ {i} | = 0 \\
&\Leftrightarrow \lim _ {k \to \infty} | x _ {i} ^ {(k)} - x _ {i} | = 0, i = 1, 2, \dots , n \\
&\Leftrightarrow \lim _ {k \to \infty} x _ {i} ^ {(k)} = x _ {i}
\end{aligned}
$$

即向量序列收敛 $\Leftrightarrow$ 按分量收敛

Cauchy 列: $\{x^{(k)}\}$ 满足 $\forall \varepsilon > 0, \exists N_{\varepsilon} \in \mathbb{N}$ 使得

$$
\| x ^ {(p)} - x ^ {(g)} \| < \varepsilon , \quad \forall p, g > N _ {\varepsilon}
$$

$\{ x^{(k)}\}$ 收敛 $\Leftrightarrow$ $\{ x^{(k)}\}$ 是 Cauchy 列

**定义4.1.2.** 定义了矩阵范数的空间 $\mathbb{R}^{n \times n}$ , 如果存在 $A \in \mathbb{R}^{n \times n}$ 使得

$$
\lim _ {k \to \infty} \| A ^ {(k)} - A \| = 0
$$

则称 $\{A^{(k)}\}$ 收敛于 $A$，记为 $\lim_{k\to\infty}A^{(k)}=A$

$$
\lim _ {k \to \infty} A ^ {(k)} = A \quad \Leftrightarrow \quad \lim _ {k \to \infty} a _ {i j} ^ {(k)} = a _ {i j}, \quad i, j = 1, 2, \dots , n
$$

**定理 4.1.1** $\lim _{k\to \infty}A^{(k)} = 0\Leftrightarrow \lim _{k\to \infty}A^{(k)}x = 0,\forall x\in \mathbb{R}^n$

**证明：** 由于 $\|\mathbf{A}^{(k)}\mathbf{x}\|\leq\|\mathbf{A}^{(k)}\|\|\mathbf{x}\|$

所以若 $\lim_{k\to\infty}A^{(k)}=0$ 则有 $\lim_{k\to\infty}\left| \left| A^{(k)} \right| \right| = 0$

$$
\Rightarrow \lim _ {k \to \infty} \| A ^ {(k)} x \| = 0 \quad \forall x \in \mathbb {R} ^ {n}
$$

反之，取 $x = {e}_{j}$ 则 $\mathop{\lim }\limits_{k \to \infty }{A}^{\left( k\right) }{e}_{j} = 0$

$$
\Rightarrow \lim _ {k \to \infty} a _ {i j} ^ {(k)} = 0, i = 1, 2, \dots , n
$$

$$
\Rightarrow \quad \lim _ {k \to \infty} a _ {i j} ^ {(k)} = 0, \quad i, j = 1, 2, \cdots, n.
$$

$\Rightarrow \lim _{k \to \infty } {A}^{\left( k\right) } = 0$

**定理 4.1.2.** 设 $B \in \mathbb{R}^{n \times n}$ ，则下列三个命题等价

1. $\lim _{k \to \infty} B^{k} = 0$

2. $\rho(B) < 1$

3. 至少存在一种矩阵从属范数使得 $\parallel B\parallel < 1$

**证明：** $1 \Rightarrow 2$ . 设 $\lambda$ 是$B$的特征值，对应特征向量为 $x \neq 0$

即 ${Bx} = {\lambda x}$ ,从而有 ${B}^{k}x = {\lambda }^{k}x$

$\Rightarrow {\left| \lambda \right| }^{k}\left| \left| x\right| \right| = \left| \left| {B}^{k}x\right| \right|$

已知 $\lim_{k\to\infty}B^{k}=0$ 由**定理 4.1.1** 知

$$
\lim _ {k \to \infty} B ^ {k} x = 0 \Rightarrow \lim _ {k \to \infty} | \lambda | ^ {k} \| x \| = 0 \Rightarrow | \lambda | < 1
$$

$\Rightarrow \rho \left( B\right) < 1$

$2 \Rightarrow 3$ . 由第一章定理可得

$3 \Rightarrow 1$ 由 $\| B^{k} \| \leq \| B \|^{k}$ 可得

**定理 4.1.3.** 设 $B \in \mathbb{R}^{n \times n}$ ，$\|\cdot\|$ 为任一种矩阵范数，则

$$
\lim _ {k \to \infty} \| B ^ {k} \| ^ {\frac {1}{k}} = \rho (B)
$$

**证明：** 由第一章定理知 $\rho(B) \leq ||B||$

所以 $\rho(B) \leq [\rho(B^{k})]^{\frac{1}{k}} \leq ||B^{k}||^{\frac{1}{k}}$

另一方面 $\forall \varepsilon > 0,$ 令

$$
B _ {\varepsilon} = [ \rho (B) + \varepsilon ] ^ {- 1} B
$$

则有 $\rho(B_{\varepsilon}) < 1$

由**定理 4.1.2** 得 $\lim_{k\to\infty}B_{\varepsilon}^{k}=0$ 所以存在 $N_{\varepsilon}\in \mathbb{N}$

$\forall k > N_{\varepsilon}$ 有

$$
\| B _ {\varepsilon} ^ {k} \| = \frac {\| B ^ {k} \|}{[ \rho(B) + \varepsilon ] ^ {k}} < 1
$$

即有 $\rho(B) \leq \|B^k\|^{\frac{1}{k}} < \rho(B) + \varepsilon$

### 迭代法收敛性

设已有迭代法

$$
x ^ {(k + 1)} = B x ^ {(k)} + f, B \in \mathbb {R} ^ {n \times n}, f \in \mathbb {R} ^ {n}
$$

$x^{*}\in\mathbb{R}^{n}$ 满足

$$
x ^ {*} = B x ^ {*} + f
$$

记误差向量为

$$
e ^ {(k)} = x ^ {(k)} - x ^ {*}
$$

则 $e^{(k)}$ 满足

$$
e ^ {(k + 1)} = B e ^ {(k)}
$$

迭代法收敛 $\Leftrightarrow$ $\lim_{k\to\infty}e^{(k)}=0$

**定理 4.1.4.** 迭代法 $x^{(k+1)} = Bx^{(k)} + f$ 收敛的两个等价条件为

(1) $\rho(B) < 1$

(2) 至少存在一种矩阵从属范数,使得 $\left\| B\right\| < 1$

**证明：** 迭代法收敛 $\Leftrightarrow \lim_{k\to\infty}e^{(k)}=0$

$\Leftrightarrow \lim _{k \to \infty} B^{k} e^{(0)} = 0$

$\Leftrightarrow \lim _{k \to \infty} B^{k} = 0$

由**定理 4.1.2** 得 $\lim _{k \to \infty} B^{k} = 0$ 与 $(1, (2))$ 等价

**定理 4.1.5** 设 $x^{*}$ 是方程组 $x = Bx + f$ 的唯一解.

$\|\cdot\|$ 是一种向量范数，其从属范数 $\parallel B\parallel = q < 1$

则 $x^{(k+1)} = B x^{(k)} + f$ 收敛且

$$
\| x ^ {(k)} - x ^ {*} \| \leq \frac {q}{1 - q} \| x ^ {(k)} - x ^ {(k - 1)} \|
$$

$$
\| x ^ {(k)} - x ^ {*} \| \leq \frac {q ^ {k}}{1 - q} \| x ^ {(1)} - x ^ {(0)} \|
$$

**证明：** 由**定理 4.1.4** 迭代法收敛.

$$
\begin{array}{r l} {x ^ {(k)} - x ^ {*}} & {= B (x ^ {(k - 1)} - x ^ {*})} \\ & {= B (x ^ {(k - 1)} - x ^ {(k)}) + B (x ^ {(k)} - x ^ {*})} \end{array}
$$

$$
\| x ^ {(k)} - x ^ {*} \| \leq q \| x ^ {(k - 1)} - x ^ {(k)} \| + q \| x ^ {(k)} - x ^ {*} \|
$$

$$
\Rightarrow \| x ^ {(k)} - x ^ {*} \| \leq \frac {q}{1 - q} \| x ^ {(k - 1)} - x ^ {(k)} \|
$$

$$
\Rightarrow \| x ^ {(k)} - x ^ {*} \| \leq \frac {q ^ {k}}{1 - q} \| x ^ {(1)} - x ^ {(0)} \|
$$

**定义 4.1.4** 迭代法 ${x}^{\left( {k + 1}\right) } = B{x}^{\left( k\right) } + f$ 的平均收敛率

定义为

$$
R _ {k} (B) = - \ln {\| B ^ {k} \| ^ {\frac {1}{k}}}
$$

**定义 4.1.5** $R(B) = -\ln \rho (B)$ 称为迭代法的渐近收敛率

## 4.2. Jacobi 和 Gauss-Seidel 迭代法

考虑线性方程组

$$
A x = b
$$

$A = [a_{ij}] \in \mathbb{R}^{n \times n}$ 可逆, $b \in \mathbb{R}^n$ , 记

$$
A = D - L - U
$$

$D = \operatorname{diag}(a_{11} \cdots a_{nn}), -L, -U$ 分别为严格上, 下三角部分

### Jacobi 迭代法

设 D 非奇异，则有

$$
A x = b \Leftrightarrow x = B _ {J} x + f _ {J}
$$

其中

$$
B _ {J} = D ^ {- 1} (L + U), \quad f _ {J} = D ^ {- 1} b
$$

由此构造迭代法

$$
x ^ {(k + 1)} = B _ {J} x ^ {(k)} + f _ {J}
$$

称为 Jacobi 迭代法

### Gauss - Seidel 迭代法

D 非奇异，则

$$
A x = b \Leftrightarrow x = B _ {G} x + f _ {G}
$$

其中

$$
B _ {G} = (D - L) ^ {- 1} U = I - (D - L) ^ {- 1} A
$$

$$
f _ {G} = (D - L) ^ {- 1} b
$$

由此构造迭代法

$$
x ^ {(k + 1)} = B _ {G} x ^ {(k)} + f _ {G}
$$

称为 Gauss-Seidel 迭代法

### Jacobi 迭代 和 Gauss-Seidel 迭代的收敛性

**定理 4.2.1** $A$ 为严格对角占优或不可约弱对角占优，则 $Ax=b$ 的 Jacobi 迭代和 G-S 迭代均收敛.

**证明：** 由第一章定理知 A 非奇异且 $a_{ii} \neq 0$ .

考虑 GS 迭代．假设 $B_{G} = (D-L)^{-1} U$ 有一个特征值 $\lambda$

满足 $|\lambda| \geq 1$ 则

$$
\det [ \lambda I - (D - L) ^ {- 1} U ] = 0
$$

$$
\det (D - L) ^ {- 1} \det (\lambda (D - L) - U) = 0
$$

$\Rightarrow \lambda \left( {D - L}\right) - U$ 奇异

注意到 $\lambda(D-L)-U$ 与 $A=D-L-U$ 零元素位置相同

故 $\lambda(D-L)-U$ 是不可约的并且由 $|\lambda| \geq 1$ 得

$\lambda(D-L)-U$ 也是严格对角占优或弱对角占优

由此推出矛盾 由反证法得 $\rho (B_G) < 1$

故 GS 迭代收敛.

Jacobi 迭代收敛 类似可证

**定理 4.2.2.** 设 A 对称，且 $a_{ii}>0,\quad i=1,2,\cdots,n$

则 ${Ax} = b$ 的 Jacobi 迭代收敛的充要条件为
$A, 2D-A$ 均正定, $D = \operatorname{diag}(a_{11}, \cdots ,a_{nn})$

**证明：** 记 ${D}^{\frac{1}{2}} = \operatorname{diag}\left( {\sqrt{a}_{11},\cdots \sqrt{a}_{nn}}\right)$ 则有

$$
B _ {J} = I - D ^ {- 1} A = D ^ {- \frac {1}{2}} (I - D ^ {- \frac {1}{2}} A D ^ {- \frac {1}{2}}) D ^ {\frac {1}{2}}
$$

$\Rightarrow B_{J}$ 与 $I - D^{-\frac{1}{2}} A D^{-\frac{1}{2}}$ 相似

$\Rightarrow {B}_{J}$ 的特征值为 $1 - \mu ,\;\mu$ 为 ${D}^{-\frac{1}{2}}A{D}^{-\frac{1}{2}}$ 的特征值

若 Jacobi 迭代收敛 则有 $\rho(B_{J})<1 \Rightarrow |1-\mu|<1$

$\Rightarrow 0 < \mu < 2$

$\Rightarrow {D}^{-\frac{1}{2}}A{D}^{-\frac{1}{2}},\;{2I} - {D}^{-\frac{1}{2}}A{D}^{-\frac{1}{2}}$ 均正定

$\Rightarrow A$ 2D-A 均正定

若 $A,{2D} - A$ 均正定

$\Rightarrow {D}^{-\frac{1}{2}}A{D}^{-\frac{1}{2}},\;{2I} - {D}^{-\frac{1}{2}}A{D}^{-\frac{1}{2}}$ 均正定

$\Rightarrow$ $\mu > 0, \; 2 - \mu > 0$

$\Rightarrow 0 < \mu < 2$ $\Rightarrow \left| {1 - \mu }\right| < 1$

$\Rightarrow \rho \left( {B}_{J}\right) < 1$ $\Rightarrow$ Jacobi 迭代收敛

**定理 4.2.3** 若 A 对称正定，则 $Ax=b$ 的 G-S 迭代收敛.

**定理 4.2.4** 设 $A \in \mathbb{R}^{n \times n}$ ，A 对称非奇异，且 $a_{i,i} > 0, i = 1, 2, \cdots, n$

若 ${Ax} = b$ 的 G-S 迭代收敛，则 $A$ 正定

**证明：** 设 $x^{\ast}$ 是 $Ax=b$ 的解， $x^{(k)}$ 是第 $k$ 次迭代的

结果， $e^{(k)} = x^{(k)} - x^\ast$ ， $\delta^{(k)} = e^{(k)} - e^{(k+1)} = x^{(k)} - x^{(k+1)}$

则有

$$
(D - L) e ^ {(k + 1)} = U e ^ {(k)}
$$

$$
(D - L) \delta^ {(k)} = A e ^ {(k)}
$$

$$
A e ^ {(k + 1)} = U \delta^ {(k)}
$$

由于 $A$ 对称

$$
\begin{array}{r l} & {(e ^ {(k)}, A e ^ {(k)}) - (e ^ {(k + 1)}, A e ^ {(k + 1)})} \\ {=} & {(e ^ {(k)}, A \delta^ {(k)}) + (\delta ^ {(k)}, A e ^ {(k + 1)})} \\ {=} & {(A e ^ {(k)} + A e ^ {(k + 1)}, \delta^ {(k)})} \\ {=} & ((D - L) \delta^ {(k)} + U \delta^ {(k)}, \delta^ {(k)}) \\ {=} & {(\delta^ {(k)}, D \delta^ {(k)})} \end{array}
$$

$$
L = U ^ {T}
$$

$a_{ii} > 0 \Rightarrow D$ 正定 $\Rightarrow \left\{ (e^{(k)}, A e^{(k)}) \right\}$ 是不增的数列

假设 $A$ 不正定 则 存在 ${e}^{\left( 0\right) } \neq 0$ 使得

$$
\{e ^ {(0)}, A e ^ {(0)} \} \le 0
$$

$$
\delta^ {(0)} = e ^ {(0)} - e ^ {(1)} = (I - B _ {G}) e ^ {(0)}
$$

由于 GS 收敛，所以 $\rho(B_{G})<1 \Rightarrow \delta^{(0)}\neq0$

$\Rightarrow \left( {\delta}^{\left( 0\right) },{D\delta}^{\left( 0\right) }\right) > 0$

$$
\Rightarrow (e ^ {(1)}, A e ^ {(1)}) < (e ^ {(0)}, A e ^ {(0)}) \leq 0
$$

另一方面 GS 收敛 $\Rightarrow$ $\lim _{k\to\infty}e^{(k)}=0$

$$
\Rightarrow \lim _ {n \to \infty} (e ^ {(n)}, A e ^ {(n)}) = 0
$$

与 $(e^{(1)}, A e^{(1)}) < 0$ 且 $(e^{(n)}, A e^{(n)})$ 不增矛盾

## 4.3 超松驰迭代法

GS迭代写成分量形式为

$$
x _ {i} ^ {(k + 1)} = \frac {1}{a _ {i i}} (b _ {i} - \sum_ {j = 1} ^ {i - 1} a _ {i j} x _ {j} ^ {(k + 1)} - \sum_ {j = i + 1} ^ {n} a _ {i j} x _ {j} ^ {(k)})
$$

将 GS 迭代的结果与 $\alpha_{i}^{(k)}$ 作加权平均可得超松弛迭代法，即

$$
\overline {x} _ {i} ^ {(k + 1)} = \frac {1}{a _ {i i}} (b _ {i} - \sum_ {j = 1} ^ {i - 1} a _ {i j} x _ {j} ^ {(k + 1)} - \sum_ {j = i + 1} ^ {n} a _ {i j} x _ {j} ^ {(k)})
$$

$$
x _ {i} ^ {(k + 1)} = \omega \overline {x} _ {i} ^ {(k + 1)} + (1 - \omega) x _ {i} ^ {(k)}
$$

迭代公式为

$$
x _ {i} ^ {(k + 1)} = (1 - w) x _ {i} ^ {(k)} + \frac {w}{a _ {i i}} (b _ {i} - \sum_ {j = 1} ^ {i - 1} a _ {i j} x _ {j} ^ {(k + 1)} - \sum_ {j = i + 1} ^ {n} a _ {i j} x _ {j} ^ {(k)})
$$

称为 逐次超松弛迭代法，简称 SOR

$ω$ 称为松弛因子.

写成矩阵的形式为

$$
x ^ {(k + 1)} = (1 - \omega) x ^ {(k)} + \omega D ^ {- 1} (b + L x ^ {(k + 1)} + U x ^ {(k)})
$$

$$
\Rightarrow x ^ {(k + 1)} = B _ {\omega} x ^ {(k)} + \omega (D - \omega L) ^ {- 1} b
$$

其中

$$
B _ {\omega} = (D - \omega L) ^ {- 1} [ (1 - \omega) D + \omega U ]
$$

### SOR 迭代的收敛性

**定理 4.3.1** $A \in {\mathbb{R}}^{n \times n}$ 非奇异, ${a}_{ii} \neq 0,i = 1,2,\cdots ,n$ 则 $∀ ω$ 有

$$
\rho (B_{\omega}) \ge | \omega - 1 |
$$

**证明：** 设 $B_\omega$ 的 $n$ 个特征值为 $\lambda_{1}\cdots\lambda_{n}$ 则

$$
\begin{array}{r l} {\lambda_ {1} \dots \lambda_ {n}} & {= \det B_{\omega}} \\ & {= \det (D - w L) ^ {- 1} \det ((1 - w) D + w U)} \\ & {= \det D ^ {- 1} \det (1 - w) D = (1 - w) ^ {n}} \end{array}
$$

$$
\Rightarrow \rho (B \omega) = \max _ {1 \le i \le n} | \lambda_ {i} | \ge | \lambda_ {1} \dots \lambda_ {n} | ^ {\frac {1}{n}} = | 1 - \omega |
$$

**推论：** 若 $Ax=b$ 的 SOR 迭代收敛 则 $0<\omega<2$

**定理 4.3.2** $A \in {\mathbb{R}}^{n \times n}$ 对称正定, $0 < \omega < 2$ 则

$Ax=b$ 的 SOR 迭代收敛

取 $w = 1$ ，可得**定理 4.2.3**

**证明：** 设 $\lambda$ 是 $B\omega$ 的特征值， $x$ 为特征向量，则有

注意： $x \in \mathbb{C}$ , $x \in \mathbb{C}^n$

$$
[ (1 - \omega) D + \omega U ] x = \lambda (D - \omega L) x
$$

$\Rightarrow (1 - \omega)(Dx, x) + \omega(Ux, x) = \lambda[(Dx, x) - \omega(Lx, x)]$

$$
\Rightarrow \quad \lambda = \frac {(1 - \omega) (D x , x) + \omega (U x , x)}{(D x , x) - \omega (L x , x)}
$$

$A$ 正定 则 $D$ 也正定，记 $P = (Dx, x) > 0$

记 $(L x, x) = \alpha + i\beta$ 则有

$$
(U x, x) = (L ^ {T} x, x) = (x, L x) = \overline {(L x , x)} = \alpha - i \beta
$$

代入 $\lambda$ 的表达式有

$$
\lambda = \frac {(1 - \omega) p + \omega \alpha - i \omega \beta}{p - \omega \alpha - i \omega \beta}
$$

$$
\Rightarrow | \lambda | ^ {2} = \frac {(p - \omega (p - \alpha)) ^ {2} + \omega ^ {2} \beta^ {2}}{(p - \omega \alpha) ^ {2} + \omega ^ {2} \beta^ {2}}
$$

分子减分母得

$$
(P - \omega (P - \alpha)) ^ {2} - (P - \omega \alpha) ^ {2} = P \omega (2 - \omega) (2 \alpha - P)
$$

$A$ 正定 则

$$
\begin{array}{r l} {(A x, x)} & {= (D x, x) - (L x, x) - (U x, x)} \\ & {= P - 2 \alpha > 0} \end{array}
$$

因为 $0 < \omega < 2$ 所以有 $|\lambda|^2 < 1 \Rightarrow \rho(B\omega) < 1$

从而 SOR 迭代收敛.

**定理 4.3.3.** $A \in \mathbb{R}^{n \times n}$ 对称非奇异， $a_{i i} > 0, i = 1, 2, \cdots, n$ 若 $Ax = b$ 的 SOR 迭代收敛，则 $A$ 正定.

### 最优松弛因子

$$
\omega _ {b} = \arg\min _ {0 < \omega < 2} \rho (B _ {\omega})
$$

称为SOR迭代的最优松弛因子.

**定义4.3.1** $A = [a_{ij}] \in \mathbb{R}^{n \times n}$ 称为具有相容次序的矩阵

如果其具有下列性质：

对某正整数 $l$ 存在 $\{ 1,2,\cdots ,n\}$ 的 $t$ 个互不相

交的子集 $S_1, \cdots S_{t}, \quad \bigcup_{i=1}^{t} S_i = \{1, 2, \cdots, n\}$

满足：若 $i \in S_k$ 则有

$$
\{j < i, a _ {i j} \neq 0 \} \subset S _ {k - 1}
$$

$$
\{j > i, a _ {i j} \neq 0 \} \subset S _ {k + 1}
$$

**定理 4.3.4.** 设 A 具有相容次序, ${a}_{ii} \neq 0\;i = 1,2,\cdots ,n,\;\omega \in \left( {0,2}\right)$

则有：

(1) 若 $\mu \in \sigma(B_J)$ , 则 $-\mu \in \sigma(B_J)$

(2) 若 $\mu \in \sigma(B_{J})$ , 且 $\lambda$ 满足

$$
(\lambda + \omega - 1) ^ {2} = \lambda \omega^ {2} \mu^ {2}
$$

(4.3.1)

则 $\lambda \in \sigma(B\omega)$

(3) 若 $\lambda \neq 0, \lambda \in \sigma(B\omega)$ , 则满足 (4.3.1) 的 $\mu \in \sigma(B_J)$

**证明：** 
 
将矩阵 $A$ 分裂为 $A = D - L - U$，其中 
$D = \operatorname{diag}(a_{11},\dots,a_{nn})$，由条件 $a_{ii}\neq 0$ 知 $D$ 可逆； 
$-L$ 为 $A$ 的严格下三角部分，$-U$ 为严格上三角部分。 
雅可比迭代矩阵为 $B_J = D^{-1}(L+U)$， 
SOR 迭代矩阵为 $B_\omega = (D-\omega L)^{-1}\bigl((1-\omega)D+\omega U\bigr)$，$\omega\in(0,2)$。

由定义 4.3.1，存在不相交集 $S_1,\dots,S_t$ 构成 $\{1,\dots,n\}$ 的划分，满足相容次序条件。


(1) 证明 $\mu\in\sigma(B_J) \Rightarrow -\mu\in\sigma(B_J)$

构造对角矩阵 $Q = \operatorname{diag}(q_1,\dots,q_n)$，其中 
$q_i = (-1)^k$ 当 $i\in S_k$。

对 $B_J$ 作相似变换 $Q^{-1}B_J Q$，考虑其 $(i,j)$ 元：
- 若 $i=j$，$(B_J)_{ii}=0$，变换后仍为 $0$；
- 若 $i\neq j$ 且 $a_{ij}\neq 0$，由相容次序：若 $j<i$ 则 $i\in S_k,\;j\in S_{k-1}$；若 $j>i$ 则 $i\in S_k,\;j\in S_{k+1}$。

于是
$$
(Q^{-1}B_J Q)_{ij}
= q_i^{-1}(B_J)_{ij}\,q_j
= (-1)^{-k}(-1)^{k\pm 1}(B_J)_{ij}
= (-1)^{\pm 1}(B_J)_{ij} = -(B_J)_{ij}.
$$
因此 $Q^{-1}B_J Q = -B_J$，即 $B_J$ 与 $-B_J$ 相似，从而它们的特征值集合相同：
$$
\sigma(B_J) = \sigma(-B_J) = \{-\mu : \mu\in\sigma(B_J)\}.
$$
故 $\mu\in\sigma(B_J)$ 时必有 $-\mu\in\sigma(B_J)$。 

(2) 与 (3) 的准备：相似变换

令 $\lambda\in\mathbb{C}$ 满足 $\lambda\neq 0$，取定 $\sqrt{\lambda}$ 为某一平方根。 
构造对角矩阵 $P = \operatorname{diag}(p_1,\dots,p_n)$，其中 
$p_i = (\sqrt{\lambda})^k$ 当 $i\in S_k$。

考察 $P^{-1}L_J P$ 与 $P^{-1}U_J P$（这里 $L_J=D^{-1}L,\;U_J=D^{-1}U$）：
- 对 $j<i$ 且 $a_{ij}\neq 0$，$i\in S_k,\;j\in S_{k-1}$，
 $(P^{-1}L_J P)_{ij} = \lambda^{-k/2}(L_J)_{ij}\lambda^{(k-1)/2} = \lambda^{-1/2}(L_J)_{ij}$；
- 对 $j>i$ 且 $a_{ij}\neq 0$，$i\in S_k,\;j\in S_{k+1}$，
 $(P^{-1}U_J P)_{ij} = \lambda^{-k/2}(U_J)_{ij}\lambda^{(k+1)/2} = \lambda^{1/2}(U_J)_{ij}$。

于是
$$
P^{-1}(\lambda\omega L_J + \omega U_J)P
= \lambda\omega\cdot\lambda^{-1/2}L_J + \omega\cdot\lambda^{1/2}U_J
= \omega\sqrt{\lambda}\,(L_J+U_J)
= \omega\sqrt{\lambda}\,B_J.
$$

(2) 证明：若 $\mu\in\sigma(B_J)$ 且 $\lambda$ 满足 (4.3.1)，则 $\lambda\in\sigma(B_\omega)$

$\lambda$ 是 $B_\omega$ 的特征值当且仅当
$$
\det\bigl(\lambda I - B_\omega\bigr)=0
\iff \det\bigl((\lambda+\omega-1)D - \lambda\omega L - \omega U\bigr)=0.
$$
因 $D$ 可逆，左乘 $\det(D^{-1})$ 得等价条件
$$
\det\bigl((\lambda+\omega-1)I - \lambda\omega L_J - \omega U_J\bigr)=0. \tag{*}
$$

**情形 1：$\lambda = 0$** 
此时 (4.3.1) 成为 $(\omega-1)^2=0$，即 $\omega=1$。 
当 $\omega=1$ 时，$(*)$ 式化为 $\det( -U_J)=0$，由于 $U_J$ 是严格上三角矩阵，其行列式为 $0$，故 $0\in\sigma(B_1)$ 成立。

**情形 2：$\lambda \neq 0$** 
利用前述 $P$ 作相似变换，$(*)$ 等价于
$$
\det\bigl((\lambda+\omega-1)I - \omega\sqrt{\lambda}B_J\bigr)=0.
$$
这说明存在 $\nu\in\sigma(B_J)$ 使得
$$
\lambda+\omega-1 = \omega\sqrt{\lambda}\,\nu. \tag{†}
$$
已知 $\mu\in\sigma(B_J)$ 且 $(\lambda+\omega-1)^2 = \lambda\omega^2\mu^2$，即
$\lambda+\omega-1 = \pm\,\omega\sqrt{\lambda}\,\mu$。 
若等式取正号，则取 $\nu=\mu$，满足 $(†)$； 
若等式取负号，则由 (1) 知 $-\mu\in\sigma(B_J)$，取 $\nu=-\mu$ 同样满足 $(†)$。 
因此总存在 $\nu\in\sigma(B_J)$ 使 $(†)$ 成立，从而 $\lambda\in\sigma(B_\omega)$。

(3) 证明：若 $0\neq\lambda\in\sigma(B_\omega)$，则存在满足 (4.3.1) 的 $\mu\in\sigma(B_J)$

由 $\lambda\neq 0$ 且 $\lambda\in\sigma(B_\omega)$，利用 $(*)$ 及相似变换得
$$
\det\bigl((\lambda+\omega-1)I - \omega\sqrt{\lambda}B_J\bigr)=0,
$$
故存在 $\mu\in\sigma(B_J)$ 满足
$$
\lambda+\omega-1 = \omega\sqrt{\lambda}\,\mu.
$$
两边平方即得 $(\lambda+\omega-1)^2 = \lambda\omega^2\mu^2$，正是 (4.3.1)。 
（若 $\lambda=0\in\sigma(B_\omega)$，定理(3)的条件已排除，无需讨论）。

综上，定理 4.3.4 全部证毕。 $\square$

**定理 4.3.5,** 设 $A$ 具有相容次序, ${a}_{ii} \neq 0,i = 1,2,\cdots ,n$ 且

$\sigma(B_{J}) \subset \mathbb{R}$ , 则 SOR 迭代收敛 当且仅当

$$
\mu = \rho (B _ {J}) < 1, \quad 0 < \omega < 2
$$

而且最优松弛因子

$$
\begin{array}{l l} \omega_ {b} = \frac {2}{1 + \sqrt {1 - \mu^ {2}}} \\ \rho (B _ {\omega}) = \left\{ \begin{array}{l l} \frac {1}{4} [ \omega \mu + \sqrt {\omega^ {2} \mu^ {2} - 4 (\omega - 1)} ] ^ {2}, & \omega \in (0, \omega_ {b}) \\ \omega - 1, & \omega \in [ \omega_ {b}, 2) \end{array} \right. \end{array}
$$

**例（一维 Poisson 方程边值问题的差分格式）**

$$
u ^ {\prime \prime} (x) = f (x) \quad x \in (0, 1)
$$

$$
u (0) = a, \quad u (1) = b
$$

空间离散: $x_{j} = jh, \quad h = \frac{1}{N+1}, \quad j = 0, 1, \cdots, N+1$

二阶导数的中心差分逼近：

$$
u ^ {\prime \prime} (x _ {j}) \approx \frac {1}{h ^ {2}} (u (x _ {j + 1}) - 2 u (x _ {j}) + u (x _ {j - 1}))
$$

差分格式为：

$$
\left\{ \begin{array}{l l} \frac {u _ {j + 1} - 2 u _ {j} + u _ {j - 1}}{h ^ {2}} = f _ {j} = f (x _ {j}), j = 1, \dots , N \\ u _ {0} = a \\ u _ {N + 1} = b \end{array} \right.
$$

写成矩阵形式为

$$
A u = d
$$

$$
A = \left[ \begin{array}{l l l l l l} - 2 & 1 & & & & \\ 1 & - 2 & 1 & & & \\ & 1 & - 2 & 1 & & \\ & & \ddots & \ddots & \ddots & \\ & & & \ddots & - 2 & 1 \\ & & & & 1 & - 2 \end{array} \right] \in \mathbb {R} ^ {N \times N}
$$

$$
d = \left[ \begin{array}{l} h ^ {2} f _ {1} - a \\ h ^ {2} f _ {2} \\ \vdots \\ h ^ {2} f _ {N - 1} \\ h ^ {2} f _ {N} - b \end{array} \right] \in \mathbb {R} ^ {N}
$$

相应的

$$
B _ {J} = I - D ^ {- 1} A = I + \frac {1}{2} A = \left[ \begin{array}{l l l l} 0 & \frac {1}{2} & & \\ \frac {1}{2} & 0 & \frac {1}{2} & \\ & \ddots & \ddots & \frac {1}{2} \\ & & \frac {1}{2} & 0 \end{array} \right] \in \mathbb {R} ^ {N}
$$

其特征值为

$$
\mu_ {j} = \cos j \pi h, j = 1 \dots N
$$

相应的特征向量为

$$
v _ {j} = [ \sin j k \pi h ], \quad j, k = 1 \dots N
$$

由此可得

$$
\rho (B _ {J}) = \cos \pi h = 1 - \frac {1}{2} \pi^ {2} h ^ {2} + O (h ^ {4})
$$

由**定理 4.3.5**

$$
\rho (B _ {G}) = \cos^ {2} \pi h = 1 - \pi^ {2} h ^ {2} + O (h ^ {4})
$$

$$
\begin{array}{r l} {\omega_ {b}} & {= \frac {2}{1 + \sin \pi h}} \\ {\rho (B_{\omega_ {b}})} & {= \omega_ {b} - 1 = \frac {\cos^ {2} \pi h}{(1 + \sin \pi h) ^ {2}}} \end{array}
$$

渐近收敛速度

$$
R (B _ {J}) = - \ln \rho (B _ {J}) = \frac {1}{2} \pi^ {2} h ^ {2} + O (h ^ {4})
$$

$$
R (B _ {G}) = - \ln \rho (B _ {G}) = \pi^ {2} h ^ {2} + O (h ^ {4})
$$

$$
\begin{array}{r l} {R (B_{\omega_ {b}})} & {= - \ln (\omega_ {b} - 1)} \\ & {= - 2 (\ln \cos \pi h - \ln (1 + \sin \pi h))} \\ & {= 2 \pi h + O (h ^ {3})} \end{array}
$$



这个例子说明了一个典型现象：网格越密（$h$ 越小），Jacobi 和 Gauss-Seidel 的收敛速度越慢。SOR 方法通过选取合适的松弛因子，显著改善了收敛速度。

---

**本章小结：** 迭代法的收敛性由迭代矩阵的谱半径决定——谱半径小于 1 则收敛，越接近 0 收敛越快。Jacobi、Gauss-Seidel 和 SOR 是三种经典的定常迭代方法，它们简单易实现，但对大规模问题收敛较慢。下一章介绍的共轭梯度法，利用 Krylov 子空间的性质，在这些问题上有着远优于定常迭代的收敛速度。

[← 上一篇：最小二乘问题的解法](/posts/numerical-analysis-1/04-least-squares/)

[下一篇：共轭梯度法 →](/posts/numerical-analysis-1/06-conjugate-gradient/)
