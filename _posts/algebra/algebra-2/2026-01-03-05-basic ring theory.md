---
note: true
layout: post
title: "Algebra II Basic Properties of Rings"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/ring-basics/
categories: algebra
tags: [ring-theory, ideals, quotient-rings, ring-homomorphisms, polynomial-rings]
use_math: true
---

本文档介绍环的基本知识，包括环的定义、子环、理想、零因子、幂零元、整环、素理想和极大理想等核心概念。

# 环的基本知识

**Definition**（环）
环$(R, +, \cdot)$是一个集合$R$配上两个二元运算：加法$+$和乘法$\cdot$，满足：
1. $(R, +)$是阿贝尔群（有单位元记作$0$，称为零元）
2. 乘法满足结合律：对任意$a,b,c \in R$，$(ab)c = a(bc)$
3. 乘法对加法满足分配律：对任意$a,b,c \in R$，
   - $a(b+c) = ab + ac$（左分配律）
   - $(a+b)c = ac + bc$（右分配律）

如果还满足：
4. 存在乘法单位元$1 \in R$使得对任意$a \in R$，$1a = a1 = a$，则称$R$为**含幺环**（或**有单位元的环**）
5. 乘法满足交换律：对任意$a,b \in R$，$ab = ba$，则称$R$为**交换环**

**Definition**（环的子环）
环$R$的子环是$R$的一个子集$S$，满足：
1. $S$在加法运算下是$(R, +)$的子群（即对加法封闭，包含零元，且每个元素有加法逆元）
2. $S$在乘法运算下封闭（对任意$a,b \in S$，有$ab \in S$）
3. 如果$R$是含幺环，通常要求$S$包含$R$的单位元$1$

**注记**：
- 环的定义不要求乘法有单位元，也不要求乘法满足交换律
- 但乘法必须满足结合律（有些文献中也研究非结合环）
- 乘法单位元（如果存在）是唯一的
- 加法单位元（零元）是唯一的


**Example**（子环的例子）
1. $\mathbb{Z} \subset \mathbb{Q} \subset \mathbb{R} \subset \mathbb{C}$都是子环关系
2. $n\mathbb{Z} = \{nk : k \in \mathbb{Z}\}$不是$(\mathbb{Z}, +, \cdot)$的子环（当$n > 1$时，因为它不含单位元$1$）
3. $M_n(R)$表示$R$上$n \times n$矩阵环，$T_n(R)$（上三角矩阵）和$D_n(R)$（对角矩阵）都是$M_n(R)$的子环
4. 如果$R$是环，$S \subseteq R$，则$C(S) = \{r \in R : rs = sr \text{ 对所有 } s \in S\}$是$R$的子环（称为$S$的中心化子）

**Definition**（理想）
（双边）理想是$R$的子集$I$使得$(I,+)$为$(R,+)$的子群， 并且对任意$x\in R,y\in I$，$xy\in I \ \& \ yx\in I$。

**注记**：
- 左理想：对任意$x \in R, y \in I$，有$xy \in I$
- 右理想：对任意$x \in R, y \in I$，有$yx \in I$
- 双边理想：既是左理想又是右理想
- 在交换环中，左理想 = 右理想 = 双边理想
- 理想不一定为子环（因为可能不包含乘法单位元）

**Proposition**（理想的性质）：
1. 任意多个理想的交仍然是理想
2. 如果$I,J$是理想，则$I+J = \{a+b : a \in I, b \in J\}$是理想
3. 如果$I,J$是理想，则$I \cap J$是理想
4. 如果$I,J$是理想，则$IJ = \{\sum_{k=1}^n a_kb_k : a_k \in I, b_k \in J, n \in \mathbb{N}\}$是理想，且$IJ \subseteq I \cap J$

**Definition**（零因子、幂零元、幂等元）
设$R$是环：
(1) 零因子：如果$x \ne 0$且$\exists y \ne 0$，使得$xy=0$或$yx=0$
(2) 幂零元：如果$\exists n>0$，使得$x^n = 0$
(3) 幂等元：如果$x^2=x$
(4) 可逆元（unit）：如果$\exists y \in R$使得$xy = yx = 1$


**Proposition**（零因子、幂零元、幂等元的性质）：
1. 每个幂零元都是零因子（除非环是零环）
2. 在交换环中，如果$x,y$是幂零元，则$x+y$和$xy$也是幂零元
3. 如果$x$是幂零元且$u$是可逆元，则$u+x$是可逆元
4. $0$和$1$总是幂等元
5. 如果$e$是幂等元，则$1-e$也是幂等元
6. 如果$e$是幂等元，则$e(1-e) = 0$

