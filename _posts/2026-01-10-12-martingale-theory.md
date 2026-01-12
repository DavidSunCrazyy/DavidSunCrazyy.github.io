---
layout: post
title: "Probability Theory I 鞅论专题"
permalink: /posts/martingale-theory/
tags: probability-theory
use_math: true
---

本文档整理鞅论的核心内容，包括鞅的定义、性质、收敛定理、可选停时定理以及相关的极大不等式。

**上一篇**：[大数定律专题](/posts/law-large-numbers/)

## 一、鞅的基本概念

### 1.1 鞅 (Martingale)

**定义** 适应过程 $\{X_n, \mathcal{F}\_n\}$ 称为鞅，如果
- $\mathbb{E}[\|X_n\|] < \infty$ 对所有 $n$（可积性）
- $X_n$ 是 $\mathcal{F}\_n$ 可测的（适应性）
- $\mathbb{E}[X_{n+1}\|\mathcal{F}\_n] = X_n$ 几乎必然（鞅性质）

**直观理解**：鞅是"公平博弈"的数学模型，即在给定当前信息的条件下，下一时刻的期望值等于当前值。

### 1.2 上鞅 (Supermartingale)

**定义** 适应过程 $\{X_n, \mathcal{F}\_n\}$ 称为上鞅，如果
- $\mathbb{E}[\|X_n\|] < \infty$ 对所有 $n$
- $X_n$ 是 $\mathcal{F}\_n$ 可测的
- $\mathbb{E}[X_{n+1}\|\mathcal{F}\_n] \le X_n$ 几乎必然

**直观理解**：上鞅对应"不利博弈"，未来期望不超过当前值。

### 1.3 下鞅 (Submartingale)

**定义** 适应过程 $\{X_n, \mathcal{F}\_n\}$ 称为下鞅，如果
- $\mathbb{E}[\|X_n\|] < \infty$ 对所有 $n$
- $X_n$ 是 $\mathcal{F}\_n$ 可测的
- $\mathbb{E}[X_{n+1}\|\mathcal{F}\_n] \ge X_n$ 几乎必然

**直观理解**：下鞅对应"有利博弈"，未来期望不低于当前值。

### 1.4 关系

$$
\begin{aligned}
\{X_n\} \text{ 是鞅} &\iff \{X_n\} \text{ 既是上鞅又是下鞅} \\
\{X_n\} \text{ 是下鞅} &\iff \{-X_n\} \text{ 是上鞅} \\
\{X_n\} \text{ 是上鞅} &\iff \{X_n + c\} \text{ 是鞅（适当条件下）}
\end{aligned}
$$

---

## 二、条件期望的性质

### 2.1 绝对值不等式

**定理** $\mathbb{E}[X\|\mathcal{A}] \le \mathbb{E}[Y\|\mathcal{A}]$ a.s. 当且仅当 $\mathbb{E}[X\mathbb{1}\_A] \le \mathbb{E}[Y\mathbb{1}\_A]$ 对所有 $A \in \mathcal{A}$ 成立。

**推论**：若 $Z = \mathbb{E}[X\|\mathcal{A}]$，则
- $\mathbb{E}[Z] = \mathbb{E}[X]$
- $\|Z\| \le \mathbb{E}[\|X\|\|\mathcal{A}]$ a.s.
- $\mathbb{E}[\|Z\|] \le \mathbb{E}[\|X\|]$
- $\mathbb{E}[\|Z\|\mathbb{1}\_A] \le \mathbb{E}[\|X\|\mathbb{1}\_A]$ 对所有 $A \in \mathcal{A}$ 成立

### 2.2 詹森不等式（条件期望版本）

**定理** 设 $\varphi$ 为凸函数且 $\mathbb{E}[\|\varphi(X)\|] < \infty$，则

$$\mathbb{E}[\varphi(X)\|\mathcal{A}] \ge \varphi(\mathbb{E}[X\|\mathcal{A}])$$

**应用**：
- 取 $\varphi(x) = \|x\|$ 得 $\|\mathbb{E}[X\|\mathcal{A}]\| \le \mathbb{E}[\|X\|\|\mathcal{A}]$
- 取 $\varphi(x) = x^2$ 得 $\mathbb{E}[X\|\mathcal{A}]^2 \le \mathbb{E}[X^2\|\mathcal{A}]$

---

## 三、Doob 极大不等式

Doob 极大不等式是鞅论中的重要工具，用于控制鞅的极大值。

### 3.1 基本形式

**定理** 设 $\{X_n\}$ 为非负下鞅。定义 $X_n^* = \max_{k \le n} X_k$。则

