---
note: true
layout: post
title: "Numerical Analysis I 最小二乘问题的解法——QR分解与正交变换"
permalink: /posts/numerical-analysis-1/04-least-squares/
categories: numerical-analysis
tags: [numerical-analysis, least-squares, qr-decomposition, householder, givens-rotation]
use_math: true
---

本文介绍最小二乘问题的基本理论与求解方法，包括法方程组、Moore-Penrose 广义逆、Householder 变换与 Givens 变换，以及 QR 分解的计算方法与在最小二乘问题中的应用。

# 第三章 最小二乘问题的解法

## 3.1 最小二乘问题

定义: 设 $A \in \mathbb{R}^{m \times n}$ , $b \in \mathbb{R}^m$ , 确定 $x \in \mathbb{R}^n$ 使得

$$
\| b - A x \| _ {2} = \min _ {y \in \mathbb {R} ^ {n}} \| A y - b \| _ {2}
$$

称为最小二乘问题，其中 $r(x)=A x-b$ 称为残向量

最小二乘问题的解 $x$ 又被称为线性方程组

$$
A x = b \quad , \quad A \in \mathbb {R} ^ {m \times n}
$$

的最小二乘解

$m > n$ ，超定方程组

$m<n$ ，欠定方程组.

根据 $m, n$ 以及 $\operatorname{rank}(A)$，最小二乘问题可分为

几种情形：

(1): $m = n$ :

(a). $\operatorname{rank}(A) = m = n$

(b) $\operatorname{rank}(A)=k<m=n$

(2): $m > n$

(a) $\operatorname{rank}(A)=n<m$

(b) $\operatorname{rank}(A)=k<n<m$

(3) $m < n$

(a) $\operatorname{rank}(A)=m<n$

(b) $\operatorname{rank}(A) < m < n$

定义：设 $A \in \mathbb{R}^{m \times n}$ ， $A$ 的值域定义为

$$
R (A) = \{y \in \mathbb {R} ^ {m}, y = A x, x \in \mathbb {R} ^ {n} \}
$$

A 的零空间定义为

$$
N (A) = \{x \in \mathbb {R} ^ {n}, A x = 0 \}
$$

一个子空间 $S \subset \mathbb{R}^n$ 的正交补定义为

$$
S ^ {\perp} = \{y \in \mathbb {R} ^ {n}, y ^ {\top} x = 0, \forall x \in S \}
$$

定理：方程组（3.1.1）的解存在的充要条件为

$$
\operatorname{rank} (A) = \operatorname{rank} ([ A, b ])
$$

定理：若 $x$ 是 $A{x} = b$ 的解，则方程组的全部

解的集合是

$$
x + N(A)
$$

定理: $Ax = b$ 的最小二乘解, 总是存在, 其解唯一的充分必要条件为 $N(A) = 0$

证明: $\forall b \in \mathbb{R}^{m}$ , $b$ 可以唯一表示为

$b = {b}_{1} + {b}_{2},\;$ 其中 ${b}_{1} \in  R\left( A\right) ,{b}_{2} \in  R\left( A\right) ^{\perp}$

$\forall x \in \mathbb{R}^{n},\quad b_{1}-Ax \in R(A) \text{与 } b_{2} \text{正交则}$

$$
\begin{array}{r l} {\| r (x) \| _ {2} ^ {2}} & = {\| b - A x \| _ {2} ^ {2} = \| (b _ {1} - A x) + b _ {2} \| _ {2} ^ {2}} \\ & = {\| b _ {1} - A x \| _ {2} ^ {2} + \| b _ {2} \| _ {2} ^ {2}} \end{array}
$$

由此可得 $\|r(x)\|_{2}^{2}$ 达到极小当且仅当 $\|b_{1}-Ax\|_{2}^{2}$

达到极小

由于 $b_{1} \in R(A)$ 即存在 $x \in \mathbb{R}^{n}$ 使得 $A x = b_{1}$

