---
layout: post
title: "大数定律专题"
permalink: /posts/law-large-numbers/
tags: probability-theory
use_math: true
---

本文档整理大数定律理论，包括 Borel-Cantelli 引理、弱大数定律、强大数定律以及相关的证明工具。

## 一、Borel-Cantelli 引理

Borel-Cantelli 引理是研究事件无穷次发生概率的核心工具，在概率极限理论中具有基础地位。

### 1.1 第一 Borel-Cantelli 引理

**定理** 对于任意事件序列 $\{E_n\}$，有

$$\sum_n \mathbb{P}[E_n] < \infty \implies \mathbb{P}[E_n \text{ i.o.}] = 0$$

其中 "i.o." 表示 "infinitely often"（无穷次发生）。

**证明思路**：利用单调收敛定理和次可加性。

### 1.2 第二 Borel-Cantelli 引理

**定理** 若事件 $\{E_n\}$ **独立**，则

$$\sum_n \mathbb{P}[E_n] = \infty \implies \mathbb{P}[E_n \text{ i.o.}] = 1$$

**注意**：独立性条件至关重要。没有独立性时结论不成立。

### 1.3 与收敛性的联系

**引理**：$X_n \to X$ a.s. 当且仅当

$$\mathbb{P}[\|X_n-X\| > \epsilon \text{ i.o.}] = 0, \quad \forall \epsilon > 0$$

**推论**：依概率收敛蕴含沿子序列的几乎必然收敛。

---

## 二、Kolmogorov 不等式

Kolmogorov 不等式是独立随机变量和的极大值概率估计，是证明强大数定律的关键工具。

### 2.1 基本形式

**定理** 设 $\{X_n\}$ 为独立随机变量。若 $\mathbb{E}[X_n] = 0$ 且 $\mathbb{E}[X_n^2] < \infty$。定义 $S_n = \sum_{j=1}^n X_j$。则有

$$\mathbb{P}\left[\max_{1 \le j \le n} \|S_j\| \ge \varepsilon\right] \le \frac{\mathbb{E}[S_n^2]}{\varepsilon^2}$$

**意义**：这个不等式将部分和的最大值与最终和的方差联系起来。

### 2.2 逆形式

**定理** 设 $\{X_n\}$ 为有界的独立随机变量：存在常数 $A$ 使得对所有 $n$，$\|X_n\| \le A$ 几乎必然成立。定义 $S_n = \sum_{j=1}^n X_j$。则有

$$\mathbb{P}\left[\max_{1 \le j \le n} \|S_j\| \le B\right] \le \frac{(2B+A)^2}{\operatorname{Var}(S_n)}$$

---

## 三、Kolmogorov 收敛准则

**定理** 设 $\{X_n\}$ 为独立随机变量。若 $\sum_n \operatorname{Var}(X_n) < \infty$，则 $\sum_n (X_n - \mathbb{E}[X_n])$ 几乎必然收敛。

**应用**：这是证明独立随机变量级数收敛的重要准则。

---

## 四、Kronecker 引理

**定理** 设 $\{x_n\}$ 为实数序列，$\{a_n\}$ 为满足 $0 < a_n \uparrow \infty$ 的数列。则

$$\sum_n \frac{x_n}{a_n} \text{ 收敛} \implies \frac{1}{a_n} \sum_{j=1}^n x_j \to 0$$

**意义**：将级数收敛转化为平均收敛，是从强大数定律到弱大数定律的关键步骤。

---

## 五、Lévy 定理

**定理** 若 $X_n$ 是独立随机变量序列，则级数 $\sum_n X_n$ 依概率收敛等价于其几乎必然收敛。

**表述**：
$$\sum_n X_n \text{ 依概率收敛} \iff \sum_n X_n \text{ 几乎必然收敛}$$

（参考：Kai Lai Chung 5.3.4）

**意义**：对于独立随机变量级数，依概率收敛和几乎必然收敛等价。

---

## 六、弱大数定律 (WLLN)

### 6.1 独立同分布情形