$$\lambda \mathbb{P}(X_n^* \ge \lambda) \le \mathbb{E}[X_n \mathbb{1}\_{X_n^* \ge \lambda}] \le \mathbb{E}[X_n]$$

**证明思路**：定义停时 $T = \min \{n \| X_n \ge \lambda\}$。注意到 $X_n^* \ge \lambda = \{T \le n\}$。

$$
\begin{aligned}
\mathbb{E}[X_n \mathbb{1}\_{T \le n}] &= \sum_{j=1}^n \mathbb{E}[X_n \mathbb{1}\_{T=j}] \\
&\ge \sum_{j=1}^n \mathbb{E}[X_j \mathbb{1}\_{T=j}] \quad \text{(下鞅性质)} \\
&\ge \sum_{j=1}^n \lambda \mathbb{P}(T=j) = \lambda \mathbb{P}(T \le n)
\end{aligned}
$$

### 3.2 $L^p$ 版本

**定理** 设 $\{X_n\}$ 为非负下鞅。则对所有 $p > 1$ 有

$$\|X_n^*\|_p \le \frac{p}{p-1}\|X_n\|_p$$

**意义**：这是鞅论中的 Doob 不等式，与 Kolmogorov 不等式在形式上相似，但适用于更一般的下鞅。

---

## 四、鞅的收敛性

鞅收敛定理是鞅论的核心结果，给出了鞅在几乎必然和 $L^p$ 意义下的收敛条件。

### 4.1 几乎必然收敛

**定理** 设 $\{X_n\}$ 为上鞅，在 $L^1$ 中有界，即 $\sup_n \mathbb{E}[\|X_j\|] < \infty$

则 $X_n \to X_\infty \in L^1$ a.s.

**推论**：若 $\{X_n\}$ 为非负上鞅，则 $X_n \to X_\infty \in L^1$ a.s.

### 4.2 $L^p$ 收敛

**定理** 设 $\{X_n\}$ 为鞅，$p > 1$。以下等价：

1. $\{X_n\}$ 在 $L^p$ 中有界
2. $\{X_n\}$ 几乎必然且 $L^p$ 收敛到 $X_\infty \in L^p$
3. 存在 $Z \in L^p$ 使得 $X_n = \mathbb{E}[Z\|\mathcal{F}\_n]$ a.s. $\forall n$

**意义**：对于 $p > 1$，鞅的 $L^p$ 有界性蕴含几乎必然和 $L^p$ 收敛。

### 4.3 $L^1$ 收敛

**定理** 设 $\{X_n\}$ 为鞅，以下等价：

1. $\{X_n\}$ 是 UI 的（一致可积）
2. $\{X_n\} \to X_\infty$ 在 $L^1$ 中且几乎必然收敛
3. 存在 $X_\infty \in L^1$ 使得 $X_n = \mathbb{E}[X_\infty\|\mathcal{F}\_n]$ a.s. $\forall n$

**引理**：设 $\mathcal{F}$ 为 $\sigma$-代数，$X \in L^1$，则 $\{\mathbb{E}[X\|\mathcal{A}]: \mathcal{A} \text{ 是 } \mathcal{F} \text{ 的子 } \sigma\text{-代数}\}$ 是 UI 的。

**证明要点**：
$$
\begin{aligned}
\mathbb{E}[\|\mathbb{E}[X\|\mathcal{A}]\|\mathbb{1}_{\|\mathbb{E}[X\|\mathcal{A}]\|>\epsilon}]
&\le \mathbb{E}[\|X\|\mathbb{1}_{\|\mathbb{E}[X\|\mathcal{A}]\|>\epsilon}] \\
&= \mathbb{E}[\|X\|\mathbb{1}_{\|X\|>\delta}\mathbb{1}_{\|\mathbb{E}[X\|\mathcal{A}]\|>\epsilon}] + \mathbb{E}[\|X\|\mathbb{1}_{\|X\|\le\delta}\mathbb{1}_{\|\mathbb{E}[X\|\mathcal{A}]\|>\epsilon}] \\
&\le \mathbb{E}[\|X\|\mathbb{1}_{\|X\|>\delta}] + \delta \mathbb{P}(\|\mathbb{E}[X\|\mathcal{A}]\|>\epsilon) \\
&\le \mathbb{E}[\|X\|\mathbb{1}_{\|X\|>\delta}] + \frac{\delta}{\epsilon}\mathbb{E}[\|X\|]
\end{aligned}
$$

令 $\delta \to \infty$，$\epsilon = \delta^2$。

