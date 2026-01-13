---
layout: post
title: "微分几何 第4章：子流形 (Submanifolds)"
permalink: /posts/differential-geome$try-04-submanifolds/
tags: differential-geome$try
use_math: true
---

本文档详细介绍子流形的理论和光滑映射的局部结构。首先给出子流形的严格定义，说明子流形如何继承流形结构。重点介绍常数秩定理，这是分析映射局部结构的核心工具。通过秩的概念分类光滑映射：浸没（满射）、浸入（单射）和嵌入（单射浸入且同胚）。利用正则值理论提供构造子流形的重要方法。最后通过具体例子说明逆函数定理和隐函数定理的应用。

---

## 子流形的定义

### 基本定义

**子流形**：子集 $S\subset M^m$ 是维数为 $k(\leq m)$ 的子流形，如果 $\forall p\in S$，$\exists M$ 在 $p$ 周围的坐标卡 $(U,\varphi)$ 使得：

$$\varphi(U\cap S) = \varphi(U) \cap $\mathbb{R}^k$$

**子流形坐标卡**：$(U,\varphi)$ 称为 $S$ 的子流形坐标卡

**余维** (Codimension)：如果 $S$ 是 $k$ 维，$M$ 是 $m$ 维，则 $S$ 的余维是 $m-k$

### 命题：子流形是流形

