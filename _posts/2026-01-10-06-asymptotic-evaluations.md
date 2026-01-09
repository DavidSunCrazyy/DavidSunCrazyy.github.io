---
layout: post
title: "Statistical Inference 渐进评估"
permalink: /posts/statistical-inference-asymptotic-evaluation/
tags: statistical-inference
use\_math: true
---

## 相合性 Consistency

**定义 相合性**

一个估计量序列 $W\_n = W\_n(X\_1, \dots, X\_n)$ 是参数 $\theta$ 的一个相合估计量序列（consistent sequence of estimators），如果对于每个 $\epsilon > 0$ 和每个 $\theta \in \Theta$，
$$
\lim\_{n \to \infty} P\_\theta(|W\_n - \theta| < \epsilon) = 1.
$$

对于一个估计量 $W\_n$，回想一下 Chebychev 不等式的陈述
$$
P\_\theta(|W\_n - \theta| \geq \epsilon) \leq \frac{\operatorname{E}\_\theta[(W\_n - \theta)^2]}{\epsilon^2},
$$
这样，如果对于每个 $\theta \in \Theta$ 有
$$
\lim\_{n \to \infty} \operatorname{E}\_\theta[(W\_n - \theta)^2] = 0,
$$
则这个估计量序列就是相合的。

此外，根据式 (7.3.1) 就有
$$
\operatorname{E}\_\theta[(W\_n - \theta)^2] = \operatorname{Var}\_\theta W\_n + [\operatorname{Bias}\_\theta W\_n]^2.
$$
把其总括在一起，我们可以给出以下的定理。

**定理 相合性的证明**

    如果 $W\_n$ 是参数 $\theta$ 的一个估计量序列，它对于每个 $\theta \in \Theta$ 都满足
    1. $\lim\_{n \to \infty} \operatorname{Var}\_\theta W\_n = 0$,
    2. $\lim\_{n \to \infty} \operatorname{Bias}\_\theta W\_n = 0$,
    则 $W\_n$ 是参数 $\theta$ 的一个相合估计量序列。

**命题**

设 $W\_n$ 是参数 $\theta$ 的一个相合估计量序列。设 $a\_1, a\_2, \dots$ 和 $b\_1, b\_2, \dots$ 是常数序列，满足
1. $\lim\_{n \to \infty} a\_n = 1$,
2. $\lim\_{n \to \infty} b\_n = 0$.
则序列 $U\_n = a\_n W\_n + b\_n$ 是参数 $\theta$ 的一个相合估计量序列。


**定理 MLE 的相合性**

设 $X\_1, X\_2, \dots$ 是 iid $f(x|\theta)$ 的，$L(\theta|x) = \prod\_{i=1}^n f(x\_i|\theta)$ 是似然函数，而 $\hat{\theta}$ 表示 $\theta$ 的 MLE。设 $\tau(\theta)$ 是 $\theta$ 的一个连续函数。那么在关于 $f(x|\theta)$，也是对 $L(\theta|x)$ 的正则性条件之下，对于每个 $\epsilon > 0$ 和每个 $\theta \in \Theta$，有

$$
\lim\_{n \to \infty} P\_\theta(|\tau(\hat{\theta}) - \tau(\theta)| \geq \epsilon) = 0.
$$

这就是说，此 $\tau(\hat{\theta})$ 是 $\tau(\theta)$ 的一个相合估计量。

## 有效性 Efficiency

**定义 极限方差**

    对于一个估计量 $T\_n$，如果
$$
\lim\_{n \to \infty} k\_n \operatorname{Var}(T\_n) = \tau^2 < \infty,
$$
其中 $\{k\_n\}$ 是一个常数序列，则 $\tau^2$ 叫做极限方差（limiting variance）或方差的极限。

**定义 渐近方差**

对于一个估计量 $T\_n$，假定有依分布收敛 $k\_n(T\_n - \tau(\theta)) \xrightarrow{d} N(0, \sigma^2)$，则参数 $\sigma^2$ 叫做 $T\_n$ 的渐近方差或 $T\_n$ 的极限分布的方差. (asymptotic variance or variance of the limit distribution)

**定义 渐进有效**

