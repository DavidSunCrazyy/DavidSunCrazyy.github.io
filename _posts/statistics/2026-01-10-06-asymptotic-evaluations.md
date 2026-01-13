---
layout: post
title: "Statistical Inference 渐进评估"
permalink: /posts/statistical-inference-asymptotic-evaluation/
tags: statistical-inference
use_math: true
---

本文系统研究统计推断量的渐近性质。首先建立相合性的概念和判断准则，这是估计量的基本性质。然后引入渐近有效性的概念，证明极大似然估计在正则条件下是相合且渐近有效的，达到Cramér-Rao下界。接着研究不同估计量之间的渐近相对效率（ARE），为大样本下选择估计量提供标准。然后推导似然比检验的渐近分布，证明其在原假设下收敛于卡方分布。最后介绍大样本检验的其他方法，包括Wald检验和Score检验，这些方法在样本量较大时都具有良好的性质，共同构成统计推断的大样本理论框架。

## 相合性 Consistency

**定义 相合性**

一个估计量序列 $W_n = W_n(X_1, \dots, X_n)$ 是参数 $\theta$ 的一个相合估计量序列（consistent sequence of estimators），如果对于每个 $\epsilon > 0$ 和每个 $\theta \in \Theta$，
$$
\lim_{n \to \infty} P_\theta(\|W_n - \theta\| < \epsilon) = 1.
$$

对于一个估计量 $W_n$，回想一下 Chebychev 不等式的陈述
$$
P_\theta(\|W_n - \theta\| \geq \epsilon) \leq \frac{\operatorname{E}\_\theta[(W_n - \theta)^2]}{\epsilon^2},
$$
这样，如果对于每个 $\theta \in \Theta$ 有
$$
\lim_{n \to \infty} \operatorname{E}\_\theta[(W_n - \theta)^2] = 0,
$$
则这个估计量序列就是相合的。

此外，根据式 (7.3.1) 就有
$$
\operatorname{E}\_\theta[(W_n - \theta)^2] = \operatorname{Var}\_\theta W_n + [\operatorname{Bias}\_\theta W_n]^2.
$$
把其总括在一起，我们可以给出以下的定理。

**定理 相合性的证明**
如果 $W_n$ 是参数 $\theta$ 的一个估计量序列，它对于每个 $\theta \in \Theta$ 都满足

1. $\lim_{n \to \infty} \operatorname{Var}\_\theta W_n = 0$,
2. $\lim_{n \to \infty} \operatorname{Bias}\_\theta W_n = 0$,

则 $W_n$ 是参数 $\theta$ 的一个相合估计量序列。

**命题**

设 $W_n$ 是参数 $\theta$ 的一个相合估计量序列。设 $a_1, a_2, \dots$ 和 $b_1, b_2, \dots$ 是常数序列，满足

1. $\lim_{n \to \infty} a_n = 1$,
2. $\lim_{n \to \infty} b_n = 0$.

则序列 $U_n = a_n W_n + b_n$ 是参数 $\theta$ 的一个相合估计量序列。


**定理 MLE 的相合性**

设 $X_1, X_2, \dots$ 是 iid $f(x\|\theta)$ 的，$L(\theta\|x) = \prod_{i=1}^n f(x_i\|\theta)$ 是似然函数，而 $\hat{\theta}$ 表示 $\theta$ 的 MLE。设 $\tau(\theta)$ 是 $\theta$ 的一个连续函数。那么在关于 $f(x\|\theta)$，也是对 $L(\theta\|x)$ 的正则性条件之下，对于每个 $\epsilon > 0$ 和每个 $\theta \in \Theta$，有

$$
\lim_{n \to \infty} P_\theta(\|\tau(\hat{\theta}) - \tau(\theta)\| \geq \epsilon) = 0.
$$

这就是说，此 $\tau(\hat{\theta})$ 是 $\tau(\theta)$ 的一个相合估计量。

## 有效性 Efficiency

**定义 极限方差**

对于一个估计量 $T_n$，如果
$$
\lim_{n \to \infty} k_n \operatorname{Var}(T_n) = \tau^2 < \infty,
$$
其中 $\{k_n\}$ 是一个常数序列，则 $\tau^2$ 叫做极限方差（limiting variance）或方差的极限。

**定义 渐近方差**

对于一个估计量 $T_n$，假定有依分布收敛 $k_n(T_n - \tau(\theta)) \xrightarrow{d} N(0, \sigma^2)$，则参数 $\sigma^2$ 叫做 $T_n$ 的渐近方差或 $T_n$ 的极限分布的方差. (asymptotic variance or variance of the limit distribution)

**定义 渐进有效**

