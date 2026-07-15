---
note: true
layout: post
title: "数值分析（一）：基本概念——误差、内积空间、范数与矩阵性质"
permalink: /posts/numerical-analysis-1/01-basic-concepts/
categories: numerical-analysis
tags: [numerical-analysis, error-analysis, vector-norms, matrix-norms, gram-schmidt]
use_math: true
---

本文介绍数值分析的基本概念，包括误差分析理论、浮点数表示、内积空间与 Gram-Schmidt 正交化、向量与矩阵范数、谱半径、对角占优矩阵与不可约矩阵等基础知识。

# 第一章 引论

## 1. 误差

定义: $x \in \mathbb{R}$ , $x_{A}$ 是 $x$ 的一个近似值

$x - x_{A}$ : $x_{A}$ 的误差

$\left| {x - {x}_{A}}\right|  : \;{x}_{A}$ 的绝对误差

$\frac{|x-x_{A}|}{|x|}$ : $x_{A}$ 的相对误差

若存在 $\varepsilon_{A}>0$ ，使得 $\vert x-x_{A}\vert\leq\varepsilon_{A}$

${\varepsilon }_{A} : {x}_{A}$ 的绝对误差界

$\frac{\varepsilon_{A}}{|x|}:\quad x_{A}$ 的相对误差界

例：$π$ 圆周率，$π_A = 3.14$. 则

$\left| {\pi  - {\pi }_{A}}\right|  = {0.0015926}\cdots  \leq  {0.002}$ 绝对误差界

相对误差界： $\frac{0.002}{\pi} \leq 0.00067$

定义： $x_{A}$ 是 $x$ 的一个近似值

$$
x _ {A} = \pm 10^{k} \times 0. d _ {1} d _ {2} \dots d _ {i} \dots
$$

$$
d _ {i} \in \{0, 1, 2, \dots , 9 \}, \quad i = 1, 2, \dots
$$

$$
d _ {1} \neq 0
$$

如果 $n$ 满足

$$
\vert x - x _ {A} \vert \le 0.5 \times 10^{k - n}
$$

的最大非负整数，则称 $x_{A}$ 为 $x$

具有 $n$ 位十进制有效数字的近似值

例： $\pi_{A}=3.14=0.314\times10^{1}$

$\left| {\pi  - {\pi }_{A}}\right|  \leq  {0.5} \times  {10}^{-2} = {0.5} \times  {10}^{1 - 3}$ ,3位有效数字

$$
\pi_ {A} = 3.1416 = 0.31416 \times 10^{1}
$$

$|\pi - \pi_{A}| \leq 1 \times 10^{-5} < 0.5 \times 10^{1-5}$ ，5位有效数字

在数值计算中误差大致分为以下四类：

(1). 输入误差

(2) 舍入误差

(3) 截断误差

(4) 传播误差

## 1.1 浮点数表示与舍入误差

## 二进制浮点计数法

$$
\pm 0. d _ {1} d _ {2} \dots d _ {t} \times 2 ^ {J}
$$

$d_{1}=1,\quad d_{2}\cdots d_{t}\in\{0,1\},\quad J\in\mathbb{Z},\quad L\leq J\leq U$

$0.d_{1}\cdots d_{t}$ 称为尾数，$t$ 称为字长，$J$ 称为阶。

IEEE 标准：单精度：$t=23, L=-126, U=127$

双精度: $t = 52, L = -1022, U = 1023$

$F$: 浮点数的集合

$F$ 对称分布在 $[-M, -m] \cup [m, M]$ 上

$$
m = 2 ^ {L - 1}, M = 2 ^ {U} (1 - 2 ^ {- t})
$$

$x \in  \mathbb{R},\;f\left( x\right)$ 为 $x$ 对应的浮点数

若 $m \leq |x| \leq M$ , $f(x) = \arg\min_{y \in F} |x - y|$

$$
\vert x \vert <   m, \quad f (x) = 0
$$

$$
\vert x \vert > M, \quad f (x) \text {不存在}
$$

定理1.1. $x \in \mathbb{R}$ 满足 $m \leq |x| \leq M$ , 则存在 $S \in \mathbb{R}$

$|\delta| \leq 2^{-t}$ 使得

$$
f (x) = x (1 + \delta)
$$

证明：不妨设 $x > 0$ ，

$$
2 ^ {\alpha - 1} \le x <   2 ^ {\alpha}
$$

在 $\left[2^{\alpha-1}, 2^{\alpha}\right)$ 中浮点数间距为 $2^{\alpha-t}$

故

$$
| f l (x) - x | \leq \frac {1}{2} \cdot 2 ^ {\alpha - t} = 2 ^ {\alpha - 1} \cdot 2 ^ {- t} \leq x \cdot 2 ^ {- t}
$$

$$
\Rightarrow \frac {| f (x) - x |}{x} \le 2 ^ {- t}
$$

$2^{-t}$ 称为机器精度.