此时 $\| {b}_{1} - {Ax} \|_{2}^{2} = 0$ 达到极小

定理: $x$ 是 $A x = b$ 的最小二乘解 当且仅当

$$
A ^ {T} A x = A ^ {T} b
$$

证明：设 $x$ 是最小二乘解．则有

${Ax} = {b}_{1} \in  R\left( A\right)$ 并且

$$
r (x) = b - A x = b - b _ {1} = b _ {2} \in R (A) ^ {\perp}
$$

$$
\Rightarrow A ^ {T} (b - A x) = A ^ {T} r (x) = A ^ {T} b _ {2} = 0
$$

反之，设 $x \in \mathbb{R}^n$ 满足 $A^T A x = A^T b$ 则 $\forall y \in \mathbb{R}^n$

$$
\begin{array}{r l} {\| b - A (x + y) \| _ {2} ^ {2}} & {= \| b - A x \| _ {2} ^ {2} - 2 y ^ {T} A ^ {T} (b - A x) + \| A y \| _ {2} ^ {2}} \\ & {= \| b - A x \| _ {2} ^ {2} + \| A y \| _ {2} ^ {2}} \\ & {\geqslant \| b - A x \| _ {2} ^ {2}} \end{array}
$$

$A^{T}A x=A^{T}b$ 称为最小二乘问题的正则化方程组或 法方程组

若 $A$ 列满秩,则 ${A}^{T}A$ 对称正定,此时可以利用 Cholesky 分解求解 法方程组 得到 最小二乘问题的解.

若 $A$ 列满秩, 则最小二乘问题的解为

$$
x = (A ^ {T} A) ^ {- 1} A ^ {T} b
$$

令 ${A}^{ \dagger  } = {\left( {A}^{T}A\right) }^{-1}{A}^{T}$ 则有

$$
x = A ^ {\dagger} b
$$

其中 $A^{\dagger}$ 是 $A$ 的 Moore - Penrose 广义逆.

定义：若 $x \in \mathbb{R}^{n \times m}$ 满足

$$
A X A = A, \quad X A X = X, \quad (A X) ^ {T} = A X, \quad (X A) ^ {T} = X A
$$

则称 $X$ 是 $A$ 的 Moore-Penrose 广义逆

考虑 $b$ 有扰动 $\delta b$ 且 $x$ 和 $x+\delta x$ 分别是最小二乘问题

$$
\min | | b - A x | | _ {2} \quad \mathrm{和} \quad \min | | b + \delta b - A x | | _ {2}
$$

的解.

定理：设 $b_{1}, \tilde{b}_{1}$ 分别为 $b$ 和 $\tilde{b}$ 在 $R(A)$ 上的正交投影 若 $b_{1} \neq 0$ 则

$$
\frac {\| \delta x \| _ {2}}{\| x \| _ {2}} \le \mathcal{K}_ {2} (A) \frac {\| b _ {1} - \tilde {b} _ {1} \| _ {2}}{\| b _ {1} \| _ {2}}
$$

其中 $\mathcal{K}_{2}(A)=\|A\|_{2}\|A^{\dagger}\|_{2}$

证明：设 $b$ 在 $R(A)^{\perp}$ 上的正交投影为 $b_{2}$ ，则 $A^{T}b_{2}=0$ 那么

$$
A ^ {\dagger} b = A ^ {\dagger} b _ {1} + A ^ {\dagger} b _ {2} = A ^ {\dagger} b _ {1}
$$

同理 $A^{\dagger}\tilde{b}=A^{\dagger}\tilde{b}_{1}$

因此

$$
\begin{array}{r l} {\| \delta x \| _ {2}} & = {\| A ^ {\dagger} b - A ^ {\dagger} \tilde {b} \| _ {2}} = {\| A ^ {\dagger} (b _ {1} - \tilde {b} _ {1}) \| _ {2}} \\ & \leq {\| A ^ {\dagger} \| _ {2} \cdot \| b _ {1} - \tilde {b} _ {1} \| _ {2}} \end{array}
$$

