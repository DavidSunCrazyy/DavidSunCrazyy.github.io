---
note: true
layout: post
title: "Probability Theory I 常用概率分布"
permalink: /posts/common-probability-distributions/
categories: probability-theory
tags: [probability-theory, probability-distributions, gaussian, poisson, binomial, exponential, gamma-distribution]
use_math: true
---

本文档整理概率论中常用的概率分布，包括离散分布和连续分布的定义、性质和应用。

**上一篇**：[期望与积分理论](/posts/expectation-integration-theory/)

## 一、离散分布

### 1.1 伯努利分布 (Bernoulli Distribution)

**定义** 参数为 $p \in (0,1)$ 的伯努利分布定义为：

$$\mathbb{P}[X=1] = p, \quad \mathbb{P}[X=0] = 1-p$$

**期望与方差**：
- $\mathbb{E}[X] = p$
- $\operatorname{Var}(X) = p(1-p)$

**特征函数**：$f(t) = (1-p) + pe^{it}$

**应用**：抛硬币、二值决策、成功/失败模型

### 1.2 泊松分布 (Poisson Distribution)

**定义** 参数为 $\lambda > 0$ 的泊松分布：

$$\mathbb{P}[X=k] = \frac{\lambda^k}{k\!}e^{-\lambda}, \quad k=0,1,2,\ldots$$

**期望与方差**：
- $\mathbb{E}[X] = \lambda$
- $\operatorname{Var}(X) = \lambda$

**特征函数**：$f(t) = \exp(\lambda(e^{it}-1))$

**性质**：
- 泊松分布的可加性：若 $X \sim \text{Poisson}(\lambda_1)$，$Y \sim \text{Poisson}(\lambda_2)$ 独立，则 $X+Y \sim \text{Poisson}(\lambda_1+\lambda_2)$
- 当 $n \to \infty$, $p \to 0$ 且 $np \to \lambda$ 时，二项分布 $\text{Bin}(n,p)$ 收敛到泊松分布

