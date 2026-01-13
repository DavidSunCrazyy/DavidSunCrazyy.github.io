---
layout: post
title: "微分几何 第5章：切空间 (Tangent Spaces)"
permalink: /posts/differential-geome$try-05-tangent-spaces/
tags: differential-geome$try
use_math: true
---

本文档引入切空间的核心概念，这是理解流形上微积分的基础。给出切向量的三种等价定义：曲线表示、偏导数表示和莱布尼茨法则刻画。证明切空间的维数定理，说明 $\dim T_pM = \dim M$。详细介绍切丛的构造和性质，说明其作为向量丛的结构。研究切映射（诱导映射）的性质和链式法则，给出局部坐标下的雅可比矩阵表示。最后介绍李代数的概念，说明李括号的封闭性。

---

## 切空间的定义

### 核心问题

给定光滑映射 $F:M^m\to N^n$，$DF$ 是什么？
- $DF$ 的定义域或值域是什么？
- 对于 $f:M\to\mathbb{R}$，$df$ 是什么？

### 定义：切向量

**切空间** $T_pM$：在点 $$p\in M$$ 处的切向量是满足以下条件的线性泛函 $v:C^\infty(M)\to\mathbb{R}$ 的集合：

$$\vec{v}(f) = \frac{d}{dt}\bigg|_{t=0} f(\gamma(t))$$

对于某条曲线 $\gamma:I\to M$，$\gamma(0)=p$

### 切空间的维数定理

**定理**：$T_pM$ 是有限维向量空间，且 $\dim T_pM = \dim M$

**证明要点**：
1. 在局部坐标下，$\vec{v}(f) = \sum_{i=1}^n a_i \frac{\partial f}{\partial x_i}\bigg\|\_{\varphi(p)}$
2. 可以将 $v$ 视为 $\operatorname{span}\_\mathbb{R}\\{\partial/\partial x_1,\ldots,\partial/\partial x_n\\}$ 中的元素

---

## 三种等价定义

### 1. 曲线表示

$$\vec{v}(f) = \frac{d}{dt}\bigg|_{t=0} f(\gamma(t))$$

对于某条曲线 $\gamma$，$\gamma(0)=p$

### 2. 偏导数表示

在局部坐标卡中：

$$\vec{v}(f) = \sum_i a_i \frac{\partial}{\partial x_i} f\bigg|_{\varphi(p)} = \nabla f \cdot \vec{a}$$

### 3. 莱布尼茨法则 (Leibniz Rule)

线性映射 $v:C^\infty(M)\to\mathbb{R}$ 满足：

$$\vec{v}(fg) = \vec{v}(f) \cdot g(p) + f(p) \cdot \vec{v}(g)$$

**定理**：给定线性映射 $v:C^\infty(M)\to\mathbb{R}$，

$\vec{v} \in T_pM \iff \vec{v} \text{ 满足乘积法则}$

---

## 坐标变换

### 推论：坐标变换公式

设 v$\\in $T_pM，(U,$\\varphi$)、(V,$\\psi$) 是两个坐标卡，则：

$$\vec{v}(f) = \sum_i a_i \frac{\partial}{\partial x_i}\tilde{f}\\|_{\varphi(p)} = \sum_j b_j \frac{\partial}{\partial y_j}\hat{f}\\|_{\psi(p)}$$

其中：

$$b_j = \sum_{i=1}^n \frac{\partial y_j}{\partial x_i} a_i$$

---

## 切丛 (Tangent Bundle)

### 定义和构造

**切丛**  
$ TM = \bigsqcup_{p \in M} T_pM $，  
投影映射 $ \pi: TM \to M $，满足 $ v \in T_pM \mapsto p $。

**光滑结构**：通过坐标卡 $ (U_i, \varphi_i) $ 构造  
- 映射 $ \Phi: \pi^{-1}(U) \to U \times \mathbb{R}^n \to \varphi(U) \times \mathbb{R}^n $，  
- 具体地，$ v \in T_pM \mapsto (p, a) \mapsto (\varphi(p), a) $。

**命题**：$ (TM, \pi) $ 是一个纤维丛，且 $ \pi $ 是光滑映射。

---

## 诱导映射

### 切映射 (Tangent Map)

设 $ F: M \to N $ 为光滑映射。在局部坐标下，$ F $ 由  
$$
\psi_\alpha \circ F \circ \varphi_i^{-1}
$$  
给出。

**诱导映射** $ DF: TM \to TN $ 满足如下交换图：

```
TM --DF--> TN
|          |
π          π
|          |
M ---F---> N
```