**定理** 设 $\{X_n\}$ 为独立同分布，具有有限均值 $m$。定义 $S_n = \sum_{j=1}^n X_j$，则有

$$\frac{S_n}{n} \to m \quad \text{依概率}$$

### 6.2 Markov 条件

**定理** 设 $\{X_n\}$ 为独立随机变量，满足 Markov 条件：

$$\frac{1}{n^2} \operatorname{Var}(S_n) \to 0 \quad \text{当 } n \to \infty$$

则

$$\frac{S_n - \mathbb{E}[S_n]}{n} \to 0 \quad \text{依概率}$$

---

## 七、强大数定律 (SLLN)

### 7.1 独立同分布情形 (Kolmogorov SLLN)

**定理** 设 $\{X_n\}$ 为独立同分布。定义 $S_n = \sum_{j=1}^n X_j$。则有：

- $\mathbb{E}[\|X_1\|] < \infty \implies \frac{S_n}{n} \to \mathbb{E}[X_1]$ 几乎必然
- $\mathbb{E}[\|X_1\|] = \infty \implies \limsup_n \frac{\|S_n\|}{n} = \infty$ 几乎必然

**意义**：第一个结论是经典的强大数定律；第二个结论说明如果期望不存在，平均不会收敛到任何有限值。

**证明**：依赖于
- Kronecker 引理
- Kolmogorov 收敛准则

### 7.2 推论：弱大数定律

设 $\{X_n\}$ 为独立同分布，具有有限均值 $m$。定义 $S_n = \sum_{j=1}^n X_j$，则有

$$\frac{S_n}{n} \to m \quad \text{依概率}$$

**注**：弱大数定律是强大数定律的直接推论，因为几乎必然收敛蕴含依概率收敛。

---

## 八、三级数定理 (Three-Series Theorem)

三级数定理给出了独立随机变量级数几乎必然收敛的充要条件。

### 8.1 定理陈述

**定理** 设 $\{X_n\}$ 为独立随机变量，对固定常数（存在）$A > 0$ 定义截断：$Y_n = X_n \mathbb{1}\_{\{\|X_n\| < A\}}$。

则级数 $\sum_n X_n$ 几乎必然收敛当且仅当以下三个级数都收敛：

$$
\begin{aligned}
&\sum_n \mathbb{P}[\|X_n\| > A] \\
&\sum_n \mathbb{E}[Y_n] \\
&\sum_n \operatorname{var}(Y_n)
\end{aligned}
$$

### 8.2 意义

三级数定理是独立随机变量级数理论的基石，它将级数收敛问题分解为：
1. 尾部概率的可和性
2. 截断期望的可和性
3. 截断方差的可和性

---

## 九、等价随机变量

### 9.1 定义

**定义** 两个随机变量序列 $\{X_n\}$ 和 $\{Y_n\}$ **等价**，如果

$$\sum_n \mathbb{P}[X_n \ne Y_n] < \infty$$

### 9.2 性质

设 $\{X_n\}$ 和 $\{Y_n\}$ 等价，则由 Borel-Cantelli 引理，存在 $\Omega_0$ 且 $\mathbb{P}[\Omega_0] = 1$ 使得，对任意 $\omega \in \Omega_0$，有 $X_n(\omega) = Y_n(\omega)$ 对所有但有限多个 $n$ 成立。

因此：
- $\sum_n (X_n - Y_n)$ 几乎必然收敛
- $\frac{1}{n}\sum_{j=1}^n (X_j - Y_j) \to 0$ 几乎必然
- $\frac{1}{n} \sum_{j=1}^n X_j \to X$ 依概率蕴含 $\frac{1}{n} \sum_{j=1}^n Y_j \to X$ 依概率

### 9.3 应用

等价随机变量理论允许我们通过截断方法简化问题，这是证明大数定律的标准技巧。

---

## 十、Ottaviani 不等式

**定理**

