---
layout: post
title: "Algebra II Unique Factorization"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/unique-factorization/
tags: algebra
use_math: true
---

本文档介绍唯一分解理论，包括欧氏整环、主理想整环(PID)、唯一分解整环(UFD)及其相互关系，以及多项式环的相关性质。

# 欧几里得整环, PID, UFD

**Definition**（整除关系）
环$R$中的非零元素$a$整除$b$，记作$a\mid b$，如果存在$c\in R$使得$b=ac$。

**Definition**（整除关系的性质）
设$R$是整环，对于$a, b, c \in R$：
1. 自反性：$a \mid a$
2. 传递性：如果$a \mid b$且$b \mid c$，则$a \mid c$
3. 如果$a \mid b$且$a \mid c$，则$a \mid (b+c)$
4. 如果$a \mid b$，则对任意$r \in R$，有$a \mid rb$

**Proposition**（整除关系与主理想的联系）
设$R$是整环，$a, b \in R$，则：
(i) $a\mid b \Leftrightarrow (b) \subseteq (a)$
(ii) $(a)=(b) \Leftrightarrow a,b$是associate
(iii) $u$是unit $\Leftrightarrow (u)=R$
(iv) $u$是unit $\Leftrightarrow u\mid r,\forall r\in R$

*Proof.*
(i) $(\Rightarrow)$ 若$a \mid b$，则存在$c$使得$b = ac$，所以$b \in (a)$，因此$(b) \subseteq (a)$。
   $(\Leftarrow)$ 若$(b) \subseteq (a)$，则$b \in (a)$，所以存在$c$使得$b = ac$，即$a \mid b$。

(ii) $(\Rightarrow)$ 若$(a) = (b)$，则$a \in (b)$且$b \in (a)$，所以$a = bd$且$b = ae$对某些$d,e \in R$。于是$a = aed$，如果$a \neq 0$，则$1 = ed$，所以$d,e$是unit，因此$a,b$是associate。
   $(\Leftarrow)$ 若$a,b$是associate，则$a = bu$对unit $u$，所以$(a) \subseteq (b)$且$(b) = au^{-1} \in (a)$，所以$(b) \subseteq (a)$。

(iii) $u$是unit当且仅当存在$v$使得$uv = 1$，即$1 \in (u)$，这等价于$(u) = R$。

(iv) 若$u$是unit，则对任意$r$，$r = u(u^{-1}r)$，所以$u \mid r$。反之，若$u \mid r$对所有$r$，则$u \mid 1$，所以$u$是unit。


**Definition**（associate）
$a,b\in R$，如果$a\mid b$且$b\mid a$，则称$a,b$是associate。

**Definition**（unit）
$u\in R$，如果$u\mid 1$，则称$u$是unit。

**Definition**（不可约元）
$a\in R$，如果$a$非0非unit，且$a=bc$蕴含$b$或$c$是unit，则称$a$是不可约元。

**Definition**（素元）
$p\in R$，如果$p$非0非unit，且$p\mid bc$蕴含$p\mid b$或$p\mid c$，则称$p$是素元。

**Proposition**（unit的性质）
设$R$是整环，$u \in R$，则以下等价：
(i) $u$是unit
(ii) $(u) = R$
(iii) $u \mid r$对所有$r \in R$

**Proposition**（素元与不可约元的关系）
设$R$是整环，$p \in R$是素元，则$p$是不可约元。

*Proof.* 设$p$是素元，且$p = ab$。由于$p \mid ab$（即$p \mid p$），且$p$是素元，所以$p \mid a$或$p \mid b$。

如果$p \mid a$，则存在$c$使得$a = pc$，所以$p = ab = pcb$，即$p(1-cb) = 0$。由于$R$是整环且$p \neq 0$，所以$1-cb = 0$，即$cb = 1$，所以$b$是unit。

类似地，如果$p \mid b$，则$a$是unit。

因此，在分解$p = ab$中，至少有一个因子是unit，所以$p$是不可约元。

**注记**：不可约元不一定是素元。例如，在$\mathbb{Z}[\sqrt{-5}]$中，$2$是不可约元但不是素元，因为$2 \mid 6 = (1+\sqrt{-5})(1-\sqrt{-5})$，但$2$不整除$(1+\sqrt{-5})$或$(1-\sqrt{-5})$。


