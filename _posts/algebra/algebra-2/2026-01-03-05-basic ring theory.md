---
layout: post
title: "Algebra II Basic Properties of Rings"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/ring-basics/
tags: algebra
use_math: true
---

# 环的基本知识

::: definition
环$R$的子环是$R$的子集，其满足在$R$上定义的$+,\cdot$运算（环的性质）。
:::

::: definition
:::

::: definition
（双边）理想是$R$的子集$I$使得$(I,+)$为群， 并且对任意$x\in R,y\in I$，$xy\in I \ \& \ yx\in I$。
:::

注意理想不一定为子环。

::: definition
(1) zero divisor if ($x\ne 0$) and $\exists y\ne 0$, s.t. $xy=0$

(2) nilpotent if $\exists n>0$, s.t. $x^n = 0$

(3) idempotent if $x^2=x$.
:::

::: proposition
交换环只有两个理想$\Leftrightarrow$ $R$ 为域。
:::

::: definition
令${\{x_i\}}_{i \in J}\subset R$。 由${\{x_i\}}_{i \in J}$生成的理想= $$\bigg\{\sum_{j=1}^n a_jx_{i_j}b_j : a_j,b_j\in R \bigg\}$$
:::

::: definition
如理想$I$可以由一个元素生成，那么这个理想为主理想。
:::

::: definition
主理想整环 (PID) 是指每个理想都是主理想的整环。
:::

::: definition
带有单位元$1\ne0$的环$R$并且每个元素都是unit（可逆）的环是除环 （dividen ring）。 域就是交换除环。 （通俗来说可以做除法的环）
:::

::: definition
整环是交换环其中任意2个非零元素的积非零。 （$a\ne 0, b\ne 0\Longrightarrow ab\ne 0$, $ab=0\Longrightarrow a=0|b=0$）
:::

::: definition
即不为$R$的理想。
:::

::: definition
素理想$I$,$a\in R,b\in R, a b \in I 
    \Longrightarrow (a \in I | b \in I)$ 即 $a\notin I \& b \notin I \Longrightarrow a b \notin I$

等价定义:$A,B$ideal of $R$,$$AB\subset P\Longrightarrow A\subset P | B\subset P$$
:::

::: remark
素理想的在同态映射下的逆像是素理想。
:::

::: proposition
带有单位元的交换环中$P$是素理想，当且仅当$R\backslash P$是整环。
:::

::: proposition
让 $f: R \rightarrow S$ 是核为 $K$ 的环的满同态。

(a) 如果 $P$ 是包含 $K$ 的 $R$ 中的素理想，那么 $f(P)$ 是 $S$ 中的素理想

(b) 如果 $Q$ 是 $S$ 中的素理想，那么 $f^{-1}(Q)$ 是 $R$ 中包含 $K$ 的素理想。

(c) $R$ 中包含 $K$ 的所有素理想的集合与 $S$ 中所有素理想的集合之间存在一一对应关系，即 $P \mapsto f(P)$。

(d) 如果 $I$ 是环 $R$ 中的一个理想，那么 $R / I$ 中的每个素理想都是 $P / I$ 的形式，其中 $P$ 是包含 $I$ 的 $R$ 中的一个素理想。
:::

::: definition
极大理想是不包含于任意其他真理想的理想。
:::

::: proposition
(i) 如果$M$是maximal并且$R$是交换的，那么商环$R\backslash M$是域。

(ii) 如果商环$R\backslash M$是除环，那么$M$是maximal。
:::

::: lemma
假设$S$为偏序集，使得$S$的每个全序子集都有上界。那么$S$包含至少一个极大元素。
:::

注意到Zorn引理和选择公理等价。

::: proposition
$R$的每个真理想都包含在某个极大真理想中。 特别的，任何环$R$都有一个极大真理想。 并且$R$的每个非unit元素都包含在一个极大理想中。
:::

::: proof
*Proof.* (使用Zorn引理)

设这个真理想为$I$。

为了使用Zorn引理，我们以集合的包含关系为偏序关系，那么包含$I$的真理想的集合是一个偏序集。

我们只要证明这个偏序集的每个全序子集都有上界。

设这个全序子集为$\mathcal{C}=\{C_i:i\in I\}$。

取$C=\bigcup_{i\in I}C_i$，这显然满足上界的条件。 我们只要证明它是真理想即可。

它是理想是容易验证的。

$C\ne R$可以通过证明$1\notin C$得到。 ◻
:::

::: theorem
If $R$ and $S$ are rings and $φ:R → S$ is a ring homomorphism then $R/\ker(φ) ∼= Im(φ)$.
:::

::: theorem
Let $I$ be an ideal of a ring $R$. There is a bijection $ψ$ from the set of subrings of $R$ containing $I$ and the set of subrings of $R/I$. The bijection preserves inclusion$(S_1 ⊆ S_2\Leftrightarrow S_1ψ ⊆ S_2ψ)$, and ideals of $R$ containing $I$ correspond to ideals of $R/I$.
:::

::: theorem
If $I$ and $J$ are ideals of a ring $R$ with $I \le J$ then $(R/I)/(J/I) \cong R/J$.
:::

::: theorem
If R is a ring, I is an ideal of R and S is a subring of $R$, define $I +S = \{x+y : x ∈ I, y ∈ S\}$. Then

(a) $I +S$ is a subring of $R$ containing $I$;

(b) $I ∩S$ is an ideal of $S$;

(c) $(I +S)/I \cong S/I ∩S$
:::