$$\mathbb{P}\left(\max_{m<j \le n} \|S_{m,j}\| > \varepsilon+\lambda\right) \cdot \min_{m<k \le n} \mathbb{P}(\|S_{k,n}\|\le \varepsilon) \le \mathbb{P}(\|S_{m,n}\| > \lambda)$$

其中 $S_{m,j} = \sum_{i=m+1}^j X_i$。

**证明思路**：

$$
\begin{aligned}
&\bigcup_{k=m+1}^n \{\max_{m<j \le k-1} \|S_{m,j}\| \le \varepsilon+\lambda, \|S_{m,k}\| > \varepsilon+\lambda; \|S_{k,n}\| \le \varepsilon\} \\
&\subset \{\|S_{m,n} > \lambda\|\}
\end{aligned}
$$

$$
\sum_{k=m+1}^n \mathbb{P}(\max_{m<j \le k-1} \|S_{m,j}\| \le \varepsilon+\lambda, \|S_{m,k}\| > \varepsilon+\lambda) \cdot \mathbb{P}(\|S_{k,n}\| \le \varepsilon) \le \mathbb{P}(\|S_{m,n}\| > \lambda)
$$

用 $\min_{m<j \le n} \mathbb{P}(\|S_{m,j}\| \le \varepsilon)$ 替代 $\mathbb{P}(\|S_{k,n}\| \le \varepsilon)$。

---

## 十一、大数定律理论体系图

```
                Borel-Cantelli 引理
                        │
        ┌───────────────┼───────────────┐
        ▼               ▼               ▼
  Kolmogorov    Kolmogorov     Kronecker 引理
   不等式        收敛准则              │
        │               │               │
        └───────┬───────┘               │
                ▼                       ▼
            三级数定理 ─────────→ 强大数定律
                                           │
                                           ▼
                                     弱大数定律
```

---

## 十二、定理关系与依赖

| 定理 | 证明依赖 | 主要应用 |
|------|---------|----------|
| Borel-Cantelli 引理 | 单调收敛定理 | 几乎必然收敛的判定 |
| Kolmogorov 不等式 | Doob 停时定理 | 部分和极大值估计 |
| Kolmogorov 收敛准则 | Kolmogorov 不等式 | 级数收敛判定 |
| Kronecker 引理 | 实分析 | SLLN 的证明 |
| 三级数定理 | Kolmogorov 不等式、收敛准则 | 独立级数收敛 |
| 强大数定律 | Kronecker 引理、收敛准则 | 平均的稳定性 |
| 弱大数定律 | 强大数定律 | 估计的相合性 |

---

## 十三、应用指南

### 13.1 证明技巧总结

| 目标 | 推荐工具 | 关键步骤 |
|------|----------|----------|
| 证明 a.s. 收敛 | Borel-Cantelli | 构造事件，验证概率级数收敛 |
| 估计极大值 | Kolmogorov 不等式 | 计算方差，应用不等式 |
| 独立级数收敛 | 三级数定理 | 验证三个级数 |
| SLLN | 截断 + 等价变量 | 转化为有限方差情形 |
| 平均收敛 | Kronecker 引理 | 从级数收敛推导平均收敛 |

### 13.2 条件对比

| 定理 | 关键条件 | 结论类型 |
|------|----------|----------|
| WLLN (i.i.d.) | 有限均值 | 依概率收敛 |
| SLLN (i.i.d.) | 有限期望 | 几乎必然收敛 |
| 三级数定理 | 三个级数收敛 | 几乎必然收敛 |
| Kolmogorov 收敛准则 | 方差级数收敛 | 几乎必然收敛 |

---

## 十四、重要提示

1. **大数定律的本质**：大数定律说明在适当条件下，大量独立重复试验的平均值会稳定在期望值附近。

2. **强弱对比**：
   - 强大数定律：几乎所有样本路径的平均都收敛
   - 弱大数定律：平均偏离期望的概率趋于零

3. **截断方法**：在处理无界随机变量时，截断是标准技巧，配合等价随机变量理论使用。

4. **方差的作用**：方差控制了随机变量的波动，Kolmogorov 不等式和收敛准则都依赖于方差的可和性。
