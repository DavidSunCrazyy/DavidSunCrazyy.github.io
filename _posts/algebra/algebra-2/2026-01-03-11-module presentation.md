---
layout: post
title: "Algebra II Module Presentations and Canonical Forms"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/module-presentation/
tags: algebra
use_math: true
---

本文档介绍模的表示和标准型理论，包括有理标准型、Jordan标准型以及它们在有限生成模结构中的应用等内容。

# 模的表示和标准型

## 模的表示

设$R$是环，$R^m,R^n$为有限自由$R$-模。

$f:R^n\to R^m$为$R$-线性映射 $\iff$ $A=(a_{ij})\in M_{m,n}(R)$

即 $$f\left(\begin{matrix}1\\0\\ \vdots\\0\end{matrix}\right)=\left(\begin{matrix}a_{11}\a_{21}\\ \vdots\a_{m1}\end{matrix}\right)$$

这里暗中使用了标准基 $$\left(\begin{matrix}1\\0\\ \vdots\\0\end{matrix}\right),\ldots,\left(\begin{matrix}0\\0\\ \vdots\\1\end{matrix}\right)$$

**Definition**（模的表示）
给定$R$-线性映射$f:R^n\to R^m$，$M:=R^m/\mathrm{Im} f$为$R$-模。在这种情况下，$f$被称为$M$的一个**表示**，如果$M$允许这样的表示。我们说$M$是**有限表示**的。

**Definition**（有限表示模）
$R$-模$M$称为有限表示的，如果存在有限自由$R$-模$F_1, F_2$和$R$-线性映射$f: F_1 \to F_2$，使得$M \cong F_2/\mathrm{Im} f$。

**Proposition**（有限表示模的性质）
1. 如果$M$是有限生成的$R$-模，且$R$是诺特环，则$M$是有限表示的。
2. 有限表示模的子模和商模不一定是有限表示的，但在诺特环上是的。

**Definition**（Smith标准型）
设$R$是主理想整环（PID），$A \in M_{m,n}(R)$。则存在可逆矩阵$P \in M_m(R)$和$Q \in M_n(R)$，使得$PAQ$是对角矩阵$\mathrm{diag}(d_1, d_2, \ldots, d_r, 0, \ldots, 0)$，其中$d_1 | d_2 | \cdots | d_r$。这种形式称为$A$的Smith标准型。


## 有理标准型

设$R=K[X]$其中$K$为域。根据有限生成模的结构定理：

**Theorem**（有理标准型的存在性）
每个有限生成的$K[X]$-模同构于 $$K[x]/(f_1(x))\oplus\cdots\oplus K[x]/(f_l(x))\oplus K[x]^k$$
其中$f_1(x), \ldots, f_l(x)$是首一多项式，且$f_1(x) | f_2(x) | \cdots | f_l(x)$。

**Definition**（相伴矩阵）
设$f(x) = x^n + a_{n-1}x^{n-1} + \cdots + a_1 x + a_0 \in K[x]$，$f(x)$的**相伴矩阵**（companion matrix）定义为：
$$C(f) = \left[
    \begin{matrix}
        0 & 0 & \cdots & 0 & -a_0 \\
        1 & 0 & \cdots & 0 & -a_1 \\
        0 & 1 & \cdots & 0 & -a_2 \\
        \vdots & \vdots & \ddots & \vdots & \vdots \\
        0 & 0 & \cdots & 1 & -a_{n-1}
    \end{matrix}
\right]$$

**Proposition**（相伴矩阵的性质）
1. $f(x)$是$C(f)$的最小多项式
2. $f(x)$是$C(f)$的特征多项式
3. 在$K[x]/(f(x))$的基$\{\bar{1}, \bar{x}, \ldots, \bar{x}^{n-1}\}$下，乘法映射$T_f: \bar{g} \mapsto \overline{xg}$由相伴矩阵$C(f)$表示

**Theorem**（有理标准型）
设$T: V \to V$是有限维$K$-向量空间$V$上的线性变换。则存在$V$的基，使得$T$在此基下的矩阵为有理标准型：
$$\left[
\begin{matrix}
C(f_1) & 0 & \cdots & 0 \\
0 & C(f_2) & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & C(f_l)
\end{matrix}
\right]$$
其中$f_1(x) | f_2(x) | \cdots | f_l(x)$是$T$的不变因子。

**注记**：有理标准型是域上唯一的，不依赖于域的扩张。

## 线性变换与模结构的关联

**Theorem**（线性变换与模结构的对应）
设$K$是域，$V$是有限维$K$-向量空间，$T: V \to V$是线性变换。则$V$可以赋予$K[x]$-模结构：
$$p(x) \cdot v = p(T)(v) = a_0v + a_1T(v) + \cdots + a_nT^n(v)$$
其中$p(x) = a_0 + a_1x + \cdots + a_nx^n \in K[x]$，$v \in V$。

**Proposition**（模同态与交换变换）
设$V, W$是$K[x]$-模（通过线性变换$T_V, T_W$），$\varphi: V \to W$是$K[x]$-模同态。则$\varphi$是$K$-线性映射且$\varphi \circ T_V = T_W \circ \varphi$（即$\varphi$与变换交换）。

