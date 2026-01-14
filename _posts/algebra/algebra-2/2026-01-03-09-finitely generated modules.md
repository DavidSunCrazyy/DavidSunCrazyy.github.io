---
layout: post
title: "Algebra II Structure of Finitely Generated Modules"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/finitely-generated-modules/
tags: algebra
use_math: true
---

# 有限生成模的结构

## 自由模

**Definition**
设$R$为环，$M$为$R$-模，设$S$为$M$的任意非空子集，下列所有的有限和 $$\sum_{x\in S} a_x x,a_x\in R$$ 其中只有有限多个$a_x$不为$0$ 为由$x$
:::

**Definition**
:::

**Theorem**
Assume $R$ is a PID

1. Every submodule of a free $R$-module is free.

2. 
    - If $V$ is a free $R$-module of rank $n<\infty$, $W\subset V$ submodule, then $W$ is free of $\operatorname{rank} W = m\le n$

    - $\exists v_1,\ldots,v_n$ be basis of $V$, $\exists b_1,\ldots,b_m\in R,\ne 0$m s.t. $b_1 v_1,\ldots,b_m v_m$ be basis of $W$. And $$b_1\mid b_2\mid \cdots \mid b_m$$
:::

**Corollary**
$V$ is finitely generated,say $V=\langle v_1,\ldots,v_m\rangle\to R^m\twoheadrightarrow^\pi V$
:::

## Finite generated modules over PID

## 有限生成模

**Definition**
若$M$可以由有限个元素生成，则称$M$是有限生成的。
:::

**Theorem**
$R$ is a PID, $V$ is a finitely generated $R$-module, then

(a) (**invariant factor form**) $\exists b_1,\ldots,b_m\in R\ne 0$, $b_1\mid b_2\mid \cdots\mid b_m$, $\exists n$, s.t. $$V\cong R/(b_1)\oplus \cdots \oplus R/(b_m) \oplus R^n$$ Moreover, $\{(b_1)\supset \cdots \supset (b_m)\}$ (invariant factors) and $n$ is unique.

(b) (**Elementary divisor form**) $\exists p_1,\ldots,p_t\in R$ irreducible $(p_i)\ne (p_j)$ $$V\cong R/(p_1^{\alpha_1})\oplus \cdots \oplus R/(p_t^{\alpha_t})$$
:::

**Theorem**
If $V$ is finitely generated over a PID $R$, then $$V\cong R/b_1\oplus \cdots\oplus R/b_l \oplus R^k$$ $\exists k>0,b_1\mid \cdots\mid b_l\in R \ne 0$
:::

**Definition**
若$R$的每个理想都是有限生成的，则称$R$是诺特环。
:::

**Definition**
R be a ring. An $R$-module $V$ is called a noetherian R-module, if the following equivalent conditions holds:

1.  every R-submodule of $V$ is finitely generated.

2.  ACC (ascending chain condition) for any $V_0\subset V_1\subset \cdots \subset V$, ascending chain of $R$-submodules. $\exists n$ s.t. $V_n=V_{n+1}=\cdots$

3.  Every nonempty set $\Sigma$ of $R$-submodules of $V$ contains a maximal element. (w.r.t inclusion)
:::

**Example**
1.  $R=\mathbb{Z}$ noetherian ring., $\mathbb{Z}/n$ is a noetherian rings

2.  $R$ is a PID $\implies$ notherian ring (1. holds)

3.  If $R$ is a neotherian ring the every quotient ring $R/I$ is a noetherian ring.

4.  $\mathbb{Z}^{\oplus \mathbb{N}}$ is not a noetherain $\mathbb{Z}$-mod since it's not f.g.

5.  $R=K[x_n]_{n\ge 1}=K[x_1,x_2,\ldots]$
:::

**Remark**
note $R$ integral domain $R\subset \mathrm{Frac} R$ which is a field thus a noetherian ring. note A subring of a noetherian ring may not be noetherian.
:::

**Definition**
A ring $R$ is called a noetherian ring, if the $R$-mod $V=R$ is a noetherian R-mod.

1.  every ideal is f.g.

2.  ascending chain of ideals is stationary.

3.  every nonempty set of ideals has a max element w.r.t $\subset$
:::

**Proposition**
$R$ noetherian ring

1.  Every f.g. $R$-module is a noetherian $R$-module

2.  (Hilbert basis theorem) $R[x]$ is also a noetherian ring.
:::

terminology $0\to M' \xrightarrow{f}  M \xrightarrow{g} M'' \to 0$ is **short exact sequence** of $R$-modules

means $f,g$ be $R$-linear map. $f$ is injective, $g$ is surjective, $\mathrm{Im} f = \ker g$.

In other words, $M'\subset M$ ,$M/M'\xrightarrow{g,\sim} M''$

**Proposition**
Let $0\to M' \xrightarrow{f} M \xrightarrow{g} M'' \to 0$ be a SES of $R$-mod. Then $M$ is noetherian $\iff$ $M',M''$ are noetherian.
:::


*Proof.* ($\implies$) take any submodules $N'\subset M'$ or $N''\subset M''$ $\to N'\subset M' \subset M$ R-module $\implies$ $N'$ f.g. R-module.

$g^{-1}(N'')\subset g^{-1}(M') \subset M$ $\implies$ $N''$ f.g.

($\impliedby$)

take ac. $M_0\subset M_1\subset M_2 \subset \cdots$ of $M$

then $M_0\cap M' \subset M_1 \cap M' \subset M_2 \cap M' \subset \cdots$ is an a.c. of $R$-submodules of $M'$, so is stationary. i.e. $\exists n',s.t.$ $N' = M_{n'} \cap M' = M_{n'+1}\cap M'= M_{n'+2} \cap M' = \cdots$

$g(M_{n'})\subset g(M_{n'+1})\subset\cdots$ is an a.c. of $R$-submodules of $M''$, thus stationary. ◻
:::

**Corollary**
If $M$ is a noe $R$-mod, the $M^n$ is noetherian and $\forall N\subset M^n$ $M^n/N$ is noetherian.

In particular, if $R$ is a notherian ring, any $f.g.$ $R-modules$ is a noetherian $R$-module
:::

**Theorem**
If $R$ is noetherian, so is $R[x]$.
:::


*Proof.* Take any $J\subset R[x]$ ideal. For each $d\ge 0$, $I_d = \{a_d\in R:\exists f(x)\in J, \text{ s.t.} f(x) = a_d x^d +a_{d-1} x^{d-1}+\cdots +a_0 \}$, then it's a ideal. $$I_0\subset I_1\subset I_2 \subset \cdots$$ Since $R$ is noetherian $\exists N$,s.t. $I_N=I_{N+1}=\cdots$ and $I_N$ f.g. ◻
:::



[← Basic Properties of Modules](/posts/algebra2/module-basics/) | [Other Modules →](/posts/algebra2/more-modules/)

