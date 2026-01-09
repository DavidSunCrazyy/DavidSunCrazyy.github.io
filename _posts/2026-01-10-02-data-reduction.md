---
layout: post
title: "Statistical Inference 数据简化原理"
permalink: /posts/statistical-inference-data-reduction/
tags: statistical-inference
use\_math: true
---


## 充分统计量

**定义 参数**

$\theta \in \Theta$ 是参数，$\Theta$ 是参数空间。

**定义 充分统计量**

如果样本 $X$ 在给定 $T(X)$ 值的条件分布不依赖于 $\theta$，则称统计量 $T(X)$ 是 $\theta$ 的充分统计量。

**引理**

如果 $p(\mathbf{x}|\theta)$ 是 $\mathbf{X}$ 的联合概率密度函数（pdf）或联合概率质量函数（pmf），且 $q(t|\theta)$ 是 $T(\mathbf{X})$ 的概率密度函数（pdf）或概率质量函数（pmf），那么 $T(\mathbf{X})$ 是 $\theta$ 的**充分统计量**，当且仅当对于样本空间中的每一个 $\mathbf{x}$，比值 $p(\mathbf{x}|\theta) / q(T(\mathbf{x})|\theta)$ 作为 $\theta$ 的函数是常数。

**命题 充分性原理 (Sufficiency Principle)**

如果 $ T(X) $ 是参数 $ \theta $ 的一个充分统计量，那么关于 $ \theta $ 的任何推断都应仅依赖于样本 $ X $ 通过值 $ T(X) $。也就是说，如果 $ x $ 和 $ y $ 是两个样本点，且满足 $ T(x) = T(y) $，那么无论观察到的是 $ X = x $ 还是 $ X = y $，关于 $ \theta $ 的推断应该相同。


**定理 Factorization Theorem**

设 $f(\mathbf{x}|\theta)$ 表示样本 $X$ 的联合概率密度函数（pdf）或联合概率质量函数（pmf）。统计量 $T(\mathbf{X})$ 是 $\theta$ 的**充分统计量**，当且仅当存在函数 $g(t|\theta)$ 和 $h(\mathbf{x})$，使得对于所有样本点 $\mathbf{x}$ 和所有参数点 $\theta$，有：
    $$
    f(\mathbf{x}|\theta) = g(T(\mathbf{x})|\theta) h(\mathbf{x}).
    $$

**证明**

Proof (for discrete case):

Part 1: Show $ T(\mathbf{X}) $ sufficient $\implies f(\mathbf{x} \mid \theta) = g(T(\mathbf{x}) \mid \theta) h(\mathbf{x}) $

1. Start with the joint probability:
   $$
   f(\mathbf{x} \mid \theta) = P\_\theta(\mathbf{X} = \mathbf{x})
   $$
   Since $ T(\mathbf{X}) $ is a sufficient statistic, we can write:
   $$
   f(\mathbf{x} \mid \theta) = P\_\theta(\mathbf{X} = \mathbf{x} \text{ and } T(\mathbf{X}) = T(\mathbf{x}))
   $$
   Using the definition of conditional probability:
   $$
   f(\mathbf{x} \mid \theta) = P\_\theta(\mathbf{X} = \mathbf{x} \mid T(\mathbf{X}) = T(\mathbf{x})) \cdot P\_\theta(T(\mathbf{X}) = T(\mathbf{x}))
   $$
   By sufficiency, this can be rewritten as:
   $$
   f(\mathbf{x} \mid \theta) = \underbrace{P\_\theta(T(\mathbf{X}) = T(\mathbf{x}))}\_{g(T(\mathbf{x}) \mid \theta)} \cdot \underbrace{P(\mathbf{X} = \mathbf{x} \mid T(\mathbf{X}) = T(\mathbf{x}))}\_{h(\mathbf{x})}
   $$
   Thus, we have:
   $$
   f(\mathbf{x} \mid \theta) = g(T(\mathbf{x}) \mid \theta) h(\mathbf{x})
   $$