**Definition**
$p\in R$，如果$p$非0非unit，且$p\mid bc$，则$p\mid b$或$p\mid c$，则称$p$是素元。


**Definition**（唯一分解整环）
设$R$是一个整环，称其为 UFD (unique factorization domain) 如果：

(i) **存在性**：对任意$a\in R$，$a$非0非unit，存在不可约元$c_1,\cdots,c_n$使得$a=c_1\cdots c_n$。

(ii) **唯一性**：若$a=c_1\cdots c_n$且$a=d_1\cdots d_m$，其中$c_1,\cdots,c_n,d_1,\cdots,d_m$是不可约元，则$n=m$且存在$\sigma\in S_n$使得$c_i$和$d_{\sigma(i)}$是associate。

**Theorem**（UFD的等价条件）
设$R$是整环，则以下条件等价：
1. $R$是UFD
2. $R$中每个非零非unit元素都可以分解为不可约元的乘积，且在以下意义下分解唯一：如果$a = p_1\cdots p_r = q_1\cdots q_s$是两个不可约元分解，则$r=s$且经过重新排序后，$p_i$与$q_i$是associate。
3. $R$中每个非零非unit元素都可以分解为素元的乘积。

**Proposition**（UFD中素元与不可约元的关系）
设$R$是UFD，则$a \in R$是不可约元当且仅当$a$是素元。

*Proof.*
($\Leftarrow$) 前面已证明素元是不可约元。

($\Rightarrow$) 设$a$是UFD $R$中的不可约元，且$a \mid bc$。由于$R$是UFD，$b$和$c$都可以分解为不可约元的乘积：$b = p_1\cdots p_r$，$c = q_1\cdots q_s$。所以$bc = p_1\cdots p_r q_1\cdots q_s$。

由于$a \mid bc$，存在$d$使得$bc = ad$。由于$R$是UFD，$d$也可以分解为不可约元的乘积，所以$ad$是不可约元的乘积。由UFD的唯一性，$a$必须与$bc$的某个因子associate，即$a$与某个$p_i$或$q_j$associate。如果$a$与$p_i$associate，则$a \mid p_i$，所以$a \mid b$。类似地，如果$a$与$q_j$associate，则$a \mid c$。因此$a$是素元。


**Definition**（主理想整环）
整环$R$称为**主理想整环**（Principal Ideal Domain, PID），如果$R$的每个理想都是主理想，即对每个理想$I \unlhd R$，存在$a \in R$使得$I = (a)$。

**Lemma**（PID中的升链条件）
若$R$是PID，且$(a_1)\subset (a_2) \subset \cdots$为理想链，则存在$n$使得$(a_j)=(a_n)$，对任意$j>n$。

*Proof.* 设$I = \cup_{i=1}^{\infty} (a_i)$。由于$R$是PID，$I$是理想，所以$I = (a)$对某个$a \in R$。由于$a \in I$，存在$n$使得$a \in (a_n)$。对任意$j \geq n$，$(a_n) \subseteq (a_j) \subseteq I = (a)$，但由于$a \in (a_n)$，我们有$(a) \subseteq (a_n)$，所以$(a_n) = (a_j)$对所有$j \geq n$。

**Theorem**（PID是UFD）
PID是UFD。

*Proof.*
**存在性**：设$R$是PID，$a \in R$非零非unit。如果$a$不可约，则分解存在。如果$a$可约，即$a = bc$，其中$b,c$都不是unit，那么$(a) \subset (b)$且$(a) \subset (c)$（因为$a \in (b)$意味着存在$d$使得$b = ad$，所以$a = acd = bcd$，如果$b \neq 0$，则$1 = cd$，这与$c$不是unit矛盾）。

如果$b$或$c$可约，继续分解。由于PID满足升链条件，这个过程必须终止，所以$a$可以分解为不可约元的乘积。

**唯一性**：设$a = p_1\cdots p_r = q_1\cdots q_s$是两个不可约元分解。由于$p_1$是素元（在PID中不可约元是素元），$p_1 \mid q_1\cdots q_s$，所以$p_1 \mid q_i$对某个$i$。不失一般性，设$p_1 \mid q_1$。由于$q_1$不可约，$p_1$和$q_1$是associate，即$q_1 = up_1$对unit $u$。

