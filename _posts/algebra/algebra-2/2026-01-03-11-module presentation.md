---
layout: post
title: "Algebra II Module Presentations and Canonical Forms"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/module-presentation/
tags: algebra
use_math: true
---

# Module Presentations and Canonical Forms

$R$ ring $R^m,R^n$ finite free modules /$R$.

$f:R^n\to R^m$ be $R$-linear map $\iff$ $A=(a_{ij})\in M_{m,n}(R)$

i.e. $$f\left(\begin{matrix}1\\0\\ \vdots\\0\end{matrix}\right)=\left(\begin{matrix}a_{11}\\a_{21}\\ \vdots\\a_{m1}\end{matrix}\right)$$

here secretly use standard basis $$\left(\begin{matrix}1\\0\\ \vdots\\0\end{matrix}\right),\ldots,\left(\begin{matrix}0\\0\\ \vdots\\1\end{matrix}\right)$$

**Definition**
Given $f:R^m\to R^n$ $R$-linear, $M:=R^m/\mathrm{Im} f$ be $R$-module. In this case, $f$ is called a presentation of $M$, and if $M$ admits such a presentation. We say $M$ is of finite presentation.
:::

## Rational canonical form

$R=K[X]$ where $K$ field. By structure theorem of f.g. module

1.  Every f.g. $K[X]$- module is isomorphic to $$K[x]/(f_1(x))\oplus\cdots\oplus K[x]/(f_l(x))\oplus K[x]^k$$

With the basis $1,x,\ldots,x^{n-1}$, this $K$-linear map is given by 

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
where $f(x) = x^n + a_{n-1}x^{n-1} + \cdots + a_1 x + a_0$.

## Jordan canonical form

$K$ field $A\in M_n(K)\leftrightarrow V\to^T V \text{ K linear map } \dim_K V=n$

$\leftrightarrow V$ as $K[x]$-module (by $(a_m x^m+\cdots a_1 x+a_0)\cdot v=a_m T^m(v)+\cdots+a_1 T(v)+a_0 \cdot v$)

1\. for rational canonical form with basis $\bar{1},\bar{x},\cdots,\bar{x}^{n-1}$

$T$ is companion matrix.

2\. for $f(x)=(x-\alpha)^n$, we can choose basis $\bar{1},\overline{(x-\alpha)},\ldots,\overline{(x-\alpha)}^{n-1}$

$x\cdot \bar{1}=\alpha \cdot \bar{1}+1\cdot \overline{(x-\alpha)}$

This gives jordan matrix.

In general if $K=\mathbb{C}$ (or algebraically closed field) $f(x)=\prod (x-\alpha_i)^{n_i}$ use CRT $V\cong K[x]/(f(x))\cong \bigoplus K[x]/(x-\alpha_i)^{n_i}$

with basis $(0,\ldots,0,\overline{(x-\alpha_i)}^j,0,\ldots,0)$

$T$ is represented as combination of Jordan blocks.



[← Other Modules](/posts/algebra2/more-modules/) | [Field and Galois Theory →](/posts/algebra2/field-galois-theory/)