**Theorem (Raikov's theorem).** 设 $X_1, \ldots, X_n$ 为相互独立的非负随机变量，若其和 $\sum_{j=1}^n X_j \sim \text{Poisson}(\lambda)$，则每个 $X_j$ 也必须服从泊松分布。

**证明（特征函数法）**：设 $\phi_j(t) = \mathbb{E}[e^{it X_j}]$ 为 $X_j$ 的特征函数。由独立性，

$$\prod_{j=1}^n \phi_j(t) = \exp(\lambda(e^{it}-1)).$$

右侧是整函数且无零点，故每个 $\phi_j(t)$ 也是整函数且无零点（否则左侧有零点）。因此可定义 $\psi_j(t) = \log \phi_j(t)$ 为整函数，且

$$\sum_{j=1}^n \psi_j(t) = \lambda(e^{it}-1).$$

由于 $X_j \geq 0$ a.s.，$\phi_j(t)$ 可解析延拓到上半平面，且 $|\phi_j(t)| \leq 1$（对 $\Im(t) \geq 0$）。通过分析 $\psi_j(t)$ 的增长性并利用 $e^{it}-1$ 的周期性，可得每个 $\psi_j(t)$ 必为 $c_j(e^{it}-1)$ 的形式，其中 $c_j \geq 0$。因此 $X_j \sim \text{Poisson}(c_j)$，且 $\sum_j c_j = \lambda$。$\square$


### 1.3 几何分布 (Geometric Distribution)

**定义** 成功概率为 $p \in (0,1)$，第 $k$ 次首次成功的几何分布：

$$\mathbb{P}[X=k] = p(1-p)^{k-1}, \quad k=1,2,\ldots$$

**期望与方差**：
- $\mathbb{E}[X] = \frac{1}{p}$
- $\operatorname{Var}(X) = \frac{1-p}{p^2}$

**特征函数**：$f(t) = \frac{pe^{it}}{1-(1-p)e^{it}}$

**性质**：无记忆性 —— $\mathbb{P}[X > m+n | X > m] = \mathbb{P}[X > n]$

**应用**：等待时间、重复试验直到成功

---

## 二、连续分布

### 2.1 指数分布 (Exponential Distribution)

**定义** 参数为 $\lambda > 0$ 的指数分布：

$$\mathbb{P}[X \le x] = \begin{cases}0, & x \le 0,\\ 1-e^{-\lambda x}, & x \ge 0.\end{cases}$$

**密度函数**：

$$p(x) = \begin{cases}0, & x \le 0, \\ \lambda e^{-\lambda x}, & x \ge 0. \end{cases}$$

**期望与方差**：
- $\mathbb{E}[X] = \frac{1}{\lambda}$
- $\operatorname{Var}(X) = \frac{1}{\lambda^2}$

**特征函数**：$f(t) = \frac{\lambda}{\lambda - it}$

**联合分布**：$n$ 个参数为 $\lambda > 0$ 的指数分布随机变量之和：

$$p(x) = \frac{\lambda^n}{\Gamma(n)} x^{n-1} e^{-\lambda x}\mathbb{1}_{x \ge 0}$$

这是伽马分布 $\Gamma(n, \lambda)$。

**性质**：无记忆性 —— $\mathbb{P}[X > s+t | X > s] = \mathbb{P}[X > t]$

**应用**：等待时间、寿命分析、泊松过程的到达间隔

### 2.2 均匀分布 (Uniform Distribution)

**定义** 区间 $[a,b]$ 上的均匀分布：

$$p(x) = \begin{cases}\frac{1}{b-a}, & a \le x \le b,\\ 0, & \text{其他}.\end{cases}$$

**期望与方差**：
- $\mathbb{E}[X] = \frac{a+b}{2}$
- $\operatorname{Var}(X) = \frac{(b-a)^2}{12}$

**特征函数**（区间 $[-a,a]$）：$f(t) = \frac{\sin(at)}{at}$

**应用**：随机抽样、数值模拟、先验分布

### 2.3 正态分布 (Normal Distribution)

**定义** 标准正态分布 $\mathcal{N}(0,1)$ 的密度函数：

$$p(x) = \frac{1}{\sqrt{2\pi}}\exp\left(-\frac{x^2}{2}\right)$$

**一般形式** $\mathcal{N}(m, \sigma^2)$ 的密度函数：

$$p(x) = \frac{1}{\sqrt{2\pi\sigma^2}}\exp\left(-\frac{(x-m)^2}{2\sigma^2}\right)$$

**期望与方差**（标准正态）：
- $\mathbb{E}[X] = 0$
- $\operatorname{Var}(X) = 1$

**矩**（标准正态）：
- $\mathbb{E}[X^{2n}] = (2n-1)!! = (2n-1)(2n-3)\cdots 3 \cdot 1$
- $\mathbb{E}[X^{2n-1}] = 0$

**特征函数**（$\mathcal{N}(m, \sigma^2)$）：$f(t) = \exp(imt - \frac{\sigma^2 t^2}{2})$

**性质**：
- 可加性：独立正态随机变量之和仍是正态的
- 对称性：密度函数关于均值对称
- 中心极限定理的极限分布

**Theorem (Cramér's theorem).** 设 $X_1, \ldots, X_n$ 为相互独立的实值随机变量，若其和 $\sum_{j=1}^n X_j$ 服从正态分布，则每个 $X_j$ 也必须服从正态分布。

**证明（特征函数法）**：设 $\phi_j(t) = \mathbb{E}[e^{it X_j}]$ 为 $X_j$ 的特征函数，$\phi_S(t)$ 为和的特征函数。由假设，存在 $\mu, \sigma^2$ 使

$$\phi_S(t) = \prod_{j=1}^n \phi_j(t) = \exp\!\left(i\mu t - \frac{\sigma^2 t^2}{2}\right).$$

右侧可延拓为复平面上的整函数且无零点，故每个 $\phi_j(t)$ 也可延拓为无零点的整函数。定义 $\psi_j(z) = \log \phi_j(z)$（取 $\psi_j(0)=0$ 的分支），则 $\psi_j$ 也是整函数且

$$\sum_{j=1}^n \psi_j(z) = i\mu z - \frac{\sigma^2}{2}z^2.$$

由特征函数的一般性质，$\psi_j(z)$ 在实轴上满足 $\overline{\psi_j(t)} = \psi_j(-t)$，且增长阶不超过 $2$。进一步，$\Re(\psi_j(t)) \leq 0$（因 $|\phi_j(t)| \leq 1$），这意味着每个 $\psi_j(z)$ 的实部是负半定的二次型加上线性项。通过比较两边的增长阶和泰勒展开，$\psi_j(z)$ 必为次数不超过 $2$ 的多项式：

$$\psi_j(z) = i a_j z - \frac{b_j^2}{2} z^2, \quad b_j^2 \geq 0.$$

其中 $b_j^2 \geq 0$ 来自 $|\phi_j(t)| \leq 1$ 的限制。因此 $\phi_j(t) = \exp(i a_j t - b_j^2 t^2/2)$，即 $X_j \sim \mathcal{N}(a_j, b_j^2)$。当 $b_j^2 = 0$ 时，$X_j$ 退化为常数 $a_j$（可视为方差为零的正态分布）。$\square$

---

## 三、分布性质总结表

| 分布 | 参数 | 期望 | 方差 | 特征函数 |
|------|------|------|------|----------|
| 伯努利 | $p$ | $p$ | $p(1-p)$ | $(1-p)+pe^{it}$ |
| 泊松 | $\lambda$ | $\lambda$ | $\lambda$ | $\exp(\lambda(e^{it}-1))$ |
| 几何 | $p$ | $\frac{1}{p}$ | $\frac{1-p}{p^2}$ | $\frac{pe^{it}}{1-(1-p)e^{it}}$ |
| 指数 | $\lambda$ | $\frac{1}{\lambda}$ | $\frac{1}{\lambda^2}$ | $\frac{\lambda}{\lambda-it}$ |
| 均匀$[a,b]$ | $a,b$ | $\frac{a+b}{2}$ | $\frac{(b-a)^2}{12}$ | $\frac{e^{itb}-e^{ita}}{it(b-a)}$ |
| 正态$\mathcal{N}(m,\sigma^2)$ | $m,\sigma^2$ | $m$ | $\sigma^2$ | $\exp\!\left(imt-\frac{\sigma^2 t^2}{2}\right)$ |

---

## 四、分布之间的关系

常见分布之间存在清晰的导出关系，这些关系揭示了它们之间的内在联系：

1. **伯努利分布 → 二项分布**：设 $X_1, \ldots, X_n \stackrel{\text{i.i.d.}}{\sim} \text{Bernoulli}(p)$，则 $\sum_{i=1}^{n} X_i \sim \text{Bin}(n, p)$。

2. **二项分布 → 泊松分布（泊松定理）**：设 $X_n \sim \text{Bin}(n, p_n)$，若 $\lim_{n\to\infty} n p_n = \lambda > 0$，则 $X_n \xrightarrow{d} \text{Poisson}(\lambda)$。

3. **指数分布 → 伽马分布**：设 $X_1, \ldots, X_n \stackrel{\text{i.i.d.}}{\sim} \text{Exp}(\lambda)$，则 $\sum_{i=1}^{n} X_i \sim \Gamma(n, \lambda)$。特别地，$\text{Exp}(\lambda) = \Gamma(1, \lambda)$。

4. **正态分布的再生性**：设 $X_i \sim \mathcal{N}(\mu_i, \sigma_i^2)$ 相互独立，则对任意常数 $a_i$，有 $\sum_i a_i X_i \sim \mathcal{N}\!\left(\sum_i a_i \mu_i,\; \sum_i a_i^2 \sigma_i^2\right)$。正态分布对线性运算封闭。

---

## 五、重要性质对比

### 无记忆性分布

具有无记忆性的分布只有：
- **几何分布**（离散）
- **指数分布**（连续）

无记忆性：$\mathbb{P}[X > s+t | X > s] = \mathbb{P}[X > t]$

### 可加性分布

独立和保持同类型分布：
- **泊松分布**：$\text{Poisson}(\lambda_1) + \text{Poisson}(\lambda_2) = \text{Poisson}(\lambda_1+\lambda_2)$
- **正态分布**：$\mathcal{N}(\mu_1, \sigma_1^2) + \mathcal{N}(\mu_2, \sigma_2^2) = \mathcal{N}(\mu_1+\mu_2, \sigma_1^2+\sigma_2^2)$
- **伽马分布**（相同尺度参数）：$\Gamma(r_1, \lambda) + \Gamma(r_2, \lambda) = \Gamma(r_1+r_2, \lambda)$

---

## 六、极限关系

1. **二项分布 → 泊松分布**：$\text{Bin}(n, \lambda/n) \xrightarrow[n\to\infty]{} \text{Poisson}(\lambda)$
2. **二项分布 → 正态分布**（De Moivre-Laplace）：$\text{Bin}(n,p) \xrightarrow[n\to\infty]{} \mathcal{N}(np, np(1-p))$
3. **泊松分布 → 正态分布**（大参数）：$\text{Poisson}(\lambda) \xrightarrow[\lambda\to\infty]{} \mathcal{N}(\lambda, \lambda)$

---

**下一篇**：[收敛理论](/posts/convergence-theory/)
