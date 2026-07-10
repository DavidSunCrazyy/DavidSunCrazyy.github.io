---
note: true
layout: post
title: "Algebra II Basic Properties of Modules"
date: 2026-01-03 00:00:00 +0800
permalink: /posts/algebra2/module-basics/
categories: algebra
tags: [module-theory, free-modules, exact-sequences, hom-functors, tensor-products]
use_math: true
---

本文档介绍模的基本知识，包括代数数、代数整数、模的定义、子模、模同态以及相关性质等内容。

# 模的基本知识

## 代数数和代数整数

**Definition**（代数数）
一个复数$\alpha$是代数数，如果存在非零多项式$f(x) \in \mathbb{Q}[x]$使得$f(\alpha)=0$。等价地，存在首一多项式 $f(x)\in \mathbb{Q}[x]$使得$f(\alpha)=0$。

**Definition**（代数整数）
一个复数$\alpha$是代数整数，如果存在首一多项式 $f(x)\in \mathbb{Z}[x]$使得$f(\alpha)=0$。

**Definition**（极小多项式）
设$\alpha$是代数数，$\alpha$的极小多项式是首一多项式$m_\alpha(x) \in \mathbb{Q}[x]$，满足：
1. $m_\alpha(\alpha) = 0$
2. $m_\alpha(x)$是满足条件1的最小次数的多项式
3. $m_\alpha(x)$在$\mathbb{Q}[x]$中不可约

**Proposition**（代数整数的等价条件）
$\alpha$ 为代数整数 $\iff$ $\alpha$的极小多项式$m_\alpha(x) \in \mathbb{Z}[x]$

**Definition**（二次域）
设$d\in \mathbb{Z}$，$d$是无平方因子数（square-free），即$d$不能被任何大于1的完全平方数整除。定义二次域$K=\mathbb{Q}[\sqrt{d}]$。

**Example**（二次整数环）
对于二次域$K=\mathbb{Q}[\sqrt{d}]$，其代数整数环$\mathcal{O}_K$为：
- 当$d \equiv 2,3 \pmod{4}$时，$\mathcal{O}_K = \mathbb{Z}[\sqrt{d}] = \{a+b\sqrt{d} : a,b \in \mathbb{Z}\}$
- 当$d \equiv 1 \pmod{4}$时，$\mathcal{O}_K = \mathbb{Z}[\frac{1+\sqrt{d}}{2}] = \{a+b\frac{1+\sqrt{d}}{2} : a,b \in \mathbb{Z}\}$

**Proposition**（代数整数环的性质）
代数整数的集合在加法和乘法下封闭，形成一个环，记作$\mathbb{A} \cap \mathbb{C}$（或$\overline{\mathbb{Z}}$）。


## 模

**Definition**（左$R$-模）
设$R$是有单位元$1_R$的环，$M$是一个阿贝尔群（加法记号）。若给定一个标量乘法映射$R\times M\to M$，记作$(r,m) \mapsto rm$，满足对所有$r,r_1,r_2 \in R$，$m,m_1,m_2 \in M$：

1.  $(r_1+r_2)m=r_1m+r_2m$（环加法对模作用的分配律）
2.  $(r_1r_2)m=r_1(r_2m)$（环乘法对模作用的结合律）
3.  $1_R m=m$（单位元作用的单位性）
4.  $r(m_1+m_2)=rm_1+rm_2$（群加法对模作用的分配律）

则称$M$是一个左$R$-模。

**注记**：
- 如果$R$是交换环，左$R$-模和右$R$-模本质上相同
- 条件1和4表明标量乘法是阿贝尔群的自同态
- 条件2确保环的乘法结构与标量乘法兼容

**Definition**（右$R$-模）
类似地，右$R$-模是满足相应条件的阿贝尔群，其中标量乘法是$M \times R \to M$，$(mr)r' = m(rr')$等。

**Proposition**（模的基本性质）：
设$M$是左$R$-模，则：
1. $0_R m = 0_M$ 对所有 $m \in M$
2. $r 0_M = 0_M$ 对所有 $r \in R$
3. $(-r)m = -(rm) = r(-m)$ 对所有 $r \in R, m \in M$
4. 如果$R$有单位元$1$，则$(-1)m = -m$