$$
\frac {\| \delta x \| _ {2}}{\| x \| _ {2}} \leq \mathcal{K}_ {2} (A) \frac {\| b _ {1} - \tilde {b} _ {1} \| _ {2}}{\| A \| _ {2} \| x \| _ {2}} \leq \mathcal{K}_ {2} (A) \frac {\| b _ {1} - \tilde {b} _ {1} \| _ {2}}{\| b _ {1} \| _ {2}}
$$

定理: 若 $A$ 列满秩, 则 $\mathcal{K}_{2}(A)^{2} = \text{cond}_{2}(A^{T}A)$

证明：首先有

$$
\| A \| _ {2} ^ {2} = \rho (A ^ {T} A) = \| A ^ {T} A \| _ {2}
$$

$$
\| A ^ {\dagger} \| _ {2} ^ {2} = \| A ^ {\dagger} (A ^ {\dagger}) ^ {T} \| _ {2} = \| (A ^ {T} A) ^ {- 1} \| _ {2}
$$

于是

$$
\mathcal{K}_ {2} (A) ^ {2} = | | A | | _ {2} ^ {2} | | A ^ {\dagger} | | _ {2} ^ {2} = \text { cond } _ {2} (A ^ {T} A)
$$

## 3.2 初等正交变换

#### Householder 变换

定义: 设 $w \in \mathbb{R}^n$ 满足 $||w||_2 = 1$ , 定义 $P \in \mathbb{R}^{n \times n}$ 为

$$
P = I - 2 \omega \omega^ {T}
$$

称 P 为 Householder 变换

Householder 变换具有以下性质：

(1) (对称性) ${P}^{T} = P$

(2) (正交性) ${p}^{T}p = I$

$$
\|w\|_{2}^{2} = w^{T} w = 1
$$

$$
p ^ {T} p = I - 4 \omega \omega^ {T} + 4 \omega \omega^ {T} \omega \omega^ {T} = I
$$

(3) (反射性) $\forall x \in R^{n}$ , $Px$ 与 $x$ 关于超平面 $span\{w\}^{\perp}$ 镜像对称

设 $x = u + \alpha w$ $u \in \operatorname{span}\{w\}^{\perp}, \quad \alpha \in \mathbb{R}$

$$
\begin{array}{r l} {p _ {x}} & {= (I - 2 w w ^ {T}) (u + \alpha w)} \\ & {= u + \alpha w - 2 w w ^ {T} u - 2 \alpha w w ^ {T} w} \end{array}
$$

$$
w ^ {T} w = 1, \quad w ^ {T} u = 0 \quad \Rightarrow \quad Px = u - \alpha w
$$

定理: $\forall x \in \mathbb{R}^{n}, x \neq 0$ , 则存在 $w \in \mathbb{R}^{n}$ , $\|w\|_{2} = 1$ , 使

得 $Px = \alpha e_{1}$

其中 P 是由 w 给出的 Householder 变换， $\alpha = \pm \|x\|_{2}$

证明：取 $\alpha = \pm \|x\|_{2}$ 令

$$
\omega = \frac {x - \alpha e _ {1}}{\| x - \alpha e _ {1} \| _ {2}}
$$

则有 $px = \alpha e_1$

为了使 $x-\alpha e_{1}$ 不损失有效数字，取

$$
\alpha = - \operatorname{sgn} (x _ {1}) \| x \| _ {2}
$$

为了避免溢出，可将 $x$ 归一化为 $\frac{x}{\|x\|_{\infty}}$

#### Givens 变换

定义: $\theta \in \mathbb{R},\quad S = \sin \theta ,\quad C = \cos \theta$

