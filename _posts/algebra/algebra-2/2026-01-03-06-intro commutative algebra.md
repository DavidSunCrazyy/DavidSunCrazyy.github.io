---
layout: post
title: "Algebra II Introduction to Commutative Algebra"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/intro-commutative-algebra/
tags: algebra
use_math: true
---

本文档介绍交换代数的基本概念，包括希尔伯特零点定理、素谱、积环、局部化等核心内容。

# 交换代数导论

## 希尔伯特零点定理

**Theorem**（希尔伯特零点定理的弱形式）
设$K$为代数闭域。则$K[x_1, \ldots, x_n]$的极大理想形如$(x_1 − a_1, \ldots, x_n − a_n)$，其中$(a_1, \ldots, a_n) \in K^n$。

*Proof.* （概要）
设$\mathfrak{m}$是$K[x_1, \ldots, x_n]$的极大理想。考虑商环$K[x_1, \ldots, x_n]/\mathfrak{m}$，这是一个域，且是$K$的有限扩张。由于$K$是代数闭的，这个扩张必须是$K$本身。因此存在$(a_1, \ldots, a_n) \in K^n$使得$x_i \equiv a_i \pmod{\mathfrak{m}}$，即$(x_1-a_1, \ldots, x_n-a_n) \subseteq \mathfrak{m}$。由于$(x_1-a_1, \ldots, x_n-a_n)$是极大理想，我们有$\mathfrak{m} = (x_1-a_1, \ldots, x_n-a_n)$。

**Definition**（代数集）
设$K$是代数闭域，$S \subseteq K[x_1, \ldots, x_n]$是一组多项式。定义$S$的零点集为：
$$V(S) = \{(a_1, \ldots, a_n) \in K^n : f(a_1, \ldots, a_n) = 0 \text{ 对所有 } f \in S\}$$

**Definition**（理想的零点集）
对理想$I \subseteq K[x_1, \ldots, x_n]$，定义$V(I) = V(\{f : f \in I\})$。

**Definition**（理想的根）
对理想$I \subseteq R$，定义$I$的根为：
$$\sqrt{I} = \{r \in R : \exists n > 0 \text{ 使得 } r^n \in I\}$$

**Theorem**（希尔伯特零点定理的强形式）
设$K$是代数闭域，$I \subseteq K[x_1, \ldots, x_n]$是一个理想。则：
$$I(V(I)) = \sqrt{I}$$
其中$I(V(I)) = \{f \in K[x_1, \ldots, x_n] : f(a_1, \ldots, a_n) = 0 \text{ 对所有 } (a_1, \ldots, a_n) \in V(I)\}$。


**Definition**（素谱）
设$R$是一个环，$R$的**素谱**是$R$的素理想的集合，记作$\operatorname{Spec}(R)$。

**Example**（复多项式环的素谱）
$\operatorname{Spec}(\mathbb{C}[x,y])$的元素包括：
- $(0)$：零理想（最小的素理想）
- $(x-a,y-b)$：对应于$\mathbb{C}^2$中的点$(a,b)$（极大理想，也是素理想）
- $(f)$：其中$f \in \mathbb{C}[x,y]$是不可约多项式（高度为1的素理想）

**Definition**（扎里斯基拓扑）
在$\operatorname{Spec}(R)$上定义扎里斯基拓扑：闭集是形如$V(I) = \{\mathfrak{p} \in \operatorname{Spec}(R) : I \subseteq \mathfrak{p}\}$的集合，其中$I$是$R$的理想。

**Proposition**（扎里斯基拓扑的性质）
1. $V(0) = \operatorname{Spec}(R)$，$V(R) = \emptyset$
2. $V(\sum I_\alpha) = \cap V(I_\alpha)$
3. $V(I \cap J) = V(I) \cup V(J)$

**Definition**（扎里斯基闭集）
对于$S \subseteq \operatorname{Spec}(R)$，定义$V(S) = \{\mathfrak{p} \in \operatorname{Spec}(R) : \mathfrak{p} \supseteq \mathfrak{q} \text{ 对某个 } \mathfrak{q} \in S\}$。