*Proof.*
3. 设$x^n = 0$，则$(u+x)(u^{-1}(1-(-u^{-1}x) + (-u^{-1}x)^2 - \cdots + (-u^{-1}x)^{n-1})) = u + x - x + \cdots = 1$（当$n$足够大时，$(-u^{-1}x)^n = 0$）

**Proposition**
交换环只有两个理想$\Leftrightarrow$ $R$ 为域。


**Definition**
令${\{x_i\}}_{i \in J}\subset R$。 由${\{x_i\}}_{i \in J}$生成的理想= $$\bigg\{\sum_{j=1}^n a_jx_{i_j}b_j : a_j,b_j\in R \bigg\}$$


**Definition**
如理想$I$可以由一个元素生成，那么这个理想为主理想。


**Definition**
主理想整环 (PID) 是指每个理想都是主理想的整环。


**Definition**（除环和域）
带有单位元$1\ne0$的环$R$并且每个非零元素都是unit（可逆）的环是除环（division ring）。域就是交换除环。（通俗来说可以做除法的环）

**Example**（除环和域的例子）：
1. $\mathbb{Q}, \mathbb{R}, \mathbb{C}$是域
2. $\mathbb{H}$（四元数环）是除环但不是域（因为乘法不可交换）
3. $\mathbb{Z}/p\mathbb{Z}$（$p$为素数）是有限域，记作$\mathbb{F}_p$
4. 有限域的阶必须是素数的幂

**Proposition**（除环和域的性质）：
1. 每个除环都是整环
2. 有限除环是域（Wedderburn小定理）
3. 域的特征要么是0，要么是素数
4. 有限域的构造：对任意素数$p$和正整数$n$，存在唯一的（同构意义下）$p^n$阶有限域，记作$\mathbb{F}_{p^n}$


**Definition**（整环）
整环是交换环其中任意2个非零元素的积非零。 （$a\ne 0, b\ne 0\Longrightarrow ab\ne 0$, $ab=0\Longrightarrow a=0|b=0$）

**注记**：
- 整环没有零因子（除了零元本身）
- 整环的特征要么是0，要么是素数
- 有限整环一定是域

**Proposition**（整环的性质）：
1. 交换环$R$是整环当且仅当它没有非零零因子
2. 在整环中，消去律成立：如果$a \neq 0$且$ab = ac$，则$b = c$
3. 有限整环是域
4. 如果$R$是整环，则多项式环$R[x]$也是整环


**Definition**（真理想）
即不为$R$本身的理想（即$I \neq R$）。


**Definition**（素理想）
设$R$是交换环，$P$是$R$的真理想。$P$称为素理想，如果对任意$a,b \in R$，满足：
$$ab \in P \Rightarrow (a \in P \text{ 或 } b \in P)$$
即 $a \notin P \text{ 且 } b \notin P \Rightarrow ab \notin P$

**等价定义**：设$A,B$是$R$的理想，$P$是素理想当且仅当：
$$AB \subseteq P \Rightarrow A \subseteq P \text{ 或 } B \subseteq P$$

**Proposition**（素理想的性质）：
1. $P$是素理想当且仅当$R/P$是整环
2. 在交换环中，$0$是素理想当且仅当环本身是整环
3. 每个极大理想都是素理想
4. 如果$f: R \to S$是环同态，$P$是$S$的素理想，则$f^{-1}(P)$是$R$的素理想


**Remark**
素理想的在同态映射下的逆像是素理想。


**Proposition**
带有单位元的交换环中$P$是素理想，当且仅当$R\backslash P$是整环。


**Proposition**
让 $f: R \rightarrow S$ 是核为 $K$ 的环的满同态。

(a) 如果 $P$ 是包含 $K$ 的 $R$ 中的素理想，那么 $f(P)$ 是 $S$ 中的素理想

(b) 如果 $Q$ 是 $S$ 中的素理想，那么 $f^{-1}(Q)$ 是 $R$ 中包含 $K$ 的素理想。

(c) $R$ 中包含 $K$ 的所有素理想的集合与 $S$ 中所有素理想的集合之间存在一一对应关系，即 $P \mapsto f(P)$。

(d) 如果 $I$ 是环 $R$ 中的一个理想，那么 $R / I$ 中的每个素理想都是 $P / I$ 的形式，其中 $P$ 是包含 $I$ 的 $R$ 中的一个素理想。


