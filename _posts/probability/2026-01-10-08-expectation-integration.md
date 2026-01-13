---
layout: post
title: "Probability Theory I 期望与积分理论"
permalink: /posts/expectation-integration-theory/
tags: probability-theory
use_math: true
---

本文档整理期望理论中的核心内容，包括极限定理、矩的概念以及期望的基本性质。

**上一篇**：[概率论基本不等式](/posts/probability-basic-inequalities/)

## 1. 收敛定理

### 1.1 控制收敛定理 (Dominated Convergence Theorem, DCT)

**定理** 若 $\lim_n X_n = X$ a.s. 且 $\|X_n\| \le Y$ a.s.，其中 $\mathbb{E}[Y]<\infty$。则 $X$ 可积且

$$\lim_n\mathbb{E}[\|X_n-X\|] = 0, \quad \lim_n \mathbb{E}[X_n] = \mathbb{E}[X]$$

**意义**：这是概率论中最重要和最常用的定理之一，允许在某些条件下交换极限和期望的顺序。

### 1.2 单调收敛定理 (Monotone Convergence Theorem, MCT)

**定理** 若 $X_n \ge 0$ 且 $X_n \uparrow X$ a.s.（即 $X_n$ 单调递增收敛到 $X$），则

$$\lim_n \mathbb{E}[X_n] = \mathbb{E}[X]$$

**特点**：不需要控制函数，但要求序列单调递增且非负。

### 1.3 法图引理 (Fatou's Lemma)

**定理** 若 $X_n \ge 0$ a.s.，则

$$\mathbb{E}[\liminf_n X_n] \le \liminf_n \mathbb{E}[X_n]$$

**注意**：法图引理是"弱"形式的单调收敛定理，允许我们用序列期望的极限下界来估计极限的期望。

**注**：这三个定理是测度论中积分理论的三大支柱，在 $L^1$ 理论中经常被使用。

## 2. 矩 (Moments)

**定义** 对于任意 $p \in (0,\infty)$，对于 $X \in L^p$，$\mathbb{E}[\|X\|^p]$ 称为 $X$ 的 $p$ 阶矩。

**常用矩**：
- **一阶矩**：$\mathbb{E}[X]$ —— 均值/期望
- **二阶矩**：$\mathbb{E}[X^2]$ —— 与方差相关
- **二阶中心矩**：$\operatorname{Var}(X) = \mathbb{E}[(X-\mathbb{E}[X])^2] = \mathbb{E}[X^2] - (\mathbb{E}[X])^2$

### 2.1 矩的不等式

对于 $0 < p < q$：
- 若 $X \in L^q$，则 $X \in L^p$（由 Lyapunov 不等式）
- $\mathbb{E}[\|X\|^p]^{1/p} \le \mathbb{E}[\|X\|^q]^{1/q}$

### 2.2 矩与分布函数的关系

**引理**：

$$\sum_{n=1}^\infty \mathbb{P}[\|X\|\ge n] \le \mathbb{E}[\|X\|] \le \sum_{n=1}^\infty \mathbb{P}[\|X\|\ge n]+1$$

**更一般形式**：

$$\mathbb{E}[\|X\|^p] = \int_0^\infty p t^{p-1} \mathbb{P}[\|X\| \ge t] \, dt$$

## 3. 协方差 (Covariance)

**定义**

$$\operatorname{cov}(X,Y) := \mathbb{E}[XY] - \mathbb{E}[X]\mathbb{E}[Y]$$

**性质**：
- $\operatorname{cov}(X,X) = \operatorname{Var}(X)$
- $\operatorname{cov}(X,Y) = \operatorname{cov}(Y,X)$（对称性）
- $\operatorname{cov}(aX+b, cY+d) = ac \cdot \operatorname{cov}(X,Y)$
- $\operatorname{cov}(X+Y, Z) = \operatorname{cov}(X,Z) + \operatorname{cov}(Y,Z)$（双线性）

**相关系数**：

$$\rho(X,Y) = \frac{\operatorname{cov}(X,Y)}{\sqrt{\operatorname{Var}(X)\operatorname{Var}(Y)}}$$

满足 $\|\rho(X,Y)\| \le 1$（由柯西-施瓦茨不等式）。

**独立性**：若 $X$ 和 $Y$ 独立，则 $\operatorname{cov}(X,Y) = 0$。反之不然。

## 4. 期望的性质总结

### 4.1 线性性质

$$\mathbb{E}[aX + bY] = a\mathbb{E}[X] + b\mathbb{E}[Y]$$

### 4.2 单调性

若 $X \le Y$ a.s.，则 $\mathbb{E}[X] \le \mathbb{E}[Y]$。

### 4.3 条件期望的性质

设 $\mathcal{A}$ 为子 $\sigma$-代数：

- **线性性**：$\mathbb{E}[aX+bY\|\mathcal{A}] = a\mathbb{E}[X\|\mathcal{A}] + b\mathbb{E}[Y\|\mathcal{A}]$
- **取期望**：$\mathbb{E}[\mathbb{E}[X\|\mathcal{A}]] = \mathbb{E}[X]$
- **塔式性质**：若 $\mathcal{A}\_1 \subset \mathcal{A}\_2$，则 $\mathbb{E}[\mathbb{E}[X\|\mathcal{A}\_2]\|\mathcal{A}\_1] = \mathbb{E}[X\|\mathcal{A}\_1]$
- **独立性的简化**：若 $X$ 与 $\mathcal{A}$ 独立，则 $\mathbb{E}[X\|\mathcal{A}] = \mathbb{E}[X]$

## 5. 收敛定理关系图

```
                        极限与期望可交换性
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
   控制收敛定理(DCT)      单调收敛定理(MCT)       法图引理
        │                     │                     │
   需要控制函数           非负+单调递增          仅给出不等式
   │                     │                     │
   └─────────────────────┴─────────────────────┘
                         │
                         ▼
                  期望的连续性
```

## 7. 应用场景总结

| 定理 | 典型应用场景 |
|------|-------------|
| DCT | 有界随机变量序列，有控制函数的收敛 |
| MCT | 单调递增的非负序列 |
| 法图引理 | 证明期望下界的估计 |
| 条件期望 | 鞅论， filtrations，平滑化 |

## 8. 重要提示

1. **交换极限和期望的式子很常用**：在 $L^1$ 的理论里更是经常看到。
2. **控制函数的存在性**：在应用 DCT 时，关键是找到合适的控制函数。
3. **矩的存在性**：高阶矩存在蕴含低阶矩存在，但反之不成立。

---

**下一篇**：[常用概率分布](/posts/common-probability-distributions/)
