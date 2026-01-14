---
layout: post
title: "Probability Theory I 收敛理论"
permalink: /posts/convergence-theory/
tags: probability-theory
use_math: true
---

本文档整理概率论中随机变量序列的各种收敛方式及其相互关系，这是理解大数定律和中心极限定理的基础。

**上一篇**：[常用概率分布](/posts/common-probability-distributions/)

## 一、收敛方式

### 1.1 几乎必然收敛 (Almost Sure Convergence)

**定义** 随机变量序列 $\{X_n\}$ 几乎必然收敛到随机变量 $X$，如果存在零测集 $\mathcal{N}$ 使得

$$\lim_n X_n(\omega) = X(\omega), \quad \forall \omega \in \Omega \setminus \mathcal{N}$$

记作：$X_n \xrightarrow{a.s.} X$ 或 $X_n \to X$ a.s.

**等价刻画**：序列 $\{X_n\}$ 几乎必然收敛到 $X$ 当且仅当，对任意 $\epsilon > 0$，有

$$\lim_{m \to \infty} \mathbb{P}[\|X_n-X\| \le \epsilon, \forall n \ge m] = 1$$

或等价地：

$$\mathbb{P}[\|X_n-X\| > \epsilon \text{ i.o.}] = 0, \quad \forall \epsilon > 0$$

其中 "i.o." 表示 "infinitely often"（无穷次发生）。

### 1.2 依概率收敛 (Convergence in Probability)

**定义** 随机变量序列 $\{X_n\}$ 依概率收敛到随机变量 $X$，如果对每个 $\epsilon > 0$，有

$$\lim_n \mathbb{P}[\|X_n-X\| > \epsilon] = 0$$

记作：$X_n \xrightarrow{P} X$ 或 $X_n \to X$ in probability。

**性质**：
- 依概率收敛蕴含沿子序列的几乎必然收敛
- 若 $X_n \xrightarrow{P} X$ 且 $Y_n \xrightarrow{P} Y$，则 $X_n + Y_n \xrightarrow{P} X + Y$

### 1.3 $L^p$ 收敛 (Convergence in $L^p$)

**定义** 假设 $p \ge 1$。随机变量序列 $\{X_n\}$ 在 $L^p$ 中收敛到随机变量 $X$，如果 $X_n \in L^p, X \in L^p$ 且

$$\lim_n \mathbb{E}[\|X_n-X\|^p] = 0$$

记作：$X_n \xrightarrow{L^p} X$。

**特例**：
- $p=1$：平均收敛（Convergence in mean）
- $p=2$：均方收敛（Convergence in mean square）

### 1.4 依分布收敛 / 弱收敛 (Convergence in Distribution)

**定义** 随机变量序列 $\{X_n\}$ 依分布收敛到随机变量 $X$，如果 $\mathcal{L}(X_n) \implies \mathcal{L}(X)$。

记作：$X_n \xrightarrow{d} X$ 或 $X_n \to X$ in distribution。

**等价条件**：对于所有有界连续函数 $f$，有

$$\lim_{n \to \infty} \mathbb{E}[f(X_n)] = \mathbb{E}[f(X)]$$

---

## 二、弱收敛理论

### 2.1 弱收敛的定义

**定义** 测度序列 $\{\mu_n\}$ 弱收敛到测度 $\mu$，如果

$$\mu_n((a,b]) \to \mu((a,b]), \quad \text{对所有 } \mu \text{ 的连续点 } a,b$$

记为：$\mu_n \implies \mu$。

### 2.2 胎紧性 (Tightness)

**定义** 概率测度族 $\{\mu_\alpha, \alpha \in A\}$ 是胎紧的，如果对任意 $\epsilon > 0$，存在有限区间 $I$，

$$\inf_{\alpha \in A} \mu_\alpha(I) \ge 1 - \epsilon$$

**引理**：设 $\{\mu_n\}$ 为概率测度序列且 $\mu_n \implies \mu$，其中 $\mu$ 也是概率测度，则 $\{\mu_n, n \ge 1\}$ 是胎紧的。