**Definition**（极大理想）
理想$M$称为极大理想，如果$M$是真理想且不存在理想$I$满足$M \subsetneq I \subsetneq R$（即$M$不包含在任何其他真理想中）。

**Proposition**（极大理想的性质）：
(i) 如果$M$是极大理想且$R$是交换含幺环，那么商环$R/M$是域。
(ii) 如果$R$是交换含幺环且$M$是$R$的理想，那么$M$是极大理想当且仅当$R/M$是域。
(iii) 每个极大理想都是素理想（在交换含幺环中）。
(iv) 在诺特环中，每个素理想都是某些极大理想的交。

**Theorem**（Krull定理）
设$R$是含幺交换环，$I$是$R$的真理想。则存在$R$的极大理想$M$使得$I \subseteq M$。
特别地，每个非单位元素都包含在某个极大理想中。


**Lemma**
假设$S$为偏序集，使得$S$的每个全序子集都有上界。那么$S$包含至少一个极大元素。


注意到Zorn引理和选择公理等价。

**Proposition**
$R$的每个真理想都包含在某个极大真理想中。 特别的，任何环$R$都有一个极大真理想。 并且$R$的每个非unit元素都包含在一个极大理想中。



*Proof.* (使用Zorn引理)

设这个真理想为$I$。

为了使用Zorn引理，我们以集合的包含关系为偏序关系，那么包含$I$的真理想的集合是一个偏序集。

我们只要证明这个偏序集的每个全序子集都有上界。

设这个全序子集为$\mathcal{C}=\{C_i:i\in I\}$。

取$C=\bigcup_{i\in I}C_i$，这显然满足上界的条件。 我们只要证明它是真理想即可。

它是理想是容易验证的。

$C\ne R$可以通过证明$1\notin C$得到。 ◻


**Definition**（环同态）
设$R,S$是环，映射$\varphi: R \to S$称为环同态，如果对任意$a,b \in R$：
1. $\varphi(a+b) = \varphi(a) + \varphi(b)$
2. $\varphi(ab) = \varphi(a)\varphi(b)$
3. $\varphi(1_R) = 1_S$（如果$R,S$都是含幺环）

$\ker(\varphi) = \{a \in R : \varphi(a) = 0\}$称为同态的核，$\operatorname{im}(\varphi) = \{\varphi(a) : a \in R\}$称为同态的像。

**Theorem**（环同态基本定理/第一同构定理）
如果$R$和$S$是环且$\varphi:R \to S$是环同态，则$R/\ker(\varphi) \cong \operatorname{im}(\varphi)$。

*Proof.* 定义$\bar{\varphi}: R/\ker(\varphi) \to \operatorname{im}(\varphi)$为$\bar{\varphi}(a + \ker(\varphi)) = \varphi(a)$。
- 这个定义是良定义的：如果$a + \ker(\varphi) = b + \ker(\varphi)$，则$a-b \in \ker(\varphi)$，所以$\varphi(a-b) = 0$，即$\varphi(a) = \varphi(b)$。
- $\bar{\varphi}$是环同态：
$$
 \begin{align} 
   \bar{\varphi}((a + \ker(\varphi)) + (b + \ker(\varphi))) & = \bar{\varphi}((a+b) + \ker(\varphi)) \\
    & = \varphi(a+b) = \varphi(a) + \varphi(b) \\
    & = \bar{\varphi}(a + \ker(\varphi)) + \bar{\varphi}(b + \ker(\varphi))
\end{align}
$$
- 类似地可证乘法性质。
- $\bar{\varphi}$是单射：$\bar{\varphi}(a + \ker(\varphi)) = 0 \Leftrightarrow \varphi(a) = 0 \Leftrightarrow a \in \ker(\varphi) \Leftrightarrow a + \ker(\varphi) = 0$。
- $\bar{\varphi}$是满射：由定义$\operatorname{im}(\varphi)$，对任意$y \in \operatorname{im}(\varphi)$，存在$a \in R$使得$\varphi(a) = y$，所以$\bar{\varphi}(a + \ker(\varphi)) = y$。


**Theorem**（环的对应定理/第二同构定理）
设$I$是环$R$的一个理想。存在从包含$I$的$R$的子环集合到$R/I$的子环集合的双射$\psi$。该双射保持包含关系$(S_1 \subseteq S_2 \Leftrightarrow S_1\psi \subseteq S_2\psi)$，且包含$I$的$R$的理想对应于$R/I$的理想。