$$
J (i, k, \theta) = \begin{array}{c} {\left[ \begin{array}{c c c c c c c c c} {1} & {} & {} & {} & {} & {} & {} & {} & {} \\ {} & {\ddots} & {} & {} & {} & {} & {} & {} & {} \\ {} & {} & {1} & {} & {} & {} & {} & {} & {} \\ {} & {} & {} & {c} & {0} & {\dots} & {0} & {s} & {} \\ {} & {} & {} & {0} & {1} & {} & {} & {0} & {} \\ {} & {} & {} & {\vdots} & {\ddots} & {} & {} & {\vdots} & {} \\ {} & {} & {} & {0} & {} & {\ddots} & {1} & {0} & {} \\ {} & {} & {} & {- s} & {0} & {\dots} & {0} & {c} & {} \\ {} & {} & {} & {} & {} & {} & {} & {1} & {} \\ {} & {} & {} & {} & {} & {} & {} & {} & {\ddots} \\ {} & {} & {} & {} & {} & {} & {} & {1} & {} \\ \end{array} \right]} \end{array} 
$$

称为 $n\times n$ 的 Givens 矩阵或 Givens 变换

若 $x \in \mathbb{R}^n$ , $x = (x_1, x_2, \cdots, x_n)^T$ 则 $y = J(i, k, \theta)x$ 为

$$
y _ {j} = x _ {j}, \quad j \neq i, k
$$

$$
y _ {i} = c x _ {i} + s x _ {k},
$$

$$
y _ {k} = - s x _ {i} + c x _ {k}
$$

要使 ${y}_{k} = 0$ ,只需 $\theta$ 满足

$$
c = \cos \theta = \frac {x _ {i}}{\sqrt {x _ {i} ^ {2} + x _ {k} ^ {2}}} \quad , \quad s = \sin \theta = \frac {x _ {k}}{\sqrt {x _ {i} ^ {2} + x _ {k} ^ {2}}}
$$

若 ${x}_{k} = 0$ ,取 $c = 1,s = 0$

若 ${x}_{k} \neq  0,$

$|x_{k}| \geq |x_{i}|$ 时, $t = \frac{x_{i}}{x_{k}}$ , $s = \text{sgn}(x_{k})(1 + t^{2})^{-\frac{1}{2}}$ , $c = st$

$|x_{k}|<|x_{i}|$ 时, $t=\frac{x_{k}}{x_{i}}$ , $c=\operatorname{sgn}(x_{i})(1+t^{2})^{-\frac{1}{2}}$ , $s=ct$

## 3.3 矩阵的QR分解

定理：设 $A \in  {\mathbb{R}}^{m \times  n}$ , $m \geq  n$ ,则存在正交矩阵 $Q \in  {R}^{m \times  m}$ 和上三角矩阵 $R \in  {R}^{n \times  n}$ 使得

$$
A = Q \left[ \begin{array}{l} R \\ 0 \end{array} \right]
$$

如果 $m=n$ , A 非奇异且规定 $R$ 的对角元素为正值, 则这种分解是唯一的.

证明：由 Householder 变换，Givens 变换或者 Gram-Schmidt

正交化 容易 构造 Q, R 使得 $A = Q \left[ \begin{matrix} R \\ 0 \end{matrix} \right]$

下面证唯一性. 设 $A$ 非奇异, 且有

$$
A = Q _ {1} R _ {1} = Q _ {2} R _ {2}
$$

其中 ${Q}_{1},{Q}_{2}$ 为正交阵, ${R}_{1},{R}_{2}$ 为上三角矩阵且对角线元

素为正，则有

$$
A ^ {T} A = R _ {1} ^ {T} R _ {1} = R _ {2} ^ {T} R _ {2}
$$

由Cholesky分解的唯一性 有 $R_{1} = R_{2}$

进一步可得 ${Q}_{1} = {Q}_{2}$ .

### QR分解的计算方法

#### Householder 变换

记 $A^{(0)} = [a_1^{(0)} \cdots a_n^{(0)}] = A$ ，计算 Householder 矩阵