**推论**：设 $X \in L^1$，则 $\mathbb{E}[X\|\mathcal{F}\_n] \to \mathbb{E}[X\|\mathcal{F}\_\infty]$ 在几乎必然且 $L^1$ 意义下成立。

其中 $\mathcal{F}\_\infty = \sigma(\bigcup_n \mathcal{F}\_n)$。

---

## 五、可选停时定理

可选停时定理（也称为可选抽样定理）是鞅论的重要应用工具。

### 5.1 鞅情形

**定理** 设 $\{X_n\}$ 为鞅，$T$ 为停时。

1. $X_{n \wedge T}$ 是鞅，因此 $\mathbb{E}[X_{n \wedge T}] = \mathbb{E}[X_0]$
2. 若 $T$ 有界（不超过 $N$），则 $\mathbb{E}[X_T] = \mathbb{E}[X_0]$ 且当 $T \ge S$ a.s. 时有 $\mathbb{E}[X_T\|\mathcal{F}\_S] = X_S$ a.s.
3. 若 $T < \infty$ a.s. 且 $\|X_n\| \le Y \in L^1$，则 $\mathbb{E}[X_T] = \mathbb{E}[X_0]$
4. 若 $\mathbb{E}[T] < \infty$，且 $X_n$ 有有界增量，则 $\mathbb{E}[X_T] = \mathbb{E}[X_0]$

### 5.2 上鞅情形

**定理** 设 $\{X_n\}$ 为上鞅，$T$ 为停时。

1. $X_{n \wedge T}$ 是上鞅，因此 $\mathbb{E}[X_{n \wedge T}] \le \mathbb{E}[X_0]$
2. 若 $T$ 有界，则 $\mathbb{E}[X_T] \le \mathbb{E}[X_0]$ 且当 $T \ge S$ a.s. 时有 $\mathbb{E}[X_T\|\mathcal{F}\_S] \le X_S$ a.s.
3. 若 $T < \infty$ a.s. 且 $\|X_n\| \le Y \in L^1$，则 $\mathbb{E}[X_T] \le \mathbb{E}[X_0]$
4. 若 $\mathbb{E}[T] < \infty$，且 $X_n$ 有有界增量，则 $\mathbb{E}[X_T] \le \mathbb{E}[X_0]$
5. 若 $T < \infty$ a.s.，且 $\{X_n\}$ 非负，则 $\mathbb{E}[X_T] \le \mathbb{E}[X_0]$

### 5.3 UI 鞅情形

**定理** 设 $\{X_n\}$ 为 UI 鞅。$S \le T$ 为停时，则

$$\mathbb{E}[X_T \| \mathcal{F}\_S] = X_S \quad \text{a.s.}$$

因此 $\mathbb{E}[X_T] = \mathbb{E}[X_S]$。

**意义**：对于 UI 鞅，可选停时定理在最一般的条件下成立。

---

## 六、Kolmogorov 0-1 律

**定理** 设 $\{\xi_i\}\_{i \ge 1}$ 为独立随机变量序列。设 $\mathcal{G}\_n = \sigma(\xi_k, k \ge n)$ 且 $\mathcal{G}\_\infty = \cap_{n \ge 1} \mathcal{G}\_n$。则 $\mathcal{G}\_\infty$ 是平凡的，即对任意 $A \in \mathcal{G}\_\infty$ 有 $\mathbb{P}(A) = 0$ 或 $1$。

**直观理解**：尾部 $\sigma$-代数中的事件概率只能是 0 或 1，这些事件不受任何有限个随机变量的影响。

**应用**：用于证明独立随机变量序列的某些极限性质几乎必然成立或不成立。

---

## 七、鞅论理论体系图

```
                    条件期望
                        │
        ┌───────────────┼───────────────┐
        ▼               ▼               ▼
      鞅定义          Doob极大不等式    停时理论
        │               │               │
        ▼               ▼               ▼
    鞅的性质          极大值控制      可选停时定理
        │               │               │
        └───────┬───────┴───────────────┘
                ▼
            鞅收敛定理
                │
        ┌───────┼───────┐
        ▼       ▼       ▼
     a.s.收敛  L^p收敛  L^1收敛
    (L^1有界) (L^p有界)  (UI条件)
```

---

## 八、重要定理关系

