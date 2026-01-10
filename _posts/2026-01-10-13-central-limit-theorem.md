---
layout: post
title: "中心极限定理专题"
permalink: /posts/central-limit-theorem/
tags: probability-theory
use_math: true
---

本文档整理中心极限定理理论，包括特征函数理论、经典中心极限定理、林德伯格-费勒定理及其推论。

## 一、特征函数

特征函数是研究概率分布和极限定理的重要工具，是证明中心极限定理的关键。

### 1.1 定义

**定义** 随机变量 $X$ 的分布为 $\mu$，其特征函数定义为：

$$f: \mathbb{R} \to \mathbb{C}, \quad f(t) := \mathbb{E}[e^{itX}] = \int e^{itx} \mu[dx]$$

**直观理解**：特征函数是分布的傅里叶变换，将概率分布问题转化为解析问题。

### 1.2 基本性质

1. **初值**：$f(0) = 1$
2. **有界性**：$\|f(t)\| \le 1$
3. **共轭对称性**：$f(-t) = \overline{f(t)}$
4. **一致连续性**：$f$ 一致连续

### 1.3 变换性质

1. **线性变换**：$f_{aX+b}(t) = f_X(at) \cdot e^{ibt}$
2. **对称性**：$f_{-X}(t) = f_X(-t) = \overline{f_X(t)}$

### 1.4 独立和的性质

1. **独立随机变量之和**：若 $X, Y$ 独立，则 $f_{X+Y} = f_X \cdot f_Y$

**证明**：$\mathbb{E}[e^{it(X+Y)}] = \mathbb{E}[e^{itX}e^{itY}] = \mathbb{E}[e^{itX}]\mathbb{E}[e^{itY}]$

2. **凸组合**：设 $\{f_n\}$ 为特征函数，$\{\lambda_n\}$ 满足 $\sum_n \lambda_n = 1$，则 $\sum_n \lambda_n f_n$ 是特征函数。

3. **模平方**：若 $f$ 是特征函数，则 $\|f\|^2$ 也是。

### 1.5 常见分布的特征函数

| 分布 | 参数 | 特征函数 $f(t)$ |
|------|------|------------------|
| Dirac 测度 | 位置 $a$ | $e^{iat}$ |
| 伯努利分布 | $p=1/2$ 在 $\{-1,1\}$ | $\cos(t)$ |
| 均匀分布 | $[-a,a]$ | $\frac{\sin(at)}{at}$ |
| 指数分布 | $\lambda > 0$ | $\frac{\lambda}{\lambda-it}$ |
| 正态分布 | $\mathcal{N}(m, \sigma^2)$ | $\exp(imt - \frac{\sigma^2 t^2}{2})$ |
| 泊松分布 | $\lambda > 0$ | $\exp(\lambda(e^{it}-1))$ |
| 几何分布 | $p \in (0,1)$ | $\frac{pe^{it}}{1-(1-p)e^{it}}$ |

### 1.6 反演公式

**定理** 设 $f$ 为概率测度 $\mu$ 的特征函数。对于 $x < y$，有

$$\mu[(x,y)] + \frac{1}{2}\mu[\{x\}] + \frac{1}{2}\mu[\{y\}] = \lim_{T \to \infty} \frac{1}{2\pi} \int_{-T}^T \frac{e^{-itx}-e^{-ity}}{it} f(t) \, dt$$

**推论 1**（唯一性）：若两个概率测度 $\mu$ 和 $\nu$ 有相同的特征函数，则 $\mu = \nu$

**推论 2**（点质量）：对于每个 $x$，有

$$\lim_{T \to \infty} \frac{1}{2T} \int_{-T}^T e^{-itx} f(t) \, dt = \mu[\{x\}]$$

$$\lim_{T \to \infty} \frac{1}{2T} \int_{-T}^T \|f(t)\|^2 \, dt = \sum_{x \in \mathbb{R}} \mu[\{x\}]^2$$

### 1.7 特征函数与收敛