消去$p_1$和$q_1$，得到$p_2\cdots p_r = u^{-1}q_2\cdots q_s$。重复这个过程，最终得到$r = s$，且经过重新排序后，$p_i$与$q_i$是associate。


**Definition**（欧氏整环）
欧氏整环是整环$R$，有一个映射$\delta:R\backslash \{0\}\rightarrow \mathbb{Z}_{\ge 0}$ 使得

1.  对任意$a,b\in R, b\ne 0$，存在$q,r\in R$使得$a=bq+r$，且$r=0$或$\delta(r)<\delta(b)$。(欧几里得算法，辗转相除法)

2.  如果$a,b\ne 0$且$ab \neq 0$，那么$\delta(a)\le \delta(ab)$

**Example**（欧氏整环的例子）
1. $\mathbb{Z}$：$\delta(n) = |n|$
2. $F[x]$（$F$是域）：$\delta(f) = \deg(f)$
3. 高斯整数环$\mathbb{Z}[i]$：$\delta(a+bi) = a^2+b^2$

**Proposition**（欧氏整环是PID）
欧氏整环是PID。

*Proof.* 设$R$是欧氏整环，$I$是$R$的理想。如果$I = \{0\}$，则$I = (0)$是主理想。假设$I \neq \{0\}$，取$0 \neq b \in I$使得$\delta(b)$最小。

对任意$0 \neq a \in I$，由欧氏性质，存在$q,r \in R$使得$a = bq + r$，其中$r = 0$或$\delta(r) < \delta(b)$。

由于$a, b \in I$，$r = a - bq \in I$。由于$\delta(b)$是最小的，$r$不能是非零元素（否则$\delta(r) < \delta(b)$与$b$的选择矛盾）。所以$r = 0$，即$a = bq$，所以$a \in (b)$。

因此$I \subseteq (b)$。显然$(b) \subseteq I$，所以$I = (b)$。因此$R$是PID。

**Corollary**
欧氏整环是UFD。


## 多项式环

**Definition**（最大公因子）
设$R$是一个整环，$a,b\in R$，如果$d\in R$满足

(i) $d\mid a,d\mid b$

(ii) $d'\mid a,d'\mid b\Rightarrow d'\mid d$

则称$d$是$a,b$的最大公因子。

**Definition**（本原多项式）
$f\in R[x]$是**本原多项式**（primitive polynomial），如果$f$的系数的最大公因子是1。

**Lemma**（高斯引理）
设$R$是UFD，$f,g\in R[x]$是本原多项式，则$fg$是本原多项式。

*Proof.* 设$f = a_0 + a_1x + \cdots + a_nx^n$，$g = b_0 + b_1x + \cdots + b_mx^m$。假设$fg$不是本原的，则存在不可约元$p$整除$fg$的所有系数。

设$p$整除$f$的前$k$个系数$a_0, \ldots, a_{k-1}$，但不整除$a_k$；$p$整除$g$的前$l$个系数$b_0, \ldots, b_{l-1}$，但不整除$b_l$。

考虑$(fg)$的$x^{k+l}$项的系数，它是$\sum_{i+j=k+l} a_i b_j$。在这些项中，$a_k b_l$不能被$p$整除（因为$p$是素元，$p$不整除$a_k$且不整除$b_l$），但其他项$a_i b_j$（其中$i<k$或$j<l$）都被$p$整除。因此，$x^{k+l}$项的系数不被$p$整除，这与$p$整除$fg$的所有系数矛盾。

**Lemma**（本原多项式的关联关系）
设$D$为UFD，分式域$F$，令$f,g$为$D[x]$的本原多项式，则$f,g$在$D[x]$中关联 $\Leftrightarrow f,g$在$F[x]$中关联。

*Proof.*
($\Rightarrow$) 显然。
($\Leftarrow$) 如果$f = cg$在$F[x]$中，其中$c \in F$，则$c = f/g$在$F$中。由于$f,g$是本原的，$c$必须在$D$中，且$c$是$D$的unit。

