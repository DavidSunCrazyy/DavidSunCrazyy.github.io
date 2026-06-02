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

**Definition**（由子集生成的子模）
设$R$为环，$M$为$R$-模，设$S$为$M$的任意非空子集，下列所有的有限和 $$\sum_{x\in S} a_x x,a_x\in R$$ 其中只有有限多个$a_x$不为$0$ 为由$S$生成的子模，记作$RS$或$\langle S \rangle$。

**Definition**（线性无关与基）
设$M$是$R$-模，$S \subseteq M$。
- 称$S$是线性无关的，如果对于任意有限子集$\{x_1, \ldots, x_n\} \subseteq S$和任意$r_1, \ldots, r_n \in R$，如果$\sum_{i=1}^n r_i x_i = 0$，则$r_1 = \cdots = r_n = 0$。
- 称$S$是$M$的基，如果$S$是线性无关的且$RS = M$。

**Definition**（自由模）
如果$R$-模$M$有一个基，则称$M$是自由$R$-模。基的势（基数）称为$M$的秩。

**Example**（自由模的例子）
1. $R^n$是自由$R$-模，标准基为$\{e_1, \ldots, e_n\}$，其中$e_i$的第$i$个分量为$1$，其余为$0$。
2. $R^{(\Lambda)} = \{(r_\lambda)_{\lambda \in \Lambda} : r_\lambda \in R \text{ 且只有有限个 } r_\lambda \neq 0\}$是自由$R$-模，基为$\{e_\lambda : \lambda \in \Lambda\}$，其中$e_\lambda$的第$\lambda$个分量为$1$，其余为$0$。
3. 如果$R$是域，则$R$-模就是$R$-向量空间，自由$R$-模就是有限维向量空间。

**Proposition**（自由模的泛性质）
设$M$是自由$R$-模，$B$是$M$的基。对于任意$R$-模$N$和任意映射$f: B \to N$，存在唯一的$R$-模同态$\varphi: M \to N$使得$\varphi|_B = f$。

**Theorem**（自由模的刻画）
$R$-模$M$是自由的当且仅当$M$同构于某个$R^{(\Lambda)}$。


**Theorem**（PID上自由模的子模性质）
假设$R$是一个PID。

1. 自由$R$-模的每个子模都是自由的，且秩不超过原模的秩。

2. **（主理想定理）**
    - 如果$V$是秩为$n<\infty$的自由$R$-模，$W\subset V$是子模，则$W$是自由的且$\operatorname{rank} W = m\le n$。

    - 更进一步，存在$V$的基$\{v_1,\ldots,v_n\}$和$R$中的元素$\{b_1,\ldots,b_m\}$（$b_i \neq 0$）使得$\{b_1 v_1,\ldots,b_m v_m\}$是$W$的基，并且 $$b_1\mid b_2\mid \cdots \mid b_m$$

    这些$b_i$称为$W$在$V$中的不变因子。

*Proof.* （概要）
1. 设$M$是自由$R$-模，$N$是$M$的子模。使用Zorn引理证明$N$有基。设$\mathcal{S}$是$N$中线性无关子集的集合，按包含关系排序。每个全序子集有上界，所以$\mathcal{S}$有极大元$B$。可以证明$RB = N$。

2. 使用Smith标准型证明。通过适当的基变换，可以将包含映射$W \hookrightarrow V$表示为对角矩阵形式，对角线上元素满足整除关系。


**Corollary**
$V$是有限生成的，比如$V=\langle v_1,\ldots,v_m\rangle\to R^m\twoheadrightarrow^\pi V$


## 主理想整环上的有限生成模

**Definition**（有限生成模）
若$M$可以由有限个元素生成，则称$M$是有限生成的。即存在有限集$\{m_1, \ldots, m_n\} \subseteq M$使得$M = Rm_1 + \cdots + Rm_n$。

**Theorem**（PID上有限生成模的结构定理）
设$R$是一个PID，$V$是一个有限生成的$R$-模，则

