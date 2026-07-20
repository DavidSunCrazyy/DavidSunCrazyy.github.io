---
note: true
layout: post
title: "Numerical Analysis I 线性方程组的直接解法——Gauss消去法与矩阵分解"
permalink: /posts/numerical-analysis-1/02-direct-methods-linear-systems/
categories: numerical-analysis
tags: [numerical-analysis, gaussian-elimination, lu-decomposition, cholesky-decomposition, direct-methods]
use_math: true
---

上一章我们建立了误差和范数的基本概念，现在开始讨论具体的数值方法。本章处理数值分析中最基础的问题：给定线性方程组 $Ax = b$，如何高效、稳定地求解？直接解法通过有限次初等变换将方程组化为易于求解的三角形式，是中小规模稠密矩阵的首选方法。

## 第二章 线性代数方程组的直接解法

## 1. Gauss 消去法

设矩阵 $A = [a_{ij}] \in \mathbb{R}^{n \times n},\;x = (x_1, \cdots, x_n)^T \in \mathbb{R}^n$

$$
b = (b_{1}, \dots, b_{n})^{T} \in \mathbb{R}^{n}
$$

$$
\text{令} \quad [A^{(1)} \mid b^{(1)}] = [A \mid b] = \left[\begin{array}{ccc|c} a_{11} & \dots & a_{1n} & b_{1} \\ \vdots & \ddots & \vdots & \vdots \\ a_{n1} & \dots & a_{nn} & b_{n} \end{array}\right]
$$

假设 ${a}_{11} \neq 0\;\text{令}$

$$
l_{i1} = \frac{a_{i1}}{a_{11}}, \quad i = 2, 3, \dots, n, \quad l_{1} = (0, l_{21}, \dots, l_{n1})^{T} \in \mathbb{R}^{n}
$$

$$
L_{1} = I + l_{1} e_{1}^{T} = \left[\begin{array}{cccc} 1 & & & \\ l_{21} & 1 & & \\ \vdots & & \ddots & \\ l_{n1} & & & 1 \end{array}\right], \quad \text{则 } L_{1}^{-1} = I - l_{1} e_{1}^{T} = \left[\begin{array}{cccc} 1 & & & \\ -l_{21} & 1 & & \\ \vdots & & \ddots & \\ -l_{n1} & & & 1 \end{array}\right]
$$

做变换

$$
\text{变换 } [A^{(2)} \mid b^{(2)}] = L_{1}^{-1} [A^{(1)} \mid b^{(1)}] = \left[\begin{array}{cccc|c} a_{11}^{(1)} & a_{12}^{(1)} & \dots & a_{1n}^{(1)} & b_{1}^{(1)} \\ 0 & a_{22}^{(2)} & \dots & a_{2n}^{(2)} & b_{2}^{(2)} \\ \vdots & \vdots & \ddots & \vdots & \vdots \\ 0 & a_{n2}^{(2)} & \dots & a_{nn}^{(2)} & b_{n}^{(2)} \end{array}\right]
$$

假设已完成 $k-1$ 步消元，得到 $A^{(k)}x=b^{(k)}$ 对应的

$$
\left[A^{(k)} \mid b^{(k)}\right] = \left[\begin{array}{cccccc|c} a_{11}^{(1)} & a_{12}^{(1)} & \dots & a_{1k}^{(1)} & \dots & a_{1n}^{(1)} & b_{1}^{(1)} \\ 0 & a_{22}^{(2)} & \dots & a_{2k}^{(2)} & \dots & a_{2n}^{(2)} & b_{2}^{(2)} \\ \vdots & 0 & \ddots & \vdots & & \vdots & \vdots \\ \vdots & \vdots & & a_{kk}^{(k)} & \dots & a_{kn}^{(k)} & b_{k}^{(k)} \\ \vdots & \vdots & & \vdots & & \vdots & \vdots \\ 0 & 0 & \dots & a_{nk}^{(k)} & \dots & a_{nn}^{(k)} & b_{n}^{(k)} \end{array}\right]
$$

假设 ${a}_{kk}^{\left( k\right) } \neq 0$ ,令

$$
l_{ik} = \frac{a_{ik}^{(k)}}{a_{kk}^{(k)}}, \quad i = k+1, \dots, n
$$

$$
l_{k} = (0, \dots, 0, l_{k+1,k}, \dots, l_{nk})^{T}, \quad L_{k} = I + l_{k} e_{k}^{T}
L_{k}^{-1} = I - l_{k} e_{k}^{T} = \left[\begin{array}{ccccc} 1 & & & & \\ & \ddots & & & \\ & & 1 & & \\ & & -l_{k+1,k} & 1 & \\ & & \vdots & & \ddots \\ & & -l_{nk} & & & 1 \end{array}\right]
$$

$$
[A^{(k+1)} \mid b^{(k+1)}] = L_{k}^{-1} [A^{(k)} \mid b^{(k)}]
$$

假设 依次有 ${a}_{kk}^{\left( k\right) } \neq 0,k = 1,2,\cdots ,n - 1$ ,最终可得

$$
\left[A^{(n)} \mid b^{(n)}\right] = \left[\begin{array}{cccc|c} a_{11}^{(1)} & a_{12}^{(1)} & \dots & a_{1n}^{(1)} & b_{1}^{(1)} \\ & a_{22}^{(2)} & \dots & a_{2n}^{(2)} & b_{2}^{(2)} \\ & & \ddots & \vdots & \vdots \\ & & & a_{nn}^{(n)} & b_{n}^{(n)} \end{array}\right]
$$