一个估计量序列 $W_n$ 关于一个参数 $\tau(\theta)$ 是渐近有效的，如果
$$
\sqrt{n}[W_n - \tau(\theta)] \xrightarrow{L} N(0, \nu(\theta))
$$
而且
$$
\nu(\theta) = \frac{[\tau'(\theta)]^2}{\operatorname{E}\_\theta\left[\left(\frac{\partial}{\partial\theta}\log f(X\|\theta)\right)^2\right]},
$$
也就是说，$W_n$ 的渐近方差达到了 Cramér-Rao 下界.


**定理 MLE 的渐近有效性**

设 $X_1, X_2, \dots$ 是 iid $f(x\|\theta)$，$\theta$ 的 MLE 记作 $\hat{\theta}$，设 $\tau(\theta)$ 是 $\theta$ 的一个连续函数。那么在 10.6 节 10.6.2 的关于 $f(x\|\theta)$，从而也就是对 $L(\theta\|x)$ 的正则性条件之下，
$$
\sqrt{n}[\tau(\hat{\theta}) - \tau(\theta)] \xrightarrow{L} N(0, \nu(\theta)),
$$
其中 $\nu(\theta)$ 是 Cramér-Rao 下界。也就是说，$\tau(\hat{\theta})$ 是 $\tau(\theta)$ 的一个相合且渐近有效的估计量。


**定义 渐近相对效率 (ARE)**

如果两个估计量 $W_n$ 和 $V_n$ 满足
$$
\sqrt{n}[W_n - \tau(\theta)] \longrightarrow N(0, \sigma_W^2)
$$
$$
\sqrt{n}[V_n - \tau(\theta)] \longrightarrow N(0, \sigma_V^2)
$$
在分布上， $V_n$ 相对于 $W_n$ 的渐近相对效率 (ARE) 为
$$
\operatorname{ARE}(V_n, W_n) = \frac{\sigma_W^2}{\sigma_V^2}
$$


**命题 LRT 的渐近分布 - 简单 $H_0$**

对于检验 $H_0 : \theta = \theta_0$ 对 $H_1 : \theta \ne \theta_0$，假设 $X_1, ..., X_n$ 是独立同分布的 $f(x \| \theta)$，$\hat{\theta}$ 是 $\theta$ 的 MLE，并且 $f(x \| \theta)$ 满足正则性条件。那么在 $H_0$ 下，当 $n \to \infty$ 时，
$$
-2\log(\lambda(\mathbf{X})) \longrightarrow \chi_1^2 \quad \text{in dist.},
$$
其中 $\chi_1^2$ 是自由度为 1 的 $\chi^2$ 随机变量。

**证明**

$H_0 : \theta = \theta_0$ 对 $H_1 : \theta \ne \theta_0$。
令 $\log L(\theta \| \mathbf{x}) = l(\theta \| \mathbf{x})$ 并在 $\hat{\theta}$ 附近进行泰勒展开，在 $\theta = \theta_0$ 下
$$
l(\theta_0 \| \mathbf{x}) = l(\hat{\theta} \| \mathbf{x}) + l'(\hat{\theta} \| \mathbf{x})(\theta_0 - \hat{\theta}) + l''(\hat{\theta} \| \mathbf{x})\frac{(\theta_0 - \hat{\theta})^2}{2} + \dots
$$
**忽略正则性条件下的项**

我们知道，
$$
\begin{aligned}
-2\log(\lambda(\mathbf{x})) &= -2\log\left[\frac{L(\theta_0 \| \mathbf{x})}{L(\hat{\theta} \| \mathbf{x})}\right] \\
&= -2[l(\theta_0 \| \mathbf{x}) - l(\hat{\theta} \| \mathbf{x})] \\
&= -2l(\theta_0 \| \mathbf{x}) + 2l(\hat{\theta} \| \mathbf{x})
\end{aligned}
$$
$\therefore -2\log(\lambda(\mathbf{x})) \approx -2\left[l(\hat{\theta} \| \mathbf{x}) + l'(\hat{\theta} \| \mathbf{x})(\theta_0 - \hat{\theta}) + l''(\hat{\theta} \| \mathbf{x})\frac{(\theta_0 - \hat{\theta})^2}{2}\right] + 2l(\hat{\theta} \| \mathbf{x})$

注意 $l'(\hat{\theta} \| \mathbf{x}) = 0$ 因为 $l'(\theta \| \mathbf{x})\|_{\theta=\hat{\theta}} = 0$ 在正则性条件下。

$-2\log(\lambda(\mathbf{x})) \approx -l''(\hat{\theta} \| \mathbf{x})(\theta_0 - \hat{\theta})^2$

$-2\log(\lambda(\mathbf{x})) \approx (\theta_0 - \hat{\theta})^2[-l''(\hat{\theta} \| \mathbf{x})] = (\hat{\theta} - \theta_0)^2 \hat{I}\_n(\hat{\theta})$

其中 $\hat{I}\_n(\hat{\theta})$ 是观测信息。

我们可以证明 $\frac{1}{n}\hat{I}\_n(\hat{\theta}) \xrightarrow{P} I_1(\theta_0)$，其中 $I_1(\theta_0)$ 是来自一个观测的信息量。
已知 (定理 10.1.12) $\frac{\sqrt{n}(\hat{\theta} - \theta_0)}{\sqrt{1/I_1(\theta_0)}} \xrightarrow{\mathcal{L}} N(0,1)$
$$
\therefore \frac{n(\hat{\theta} - \theta_0)^2}{1/I_1(\theta_0)} \xrightarrow{\mathcal{L}} \chi_1^2
$$
$$
-2\log(\lambda(\mathbf{x})) \approx \frac{n(\hat{\theta} - \theta_0)^2}{1/I_1(\theta_0)} \frac{1}{n}\hat{I}\_n(\hat{\theta}) \xrightarrow{\mathcal{L}} \chi_1^2 \quad \text{通过应用 Slutsky 定理}
$$
$$
\underbrace{\frac{n(\hat{\theta} - \theta_0)^2}{1/I_1(\theta_0)}}\_{\xrightarrow{\mathcal{L}} \chi_1^2} \quad \underbrace{\frac{1}{n}\hat{I}\_n(\hat{\theta})}\_{\xrightarrow{P} 1}
$$
$$
\therefore -2\log(\lambda(\mathbf{x})) \xrightarrow{\mathcal{L}} \chi_1^2 \quad \text{在 } H_0 \text{ 下}.
$$




## 其他大样本集合测试

**命题 Wald 检验**

假设我们对检验关于 $\theta$ 的假设感兴趣，并且 $W_n(X_1, ..., X_n)$ 是基于样本量 $n$ 的 $\theta$ 的点估计量，例如矩估计法 (Method of Moments)、最大似然估计 (MLE) 等。
令 $\sigma_n^2 = \operatorname{Var}(W_n)$，如果我们能使用某种形式的中心极限定理 (CLT) 并表明：

$$
(W_n - \theta)/\sigma_n \xrightarrow{\mathcal{L}} N(0,1) \quad (\text{检验的基础})
$$

如果 $W_n$ 是 MLE，使用定理 10.1.12 来验证上述结论。
如果 $\sigma_n$ 也依赖于一个未知参数怎么办？
$\rightarrow$ 估计 $\sigma_n$ (使用 $S_n$ 或 $\hat{\sigma}\_n$)，使得 $\left(\frac{\sigma_n}{S_n}\right) \xrightarrow{P} 1$
$$
\left. \begin{array}{l}
\xrightarrow{\mathcal{L}} \text{依分布收敛} \\
\xrightarrow{P} \text{依概率收敛}
\end{array} \right\} \text{应用 Slutsky 定理}
$$


**命题 Score 检验**

假设 $\log f(x \| \theta) = \log L(\theta \| x)$ 对 $\theta$ 是二次可微的，并且我们可以交换积分和 $\frac{d}{d\theta}$ 的顺序来得到一阶和二阶导数。
令 $l(\theta \| \mathbf{x}) = \log L(\theta \| \mathbf{x})$。定义对 $\theta$ 的一阶导数为 $l'(\theta \| \mathbf{x}) = \frac{\partial}{\partial\theta} \log L(\theta \| \mathbf{x})$，这被称为得分。
假设检验 $H_0: \theta = \theta_0$ 对 $H_1: \theta \ne \theta_0$。在原假设下，我们有 $E[l'(\theta_0 \| \mathbf{X})] = 0$ 和 $\operatorname{Var}[l'(\theta_0 \| \mathbf{X})] = I_n(\theta_0) = \text{n 次观测的信息量}$。
得分检验：对数似然（或等价地似然）在 $\theta_0$ 处的斜率是否为零。
得分检验的检验统计量是
$$
Z_S(\mathbf{X}) = l'(\theta_0 \| \mathbf{X}) / \sqrt{I_n(\theta_0)}
$$
在 $H_0$ 下，$Z_S$ 的均值为 0，方差为 1，并收敛于标准正态随机变量。因此，近似水平为 $\alpha$ 的得分检验当 $\|Z_S(\mathbf{x})\| > z_{\alpha/2}$ 时拒绝 $H_0$。