一个估计量序列 $W\_n$ 关于一个参数 $\tau(\theta)$ 是渐近有效的，如果
$$
\sqrt{n}[W\_n - \tau(\theta)] \xrightarrow{L} N(0, \nu(\theta))
$$
而且
$$
\nu(\theta) = \frac{[\tau'(\theta)]^2}{\operatorname{E}\_\theta\left[\left(\frac{\partial}{\partial\theta}\log f(X|\theta)\right)^2\right]},
$$
也就是说，$W\_n$ 的渐近方差达到了 Cramér-Rao 下界.


**定理 MLE 的渐近有效性**

设 $X\_1, X\_2, \dots$ 是 iid $f(x|\theta)$，$\theta$ 的 MLE 记作 $\hat{\theta}$，设 $\tau(\theta)$ 是 $\theta$ 的一个连续函数。那么在 10.6 节 10.6.2 的关于 $f(x|\theta)$，从而也就是对 $L(\theta|x)$ 的正则性条件之下，
$$
\sqrt{n}[\tau(\hat{\theta}) - \tau(\theta)] \xrightarrow{L} N(0, \nu(\theta)),
$$
其中 $\nu(\theta)$ 是 Cramér-Rao 下界。也就是说，$\tau(\hat{\theta})$ 是 $\tau(\theta)$ 的一个相合且渐近有效的估计量。


**定义 渐近相对效率 (ARE)**

    如果两个估计量 $W\_n$ 和 $V\_n$ 满足
$$
\sqrt{n}[W\_n - \tau(\theta)] \longrightarrow N(0, \sigma\_W^2)
$$
$$
\sqrt{n}[V\_n - \tau(\theta)] \longrightarrow N(0, \sigma\_V^2)
$$
在分布上， $V\_n$ 相对于 $W\_n$ 的渐近相对效率 (ARE) 为
$$
\operatorname{ARE}(V\_n, W\_n) = \frac{\sigma\_W^2}{\sigma\_V^2}
$$


**命题 LRT 的渐近分布 - 简单 $H\_0$**

    对于检验 $H\_0 : \theta = \theta\_0$ 对 $H\_1 : \theta \ne \theta\_0$，假设 $X\_1, ..., X\_n$ 是独立同分布的 $f(x | \theta)$，$\hat{\theta}$ 是 $\theta$ 的 MLE，并且 $f(x | \theta)$ 满足正则性条件。那么在 $H\_0$ 下，当 $n \to \infty$ 时，
$$
-2\log(\lambda(\mathbf{X})) \longrightarrow \chi\_1^2 \quad \text{in dist.},
$$
其中 $\chi\_1^2$ 是自由度为 1 的 $\chi^2$ 随机变量。

**证明**

$H\_0 : \theta = \theta\_0$ 对 $H\_1 : \theta \ne \theta\_0$。
令 $\log L(\theta | \mathbf{x}) = l(\theta | \mathbf{x})$ 并在 $\hat{\theta}$ 附近进行泰勒展开，在 $\theta = \theta\_0$ 下
$$
l(\theta\_0 | \mathbf{x}) = l(\hat{\theta} | \mathbf{x}) + l'(\hat{\theta} | \mathbf{x})(\theta\_0 - \hat{\theta}) + l''(\hat{\theta} | \mathbf{x})\frac{(\theta\_0 - \hat{\theta})^2}{2} + \dots
$$
**忽略正则性条件下的项**

我们知道，
$$
\begin{aligned}
-2\log(\lambda(\mathbf{x})) &= -2\log\left[\frac{L(\theta\_0 | \mathbf{x})}{L(\hat{\theta} | \mathbf{x})}\right] \\
&= -2[l(\theta\_0 | \mathbf{x}) - l(\hat{\theta} | \mathbf{x})] \\
&= -2l(\theta\_0 | \mathbf{x}) + 2l(\hat{\theta} | \mathbf{x})
\end{aligned}
$$
$\therefore -2\log(\lambda(\mathbf{x})) \approx -2\left[l(\hat{\theta} | \mathbf{x}) + l'(\hat{\theta} | \mathbf{x})(\theta\_0 - \hat{\theta}) + l''(\hat{\theta} | \mathbf{x})\frac{(\theta\_0 - \hat{\theta})^2}{2}\right] + 2l(\hat{\theta} | \mathbf{x})$

注意 $l'(\hat{\theta} | \mathbf{x}) = 0$ 因为 $l'(\theta | \mathbf{x})|\_{\theta=\hat{\theta}} = 0$ 在正则性条件下。

$-2\log(\lambda(\mathbf{x})) \approx -l''(\hat{\theta} | \mathbf{x})(\theta\_0 - \hat{\theta})^2$

$-2\log(\lambda(\mathbf{x})) \approx (\theta\_0 - \hat{\theta})^2[-l''(\hat{\theta} | \mathbf{x})] = (\hat{\theta} - \theta\_0)^2 \hat{I}\_n(\hat{\theta})$

其中 $\hat{I}\_n(\hat{\theta})$ 是观测信息。

我们可以证明 $\frac{1}{n}\hat{I}\_n(\hat{\theta}) \xrightarrow{P} I\_1(\theta\_0)$，其中 $I\_1(\theta\_0)$ 是来自一个观测的信息量。
已知 (定理 10.1.12) $\frac{\sqrt{n}(\hat{\theta} - \theta\_0)}{\sqrt{1/I\_1(\theta\_0)}} \xrightarrow{\mathcal{L}} N(0,1)$
$$
\therefore \frac{n(\hat{\theta} - \theta\_0)^2}{1/I\_1(\theta\_0)} \xrightarrow{\mathcal{L}} \chi\_1^2
$$
$$
-2\log(\lambda(\mathbf{x})) \approx \frac{n(\hat{\theta} - \theta\_0)^2}{1/I\_1(\theta\_0)} \frac{1}{n}\hat{I}\_n(\hat{\theta}) \xrightarrow{\mathcal{L}} \chi\_1^2 \quad \text{通过应用 Slutsky 定理}
$$
$$
\underbrace{\frac{n(\hat{\theta} - \theta\_0)^2}{1/I\_1(\theta\_0)}}\_{\xrightarrow{\mathcal{L}} \chi\_1^2} \quad \underbrace{\frac{1}{n}\hat{I}\_n(\hat{\theta})}\_{\xrightarrow{P} 1}
$$
$$
\therefore -2\log(\lambda(\mathbf{x})) \xrightarrow{\mathcal{L}} \chi\_1^2 \quad \text{在 } H\_0 \text{ 下}.
$$




## 其他大样本集合测试

**命题 Wald 检验**

假设我们对检验关于 $\theta$ 的假设感兴趣，并且 $W\_n(X\_1, ..., X\_n)$ 是基于样本量 $n$ 的 $\theta$ 的点估计量，例如矩估计法 (Method of Moments)、最大似然估计 (MLE) 等。
令 $\sigma\_n^2 = \operatorname{Var}(W\_n)$，如果我们能使用某种形式的中心极限定理 (CLT) 并表明：

$$
(W\_n - \theta)/\sigma\_n \xrightarrow{\mathcal{L}} N(0,1) \quad (\text{检验的基础})
$$

如果 $W\_n$ 是 MLE，使用定理 10.1.12 来验证上述结论。
如果 $\sigma\_n$ 也依赖于一个未知参数怎么办？
$\rightarrow$ 估计 $\sigma\_n$ (使用 $S\_n$ 或 $\hat{\sigma}\_n$)，使得 $\left(\frac{\sigma\_n}{S\_n}\right) \xrightarrow{P} 1$
$$
\left. \begin{array}{l}
\xrightarrow{\mathcal{L}} \text{依分布收敛} \\
\xrightarrow{P} \text{依概率收敛}
\end{array} \right\} \text{应用 Slutsky 定理}
$$


**命题 Score 检验**

    假设 $\log f(x | \theta) = \log L(\theta | x)$ 对 $\theta$ 是二次可微的，并且我们可以交换积分和 $\frac{d}{d\theta}$ 的顺序来得到一阶和二阶导数。
令 $l(\theta | \mathbf{x}) = \log L(\theta | \mathbf{x})$。定义对 $\theta$ 的一阶导数为 $l'(\theta | \mathbf{x}) = \frac{\partial}{\partial\theta} \log L(\theta | \mathbf{x})$，这被称为得分。
假设检验 $H\_0: \theta = \theta\_0$ 对 $H\_1: \theta \ne \theta\_0$。在原假设下，我们有 $E[l'(\theta\_0 | \mathbf{X})] = 0$ 和 $\operatorname{Var}[l'(\theta\_0 | \mathbf{X})] = I\_n(\theta\_0) = \text{n 次观测的信息量}$。
得分检验：对数似然（或等价地似然）在 $\theta\_0$ 处的斜率是否为零。
得分检验的检验统计量是
$$
Z\_S(\mathbf{X}) = l'(\theta\_0 | \mathbf{X}) / \sqrt{I\_n(\theta\_0)}
$$
在 $H\_0$ 下，$Z\_S$ 的均值为 0，方差为 1，并收敛于标准正态随机变量。因此，近似水平为 $\alpha$ 的得分检验当 $|Z\_S(\mathbf{x})| > z\_{\alpha/2}$ 时拒绝 $H\_0$。


