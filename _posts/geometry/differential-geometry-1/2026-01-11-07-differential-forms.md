---
layout: post
title: "Differential Geometry 微分形式 (Differential Forms)"
permalink: /posts/differential-geometry-07-differential-forms/
tags: differential-geometry
use_math: true
---

本文档系统介绍微分形式理论，这是de Rham上同调和积分理论的基础。首先定义余切空间和1-形式，说明其作为切空间对偶的性质。详细介绍外微分算子，证明其唯一性并满足$d^2=0$。引入楔积运算，建立微分形式的外代数结构。研究k-形式的性质和局部坐标表示。介绍内积算子$\iota_X$的性质。重点阐述Cartan魔法公式（$L_X = d·\iota_X + \iota_X·d$）及其应用，建立三个基本算子（d、$\iota_X$、$L_X$）之间的关系。最后给出超导数的六大基本关系。

---

## 余切空间和1-形式

### 余切空间 (Cotangent Space)

**定义**：$T_p^*M$ 是 $T_pM$ 的对偶空间，其元素称为**余向量** (covector)

**例子**：对于 $f:M\to\mathbb{R}$ 光滑，$df_p:T_pM\to\mathbb{R}$ 是线性的 $\Rightarrow$ $df_p\in T_p^*M$

### 余切丛 (Cotangent Bundle)

**定义**：$T^*M = \bigsqcup_{p\in M} T_p^*M$

**构造**：
- 局部平凡化：$(U_i\times V^*)$ 和粘合 $\psi_{ij}$
- $\psi_{ij}(x) = (D(\varphi_i\circ\varphi_j^{-1}))^\ast$

---

## 1-形式

### 定义

**1-形式**：$T^\ast M$ 的截面，记为 $\Omega^1(M) = \Gamma^\infty(M,T^\ast M)$

**性质**：$\alpha\in \Omega^1(M)$ 通过 $\alpha(X)\|\_p = \alpha_p(X_p)$ 作用于 $\Gamma^\infty(M,TM)$

### 外微分 (Exterior Derivative)

**定义**：对于 $f\in C^\infty(M)$，$df = p_2\circ Tf:TM\to\mathbb{R}$ 称为 f 的**外微分**

**局部表示**：在坐标 $\{u^i\}$ 下，$\{du^i\}$ 是 $\{\partial/\partial u^i\}$ 的对偶基
- $du^i(\partial/\partial u^j) = \delta_{ij}$
- $\alpha = \sum \alpha_i du^i$，其中 $\alpha_i = \alpha(\partial/\partial u^i)$

### 拉回 (Pullback)

**定义**：对于 $\beta\in \Omega^1(N)$，$F^\ast\beta = T^\ast F\circ\beta\circ F\in \Omega^1(M)$

**局部公式**：$F^\ast dy^i = \sum_j (\partial F^i/\partial x^j)dx^j$

---

## k-形式

### 2-形式

**定义**：**2-形式**是 $C^\infty(M)$-双线性、交错映射 $\omega:\mathfrak{X}(M)\times\mathfrak{X}(M)\to C^\infty(M)$

**楔积** (Wedge product)：

$$\alpha \wedge \beta(X,Y) = \alpha(X)\beta(Y) - \alpha(Y)\beta(X) = \det\begin{pmatrix}\alpha(X) & \alpha(Y)\\ \beta(X) & \beta(Y)\end{pmatrix}$$

### k-形式

**定义**：**k-形式**是 $C^\infty(M)$-多重线性、交错的

$$\alpha:\mathfrak{X}\times\cdots\times\mathfrak{X} \to C^\infty(M)$$

**空间**：$\Omega^k(M)$ 是所有 k-形式的空间

---

## 楔积 (Wedge Product)

### 基本定义

对于 1-形式 $\alpha_1,\ldots,\alpha_k$：

$$\alpha_1\wedge\cdots\wedge\alpha_k(x_1,\dots,x_k) = \det(\alpha_i(x_j))$$

### 性质

**命题**：
1. **反交换性**：$\alpha\wedge\beta = (-1)^{kl} \beta\wedge\alpha$
2. **结合性**：$\alpha\wedge\beta\wedge\gamma = \alpha\wedge(\beta\wedge\gamma)$

**推论**：$\Omega(M) = \bigoplus_{k\in \mathbb{Z}} \Omega^k(M)$ 是 $\mathbb{Z}$-分次代数

**局部表示**：

$$\rho = \sum_{i_1<\cdots<i_k} \rho_{i_1,\dots,i_k}dx^{i_1}\wedge\cdots\wedge dx^{i_k}$$

---

## 内积 (Interior Product)

### 定义

对于 $X\in \Gamma^\infty(M,TM)$，**内积** $\iota_X:\Omega^k\to\Omega^{k-1}$：

$$\iota_X\alpha(X_1,\dots,X_{k-1}) = \alpha(X,X_1,\dots,X_{k-1})$$

对于 $f\in \Omega^0$，$\iota_X f := 0$

---

## Cartan微积分

### Cartan魔法公式 (Cartan's Magic Formula)

**定理**：

$$\mathcal{L}_X = [d,\iota_X] = d\cdot \iota_X + \iota_X \cdot d$$

**证明要点**：只需在 $\Omega^0$ 和 $d\Omega^0$ 上验证

### 闭形式和恰当形式

**定义**：
- **闭形式** (Closed form)：$d\rho = 0$
- **恰当形式** (Exact form)：$\rho = d\beta$

**推论**：如果 $\omega$ 是闭的，则 $L_X\omega$ 是恰当的

---

## 关键概念总结

| 概念 | 英文 | 符号 | 说明 |
|------|------|------|------|
| 余切空间 | Cotangent Space | $T_p^\ast M$ | $T_pM$ 的对偶空间 |
| 余切丛 | Cotangent Bundle | $T^\ast M$ | 所有余切空间的并 |
| 1-形式 | 1-form | $\alpha\in \Omega^1(M)$ | 余切丛的截面 |
| k-形式 | k-form | $\alpha\in \Omega^k(M)$ | 交错的 k-线性映射 |
| 外微分 | Exterior Derivative | $d$ | k+1 次导数 |
| 楔积 | Wedge Product | $\wedge$ | 反交换的乘积 |
| 内积/收缩 | Interior Product | $\iota_X$ | 降次的算子 |
| 李导数 | Lie Derivative | $L_X$ | 沿 X 的导数 |
| 闭形式 | Closed Form | $d\alpha=0$ | 外微分为零 |
| 恰当形式 | Exact Form | $\alpha=d\beta$ | 外微分的像 |

---

## 本章要点

1. **微分形式**是切丛对偶的截面，提供了"可微积分"的代数框架

2. **外微分 d** 满足 $d^2=0$，这是 de Rham 上同调的基础

3. **楔积 $\wedge$** 是反交换的，使得 $\Omega^\infty(M)$ 成为分次代数

4. **Cartan魔法公式**连接了三个基本算子：d、$\iota_X$、$L_X$

5. **六个超导数关系**构成了Cartan微积分的核心