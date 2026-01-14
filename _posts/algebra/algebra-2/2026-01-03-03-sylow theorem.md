---
layout: post
title: "Algebra II Sylow Theorem"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/sylow-theorem/
tags: algebra
use_math: true
---

# 群作用和 Sylow 定理

## 群作用

::: definition
群$G$作用在集合$S$上，如果有映射$G\times S\rightarrow S$，$(g,s)\mapsto g\cdot s$满足

(1) $e\cdot s=s$

(2) $(gh)\cdot s=g\cdot (h\cdot s)$
:::

::: definition
$\mathrm{Stab}\_G(a) = \{g\in G:g a = a\} = G_a$.
:::

::: definition
$G$作用在$S$上，$G$的轨道为$O_G(a) = \{g a: g\in G\}$
:::

::: definition
$G$作用在$S$上，$a\in S$为不动点，如果$g a = a$。 $$Z = \{a: \forall g\in G, ga = a\}$$
:::

::: proposition
$$|G| = |\mathrm{Stab}_G(a)||O_G(a)|$$
:::

::: proposition
令$S$为有限集，令群$G$作用在$S$上。$A$表示非平凡轨道（不止一个元素）的代表元素集合。则 $$|S|=|Z|+\sum_{a\in A}|G:G_a|=\sum O_G(a)$$
:::

## 共轭作用 (conjugation action)

::: definition
群$G$的共轭作用定义为$G$在自身上的作用，$\rho(g, a) = gag^{-1}$。
:::

::: definition
$Z(G)=\{a\in G:ag=ga,\forall g\in G\}$
:::

::: definition
对$a\in G$，中心化子（正规化子）$Z_G(a)$是在共轭作用下的稳定化子。 $$Z_G(a) = \{g ∈ G : gag^{−1} = a\} = \{g ∈ G : ga = ag\}$$ 包含在$G$中与$a$交换的元素。明显$a\in Z(G)\Longleftrightarrow Z_G(a)=G$。
:::

::: definition
阶为$p$的幂的有限群称为p群。
:::

::: corollary
令$G$为作用在有限集$S$上的p群，令$Z$为该作用的不动点的集合。则 $|Z|\equiv|S| \mod p$。
:::

::: lemma
令$G$为有限群, 假设 $G/Z(G)$是循环群。 那么G是交换群。(and hence G/Z(G) is in fact trivial)
:::

::: definition
$a\in G$的共轭类是共轭作用下a的轨道$[a]$。如果$G$中的两个元素$a, b$属于同一个共轭类，那么它们就是共轭的。 $$C(a)=\text{orbit of a}=\{g a g^{-1}\in G:g\in G\}$$
:::

::: proposition
$G$是有限群 $$|G|=|Z(G)|+\sum_{a\in A}[G:Z(a)]$$ 其中 $A ⊆ G$为包含 $G$ 中每个非平凡共轭类的一个代表的集合。
:::

::: corollary
令$G$为非平凡p-群，则$G$有非平凡中心。
:::

对子集$A\subset G$以及$g\in G$，$A$的共轭$g A g^{-1}$。由消去律$a\mapsto g a g^{-1}$是双射。

::: definition
$N_G(A)=\{g\in G:g A = A g\}$。
:::

::: definition
$A$的中心化子为$Z_G(A)=\{g\in G:g a =a g,\forall a\in A\}\subset N_G(A)$。
:::

对单元集$A=\{a\}$，$N_G(\{a\})=Z_G(\{a\})=Z_G(a)$。一般来说，$Z_G(A)\nsubseteq N_G(A)$。

若$H<G$，则其共轭$g H g^{-1}$亦为$G$的子群。共轭有相同的度。

::: lemma
令$H<G$。则与其共轭子群数量（若有限）等于$[G:N_G(H)]$。
:::

## Sylow定理

::: theorem
令$G$为有限群，令$p$为$|G|$的素因子，那么$G$包含$p$阶元素。
:::

::: proof
*Proof.* $S=\{(a_1,\cdots,a_p)\in G^p:a_1\cdots a_p=1\}$，$|S|=|G|^{p-1}$。$|S|\equiv 0 \mod p$。

$\mathbb{Z}\_p$作用在$S$上，$k \cdot (a_1,\cdots,a_p) =(a_{1+k},\cdots,a_p,a_1,\cdots,a_k)$。可验证这是群作用。

$|S|\equiv |Z|\equiv 0\mod p$。$(e,\cdots,e)\in Z$，故$(a,\cdots, a)\in S,\forall a\ne e,a\in S\Longrightarrow a^p = 1$ ◻
:::

::: definition
群$G$的Sylow p-子群定义为阶为$p^r$的子群，其中$|G|=p^r m$，而且$(p,m)=1$
:::

::: lemma
令$H$包含在有限群$G$中的p-子群。则 $$[N_G(H):H]\equiv [G:H] \mod p.$$
:::

::: proof
*Proof.* ◻
:::

::: theorem
对所有素数$p$，每个有限群包含一个Sylow p-子群。
:::

::: proposition
若$p^k\mid |G|$，则$G$有$p^k$阶子群。
:::

::: theorem
令$G$为有限群，令$P$为Sylow p-子群，令$H\subset G$为p-群，则包含在$P$的一个共轭中，即存在$g\in G$使得$H\subset g H g^{-1}$。
:::

::: proposition
令$H$为有限群$G$中的p-子群。假设$H$不为Sylow p-子群。则存在$G$的Sylow p-子群$H'$包含$H$使得$[H':H]=p$且$H\triangleleft H'$。
:::

::: theorem
令$p$为素数，令$G$为有限群且$|G|=p^rm$，假设$p\nmid m$。则$G$的Sylow p-子群的个数整除$m$且同余$1$模$p$。
:::