1. **（不变因子形式）** 存在$b_1,\ldots,b_m\in R\setminus\{0\}$，满足$b_1\mid b_2\mid \cdots\mid b_m$，以及$n \geq 0$，使得 $$V\cong R/(b_1)\oplus \cdots \oplus R/(b_m) \oplus R^n$$ 此外，$\{(b_1)\supset \cdots \supset (b_m)\}$（不变因子）和$n$是唯一确定的。

2. **（初等因子形式）** 存在不可约元素$p_1,\ldots,p_t\in R$（不必互不相同）和正整数$\alpha_1, \ldots, \alpha_s$，使得 $$V\cong R/(p_1^{\alpha_1})\oplus \cdots \oplus R/(p_s^{\alpha_s}) \oplus R^k$$ 其中$k \geq 0$。这些$p_i^{\alpha_i}$（称为初等因子）和$k$是唯一确定的。

*Proof.* （概要）
通过选取适当的生成元和关系元，可以将模$V$表示为自由模的商：$V \cong R^n/K$，其中$K$是$R^n$的子模。由于$R$是PID，$K$是自由的，且存在适当的基使得包含映射$K \hookrightarrow R^n$可以用对角矩阵表示（Smith标准型），这就给出了结构定理。

**Theorem**（PID上有限生成模的挠分解）
如果$V$在PID $R$上是有限生成的，则 $$V\cong V_{\text{tors}} \oplus V_{\text{free}}$$ 其中$V_{\text{tors}} = \{v \in V : \exists r \neq 0, rv = 0\}$是挠子模，$V_{\text{free}} \cong R^k$是自由部分。

更具体地，$$V\cong R/(b_1)\oplus \cdots\oplus R/(b_l) \oplus R^k$$ 其中$\exists k\geq 0,l\geq 0$，$b_1\mid \cdots\mid b_l\in R \setminus\{0\}$，且每个$b_i$不是单位。

**Definition**（挠模和自由模）
设$M$是$R$-模：
- $M$的挠子模定义为 
 $$M_{\text{tors}} = \{m \in M : \exists r \in R\setminus\{0\}, rm = 0\}$$
- 如果$M_{\text{tors}} = M$，则称$M$是挠模
- 如果$M_{\text{tors}} = 0$，则称$M$是无挠模
- 如果$M$同构于某个自由模$R^{(\Lambda)}$，则称$M$是自由模


**Definition**（诺特环）
若$R$的每个理想都是有限生成的，则称$R$是诺特环。

**Definition**（诺特模）
设$R$为一个环。如果满足以下等价条件之一，则称$R$-模$V$是诺特$R$-模：

1.  $V$的每个$R$-子模都是有限生成的。

2.  对于任何$V_0\subset V_1\subset \cdots \subset V$，$R$-子模的升链条件(ACC)。$\exists n$使得$V_n=V_{n+1}=\cdots$

3.  $V$的$R$-子模的每个非空集合$\Sigma$包含一个最大元素。（关于包含关系）

**Proposition**（诺特模的等价条件）
这三个条件是等价的。

*Proof.*
$(1) \Rightarrow (2)$：设$V_0 \subseteq V_1 \subseteq \cdots$是$V$的子模升链。令$W = \cup_{i=0}^{\infty} V_i$，则$W$是$V$的子模，所以$W$是有限生成的。设$W = \langle w_1, \ldots, w_m \rangle$，每个$w_i$属于某个$V_{n_i}$。取$n = \max\{n_1, \ldots, n_m\}$，则$w_1, \ldots, w_m \in V_n$，所以$W \subseteq V_n$，从而$V_n = V_{n+1} = \cdots$。

$(2) \Rightarrow (3)$：设$\Sigma$是$V$的子模的非空集合。如果$\Sigma$没有最大元素，我们可以构造一个严格递增的升链：取$V_0 \in \Sigma$，由于$\Sigma$没有最大元素，存在$V_1 \in \Sigma$使得$V_0 \subsetneq V_1$。继续这个过程，得到严格递增的升链$V_0 \subsetneq V_1 \subsetneq \cdots$，这与(2)矛盾。