例： $x,y \in \mathbb{R}$ ⊕ ⊖ 表示 F 中的加法、减法运算

即

$$
x \oplus y = f l (f l (x) + f l (y))
$$

由定理1.1

$$
\begin{array}{r l} {x \oplus y} & {= (x (1 + \delta_ {x}) + y (1 + \delta_ {y})) (1 + \delta)} \\ & {= x + y + (x \delta_ {x} + y \delta_ {y}) (1 + \delta)} \\ & {\qquad + (x (1 + \delta_ {x}) + y (1 + \delta_ {y})) \delta} \end{array}
$$

$$
\begin{array}{r l} {x \ominus y} & {= f_{l} (f_{l} (x) - f_{l} (y))} \\ & {= (x (1 + \delta x) - y (1 + \delta y)) (1 + \delta)} \\ & {= x - y + (x \delta x - y \delta y) (1 + \delta)} \\ & {+ (x (1 + \delta x) - y (1 + \delta y)) \delta} \end{array}
$$

例: $\ln (1 + x) = \sum_{n=1}^{\infty} (-1)^{n+1} \frac{x^n}{n}$

$$
\begin{array}{r l} {\mathrm{令} x = 1} \\ {\ln 2} & {= \sum_ {n = 1} ^ {\infty} (- 1) ^ {n + 1} \frac {1}{n}} \end{array}
$$

$$
\ln \frac {1 + x}{1 - x} = 2 \left[ x + \frac {x ^ {3}}{3} + \frac {x ^ {5}}{5} + \dots + \frac {x ^ {2 n + 1}}{2 n + 1} + \dots \right]
$$

取 $x = \frac{1}{3}$ 计算 $\ln 2$

练习: 利用 $e^{x} = \sum_{n=0}^{\infty} \frac{x^{n}}{n!}$ 计算 $e^{-25}$

练习: Gram-Schmidt 正交化的修正.

### 1.3 传播误差与稳定性

设 $\varepsilon_{n}$ 为运算 $n$ 步之后的误差

- $|\varepsilon_n| \approx c n \varepsilon_0$ 误差增长为线性型

- $|\varepsilon_n| \approx  {c}^{n}{\varepsilon }_{0}$ 误差增长为指数型

指数型的误差增长若 $c > 1$ ，则是不稳定的

相应的数值方法在实际计算中不可用、

例：生成序列 $x_{n}=\frac{1}{3^{n}}$

(1) $x_0 = 1$ , $x_n = \frac{1}{3} x_{n-1}$

$$
(2) \quad x _ {0} = 1, \quad x _ {1} = \frac {1}{3}, \quad x _ {n} = \frac {4}{3} x _ {n - 1} - \frac {1}{3} x _ {n - 2}
$$

(3), $x_0 = 1$ , $x_1 = \frac{1}{3}$ , $x_n = \frac{10}{3} x_{n-1} - x_{n-2}$

(1) $r_0 = 0.99996, r_n = \frac{1}{3} r_{n-1}, n = 1, 2, \cdots$ .

(2) $p_{0}=1,p_{1}=0.333\ 32,p_{n}=\frac{4}{3}p_{n-1}-\frac{1}{3}p_{n-2},n=2,3,\cdots.$

(3) $q_{0} = 1, q_{1} = 0.33332, q_{n} = \frac{10}{3} q_{n - 1} - q_{n - 2}, n = 2, 3, \dots.$

| n | $x_{n}-r_{n}$ | $x_{n}-p_{n}$ | $x_{n}-q_{n}$ |
|---|----------------|----------------|----------------|
| 0 | $4.000\ 00\times10^{-5}$ | $0.000\ 00\times10^{-5}$ | $0.000\ 000\ 000\ 0$ |
| 1 | $1.333\ 33\times10^{-5}$ | $1.333\ 33\times10^{-5}$ | $0.000\ 013\ 333\ 3$ |
| 2 | $0.444\ 44\times10^{-5}$ | $1.777\ 78\times10^{-5}$ | $0.000\ 044\ 444\ 4$ |
| 3 | $0.148\ 14\times10^{-5}$ | $1.925\ 92\times10^{-5}$ | $0.000\ 134\ 814\ 8$ |
| 4 | $0.049\ 38\times10^{-5}$ | $1.975\ 31\times10^{-5}$ | $0.000\ 404\ 938\ 3$ |
| 5 | $0.016\ 46\times10^{-5}$ | $1.991\ 77\times10^{-5}$ | $0.001\ 214\ 979\ 4$ |
| 6 | $0.005\ 49\times10^{-5}$ | $1.997\ 26\times10^{-5}$ | $0.003\ 644\ 993\ 1$ |
| 7 | $0.001\ 83\times10^{-5}$ | $1.999\ 09\times10^{-5}$ | $0.010\ 934\ 997\ 7$ |
| 8 | $0.000\ 61\times10^{-5}$ | $1.999\ 70\times10^{-5}$ | $0.032\ 804\ 999\ 2$ |
| 9 | $0.000\ 21\times10^{-5}$ | $1.999\ 90\times10^{-5}$ | $0.098\ 414\ 999\ 8$ |
| 10 | $0.000\ 07\times10^{-5}$ | $1.999\ 97\times10^{-5}$ | $0.295\ 244\ 999\ 9$ |