*Proof.*
1. $0_R m = (0_R + 0_R)m = 0_R m + 0_R m$，两边加上$-(0_R m)$得$0_M = 0_R m$
2. $r 0_M = r(0_M + 0_M) = r 0_M + r 0_M$，两边加上$-(r 0_M)$得$0_M = r 0_M$
3. $(-r)m + rm = ((-r) + r)m = 0_R m = 0_M$，所以$(-r)m = -(rm)$
   类似地，$r(-m) + rm = r((-m) + m) = r 0_M = 0_M$，所以$r(-m) = -(rm)$
4. $(-1)m = -(1m) = -m$


**Example**（模的例子）
1. 任何环$R$都是左$R$-模（通过环乘法）
2. 任何阿贝尔群$G$都是$\mathbb{Z}$-模（通过$n \cdot g = ng$，其中$ng$是$g$的$n$倍）
3. 如果$R$是域$F$，则$R$-模就是$F$-向量空间
4. 如果$R = M_n(F)$是$n \times n$矩阵环，则$R$-模是$F^n$上的线性变换

**Definition**（子模）
设$M$是一个$R$-模，$N$是$M$的一个子集。如果$N$满足：
1. $N$是$(M,+)$的子群（即对加法封闭，包含零元，且每个元素有加法逆元）
2. 对任意$r \in R$，$n \in N$，有$rn \in N$（对$R$的标量乘法封闭）

则称$N$是$M$的一个子模。

**Proposition**（子模的判定准则）
设$M$是$R$-模，$N \subseteq M$非空。则$N$是子模当且仅当对任意$r \in R$，$n_1, n_2 \in N$，有$n_1 - n_2 \in N$且$rn_1 \in N$。

**Example**（子模的例子）
1. $R$的子模正好是$R$的理想
2. 如果$M$是$F$-向量空间（$F$是域），则$M$的子模就是$M$的子空间
3. $\mathbb{Z}$-模$M$的子模就是$M$的子群（因为$\mathbb{Z}$-模结构自动保持）


**Definition**（模同态）
设$M,N$是$R$-模，$\varphi:M\to N$是一个映射。如果$\varphi$满足：
1. $\varphi(a+b)=\varphi(a)+\varphi(b)$（加法同态）
2. $\varphi(ra)=r\varphi(a)$（与标量乘法兼容）

对所有$a,b \in M$，$r \in R$成立，则称$\varphi$是$R$-模同态。

**Definition**（特殊的模同态）
设$\varphi: M \to N$是$R$-模同态：
- 如果$\varphi$是单射，则称$\varphi$为单同态
- 如果$\varphi$是满射，则称$\varphi$为满同态
- 如果$\varphi$是双射，则称$\varphi$为同构
- 如果$M=N$，则称$\varphi$为自同态
- 如果$M=N$且$\varphi$是同构，则称$\varphi$为自同构

**Definition**（核与像）
设$\varphi: M \to N$是$R$-模同态，则：
- $\ker(\varphi) = \{m \in M : \varphi(m) = 0\}$称为$\varphi$的核
- $\operatorname{im}(\varphi) = \{\varphi(m) : m \in M\}$称为$\varphi$的像

**Proposition**（模同态的核与像）
设$\varphi: M \to N$是$R$-模同态，则：
1. $\ker(\varphi)$是$M$的子模
2. $\operatorname{im}(\varphi)$是$N$的子模

*Proof.*
1. 设$a,b \in \ker(\varphi)$，$r \in R$。则$\varphi(a-b) = \varphi(a) - \varphi(b) = 0 - 0 = 0$，所以$a-b \in \ker(\varphi)$。又$\varphi(ra) = r\varphi(a) = r \cdot 0 = 0$，所以$ra \in \ker(\varphi)$。因此$\ker(\varphi)$是子模。

2. 设$x,y \in \operatorname{im}(\varphi)$，$r \in R$。则存在$a,b \in M$使得$\varphi(a) = x$，$\varphi(b) = y$。于是$x-y = \varphi(a)-\varphi(b) = \varphi(a-b) \in \operatorname{im}(\varphi)$，且$rx = r\varphi(a) = \varphi(ra) \in \operatorname{im}(\varphi)$。因此$\operatorname{im}(\varphi)$是子模。


**Definition**（由子集生成的子模）
设$M$是$R$-模，$X \subseteq M$是子集。所有包含$X$的$M$的子模的交称为由$X$生成的子模，记作$RX$或$\langle X \rangle$。

**Proposition**（生成子模的显式描述）
设$M$是$R$-模，$X \subseteq M$。则：
$$RX = \left\{ \sum_{i=1}^n r_ix_i : r_i \in R, x_i \in X, n \in \mathbb{N} \right\}$$

