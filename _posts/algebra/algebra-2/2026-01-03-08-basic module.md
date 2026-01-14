---
layout: post
title: "Algebra II Basic Properties of Modules"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/module-basics/
tags: algebra
use_math: true
---

# 模的基本知识

## 代数数

**Definition**
一个数$\alpha$是代数数，若$\exists \textrm{ monic } f(x)\in \mathbb{Q}[x]$使得$f(\alpha)=0$。
:::

**Definition**
一个数$\alpha$是代数整数，若$\exists \textrm{ monic } f(x)\in \mathbb{Z}[x]$使得$f(\alpha)=0$。
:::

**Definition**
$\alpha$的极小多项式是$F(\alpha)=0$的最小次数的首一多项式。
:::

**Proposition**
$\alpha$ 为代数整数 $\iff$ $F(X)\in \mathbb{Z}[x]$
:::

**Definition**
设$d\in \mathbb{Z}$，$d$ square free, $K=Q[\sqrt{d}]$
:::

## 模

**Definition**
设$R$是有$1$的环，$M$是一个交换群。若给定一个映射$R\times M\to M$，满足

1.  $(r_1+r_2)m=r_1m+r_2m$

2.  $(r_1r_2)m=r_1(r_2m)$

3.  $1m=m$

4.  $r(m_1+m_2)=rm_1+rm_2$

则称$M$是一个$R$-模。
:::

**Example**
$R$是一个环，$R$是一个$R$-模。
:::

**Definition**
设$M$是一个$R$-模，$N$是$M$的一个子集，若$N$对于$M$的加法和$R$的乘法封闭，则称$N$是$M$的一个子模。
:::

**Example**
$R$的子模为$R$的理想。
:::

**Definition**
设$M,N$是$R$-模，$\varphi:M\to N$是一个映射，若 $$\varphi(a+b)=\varphi(a)+\varphi(b),\varphi(ra)=r\varphi(a)$$
:::

**Definition**
所有包含模$M$的子集$X$的子模的交称为由$X$生成的子模。
:::

**Theorem**
令$W$为$R$-模$V$的子模。

(a) (First Isomorphism Theorem)

(b) (Correspondence Theorem)
:::

## 直和，直积

**Definition**
$$\prod_{i\in I} A_i$$, $$r(a_i) = (r a_i)$$
:::

**Definition**
$A_i,i\in I$为$R$-模， $$\sum_{i\in I} A_i = (a_i)_{i\in I}$$ 只有有限个 $a_i$ 不为$0$
:::



[← Unique Factorization](/posts/algebra2/unique-factorization/) | [Structure of Finitely Generated Modules →](/posts/algebra2/finitely-generated-modules/)