**连续性定理**：$\mu_n \implies \mu$ 当且仅当 $f_n(t) \to f(t)$ 对所有 $t$，其中 $f_n, f$ 是对应的特征函数。

---

## 二、经典中心极限定理 (CLT)

### 2.1 定理陈述

**定理** 设 $\{X_n\}$ 为独立同分布，且 $\mathbb{E}[X_1] = m$，$\operatorname{var}(X_1) = \sigma^2 \in (0,\infty)$。定义 $S_n = \sum_{j=1}^n X_j$。

则

$$\frac{S_n - nm}{\sqrt{n}} \implies \mathcal{N}(0, \sigma^2)$$

**等价形式**：设 $\bar{X}\_n = \frac{1}{n}\sum_{j=1}^n X_j$，则

$$\sqrt{n}(\bar{X}\_n - m) \implies \mathcal{N}(0, \sigma^2)$$

**标准化形式**：设 $Y_n = \frac{S_n - nm}{\sigma\sqrt{n}}$，则 $Y_n \implies \mathcal{N}(0,1)$。

### 2.2 直观理解

中心极限定理说明：大量独立同分布随机变量的和（适当标准化后）的分布趋近于正态分布，无论原始分布是什么形状（只要方差有限）。

### 2.3 证明思路（特征函数方法）

1. 设 $Y_i = \frac{X_i - m}{\sigma}$，则 $\mathbb{E}[Y_i] = 0$，$\mathbb{E}[Y_i^2] = 1$，且 $Y_n = \frac{1}{\sqrt{n}}\sum_{j=1}^n Y_j$
2. 特征函数：$f_{Y_n}(t) = \left[f_Y\left(\frac{t}{\sqrt{n}}\right)\right]^n$
3. 泰勒展开：$f_Y(t) = 1 + it\mathbb{E}[Y] - \frac{t^2}{2}\mathbb{E}[Y^2] + o(t^2) = 1 - \frac{t^2}{2} + o(t^2)$
4. 取极限：$\lim_{n \to \infty} f_{Y_n}(t) = \lim_{n \to \infty} \left[1 - \frac{t^2}{2n} + o\left(\frac{t^2}{n}\right)\right]^n = e^{-t^2/2}$
5. 识别：$e^{-t^2/2}$ 是 $\mathcal{N}(0,1)$ 的特征函数

---

## 三、林德伯格-费勒定理 (Lindberg-Feller Theorem)

林德伯格-费勒定理是中心极限定理的最一般形式，适用于非同分布的独立随机变量序列。

### 3.1 定理陈述

**定理** 对于每个 $n$，设 $\{X_{n,m}\} (1 \le m \le n)$ 为独立随机变量，且 $\mathbb{E}[X_{n,m}] = 0$。

如果满足：
1. **林德伯格条件**：对于所有 $\epsilon > 0$，有

$$\sum_{m=1}^n \mathbb{E}[X_{n,m}^2 \mathbb{1}\_{\{\|X_{n,m}\|>\epsilon\}}] \to 0 \quad \text{当 } n \to \infty$$

2. **方差条件**：

$$\sum_{m=1}^n \mathbb{E}[X_{n,m}^2] \to \sigma^2 < \infty \quad \text{当 } n \to \infty$$

则

$$\sum_{m=1}^n X_{n,m} \implies \mathcal{N}(0, \sigma^2)$$

### 3.2 林德伯格条件的直观理解

林德伯格条件说明：单个随机变量 $X_{n,m}$ 对总方差的贡献可以任意小（在概率意义下），即没有"主导"项。

**等价表述**：对于任意 $\epsilon > 0$，

$$\sum_{m=1}^n \mathbb{E}[X_{n,m}^2 \mathbb{1}\_{\{\|X_{n,m}\|>\epsilon\}}] = o\left(\sum_{m=1}^n \mathbb{E}[X_{n,m}^2]\right)$$

### 3.3 退化情形