*Proof.*
设$S = \{ \sum_{i=1}^n r_ix_i : r_i \in R, x_i \in X, n \in \mathbb{N} \}$。首先验证$S$是子模：
- 封闭性：$\sum r_ix_i + \sum s_jy_j = \sum r_ix_i + \sum s_jy_j \in S$
- 标量乘法：$r(\sum s_ix_i) = \sum (rs_i)x_i \in S$
- 包含$X$：对任意$x \in X$，$x = 1 \cdot x \in S$

显然$S$包含在任何包含$X$的子模中，所以$S$是包含$X$的最小子模，即$S = RX$。

**Definition**（有限生成模）
如果存在有限集合$X = \{x_1, \ldots, x_n\}$使得$M = RX$，则称$M$是有限生成的$R$-模。

**Definition**（循环子模）
如果$N = Rx$对某个$x \in M$，则称$N$是循环子模。


**Theorem**（模的同构定理）
令$N$为$R$-模$M$的子模。

(a) **第一同构定理**：设$\varphi: M \to L$是$R$-模同态，则$M/\ker(\varphi) \cong \operatorname{im}(\varphi)$。

*Proof.* 定义$\bar{\varphi}: M/\ker(\varphi) \to \operatorname{im}(\varphi)$为$\bar{\varphi}(m + \ker(\varphi)) = \varphi(m)$。
- 良定义性：如果$m + \ker(\varphi) = m' + \ker(\varphi)$，则$m - m' \in \ker(\varphi)$，所以$\varphi(m-m') = 0$，即$\varphi(m) = \varphi(m')$。
- 同态性：$\bar{\varphi}((m_1 + \ker(\varphi)) + (m_2 + \ker(\varphi))) = \bar{\varphi}((m_1+m_2) + \ker(\varphi)) = \varphi(m_1+m_2) = \varphi(m_1) + \varphi(m_2) = \bar{\varphi}(m_1 + \ker(\varphi)) + \bar{\varphi}(m_2 + \ker(\varphi))$。
- 标量乘法：$\bar{\varphi}(r(m + \ker(\varphi))) = \bar{\varphi}(rm + \ker(\varphi)) = \varphi(rm) = r\varphi(m) = r\bar{\varphi}(m + \ker(\varphi))$。
- 单射性：$\bar{\varphi}(m + \ker(\varphi)) = 0$当且仅当$\varphi(m) = 0$当且仅当$m \in \ker(\varphi)$当且仅当$m + \ker(\varphi) = 0$。
- 满射性：对任意$y \in \operatorname{im}(\varphi)$，存在$m \in M$使得$\varphi(m) = y$，所以$\bar{\varphi}(m + \ker(\varphi)) = y$。

(b) **对应定理**：$M$中包含$N$的子模与$M/N$的子模之间存在一一对应关系。具体地，如果$K$是包含$N$的$M$的子模，则$K/N$是$M/N$的子模；反之，$M/N$的每个子模都形如$K/N$，其中$K$是包含$N$的$M$的子模。

(c) **第二同构定理**：设$S,T$是$M$的子模，则$(S+T)/T \cong S/(S \cap T)$。

*Proof.* 定义$\varphi: S \to (S+T)/T$为$\varphi(s) = s + T$。
- 这是模同态：$\varphi(s_1+s_2) = (s_1+s_2) + T = (s_1+T) + (s_2+T) = \varphi(s_1) + \varphi(s_2)$
- 标量乘法：$\varphi(rs) = rs + T = r(s + T) = r\varphi(s)$
- 满射性：对任意$(s+t) + T \in (S+T)/T$（其中$s \in S, t \in T$），有$(s+t) + T = s + T = \varphi(s)$
- $\ker(\varphi) = \{s \in S : s + T = T\} = \{s \in S : s \in T\} = S \cap T$

由第一同构定理，$S/\ker(\varphi) = S/(S \cap T) \cong \operatorname{im}(\varphi) = (S+T)/T$。

(d) **第三同构定理**：设$N \subseteq K \subseteq M$，其中$N,K$都是$M$的子模，则$(M/N)/(K/N) \cong M/K$。

*Proof.* 定义$\varphi: M/N \to M/K$为$\varphi(m+N) = m+K$。
- 良定义性：如果$m+N = m'+N$，则$m-m' \in N \subseteq K$，所以$m+K = m'+K$。
- 这是满同态：显然$\varphi$是满射。
- $\ker(\varphi) = \{m+N : m+K = K\} = \{m+N : m \in K\} = K/N$