**命题**：假设 $S$ 是 $M$ 的子流形。则：
1. $S$ 是 $k$ 维光滑流形
2. 其图集由 $\\{(U\cap S,\varphi')\\}$ 组成，其中 $\varphi' = \pi\circ\varphi|_{U\cap S}$，$\pi:\mathbb{R}^m\to$\mathbb{R}^k$ 是投影
3. 包含 $\iota:S\hookrightarrow M$ 是光滑的

---

## 光滑映射的局部结构

### 秩 (Rank)

**定义**：$f\in C^\infty($\mathbb{R}^m,$\mathbb{R}^n)$ 在 $p\in M$ 处的**秩**是其雅可比矩阵的秩：

$$Df(p) = \begin{pmatrix}
\frac{\partial f_1}{\partial x_1}(p) & \cdots & \frac{\partial f_1}{\partial x_m}(p)\\
\vdots & \ddots & \vdots\\
\frac{\partial f_n}{\partial x_1}(p) & \cdots & \frac{\partial f_n}{\partial x_m}(p)
\end{pmatrix}$$

对于流形间的映射 $f:M\to N$，$\operatorname{rank}\_p f = \operatorname{rank}\_{\varphi(p)}(\psi\circ f\circ\varphi^{-1})$

**性质**：$\operatorname{rank} Df(p) \leq \min(m,n)$

### 最大秩

**定义**：$f$ 在 $p$ 处具有**最大秩**，如果 $\operatorname{rank}\_p f = \min\\{m,n\\}$

**常数秩**：$f$ 具有常数秩 $k$，如果 $\operatorname{rank}\_p f = k$，$\forall p\in M$

---

## 重要定理

### 逆函数定理 (Inverse Function Theorem)

**定理**：设 $f\in C^\infty(M,N)$，$\dim M = \dim N = m$。如果对于某个 $p\in M$，$\operatorname{rank}\_p F = m$，则 $\exists p$ 的邻域 $U$ 使得 $f\|_U$ 是微分同胚

**局部微分同胚**：$f\in C^\infty(M,N)$ 是局部微分同胚，如果 $\forall p\in M$，$\exists U\ni p$ 使得 $f\|_U$ 是微分同胚

### 常数秩定理 (Constant Rank Theorem)

**定理**：设 $f:M^m\to N^n$ 光滑。如果 $Df$ 在 $p$ 的邻域中具有秩 $k$，则存在：
- $p$ 周围的坐标卡 $(U,\varphi)$
- $f(p)$ 周围的坐标卡 $(V,\psi)$

使得：

$$\psi \circ f \circ \varphi^{-1}(x_1,\cdots,x_m) = (x_1,\cdots,x_k,0,\cdots,0)$$

**推论**：$f:M\to N$ 光滑，$Df(p)$ 在所有点具有常数秩 $k$ $\Rightarrow$ $\forall q\in f(M)$，$f^{-1}(q)\subset M$ 是余维 $k$ 的子流形

---

## 正则值和临界值

### 定义

对于 $f\in C^\infty(M,N)$：

**正则点** (Regular point)：$T_p f$ 具有最大秩的点 $p$

**临界点** (Critical point)：$T_p f$ 不具有最大秩的点 $p$

**正则值** (Regular value)：$q\in N$ 是正则值，如果 $f^{-1}(q)$ 中所有点都是正则点

**临界值** (Critical value)：$q\in N$ 是临界值，如果 $f^{-1}(q)$ 包含至少一个临界点

---

## 浸没、浸入和嵌入

### 浸没 (Submersion)

**定义**：$Df(p)$ 在 $\forall p\in M$ 处满射

**命题**：$Df(p)$ 在 $p$ 处满射 $\Rightarrow U\cap f^{-1}(q)$ 是子流形，其中 $U$ 是 $p$ 的邻域

### 浸入 (Immersion)

**定义**：$Df(p)$ 在 $\forall p\in M$ 处单射

**命题**：$Df(p)$ 在 $p$ 处单射 $\Rightarrow f(U)$ 是 $N$ 的子流形，$U$ 是 $p$ 的邻域

### 嵌入 (Embedding)

**定义**：到其像为同胚的单射浸入

**命题**：$f:M\to N$ 嵌入 $\Rightarrow f(M)$ 是 $N$ 的维数为 $m$ 的子流形

---

## 重要例子

### 1. 正则值的例子

$f:\mathbb{R}^n\to\mathbb{R}$，$(x_1,\cdots,x_n)\mapsto x_1^2+\cdots+x_n^2$
- $Df(p) = (2x_1,\cdots,2x_n)$ 在 $\mathbb{R}^n\setminus\\{0\\}$ 上具有秩 $1$
- $f^{-1}(1) = S^{n-1}$ 是 $\mathbb{R}^n\setminus\\{0\\}$ 的余维 $1$ 的子流形

### 2. $\mathbb{R}^3$ 中的例子

设 $f\in C^\infty(\mathbb{R}^3)$，$S = f^{-1}(0)$

对于 $p\in S$，如果 $(\partial f/\partial x)_p\neq 0$，则隐函数定理 (IFT) 说明在 $p$ 的邻域上可以求解

**推论**：如果 $\nabla f = (\partial f/\partial x,\partial f/\partial y,\partial f/\partial z) \neq 0$，$\forall p\in S$，则 $f^{-1}(0)=S$ 是 $\mathbb{R}^3$ 的子流形

---

## 关键概念总结

| 概念 | 英文 | 线性代数条件 |
|------|------|-------------|
| 子流形 | Submanifold | 局部平坦嵌入 |
| 余维 | Codimension | $m-k$ |
| 秩 | Rank | 雅可比矩阵的秩 |
| 最大秩 | Maximal rank | $\operatorname{rank} = \min(m,n)$ |
| 常数秩 | Constant $rank | 各点秩相同 |
| 浸没 | Submersion | 满射 $Df$ |
| 浸入 | Immersion | 单射 $Df$ |
| 嵌入 | Embedding | 单射浸入+同胚 |
| 正则值 | Regular value | 原像都是正则点 |

---

## 本章要点

1. **子流形**：局部上像坐标平面
2. **秩**：雅可比矩阵的秩决定映射的局部性质
3. **三大类映射**：
   - **浸没** (Submersion)：满秩，原像是子流形
   - **浸入** (Immersion)：单射，像局部是子流形
   - **嵌入** (Embedding)：全局像也是子流形
4. **常数秩定理**是分析映射局部结构的强大工具
5. **正则值**提供了构造子流形的重要方法