若 $\max_{1 \le m \le n} \operatorname{Var}(X_{n,m}) / \sum_{m=1}^n \operatorname{Var}(X_{n,m}) \to 0$（即方差均匀小），则林德伯格条件自动满足。

---

## 四、李雅普诺夫定理 (Lyapunov's Theorem)

李雅普诺夫定理是林德伯格-费勒定理的重要推论，提供了更易验证的充分条件。

### 4.1 定理陈述

**定理** 设 $\{Y_n\}$ 为独立随机变量，$S_n = \sum_{j=1}^n Y_j$。定义 $\alpha_n = \sqrt{\operatorname{Var}(S_n)}$。

若 $\exists \delta > 0$ 使得

$$\lim_{n \to \infty} \alpha_n^{-2-\delta} \sum_{m=1}^n \mathbb{E}[\|Y_m - \mathbb{E}[Y_m]\|^{2+\delta}] = 0$$

则

$$\frac{S_n - \mathbb{E}[S_n]}{\alpha_n} \implies \mathcal{N}(0,1)$$

### 4.2 常用情形：$\delta = 1$

条件简化为：

$$\lim_{n \to \infty} \frac{1}{\alpha_n^3} \sum_{m=1}^n \mathbb{E}[\|Y_m - \mathbb{E}[Y_m]\|^3] = 0$$

### 4.3 与林德伯格条件的关系

李雅普诺夫条件蕴含林德伯格条件（利用 $X^2 \mathbb{1}\_{\|X\|>\epsilon} \le \|X\|^{2+\delta}/\epsilon^{\delta}$），因此是更强的条件。

---

## 五、De Moivre-Laplace 定理

De Moivre-Laplace 定理是中心极限定理的最早形式，专门针对二项分布。

### 5.1 定理陈述

**定理** 设 $S_n \sim \text{Binomial}(n, p)$，则

$$\frac{S_n - np}{\sqrt{np(1-p)}} \implies \mathcal{N}(0,1)$$

**等价形式**：对于整数 $k$，当 $n \to \infty$ 时，

$$\mathbb{P}[S_n = k] \approx \frac{1}{\sqrt{2\pi np(1-p)}} \exp\left(-\frac{(k-np)^2}{2np(1-p)}\right)$$

### 5.2 应用

用于二项分布的正态近似，当 $np(1-p)$ 较大时效果良好。

---

## 六、中心极限定理理论体系图

```
                    特征函数理论
                        │
        ┌───────────────┼───────────────┐
        ▼               ▼               ▼
   唯一性定理        反演公式        连续性定理
        │               │               │
        └───────────────┴───────────────┘
                        ▼
              证明中心极限定理的工具
                        │
        ┌───────────────┼───────────────┐
        ▼               ▼               ▼
  经典CLT(i.i.d.)   林德伯格-费勒    李雅普诺夫
   (方差有限)       (一般形式)       (充分条件)
        │               │               │
        └───────────────┴───────────────┘
                        ▼
                  和的渐近正态性
```

---

## 七、定理对比与应用条件

| 定理 | 关键条件 | 适用范围 | 验证难度 |
|------|----------|----------|----------|
| 经典 CLT | i.i.d.，有限方差 | 同分布独立和 | 简单 |
| De Moivre-Laplace | 二项分布 | 二项分布 | 最简单 |
| 林德伯格-费勒 | 林德伯格条件 | 非同分布独立和 | 中等 |
| 李雅普诺夫 | 矩条件（$2+\delta$） | 非同分布独立和 | 较简单 |

---

## 八、应用指南

### 8.1 选择合适的 CLT

| 场景 | 推荐定理 | 理由 |
|------|----------|------|
| i.i.d. 且方差有限 | 经典 CLT | 直接应用 |
| 二项分布近似 | De Moivre-Laplace | 专门针对二项 |
| 非同分布但方差均匀小 | 李雅普诺夫 ($\delta=1$) | 矩条件易验证 |
| 一般非同分布 | 林德伯格-费勒 | 最一般的条件 |

### 8.2 验证林德伯格条件的步骤