| 定理 | 条件 | 结论类型 | 应用场景 |
|------|------|----------|----------|
| Doob 极大不等式 | 非负下鞅 | 尾概率估计 | 控制鞅的极大值 |
| Doob 不等式 ($L^p$) | 下鞅，$p>1$ | $L^p$ 范数估计 | $L^p$ 鞅的收敛性 |
| 鞅收敛定理 (a.s.) | $L^1$ 有界上鞅 | a.s. 收敛 | 上鞅的极限行为 |
| 鞅收敛定理 ($L^p$) | $L^p$ 有界鞅 | a.s. + $L^p$ 收敛 | 高阶矩鞅的收敛 |
| 鞅收敛定理 ($L^1$) | UI 鞅 | a.s. + $L^1$ 收敛 | 一般鞅的收敛 |
| 可选停时定理 | 各种条件 | 期望保持 | 停时问题的期望计算 |

---

## 九、鞅收敛定理对比

| 收敛类型 | 充要条件 | 极限表示 | 典型应用 |
|---------|----------|----------|----------|
| 几乎必然 | $L^1$ 有界（上鞅） | $X_\infty \in L^1$ | 上鞅的稳定性 |
| $L^p$ ($p>1$) | $L^p$ 有界 | $X_n = \mathbb{E}[Z\|\mathcal{F}\_n]$ | 条件期望的正则性 |
| $L^1$ | UI | $X_n = \mathbb{E}[X_\infty\|\mathcal{F}\_n]$ | 一致可积鞅的收敛 |

---

## 十、经典鞅例子

### 10.1 例1：鞅差序列和

设 $\{Y_n\}$ 是独立同分布，$\mathbb{E}[Y_n] = 0$，$\mathbb{E}[\|Y_n\|] < \infty$。定义 $X_n = \sum_{j=1}^n Y_j$，则 $\{X_n\}$ 是鞅。

### 10.2 例2：似然比

设 $\{Y_n\}$ 是独立同分布，$\mathbb{E}[Y_n] = 1$。定义 $X_n = \prod_{j=1}^n Y_j$，则 $\{X_n\}$ 是鞅。

### 10.3 例3：Doob 鞅

设 $Z \in L^1$，定义 $X_n = \mathbb{E}[Z\|\mathcal{F}\_n]$，则 $\{X_n\}$ 是 UI 鞅，且 $X_n \to \mathbb{E}[Z\|\mathcal{F}\_\infty]$ a.s. 且 $L^1$。

### 10.4 例4：Polya 罐子模型

初始有 $a$ 个红球和 $b$ 个蓝球。每次随机取一个球，然后放回并增加同色球 $c$ 个。设 $X_n$ 为第 $n$ 次红球比例，则 $\{X_n\}$ 是鞅。

---

## 十一、应用指南

### 11.1 判定鞅类型

| 检查项 | 鞅 | 上鞅 | 下鞅 |
|--------|----| ---- | ---- |
| 可积性 | ✓ | ✓ | ✓ |
| 适应性 | ✓ | ✓ | ✓ |
| 条件期望 | $E[X_{n+1}\|\mathcal{F}\_n] = X_n$ | $E[X_{n+1}\|\mathcal{F}\_n] \le X_n$ | $E[X_{n+1}\|\mathcal{F}\_n] \ge X_n$ |

### 11.2 证明收敛性

| 目标 | 推荐定理 | 关键条件 |
|------|----------|----------|
| a.s. 收敛（上鞅） | Doob 收敛定理 | $L^1$ 有界 |
| $L^p$ 收敛 ($p>1$) | Doob $L^p$ 收敛定理 | $L^p$ 有界 |
| $L^1$ 收敛 | UI 鞅收敛定理 | 一致可积 |
| 期望计算 | 可选停时定理 | 验证对应条件 |

### 11.3 常用技巧

1. **构造鞅**：从条件期望定义出发，验证鞅性质
2. **停时分析**：利用可选停时定理简化期望计算
3. **极大值估计**：使用 Doob 极大不等式
4. **收敛性**：验证 UI 条件或 $L^p$ 有界性

---

## 十二、重要提示

1. **鞅的核心意义**：鞅是"公平博弈"的数学模型，鞅论提供了研究随机过程收敛性的强大工具。

2. **UI 的重要性**：一致可积性是连接依概率收敛和 $L^1$ 收敛的桥梁，在鞅收敛定理中起关键作用。

3. **停时的灵活性**：可选停时定理允许我们选择适当的停时来简化问题，这是鞅论的重要应用。

4. **收敛条件对比**：
   - $p > 1$：$L^p$ 有界即可
   - $p = 1$：需要更强的 UI 条件
   - a.s. 收敛：只需 $L^1$ 有界（对上鞅）

---

**下一篇**：[中心极限定理专题](/posts/central-limit-theorem/)
