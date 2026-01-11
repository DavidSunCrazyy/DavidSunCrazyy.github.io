---
layout: post
title: "Topology Seifert-Van Kampen theorem"
permalink: /posts/topology-seifert-van-kampen-theorem/
tags: topology
use_math: true
---

# Seifert-Van Kampen theorem

## 积的基本群

## <span style="color:blue">定理</span>

$$
    \pi_1(\bigsqcap_{\alpha\in S}X_\alpha, (x_\alpha)) = \bigsqcap_{\alpha\in S}\pi_1(X_\alpha,x_\alpha).
$$

**证明**：令 $\pi_\beta:\prod_{\alpha\in S}X_\alpha \to X_\beta$为投影映射。

由积空间的泛性质，有双射
$$
    \{\text{loops in } \prod_{\alpha\in S} X_\alpha \text{ based at } (x_\alpha)\}
    \leftrightarrow
    \prod_{\alpha\in S} \{\text{loops in } X_\alpha \text{ based at } X_\alpha\}
$$
由$\gamma\leftrightarrow (\pi_\alpha\circ \gamma)_{\alpha\in S}$给出。

再由泛性质

### <span style="color:darkgray">例</span>

$\pi_1(T^n)\cong \pi_1(S^1)\times \cdots \times \pi_1(S^1)\cong \mathbb{Z}^n$

### <span style="color:cyan">定义</span> [一点并 (one point union)]

令$\{X_\alpha,x_\alpha\}_{\alpha\in S}$为带点空间的族。则它们的**一点并**定义为
$$
    \bigvee_{\alpha\in S}X_\alpha := (\bigsqcup_{\alpha\in S}X_\alpha)/\sim
$$
其中$\sim$有$x_\alpha\sim x_\beta$对任意$\alpha,\beta$生成。而$\bigwedge_{\alpha\in S}X_\alpha$的基点取为$[x_\alpha]$

## 群的自由积

### <span style="color:cyan">定义</span> [单词 (word)]

令$\{G_\alpha\}_{\alpha\in S}$为群的族。作如下定义：
1. $\{G_\alpha\}_{\alpha\in S}$的**单词**定义为有限序列$(g_1,\cdots,g_n)$使得$g_i\in \bigsqcup_{\alpha\in S}G_\alpha$对任意$i$均成立。其中$n$称为该单词的**长度** (length)。

## <span style="color:violet">引理</span> [自由积的泛性质]

