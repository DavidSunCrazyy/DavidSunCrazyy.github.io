---
layout: post
title: "Differential Geometry 光滑流形 (Smooth Manifolds)"
permalink: /posts/differential-geometry-02-smooth-manifolds/
tags: differential-geometry
use_math: true
---

本文档在拓扑流形的基础上引入光滑结构。首先建立微分的定义和光滑性层次（$C^k$、$C^\infty$），然后定义光滑流形和微分同胚的概念。重点介绍最大图集的唯一性存在性，以及光滑坐标卡之间的相容性条件。详细讨论可定向性理论，包括保向映射、定向图集和定向流形的刻画。通过球面$S^n$和实射影空间$\mathbb{R}P^n$的例子说明光滑结构的构造方法，最后介绍Grassmann流形作为重要的例子。

---

## 微分和光滑性基础

### 微分的定义

设 $U\subset W$ 是向量空间 $W$ 中的开集，$f:U\to V$ 是映射。

**可微性**：$f$ 在 $p\in U$ 处可微，如果存在线性映射 $Df(p):W\to V$ 使得：

$$\lim_{x\to 0}\frac{f(p+x)-f(p)-Df(p)(x)}{\\|x\\|} = 0$$

**重要性质**：
1. $Df(p)$ 是唯一的
2. $Df(p)$ 可以表示为雅可比矩阵 (Jacobian ma$trix)
3. $Df:U\to \text{Hom}(W,V)$，$p\mapsto Df(p)$

### 光滑性层次

- **$C^1$**：连续可微，$Df$ 连续
- **$C^k$**：$k$ 次连续可微，存在连续的 $D^kf$
- **$C^\infty$ (光滑)**：对所有 $k$，$f\in C^k$

$$C^\infty(U,V) = \bigcap_{k\geq 0} C^k(U,V)$$

---

## 光滑流形的定义

### 光滑图集

**定义**：图集 $\mathcal{A} = \\{(U_i, \varphi_i)\\}\_{i\in I}$ 是**光滑的**，如果所有粘合映射

$$\varphi_{ij} = \varphi_j \circ \varphi_i^{-1}|_{\varphi_i(U_{ij})}$$

都是光滑的（即微分同胚）

**光滑相容**：两个坐标卡 $(U_1,\varphi_1)$、$(U_2,\varphi_2)$ 是光滑相容的，如果

$$\varphi_2 \circ \varphi_1^{-1}|_{\varphi_1(U_1\cap U_2)}$$

是微分同胚

**光滑流形**：具有光滑坐标卡等价类的拓扑流形

---

## 最大图集

### 定义和性质

**最大图集** (Maximal atlas)：光滑图集 $\tilde{\mathcal{A}}$ 不真包含于任何其他光滑图集中

**命题**：
1. 每个光滑图集 $\mathcal{A}$ 都包含在唯一的最大图集 $\tilde{\mathcal{A}}$ 中
2. $\mathcal{A}\_1$ 和 $\mathcal{A}\_2$ 包含在同一个最大图集中当且仅当 $\mathcal{A}\_1\cup\mathcal{A}\_2$ 是光滑图集

---

## 可定向性 (Orientability)

### 基本定义

**保向线性变换**：$A:\mathbb{R}^n\to\mathbb{R}^n$ 称为保向的，如果 $\det A > 0$

**保向映射**：$f:U\to V$ 是保向的，如果 $\forall p\in U$，$\det Df(p) > 0$

**光滑定向相容**：$(U,\varphi)$ 和 $(V,\psi)$ 是光滑定向相容的，如果 $\psi\circ\varphi^{-1}$ 是保向的

**定向图集**：所有坐标卡都定向相容的光滑图集

### 可定向流形

**可定向**：流形容许定向图集

**定向**：选择了定向图集的流形

**相反定向**：设 $(M,\mathcal{A})$ 是定向流形，$R:\mathbb{R}^n\to\mathbb{R}^n$，$(x_1,\ldots,x_n)\mapsto(x_1,\ldots,-x_n)$
则 $\bar{\mathcal{A}} = \\{(U_\alpha,R\circ\varphi_\alpha)\\}$ 是定向图集，$(M,\bar{\mathcal{A}})$ 具有相反定向

### 命题

设 $(M,\mathcal{A})$ 是定向的，$(U,\varphi)$ 是与 $\mathcal{A}$ 相容的连通坐标卡，则 $(U,\varphi)$ 与 $\mathcal{A}$ 或 $\bar{\mathcal{A}}$ 定向相容

---

## 重要例子

### 1. 球面 $S^n$ 是光滑流形

使用球极投影坐标卡：
- 豪斯多夫性：$S^2\subset$\mathbb{R}^3$ 继承豪斯多夫性
- 第二可数性：$\mathbb{R}^3$ 具有可数基
- 光滑相容性：转移映射

$$\phi_S \circ \phi_N^{-1}(u,v) = \left(\frac{u}{u^2+v^2},\frac{v}{u^2+v^2}\right)$$

在 $\mathbb{R}^2\setminus\\{(0,0)\\}$ 上是光滑的微分同胚

### 2. 实射影空间 $\mathbb{R}P^n$ 是光滑流形

### 3. 实 Grassmann 流形 (Real Grassmann Manifold)

**定义**：$G(k,n)$ 是 $\mathbb{R}^n$ 的所有 $k$ 维子空间的集合

**命题**：$G(k,n)$ 是 $k(n-k)$ 维光滑流形

---

## 关键概念总结

\| 概念 \| 英文 | 说明 |
|------|------|------|
| 可微 | Differentiable | 存在线性映射 $Df(p)$ \|
\| 光滑 | Smooth ($C^\infty$) \| 任意次连续可微 \|
| 微分同胚 | Diffeomorphism | 光滑同胚，逆也光滑 |
| 光滑图集 | Smooth atlas | 粘合映射光滑 |
| 最大图集 | Maximal atlas | 不真包含于其他图集 |
| 可定向 | Orientable | 容许定向图集 |
| 保向 | Orientation-preserving | $\det > 0$ \|
\| Grassmann流形 | Grassmann manifold | $\mathbb{R}^n$ 的 $k$ 维子空间集合 |

---

## 本章要点

1. **光滑性**：$C^\infty$ 意味着任意次连续可微
2. **微分同胚**比**同胚**更强：需要光滑且逆也光滑
3. **最大图集**是光滑结构的完整描述
4. **可定向性**是流形的重要性质，与体积形式的定义相关
5. **Grassmann流形**提供了重要的例子，包括射影空间

### 可定向性总结

- $S^n$：可定向
- $\mathbb{R}P^n$：当 $n$ 为奇数时可定向，$n$ 为偶数时不可定向
