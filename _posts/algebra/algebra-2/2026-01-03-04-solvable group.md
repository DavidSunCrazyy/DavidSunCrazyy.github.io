---
layout: post
title: "Algebra II Solvable Groups"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/solvable-groups/
tags: algebra
use_math: true
---

本文档介绍可解群理论，包括合成列、Jordan-Hölder定理、自由群和可解群的基本性质等内容。

# 可解群

## 合成列

**Definition**（正规列）
$G$的正规列定义为一列有限正规子群形如：$$G=H_0\unrhd H_1 \unrhd H_2 \unrhd \cdots \unrhd H_m = \{1\}$$

**Definition**（加细）
给定两个正规列 $$G=H_0\unrhd H_1 \unrhd H_2 \unrhd \cdots \unrhd H_m = \{1\}$$ $$G=K_0\unrhd K_1 \unrhd K_2 \unrhd \cdots \unrhd K_n = \{1\}$$ 称$\{H_i\}$是$\{K_i\}$的加细，如果$\{K_0, K_1, \ldots, K_n\} \subseteq \{H_0, H_1, \ldots, H_m\}$（作为集合）。

**Definition**（合成列）
如果正规列$G=H_0\unrhd H_1 \unrhd H_2 \unrhd \cdots \unrhd H_m = \{1\}$满足对所有$i = 0, 1, \ldots, m-1$，因子群$H_i/H_{i+1}$都是非平凡的单群，则称$(H_i)$为$G$的合成列。其中单群是指没有非平凡正规子群的群。

**Definition**（等价列）
两个合成列$(H_i)$和$(K_j)$称为等价的，如果它们有相同的长度且对应的因子群同构（不考虑顺序）。

**Proposition**（因子群的性质）
设$G$是群，$N \triangleleft G$，$H \leq G$，则：
1. 若$N \leq H$，则$H/N \leq G/N$
2. $(G/N)/(H/N) \cong G/H$（当$N \leq H \leq G$时）

**Theorem**（Schreier refinement定理）
给定群$G$的任意两个正规列，总存在这两个列的公共加细，使得这两个加细等价。

*Proof.* （略，这是一个较为复杂的技术性证明，涉及重排引理的应用）


**Theorem**（Jordan-Hölder定理）
如果群$G$具有合成列，那么$G$的所有合成列都彼此等价（即它们有相同的长度，且对应的因子群同构，不计顺序）。

*Proof.* 设$G$有两个合成列：
$$G = H_0 \unrhd H_1 \unrhd \cdots \unrhd H_m = \{1\}$$
$$G = K_0 \unrhd K_1 \unrhd \cdots \unrhd K_n = \{1\}$$

根据Schreier refinement定理，这两个列有等价的加细。设加细分别为：
$$G = H'_0 \unrhd H'_1 \unrhd \cdots \unrhd H'_r = \{1\}$$
$$G = K'_0 \unrhd K'_1 \unrhd \cdots \unrhd K'_r = \{1\}$$

由于原列都是合成列，它们的因子群都是单群。在加细过程中，如果$H_i/H_{i+1}$是单群，那么在加细后的序列中，对应的部分只能是$H_i = \cdots = H_{i+1}$（无细化）或者$H_i \unrhd H_{i+1}$（已经是最简）。由于$H_i/H_{i+1}$是单群，不能有真正规子群，所以加细只能是平凡的。

因此，两个合成列的加细实际上是将每个合成列重复多次。由于两个加细是等价的，这意味着原来的两个合成列必须有相同的长度（$m=n$），并且对应的因子群同构（不计顺序）。

**Corollary**：
合成列的长度称为群$G$的合成长度，因子群（考虑同构类）称为合成因子。Jordan-Hölder定理表明，如果群$G$有合成列，那么合成长度和合成因子（不计顺序）是$G$的不变量。


## 自由群

**Definition**（字和自由群）
设$S$是一个集合（称为字母表）。由$S$生成的**字**是形如$s_1^{\epsilon_1}s_2^{\epsilon_2}\cdots s_n^{\epsilon_n}$的表达式，其中$s_i \in S$，$\epsilon_i = \pm 1$。

定义**等价关系**：两个字等价，如果可以通过以下操作互相转化：
1. 插入或删除形如$ss^{-1}$或$s^{-1}s$的相邻项
2. 有限次应用上述操作

由$S$生成的**自由群**$F(S)$是所有等价类构成的集合，运算为字的连接后化简。

**Definition**（通用性质）
自由群$F(S)$具有以下**通用性质**：对于任意群$G$和任意映射$f: S \to G$，存在唯一的群同态$\varphi: F(S) \to G$使得$\varphi|_S = f$。

**Proposition**：
- 如果$S$是有限集，$\|S\| = n$，则称$F(S)$为$n$阶自由群，记作$F_n$
- $F_1 \cong \mathbb{Z}$（无限循环群）
- 如果$\|S\| \geq 2$，则$F(S)$是非交换群

**Theorem**（Nielsen-Schreier定理）
自由群的子群仍是自由群。

**Note**：虽然我们在这里提到了自由群，但它们与可解群理论的关系相对间接。接下来我们重点讨论可解群。


## 可解群

**Definition**（换位子群）
设$G$是群，$x,y \in G$。元素$[x,y] = xyx^{-1}y^{-1}$称为$x$和$y$的**换位子**（或交换子）。