**局部表达式**（即 $ TF $）：  
若局部表示 $ f_{i\alpha} $ 为  
$$
(x_1, \dots, x_m) \mapsto (y_1, \dots, y_n),
$$  
则其切映射作用为：
$$
(Df_{i\alpha})(p) \cdot 
\begin{pmatrix}
a_1 \\ \vdots \\ a_m
\end{pmatrix}
=
\begin{pmatrix}
\frac{\partial y_1}{\partial x_1} & \cdots & \frac{\partial y_1}{\partial x_m} \\
\vdots & \ddots & \vdots \\
\frac{\partial y_n}{\partial x_1} & \cdots & \frac{\partial y_n}{\partial x_m}
\end{pmatrix}
\cdot
\begin{pmatrix}
a_1 \\ \vdots \\ a_m
\end{pmatrix}.
$$

### 链式法则

**命题**：若 $ h = f \circ g $ 是光滑映射，则  
$$
Df \circ Dg = Dh.
$$

---

## 正则值和临界点

### 定义

设 $ f: M \to N $ 为光滑映射：

- $ q \in N $ 是 **正则值**：若对所有 $ p \in f^{-1}(q) $，切映射 $ T_p f $ 是满射；
- $ q \in N $ 是 **临界值**：若存在 $ p \in f^{-1}(q) $ 使得 $ T_p f $ 不是满射；
- $ p \in M $ 是 **临界点**：若 $ T_p f $ 不具有最大秩；
- $ p \in M $ 是 **正则点**：否则。

### 命题：正则值的切空间

设 $ F: M^m \to N^n $ 光滑，且 $ q \in N $ 是正则值（其中 $ m \geq n $）。令  
$$
S = F^{-1}(q),
$$  
则 $ S \subset M $ 是一个余维数为 $ n $ 的子流形，且对任意 $ p \in S $，有  
$$
T_p S = \ker(T_p F) \subseteq T_p M.
$$

---

## 李代数 (Lie Algebra)

### 矩阵李群

**定义**：若李群 $ G $ 是 $ M(n, \mathbb{R}) $ 的子流形，则称 $ G $ 为 **矩阵李群**。

**李代数**：  
$$
\mathfrak{g} = T_I G,
$$  
即 $ G $ 在单位元 $ I $ 处的切空间。

### 李括号

**命题**：若 $ X, Y \in \mathfrak{g} $，则  
$$
[X, Y] = XY - YX \in \mathfrak{g}.
$$

**证明要点**：考虑共轭作用 $ \lambda(t) X \lambda(t)^{-1} \in \mathfrak{g} $，对其关于 $ t $ 求导（在 $ t=0 $ 处），可得 $ [Y, X] = YX - XY \in \mathfrak{g} $。

---

## 重要例子

### 1. $ \mathrm{GL}(n, \mathbb{R}) $

- $ G = \mathrm{GL}(n, \mathbb{R}) $（所有可逆 $ n \times n $ 实矩阵）是 $ M(n, \mathbb{R}) $ 中的开子集；
- 李代数：  
  $$
  \mathfrak{gl}(n, \mathbb{R}) = M(n, \mathbb{R}).
  $$

### 2. $ \mathrm{O}(n, \mathbb{R}) $（正交群）

- 定义：  
  $$
  \mathrm{O}(n, \mathbb{R}) = \{ A \in M(n, \mathbb{R}) \mid A^\top A = I \}.
  $$
- 考虑光滑映射  
  $$
  F: M(n, \mathbb{R}) \to \mathrm{Sym}(n, \mathbb{R}), \quad A \mapsto A^\top A.
  $$
- 切映射在单位元处为：  
  $$
  T_I F(X) = X^\top + X.
  $$
- 李代数：  
  $$
  \mathfrak{o}(n, \mathbb{R}) = \ker(T_I F) = \{ X \in M(n, \mathbb{R}) \mid X^\top + X = 0 \},
  $$  
  即所有反对称矩阵。

---

## 关键概念总结

| 概念         | 英文             | 符号                | 说明                             |
|--------------|------------------|---------------------|----------------------------------|
| 切空间       | Tangent Space    | $ T_p M $         | 点 $ p $ 处切向量的集合         |
| 切向量       | Tangent Vector   | $ v $             | 满足莱布尼茨法则的线性泛函       |
| 切丛         | Tangent Bundle   | $ TM $            | 所有切空间的不交并               |
| 切映射       | Tangent Map      | $ DF,\, TF $      | 由光滑映射诱导的切丛间映射       |
| 李代数       | Lie Algebra      | $ \mathfrak{g} = T_I G $ | 李群在单位元处的切空间         |
| 李括号       | Lie Bracket      | $ [X, Y] $        | 定义为 $ XY - YX $             |


---

## 本章要点

1. **切空间**的三种等价定义，各有用途
2. **切丛** $TM$ 是流形上的重要向量丛
3. **切映射** $DF$ 提供了光滑映射的线性化
4. **李代数** 是李群在单位元处的切空间，李括号保持封闭
5. **正则值**的切空间是原切空间的子空间