对应方程组 ${A}^{\left( n\right) }x = {b}^{\left( n\right) }$

$A^{(n)}$ 为上三角矩阵

$$
A^{(n)} = L_{n-1}^{-1} \cdots L_{1}^{-1} A
$$

由此可得线性方程组的解

$$
\left\{ \begin{array}{l} x_{n} = b_{n}^{(n)} / a_{nn}^{(n)} \\ x_{i} = \left(b_{i}^{(n)} - \sum\limits_{j=i+1}^{n} a_{ij}^{(i)} x_{j}\right) / a_{ii}^{(i)}, \quad i = n-1, \dots, 2, 1 \end{array} \right.
$$

Gauss 消元法 第 $k$ 步需做除法 $n - k$ 次，

乘法和加法 各 $(n-k)(n+1-k)$ 次

整个消去过程的计算量为

$$
\sum_{k=1}^{n-1} (n-k) + 2 \sum_{k=1}^{n-1} (n-k)(n+1-k) = \frac{2n^{3}}{3} + \frac{n^{2}}{2} - \frac{7}{6}n
$$

$$
O(n^{3})
$$

**定理：** 设 $A \in {\mathbb{R}}^{n \times n}$ ,对 $k = 1,2,\cdots n$ Gauss 顺序消去过程的对角元 $a_{11}^{(1)} \neq 0$ $\cdots$ $a_{kk}^{(k)} \neq 0$ 的充要条件是 

$\Delta_{1}\neq0\quad\cdots\quad\Delta_{k}\neq0,\quad\Delta_{i}=\det A_{i}$

$A_{i}$为$A$的$i$阶 顺序主子式.

**证明：** 由 Gauss 顺序消去过程 不改变 顺序主子式的行列式 易证.

**定理:** $A \in \mathbb{R}^{n \times n}, \quad \det A \neq 0, \quad \Delta_i \neq 0, \quad i = 1, 2, \cdots n-1.$

则存在唯一的单位下三角矩阵 $L$ 和非奇异的上三角矩阵 $U$ 使得

$$
A = LU
$$

**证明：** 由 Gauss 消元法可得

$$
L_{n-1}^{-1} L_{n-2}^{-1} \cdots L_{2}^{-1} L_{1}^{-1} A = U
$$

$\Rightarrow A = L_{1}L_{2}\cdots L_{n-1}U = LU$

由 $L_{k}$ 的表达式得

$$
L = L_{1} \cdots L_{n-1} = \left[\begin{array}{ccccc} 1 & & & & \\ l_{21} & 1 & & & \\ \vdots & l_{32} & \ddots & & \\ \vdots & \vdots & \ddots & \ddots & \\ l_{n1} & l_{n2} & \dots & l_{n,n-1} & 1 \end{array}\right]
$$

是一个单位下三角矩阵.

如果存在单位下三角矩阵 $L_{1}, L_{2}$ 和非奇异的上三角矩阵 $U_{1}, U_{2}$ 使得

$$
A = L_{1} U_{1} = L_{2} U_{2}
$$

则有 $U_{1}U_{2}^{-1}=L_{1}^{-1}L_{2}$

$U_{1}U_{2}^{-1}$ 为上三角矩阵， $L_{1}^{-1}L_{2}$ 为单位下三角矩阵

所以 $U_{1}U_{2}^{-1}=L_{1}^{-1}L_{2}=I$

$\Rightarrow U_{1}=U_{2},\quad L_{1}=L_{2}$ 唯一性得证.

顺序 Gauss 消去法要求每步的主元 $a_{kk}^{(k)} \neq 0$，但即使 $\det A \neq 0$，计算过程中仍可能出现零主元。更常见的情况是：主元虽然非零但很小，会导致舍入误差被严重放大。为了解决这个问题，我们在每一步选取绝对值最大的元素作为主元。

## 2. 选主元素的消去法

设 Gauss 消去法进行了 $k-1$ 步得到

$$
[A^{(k)} \mid b^{(k)}] = \left[\begin{array}{cccccc|c} a_{11}^{(1)} & a_{12}^{(1)} & \dots & a_{1k}^{(1)} & \dots & a_{1n}^{(1)} & b_{1}^{(1)} \\ 0 & a_{22}^{(2)} & \dots & a_{2k}^{(2)} & \dots & a_{2n}^{(2)} & b_{2}^{(2)} \\ \vdots & 0 & \ddots & \vdots & & \vdots & \vdots \\ \vdots & \vdots & & a_{kk}^{(k)} & \dots & a_{kn}^{(k)} & b_{k}^{(k)} \\ \vdots & \vdots & & \vdots & & \vdots & \vdots \\ 0 & 0 & \dots & a_{nk}^{(k)} & \dots & a_{nn}^{(k)} & b_{n}^{(k)} \end{array}\right]
$$

若 $a_{k k}^{(k)} = 0$ 设 $\left|a_{i_k k}^{(k)}\right| = \max _{k\leq i\leq n}|a_{ik}^{(k)}|$

因为 $\det A \neq 0$ 有 ${a}_{i,k}^{\left( k\right) } \neq 0$

交换 第 $k$ 行和第 $i_{k}$ 行 然后继续 Gauss 消去法.

$$
[A^{(k+1)} \mid b^{(k+1)}] = L_{k}^{-1} I_{i_k, k} [A^{(k)} \mid b^{(k)}]
$$

其中 $I_{i_k,k}$ 为置换矩阵

$$
I_{i,j} = \left[\begin{array}{ccccccc} 1 & & & & & & \\ & \ddots & & & & & \\ & & 0 & & 1 & & \\ & & & \ddots & & & \\ & & 1 & & 0 & & \\ & & & & & \ddots & \\ & & & & & & 1 \end{array}\right]
$$

$$
L_{n-1}^{-1} I_{i_{n-1}, n-1} \cdots L_{2}^{-1} I_{i_{2}, 2} L_{1}^{-1} I_{i_{1}, 1} A = U
$$

容易验证

$$
I_{i_k, k} L_{k-1}^{-1} = (I_{i_k, k} L_{k-1}^{-1} I_{i_k, k}) I_{i_k, k}
$$

$$
I_{i_k, k} L_{k-1}^{-1} I_{i_k, k} = I - (I_{i_k, k} l_{k-1}) e_{k}^{T}
$$

由此可得

$$
\underbrace{L_{n-1}^{-1} \tilde{L}_{n-2}^{-1} \cdots \tilde{L}_{1}^{-1}}_{L^{-1}} \; \underbrace{I_{i_{n-1}, n-1} \cdots I_{i_{1}, 1}}_{P} \; A = U
$$

$$
\tilde{L}_{k}^{-1} = I_{i_{n-1}, n-1} \cdots I_{i_{k+1}, k+1} L_{k}^{-1} I_{i_{k+1}, k+1} \cdots I_{i_{n-1}, n-1}
$$

$$
\Rightarrow \quad PA = LU
$$

Gauss 消去法的本质是将 $A$ 分解为单位下三角矩阵 $L$ 和上三角矩阵 $U$ 的乘积。如果我们能直接构造这个分解，就能避免消去过程中对增广矩阵的反复操作——这就是直接三角分解的思想。

## 3. 直接三角分解方法

### 3.1 Doolittle 分解方法

设 $A = [a_{ij}] \in \mathbb{R}^{n \times n}$ ， $\Delta_{i} \neq 0$ ， $i = 1, 2, \cdots, n$ 则存在单位下三角矩阵 $L = [l_{ij}]$ ，上三角矩阵 $U = [u_{ij}]$ 使得 $A = LU$ 即

$$
\left[\begin{array}{cccc} a_{11} & a_{12} & \dots & a_{1n} \\ a_{21} & a_{22} & \dots & a_{2n} \\ \vdots & \vdots & \ddots & \vdots \\ a_{n1} & a_{n2} & \dots & a_{nn} \end{array}\right] = \left[\begin{array}{cccc} 1 & & & \\ l_{21} & 1 & & \\ \vdots & \ddots & \ddots & \\ l_{n1} & \dots & l_{n,n-1} & 1 \end{array}\right] \left[\begin{array}{cccc} u_{11} & u_{12} & \dots & u_{1n} \\ & u_{22} & \dots & u_{2n} \\ & & \ddots & \vdots \\ & & & u_{nn} \end{array}\right]
$$

$$
\Rightarrow u_{1j} = a_{1j}, \quad j = 1, 2, \dots, n
$$

$$
l_{i1} = \frac{a_{i1}}{u_{11}}, \quad i = 2, 3, \dots, n
$$

假设 $U$ 的前 $k-1$ 行和 $L$ 的前 $k-1$ 列已算出
则有

$$
a_{kj} = \sum_{r=1}^{n} l_{kr} u_{rj} = \sum_{r=1}^{k-1} l_{kr} u_{rj} + u_{kj}
$$

$$
\Rightarrow u_{kj} = a_{kj} - \sum_{r=1}^{k-1} l_{kr} u_{rj}, \quad j = k, k+1, \dots, n
$$

$$
a_{ik} = \sum_{r=1}^{n} l_{ir} u_{rk} = \sum_{r=1}^{k-1} l_{ir} u_{rk} + l_{ik} u_{kk}
$$

$$
\Rightarrow \quad l_{ik} = \frac{1}{u_{kk}} \left(a_{ik} - \sum_{r=1}^{k-1} l_{ir} u_{rk}\right), \quad i = k+1, \dots, n
$$

### 3.2 对称矩阵的 Cholesky 分解 (Cholesky 方法)

**定理：** $A \in \mathbb{R}^{n \times n}$ 对称正定，则存在唯一的对角元素为正数的下三角矩阵，使得

$$
A = LL^{T}
$$

**证明：** 对矩阵的阶数用归纳法.

当 $n = 1$ 时, $A = [a_{11}]$ 正定, 则 $a_{11} > 0$ ,

$$
A = [\sqrt{a_{11}}] [\sqrt{a_{11}}]^{T}
$$

设命题对 n-1 成立，n 阶对称正定矩阵

$$
A = \left[\begin{array}{ll} a_{11} & a^{T} \\ a & A_{22} \end{array}\right]
$$

其中 $a_{11} > 0$ ， $a \in \mathbb{R}^{n-1}$ ， $A_{22} \in \mathbb{R}^{(n-1) \times (n-1)}$ 对称正定

进一步有

$$
A = \left[\begin{array}{ll} \sqrt{a_{11}} & 0 \\ \frac{a}{\sqrt{a_{11}}} & I_{n-1} \end{array}\right] \left[\begin{array}{ll} 1 & 0 \\ 0 & \widetilde{A}_{22} \end{array}\right] \left[\begin{array}{ll} \sqrt{a_{11}} & \frac{a^{T}}{\sqrt{a_{11}}} \\ 0 & I_{n-1} \end{array}\right]
$$

其中 $I_{n-1}$ 为 $n-1$ 阶单位矩阵.

$\widetilde{A}_{22}=A_{22}-\frac{aa^{T}}{a_{11}}$ 为对称的n-1阶矩阵.

并且 $\begin{bmatrix}1 & 0 \\ 0 & \widetilde{A}_{22}\end{bmatrix}$ 对称正定，从而 $\widetilde{A}_{22}$ 对称正定

由归纳假设，存在唯一的对角元素为正数的下三角矩阵 $\widetilde{L}$ 使得 $\widetilde{A}_{22} = \widetilde{L} \widetilde{L}^{T}$。令

$L=\begin{bmatrix}\sqrt{a_{11}}&0\\ \frac{a}{\sqrt{a_{11}}}&\widetilde{L}\end{bmatrix}$ 则有 $A=LL^{T}$。设 $A \in \mathbb{R}^{n \times n}$ 对称正定，$L = [l_{ij}] \in \mathbb{R}^{n \times n}$ 为下三角矩阵且 $l_{ii} > 0$，则有

$$
A = \left[\begin{array}{cccc} a_{11} & a_{12} & \dots & a_{1n} \\ a_{21} & a_{22} & \dots & a_{2n} \\ \vdots & \vdots & \ddots & \vdots \\ a_{n1} & a_{n2} & \dots & a_{nn} \end{array}\right] = \left[\begin{array}{cccc} l_{11} & & & \\ l_{21} & l_{22} & & \\ \vdots & \vdots & \ddots & \\ l_{n1} & l_{n2} & \dots & l_{nn} \end{array}\right] \left[\begin{array}{cccc} l_{11} & l_{21} & \dots & l_{n1} \\ & l_{22} & \dots & l_{n2} \\ & & \ddots & \vdots \\ & & & l_{nn} \end{array}\right]
$$

设 $i \geq j$ ,

$$
a_{ij} = \sum_{k=1}^{j-1} l_{ik} l_{jk} + l_{ij} l_{jj}, \quad i = j, \dots, n
$$

取 j=1 有

$$
a_{i1} = l_{i1} l_{11}, \quad i = 1, \dots, n
$$

$$
\Rightarrow \quad l_{11} = \sqrt{a_{11}}, \quad l_{i1} = \frac{a_{i1}}{l_{11}}, \quad i = 2, \dots, n
$$

假设前j-1列已算好

取 i=j 得

$$
a_{jj} = \sum_{k=1}^{j-1} l_{jk}^{2} + l_{jj}^{2}
$$

$$
\Rightarrow \quad l_{jj} = \left(a_{jj} - \sum_{k=1}^{j-1} l_{jk}^{2}\right)^{1/2}
$$

对于 $i = j + 1\cdots n$ 有

$$
a_{ij} = \sum_{k=1}^{j-1} l_{ik} l_{jk} + l_{ij} l_{jj}
$$

$$
\Rightarrow l_{ij} = \frac{1}{l_{jj}} \left(a_{ij} - \sum_{k=1}^{j-1} l_{ik} l_{jk}\right), \quad i = j+1, \dots, n
$$

加边的 Cholesky 算法

记 ${A}_{i}, L_{i}$ 分别为 $A,L$ 的顺序主子式. 易知

$$
A_{i} = L_{i} L_{i}^{T}
$$

从 ${A}_{1}$ 开始, ${A}_{1} = {L}_{1}{L}_{1}^{T},{L}_{1} = \left\lbrack  {\sqrt{a}_{11}}\right\rbrack$

如果 $L_{i-1}$ 已知，则

$$
A_{i} = \left[\begin{array}{ll} A_{i-1} & c \\ c^{T} & a_{ii} \end{array}\right] = \left[\begin{array}{ll} L_{i-1} & 0 \\ h^{T} & l_{ii} \end{array}\right] \left[\begin{array}{ll} L_{i-1}^{T} & h \\ 0 & l_{ii} \end{array}\right]
$$

其中 $c = {\left( {a}_{i1}\cdots {a}_{i,i - 1}\right) }^{T}$ 已知.

由此可得.

$$
A_{i-1} = L_{i-1} L_{i-1}^{T}
$$

$$
c = L_{i-1} h \Rightarrow h = L_{i-1}^{-1} c
$$

$$
a_{ii} = h^{T} h + l_{ii}^{2} \Rightarrow l_{ii} = (a_{ii} - h^{T} h)^{1/2}
$$

**定理:** $A \in {\mathbb{R}}^{n \times n}$ 对称, $A$ 的顺序主子式 ${\Delta_i} \neq 0$, $i = 1,2,\cdots ,n$, 则存在唯一的单位下三角矩阵 $L$ 和对角矩阵 $D$ 使得
$$
A = LDL^{T}
$$

### 3.3 带状矩阵方程组的直接方法

实际应用中（如微分方程离散化），矩阵往往具有带状结构——非零元素集中在对角线附近。利用这种稀疏性，可以大幅降低存储和计算量。

#### 三对角矩阵的追赶法.

$$
A = \left[\begin{array}{ccccc} b_{1} & c_{1} & & & \\ a_{2} & b_{2} & c_{2} & & \\ & \ddots & \ddots & \ddots & \\ & & a_{n-1} & b_{n-1} & c_{n-1} \\ & & & a_{n} & b_{n} \end{array}\right]
$$

称为 三对角矩阵

$$
A = LU = \left[\begin{array}{cccc} 1 & & & \\ l_{2} & 1 & & \\ & \ddots & \ddots & \\ & & l_{n} & 1 \end{array}\right] \left[\begin{array}{cccc} u_{1} & c_{1} & & \\ & u_{2} & c_{2} & \\ & & \ddots & c_{n-1} \\ & & & u_{n} \end{array}\right]
$$

$$
\begin{aligned}
l_{i} &= \frac{a_{i}}{u_{i-1}}, \quad i = 2, 3, \dots, n \\
u_{i} &= b_{i} - l_{i} c_{i-1}, \quad i = 2, 3, \dots, n
\end{aligned}
$$

由 LU 分解可得 Ax = d 的解.

$$
\begin{aligned}
Ly &= d, \quad Ux = y \\
y_{1} &= d_{1}, \quad y_{i} = d_{i} - l_{i} y_{i-1}, \quad i = 2, 3, \dots, n \\
x_{n} &= \frac{y_{n}}{u_{n}}, \quad x_{i} = \frac{1}{u_{i}} (y_{i} - c_{i} x_{i+1}), \quad i = n-1, \dots, 1
\end{aligned}
$$

这种方法称为解三对角方程组的追赶法

追赶法实现的条件为 ${u}_{i} \neq 0,i = 1,2,\cdots ,n$ .

**定理：** 设三对角矩阵 A 满足

$$
\begin{array}{l} |b_{1}| > |c_{1}| > 0 \\ |b_{i}| \geq |a_{i}| + |c_{i}|, \quad a_{i}c_{i} \neq 0, \quad i = 2, 3, \dots, n-1 \\ |b_{n}| > |a_{n}| > 0 \end{array}
$$

则 A 非奇异 且追赶法过程中有

$$
u_{i} \neq 0
$$

$$
i = 1, 2, \dots , n
$$

$$
0 < \frac{|c_{i}|}{|u_{i}|} < 1
$$

$$
i = 1, 2, \dots , n - 1
$$

$$
|b_{i}| - |a_{i}| < |u_{i}| < |b_{i}| + |a_{i}|, \quad i = 2, 3, \dots, n
$$

#### 循环三对角方程组.

$$
A = \left[\begin{array}{ccccc} b_{1} & c_{1} & & & a_{1} \\ a_{2} & b_{2} & c_{2} & & \\ & \ddots & \ddots & \ddots & \\ & & a_{n-1} & b_{n-1} & c_{n-1} \\ c_{n} & & & a_{n} & b_{n} \end{array}\right]
$$

此时

$$
A = LU
$$

$$
L = \left[\begin{array}{ccccc} 1 & & & & \\ l_{2} & 1 & & & \\ & \ddots & \ddots & & \\ & & l_{n-1} & 1 & \\ \sigma_{1} & \dots & \sigma_{n-2} & \sigma_{n-1}+l_{n} & 1 \end{array}\right]
$$

$$
U = \left[\begin{array}{ccccc} u_{1} & c_{1} & & & \rho_{1} \\ & u_{2} & c_{2} & & \rho_{2} \\ & & \ddots & \ddots & \vdots \\ & & & u_{n-1} & c_{n-1}+\rho_{n-1} \\ & & & & u_{n} \end{array}\right]
$$

由矩阵乘法可得

$$
u_{1} = b_{1}, \quad \rho_{1} = a_{1}, \quad \sigma_{1} = \frac{c_{n}}{u_{1}}
$$

$$
l_{i} = \frac{a_{i}}{u_{i-1}}, \quad u_{i} = b_{i} - l_{i} c_{i-1}, \quad i = 2, 3, \dots, n-1
$$

$$
\rho_{i} = -l_{i} \rho_{i-1}, \quad \sigma_{i} = -\frac{\sigma_{i-1} c_{i-1}}{u_{i-1}}, \quad i = 2, 3, \dots, n-1
$$

$$
l_{n} = \frac{a_{n}}{u_{n-1}}, \quad u_{n} = b_{n} - (\sigma_{n-1} + l_{n})(c_{n-1} + \rho_{n-1}) - \sum_{i=1}^{n-2} \sigma_{i} \rho_{i}
$$

线性方程组 Ax = d 的解为

$$
\left\{ \begin{array}{l} y_{1} = d_{1} \\ y_{i} = d_{i} - l_{i} y_{i-1}, \quad i = 2, \dots, n-1 \\ y_{n} = d_{n} - \sum\limits_{i=1}^{n-2} \sigma_{i} y_{i} - (l_{n} + \sigma_{n-1}) y_{n-1} \end{array} \right.
$$

$$
\left\{ \begin{array}{l} x_{n} = \dfrac{y_{n}}{u_{n}} \\ x_{i} = \dfrac{1}{u_{i}} (y_{i} - c_{i} x_{i+1} - \rho_{i} x_{n}), \quad i = n-1, \dots, 1 \end{array} \right.
$$

#### 带状矩阵的 LU 分解

**定理：** 设 $A \in \mathbb{R}^{n \times n}$ 存在 $LU$ 分解 $A = LU$ ，且 $A$ 的上带宽为 $\Omega$ ，下带宽为 $P$ ，则 $U$ 的上带宽为 $\Omega$ 、 $L$ 的下带宽为 $P$

**证明：** 对 $n$ 做数学归纳法.

$$
A = \left[\begin{array}{ll} \alpha & \omega^{T} \\ \nu & B \end{array}\right] = \left[\begin{array}{ll} 1 & 0 \\ \nu/\alpha & I_{n-1} \end{array}\right] \left[\begin{array}{ll} 1 & 0 \\ 0 & B - \nu\omega^{T}/\alpha \end{array}\right] \left[\begin{array}{ll} \alpha & \omega^{T}/\alpha \\ 0 & I_{n-1} \end{array}\right]
$$

则 B 与 A 具有相同的上下带宽.

由归纳假设 $B - \frac{\nu \omega^{T}}{\alpha} = L_{1} U_{1}$

$L$ 的下带宽为 $P$，$U$ 的上带宽为 $\Omega$ 则

$$
A = \left[\begin{array}{ll} 1 & 0 \\ \nu/\alpha & L_{1} \end{array}\right] \left[\begin{array}{ll} \alpha & \omega^{T} \\ 0 & U_{1} \end{array}\right]
$$

为 $A$ 的满足带宽条件的 $LU$ 分解

#### 对称矩阵的 $LTL^{T}$ 型分解 (Parlett-Reid 算法)

设 $A \in \mathbb{R}^{n \times n}$ , $A^T = A$ , $A = [a_{ij}] \quad i,j = 1 \cdots n$

令 $k = \arg \max \limits_{2 \leq  i \leq  n}|a_{i,i}|$ ，取 ${p}_{i}$ 为交换第 $2$ 行, 第 $k$ 行的置换矩阵，则有

$$
\widetilde{A}^{(1)} = P_{i} A P_{i}^{T} = \left[\begin{array}{lll} a_{11} & a_{1k} & * \\ a_{k1} & a_{kk} & * \\ * & * & * \end{array}\right] = [\widetilde{a}_{ij}^{(1)}]
$$

令 ${l}_{i}^{\left( 1\right) } = \frac{a}_{i1}{a}_{k1},\;i = 3,4,\cdots ,n$

$$
M_{1} = \left[\begin{array}{cccc} 1 & 0 & & \\ 0 & 1 & & \\ 0 & -l_{3}^{(1)} & \ddots & \\ \vdots & \vdots & & \\ \vdots & \vdots & \ddots & \\ 0 & -l_{n}^{(1)} & & 1 \end{array}\right]
$$

则

$$
A^{(1)} = M_{1} P_{i} A P_{i}^{T} M_{1}^{T} = \left[\begin{array}{ccccc} a_{11} & a_{1k} & 0 & \dots & 0 \\ a_{k1} & a_{kk} & a_{23}^{(1)} & \dots & a_{2n}^{(1)} \\ 0 & a_{32}^{(1)} & & & \\ \vdots & \vdots & & * & \\ 0 & a_{n2}^{(1)} & & & \end{array}\right]
$$

依此类推可得

$$
T = A^{(n-2)} = (M_{n-2} P_{n-2} \cdots M_{1} P_{1}) A (M_{n-2} P_{n-2} \cdots M_{1} P_{1})^{T}
$$

$T$ 为三对角矩阵.

(利用选主元的高斯消元法同样的分析方法可以证明

$$
PAP^{T} = LTL^{T}
$$

其中 $P = P_{n-2} P_{n-3} \cdots P_1$ ， $L$ 为单位下三角矩阵.)

**证明:**

由算法构造过程，第 $1$ 步选取 $k = \arg\max_{2 \leq i \leq n} |a_{i1}|$，取 $P_1$ 为交换第 $2$ 行与第 $k$ 行的初等置换矩阵，则

$$
\widetilde{A}^{(1)} = P_1 A P_1^{T} = [\widetilde{a}_{ij}^{(1)}]
$$

是将 $A$ 的第 $2$ 行与第 $k$ 行、第 $2$ 列与第 $k$ 列同时交换所得的对称矩阵，使得 $|\widetilde{a}_{21}^{(1)}|$ 在第 $1$ 列的非对角元中最大。

令 $l_{i}^{(1)} = \widetilde{a}_{i1}^{(1)} / \widetilde{a}_{21}^{(1)},\; i = 3,4,\cdots,n$，构造 Gauss 变换矩阵

$$
M_1 = I - m^{(1)} e_2^{T}, \quad m^{(1)} = (0, 0, l_3^{(1)}, \dots, l_n^{(1)})^{T}
$$

则 $M_1$ 为单位下三角矩阵，其逆 $M_1^{-1} = I + m^{(1)} e_2^{T}$。作用 $M_1$ 于 $\widetilde{A}^{(1)}$ 的第 $3$ 至第 $n$ 行，消去第 $1$ 列中第 $3$ 行及以下的元素，同时右乘 $M_1^{T}$ 利用对称性消去第 $1$ 行对应位置：

$$
A^{(1)} = M_1 P_1 A P_1^{T} M_1^{T} = \left[\begin{array}{ccccc}
a_{11}^{(1)} & a_{12}^{(1)} & 0 & \cdots & 0 \\
a_{21}^{(1)} & a_{22}^{(1)} & a_{23}^{(1)} & \cdots & a_{2n}^{(1)} \\
0 & a_{32}^{(1)} & & & \\
\vdots & \vdots & & A_{22}^{(1)} & \\
0 & a_{n2}^{(1)} & & &
\end{array}\right]
$$

其中 $A_{22}^{(1)} \in \mathbb{R}^{(n-2) \times (n-2)}$ 仍为对称矩阵。此时 $A^{(1)}$ 的第 $1$ 行和第 $1$ 列除 $(1,1)$ 和 $(1,2)$（以及对称的 $(2,1)$）位置外均已化为零。

对 $A_{22}^{(1)}$ 重复上述过程：在第 $r$ 步（$r = 2, 3, \dots, n-2$），选取置换 $P_r$ 使得当前子矩阵的第 $1$ 列最大元换至 $(2,1)$ 位置，再以 $M_r$ 消去该列第 $3$ 行以下的元。每步消去一行一列，且由对称性，右乘 $M_r^{T}$ 同步消去对应的行。

经过 $n-2$ 步后，得到

$$
T = A^{(n-2)} = M_{n-2} P_{n-2} \cdots M_1 P_1 \cdot A \cdot (M_{n-2} P_{n-2} \cdots M_1 P_1)^{T}
$$

此时 $T$ 为三对角矩阵。事实上，每一步消去了当前工作列中第 $3$ 行以下的所有元素，$n-2$ 步后第 $1, 2, \dots, n-2$ 列均满足三对角条件，剩余的第 $n-1$ 和 $n$ 列自动满足。

现将乘积整理为 $LTL^{T}$ 形式。令 $L_k^{-1} = M_k$，并记

$$
\widetilde{M}_k = P_{n-2} \cdots P_{k+1} M_k P_{k+1} \cdots P_{n-2}
$$

利用置换矩阵的性质 $P_r P_r = I$ 及 $P_r^{T} = P_r$，逐步将 $M_k$ 向右交换：

$$
\begin{aligned}
T &= M_{n-2} P_{n-2} \cdots M_1 P_1 \cdot A \cdot P_1^{T} M_1^{T} \cdots P_{n-2}^{T} M_{n-2}^{T} \\
  &= (\widetilde{M}_{n-2} \cdots \widetilde{M}_1)(P_{n-2} \cdots P_1) \cdot A \cdot (P_{n-2} \cdots P_1)^{T} (\widetilde{M}_{n-2} \cdots \widetilde{M}_1)^{T}
\end{aligned}
$$

记 $P = P_{n-2} \cdots P_1$，$L^{-1} = \widetilde{M}_{n-2} \cdots \widetilde{M}_1$。由于每个 $M_k$ 为单位下三角矩阵，经置换相似变换后 $\widetilde{M}_k$ 仍为单位下三角矩阵，故其乘积 $L^{-1}$ 也是单位下三角矩阵，从而 $L$ 为单位下三角矩阵。于是

$$
L^{-1} P A P^{T} L^{-T} = T \quad \Longrightarrow \quad PAP^{T} = LTL^{T}
$$

证毕.

拓展：存在置换矩阵 $P$ ，单位下三角矩阵 $L$，使得

$$
PAP^{T} = LDL^{T}
$$

其中 $D$ 是块对角矩阵，即

$$
D = \left[\begin{array}{lll} D_{1} & & \\ & \ddots & \\ & & D_{s} \end{array}\right]
$$

$D_{i}$ 为 $1 \times 1$ 或 $2 \times 2$ 矩阵.

**证明:** 由前述 Parlett-Reid 算法，存在置换矩阵 $P$ 和单位下三角矩阵 $L_1$，使得

$$
PAP^{T} = L_1 T L_1^{T}
$$

其中 $T$ 为对称三对角矩阵。记

$$
T = \begin{bmatrix}
\alpha_1 & \beta_1 & & & \\
\beta_1 & \alpha_2 & \beta_2 & & \\
& \beta_2 & \alpha_3 & \ddots & \\
& & \ddots & \ddots & \beta_{n-1} \\
& & & \beta_{n-1} & \alpha_n
\end{bmatrix}
$$

下面证明 $T$ 可分解为 $T = L_2 D L_2^{T}$，其中 $L_2$ 为单位下三角矩阵，$D$ 为块对角矩阵且每个对角块为 $1 \times 1$ 或 $2 \times 2$。对矩阵阶数 $n$ 做归纳法。

---

**归纳基础** $n = 1$：$T = [\alpha_1]$，取 $D = [\alpha_1]$（$1 \times 1$ 块），$L_2 = [1]$，成立.

**归纳基础** $n = 2$：

$$
T = \begin{bmatrix} \alpha_1 & \beta_1 \\ \beta_1 & \alpha_2 \end{bmatrix}
$$

若取 $D = T$（$2 \times 2$ 块），$L_2 = I_2$，则 $T = L_2 D L_2^{T}$ 成立.

---

**归纳步骤：** 假设结论对阶数 $< n$ 的对称三对角矩阵成立，考虑 $n$ 阶情形。观察 $T$ 的左上角 $2 \times 2$ 子块：

### 情形 1 若 $\alpha_1 \neq 0$，使用 $1 \times 1$ 主元消去.

  取 $D_1 = [\alpha_1]$（$1 \times 1$ 块）。令 $l_2 = \beta_1 / \alpha_1$，构造消去矩阵

  $$
  M = \begin{bmatrix} 1 & & & \\ l_2 & 1 & & \\ & & I_{n-2} & \end{bmatrix}, \quad
  M^{-1} = \begin{bmatrix} 1 & & & \\ -l_2 & 1 & & \\ & & I_{n-2} & \end{bmatrix}
  $$

  则有

  $$
  M^{-1} T M^{-T} = \begin{bmatrix} \alpha_1 & 0 & \cdots & 0 \\ 0 & & & \\ \vdots & & T' & \\ 0 & & & \end{bmatrix}
  $$

  其中 $T' \in \mathbb{R}^{(n-1) \times (n-1)}$ 为对称三对角矩阵，其 $(1,1)$ 元为 $\alpha_2 - \beta_1^2 / \alpha_1$，$(1,2)$ 元为 $\beta_2$，其余不变. 由归纳假设，存在单位下三角矩阵 $L_2'$ 和块对角矩阵 $D'$ 使得 $T' = L_2' D' (L_2')^{T}$.

  令

  $$
  L_2 = M \begin{bmatrix} 1 & \\ & L_2' \end{bmatrix}, \quad
  D = \begin{bmatrix} D_1 & \\ & D' \end{bmatrix}
  $$

  则 $T = L_2 D L_2^{T}$，且 $D$ 的块结构为首块 $1 \times 1$、其余由 $D'$ 的块组成.

### 情形 2 若 $\alpha_1 = 0$，使用 $2 \times 2$ 主元.

  此时 $\beta_1 \neq 0$（否则 $T$ 的第 $1$ 行第 $1$ 列全为零，$T$ 已是块对角形式，直接归约为 $n-1$ 阶问题）. 取 $2 \times 2$ 块

  $$
  D_1 = \begin{bmatrix} \alpha_1 & \beta_1 \\ \beta_1 & \alpha_2 \end{bmatrix} = \begin{bmatrix} 0 & \beta_1 \\ \beta_1 & \alpha_2 \end{bmatrix}
  $$

  由于 $\beta_1 \neq 0$，$D_1$ 非奇异. 令 $l_{i} = \beta_{i-1} / \beta_1$（当 $i \geq 3$ 且第 $i$ 行有来自 $T$ 第 $2$ 列的填充元时），但此时更直接地，将 $T$ 分块为

  $$
  T = \begin{bmatrix} D_1 & B^{T} \\ B & T'' \end{bmatrix}, \quad
  B = \begin{bmatrix} 0 & \beta_2 & & \\ 0 & 0 & & \end{bmatrix} \in \mathbb{R}^{(n-2) \times 2}
  $$

  构造消去矩阵

  $$
  M = \begin{bmatrix} I_2 & 0 \\ B D_1^{-1} & I_{n-2} \end{bmatrix}
  $$

  注意到 $B D_1^{-1}$ 的第 $1$ 列全为零（因为 $B$ 的第 $1$ 列为零），第 $2$ 列仅第 $1$ 个分量非零，故 $M$ 仅在 $(3,2)$ 位置有一个非零元 $\beta_2 / \beta_1$. 类似情形 1，有

  $$
  M^{-1} T M^{-T} = \begin{bmatrix} D_1 & 0 \\ 0 & T'' - B D_1^{-1} B^{T} \end{bmatrix}
  $$

  其中 $T'' - B D_1^{-1} B^{T}$ 为 $n-2$ 阶对称三对角矩阵（消去仅改变 $(1,1)$ 元 $\alpha_3 \leftarrow \alpha_3 - \beta_2^2 \alpha_2 / \beta_1^2$）. 由归纳假设得 $T'' - B D_1^{-1} B^{T} = L_2'' D'' (L_2'')^{T}$.

  令

  $$
  L_2 = M \begin{bmatrix} I_2 & \\ & L_2'' \end{bmatrix}, \quad
  D = \begin{bmatrix} D_1 & \\ & D'' \end{bmatrix}
  $$

  则 $T = L_2 D L_2^{T}$，且 $D$ 以 $2 \times 2$ 块 $D_1$ 开头.

---

综上，由归纳法，任意对称三对角矩阵 $T$ 存在分解 $T = L_2 D L_2^{T}$，其中 $L_2$ 为单位下三角矩阵，$D$ 为块对角矩阵且每个对角块为 $1 \times 1$ 或 $2 \times 2$. 结合 Parlett-Reid 分解：

$$
PAP^{T} = L_1 T L_1^{T} = L_1 (L_2 D L_2^{T}) L_1^{T} = (L_1 L_2) D (L_1 L_2)^{T}
$$

令 $L = L_1 L_2$，则 $L$ 仍为单位下三角矩阵（两个单位下三角矩阵的乘积），从而

$$
PAP^{T} = LDL^{T}
$$

证毕.

---

**本章小结：** 直接解法的核心思路是将 $A$ 分解为三角矩阵的乘积，然后通过前代和回代求解。Gauss 消去法是理解这一思路的起点，选主元技术保证了数值稳定性。对于不同结构的矩阵，我们有专门的分解方法：对称正定矩阵用 Cholesky，三对角矩阵用追赶法，一般对称矩阵可用 Parlett-Reid 化为三对角形式再处理。直接解法的计算复杂度为 $O(n^3)$，当矩阵规模很大时，下一章介绍的迭代解法可能更加高效。

[← 上一篇：基本概念](/posts/numerical-analysis-1/01-basic-concepts/)

[下一篇：矩阵的条件数及误差分析 →](/posts/numerical-analysis-1/03-condition-number-error-analysis/)