## 积环

**Definition**（环的直积）
设$R,S$是环，$R\times S$是$R$和$S$的直积，定义为：
- 元素：$(r,s)$，其中$r \in R, s \in S$
- 加法：$(r,s)+(r',s')=(r+r',s+s')$
- 乘法：$(r,s)\cdot (r',s')=(r\cdot r',s\cdot s')$
- 单位元：$(1_R, 1_S)$

**Proposition**（积环的性质）
1. $R \times S$是环
2. $(1,0)$和$(0,1)$是$R \times S$中的幂等元
3. $(1,0) + (0,1) = (1,1)$是单位元
4. $(1,0) \cdot (0,1) = (0,0)$是零元

**Theorem**（环的分解）
设$R$是环，$e \in R$是幂等元（即$e^2 = e$），且$e \neq 0,1$。则$R \cong eR \times (1-e)R$，其中$eR$和$(1-e)R$是环（具有单位元$e$和$1-e$）。

**Definition**（理想的积）
设$I$是$R$的理想，$J$是$S$的理想，则$I \times J$是$R \times S$的理想，定义为：
$$I \times J = \{(i,j) : i \in I, j \in J\}$$

**Proposition**（积环的理想结构）
$R \times S$的每个理想都形如$I \times J$，其中$I \unlhd R$，$J \unlhd S$。

**Proposition**（积环的素理想和极大理想）
1. $R \times S$的素理想形如$\mathfrak{p} \times S$或$R \times \mathfrak{q}$，其中$\mathfrak{p}$是$R$的素理想，$\mathfrak{q}$是$S$的素理想
2. $R \times S$的极大理想形如$\mathfrak{m} \times S$或$R \times \mathfrak{n}$，其中$\mathfrak{m}$是$R$的极大理想，$\mathfrak{n}$是$S$的极大理想


## 局部化

**Definition**（分式环/商域）
令$R$为整环。$R$的**分式环**（或**商域**，如果$R$是域）定义为：
$$\operatorname{Frac}(R) := \{(a,s)\in R^2:s\ne 0\}/\sim$$
其中$(a,s)\sim (b,t) \iff at=bs$。

**注记**：在分式环中，我们将$(a,s)$记作$a/s$，这样就得到了熟悉的分数形式。

**Definition**（乘法封闭子集）
设$R$是一个环，$S \subseteq R$满足：
1. $1 \in S$
2. 对任意$x,y \in S$，有$xy \in S$

则$S$称为$R$的**乘法封闭子集**。

**注记**：注意这里的定义与原文略有不同，通常不需要$x-y \in S$这个条件，而是要求$S$对乘法封闭且包含单位元。

**Definition**（环的局部化）
设$R$是一个环，$S$是$R$的乘法封闭子集。$R$关于$S$的**局部化**定义为：
$$S^{-1}R:=\{(r,s)\in R\times S\}/\sim$$
其中$(r,s)\sim (r',s')$当且仅当存在$t\in S$使得$t(rs'-r's)=0$。