$P_{i} \in \mathbb{R}^{m \times m}$ 使得

$$
p _ {1} a _ {1} ^ {(0)} = \alpha_ {1} e _ {1}
$$

令

$$
A ^ {(1)} = P _ {1} A ^ {(0)} = \left[ \begin{array}{c c c c c} * & * & - & - & * \\ 0 & * & & & 1 \\ \vdots & * & & & 1 \\ \vdots & \vdots & & \ddots & 1 \\ 0 & * & - & - & * \end{array} \right]
$$

计算 Householder 矩阵 $P_{2} \in \mathbb{R}^{(m-1) \times (m-1)}$ 使得

$$
\overline {P} _ {2} a _ {2} ^ {(1)} = \alpha_ {2} (1, 0, \dots , 0) \in \mathbb {R} ^ {m - 1}
$$

令

$$
P _ {2} = \left[ \begin{array}{l l} 1 & 0 \\ 0 & \overline {P} _ {2} \end{array} \right]
$$

$$
A ^ {(2)} = P _ {2} A ^ {(1)} = \left[ \begin{array}{l l l l l} * & * & * & - & - & * \\ 0 & * & * & & 1 \\ \vdots & 0 & * & \ddots & 1 \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ 0 & 0 & * & - & - & * \end{array} \right]
$$

依次类推可得

$$
P _ {n - 1} P _ {n - 2} \dots P _ {1} A = R
$$

令 $P = {P}_{n - 1}\cdots {P}_{1},Q = {P}^{T}$ 即得 $A = {QR}$

#### Givens 变换

计算 $\theta_{12}$ 使得 $J(1,2,\theta_{12})a_{1}$ 的第二个元素为 0

计算 $\theta_{13}$ 使得 $J(1,3,\theta_{13})J(1,2,\theta_{12})a_{1}$ 的第三个元素为0

(第二个元素不变,仍然为0)

依此类推可得 $\theta_{12}$ $\theta_{13}$ $\cdots$ $\theta_{1m}$ 使得

$J(1,m,\theta_{1m})\cdots J(1,2,\theta_{12})a_{1}$ 除第一个元素均为0

令 $A^{(2)} = J(1,m,\theta_{1m}) \cdots J(1,2,\theta_{12})A^{(1)}, A^{(1)} = A$

计算 $\theta_{23}$ $\cdots$ $\theta_{2m}$ 使得

$J(2,m,\theta_{2m})\cdots J(2,3,\theta_{23})a_{2}^{(2)}$ 除前两个元素

均为 0

以此类推 可得 QR 分解.

采用 QR 分解可以方便的求解 最小二乘问题

设 $A \in  {\mathbb{R}}^{m \times  n},m \geq  n,\operatorname{rank}\left( A\right)  = n$

$A$ 有 QR 分解

$$
A = Q \left[ \begin{array}{l} R \\ 0 \end{array} \right]
$$

则 $\min \|Ax - b\|_2$

$\Leftrightarrow \min \| Q^{\top} A x - Q^{\top} b \|_{2}$

$\Leftrightarrow \quad \min \left\| \left[ \begin{array}{c} R \\ 0 \end{array} \right] x - \left[ \begin{array}{c} C_1 \\ C_2 \end{array} \right] \right\|_{2}, \quad \left[ \begin{array}{c} C_1 \\ C_2 \end{array} \right] = Q^T b$

$\Leftrightarrow \min \| Rx - C_{1} \|_{2}$

$\Leftrightarrow Rx = C_{1}$

R 为上三角矩阵， ${Rx} = {C}_{1}$ 很容易求解.

[← 上一篇：矩阵的条件数及误差分析](/posts/numerical-analysis-1/03-condition-number-error-analysis/)

[下一篇：线性方程组的迭代解法 →](/posts/numerical-analysis-1/05-iterative-methods-linear-systems/)