令$H$为群并令$\{f_\alpha:G_\alpha\to H\}_{\alpha\in S}$为群同态的族。则存在唯一的群同态
$$\bigast_{\alpha\in S}f_\alpha:\bigast_{\alpha\in S}G_\alpha\to H$$
使得如下交换图对任意$\beta\in S$成立
$$
    \begin{tikzcd}
        {\bigast_{\alpha\in S}G_\alpha} \\
        {G_\beta} & H
        \arrow["{\bigast_{\alpha\in S}f_\alpha}", from=1-1, to=2-2]
        \arrow["{i_\beta}", from=2-1, to=1-1]
        \arrow["{f_\beta}"', from=2-1, to=2-2]
    \end{tikzcd}
$$

### <span style="color:cyan">定义</span> [正规闭包]

令$A$为群$G$的子集。定义$A$在$G$中的**正规闭包 (normal closure)** $N_G(A)$ 为包含以下集合中有限个元素的积的子群
$$\{e\}\cup\{gag^{-1}:g\in G,a\in A\}\cup \{g a^{-1}g^{-1}:g\in A,a\in A\}$$
注意$N_G(A)$为所有包含$A$的$G$的正规子群的交。特别的，$N_G(A)$本身也是一个正规子群。

### <span style="color:cyan">定义</span>

给定集合$S$和自由群$F_S$的子集$R$，定义由关系$R$生成在$S$上的群为 (the group generated over $S$ with relation $R$) 一商群：
$$
    \langle S|R\rangle:=F_S/(N_{F_S}(R))
$$

### <span style="color:darkgray">例</span> [(1)]

1. $\langle a,b|aba^{-1}b^{-1}\rangle\cong \mathbb{Z}\oplus \mathbb{Z}$
2. $\langle a,b|a^2,b^2\rangle \cong \mathbb{Z}/2\ast \mathbb{Z}/2$
3. $\langle a,b| ab,aba\rangle\cong \{e\}$

### <span style="color:cyan">定义</span> [表示 (presentation)]

群$G$的一个**表示**为一同构$G\cong\langle S|R\rangle$对某些$S$以及$R$。若$S,R$均有限，称其为有限表示。$G$的阶是$S$的最小大小使得$G\cong\langle S|R\rangle$。称$G$为有限生成若阶是有限的，称$G$为有限表示的若其有有限表示。

## Seifert-Van Kampen 定理的证明

令$X$为拓扑空间，带有开覆盖$\bigcup_{\alpha\in S}A_\alpha$。假设$\bigcap_{\alpha\in S}A_\alpha\ne \emptyset$并且取一基点$x_0\in \bigcap_{\alpha\in S}A_\alpha$。对任意$\alpha,\beta\in S$，令
$$f_\alpha:\pi_1(A_\alpha,x_0)\to \pi_1(X,x_0)$$
为由$A_\alpha\hookrightarrow X$导出。
令
$$f_{\alpha,\beta}:\pi_1(A_\alpha\cap A_\beta,x_0)\to \pi_1(A_\alpha,x_0)$$
由$A_\alpha\cap A_\beta\hookrightarrow A_\alpha$导出。

## <span style="color:violet">引理</span>

考虑集合
$$
    B=\bigcup_{\beta,\beta'\in S}\{ f_{\beta,\beta'}(g)\cdot (f_{\beta',\beta}(g))^{-1}:g\in \pi_1(A_\beta\cap A_{\beta'},x_0)\}
$$
则$B\subset \ker(\bigast_{\alpha\in S}f_\alpha)$

## <span style="color:blue">定理</span> (Seifert-Van Kampen)

给定开覆盖$X=\bigcup_{\alpha\in A} A_\alpha$ 其中$\bigcap_\alpha A_\alpha\ne \emptyset$
选取$x_0\in \bigcap_\alpha A_\alpha$。则如下结论成立：
1. 假设$A_\alpha,A_\alpha\cap A_\beta$对任意$\alpha,\beta\in S$道路连通，则$\varphi$为满射。
2. 假设$A_\alpha,A_\alpha\cap A_\beta,A_\alpha \cap A_\beta \cap A_\gamma$对任意$\alpha,\beta,\gamma\in S$道路连通，则$\varphi$为同构。

## Seifert-Van Kampen定理的应用

### <span style="color:cyan">定义</span>

称一个点$x\in X$是"nice"的，若存在一$x$的开邻域$U$形变收缩到$x$。

### <span style="color:darkgray">例</span>

1. 所有流形上的点都是"nice"的。
2. Hawaiinn earring 中的原点不是 "nice" 的
   $$X:=\bigcup_{n\in \mathbb{N}^+} \{(x,y)\in \mathbb{R}^2:x^2+(y-\frac{1}{n})^2 = \frac{1}{n^2}\}$$

## <span style="color:olive">命题</span> [Wedge]

令$\{(X_\alpha,x_\alpha)\}_{\alpha\in S}$为带点空间的族。假设 $x_\alpha$ 对所有$\alpha$都是 "nice" 的
则
$$
    \pi_1(\bigvee_{\alpha\in S} X_\alpha, [x_\alpha]) \cong \bigast_{\alpha\in S} \pi_1(X_\alpha,x_\alpha)
$$

### <span style="color:darkgray">例</span>

1. $$\pi_1(\bigvee_n S^1) \cong F_n.$$