Part 2: Show $ f(\mathbf{x} \mid \theta) = g(T(\mathbf{x}) \mid \theta) h(\mathbf{x}) \implies T(\mathbf{X}) $ sufficient

1. Assume the factorization exists:
   $$
   f(\mathbf{x} \mid \theta) = g(T(\mathbf{x}) \mid \theta) h(\mathbf{x})
   $$
   Let $ T(\mathbf{X}) \sim q(t \mid \theta) $. We examine the ratio:
   $$
   \frac{f(\mathbf{x} \mid \theta)}{q(T(\mathbf{x}) \mid \theta)}
   $$
   Define $ A\_{T(\mathbf{x})} = \{\mathbf{y} : T(\mathbf{y}) = T(\mathbf{x})\} $, which is the partition containing all samples with $ T(\mathbf{x}) = t $ (the realized value). Then:
   $$
   \frac{f(\mathbf{x} \mid \theta)}{q(T(\mathbf{x}) \mid \theta)} = \frac{g(T(\mathbf{x}) \mid \theta) h(\mathbf{x})}{P\_\theta(T(\mathbf{X}) = T(\mathbf{x}))}
   $$
   The denominator $ P\_\theta(T(\mathbf{X}) = T(\mathbf{x})) $ is the sum over all points $ \mathbf{y} $ such that $ T(\mathbf{y}) = T(\mathbf{x}) $, which gives the probability of observing the partition value $ T(\mathbf{x}) $. By factorization:
   $$
   \frac{g(T(\mathbf{x}) \mid \theta) h(\mathbf{x})}{\sum\_{A\_{T(\mathbf{x})}} f(\mathbf{y} \mid \theta)} = \frac{g(T(\mathbf{x}) \mid \theta) h(\mathbf{x})}{\sum\_{A\_{T(\mathbf{x})}} g(T(\mathbf{y}) \mid \theta) h(\mathbf{y})}
   $$
   Since $ g(T(\mathbf{y}) \mid \theta) = g(T(\mathbf{x}) \mid \theta) $ for all $ \mathbf{y} \in A\_{T(\mathbf{x})} $, we can factor it out:
   $$
   = \frac{g(T(\mathbf{x}) \mid \theta) h(\mathbf{x})}{g(T(\mathbf{x}) \mid \theta) \sum\_{A\_{T(\mathbf{x})}} h(\mathbf{y})}
   $$
   Simplifying, we get:
   $$
   = \frac{h(\mathbf{x})}{\sum\_{A\_{T(\mathbf{x})}} h(\mathbf{y})}
   $$
   This expression is independent of $ \theta $, which implies that $ T(\mathbf{X}) $ is sufficient.

Thus, we have shown both directions of the equivalence:
$$
\boxed{T(\mathbf{X}) \text{ is sufficient } \iff f(\mathbf{x} \mid \theta) = g(T(\mathbf{x}) \mid \theta) h(\mathbf{x})}
$$

**命题 sufficient statistic for exponential family**

Let $ X\_1, \dots, X\_n $ be iid observations from a pdf or pmf $ f(x \mid \boldsymbol{\theta}) $ that belongs to an exponential family given by

$$
f(x \mid \boldsymbol{\theta}) = h(x) c(\boldsymbol{\theta}) \exp\left( \sum\_{i=1}^k w\_i(\boldsymbol{\theta}) t\_i(x) \right),
$$

where $ \boldsymbol{\theta} = (\theta\_1, \theta\_2, \dots, \theta\_d) $ and $ d \leq k $. Then

$$
T(\mathbf{X}) = \left( \sum\_{j=1}^n t\_1(X\_j), \dots, \sum\_{j=1}^n t\_k(X\_j) \right)
$$

is a sufficient statistic for $ \boldsymbol{\theta} $.

Note that $ d \leq k $ includes curved exponential families like $ \text{N}(\theta, \theta^2) $.


**定义 极小充分统计量 (minimal sufficient statistic)**

