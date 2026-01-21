---
layout: post
title: "Algebra II Structure of Finitely Generated Modules"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/finitely-generated-modules/
tags: algebra
use_math: true
---

本文档介绍有限生成模的结构理论，包括自由模、有限生成模在主理想整环上的结构定理、诺特环以及相关的同构定理等内容。

# 有限生成模的结构

## 自由模

**Definition**
设$R$为环，$M$为$R$-模，设$S$为$M$的任意非空子集，下列所有的有限和 $$\sum_{x\in S} a_x x,a_x\in R$$ 其中只有有限多个$a_x$不为$0$ 为由$x$生成


**Definition**


**Theorem**
假设$R$是一个PID

1. 自由$R$-模的每个子模都是自由的。
2. 
    - 如果$V$是秩为$n<\infty$的自由$R$-模，$W\subset V$是子模，则$W$是自由的且$\operatorname{rank} W = m\le n$

    - $\exists v_1,\ldots,v_n$是$V$的基，$\exists b_1,\ldots,b_m\in R,\ne 0$使得$b_1 v_1,\ldots,b_m v_m$是$W$的基。并且 $$b_1\mid b_2\mid \cdots \mid b_m$$


**Corollary**
$V$是有限生成的，比如$V=\langle v_1,\ldots,v_m\rangle\to R^m\twoheadrightarrow^\pi V$


## 主理想整环上的有限生成模

## 有限生成模

**Definition**
若$M$可以由有限个元素生成，则称$M$是有限生成的。


**Theorem**
$R$是一个PID，$V$是一个有限生成的$R$-模，则

1. （不变因子形式）$\exists b_1,\ldots,b_m\in R\ne 0$，$b_1\mid b_2\mid \cdots\mid b_m$，$\exists n$，使得 $$V\cong R/(b_1)\oplus \cdots \oplus R/(b_m) \oplus R^n$$ 此外，$\{(b_1)\supset \cdots \supset (b_m)\}$（不变因子）和$n$是唯一的。

2. （初等因子形式）$\exists p_1,\ldots,p_t\in R$不可约且$(p_i)\ne (p_j)$ $$V\cong R/(p_1^{\alpha_1})\oplus \cdots \oplus R/(p_t^{\alpha_t})$$


**Theorem**
如果$V$在PID $R$上是有限生成的，则 $$V\cong R/b_1\oplus \cdots\oplus R/b_l \oplus R^k$$ $\exists k>0,b_1\mid \cdots\mid b_l\in R \ne 0$


**Definition**
若$R$的每个理想都是有限生成的，则称$R$是诺特环。


**Definition**
设$R$为一个环。如果满足以下等价条件之一，则称$R$-模$V$是诺特$R$-模：

1.  $V$的每个$R$-子模都是有限生成的。

2.  对于任何$V_0\subset V_1\subset \cdots \subset V$，$R$-子模的升链条件(ACC)。$\exists n$使得$V_n=V_{n+1}=\cdots$

3.  $V$的$R$-子模的每个非空集合$\Sigma$包含一个最大元素。（关于包含关系）


**Example**
1.  $R=\mathbb{Z}$是诺特环，$\mathbb{Z}/n$是诺特环

2.  $R$是PID $\implies$ 诺特环（条件1成立）

3.  如果$R$是诺特环，则每个商环$R/I$是诺特环。

4.  $\mathbb{Z}^{\oplus \mathbb{N}}$不是诺特$\mathbb{Z}$-模，因为它不是有限生成的。

5.  $R=K[x_n]_{n\ge 1}=K[x_1,x_2,\ldots]$


**Remark**
注意$R$是整环，$R\subset \mathrm{Frac} R$，而$\mathrm{Frac} R$是一个域，从而是诺特环。注意诺特环的子环可能不是诺特环。


**Definition**
如果$R$-模$V=R$是诺特$R$-模，则称环$R$是诺特环。

1.  每个理想都是有限生成的。

2.  理想的升链是稳定的。

3.  每个理想的非空集合关于$\subset$有一个最大元素


**Proposition**
$R$是诺特环

1.  每个有限生成的$R$-模是诺特$R$-模

2.  （Hilbert基定理）$R[x]$也是诺特环。


术语 $0\to M' \xrightarrow{f}  M \xrightarrow{g} M'' \to 0$ 是$R$-模的**短正合序列**

意思是$f,g$是$R$-线性映射。$f$是单射，$g$是满射，$\mathrm{Im} f = \ker g$。

换句话说，$M'\subset M$ ,$M/M'\xrightarrow{g,\sim} M''$

**Proposition**
设$0\to M' \xrightarrow{f} M \xrightarrow{g} M'' \to 0$是$R$-模的短正合序列(SDS)。则$M$是诺特的 $\iff$ $M',M''$ 是诺特的。



*Proof.* ($\implies$) 取$M'$或 $M''$ 的任意子模$N'$或$N''$ $\to N'\subset M' \subset M$是$R$-模 $\implies$ $N'$是有限生成的$R$-模。

$g^{-1}(N'')\subset g^{-1}(M') \subset M$ $\implies$ $N''$ 是有限生成的。

($\impliedby$)

取$M$的升链 $M_0\subset M_1\subset M_2 \subset \cdots$

那么 $M_0\cap M' \subset M_1 \cap M' \subset M_2 \cap M' \subset \cdots$ 是$M'$的$R$-子模的升链，所以是稳定的。即$\exists n'$，使得$N' = M_{n'} \cap M' = M_{n'+1}\cap M'= M_{n'+2} \cap M' = \cdots$

$g(M_{n'})\subset g(M_{n'+1})\subset\cdots$是 $M''$ 的$R$-子模的升链，因此是稳定的。 Qed


**Corollary**
如果$M$是诺特$R$-模，则$M^n$是诺特的且$\forall N\subset M^n$，$M^n/N$是诺特的。

特别地，如果$R$是诺特环，任何有限生成的$R$-模是诺特$R$-模


**Theorem**
如果$R$是诺特环，则$R[x]$也是诺特环。



*Proof.* 取任意$J\subset R[x]$理想。对于每个$d\ge 0$，$I_d = \{a_d\in R:\exists f(x)\in J, \text{ s.t.} f(x) = a_d x^d +a_{d-1} x^{d-1}+\cdots +a_0 \}$，那么它是一个理想。$$I_0\subset I_1\subset I_2 \subset \cdots$$ 由于$R$是诺特环，$\exists N$，使得$I_N=I_{N+1}=\cdots$且$I_N$是有限生成的。 Qed




[← Basic Properties of Modules](/posts/algebra2/module-basics/) | [Other Modules →](/posts/algebra2/more-modules/)