$(3) \Rightarrow (1)$：设$W$是$V$的任意子模。考虑$W$的所有有限生成子模的集合$\Sigma$。由于$\{0\} \in \Sigma$，$\Sigma$非空。由(3)，$\Sigma$有最大元素$W'$。如果$W' \neq W$，则存在$w \in W \setminus W'$，于是$W' + Rw$是包含$W'$的更大的有限生成子模，与$W'$的最大性矛盾。所以$W' = W$，即$W$是有限生成的。

**Definition**（诺特环的等价定义）
如果$R$作为$R$-模是诺特的，则称环$R$是诺特环。这等价于：
1. 每个理想都是有限生成的。
2. 理想的升链是稳定的。
3. 每个理想的非空集合关于$\subseteq$有一个最大元素。


**Example**（诺特环和诺特模的例子）
1.  $R=\mathbb{Z}$是诺特环，因为$\mathbb{Z}$是PID。$\mathbb{Z}/n$是诺特$\mathbb{Z}$-模。

2.  $R$是PID $\implies$ $R$是诺特环（因为每个理想都是主理想，所以有限生成）

3.  如果$R$是诺特环，则每个商环$R/I$是诺特环。

4.  $\mathbb{Z}^{\oplus \mathbb{N}}$不是诺特$\mathbb{Z}$-模，因为它不是有限生成的。

5.  $R=K[x_1,x_2,\ldots]$（多项式环在无限多个变量上）不是诺特环，因为理想$(x_1, x_2, \ldots)$不是有限生成的。

**Remark**
注意$R$是整环，$R\subset \mathrm{Frac} R$，而$\mathrm{Frac} R$是一个域，从而是诺特环。注意诺特环的子环可能不是诺特环。

**Proposition**（诺特环的性质）
设$R$是诺特环，则：

1.  每个有限生成的$R$-模是诺特$R$-模

2.  （Hilbert基定理）$R[x]$也是诺特环。

*Proof.*
1. 设$M$是有限生成的$R$-模，即$M = \langle m_1, \ldots, m_n \rangle$。则存在满同态$\varphi: R^n \to M$，$\varphi(e_i) = m_i$。由于$R$是诺特环，$R^n$是诺特模。由下面的短正合序列性质，$M \cong R^n/\ker(\varphi)$是诺特模。

2. 见后面Hilbert基定理的证明。


**Definition**（短正合序列）
$0\to M' \xrightarrow{f}  M \xrightarrow{g} M'' \to 0$ 是$R$-模的**短正合序列**，意思是$f,g$是$R$-线性映射，$f$是单射，$g$是满射，且$\mathrm{Im} f = \ker g$。

换句话说，$M'\subset M$，且$M/\mathrm{Im}(f) \xrightarrow{g,\sim} M''$。

**Proposition**（短正合序列与诺特性）
设$0\to M' \xrightarrow{f} M \xrightarrow{g} M'' \to 0$是$R$-模的短正合序列。则$M$是诺特的 $\iff$ $M'$和$M''$都是诺特的。