$G$的**换位子群**（或导群）$G'$定义为所有换位子生成的子群：$$G' = \langle [x,y] \mid x,y \in G \rangle$$

**Proposition**：
1. $G' \triangleleft G$（换位子群是正规子群）
2. $G/G'$是阿贝尔群
3. 如果$N \triangleleft G$且$G/N$是阿贝尔群，则$G' \subseteq N$

*Proof.*
1. 对任意$g \in G$，$h \in G'$，由于$ghg^{-1}h^{-1} \in G'$（它是$g,h$的换位子），所以$ghg^{-1} \in G'$，因此$G' \triangleleft G$。
2. 对任意$x,y \in G$，$(xG')(yG') = xyG' = (xy)[x,y]G' = yxG' = (yG')(xG')$，所以$G/G'$是阿贝尔群。
3. 如果$G/N$是阿贝尔群，则对任意$x,y \in G$，$(xN)(yN) = (yN)(xN)$，即$xyN = yxN$，所以$x^{-1}y^{-1}xy \in N$，即$[x,y] \in N$，因此$G' \subseteq N$。

**Definition**（导出列）
设$G$是群，定义$G$的**导出列**（或换位子列）为：
$$G = G^{(0)} \unrhd G^{(1)} \unrhd G^{(2)} \unrhd \cdots$$
其中$G^{(0)} = G$，$G^{(i+1)} = (G^{(i)})'$（即$G^{(i+1)}$是$G^{(i)}$的换位子群）。

**Definition**（可解群）
群$G$称为**可解的**，如果存在$n \geq 0$使得$G^{(n)} = \{1\}$，其中$G^{(n)}$是导出列的第$n$项。

**Example**：
1. 所有阿贝尔群都是可解的（因为$G' = \{1\}$）
2. $S_3$是可解群：$S_3' = A_3 \cong \mathbb{Z}_3$，$(S_3)' = A_3' = \{1\}$（因为$A_3 \cong \mathbb{Z}_3$是阿贝尔群）
3. $S_4$是可解群：$S_4' = A_4$，$A_4' \cong V_4$（克莱因四元群），$V_4' = \{1\}$
4. 任何$p$-群（$p$是素数）都是可解群

**Proposition**：
如果$G$是可解群，$H \leq G$，则$H$也是可解群。

*Proof.* 如果$G^{(n)} = \{1\}$，则容易看出$H^{(n)} \subseteq G^{(n)} = \{1\}$，所以$H^{(n)} = \{1\}$，因此$H$可解。

**Proposition**：
如果$G$是可解群，$N \triangleleft G$，则商群$G/N$也是可解群。

*Proof.* 我们有$(G/N)' \cong G'N/N$，进而$(G/N)^{(i)} \cong G^{(i)}N/N$。如果$G^{(n)} = \{1\}$，则$(G/N)^{(n)} \cong G^{(n)}N/N = N/N = \{1\}$，所以$G/N$可解。

**Theorem**（可解群的等价条件）
设$G$是有穷群，则以下条件等价：
1. $G$是可解群
2. $G$有一个正规列，其因子群都是素数阶的循环群
3. $G$的所有Sylow子群都是可解群
4. $G$有一个正规列$G = G_0 \unrhd G_1 \unrhd \cdots \unrhd G_n = \{1\}$，使得每个因子群$G_i/G_{i+1}$都是阿贝尔群

*Proof.* （简述思路）
$(1) \Rightarrow (2)$：如果$G$可解，则存在$n$使得$G^{(n)} = \{1\}$。我们可以构造一个正规列，使其因子群为素数阶循环群。
$(2) \Rightarrow (4)$：素数阶循环群是阿贝尔群。
$(4) \Rightarrow (1)$：如果存在正规列，其因子群都是阿贝尔群，则通过归纳法可以证明$G$可解。

**Theorem**（Burnside定理）
设$\|G\| = p^a q^b$，其中$p,q$是素数，$a,b \geq 0$，则$G$是可解群。

**Theorem**（Feit-Thompson定理）
每一个奇数阶群都是可解群。

**Theorem**（Galois理论中的应用）
多项式$f(x)$在域$F$上根式可解当且仅当其伽罗瓦群$\operatorname{Gal}(f/F)$是可解群。

**Example**（不可解群的例子）
$A_5$和$S_5$是不可解群，因为$(A_5)' = A_5$（$A_5$是完全球群），所以$A_5$的导出列永不终止于平凡群。

更一般地，对$n \geq 5$，$A_n$和$S_n$都是不可解群。

**Proposition**（短正合序列与可解性）
设$1 \to N \to G \to G/N \to 1$是群的短正合序列。如果$N$和$G/N$都是可解群，则$G$也是可解群。

*Proof.* 设$N^{(r)} = \{1\}$，$(G/N)^{(s)} = \{1\}$。由$(G/N)^{(i)} \cong G^{(i)}N/N$可知，当$G^{(s)}N/N = \{1\}$时，$G^{(s)} \subseteq N$。因此$G^{(r+s)} \subseteq N^{(r)} = \{1\}$，所以$G^{(r+s)} = \{1\}$，即$G$可解。

[← Sylow Theorem](/posts/algebra2/sylow-theorem/) | [Basic Properties of Rings →](/posts/algebra2/ring-basics/)