更具体地，这个双射是：
- 对$R$中包含$I$的子环$S$，对应$S/I \subseteq R/I$
- 对$R/I$中的子环$\overline{T}$，对应$\pi^{-1}(\overline{T}) \subseteq R$（其中$\pi: R \to R/I$是自然投影）

**Theorem**（第三同构定理）
如果$I$和$J$是环$R$的理想且$I \subseteq J$，则$(R/I)/(J/I) \cong R/J$。

*Proof.* 定义$\varphi: R/I \to R/J$为$\varphi(a+I) = a+J$。
- 这个定义是良定义的：如果$a+I = b+I$，则$a-b \in I \subseteq J$，所以$a+J = b+J$。
- $\varphi$是环同态：容易验证加法和乘法性质。
- $\varphi$是满射：对任意$b+J \in R/J$，有$\varphi(b+I) = b+J$。
- $\ker(\varphi) = \{a+I \in R/I : a+J = 0+J\} = \{a+I : a \in J\} = J/I$。
- 由第一同构定理，$(R/I)/\ker(\varphi) = (R/I)/(J/I) \cong \operatorname{im}(\varphi) = R/J$。

**Theorem**（环的同态基本定理）
如果$R$和$S$是环且$\varphi:R \to S$是环同态，则$R/\ker(\varphi) \cong \operatorname{im}(\varphi)$。




**Theorem**（环的第二同构定理）
如果$R$是一个环，$I$是$R$的理想且$S$是$R$的子环，定义$I +S = \{x+y : x \in I, y \in S\}$。则

(a) $I +S$是包含$I$的$R$的子环；

(b) $I \cap S$是$S$的理想；

(c) $(I +S)/I \cong S/(I \cap S)$

*Proof.*
(a) $I+S$在加法下封闭：$(x_1+y_1)+(x_2+y_2) = (x_1+x_2)+(y_1+y_2) \in I+S$，其中$x_1,x_2 \in I, y_1,y_2 \in S$。
   $I+S$在乘法下封闭：$(x_1+y_1)(x_2+y_2) = x_1x_2+x_1y_2+y_1x_2+y_1y_2$。由于$I$是理想，$x_1y_2, y_1x_2 \in I$，而$x_1x_2 \in I, y_1y_2 \in S$，所以乘积仍在$I+S$中。
   包含$I$：对任意$x \in I$，有$x = x+0 \in I+S$。

(b) $I \cap S \subseteq S$，且对任意$a \in I \cap S, s \in S$，有$as, sa \in S$（因为$S$是子环），且$as, sa \in I$（因为$I$是理想），所以$as, sa \in I \cap S$。

(c) 定义$\varphi: S \to (I+S)/I$为$\varphi(s) = s+I$。
   - $\varphi$是环同态：$\varphi(s_1+s_2) = (s_1+s_2)+I = (s_1+I)+(s_2+I) = \varphi(s_1)+\varphi(s_2)$，乘法类似。
   - $\varphi$是满射：对任意$(x+s)+I \in (I+S)/I$（其中$x \in I, s \in S$），有$(x+s)+I = s+I = \varphi(s)$。
   - $\ker(\varphi) = \{s \in S : s+I = I\} = \{s \in S : s \in I\} = S \cap I$。
   - 由第一同构定理，$S/(S \cap I) \cong (I+S)/I$。




## 环的例子

**Example**（常见环的例子）：
1. $\mathbb{Z}$：整数环（主理想整环，但不是域）
2. $\mathbb{Z}[i] = \{a+bi : a,b \in \mathbb{Z}\}$：高斯整数环
3. $\mathbb{Z}[\sqrt{-5}] = \{a+b\sqrt{-5} : a,b \in \mathbb{Z}\}$：非唯一分解整环
4. $M_n(R)$：$R$上$n \times n$矩阵环（当$n > 1$时非交换）
5. $R[x]$：$R$上的多项式环
6. $R[[x]]$：$R$上的形式幂级数环
7. $\mathbb{Z}/n\mathbb{Z}$：模$n$的剩余类环
8. $\mathbb{Q}[x]/(x^2-2)$：$\mathbb{Q}$的二次扩域

**Example**（主理想整环）：
- $\mathbb{Z}$：整数环
- $F[x]$：域$F$上的多项式环
- $F[[x]]$：域$F$上的形式幂级数环

[← Solvable Groups](/posts/algebra2/solvable-groups/) | [Introduction to Commutative Algebra →](/posts/algebra2/intro-commutative-algebra/)