1. 计算每个 $X_{n,m}$ 的二阶矩
2. 验证方差收敛：$\sum_m \mathbb{E}[X_{n,m}^2] \to \sigma^2$
3. 对于任意 $\epsilon > 0$，估计 $$\sum_m \mathbb{E}[X_{n,m}^2 \mathbb{1}\_{\|_{n,m}\|>\epsilon}]$$
4. 验证该尾项趋于 0

### 8.3 应用李雅普诺夫定理的步骤

1. 选择合适的 $\delta > 0$（通常 $\delta = 1$）
2. 计算 $\alpha_n^2 = \operatorname{Var}(S_n)$
3. 计算 $\sum_m \mathbb{E}[\|Y_m - \mathbb{E}[Y_m]\|^{2+\delta}]$
4. 验证比值趋于 0

---

## 九、典型应用例子

### 9.1 例1：i.i.d. 情形

设 $X_1, X_2, \ldots$ i.i.d.，$\mathbb{E}[X_1] = 0$，$\mathbb{E}[X_1^2] = 1$。

则 $\frac{1}{\sqrt{n}}\sum_{j=1}^n X_j \implies \mathcal{N}(0,1)$。

### 9.2 例2：独立非同分布

设 $X_{n,m}$ 满足 $\mathbb{E}[X_{n,m}] = 0$，$\mathbb{E}[X_{n,m}^2] = \sigma_m^2$，且 $\max_m \sigma_m^2 / \sum_m \sigma_m^2 \to 0$。

则林德伯格条件满足，$\sum_{m=1}^n X_{n,m} \implies \mathcal{N}(0, \sum_m \sigma_m^2)$。

### 9.3 例3：李雅普诺夫条件

设 $\{Y_j\}$ 独立，$\mathbb{E}[Y_j] = 0$，$\mathbb{E}[\|Y_j\|^3] \le M < \infty$。

若 $n \to \infty$ 时 $\operatorname{Var}(S_n) \to \infty$，则李雅普诺夫条件（$\delta=1$）满足。

---

## 十、重要提示

1. **中心极限定理的本质**：大量独立随机变量之和的标准化分布趋近于正态分布，这是概率论中最著名的定理之一。

2. **特征函数的作用**：特征函数将卷积运算转化为乘法运算，使得处理独立和的问题大大简化。

3. **林德伯格条件的关键**：确保没有单个随机变量主导总和，这是渐近正态性的核心要求。

4. **矩条件 vs. 分布条件**：
   - 李雅普诺夫：矩条件（易于验证）
   - 林德伯格：分布条件（更一般但验证较难）

5. **收敛速度**：独立同分布情形的收敛速度由 Berry-Esseen 定理给出，通常为 $O(n^{-1/2})$。

---

## 十一、与其他极限定理的关系

```
        大数定律 (LLN)
              ↓
    标准化和：中心极限定理 (CLT)
              ↓
    大偏差理论 (Large Deviations)
```

- **LLN**：给出平均的稳定性（收敛到常数）
- **CLT**：给出波动的一阶近似（收敛到正态分布）
- **大偏差**：给出尾概率的精确衰减速率

---

## 十二、补充：多变量中心极限定理

**定理** 设 $\{X_n\}$ 为 $\mathbb{R}^d$ 值 i.i.d. 随机向量，$\mathbb{E}[X_1] = \mu$，$\operatorname{Cov}(X_1) = \Sigma$（正定）。

则 $\sqrt{n}(\bar{X}\_n - \mu) \implies \mathcal{N}\_d(0, \Sigma)$。

其中 $\mathcal{N}\_d(0, \Sigma)$ 是 $d$ 维正态分布。

---

## 十三、实际应用中的注意事项

1. **样本量要求**：通常 $n \ge 30$ 时 CLT 近似效果良好
2. **偏态分布**：对于严重偏斜的分布，可能需要更大的样本量
3. **离散分布**：连续性修正可以改善近似效果
4. **重尾分布**：方差不存在时，CLT 不适用（可能需要稳定分布理论）