由第一同构定理，$(M/N)/(K/N) = (M/N)/\ker(\varphi) \cong \operatorname{im}(\varphi) = M/K$。


## 直和，直积

**Definition**（模的直积）
设$\{M_i\}_{i \in I}$是一族$R$-模。它们的直积定义为：
$$\prod_{i\in I} M_i = \{(m_i)_{i\in I} : m_i \in M_i \text{ 对所有 } i \in I\}$$
其上的$R$-模结构定义为：
- 加法：$(m_i) + (n_i) = (m_i + n_i)$
- 标量乘法：$r(m_i) = (rm_i)$

**Definition**（模的直和）
设$\{M_i\}_{i \in I}$是一族$R$-模。它们的直和定义为：
$$\bigoplus_{i\in I} M_i = \{(m_i)_{i\in I} : m_i \in M_i \text{ 且只有有限个 } m_i \text{ 不为 } 0\}$$
其上的$R$-模结构与直积相同。

**注记**：
- 当索引集$I$是有限集时，直积和直和相同：$\prod_{i=1}^n M_i = \bigoplus_{i=1}^n M_i$
- 当$I$是无限集时，直和是直积的子模

**Proposition**（直和的泛性质）
设$\{M_i\}_{i \in I}$是一族$R$-模，$N$是另一个$R$-模。
1. 对每个$j \in I$，存在自然嵌入$\iota_j: M_j \to \bigoplus_{i \in I} M_i$，定义为$\iota_j(m_j) = (m_i)_{i \in I}$，其中$m_i = 0$当$i \neq j$，$m_j = m_j$
2. 对任意一族同态$\{\varphi_i: M_i \to N\}_{i \in I}$，存在唯一的同态$\varphi: \bigoplus_{i \in I} M_i \to N$使得对所有$i \in I$，$\varphi \circ \iota_i = \varphi_i$

**Proposition**（直积的泛性质）
设$\{M_i\}_{i \in I}$是一族$R$-模，$N$是另一个$R$-模。
1. 对每个$j \in I$，存在自然投影$\pi_j: \prod_{i \in I} M_i \to M_j$，定义为$\pi_j((m_i)_{i \in I}) = m_j$
2. 对任意一族同态$\{\varphi_i: N \to M_i\}_{i \in I}$，存在唯一的同态$\varphi: N \to \prod_{i \in I} M_i$使得对所有$i \in I$，$\pi_i \circ \varphi = \varphi_i$

**Definition**（内部直和）
设$M$是$R$-模，$\{N_i\}_{i \in I}$是$M$的一族子模。如果每个$m \in M$都能唯一地写成$m = \sum_{i \in I} n_i$（其中$n_i \in N_i$且几乎所有的$n_i = 0$），则称$M$是子模$\{N_i\}$的内部直和，记作$M = \bigoplus_{i \in I} N_i$。

**Proposition**（内部直和的判定）
设$\{N_i\}_{i \in I}$是$R$-模$M$的子模族，则$M = \sum_{i \in I} N_i$是内部直和当且仅当：
1. $M = \sum_{i \in I} N_i$（生成性）
2. 对任意有限子集$J \subseteq I$，如果$\sum_{j \in J} n_j = 0$（其中$n_j \in N_j$），则对所有$j \in J$，$n_j = 0$




## 模的例子

**Example**（向量空间）
如果$R = F$是域，则$R$-模就是$F$-向量空间。在这种情况下，子模就是子空间，模同态就是线性变换。

**Example**（阿贝尔群）
$\mathbb{Z}$-模与阿贝尔群是一一对应的。任何阿贝尔群$G$都可以看作$\mathbb{Z}$-模，其中$n \cdot g$（$n \in \mathbb{Z}, g \in G$）定义为$g$的$n$倍（当$n > 0$时）或$g$的$|n|$倍的逆元（当$n < 0$时）。

**Example**（理想作为模）
如果$I$是环$R$的理想，则$I$是$R$-模（通过环乘法）。

**Example**（商环作为模）
如果$I$是环$R$的理想，则商环$R/I$是$R$-模，其中$R$通过$R \to R/I$的自然投影作用在$R/I$上。

**Example**（矩阵模）
设$R = M_n(F)$是$F$上$n \times n$矩阵环，则$F^n$是左$R$-模，其中矩阵与列向量相乘。

[← Unique Factorization](/posts/algebra2/unique-factorization/) | [Structure of Finitely Generated Modules →](/posts/algebra2/finitely-generated-modules/)

