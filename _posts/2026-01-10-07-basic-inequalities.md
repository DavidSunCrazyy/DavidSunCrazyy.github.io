---
layout: post
title: "概率论基本不等式"
permalink: /posts/probability-basic-inequalities/
tags: probability-theory
use_math: true
---

本文档整理概率论中的基本不等式，这些不等式是深入理解概率论的基础工具。

## 1. 切比雪夫不等式 (Chebyshev Inequality)

**定理** 设 $X$ 为随机变量，$\varphi$ 是 $[0,\infty)$ 上的严格正增函数。则对任意 $x>0$，有

$$\mathbb{P}[\|X\|\ge x] \le \frac{\mathbb{E}[\varphi(\|X\|)]}{\varphi(x)}$$

**常用形式**：当 $\varphi(x) = x^2$ 时，得到经典的切比雪夫不等式：

$$\mathbb{P}[\|X-\mathbb{E}[X]\| \ge \varepsilon] \le \frac{\operatorname{Var}(X)}{\varepsilon^2}$$

## 2. 赫尔德不等式 (Hölder Inequality)

**定理** 设 $X,Y$ 为随机变量。对于 $1<p<\infty$ 且 $1/p+1/q=1$，有

$$\mathbb{E}[\|XY\|] \le \mathbb{E}[\|X\|^p]^{1/p} \cdot \mathbb{E}[\|Y\|^q]^{1/q}$$

**特例**：当 $p=q=2$ 时，得到柯西-施瓦茨不等式：

$$\mathbb{E}[\|XY\|] \le \sqrt{\mathbb{E}[\|X\|^2] \cdot \mathbb{E}[\|Y\|^2]}$$

## 3. 闵可夫斯基不等式 (Minkowski Inequality)

**定理** 对于 $1\le p < \infty$，有

$$\mathbb{E}[\|X+Y\|^p]^{1/p} \le \mathbb{E}[\|X\|^p]^{1/p} + \mathbb{E}[\|Y\|^p]^{1/p}$$

**意义**：这个不等式说明 $L^p$ 范数满足三角不等式，因此 $L^p$ 空间构成赋范线性空间。

## 4. 詹森不等式 (Jensen's Inequality)

**定理** 若 $\varphi$ 是凸函数，则

$$\varphi(\mathbb{E}[X]) \le \mathbb{E}[\varphi(X)]$$

**条件期望版本**：设 $\varphi$ 为凸函数且 $\mathbb{E}[\|\varphi(X)\|]<\infty$，则

$$\mathbb{E}[\varphi(X)\|\mathcal{A}] \ge \varphi(\mathbb{E}[X\|\mathcal{A}])$$

**常用推论**：
- $\|\mathbb{E}[X\|\mathcal{A}]\| \le \mathbb{E}[\|X\|\|\mathcal{A}]$ （取 $\varphi(x)=\|x\|$）
- $\mathbb{E}[X\|\mathcal{A}]^2 \le \mathbb{E}[X^2\|\mathcal{A}]$ （取 $\varphi(x)=x^2$）

## 5. 条件期望的绝对值不等式

**定理** 若 $Z = \mathbb{E}[X\|\mathcal{A}]$，则
- $\mathbb{E}[Z] = \mathbb{E}[X]$
- $\|Z\| \le \mathbb{E}[\|X\|\|\mathcal{A}]$ a.s.
- $\mathbb{E}[\|Z\|] \le \mathbb{E}[\|X\|]$
- $\mathbb{E}[\|Z\|\mathbb{1}\_A] \le \mathbb{E}[\|X\|\mathbb{1}\_A]$ 对所有 $A \in \mathcal{A}$ 成立

**绝对值比较**：$\mathbb{E}[X\|\mathcal{A}] \le \mathbb{E}[Y\|\mathcal{A}]$ a.s. 当且仅当 $\mathbb{E}[X\mathbb{1}\_A] \le \mathbb{E}[Y\mathbb{1}\_A]$ 对所有 $A\in\mathcal{A}$ 成立。

## 6. Kolmogorov 不等式

**定理** 设 $\{X_n\}$ 为独立随机变量，若 $\mathbb{E}[X_n] = 0$ 且 $\mathbb{E}[X_n^2]<\infty$。定义 $S_n = \sum_{j=1}^n X_j$。则有

$$\mathbb{P}\left[\max_{1\le j\le n}\|S_j\|\ge \varepsilon\right] \le \frac{\mathbb{E}[S_n^2]}{\varepsilon^2}$$

**逆形式**：设 $\{X_n\}$ 为有界的独立随机变量：存在常数 $A$ 使得对所有 $n$，$\|X_n\| \le A$ 几乎必然成立。定义 $S_n = \sum_{j=1}^n X_j$。则有

$$\mathbb{P}\left[\max_{1\le j\le n} \|S_j\| \le B\right] \le \frac{(2B+A)^2}{\operatorname{Var}(S_n)}$$

## 7. Doob 极大不等式

**定理** 设 $\{X_n\}$ 为非负下鞅。定义 $X_n^* = \max_{k\le n} X_k$。则

$$\lambda \mathbb{P}(X_n^* \ge \lambda) \le \mathbb{E}[X_n \mathbb{1}_{X_n^*\ge \lambda}] \le \mathbb{E}[X_n]$$

**$L^p$ 版本**：设 $\{X_n\}$ 为非负下鞅。则对所有 $p>1$ 有

$$\|X_n^*\|_p \le \frac{p}{p-1}\|X_n\|_p$$

## 8. Ottaviani 不等式

**定理**

$$\mathbb{P}\left(\max_{m<j\le n} \|S_{m,j}\|>\varepsilon+\lambda\right) \cdot \min_{m<k\le n} \mathbb{P}(\|S_{k,n}\|\le \varepsilon) \le \mathbb{P}(\|S_{m,n}\|>\lambda)$$

其中 $S_{m,j} = \sum_{i=m+1}^j X_i$。

## 不等式关系图

```
切比雪夫不等式
    └─> 经典形式：控制尾概率

赫尔德不等式 (p,q共轭)
    └─> 柯西-施瓦茨不等式 (p=q=2)

闵可夫斯基不等式
    └─> Lp范数的三角不等式

詹森不等式
    └─> 条件期望版本
          └─> 绝对值不等式
                └─> 条件期望的单调性

Kolmogorov不等式 (独立和)
    ├─> 与Doob极大不等式类似
    └─> 适用于部分和的最大值

Doob极大不等式 (下鞅)
    └─> Lp版本
```

## 应用场景总结

| 不等式 | 主要应用 |
|--------|----------|
| 切比雪夫 | 控制随机变量偏离其均值的概率 |
| 赫尔德 | 估计乘积的期望，证明Lp空间的连续性 |
| 闵可夫斯基 | 证明Lp空间的完备性 |
| 詹森 | 证明凸性性质，导出其他不等式 |
| Kolmogorov | 研究独立随机变量和的收敛性 |
| Doob | 研究鞅的极大值和大数定律 |
