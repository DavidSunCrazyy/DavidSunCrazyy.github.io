---
layout: post
title: "微分几何 第9章：经典微分几何 (Classical Differential Geometry)"
permalink: /posts/differential-geometry-09-classical-differential-geometry/
tags: differential-geometry
use_math: true
---

本文档系统介绍经典微分几何的核心内容。首先建立Riemann度量的概念，包括第一基本形式和诱导度量。详细介绍曲线的曲率理论，包括弧长参数化、Frenet标架和挠率。研究曲面的曲率，通过第二基本形式定义Weingarten映射，引入高斯曲率K和平均曲率H。重点证明Gauss绝妙定理，说明高斯曲率只依赖于第一基本形式（内在不变量）。介绍Cartan形式体系，给出结构方程的优雅表达。最后通过Gauss-Bonnet定理展示几何（曲率）与拓扑（Euler示性数）的深刻联系。

---

## Riemann 度量

### 定义

**Riemann 度量**：截面 $g\in \Gamma^\infty(M, \text{Sym}^2T^*M)$，在每点满足：
1. 非退化
2. 正定

**局部表示**：在坐标 $(x^1,\ldots,x^n)$ 下：

$$g = \sum_{i,j} g_{ij}dx^i\otimes dx^j$$

其中 $g_{ij} = g_{ji}$（对称性）

**第一基本形式** (First Fundamental Form)：

$$I = \sum g_{ij}dx^idx^j = Edu^2 + 2Fdudv + Gdv^2$$

---

## 曲线的曲率

### 弧长参数化

**弧长**：$s(t) = \int_{a}^{t} \|\gamma'(t)\| dt$

**单位速率参数化**：$|d\gamma/ds| = 1$

### 曲率 (Curvature)

**曲率**：$\kappa = \|\gamma''(s)\|$

**有号曲率** (Signed curvature)：$\kappa_s = \gamma''(s)\cdot n$

### Frenet 标架

对于 $\mathbb{R}^3$中的曲线：
- **切向量**：$t = \gamma'(s)$
- **法向量**：$n = (1/\kappa)t'$
- **副法向量**：$b = t\times n$

### Frenet-Serret 公式

$$\begin{cases}
\vec{t}' = \kappa\vec{n}\\
\vec{b}' = -\tau\vec{n}\\
\vec{n}' = -\kappa\vec{t} + \tau\vec{b}
\end{cases}$$

---

## 曲面的曲率

### 第二基本形式 (Second Fundamental Form)

**定义**：偏离 $\Delta\sigma\cdot n$（沿法向量 n）的二阶展开

**矩阵表示**：

$$\begin{pmatrix}
L & M\\
M & N
\end{pmatrix}
=
\begin{pmatrix}
\sigma_{uu}\cdot\vec{n} & \sigma_{uv}\cdot\vec{n}\\
\sigma_{uv}\cdot\vec{n} & \sigma_{vv}\cdot\vec{n}
\end{pmatrix}$$

**第二基本形式**：$II = Ldu^2 + 2Mdudv + Ndv^2$

### Weingarten 映射 (形状算子)

**Weingarten 映射** (Shape operator)：$W = -T_pG$

其中 $G:S\to S^2$，$p\mapsto n_p$（Gauss 映射）

### 曲率的分类

**主曲率** (Principal Curvatures)：$W$ 的特征值 $k_1,k_2$

**高斯曲率** (Gaussian Curvature)：$K = \det W = k_1k_2$

**平均曲率** (Mean Curvature)：$H = \frac{1}{2}\text{trace } W = \frac{1}{2}(k_1+k_2)$

**公式**：

$$K = \frac{LN-M^2}{EG-F^2}$$

$$H = \frac{LG-2MF+NE}{2(EG-F^2)}$$

---

## Gauss 方程和绝妙定理

### 绝妙定理 (Theorema Egregium)

**定理** (Gauss)：高斯曲率 $K$ 只依赖于第一基本形式及其导数

**推论**：如果 $f:(M,g)\to(N,h)$ 是曲面的局部等距，则 $K_M(p) = K_N(f(p))$

**等距** (Isometry)：$f$ 是等距，如果 $g = f^*h$

---

## Cartan 形式体系

### 活动标架

**正交标架** (Orthonormal frame)：$\{E_1,E_2,E_3\}$ 满足 $g_0(E_i,E_j) = \delta_{ij}$

**适应标架** (Adapted frame)：$E_1,E_2$ 切于 S，$E_3$ 法向于 S

### Cartan 结构方程

**第一结构方程**：
1. $d\theta_1 = \omega_{12}\wedge\theta_2$
2. $d\theta_2 = \omega_{21}\wedge\theta_1$

**第二结构方程**：
4. $d\omega_{12} = \omega_{13}\wedge\omega_{32}$（Gauss 方程）
5. $d\omega_{13} = \omega_{12}\wedge\omega_{23}$（Codazzi 方程）
6. $d\omega_{23} = \omega_{21}\wedge\omega_{13}$

### 推论

**推论**：$d\omega_{12} = -K\theta_1\wedge\theta_2$，其中 $K$ 是 Gauss 曲率

---

## 测地线和 Gauss-Bonnet 定理

### Gauss-Bonnet 定理 (Gauss-Bonnet Theorem)

**定理**：对于紧定向曲面 $(S,\partial S)$ 和任意 Riemann 度量 $g$：

$$\iint_S K\,dA + \int_{\partial S} k_g\,ds = 2\pi\chi(S)$$

其中 $\chi(S)$ 是 **Euler 示性数** (Euler characteristic)

---

## 关键概念总结

| 概念 | 英文 | 符号 | 说明 |
|------|------|------|------|
| Riemann 度量 | Riemannian Metric | $g$ | 正定对称 2-张量 |
| 第一基本形式 | First Fundamental Form | $I$ | 长度度量 |
| 第二基本形式 | Second Fundamental Form | $II$ | 弯曲度量 |
| 高斯曲率 | Gaussian Curvature | $K$ | $k_1k_2$ |
| 平均曲率 | Mean Curvature | $H$ | $(k_1+k_2)/2$ |
| 主曲率 | Principal Curvatures | $k_1,k_2$ | Weingarten 映射特征值 |
| 弧长 | Arc Length | $s(t)$ | $\int\|\gamma'(t)\|dt$ |
| Frenet 标架 | Frenet Frame | $\{t,n,b\}$ | 曲线的活动标架 |
| 测地线 | Geodesic | $k_g=0$ | "最短"曲线 |
| Euler 示性数 | Euler Characteristic | $\chi(S)$ | $V-E+F$ |

---

## 重要定理

### 定理1：Gauss 绝妙定理

$K$ 只依赖于第一基本形式（内在不变量）

### 定理2：Gauss-Bonnet 定理

$$\int_S K dA + \int_{\partial S} k_g ds = 2\pi\chi(S)$$

---

## 本章要点

1. **Riemann 度量**提供了流形上的长度和角度概念

2. **曲线的曲率**：$\kappa$ 衡量偏离直线的程度，$\tau$ 衡量偏离平面的程度

3. **曲面的曲率**：
   - $K$：内在曲率（Gauss 曲率）
   - $H$：外在曲率（平均曲率）

4. **绝妙定理**：$K$ 是内在不变量，开创了内在几何学

5. **Gauss-Bonnet 定理**：连接了几何（曲率）和拓扑（Euler 示性数）

6. **Cartan 形式体系**：提供了优雅的计算框架