如果对于任何其他充分统计量 $T'(X)$，$T(x)$ 是 $T'(x)$ 的函数，则称充分统计量 $T(X)$ 为极小充分统计量。
$\forall \mathbf{x}, \mathbf{y}$ as long as $T'(\mathbf{x}) = T'(\mathbf{y})$ $\implies$ $T(\mathbf{x}) = T(\mathbf{y})$.


**定理 极小充分统计量判定**

设 $f(\mathbf{x} \mid \theta)$ 是样本 $\mathbf{X}$ 的概率质量函数（pmf）或概率密度函数（pdf）。假设存在一个函数 $T(\mathbf{x})$，使得对于任意两个样本点 $\mathbf{x}$ 和 $\mathbf{y}$，比值 $\frac{f(\mathbf{x} \mid \theta)}{f(\mathbf{y} \mid \theta)}$ 作为 $\theta$ 的函数是常数当且仅当 $T(\mathbf{x}) = T(\mathbf{y})$。那么 $T(\mathbf{X})$ 是 $\theta$ 的极小充分统计量。

总结：$\frac{f(\mathbf{x} \mid \theta)}{f(\mathbf{y} \mid \theta)}$ 关于 $\theta$ 是常数当且仅当 $T(\mathbf{x}) = T(\mathbf{y})$ $\Rightarrow$ $T(\mathbf{X})$ 是极小充分的。

## 辅助统计量

**定义 辅助统计量**

如果统计量 $S(X)$ 的分布与 $\theta$ 无关，则称 $S(X)$ 为辅助统计量（ancillary statistic）。

**例子 位置族辅助统计量**

设随机样本 $X\_1, \cdots, X\_n$ 取自累积分布函数为 $F(x-\theta), -\infty < \theta < \infty$ 的位置参数族总体，下证极差 $R = X\_{(n)} - X\_{(1)}$ 是辅助统计量。根据定理 3.5.6，若令 $X\_1 = Z\_1 + \theta, \cdots, X\_n = Z\_n + \theta$，则 $Z\_1, \cdots, Z\_n$ 是取自 $F(x)$（即取 $\theta = 0$）总体的随机样本。于是，极差统计量 $R$ 的累积分布函数为

$$
\begin{aligned}
F\_R(r|\theta) & = P\_\theta (R \leq r) \\
& = P\_\theta (\max X\_i - \min X\_i \leq r) \\
& = P\_\theta (\max (Z\_i + \theta) - \min (Z\_i + \theta) \leq r) \\
& = P\_\theta (\max Z\_i - \min Z\_i + \theta - \theta \leq r) \\
& = P\_\theta (\max Z\_i - \min Z\_i \leq r) \\
\end{aligned}
$$

由于 $Z\_1, \cdots, Z\_n$ 不依赖于 $\theta$，所以上述最后得到的概率与 $\theta$ 无关，即 $R$ 的累积分布函数与 $\theta$ 无关。故 $R$ 是辅助统计量。

**例子 尺度族辅助统计量**

尺度参数族也有一类辅助统计量。设随机样本 $X\_1, \cdots, X\_n$ 取自累积分布函数为 $F(x/\sigma), \sigma > 0$ 的尺度参数族总体，则所有只通过 $X\_1 / X\_n, \cdots, X\_{n-1} / X\_n$ 这 $n-1$ 个值与样本关联的统计量都是辅助统计量，例如

$$
\frac{X\_1 + \cdots + X\_n}{X\_n} = \frac{X\_1}{X\_n} + \cdots + \frac{X\_{n-1}}{X\_n} + 1
$$

事实上，若令 $X\_i = \sigma Z\_i$，则 $Z\_1, \cdots, Z\_n$ 是取自 $F(x)$（即取 $\sigma = 1$）总体的随机样本。于是，$X\_1 / X\_n, \cdots, X\_{n-1} / X\_n$ 的累积分布函数为

$$
F(y\_1, \cdots, y\_{n-1} | \sigma) = P\_\sigma (X\_1 / X\_n \leq y\_1, \cdots, X\_{n-1} / X\_n \leq y\_{n-1})
$$
$$
= P\_\sigma (\sigma Z\_1 / (\sigma Z\_n) \leq y\_1, \cdots, \sigma Z\_{n-1} / (\sigma Z\_n) \leq y\_{n-1})
$$
$$
= P\_\sigma (Z\_1 / Z\_n \leq y\_1, \cdots, Z\_{n-1} / Z\_n \leq y\_{n-1})
$$

