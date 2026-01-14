---
layout: post
title: "Differential Geometry de Rham上同调 (de Rham Cohomology)"
permalink: /posts/differential-geometry-08-de-rham-cohomology/
tags: differential-geometry
use_math: true
---

本文档系统介绍de Rham上同调理论，这是微分几何和代数拓扑的重要桥梁。首先定义de Rham复形和上同调群，建立闭形式和恰当形式的商空间。通过$S^1$的详细计算说明上同调群的计算方法。重点证明同伦不变性定理，说明上同调是同伦不变量。作为重要推论，给出Poincaré引理，说明$\mathbb{R}^n$的上同调性质。详细介绍Stokes定理，这是微积分基本定理的推广。引入Mayer-Vietoris序列，提供计算上同调的强大工具。最后给出积分同构定理和紧支集Poincaré引理。

---

## de Rham 复形和上同调

### 上链复形 (Chain Complex)

**de Rham 复形**：

$$0\to \Omega^0 \xrightarrow{d} \Omega^1 \xrightarrow{d} \cdots \xrightarrow{d} \Omega^n \to 0$$

记为 $(\Omega^\bullet,d)$

### 上同调群的定义

**上闭链** (Z-cocycles)：

$$Z^k_{dR}(M) = \ker d^k = \{\alpha\in\Omega^k(M) \mid d\alpha = 0\}$$

**上边缘** (B-coboundaries)：

$$B^k_{dR}(M) = \text{im}\,d^{k-1} = \{d\beta \mid \beta\in\Omega^{k-1}(M)\}$$

**de Rham 上同调群**：

$$H^k_{dR}(M) = Z^k_{dR}(M)/B^k_{dR}(M)$$

---

## $S^1$ 的上同调计算

### $H^0_{dR}(S^1)$

- $\Omega^0(S^1)$：光滑函数 $f:S^1\to\mathbb{R}$（$2\pi$-周期函数）
- $d$ 的核：常值函数
- **结果**：$H^0_{dR}(S^1) \cong \mathbb{R}$

### $H^1_{dR}(S^1)$

- $\Omega^1(S^1)$：形如 $g(\theta)d\theta$ 的形式
- $d$ 的核：所有 1-形式
- $d$ 的像：恰当形式 $f'(\theta)d\theta$

**关键**：$g(\theta)d\theta$ 是恰当的 $\Leftrightarrow$ $\int_0^{2\pi} g(\theta)d\theta = 0$

**例子**：$d\theta$ 是闭的但不是恰当的
- $\int_0^{2\pi} d\theta = 2\pi \neq 0$
- $[d\theta] \in  H^1_{dR}(S^1)$ 是非平凡的

**同构**：

$$H^1_{dR}(S^1) \cong \mathbb{R},\quad [g(\theta)d\theta] \mapsto \frac{1}{2\pi}\int_0^{2\pi} g(\theta)d\theta$$

---

## 同伦不变性

### 同伦不变性定理

**定理**：如果 $f,g:M\to N$ 光滑同伦，则在上同调上 $f^* = g^*$

**推论**：如果 $M,N$ 光滑同伦，则 $H^\bullet_{dR}(M) \cong H^\bullet_{dR}(N)$

### Poincaré引理 (Poincaré Lemma)

**推论**：因为 $\mathbb{R}^n \cong *$（单点），

$$H^\bullet_{dR}(\mathbb{R}^n) = \begin{cases}
\mathbb{R} & n=0\\
0 & n>0
\end{cases}$$

---

## 积分和 Stokes 定理

### 积分的定义

**定向流形上的积分**：对于定向 n-流形 M，存在唯一线性映射：

$$\int_M : \Omega^n_c(M) \to \mathbb{R}$$

满足：如果 $h:V\to U$ 是保向微分同胚，$\alpha\in \Omega^n_c(M)$，$\text{supp } \alpha\subset U$，则

$$\int_M \alpha = \int_V h^*\alpha$$

### Stokes 定理 (Stokes' Theorem)

**全局 Stokes 定理**：

设 $(M,\partial M)$ 定向，$\alpha\in \Omega^{n-1}_c(M)$，$j:\partial M\to M$ 由外法定向，则：

$$\int_M d\alpha = \int_{\partial M} j^*\alpha$$

**推论**：如果 M 紧、无边界、可定向，则 $H^n_{dR}(M) \neq 0$

---

## Mayer-Vietoris 序列

### 长正合序列

**定理**：短正合序列诱导长正合序列：

$$\cdots \to H^{k-1}(U\cap V) \to H^k(U\cup V) \to H^k(U)\oplus H^k(V) \to H^k(U\cap V) \to H^{k+1}(U\cup V) \to \cdots$$

### $S^n$ 的上同调

使用 $S^n = U\cup V$，其中 $U,V \cong$ 点，$U\cap V \cong S^{n-1}$：

$$H^k(S^n) = \begin{cases}
\mathbb{R} & k=0,n\\
0 & \text{其他}
\end{cases}$$

---

## 积分同构

### 定理

**定理**：设 M 是连通、闭、定向的 n-维流形，则：

$$\int_M : H^n(M) \to \mathbb{R}$$

是同构

---

## 关键概念总结

| 概念 | 英文 | 符号 | 说明 |
|------|------|------|------|
| de Rham复形 | de Rham Complex | $(\Omega^\bullet,d)$ | 外微分的复形 |
| 上闭链 | Cocycle | $Z^k_{dR}$ | $d\alpha=0$ |
| 上边缘 | Coboundary | $B^k_{dR}$ | $\alpha=d\beta$ |
| 上同调群 | Cohomology Group | $H^k_{dR}$ | $Z^k/B^k$ |
| 同伦不变性 | Homotopy Invariance | - | 同伦映射诱导相同同调 |
| Poincaré引理 | Poincaré Lemma | - | $\mathbb{R}^n$ 的上同调平凡 |
| Stokes定理 | Stokes' Theorem | $\int_M d\alpha = \int_{\partial M} \alpha$ | 微积分基本定理推广 |
| Mayer-Vietoris | Mayer-Vietoris Sequence | 长正合序列 | 计算上同调的工具 |
| 定向 | Orientation | $[\sigma]$ | 非零 n-形式的等价类 |

---

## 上同调计算表

| 流形 | $H^0$ | $H^1$ | $H^2$ | $H^3$ | ... | $H^n$ |
|------|-----|----|----|----|-----|-----|
| 点 | $\mathbb{R}$ | 0 | 0 | 0 | ... | 0 |
| $S^1$ | $\mathbb{R}$ | $\mathbb{R}$ | 0 | 0 | ... | 0 |
| $S^2$ | $\mathbb{R}$ | 0 | $\mathbb{R}$ | 0 | ... | 0 |
| $S^n$ | $\mathbb{R}$ | 0 | 0 | 0 | ... | $\mathbb{R}$ |
| $\mathbb{R}^n$ | $\mathbb{R}$ | 0 | 0 | 0 | ... | 0 |

---

## 本章要点

1. **de Rham上同调**衡量闭形式和恰当形式的差别

2. **同伦不变性**：上同调是同伦不变量，是拓扑不变量

3. **Poincaré引理**：$\mathbb{R}^n$ 的高阶上同调消失

4. **Stokes定理**：连接了外微分和边界积分，是微积分基本定理的推广

5. **Mayer-Vietoris序列**：提供了计算上同调的强大工具

6. **积分**：$H^n(M)\to\mathbb{R}$ 是同构（对于闭定向连通流形）