*Proof.*
($\Rightarrow$) 设$M$是诺特模。
- 对于$M'$：取$M'$的任意子模$N'$，则$f(N')$是$M$的子模，所以$f(N')$是有限生成的。由于$f$是单射，$N' \cong f(N')$，所以$N'$是有限生成的。
- 对于 $M''$ ：取 $M''$ 的任意子模$N''$，则$g^{-1}(N'')$是$M$的子模，所以$g^{-1}(N'')$是有限生成的。由于$N'' \cong g^{-1}(N'')/\ker(g\|_{g^{-1}(N'')}) = g^{-1}(N'')/M'$，而商模的有限生成性保持，所以 $N''$ 是有限生成的。

($\Leftarrow$) 设$M'$和 $M''$ 是诺特模。取$M$的升链$M_0\subset M_1\subset M_2 \subset \cdots$。
- 考虑升链$f^{-1}(M_0 \cap f(M')) \subset f^{-1}(M_1 \cap f(M')) \subset \cdots$，这是$M'$的子模升链，所以稳定。
- 考虑升链$g(M_0) \subset g(M_1) \subset \cdots$，这是 $M''$ 的子模升链，所以稳定。
- 由于$f$是单射，$g$是满射，且$\ker g = \mathrm{Im} f$，可以证明原升链也稳定。

**Corollary**
如果$M$是诺特$R$-模，则$M^n$是诺特的，且对任意子模$N\subset M^n$，商模$M^n/N$是诺特的。

特别地，如果$R$是诺特环，任何有限生成的$R$-模是诺特$R$-模。



**Theorem**（Hilbert基定理）
如果$R$是诺特环，则$R[x]$也是诺特环。

*Proof.* 设$J$是$R[x]$的任意理想。对于每个$d \geq 0$，定义
$$I_d = \{a_d \in R : \exists f(x) \in J, \text{ s.t. } f(x) = a_d x^d + a_{d-1} x^{d-1} + \cdots + a_0 \text{ 且 } a_d \neq 0\} \cup \{0\}$$
即$I_d$是$J$中所有次数不超过$d$的多项式的最高次系数构成的集合（加上0）。

容易验证$I_d$是$R$的理想，且$I_0 \subseteq I_1 \subseteq I_2 \subseteq \cdots$。

由于$R$是诺特环，存在$N$使得$I_N = I_{N+1} = \cdots$，且每个$I_d$都是有限生成的。

对每个$d = 0, 1, \ldots, N$，设$I_d = (a_{d,1}, \ldots, a_{d,k_d})$，并选择$J$中的多项式$f_{d,j}$，使得$f_{d,j}$的首项系数是$a_{d,j}$且次数为$d$。

我们断言$J = (f_{d,j} : 0 \leq d \leq N, 1 \leq j \leq k_d)$，即$J$由这些有限个多项式生成。

设$g \in J$，我们用归纳法证明$g$在由这些多项式生成的理想中。
设$\deg(g) = m$，如果$m > N$，则$g$的首项系数$a_m \in I_m = I_N$，所以$a_m$可以写成$a_m = \sum_{j=1}^{k_N} r_j a_{N,j}$。

构造$h = \sum_{j=1}^{k_N} r_j x^{m-N} f_{N,j}$，则$h \in J$且$h$的首项系数与$g$相同，次数也为$m$。
所以$g - h$的次数小于$m$，由归纳假设，$g-h$在生成理想中，因此$g = (g-h) + h$也在生成理想中。




## 有限生成模的例子

**Example**（有限生成模的例子）
1. **有限阿贝尔群**：有限阿贝尔群是$\mathbb{Z}$-模，根据结构定理，它可以分解为循环群的直和。例如，$\mathbb{Z}/n\mathbb{Z}$是有限生成的$\mathbb{Z}$-模。

2. **有限维向量空间**：如果$R = F$是域，则有限生成的$F$-模就是有限维$F$-向量空间。它们都是自由的，结构简单。

3. **有限生成的$\mathbb{Z}$-模**：根据结构定理，任何有限生成的$\mathbb{Z}$-模都同构于$\mathbb{Z}^r \oplus \mathbb{Z}/n_1\mathbb{Z} \oplus \cdots \oplus \mathbb{Z}/n_k\mathbb{Z}$的形式，其中$r \geq 0$是自由部分的秩，$n_i$是不变因子。

4. **理想**：如果$R$是PID，$I \subset R$是一个理想，则$I = (a)$是主理想，所以$I$是有限生成的$R$-模。

5. **有限生成的$K[x]$-模**：设$V$是域$K$上的有限维向量空间，$T: V \to V$是线性变换。则$V$成为$K[x]$-模，其中$x$作用为$T$。根据结构定理，$V$可以分解为循环子模的直和，这对应于线性变换的Jordan标准型理论。

[← Basic Properties of Modules](/posts/algebra2/module-basics/) | [Other Modules →](/posts/algebra2/more-modules/)