在$S^{-1}R$中，我们将等价类$[(r,s)]$记作$r/s$，并在其上定义运算：
- 加法：$r/s + r'/s' = (rs' + r's)/(ss')$
- 乘法：$(r/s) \cdot (r'/s') = (rr')/(ss')$
- 单位元：$1/1$
- 零元：$0/1$

**Remark**（局部化的性质）
1. $\sim$ 是等价关系
2. $S^{-1}R$是一个环
3. 映射$\varphi:R\rightarrow S^{-1}R$，定义为$r\mapsto r/1$，是环同态
4. 对任意$s \in S$，$s/1$在$S^{-1}R$中是可逆的，其逆元是$1/s$


**Proposition**（整环的局部化）
如果$R$是整环，则$S^{-1}R$也是整环。

*Proof.* 设$R$是整环，$a/s, b/t \in S^{-1}R$，且$(a/s)(b/t) = 0$。则$ab/(st) = 0/1$，这意味着存在$u \in S$使得$u(ab \cdot 1 - 0 \cdot st) = uab = 0$。由于$R$是整环且$u \neq 0$，我们有$ab = 0$。由于$R$是整环，所以$a = 0$或$b = 0$，因此$a/s = 0$或$b/t = 0$。

**Proposition**（分式环的性质）
如果$S = R \setminus \{0\}$，则$S^{-1}R = \operatorname{Frac}(R)$是域。

**Lemma**（素理想的补集是乘法封闭的）
设$R$是一个环，$\mathfrak{p}$为素理想，则$S = R \setminus \mathfrak{p}$是乘法封闭子集。

*Proof.* 显然$1 \in S$（因为$\mathfrak{p}$是真理想）。如果$x, y \in S$，则$x, y \notin \mathfrak{p}$。由于$\mathfrak{p}$是素理想，$xy \notin \mathfrak{p}$（否则$x \in \mathfrak{p}$或$y \in \mathfrak{p}$），所以$xy \in S$。


**Definition**（局部化在素理想处）
设$\mathfrak{p}$是环$R$的素理想，$S = R \setminus \mathfrak{p}$。则$S$是乘法封闭子集，定义：
$$R_{\mathfrak{p}} = S^{-1}R$$
称为$R$在素理想$\mathfrak{p}$处的**局部化**。

**Proposition**（局部化的泛性质）
设$S$是环$R$的乘法封闭子集，$\varphi: R \to S^{-1}R$是自然同态。如果$f: R \to T$是环同态，且对所有$s \in S$，$f(s)$在$T$中可逆，则存在唯一的环同态$g: S^{-1}R \to T$使得$f = g \circ \varphi$。


**Definition**（理想在局部化中的扩展）
设$R$是一个环，$S$是$R$的乘法封闭子集，$I$为$R$的理想。定义$I$在$S^{-1}R$中的**扩展**为：
$$S^{-1}I:=\{a/s\in S^{-1}R:a\in I, s\in S\}$$
这等价于$\varphi(I) \cdot S^{-1}R$，其中$\varphi: R \to S^{-1}R$是自然同态。

**Theorem**（局部化与理想的运算）
设$I,J$为$R$的理想，则：
(a) $S^{-1}(I+J)=S^{-1}I+S^{-1}J$
(b) $S^{-1}(IJ)=S^{-1}I \cdot S^{-1}J$
(c) $S^{-1}(I\cap J)=S^{-1}I\cap S^{-1}J$

*Proof.*
(a) $$S^{-1}(I+J) = \{(a+b)/s : a \in I, b \in J, s \in S\} = \{a/s + b/s : a \in I, b \in J, s \in S\} = S^{-1}I + S^{-1}J$$

(b) $$S^{-1}(IJ) = \{(\sum a_ib_i)/s : a_i \in I, b_i \in J, s \in S\} = \{(\sum (a_i/1)(b_i/1))/s : a_i \in I, b_i \in J, s \in S\} = S^{-1}I \cdot S^{-1}J$$

(c) 包含关系$S^{-1}(I\cap J) \subseteq S^{-1}I\cap S^{-1}J$是显然的。对于反向包含，设$a/s \in S^{-1}I\cap S^{-1}J$，则$a/s = b/t$对某个$b \in I, t \in S$，且$a/s = c/u$对某个$c \in J, u \in S$。存在$v \in S$使得$v(at-bs) = 0$和$v(au-cs) = 0$。于是$vat = vbs \in I$（因为$b \in I$且$I$是理想），$vau = vcs \in J$。由于$vat \in I \cap J$，我们有$a/s = (vat)/(vst) \in S^{-1}(I \cap J)$。


**Proposition**（局部化与理想的等价条件）
$S^{-1}I=S^{-1}R \iff S\cap I\ne \emptyset$。

*Proof.*
$(\Rightarrow)$ 如果$S^{-1}I = S^{-1}R$，则$1/1 \in S^{-1}I$，所以$1/1 = a/s$对某个$a \in I, s \in S$。存在$t \in S$使得$t(1 \cdot s - a \cdot 1) = t(s-a) = 0$。因此$s-a \in \operatorname{Ann}(t)$（$t$的零化子）。由于$t \in S$且$S$是乘法封闭的，$t \neq 0$。如果$R$是整环，则$s = a \in S \cap I$。

$(\Leftarrow)$ 如果$S \cap I \neq \emptyset$，设$s \in S \cap I$，则$1/1 = s/s \in S^{-1}I$，所以$S^{-1}I = S^{-1}R$。

**Theorem**（局部化与商环的交换性）
$$S^{-1}R/S^{-1}I\cong \overline{S}^{-1}(R/I)$$
其中$\overline{S}$是$S$在$R \to R/I$下的像。

*Proof.* 定义$\varphi: S^{-1}R \to \overline{S}^{-1}(R/I)$为$\varphi(a/s) = (a+I)/(s+I)$。这个映射是良定义的，是环同态，且是满射。

$$\ker(\varphi) = \{a/s \in S^{-1}R : (a+I)/(s+I) = 0+I\} = \{a/s : \exists t \in S \text{ s.t. } t(a+I) = 0+I\} = \{a/s : ta \in I \text{ for some } t \in S\} = S^{-1}I$$

由第一同构定理，$S^{-1}R/S^{-1}I \cong \overline{S}^{-1}(R/I)$。

**Theorem**（素理想在局部化中的行为）
若$\mathfrak{p}\in \operatorname{Spec} R$且$S\cap \mathfrak{p}=\emptyset$，则$S^{-1}\mathfrak{p}$在$S^{-1}R$中为素理想，并且$\varphi^{-1}(S^{-1}\mathfrak{p})=\mathfrak{p}$，其中$\varphi: R \to S^{-1}R$是自然同态。

*Proof.*
首先证明$S^{-1}\mathfrak{p}$是素理想。设$(a/s)(b/t) \in S^{-1}\mathfrak{p}$，即$(ab)/(st) = c/u$对某个$c \in \mathfrak{p}, u \in S$。则存在$v \in S$使得$v(abu - cst) = 0$，即$vabu = vcst$。由于$c \in \mathfrak{p}$，$vcst \in \mathfrak{p}$，所以$vabu \in \mathfrak{p}$。由于$S \cap \mathfrak{p} = \emptyset$，$vu \notin \mathfrak{p}$，所以$ab \in \mathfrak{p}$。由于$\mathfrak{p}$是素理想，$a \in \mathfrak{p}$或$b \in \mathfrak{p}$，因此$a/s \in S^{-1}\mathfrak{p}$或$b/t \in S^{-1}\mathfrak{p}$。

对于$\varphi^{-1}(S^{-1}\mathfrak{p})=\mathfrak{p}$，设$a \in \varphi^{-1}(S^{-1}\mathfrak{p})$，即$a/1 \in S^{-1}\mathfrak{p}$。则$a/1 = b/s$对某个$b \in \mathfrak{p}, s \in S$。存在$t \in S$使得$t(as-b) = 0$，即$ats = bt$。由于$b \in \mathfrak{p}$，$bt \in \mathfrak{p}$，所以$ats \in \mathfrak{p}$。由于$S \cap \mathfrak{p} = \emptyset$，$ts \notin \mathfrak{p}$，所以$a \in \mathfrak{p}$。反向包含是显然的。


**Theorem**（局部化与素谱的对应）
设$S$是$R$的乘法封闭子集，则$S^{-1}R$的素理想一一对应于$R$的素理想$\mathfrak{p}$满足$\mathfrak{p} \cap S = \emptyset$。
$$\operatorname{Spec}(S^{-1}R) \leftrightarrow \{\mathfrak{p} \in \operatorname{Spec}(R) : \mathfrak{p} \cap S = \emptyset\}$$

这个对应关系由$\mathfrak{q} \mapsto \varphi^{-1}(\mathfrak{q})$和$\mathfrak{p} \mapsto S^{-1}\mathfrak{p}$给出，其中$\varphi: R \to S^{-1}R$是自然同态。

**Definition**（局部环）
设$(R, \mathfrak{m})$是环，如果$R$只有一个极大理想$\mathfrak{m}$，则称$R$是**局部环**。$\mathfrak{m}$称为$R$的**唯一极大理想**。

**Proposition**（局部环的性质）
$(R, \mathfrak{m})$是局部环当且仅当$R \setminus \mathfrak{m}$是$R$中所有可逆元的集合。

*Proof.*
$(\Rightarrow)$ 设$(R, \mathfrak{m})$是局部环。如果$x \in R \setminus \mathfrak{m}$，则$(x)$是包含$x$的主理想。由于$x \notin \mathfrak{m}$，$(x) \not\subseteq \mathfrak{m}$，所以$(x) = R$（因为$\mathfrak{m}$是唯一极大理想）。因此存在$r \in R$使得$rx = 1$，即$x$可逆。

反之，如果$x \in R$可逆，则$x$不在任何真理想中，特别是$x \notin \mathfrak{m}$。

$(\Leftarrow)$ 如果$R \setminus \mathfrak{m}$恰好是所有可逆元的集合，则$\mathfrak{m}$是所有非可逆元的集合。任何真理想都不包含可逆元，所以任何真理想都包含在$\mathfrak{m}$中。因此$\mathfrak{m}$是唯一极大理想。

**Theorem**（局部化产生局部环）
如果$\mathfrak{p}$是$R$的素理想，则$R_{\mathfrak{p}}$是局部环，其唯一极大理想是$\mathfrak{p}R_{\mathfrak{p}}$。

*Proof.* 我们需要证明$R_{\mathfrak{p}}$的唯一极大理想是$\mathfrak{p}R_{\mathfrak{p}}$。由前面的定理，$R_{\mathfrak{p}}$的素理想与$R$的素理想$\mathfrak{q}$满足$\mathfrak{q} \cap (R \setminus \mathfrak{p}) = \emptyset$，即$\mathfrak{q} \subseteq \mathfrak{p}$一一对应。在这些素理想中，最大的一个是$\mathfrak{p}$本身，所以$\mathfrak{p}R_{\mathfrak{p}}$是$R_{\mathfrak{p}}$的唯一极大理想。


**Example**（局部化的例子）
1. $R=\mathbb{Z}$，$S=\mathbb{Z}\setminus \{0\}$，则$S^{-1}R=\mathbb{Q}$。
2. $R=\mathbb{Z}$，$S=\{2^n:n\ge0\}$，则$S^{-1}R=\mathbb{Z}[1/2] = \{a/2^n : a \in \mathbb{Z}, n \geq 0\}$。
3. $R=F[x]$（$F$是域），$S = \{1, x, x^2, \ldots \}$，则$S^{-1}R = F[x, x^{-1}]$（Laurent多项式环）。

## Nilradical和Jacobson Radical

**Definition**（Nilradical）
设$R$是环，定义$R$的**Nilradical**为：
$$\sqrt{0} = \{x \in R : x \text{ 是幂零元 }, \exists n > 0, x^n = 0\}$$

更一般地，对理想$I$，定义$I$的根为：
$$\sqrt{I} = \{x \in R : \exists n > 0 \text{ 使得 } x^n \in I\}$$

**Theorem**（Nilradical的性质）
$$\sqrt{0} = \bigcap_{\mathfrak{p} \in \operatorname{Spec} R} \mathfrak{p}$$

*Proof.*
($\subseteq$) 设$x \in \sqrt{0}$，则存在$n > 0$使得$x^n = 0$。对任意素理想$\mathfrak{p}$，由于$0 \in \mathfrak{p}$，我们有$x^n \in \mathfrak{p}$。由于$\mathfrak{p}$是素理想，$x \in \mathfrak{p}$。

($\supseteq$) 设$x \notin \sqrt{0}$。考虑集合$S = \{1, x, x^2, x^3, \ldots\}$。由于$x$不是幂零元，$0 \notin S$。由Zorn引理，存在包含$(0)$且与$S$不相交的极大理想$\mathfrak{m}$。可以证明这样的$\mathfrak{m}$是素理想：如果$ab \in \mathfrak{m}$但$a, b \notin \mathfrak{m}$，则$(\mathfrak{m}, a) \cap S \neq \emptyset$和$(\mathfrak{m}, b) \cap S \neq \emptyset$，这会导致$S \cap \mathfrak{m} \neq \emptyset$，矛盾。因此$\mathfrak{m}$是素理想且$x \notin \mathfrak{m}$，所以$x \notin \bigcap_{\mathfrak{p} \in \operatorname{Spec} R} \mathfrak{p}$。

**Definition**（Jacobson Radical）
设$R$是环，定义$R$的**Jacobson Radical**为：
$$J(R) = \bigcap_{\mathfrak{m} \text{ 极大理想}} \mathfrak{m}$$

**Theorem**（Jacobson Radical的性质）
$$J(R) = \{x \in R : 1-ax \text{ 对所有 } a \in R \text{ 都是可逆元}\}$$

*Proof.*
($\subseteq$) 设$x \in J(R)$，假设存在$a \in R$使得$1-ax$不是可逆元。则$(1-ax)$是真理想，包含在某个极大理想$\mathfrak{m}$中。由于$x \in J(R) \subseteq \mathfrak{m}$，$ax \in \mathfrak{m}$，所以$1 = (1-ax) + ax \in \mathfrak{m}$，这与$\mathfrak{m}$是真理想矛盾。

($\supseteq$) 设$x \notin J(R)$，则存在极大理想$\mathfrak{m}$使得$x \notin \mathfrak{m}$。考虑$(\mathfrak{m}, x)$，这是整个环$R$，所以$1 = m + ax$对某些$m \in \mathfrak{m}, a \in R$。于是$1-ax = m \in \mathfrak{m}$。如果$1-ax$可逆，则$1 \in \mathfrak{m}$，矛盾。所以$1-ax$不是可逆元。


## 几何解释

**Remark**（几何解释）
交换代数与代数几何密切相关。对于一个交换环$R$：
- $\operatorname{Spec}(R)$可以看作是"代数簇"的点集
- 素理想$\mathfrak{p}$对应于代数簇的"子簇"（不可约子集）
- 极大理想对应于代数簇的"点"
- $R_{\mathfrak{p}}$表示在点$\mathfrak{p}$附近的函数芽（germs of functions）
- 局部化过程对应于在特定点附近研究代数簇的性质

**Example**（几何例子）
考虑$R = \mathbb{C}[x,y]/(xy)$，这是两条坐标轴的并集的坐标环。$\operatorname{Spec}(R)$包含：
- $(x,y)$：两条轴的交点
- $(x-a)$：$x$轴上的点（$a \neq 0$）
- $(y-b)$：$y$轴上的点（$b \neq 0$）

在$(x,y)$处的局部化$R_{(x,y)}$反映了在原点附近的行为，而$R_{(x-a)}$（$a \neq 0$）反映了在$x$轴上远离原点的点附近的行为。

**Definition**（Noetherian环）
环$R$称为**Noetherian**，如果它满足升链条件：对任意理想升链$I_1 \subseteq I_2 \subseteq I_3 \subseteq \cdots$，存在$n$使得$I_n = I_{n+1} = \cdots$。

**Theorem**（Hilbert基定理）
如果$R$是Noetherian环，则$R[x]$也是Noetherian环。

[← Basic Properties of Rings](/posts/algebra2/ring-basics/) | [Unique Factorization →](/posts/algebra2/unique-factorization/)