# 2. 基本概念回顾.

## 2.1 内积空间

定义： $V$ 是数域 $P$ 上的一个线性空间.

内积 $(\cdot,\cdot)$ : $V\times V\rightarrow P$ 满足

(1) $(u + v, w) = (u, w) + (v, w), \forall u, v, w \in V$

(2) $(\alpha u, v) = \alpha(u, v) \quad \forall \alpha \in P, u, v \in V$

(3) $(u,v)=\overline{(v,u)}$ , $\forall u,v\in V$

(4) $(u,u)\geq0,\forall u\in V$ 且

$$
(u, u) = 0 \Leftrightarrow u = \theta
$$

称 $(u,v)$ 为 $u,v$ 的内积

定义了内积的线性空间 $V$ 称为内积空间

例. $(\mathbb{R}^{n}, \mathbb{C}^{n})$ $x, y \in \mathbb{R}^{n}$

$$
x = (x _ {1}, \dots , x _ {n}) ^ {T}, \quad y = (y _ {1}, \dots , y _ {n}) ^ {T}
$$

内积 $(x,y)=\sum_{i=1}^{n}x_{i}y_{i}=x^{T}y=y^{T}x$

给定 $w_{i}>0$ , $i=1,\cdots n$ 带权内积

$$
(x, y) = \sum_ {i = 1} ^ {n} w _ {i} x _ {i} y _ {i}
$$

设 $x, y \in \mathbb{C}^n$ ，带权内积

$$
(x, y) = \sum_ {i = 1} ^ {n} w _ {i} x _ {i} \overline {{y}} _ {i}
$$

例 ($C[a,b]$) $\rho(x)$ 是 [a,b] 上的可积函数，满足

(1) $\rho(x) \geq 0, \forall x \in [a,b]$

(2) 在 $[a,b]$ 的任意子区间上, $\rho(x)$ 不恒为零

称 $\rho$ 为 $[a,b]$ 上的一个权函数

$C[a,b]$上的带权内积为

$$
(f, g) _ {\rho} = \int_ {a} ^ {b} \rho (x) f (x) g (x) d x
$$

若 $(u, v) = 0$ 则称 $u$ 与 $v$ 正交.

**Gram-Schmidt 正交化**

$u_{1}\cdots u_{n}$ 是 $V$ 的一组基，令