**Definition**（循环模）
$K[x]$-模$M$称为**循环模**，如果存在$v \in M$使得$M = K[x] \cdot v$。等价地，$M \cong K[x]/I$对某个理想$I$。

**Proposition**（循环子模的基）
设$V$是$K[x]$-模（通过线性变换$T$），$v \in V$。如果$K[x] \cdot v$是循环子模且其零化子理想是$(f(x))$，其中$f(x)$是首一多项式且$\deg(f) = n$，则$\{v, T(v), T^2(v), \ldots, T^{n-1}(v)\}$是$K[x] \cdot v$的$K$-基。

## Jordan标准型

**Definition**（可对角化与可三角化）
设$T: V \to V$是有限维$K$-向量空间$V$上的线性变换。
- $T$称为**可对角化**，如果存在$V$的基使得$T$在此基下的矩阵是对角矩阵。
- $T$称为**可三角化**，如果存在$V$的基使得$T$在此基下的矩阵是上三角矩阵。

**Definition**（Jordan块）
设$\alpha \in K$，$n \times n$的**Jordan块**（Jordan block）定义为：
$$J_n(\alpha) = \left[
\begin{matrix}
\alpha & 1 & 0 & \cdots & 0 \\
0 & \alpha & 1 & \cdots & 0 \\
0 & 0 & \alpha & \cdots & 0 \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
0 & 0 & 0 & \cdots & \alpha
\end{matrix}
\right]$$

**Theorem**（Jordan标准型的存在性）
设$K$是代数闭域，$T: V \to V$是有限维$K$-向量空间$V$上的线性变换。则存在$V$的基，使得$T$在此基下的矩阵为Jordan标准型：
$$\left[
\begin{matrix}
J_{n_1}(\alpha_1) & 0 & \cdots & 0 \\
0 & J_{n_2}(\alpha_2) & \cdots & 0 \\
\vdots & \vdots & \ddots & \vdots \\
0 & 0 & \cdots & J_{n_k}(\alpha_k)
\end{matrix}
\right]$$

**Theorem**（Jordan标准型的构造）
设$K$是域，$T: V \to V$是有限维$K$-向量空间$V$上的线性变换，其特征多项式在$K$中完全分解为线性因子。则$V$作为$K[x]$-模（通过$x \cdot v = T(v)$）可以分解为：
$$V \cong \bigoplus_{i=1}^k \bigoplus_{j=1}^{m_i} K[x]/(x-\alpha_i)^{d_{ij}}$$
其中$\alpha_i$是$T$的特征值。

对于每个分量$K[x]/(x-\alpha)^n$，在基$\{\overline{1}, \overline{x-\alpha}, \overline{(x-\alpha)^2}, \ldots, \overline{(x-\alpha)^{n-1}}\}$下，乘法映射$x \cdot$由Jordan块$J_n(\alpha)$表示。

**Proposition**（Jordan标准型的唯一性）
Jordan标准型在相似变换下是唯一的（不考虑Jordan块的排列顺序）。

**注记**：Jordan标准型只在代数闭域上存在，而有理标准型在任意域上都存在。

## 标准型的应用例子

**Example**（有理标准型的例子）
考虑矩阵$A = \begin{pmatrix} 0 & -6 \\ 1 & 5 \end{pmatrix}$。其特征多项式为$\chi_A(x) = x^2 - 5x + 6 = (x-2)(x-3)$，最小多项式为$m_A(x) = (x-2)(x-3)$。由于最小多项式无重根，$A$可对角化，其有理标准型为$\begin{pmatrix} 2 & 0 \\ 0 & 3 \end{pmatrix}$。

**Example**（Jordan标准型的例子）
考虑矩阵$B = \begin{pmatrix} 2 & 1 \\ 0 & 2 \end{pmatrix}$。其特征多项式为$\chi_B(x) = (x-2)^2$，最小多项式为$m_B(x) = (x-2)^2$。由于最小多项式有重根，$B$不可对角化，但其Jordan标准型为$B$本身，即$J_2(2) = \begin{pmatrix} 2 & 1 \\ 0 & 2 \end{pmatrix}$。

**Example**（不变因子的计算）
设$T: V \to V$是线性变换，$\dim V = 4$。如果$V$作为$K[x]$-模的结构为$V \cong K[x]/(x-1) \oplus K[x]/((x-1)^2) \oplus K[x]/((x-1)^2)$，则$T$的不变因子为$\{1, (x-1), (x-1)^2, (x-1)^2\}$，初等因子为$\{(x-1), (x-1)^2, (x-1)^2\}$。

**Application**（矩阵函数的计算）
利用Jordan标准型，可以定义矩阵函数。如果$A = PJP^{-1}$，其中$J$是Jordan标准型，则$f(A) = Pf(J)P^{-1}$。例如，$\exp(A) = P\exp(J)P^{-1}$，其中$\exp(J)$是对每个Jordan块分别计算指数函数。

[← Other Modules](/posts/algebra2/more-modules/) | [Field and Galois Theory →](/posts/algebra2/field-galois-theory/)

