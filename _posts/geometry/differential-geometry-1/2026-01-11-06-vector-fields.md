---
layout: post
title: "Differential Geometry 向量场 (Vector Fields)"
permalink: /posts/differential-geometry-06-vector-fields/
tags: differential-geometry
use_math: true
---

本文档系统介绍向量场理论。首先定义向量场为切丛的光滑截面，建立其作为导数的观点。详细研究李括号的性质和局部坐标表示，说明其作为向量场非交换性度量的作用。介绍积分曲线和流的概念，证明常微分方程解的存在唯一性定理。深入研究李导数的几何意义，给出Cartan魔法公式（$L_X = d·\iota_X + \iota_X·d$）及其应用。最后通过Frobenius定理说明完全可积性条件，展示微分方程理论与几何的深刻联系。

---

## 向量场的定义

### 基本定义

**向量场** X：M 上的向量场是光滑映射 $X:M\to TM$，使得 $\pi∘X = id_M$

**注**：这样的映射称为向量丛的**光滑截面** (smooth section)

**记号**：
- $\mathfrak{X}(M)$ 或 $\Gamma^\infty(M,TM)$（有时也 $\Gamma(M,TM)$）
- 所有向量场的空间

### 局部表示

在开集 $U\subset V$（向量空间）上，$TU \cong U\times V$

$X(p) = \sum_{i=1}^n a_i \partial/\partial x_i$，视为截面 $U\to U\times V$：

$$p \mapsto (p, \sum a_i(p) \frac{\partial}{\partial x_i}\bigg|_p)$$

---

## 推前和拉回

### 推前 (Pushforward)

如果 f 有光滑逆 $f^{-1}$，定义 $Y = Tf∘X∘f^{-1}:N\to TN$

记为 $Y = f_*X$，称为 X 的**推前**

### f-相关

**定义**：X, Y 称为 **f-相关**的，如果 $Y∘f = Tf∘X$

### 拉回 (Pullback)

对于 $\varphi:M\to N$ 光滑，$f\in C^\infty(N)$，定义：

$$\varphi^*f = f\circ\varphi \in C^\infty(M)$$

$\varphi^*:C^\infty(N)\to C^\infty(M)$ 称为 f 的拉回

---

## 向量场作为导数

### 导数的定义

**$\mathbb{R}$-代数 A 的导数**：线性映射 $D:A\to A$，满足：

$$D(fg) = f\cdot D(g) + D(f)\cdot g$$

所有导数的集合记为 $\mathrm{Der}(A)$

### 向量场与导数的对应

**局部**：$X = \sum a_i \partial/\partial x_i$ 在 $C^\infty(U)$ 上，$X f = \sum a_i \partial f/\partial x_i$

**全局**：对于 $X\in \Gamma^\infty(M,TM)$，定义：

$$X(f) := df \circ X : M \to \mathbb{R} \in C^\infty(M)$$

**李导数** (Lie derivative)：$X(f) = df∘X =: L_X f$ 称为 f 沿 X 的李导数

### 主要定理

**定理**：映射

$$\mathcal{L}: \Gamma^\infty(M,TM) \to \mathrm{Der}(C^\infty(M))$$

$$X \mapsto \mathcal{L}_X$$

是双射

---

## 李括号 (Lie Bracket)

### 定义

**李括号**：对于 $X,Y\in \mathrm{Der}(C^\infty(M))$，

$$[X,Y] := X \circ Y - Y \circ X : C^\infty(M) \to C^\infty(M)$$

### 性质

**命题**：
1. $[X,Y]$ 是导数（满足乘积法则）
2. 局部坐标下：

$$[X,Y] = \sum_i \sum_j \left(a_i \frac{\partial b_j}{\partial x_i} - b_i \frac{\partial a_j}{\partial x_i}\right)\frac{\partial}{\partial x_j}$$

**交换性**：如果 $[X,Y] = 0$，称 X,Y **交换**

---

## 积分曲线和流

### 积分曲线

**定义**：$\gamma:(-\varepsilon,\varepsilon)\to M$ 是 X 的**积分曲线**，如果：

$$\gamma'(t) = X(\gamma(t))$$

### 常微分方程的存在唯一性

**定理**：设 X 是 $V\subset \mathbb{R}^n$ 上的向量场。$\forall x_0\in V$，$\exists$：
- 邻域 $U\subset V$
- $\varepsilon>0$
- 光滑函数 $\Phi:(-\varepsilon,\varepsilon)\times U\to V$，$(t,p)↦\varphi_t(p)$

使得 $\forall p\in U$，$t↦\varphi_t$ 是具有给定初始条件的 X 的积分曲线

### 流 (Flow)

**定义**：映射 $\Phi$（也记为 $\varphi_t$）称为 X 的**流**，或**局部单参数微分同胚群**

**性质**：
1. $\varphi_0(x) = x$
2. $\varphi_{t'}(\varphi_t(x)) = \varphi_{t+t'}(x)$
3. $\varphi_{-t}$ 是 $\varphi_t$ 的逆

### 完备向量场

**定义**：X 是**完备的**，如果最大定义域 $U^\times = \mathbb{R}\times M$

**定理**：紧 M 上的任何向量场都是完备的

---

## Frobenius定理

### 积分子流形

**定义**：$X_1,...,X_r\in \Gamma^\infty(M,TM)$ 线性无关，$S\subset M$ 是 r 维子流形，如果：

$$X_i|_q \in T_q S, \quad \forall q\in S$$

称 S 是 $X_1,...,X_r$ 的**积分子流形**

### Frobenius定理 (Frobenius Theorem)

**定理**：设 $X_1,...,X_r$ 线性无关，以下等价：
1. $\forall p\in U$，$\exists$ 经过 p 的积分子流形 S
2. $[X_i, X_j] = \sum_{k=1}^r c_{ij}^k X_k$（Frobenius条件）

---

## 关键概念总结

| 概念 | 英文 | 符号 | 说明 |
|------|------|------|------|
| 向量场 | Vector Field | $X\in \Gamma^\infty(M,TM)$ | 切丛的光滑截面 |
| 推前 | Pushforward | $f_*X$ | 通过微分同胚转移 |
| 拉回 | Pullback | $\varphi^*f$ | $\varphi^*f = f∘\varphi$ |
| 李括号 | Lie Bracket | $[X,Y]$ | XY-YX |
| 积分曲线 | Integral Curve | $\gamma'(t)=X(\gamma(t))$ | 向量场的解曲线 |
| 流 | Flow | $\varphi_t$ | 单参数微分同胚群 |
| 李导数 | Lie Derivative | $L_X$ | 沿向量场的导数 |
| 完备向量场 | Complete Vector Field | - | 全局定义的流 |
| Frobenius条件 | Frobenius Condition | $[X_i,X_j]\in \mathrm{span}\{X_k\}$ | 积分子流形条件 |

---

## 本章要点

1. **向量场**的三种观点：
   - 几何观点：切丛的截面
   - 分析观点：导子
   - 物理观点：速度场

2. **李括号**衡量两个向量场的不可交换程度

3. **流**是向量场的全局积分，提供单参数群作用

4. **Cartan魔法公式**连接了外微分、内积和李导数

5. **Frobenius定理**给出完全可积性条件