**Prohorov 定理**：设 $\{\mu_\alpha \| \alpha \in A\}$ 为概率测度族。任意序列存在弱收敛到概率测度的子序列，当且仅当该族是*胎紧的*。

### 2.3 弱收敛的判据

**定理** 设 $\{\mu_n\}$ 和 $\mu$ 为概率测度。则以下命题等价：

$$
\begin{aligned}
& \mu_n \implies \mu \\
&\iff \lim_n \int f \, d\mu_n = \int f \, d\mu, \quad \forall f \in C_b \text{（有界连续函数）} \\
&\iff \mathbb{E}[f(X_n)] \to \mathbb{E}[f(X)], \quad \forall f \in C_c \text{（紧支撑连续函数）} \\
&\iff \liminf_n \int f \, d\mu_n \ge \int f \, d\mu, \quad \forall \text{ 有界下半连续函数 } f \\
&\iff \limsup_n \int f \, d\mu_n \le \int f \, d\mu, \quad \forall \text{ 有界上半连续函数 } f \\
&\iff \liminf_n \mu_n(O) \ge \mu(O), \quad \forall \text{ 开集 } O \\
&\iff \limsup_n \mu_n(K) \le \mu(K), \quad \forall \text{ 紧集 } K
\end{aligned}
$$

### 2.4 依分布收敛的性质

**定理**：若 $X_n \implies X$，$\alpha_n \implies a$，$\beta_n \implies b$（其中 $a,b$ 为常数），则

$$\alpha_n X_n + \beta_n \implies aX + b$$

**引理**：设 $X_n \to X$ 依分布，$Y_n \to 0$ 依分布，则：
1. $X_n + Y_n \to X$ 依分布
2. $X_n Y_n \to 0$ 依分布

**推论**：设 $X_n$ 依分布收敛到常数 $c$。则 $X_n \to c$ 依概率。

---

## 三、Helly 抽取原理

**定理** 给定任意次概率测度序列，存在弱收敛到次概率测度的子序列。

**命题** 设 $\{\mu_n\}$ 为次概率测度序列。若每个弱收敛的子序列都收敛到同一极限 $\mu$，则 $\mu_n \implies \mu$。

**意义**：这是证明弱收敛的有力工具，只需验证所有收敛子序列的极限相同即可。

---

## 四、一致可积性

### 4.1 定义

**定义** 随机变量集合 $\{X_i, i \in I\}$ 是一致可积的（UI），如果

$$\sup_i \mathbb{E}[\|X_i\|\mathbb{1}_{\{\|X_i\| \ge \alpha\}}] \to 0 \quad \text{当 } \alpha \to \infty$$

### 4.2 重要结论

**引理**：
1. UI 族在 $L^1$ 中有界
2. 若随机变量族在某个 $L^p$（$p>1$）中有界，则它是 UI 的

**重要关系**：
$$L^p \text{ 中有界} \implies \text{UI} \implies L^1 \text{ 中有界}$$

### 4.3 UI 与收敛

**定理**：设 $X_n \xrightarrow{P} X$，则 $X_n \xrightarrow{L^1} X$ 当且仅当 $\{X_n\}$ 是 UI 的。

**绝对连续性**：设 $Z \in L^1$，则对任意 $\epsilon > 0$，存在 $\delta > 0$ 使得

若 $\mathbb{P}(A) \le \delta$，则 $\mathbb{E}[Z \mathbb{1}\_A] \le \epsilon$

---

## 五、收敛方式之间的关系

### 5.1 蕴含关系图

```
           几乎必然收敛
                 │
                 ├───────────┐
                 ▼           ▼
              依概率收敛    L^p 收敛 (p ≥ 1)
                 │           │
                 └─────┬─────┘
                       ▼
                 依分布收敛
```

**说明**：
- 几乎必然收敛 $\implies$ 依概率收敛
- $L^p$ 收敛 $\implies$ 依概率收敛
- 依概率收敛 $\implies$ 依分布收敛

