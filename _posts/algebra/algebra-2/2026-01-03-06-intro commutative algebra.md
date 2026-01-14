---
layout: post
title: "Algebra II Introduction to Commutative Algebra"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/intro-commutative-algebra/
tags: algebra
use_math: true
---

# Introduction to Commutative Algebra

**Theorem**
Let $K$ be an algebraically closed field. Then the maximal ideals of $K[x_1, . . . , x_n]$ are of the form $(x_1 − a_1, . . . , x_n − a_n)$ for some $(a_1, . . . , a_n) ∈ K^n$.
:::

**Proposition**
$\operatorname{Spec}(\mathbb{C}[x,y])$ $$\operatorname{Spec}(\mathbb{C}[x,y])=\{(0)\}\cup \{(x-a,y-b)\}\cup \{(f):f\in \mathbb{C}[x,y], f \text{ irreducible}\}$$
:::

## 积环

**Definition**
设$R,S$是环，$R\times S$是$R$和$S$的直积，定义

(1) $(r,s)+(r',s')=(r+r',s+s')$

(2) $(r,s)\cdot (r',s')=(r\cdot r',s\cdot s')$
:::

**Definition**
设$I$是$R$的理想，$J$是$S$的理想，$IJ$是$R$的理想，定义为$\{\sum x_v y_v:x_v\in I,y_v\in J\}$。
:::

## 局部化

**Definition**
令$R$为整环。$Frac R:=\{(a,s)\in R^2:s\ne 0\}/\sim$　其中$(a,s)\sim (b,t) \iff at=bs$
:::

**Definition**
设$R$是一个环，$S\subset R$满足

(1) $1\in S$

(2) $x,y\in S\Rightarrow xy\in S$

(3) $x,y\in S\Rightarrow x-y\in S$

则$S$称为$R$的**乘法封闭子集**。
:::

**Definition**
设$R$是一个环，$R$的**素谱**是$R$的素理想的集合，记作$\operatorname{Spec}(R)$。
:::

**Definition**
$R$的**局部化**（通过$S$） (localization of $R$ by $S$): $$S^{-1}R:=\{(r,s)\in R\times S\}/\sim$$ 其中$(r,s)\sim (r',s')$当且仅当$\exists t\in S$使得$t(rs'-r's)=0$。
:::

::: remark
1.  $\sim$ 是等价关系

2.  $S^{-1}R$是一个环

3.  $\varphi:R\rightarrow S^{-1}R,s\mapsto s/1$ 同态
:::

**Proposition**
$R$无zero divisor $\mathrm{Im}plies S^{-1}R$是整环。
:::

**Proposition**
$S=R/\{0\}$,$S^{-1}R=Frac R$
:::

**Lemma**
$R$是一个环，$\mathfrak{p}$为素理想，$S=R- \mathfrak{p}$，则$S$是乘法封闭子集。
:::

**Definition**
$S=R- \mathfrak{p}$ $$R_{\mathfrak{p}} = S^{-1}R$$ 称为$R$在$\mathfrak{p}$处的局部化。
:::

**Definition**
设$R$是一个环，$S$是$R$的乘法封闭子集，$S$不包含$0$。 $I$为$R$的理想，则$S^{-1}I:=\{a/s\in S^{-1}R:a\in I\}=\varphi(I)\cdot S^{-1}R$。
:::

**Theorem**
$I,J$为$R$的理想，则

(a) $S^{-1}(I+J)=S^{-1}I+S^{-1}J$

(b) $S^{-1}(IJ)=S^{-1}I\cdot S^{-1}J$

(c) $S^{-1}(I\cap J)=S^{-1}I\cap S^{-1}J$
:::

**Proposition**
$S^{-1}I=S^{-1}R \iff S\cap I\ne \emptyset$.
:::

**Proposition**
$$S^{-1}R/S^{-1}I\cong \overline{S}^{-1}(R/I)$$ where $\overline{S}$:image of $S$ under $R\rightarrow R/I$
:::

**Proposition**
若$\mathfrak{p}\in \operatorname{Spec} R$且$S\cap \mathfrak{p}=\emptyset$，则$S^{-1}\mathfrak{p}$在$S^{-1}R$为素理想，并且$\varphi^{-1}(S^{-1}\mathfrak{p})=\mathfrak{p}$
:::

**Definition**
设$R$是一个环，$P$是$R$的素理想，$R_P$是$R$的局部化，称为$R$的$P$处的局部环。
:::

**Example**
$R=\mathbb{Z},S=\mathbb{Z}\backslash \{0\}$，则$S^{-1}R=\mathbb{Q}$。 $R=\mathbb{Z}$,$S=\{2^n:n\ge0\}$,则$S^{-1}R=\mathbb{Z}[1/2]$。
:::

**Proposition**
设$S$是$R$的乘法封闭子集，$S^{-1}R$的素理想一一对应于$R$的素理想$P$满足$P\cap S=\emptyset$。 $$\operatorname{Spec} S^{-1}R \rightarrow \{\mathfrak{p}\in \operatorname{Spec} R:\mathfrak{p}\cap S=\emptyset\}$$
:::

**Definition**
$\sqrt{0}=\{x\in R: x \text{nilpotent},\exists n>0,x^n=0\}$
:::

**Theorem**
$\sqrt{0}=\bigcap_{\mathfrak{p}\in\operatorname{Spec} R}\mathfrak{p}$
:::



[← Basic Properties of Rings](/posts/algebra2/ring-basics/) | [Unique Factorization →](/posts/algebra2/unique-factorization/)
