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

$R$环，$R^m,R^n$为有限自由$R$-模。

$f:R^n\to R^m$为$R$-线性映射 $\iff$ $A=(a_{ij})\in M_{m,n}(R)$

即 $$f\left(\begin{matrix}1\\0\\ \vdots\\0\end{matrix}\right)=\left(\begin{matrix}a_{11}\\a_{21}\\ \vdots\\a_{m1}\end{matrix}\right)$$

这里暗中使用了标准基 $$\left(\begin{matrix}1\\0\\ \vdots\\0\end{matrix}\right),\ldots,\left(\begin{matrix}0\\0\\ \vdots\\1\end{matrix}\right)$$

**Definition**
给定$f:R^m\to R^n$为$R$-线性映射，$M:=R^m/\mathrm{Im} f$为$R$-模。在这种情况下，$f$被称为$M$的一个表示，如果$M$允许这样的表示。我们说$M$是有限表示的。


## 有理标准型

$R=K[X]$其中$K$为域。根据有限生成模的结构定理

1.  每个有限生成的$K[X]$-模同构于 $$K[x]/(f_1(x))\oplus\cdots\oplus K[x]/(f_l(x))\oplus K[x]^k$$

在基$1,x,\ldots,x^{n-1}$下，这个$K$-线性映射由下式给出

$$
\left[
    \begin{matrix}
        0 & 0 & \cdots & 0 & -a_0 \\
        1 & 0 & \cdots & 0 & -a_1 \\
        0 & 1 & \cdots & 0 & -a_2 \\
        \vdots & \vdots & \ddots & \vdots & \vdots \\
        0 & 0 & \cdots & 1 & -a_{n-1}
    \end{matrix}
\right]
$$
其中$f(x) = x^n + a_{n-1}x^{n-1} + \cdots + a_1 x + a_0$。

## Jordan标准型

$K$为域，$A\in M_n(K)\leftrightarrow V\to^T V$为$K$-线性映射，$\dim_K V=n$

$\leftrightarrow V$作为$K[x]$-模（通过$(a_m x^m+\cdots a_1 x+a_0)\cdot v=a_m T^m(v)+\cdots+a_1 T(v)+a_0 \cdot v$）

1\. 对于有理标准型，基为$\bar{1},\bar{x},\cdots,\bar{x}^{n-1}$

$T$是友矩阵。

2\. 对于$f(x)=(x-\alpha)^n$，我们可以选择基$\bar{1},\overline{(x-\alpha)},\ldots,\overline{(x-\alpha)}^{n-1}$

$x\cdot \bar{1}=\alpha \cdot \bar{1}+1\cdot \overline{(x-\alpha)}$

这给出了Jordan矩阵。

一般地，如果$K=\mathbb{C}$（或代数闭域）$f(x)=\prod (x-\alpha_i)^{n_i}$，使用中国剩余定理，$V\cong K[x]/(f(x))\cong \bigoplus K[x]/(x-\alpha_i)^{n_i}$

以$(0,\ldots,0,\overline{(x-\alpha_i)}^j,0,\ldots,0)$为基

$T$表示为Jordan块的组合。



[← Other Modules](/posts/algebra2/more-modules/) | [Field and Galois Theory →](/posts/algebra2/field-galois-theory/)