**重要**：
- 依分布收敛 ⇏ 依概率收敛（除非极限是常数）
- 几乎必然收敛和 $L^p$ 收敛一般不能相互推出

### 5.2 依概率收敛与几乎必然收敛

**Borel-Cantelli 引理的联系**：
$$X_n \to X \text{ a.s.} \iff \mathbb{P}[\|X_n-X\| > \epsilon \text{ i.o.}] = 0, \quad \forall \epsilon > 0$$

**依概率收敛的性质**：依概率收敛蕴含沿子序列的几乎必然收敛。

即：若 $X_n \xrightarrow{P} X$，则存在子序列 $\{X_{n_k}\}$ 使得 $X_{n_k} \xrightarrow{a.s.} X$。

### 5.3 Skorokhod 表示定理

**定理**：假设 $X_n \to X$ in distribution。则存在概率空间和该空间中的随机变量 $\{Y_n\}$ 和 $Y$ 使得

$$Y_n \to Y \text{ a.s.}, \quad \mathcal{L}(Y_n) = \mathcal{L}(X_n), \quad \mathcal{L}(Y) = \mathcal{L}(X)$$

**意义**：这一定理说明依分布收敛本质上可以通过构造新的概率空间转化为几乎必然收敛。

---

## 六、收敛性判据总结

| 收敛类型 | 判据 | 典型应用 |
|---------|------|----------|
| a.s. 收敛 | $\forall \epsilon > 0$: $\mathbb{P}[\|X_n-X\|>\epsilon \text{ i.o.}] = 0$ | 强大数定律 |
| 依概率收敛 | $\forall \epsilon > 0$: $\lim_n \mathbb{P}[\|X_n-X\|>\epsilon] = 0$ | 弱大数定律 |
| $L^1$ 收敛 | $\lim_n \mathbb{E}[\|X_n-X\|] = 0$（需要 UI 条件） | 鞅收敛 |
| 依分布收敛 | $\forall f \in C_b$: $\lim_n \mathbb{E}[f(X_n)] = \mathbb{E}[f(X)]$ | 中心极限定理 |

---

## 七、重要定理总结

### 7.1 依分布收敛的性质

1. **连续映射定理**：若 $X_n \xrightarrow{d} X$ 且 $g$ 是连续函数，则 $g(X_n) \xrightarrow{d} g(X)$。

2. **Slutsky 定理**：若 $X_n \xrightarrow{d} X$ 且 $Y_n \xrightarrow{P} c$（常数），则：
   - $X_n + Y_n \xrightarrow{d} X + c$
   - $X_n Y_n \xrightarrow{d} cX$
   - $X_n / Y_n \xrightarrow{d} X/c$（当 $c \neq 0$）

### 7.2 一致可积性的应用

**Vitali 收敛定理**：设 $\{X_n\} \subset L^1$。则 $X_n \xrightarrow{L^1} X$ 当且仅当：
1. $X_n \xrightarrow{P} X$
2. $\{X_n\}$ 是 UI 的

---

## 八、实际应用指南

### 8.1 选择合适的收敛类型

| 问题类型 | 推荐收敛类型 | 理由 |
|---------|-------------|------|
| 证明路径性质 | 几乎必然收敛 | 最强的收敛，适用于所有样本路径 |
| 统计推断 | 依概率收敛 | 足够用于估计量的相合性 |
| $L^p$ 估计 | $L^p$ 收敛 | 直接控制误差的 $p$ 阶矩 |
| 极限分布 | 依分布收敛 | 用于渐近分布理论 |
| 鞅论 | 几乎必然 + $L^1$ | 鞅收敛定理给出两者 |

### 8.2 证明技巧

1. **证明 a.s. 收敛**：使用 Borel-Cantelli 引理
2. **证明依概率收敛**：使用切比雪夫不等式或直接估计
3. **证明 $L^1$ 收敛**：验证一致可积性 + 依概率收敛
4. **证明依分布收敛**：使用特征函数或矩母函数

---

**下一篇**：[大数定律专题](/posts/law-large-numbers/)