$$
\left\{ \begin{array}{l l} v _ {1} = u _ {1} \\ v _ {i} = u _ {i} - \sum_ {k = 1} ^ {i - 1} \frac {(u _ {i} , v _ {k})}{(v _ {k} , v _ {k})} v _ {k}, i = 2, 3, \dots n \end{array} \right.
$$

则有 $v_{1}, \cdots, v_{n}$ 满足 $(v_{i}, v_{j}) = 0, i \neq j$

构成了 $V$ 的一组正交基

定理（Gram 矩阵） V 是一个内积空间，

$$
u _ {1} \dots u _ {n} \in V \quad \mathrm{令}
$$

$$
G = \begin{bmatrix} (u_{1}, u_{1}) & (u_{2}, u_{1}) & \dots & (u_{n}, u_{1}) \\ (u_{1}, u_{2}) & (u_{2}, u_{2}) & \dots & (u_{n}, u_{2}) \\ \vdots & \vdots & \ddots & \vdots \\ (u_{1}, u_{n}) & (u_{2}, u_{n}) & \dots & (u_{n}, u_{n}) \end{bmatrix}
$$

称为 Gram 矩阵，G 可逆的充分必要条件为

$u_{1}\cdots u_{n}$ 线性无关

证明：若 $u_{1} \cdots u_{n}$ 线性相关，则存在

$0 \neq \alpha = (\alpha_{1}, \cdots, \alpha_{n})^{T}$ 使得

$$
\sum_ {i = 1} ^ {n} \alpha_ {i} u _ {i} = 0
$$

那么

$$
G _ {\alpha} = \left[ \begin{array}{l} (\sum_ {i = 1} ^ {n} \alpha_ {i} u _ {i}, u _ {i}) \\ \vdots \\ (\sum_ {i = 1} ^ {n} \alpha_ {i} u _ {i}, u _ {n}) \end{array} \right] = 0
$$

$\Rightarrow  G$ 不可逆

若 $G$ 不可逆, 则存在 $0 \neq  \alpha  = {\left( {\alpha }_{1}\cdots {\alpha }_{n}\right) }^{T}$

使得

$$
G _ {i} \alpha = \left[ \begin{array}{l} (\sum_ {i = 1} ^ {n} \alpha_ {i} u _ {i}, u _ {i}) \\ \vdots \\ (\sum_ {i = 1} ^ {n} \alpha_ {i} u _ {i}, u _ {n}) \end{array} \right] = 0
$$

$$
\Rightarrow \alpha^ {T} G \alpha = (\sum_ {i = 1} ^ {n} \alpha_ {i} u _ {i}, \sum_ {i = 1} ^ {n} \alpha_ {i} u _ {i}) = 0
$$

$$
\Rightarrow \sum_ {i = 1} ^ {n} \alpha_ {i} u _ {i} = 0
$$

$\Rightarrow  {u}_{1}\cdots {u}_{n}$ 线性相关

## 2.2 范数、赋范线性空间

定义： $V$ 是一个数域 $P$ 上的线性空间

$V$ 上的一个映射 $\|\cdot\|: V \to \mathbb{R}$ 满足:

(1) 正定性 $\left\| u\right\|  \geq  0,\forall u \in  V$ ,且 $\left\| u\right\|  = 0 \Leftrightarrow  u =  \theta$

(2) 齐次性 $\|\alpha u\| = |\alpha|\|u\|$ $\forall u \in V, \alpha \in P$

(3)三角不等式 $\|u + v\| \leq \|u\| + \|v\|, \quad \forall u, v \in V$

则称 $\|\cdot\|$ 为 V 的范数，称 V 为赋范线性空间

例： ($\mathbb{R}^{n}$) $\forall x\in \mathbb{R}^{n},\quad x=(x_{1}\cdots x_{n})^{T}$

$\|x\|_{1} = \sum_{i=1}^{n}|x_{i}|$ 1-范数

$$
\|x\|_{2} = \left(\sum_{i = 1}^{n} |x_{i}|^{2}\right)^{1/2}, 2\text{-范数}
$$

$$
\| x \| _ {\infty} = \max _ {1 \le i \le n} | x _ {i} |, \quad \infty \text {范数}
$$

$$
\| x \| _ {p} = \left(\sum_ {i = 1} ^ {n} | x _ {i} | ^ {p}\right) ^ {1 / p}, 1 \leq p < \infty, p\text{-范数}
$$


例 ($C [ a, b ]$) $ f \in C [ a, b ]$


$$
\| f \| _ {2, \rho} = \left(\int_ {a} ^ {b} \rho (x) | f (x) | ^ {2} d x\right) ^ {1 / 2}
$$

$$
\| f \| _ {\infty} = \max _ {x \in [ a, b ]} | f (x) |
$$

定义： $V$ 上的两种范数 $||\cdot||_{\alpha}$ ， $||\cdot||_{\beta}$ 若存在

${C}_{1}\;{C}_{2} > 0$ 使得

$C_{1}||u||_{\alpha}\leq ||u||_{\beta}\leq C_{2}||u||_{\alpha}$

则称 $ \|\cdot \|_{\alpha}$, $\| \cdot \|_{\beta}$ 是 $V$ 上的等价范数

**$\mathbb{R}^n$ 上 范数的等价性**

定理: $A \in \mathbb{R}^{n \times n}$ , $\|\cdot\|$ 是 $\mathbb{R}^n$ 上的范数, 则

$\| A x\|$ 是 $\mathbb{R}^n$ 上的连续函数

证明: 记 $a_{j}$ 为 $A$ 的第 $j$ 列 对于 $\forall h \in \mathbb{R}^{n}$

$$
\left| \begin{array}{l l} \| A (x + h) \| - \| A x \| & \leq \quad \| A h \| \end{array} \right.
$$

$$
= \| \sum_ {j = 1} ^ {n} h _ {j} a _ {j} \| \leq \sum_ {j = 1} ^ {n} | h _ {j} | \| a _ {j} \| \leq M \max _ {1 \leq j \leq n} | h _ {j} |
$$

其中 $M = \mathop{\sum }\limits_{{j = 1}}^{n}\left\| {a}_{j}\right\| .$

由此可得 $\|Ax\|$ 的连续性.

推论： $\|x\|$ 是 $\mathbb{R}^{n}$ 上的连续函数.

定理： $\mathbb{R}^{n}$ 上所有范数相互等价

证明 设 $D = \{ x \in  {\mathbb{R}}^{n},\| x\|_{\infty } = 1\}$

$D$ 是 ${\mathbb{R}}^{n}$ 上的有界闭集.

设 $\|\cdot\|_\alpha$ 是 $\mathbb{R}^n$ 上任一范数，则 $\|\cdot\|_\alpha$ 是 $\mathbb{R}^n$ 上的

连续 函数 则 $\|\cdot\|$ 在 $D$ 上 有 最大值 和最小值

设为 $M,m$ 且 $M \geq  m > 0$

$\forall x \in \mathbb{R}^{n}, x \neq 0, \frac{x}{\|x\|_{\infty}} \in D \text{ 故有 }$

$$
m \leq \left\| \frac {x}{\| x \| _ {\infty}} \right\| _ {\alpha} \leq M
$$

$$
\Rightarrow m \left\| x \right\| _ {\infty} \leq \left\| x \right\| _ {\alpha} \leq M \left\| x \right\| _ {\infty}
$$

## 2.3 矩阵范数

定义: $\mathbb{R}^{n\times n}$ 的范数 $\|\cdot \|:\mathbb{R}^{n\times n}\to \mathbb{R}$ 满足

(1) $\|\mathbf{A}\| \geq 0,\forall A \in \mathbb{R}^{n\times n}\text{且}\|\mathbf{A}\| = 0\Leftrightarrow A = 0$

(2) $\|\alpha A\| = |\alpha| \|A\|$ , $\forall A \in \mathbb{R}^{n \times n}$ , $\alpha \in \mathbb{R}$

(3) $\|\mathbf{A} + \mathbf{B}\| \leq \|\mathbf{A}\| + \|\mathbf{B}\| ,\;\forall \mathbf{A},\mathbf{B} \in  \mathbb{R}^{n\times n}$

(4) $\|\mathbf{A}\mathbf{B}\|\leq\|\mathbf{A}\|\|\mathbf{B}\|,\quad\forall A,B\in\mathbb{R}^{n\times n}$

称 $\|A\|$ 为矩阵 A 的范数

例: ( Frobenius 范数) $A = [a_{ij}] \in \mathbb{R}^{n \times n}$

$$
\| A \| _ {F} = \left(\sum_ {i = 1} ^ {n} \sum_ {j = 1} ^ {n} | a _ {i j} | ^ {2}\right) ^ {1 / 2}
$$

可以看成 $n^2$ 维向量的 2 范数, 故只需验证第 4 条性质

$$
A \cdot B \in \mathbb {R} ^ {n \times n} \quad A = [ a _ {1} \dots a _ {n} ], B = [ b _ {1} \dots b _ {n} ]
$$

$$
\begin{array}{r l} {\| A B \| _ {F} ^ {2}} & {= \sum_ {i, j = 1} ^ {n} | a _ {i} ^ {T} b _ {j} | ^ {2} \leq \sum_ {i = 1} ^ {n} \sum_ {j = 1} ^ {n} \| a _ {i} \| _ {2} ^ {2} \| b _ {j} \| _ {2} ^ {2}} \\ & {= (\sum_{i = 1}^{n} \| a_{i} \|_{2}^{2}) (\sum_{j = 1}^{n} \| b_{j} \|_{2}^{2}) = \| A \|_{F}^{2} \| B \|_{F}^{2}} \end{array}
$$

定义: 对于 $\mathbb{R}^n$ 上给定的一种向量范数 $\|\cdot\|$

和 $\mathbb{R}^{n \times n}$ 上给定的一种矩阵范数 $\|\cdot\|$

如果 $\left\| A{x}\right\|  \leq  \left\| A\right\| \left\| x\right\| \;\forall x \in  {\mathbb{R}}^{n}, A \in \mathbb{R}^{n \times n}$

则称上述矩阵范数与向量范数**相容**。

定理：设 $\|x\|$ 是 $\mathbb{R}^n$ 上任一种向量范数，则

$$
\| A \| = \max _ {x \neq 0} \frac {\| A x \|}{\| x \|} = \max _ {\| x \| = 1} \| A x \|
$$

定义了 $\mathbb{R}^{n\times n}$ 上的一个矩阵范数

证明： $\|A\|\geq0$ 显然.

若 $A = 0$ 则有 $\| A\|  = 0$ 

若 $A \neq  0$ 设 $A$ 的第$i$列

不是零向量，即 $Ae_j \neq 0$ 则有

$$
0 <   \left\| A e _ {j} \right\| \leq \left\| A \right\| \left\| e _ {j} \right\| \Rightarrow \left\| A \right\| > 0
$$

$\forall \alpha \in \mathbb{R}$

$$
\| \alpha A \| = \max _ {\| x \| = 1} \| \alpha A x \| = | \alpha | \max _ {\| x \| = 1} \| A x \| = | \alpha | \| A \|
$$

$$
\forall A, B \in \mathbb {R} ^ {n \times n}
$$

设 
$$
x = \underset {\| z \| = 1} {\arg \max} \| (A + B) z \|
$$

则 $\left\| A + B\right\| = \left\| (A + B)x\right\| \leq \left\| Ax\right\| + \left\| Bx\right\| \leq (\left\| A\right\| + \left\| B\right\|)\left\| x\right\|$ $= \left\| A\right\| + \left\| B\right\|$

设 $y = \arg\max_{\|z\| = 1} \|ABz\|$

$$
\| A B \| = \| A B y \| \leq \| A \| \| B y \| \leq \| A \| \| B \| \| y \| = \| A \| \| B \|
$$

定义：对于 $\mathbb{R}^{n}$ 上任意一种向量范数，由
$\left\| A\right\| = \max_{\left\| x\right\| = 1}\left\| A x\right\|$ 所确定的矩阵范数
称为 从属于给定向量范数的矩阵范数

简称 从属范数或诱导范数

定理 设 $A = [a_{ij}] \in \mathbb{R}^{n \times n}$ 则

$$
\| A \| _ {1} = \max _ {1 \le j \le n} \sum_ {i = 1} ^ {n} | a _ {i j} |
$$

$$
\| A \| _ {\infty} = \max _ {1 \leq i \leq n} \sum_ {j = 1} ^ {n} \left| a _ {i j} \right|
$$

$$
\| A \| _ {2} = [ \rho (A ^ {T} A) ] ^ {1 / 2}
$$

证明：记 $a_j$ 为 $A$ 的第 $j$ 个列向量，则有

$$
\left\| a _ {j} \right\| _ {1} = \sum_ {i = 1} ^ {n} \left| a _ {i j} \right|, j = 1, 2, \dots , n
$$

设 ${a}_{k}$ 为其中 1 范数最大的,即 $\| {a}_{k}\|_{1} = \mathop{\max }\limits_{{1 \leq  j \leq  n}}\left\| {a}_{j}\right\| ,$

对 $\forall x = (x_1, \cdots, x_n)^T \in \mathbb{R}^n, \quad \|x\|_{1} = 1$ 有

$$
\begin{array}{r l} {\| A x \| _ {1}} & = {\| \sum_ {j = 1} ^ {n} a _ {j} x _ {j} \| _ {1}} \leq \sum_ {j = 1} ^ {n} | x _ {j} |   \| a _ {j} \| _ {1}, \\ & \leq \| a _ {k} \| _ {1} \sum_ {j = 1} ^ {n} | x _ {j} | = \| a _ {k} \| _ {1}, \end{array}
$$

特别取 $x = {e}_{k}$

$$
\| A e _ {k} \| _ {1} = \| a _ {k} \| _ {1}
$$

由此可得

$$
\| A \| _ {1} = \max _ {\| x \| _ {1} = 1} \| A x \| _ {1} = \max _ {1 \le j \le n} \| a _ {j} \| _ {1}
$$

$\left\| {A}\right\|_\infty$ 类似可证.

$$
\| A \| _ {2} = \max _ {\| x \| _ {2} = 1} \| A x \| _ {2} = \max _ {\| x \| _ {2} = 1} (x ^ {T} A ^ {T} A x) ^ {1 / 2}
$$

$A^{T}A$ 为半正定对称矩阵，设其特征值为

$$
\lambda_ {1} \geq \lambda_ {2} \geq \dots \geq \lambda_ {n} \geq 0
$$

对应的正交规范特征向量 $u_{1}$ $\cdots$ $u_{n}$

$\forall x \in \mathbb{R}^{n}, \|x\|_{2} = 1 \text{有} x = \sum_{i=1}^{n} \alpha_{i} u_{i}$

$$
\sum_ {i = 1} ^ {n} \alpha_ {i} ^ {2} = 1
$$

$$
\| A x \| _ {2} ^ {2} = x ^ {T} A ^ {T} A x = \sum_ {i = 1} ^ {n} \lambda_ {i} \alpha_ {i} ^ {2} \leq \lambda_ {1}
$$

由此可得 $\left\|A\right\|_{2}^{2}\leq\lambda_{1}$

取 $x = {u}_{1}$

$$
\| A \| _ {2} ^ {2} \geq \| A u _ {1} \| _ {2} ^ {2} = \lambda_ {1} \| u _ {1} \| _ {2} ^ {2} = \lambda_ {1}
$$

所以 $\|A\|_{2}^{2}=\lambda_{1}=\rho(A^{\mathrm{T}}A)$

定理: 设 $\| x\|_{\alpha}$ 为 $\mathbb{R}^n$ 上一种向量范数， $\| A\|_{\alpha}$ 是其从属矩阵范数, $P \in  {\mathbb{R}}^{n \times  n}$ 可逆,则

(1) $\left\| x\right\|_{P,\alpha} = \left\| Px\right\|_{\alpha}$ 定义了另一种向量范数

(2) 从属于 $\| x\|_{P,\alpha}$ 的矩阵范数为

$$
\| A \| _ {P, \alpha} = \| P A P ^ {- 1} \| _ {\alpha}
$$

定理：（1）设 $\|\cdot\|$ 为 $\mathbb{R}^{n\times n}$ 上任意矩阵范数，则

$\forall A \in \mathbb{R}^{n \times n}$ 有

$$
\rho(A) \leq \| A \|
$$

(2) $\forall A \in  {\mathbb{R}}^{n \times  n}$ 及 $\varepsilon  > 0$ 至少存在一种从属矩阵范数使得

$$
\| A \| \leq \rho (A) + \varepsilon
$$

证明：(1) 设 $\lambda$ 是 $A$ 的特征值且 $|\lambda| = \rho(A)$

$\lambda$对应的特征向量为 $x, x \neq 0$

则存在 $y \in \mathbb{R}^n$ 使得 $xy^T$ 不是零矩阵.

$$
\rho (A) \| x y ^ {T} \| = \| \lambda x y ^ {T} \| = \| A x y ^ {T} \| \leq \| A \| \| x y ^ {T} \|
$$

$\Rightarrow  \rho \left( A\right)  \leq  \|A\|$

(2) $\forall A \in  {\mathbb{R}}^{n \times  n}$ 存在 $P \in  {\mathbb{R}}^{n \times  n}$ 使得

$$
J = P ^ {- 1} A P = \text { diag } [ J _ {1}, J _ {2}, \dots , J _ {s} ]
$$

其中 $J_i$ 有块对角的形式 ，即

$$
J = P ^ {- 1} A P = \left[ \begin{array}{l l l l l} \lambda_ {1} & \delta_ {1} & & & \\ & \lambda_ {2} & \ddots & & \\ & & \ddots & \ddots & \\ & & & \lambda_ {n - 1} & \delta_ {n - 1} \\ & & & & \lambda_ {n} \end{array} \right]
$$

$\lambda_{i}\cdots\lambda_{n}$ 是 J 的特征值, $\delta_{i}=0,1$

对于 $\varepsilon > 0$ 令

$$
D _ {\varepsilon} = \text { diag } (1, \varepsilon , \varepsilon^ {2}, \dots ,\varepsilon^ {n - 1})
$$

则有

$$
J _ {\varepsilon} = D _ {\varepsilon} ^ {- 1} J D _ {\varepsilon} = \left[ \begin{array}{l l l l} \lambda_ {1} & \varepsilon \delta_ {1} & & \\ & \lambda_ {2} & \ddots & \\ & & \ddots & \ddots \\ & & & \lambda_ {n - 1} & \varepsilon \delta_ {n - 1} \\ & & & & \lambda_ {n} \end{array} \right]
$$

$$
\| J _ {\varepsilon} \| _ {\infty} = \| D _ {\varepsilon} ^ {- 1} P ^ {- 1} A P D _ {\varepsilon} \| _ {\infty} = \max _ {1 \le i \le n} (| \lambda_ {i} | + \varepsilon \delta_ {i}) \le \rho (A) + \varepsilon
$$

$\|J_{\varepsilon}\|_\infty$ 是从属于 $\|D_{\varepsilon}^{-1}P^{-1}x\|_\infty$ 的矩阵范数.

定理：设 $\|\cdot\|$ 是 $\mathbb{R}^{n \times n}$ 上的一种从属范数，矩阵

$B \in \mathbb{R}^{n \times n}$ 满足 $\|B\| < 1$ 则 $I + B$ 非奇异且

$$
\| (I + B) ^ {- 1} \| \leq \frac {1}{1 - \| B \|}
$$

证明：若 $I+B$ 奇异 则存在 $x≠0$ 使得

$\left( {I + B}\right) x = 0 \Rightarrow   - 1$ 是 $B$ 的特征值

$\Rightarrow  \rho \left( B\right)  \geq  1\;\Rightarrow  \|B\| \geq \rho(B) \geq 1\;$ 矛盾

$$
1 = \left\| I \right\| = \left\| (I + B) (I + B) ^ {- 1} \right\| \geq \left\| (I + B) ^ {- 1} \right\| - \left\| B \right\| \left\| (I + B) ^ {- 1} \right\|
$$

$$
\| (I + B) ^ {- 1} \| \leq \frac {1}{1 - \| B \|}
$$

推论： $A, C \in \mathbb{R}^{n \times n}$ . $A$ 可逆 $\|A^{-1}\| \leq \alpha$ $\|A - c\| \leq \beta, \quad \alpha\beta < 1$ 则 $C$ 可逆且 $\|C^{-1}\| \leq \frac{\alpha}{1 - \alpha\beta}$

证明 $\|\mathbf{I} - \mathbf{A}^{-1}\mathbf{C}\| = \|\mathbf{A}^{-1}(\mathbf{A} - \mathbf{C})\| \leq \|\mathbf{A}^{-1}\|$ $\|\mathbf{A} - \mathbf{C}\| \leq \alpha \beta < 1$

$\Rightarrow A^{-1}C$ 可逆 $\Rightarrow C$ 可逆

且 $\|\mathbf{C}^{-1}\| = \|\mathbf{C}^{-1}\mathbf{A}\mathbf{A}^{-1}\| \leq \|\mathbf{C}^{-1}\mathbf{A}\|\|\mathbf{A}^{-1}\|$ $=\alpha\|\left(\mathbf{I}-(\mathbf{I}-\mathbf{A}^{-1}\mathbf{C})\right)^{-1}\| \leq \frac{\alpha}{1-\|\mathbf{I}-\mathbf{A}^{-1}\mathbf{C}\|}$ $\leq \frac{\alpha}{1-\alpha\beta}$

## 2.4 对角占优矩阵

定义 设 $A = [a_{ij}] \in \mathbb{R}^{n \times n}$ 若

$$
| a _ {i i} | > \sum_ {\substack {j = 1 \\ j \neq i}} ^ {n} | a _ {i j} |, \quad i = 1, 2, \dots , n
$$

则称 $A$ 为 严格对角占优矩阵

若 $\left| {a}_{ii}\right|  \geq  \mathop{\sum }\limits_{{j = 1\atop j \neq  i}}^{n}\left| {a}_{ij}\right| ,\;i = 1,2,\cdots ,n$

且至少有一个取严格大于号，则称 $A$ 弱对角占优

定理 $A = [a_{ij}] \in \mathbb{R}^{n \times n}$ 严格对角占优 则 $a_{i,i} \neq 0, i=1,2,\cdots,n$

且 A 非奇异

证明：由严格对角占优定义可知 ${a}_{ii} \neq  0\;i = 1\cdots n$

若 $A$ 奇异 则 存在 $x = (x_1, \cdots, x_n)^T \neq 0$ 使得

$$
A x = 0
$$

不妨设 $\| x\|_{\infty} = |x_k| = 1$ ， $Ax=0$ 的第 $k$ 个方程

为

$$
a _ {k k} x _ {k} = - \sum_ {\substack {j = 1 \\ j \neq k}} ^ {n} a _ {k j} x _ {j}
$$

$$
\Rightarrow \quad | a _ {k k} | \leq \sum_ {\substack {j = 1 \\ j \neq k}} ^ {n} | a _ {k j} | | x _ {j} | \leq \sum_ {\substack {j = 1 \\ j \neq k}} ^ {n} | a _ {k j} |
$$

矛盾

定义: $A \in \mathbb{R}^{n \times n}, n \geq 2$ 如果存在排列矩阵, 使得

$$
P ^ {T} A P = \left[ \begin{array}{l l} \overline {{A}} _ {1 1} & \overline {{A}} _ {1 2} \\ 0 & \overline {{A}} _ {2 2} \end{array} \right]
$$

其中 $\overline{A}_{11}$ 为 $r×r$ 的方阵， $\overline{A}_{22}$ 为 $(n-r)\times(n-r)$ 的方阵

则称 $A$ 为可约矩阵. 否则 $A$ 为不可约矩阵

定理: $A = [a_{ij}] \in \mathbb{R}^{n \times n}$ 不可约 弱对角占优 则 $a_{ii} \neq 0$ $i \geq 1 \cdots n$

且 $A$ 非奇异

证明：若存在 ${a}_{ii} = 0$ 则第 $i$ 行全为零

与不可约矛盾

若 $A$ 奇异 则存在 $x=(x_{1}\cdots x_{n})^{T}\in\mathbb{R}^{n}, x\neq0$

使得 ${Ax} = 0$

不妨设 $\vert x\vert_{\infty}=1$

情况1: $|x_1| = \cdots = |x_n| = 1$ 则

$$
| a _ {i i} | = | a _ {i i} x _ {i} | = \left| \sum_ {\substack {j = 1 \\ j \neq i}} ^ {n} a _ {i j} x _ {j} \right| \leq \sum_ {\substack {j = 1 \\ j \neq i}} ^ {n} | a _ {i j} |, i = 1, 2, \dots , n
$$

与弱对角占优矛盾

情况2：设 $\left| {{x}_{1}}\right|  \leq  \left| {{x}_{2}}\right|  \leq  \cdots  \leq  \left| {{x}_{m}}\right|  < \left| {{x}_{m + 1}}\right|  = \cdots  = \left| {{x}_{n}}\right|  = 1$

由于 A 不可约，则存在 $a_{kl} \neq 0, \quad m + 1 \leq k \leq n$

$$
1 \le l \le m
$$

则由 $Ax=0$ 的第k个方程得

$$
\begin{array}{r l} {| a _ {k k} |} & {= | a _ {k k} x _ {k} | = \left| \sum_ {\substack {j = 1 \\ j \neq k}} ^ {n} a _ {k j} x _ {j} \right|} \\ & {\leq \sum_ {\substack {j = 1 \\ j \neq k}} ^ {n} | a _ {k j} | | x _ {j} | <   \sum_ {\substack {j = 1 \\ j \neq k}} ^ {n} | a _ {k j} |} \end{array}
$$

$$
\vert a _ {k l} \vert \vert x _ {l} \vert <   \vert a _ {k l} \vert
$$

矛盾.

[下一篇：线性方程组的直接解法 →](/posts/numerical-analysis-1/02-direct-methods-linear-systems/)
