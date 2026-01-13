---
layout: post
title: "Probability Theory I 常用概率分布"
permalink: /posts/common-probability-distributions/
tags: probability-theory
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

**应用**：稀有事件计数、电话呼叫到达、放射性衰变

### 1.3 几何分布 (Geometric Distribution)

**定义** 成功概率为 $p \in (0,1)$，第 $k$ 次首次成功的几何分布：

$$\mathbb{P}[X=k] = p(1-p)^{k-1}, \quad k=1,2,\ldots$$

**期望与方差**：
- $\mathbb{E}[X] = \frac{1}{p}$
- $\operatorname{Var}(X) = \frac{1-p}{p^2}$

**特征函数**：$f(t) = \frac{pe^{it}}{1-(1-p)e^{it}}$

**性质**：无记忆性 —— $\mathbb{P}[X > m+n \| X > m] = \mathbb{P}[X > n]$

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

$$p(x) = \frac{\lambda^n}{\Gamma(n)} x^{n-1} e^{-\lambda x}\mathbb{1}\_{x \ge 0}$$

这是伽马分布 $\Gamma(n, \lambda)$。

**性质**：无记忆性 —— $\mathbb{P}[X > s+t \| X > s] = \mathbb{P}[X > t]$

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

**应用**：自然现象建模、误差分析、统计推断

---

## 三、分布性质总结表

| 分布 | 参数 | 期望 | 方差 | 特征函数 |
|------|------|------|------|----------|
| 伯努利 | $p$ | $p$ | $p(1-p)$ | $(1-p)+pe^{it}$ |
| 泊松 | $\lambda$ | $\lambda$ | $\lambda$ | $\exp(\lambda(e^{it}-1))$ |
| 几何 | $p$ | $1/p$ | $(1-p)/p^2$ | $pe^{it}/(1-(1-p)e^{it})$ |
| 指数 | $\lambda$ | $1/\lambda$ | $1/\lambda^2$ | $\lambda/(\lambda-it)$ |
| 均匀$[a,b]$ | $a,b$ | $(a+b)/2$ | $(b-a)^2/12$ | $(e^{itb}-e^{ita})/(it(b-a))$ |
| 正态$\mathcal{N}(m,\sigma^2)$ | $m,\sigma^2$ | $m$ | $\sigma^2$ | $\exp(imt-\sigma^2 t^2/2)$ |

---

## 四、分布之间的关系图

```
                     伯努利分布
                         │
                         │ 重复n次独立试验
                         ▼
                   二项分布 Bin(n,p)
                         │
                         │ n→∞, p→0, np→λ
                         ▼
                   泊松分布 Poisson(λ)

                     指数分布 Exp(λ)
                         │
                         │ n个独立之和
                         ▼
              伽马分布 Γ(n, λ)

                  正态分布族
                         │
                         │ 独立和
                         ▼
                 正态分布保持不变
```

---

## 五、重要性质对比

### 无记忆性分布

具有无记忆性的分布只有：
- **几何分布**（离散）
- **指数分布**（连续）

无记忆性：$\mathbb{P}[X > s+t \| X > s] = \mathbb{P}[X > t]$

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

## 七、实际应用指南

| 场景 | 推荐分布 | 理由 |
|------|----------|------|
| 二值结果 | 伯努利 | 最简单的离散分布 |
| 稀有事件计数 | 泊松 | 稀有事件的极限模型 |
| 等待时间 | 指数/几何 | 无记忆性 |
| 自然现象 | 正态 | 中心极限定理 |
| 均匀随机抽样 | 均匀 | 最大熵原则 |
| 寿命/可靠性 | 伽马/韦布尔 | 灵活的形状参数 |

---

**下一篇**：[收敛理论](/posts/convergence-theory/)