由于 $Z\_1, \cdots, Z\_n$ 不依赖于 $\sigma$，所以上述最后得到的概率与 $\sigma$ 无关，即 $X\_1 / X\_n, \cdots, X\_{n-1} / X\_n$ 的分布与 $\sigma$ 无关。因此，这些统计量是辅助统计量。

## 完全统计量

**定义 完全统计量**

设 $T(X)$ 是一个基于样本 $X = (X\_1, X\_2, \dots, X\_n)$ 的统计量，其分布依赖于参数 $\theta$。如果对于所有函数 $g(\cdot)$，满足以下条件：
$$
\mathbb{E}\_\theta[g(T)] = 0 \quad \text{对所有 } \theta \implies g(T) = 0 \quad \text{几乎处处成立},
$$
则称统计量 $T(X)$ 是**完全统计量**。


**命题 指数族中的完全统计量**

设 $X\_1, \ldots, X\_n$ 是来自具有以下形式的概率密度函数或概率质量函数的指数族的独立同分布观察值：

$$ f(x \mid \boldsymbol{\theta}) = h(x) c(\boldsymbol{\theta}) \exp\left( \sum\_{j=1}^{k} w\_j(\boldsymbol{\theta}) t\_j(x) \right), $$

其中 $\boldsymbol{\theta} = (\theta\_1, \theta\_2, \ldots, \theta\_k)$。则统计量

$$ T(\mathbf{X}) = \left( \sum\_{i=1}^{n} t\_1(X\_i), \sum\_{i=1}^{n} t\_2(X\_i), \ldots, \sum\_{i=1}^{n} t\_k(X\_i) \right) $$

是完全的，如果 $\{(w\_1(\boldsymbol{\theta}), \ldots, w\_k(\boldsymbol{\theta})) : \boldsymbol{\theta} \in \Theta\}$ 在 $\mathbb{R}^k$ 中包含一个开集。

**定理 Basu's Theorem**

    If $T(\mathbf{x})$ is complete and minimal sufficient statistics, then, it is independent of any ancillary statistics.

    如果 $T(\mathbf{x})$ 是完全且极小充分的统计量，那么它与任何辅助统计量（ancillary statistic）相互独立。 在实际应用中，我们只需要考虑完全的充分统计量。


**例子 正态分布下样本均值 $\bar{X}$ 和样本方差 $S^2$ 的独立性**

    由于 $\bar{X}$ 是正态分布均值 $\mu$ 的完全充分统计量，而 $S^2$ 是关于 $\mu$ 的辅助统计量，根据巴苏定理，$\bar{X}$ 和 $S^2$ 是相互独立的。这个结果在统计推断中非常重要，例如在构建t检验和方差分析时。

**命题**

    If a minimal sufficient statistic exists any complete sufficient statistics is also minimal sufficient.

    如果存在一个极小充分统计量，那么任何完全的充分统计量也是极小充分的。

**命题 极小充分统计量**

    设概率密度函数族 $\{f\_0(x), \dots, f\_k(x)\}$ 有公共支撑集，则
    1. 统计量
        $$
            T(X) = \left( \frac{f\_1(X)}{f\_0(X)}, \frac{f\_2(X)}{f\_0(X)}, \dots, \frac{f\_k(X)}{f\_0(X)} \right)
        $$
        是分布族 $\{f\_0(x), \dots, f\_k(x)\}$ 的极小充分统计量；
    2. 设 $\mathcal{F}$ 是一集具有公共支撑集的概率密度函数，且
        a. $f\_i(x) \in \mathcal{F}, \, i = 0, 1, \dots, k$；
        b. $T(x)$ 是 $\mathcal{F}$ 的充分统计量。
        则 $T(x)$ 是 $\mathcal{F}$ 的极小充分统计量。
