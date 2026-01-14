---
layout: post
title: "Algebra II Unique Factorization"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/unique-factorization/
tags: algebra
use_math: true
---

# 欧氏整环, PID, UFD

::: definition
环$R$中的非零元素$a$整除$b$，记作$a\mid b$，如果存在$c\in R$使得$b=ac$。
:::

::: definition
$a,b\in R$，如果$a\mid b$且$b\mid a$，则称$a,b$是associate。
:::

::: definition
$u\in R$，如果$u\mid 1$，则称$u$是unit。
:::

::: proposition
(i) $a\mid b\Leftrightarrow (b)\subset (a)$

(ii) $(a)=(b)\Leftrightarrow a,b$是associate

(iii) $u$是unit $\Leftrightarrow (u)=R$

(iv) $u$是unit $\Leftrightarrow u\mid r,\forall r\in R$
:::

::: definition
$a\in R$，如果$a$非0非unit，且$a=bc$，则$b$或$c$是unit，则称$a$是不可约元。
:::

::: definition
$p\in R$，如果$p$非0非unit，且$p\mid bc$，则$p\mid b$或$p\mid c$，则称$p$是素元。
:::

::: definition
设$R$是一个整环，称其为 UFD (unique factorization domain) 如果

(i) $a\in R$，$a$非0非unit，$a=c_1\cdots c_n$，$c_1 c_2 \cdots c_n$，其中$c_1,\cdots,c_n$是不可约元。

(ii) 若$a=c_1\cdots c_n$且$a=d_1\cdots d_m$，其中$c_1,\cdots,c_n,d_1,\cdots,d_m$是不可约元，则$n=m$且存在$\sigma\in S_n$使得$c_i$和$d_{\sigma(i)}$是associate。
:::

::: lemma
若$R$是PID，且$(a_1)\subset (a_2) \subset \cdots$为理想链，则存在$n$使得$(a_j)=(a_n)$，对任意$j>n$。
:::

::: theorem
PID是UFD。
:::

::: definition
欧氏整环是整环$R$，有一个映射$\delta:R\backslash 0\rightarrow \mathbb{Z}_{\ge 0}$ 使得

1.  $a,b\in R, b\ne 0$， 则$\exists q,r\in R, a=bq+r$，有$r=0$或$\delta(r)<\delta(a)$。(欧几里得算法，辗转相除法)

2.  如果$a,b\ne 0$那么$\delta(a)\le \delta(ab)$
:::

::: proposition
欧氏整环是PID。
:::

## 多项式环

::: definition
设$R$是一个整环，$a,b\in R$，如果$d\in R$满足

(i) $d\mid a,d\mid b$

(ii) $d'\mid a,d'\mid b\Rightarrow d'\mid d$

则称$d$是$a,b$的最大公因子。
:::

::: definition
$f\in R[x]$是primitive polynomial，如果$f$的系数的最大公因子是1。
:::

::: lemma
$f,g\in R[x]$是primitive polynomial，则$fg$是primitive polynomial。
:::

::: lemma
$D$为UFD，分式域$F$，令$f,g$为$D[x]$的primitive polynomial，则$f,g$在$D[x]$中 associate $\Leftrightarrow f,g$在$F[x]$中associate。
:::

::: lemma
$D$为UFD，$F$为分式域，$f$为$D[x]$的primitive polynomial，则$f$在$D[x]$中不可约 $\Leftrightarrow f$在$F[x]$中不可约。
:::

::: theorem
$D$为UFD，则$D[x]$为UFD。
:::