**Lemma**（本原多项式的不可约性）
设$D$为UFD，$F$为分式域，$f$为$D[x]$的本原多项式，则$f$在$D[x]$中不可约 $\Leftrightarrow f$在$F[x]$中不可约。

*Proof.*
($\Rightarrow$) 如果$f = gh$在$F[x]$中，则存在$0 \neq d \in D$使得$df = g'h'$，其中$g',h' \in D[x]$。由于$f$是本原的，可以证明$g',h'$可以写成$g' = dg_1, h' = h_1$或$g' = g_1, h' = dh_1$的形式，其中$g_1,h_1$是本原的。由于$f$在$D[x]$中不可约，$g_1$或$h_1$必须是unit，所以$f$在$F[x]$中不可约。

($\Leftarrow$) 如果$f = gh$在$D[x]$中，则由于$f$在$F[x]$中不可约，$g$或$h$必须是unit在$F[x]$中，这意味着它是$D[x]$中的unit。

**Theorem**（高斯引理）
设$D$为UFD，则$D[x]$为UFD。

*Proof.*
**存在性**：设$f \in D[x]$，$f \neq 0$且非unit。如果$\deg(f) = 0$，则$f \in D$，由于$D$是UFD，$f$可以分解为$D$中不可约元的乘积。

如果$\deg(f) > 0$，我们可以将$f$写成$f = cf_0$，其中$c \in F$（$F$是$D$的分式域），$f_0$是本原多项式。由于$D$是UFD，$c$可以分解。对于本原多项式$f_0$，如果$f_0$不可约，则分解完成；如果$f_0$可约，则继续分解。

**唯一性**：设$f = p_1\cdots p_r = q_1\cdots q_s$是两个分解。通过比较常数项和最高次项，以及使用$F[x]$中唯一分解的性质，可以证明分解的唯一性。

通过归纳，如果$D$是UFD，则$D[x_1, \ldots, x_n]$也是UFD。


**Definition**
$f\in R[x]$是primitive polynomial，如果$f$的系数的最大公因子是1。


**Lemma**
$f,g\in R[x]$是primitive polynomial，则$fg$是primitive polynomial。


**Lemma**
$D$为UFD，分式域$F$，令$f,g$为$D[x]$的primitive polynomial，则$f,g$在$D[x]$中 associate $\Leftrightarrow f,g$在$F[x]$中associate。


**Lemma**
$D$为UFD，$F$为分式域，$f$为$D[x]$的primitive polynomial，则$f$在$D[x]$中不可约 $\Leftrightarrow f$在$F[x]$中不可约。


**Theorem**
$D$为UFD，则$D[x]$为UFD。




[← Introduction to Commutative Algebra](/posts/algebra2/intro-commutative-algebra/) | [Basic Properties of Modules →](/posts/algebra2/module-basics/)

## 环的例子 

**Example**（环的例子） 
1. **整数环** $\mathbb{Z}$：这是欧氏整环，因此是PID，也是UFD。每个整数都可以唯一分解为素数的乘积。 

2. **多项式环** $F[x]$（$F$是域）：这是欧氏整环，因此是PID，也是UFD。不可约多项式扮演着素数的角色。 

3. **高斯整数环** $\mathbb{Z}[i] = \{a+bi : a,b \in \mathbb{Z}\}$：这是欧氏整环，其中欧氏函数是$\delta(a+bi) = a^2+b^2$。 

4. **$\mathbb{Z}[\sqrt{-5}]$**：这不是UFD，因为$6 = 2 \cdot 3 = (1+\sqrt{-5})(1-\sqrt{-5})$，而$2, 3, 1+\sqrt{-5}, 1-\sqrt{-5}$都是不可约元，但它们不是associate。 

5. **$F[x,y]$**（$F$是域）：这是UFD但不是PID，因为理想$(x,y)$不是主理想。 

6. **$\mathbb{Z}[x]$**：这是UFD但不是PID，因为理想$(2,x)$不是主理想。 

**Theorem**（环的包含关系） 
欧氏整环 $\subset$ PID $\subset$ UFD 

所有包含关系都是严格的，即存在PID不是欧氏整环，存在UFD不是PID。

