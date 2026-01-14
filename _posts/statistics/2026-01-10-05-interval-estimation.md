---
layout: post
title: "Statistical Inference 区间估计"
permalink: /posts/statistical-inference-interval-estimation/
tags: statistical-inference
use_math: true
---

本文系统研究参数的区间估计理论。首先定义区间估计、覆盖概率和置信系数等基本概念。然后介绍两种主要的区间构造方法：一是通过反转假设检验得到置信区间，建立检验与区间估计的对偶关系；二是利用枢轴量方法，适用于位置族、尺度族和位置-尺度族。接着建立区间估计的评价标准，研究最短置信区间和一致最大准确（UMA）置信集，证明反转UMP检验可得到UMA置信区间。最后引入无偏置信集的概念，并介绍贝叶斯可信区间，展示频率学派和贝叶斯学派在区间估计上的不同视角。

**定义 区间估计**

一个实值参数 $\theta$ 的区间估计是样本的任意一对函数 $L(x_1, \ldots, x_n)$ 和 $U(x_1, \ldots, x_n)$，对于所有的 $\mathbf{x} \in \mathcal{X}$ 满足 $L(\textbf{x}) \leq U(\textbf{x})$。如果观测到样本 $X = \mathbf{x}$，就做出推断 $L(\mathbf{x}) \leq \theta \leq U(\mathbf{x})$。随机区间 $[L(\mathbf{X}), U(\mathbf{X})]$ 叫做区间估计量 (interval estimator)。

- 再次说明，这看起来是一个"模糊"的定义，与点估计量（point estimator）类似。
- $[L(\mathbf{X}), U(\mathbf{X})]$ 是基于随机样本 $\mathbf{X} = (X_1, \ldots, X_n)$ 的一个随机区间。$[L(\mathbf{x}), U(\mathbf{x})]$ 是其观测值（即实现值）。
- 区间可以是单侧的，例如 $(-∞, U(\mathbf{x})]$ 或 $[L(\mathbf{x}), ∞)$。

**例子**

$X_1, X_2, X_3, X_4$ 独立同分布于 $\text{N}(\mu, 1)$。

$\mu$ 的一个区间估计量为 $[\bar{X} - 1, \bar{X} + 1]$。

我们在估计器的精度上有所牺牲，但我们在断言的正确性上获得了信心。已知 $\bar{X} \sim \text{N}(\mu, 1/4)$：

$$P(\bar{X} = \mu) = 0$$
$$
\begin{aligned}
P(\mu \in [\bar{X} - 1, \bar{X} + 1]) &= P(\bar{X} - 1 \leq \mu \leq \bar{X} + 1) \\
&= P(-1 \leq \bar{X} - \mu \leq 1) \\
&= P\left(-2 \leq \frac{\bar{X} - \mu}{\sqrt{1/4}} \leq 2\right) \\
&= P(-2 \leq Z \leq 2) = 0.9544
\end{aligned}
$$

结论

- >95% 的概率覆盖未知参数 $\mu$（固定），使用我们的区间估计量。
- 区间估计量 vs. 点估计量："区间估计量……对捕获感兴趣的参数有一定保证"。


**定义 覆盖概率 coverage probability**

对于参数 $\theta$ 的区间估计量 $[L(\mathbf{X}), U(\mathbf{X})]$，其覆盖概率是指随机区间 $[L(\mathbf{X}), U(\mathbf{X})]$ 覆盖真实参数 $\theta$ 的概率。用符号表示为
$$
P_\theta\left( \theta \in [L(\mathbf{X}), U(\mathbf{X})] \right) \quad \text{或} \quad P\left( \theta \in [L(\mathbf{X}), U(\mathbf{X})] \mid \theta \right).
$$

**定义 置信系数 confidence coefficient**

对于参数 $\theta$ 的区间估计量 $[L(\mathbf{X}), U(\mathbf{X})]$，其**置信系数**（confidence coefficient）定义为覆盖概率的下确界，即
$$
\inf_{\theta} P_\theta\left( \theta \in [L(\mathbf{X}), U(\mathbf{X})] \right).
$$


## 寻找区间估计的方法

### 反转一个检验统计量

**定理 反转检验统计量**

对于每一个 $\theta_0 \in \Theta$，设 $A(\theta_0)$ 是 $H_0: \theta = \theta_0$ 的一个水平为 $\alpha$ 的检验的接受区域。对每一个 $\textbf{x} \in \mathcal{X}$，在参数空间里定义一个集合 $C(\textbf{x})$：
$$
C(\textbf{x}) = \{\theta_0 : \textbf{x} \in A(\theta_0)\} 
$$
则随机集合 $C(\textbf{x})$ 是一个 $1-\alpha$ 置信集合。反之，设 $C(\textbf{x})$ 是一个 $1-\alpha$ 置信集合。对任意的 $\theta_0 \in \Theta$，定义
$$
A(\theta_0) = \{\textbf{x} : \theta_0 \in C(x)\}
$$
则 $A(\theta_0)$ 是 $H_0: \theta = \theta_0$ 的一个水平为 $\alpha$ 的检验的接受区域。

**证明**

关于第一部分，因为 $A(\theta_0)$ 是一个水平为 $\alpha$ 的检验的接受区域，所以
$$
P_{\theta_0}(X \notin A(\theta_0)) \leq \alpha
$$
并且因此
$$
P_{\theta_0}(X \in A(\theta_0)) \geq 1 - \alpha
$$
由于 $\theta_0$ 是任意的，可以把 $\theta_0$ 改写成 $\theta$。把上面的不等式与 (1) 合在一起，就证明了集合 $C(X)$ 的覆盖概率是
$$
P_\theta(\theta \in C(X)) = P_\theta(X \in A(\theta)) \geq 1 - \alpha
$$
这证明了 $C(X)$ 是一个 $1-\alpha$ 置信集合。

关于第二部分，对 $H_0: \theta = \theta_0$ 的以 $A(\theta_0)$ 作接受区域的检验，它犯第一类错误的概率是
$$
P_{\theta_0}(X \notin A(\theta_0)) = P_{\theta_0}(\theta_0 \notin C(X)) \leq \alpha
$$
所以是一个水平为 $\alpha$ 的检验。

### Pivotal Quantities


**定义 枢轴量 pivot**

若随机变量 $Q(X, \theta) = Q(X_1, \ldots, X_n, \theta)$ 的分布与所有参数无关，则称其为枢轴量（或枢轴）。也就是说，若 $X \sim F(x \mid \theta)$，则对于所有 $\theta$ 的值，$Q(X, \theta)$ 具有相同的分布。

**例子**

设 $X_1, \ldots, X_n$ 是来自正态分布 $N(\mu, \sigma^2)$ 的随机样本，令 $\bar{X} = (1/n)\sum_{i=1}^n X_i$ 和 $S^2 = [1/(n-1)]\sum_{i=1}^n (X_i - \barline{X})^2$。则

1. $\bar{X}$ 和 $S^2$ 是独立的随机变量，
2. $\bar{X}$ 服从 $N(\mu, \sigma^2/n)$ 分布，
3. $(n-1)S^2/\sigma^2$ 服从自由度为 $n-1$ 的卡方分布。

**如果 $\mu$ 未知且 $\sigma^2$ 已知**

$$Q(X, \theta) = \frac{\bar{X} - \mu}{\sigma / \sqrt{n}}$$
是一个与参数无关的枢轴量，服从 $N(0, 1)$。

$$P(-a \leq \frac{\bar{X} - \mu}{\sigma / \sqrt{n}} \leq a) = P(-a \leq Z \leq a) = 1 - \alpha \quad \text{当 } a = z_{\alpha/2}.$$

整理得到 $\mu$ 在中心：$\{\mu : \bar{x} - z_{\alpha/2} \frac{\sigma}{\sqrt{n}} \leq \mu \leq \bar{x} + z_{\alpha/2} \frac{\sigma}{\sqrt{n}}\}$。

**如果 $\sigma^2$ 也未知**

$$Q(X, \theta) = \frac{\bar{X} - \mu}{S / \sqrt{n}}$$
是一个与参数无关的枢轴量，服从 $t_{n-1}$。

$$P(-a \leq \frac{\bar{X} - \mu}{S / \sqrt{n}} \leq a) = P(-a \leq T_{n-1} \leq a) = 1 - \alpha \quad \text{当 } a = t_{n-1, \alpha/2}.$$

整理得到 $\mu$ 在中心：$\{\mu : \bar{x} - t_{n-1, \alpha/2} \frac{s}{\sqrt{n}} \leq \mu \leq \bar{x} + t_{n-1, \alpha/2} \frac{s}{\sqrt{n}}\}$。

上述区间给出了基于 Student's t-分布的 "经典" $(1-\alpha)$ 置信区间。

**关于 $\sigma^2$ 的区间**

$$Q(X, \theta) = \frac{(n-1)S^2}{\sigma^2} \sim \chi^2_{n-1} \quad \text{—— 与参数无关。}$$

选择 $a$ 和 $b$ 满足

$$P(a \leq \frac{(n-1)S^2}{\sigma^2} \leq b) = P(a \leq \chi^2_{n-1} \leq b) = 1 - \alpha$$

一种选择是将 $\alpha/2$ 放在每条尾部：$a = \chi^2_{n-1, 1-\alpha/2}, b = \chi^2_{n-1, \alpha/2}$



| **概率密度函数的形式 (Form of pdf)** | **概率密度函数的类型 (Type of pdf)** | **枢轴量 (Pivotal quantity)** |
|-------------------------------------|-------------------------------------|------------------------------|
| $f(x - \mu)$ | 位置型 (Location) | $\bar{X} - \mu$ |
| $\frac{1}{\sigma} f\left(\frac{x}{\sigma}\right)$ | 尺度型 (Scale) | $\frac{\bar{X}}{\sigma}$ |
| $\frac{1}{\sigma} f\left(\frac{x - \mu}{\sigma}\right)$ | 位置-尺度型 (Location-scale) | $\frac{\bar{X} - \mu}{S}$ |


### Pivoting the CDF

**命题 连续 CDF 的枢轴化**

设 $T$ 是一个具有连续分布函数 $F_T(t \| \theta)$ 的统计量。令 $\alpha_1 + \alpha_2 = \alpha$，其中 $0 < \alpha < 1$ 为固定值。假设对于每个 $t \in \mathcal{T}$，可以定义函数 $\theta_L(t)$ 和 $\theta_U(t)$ 如下：

1. 如果 $F_T(t \| \theta)$ 对于每个 $t$ 是 $\theta$ 的递减函数，则通过以下方式定义 $\theta_L(t)$ 和 $\theta_U(t)$：
$$
    F_T(t \| \theta_U(t)) = \alpha_1, \quad F_T(t \| \theta_L(t)) = 1 - \alpha_2
$$
2. 如果 $F_T(t \| \theta)$ 对于每个 $t$ 是 $\theta$ 的递增函数，则通过以下方式定义 $\theta_L(t)$ 和 $\theta_U(t)$：
$$
    F_T(t \| \theta_U(t)) = 1 - \alpha_2, \quad F_T(t \| \theta_L(t)) = \alpha_1
$$

那么随机区间 $[\theta_L(T), \theta_U(T)]$ 是 $\theta$ 的 $1 - \alpha$ 置信区间。

**注释：**

- 若对于每个 $t \in \mathcal{T}$，$F(t \| \theta)$ 是 $\theta$ 的递减函数，则称分布函数族 $F(t \| \theta)$ 在 $\theta$ 上是随机递增 (stochastically increasing) 的。
- 若对于每个 $t \in \mathcal{T}$，$F(t \| \theta)$ 是 $\theta$ 的递增函数，则称分布函数族 $F(t \| \theta)$ 在 $\theta$ 上是随机递减(stochastically decreasing) 的。

## Methods of Evaluating Interval Estimators

### Shortest Interval Estimation

**命题**

设 $f(x)$ 是一个单峰概率密度函数。如果区间 $[a, b]$ 满足以下条件：
1. $\int_{a}^{b} f(x) \, dx = 1 - \alpha$
2. $f(a) = f(b) > 0$，且
3. $a \leq x^* \leq b$，其中 $x^*$ 是 $f(x)$ 的众数，
那么 $[a, b]$ 是所有满足条件 i 的区间中最短的一个。

**注意：** 单峰是指 $f(x)$ 在 $x \leq x^*$ 上非减，在 $x \geq x^*$ 上非增。

### 一致最大准确 (UMA) 置信集

我们了解到，置信集 $C(x)$ 的覆盖概率，或者说真覆盖概率是 $\theta$ 的函数，由 $P_{\theta}(\theta \in C(X))$ 给出。我们现在定义假值覆盖概率为 $\theta$ 和 $\theta'$ 的函数，如下所示：

$$
\begin{aligned}
&P_{\theta}(\theta' \in C(X)), \theta' \neq \theta, \quad \text{如果 } C(X) = [L(X), U(X)], \\
&P_{\theta}(\theta' \in C(X)), \theta' < \theta, \quad \text{如果 } C(X) = [L(X), \infty), \\
&P_{\theta}(\theta' \in C(X)), \theta' > \theta, \quad \text{如果 } C(X) = (-\infty, U(X)],
\end{aligned}
$$

$$
\left.
\begin{array}{l}
\text{假值覆盖是 } \theta \text{ 和 } \theta' \text{ 的函数}, \\
\text{当 } \theta \text{ 是真实参数时覆盖 } \theta' \text{ 的概率}
\end{array}
\right\} \text{间接衡量大小}.
$$


**定义 一致最大准确 (UMA) 置信集**

固定 $\alpha$：在一类 $(1-\alpha)$ 置信集中，最小化假值覆盖的 $(1-\alpha)$ 置信集叫做一致最大准确 (UMA) 置信集。

检验 $H_0: \theta = \theta_0$, $H_1: \theta > \theta_0$ $\mathrm{Im}plies$ UMA 下界置信区间 $[L(X), \infty)$。


**定理 反转 UMP $\mathrm{Im}plies$ UMA**

设 $X \sim f(x \mid \theta)$，其中 $\theta$ 是一个实值参数。对于每个 $\theta_0 \in \Theta$，令 $A^*(\theta_0)$ 为检验 $H_0: \theta = \theta_0$ 对于 $H_1: \theta > \theta_0$ 的 UMP（一致最大功效）水平 $\alpha$ 的接受域。令 $C^*(\textbf{x})$ 为通过反转 UMP 接受域形成的 $1-\alpha$ 置信集。那么对于任何其他 $1-\alpha$ 置信集 $C$，
$$
P_\theta(\theta' \in C^*(\textbf{X})) \leq P_\theta(\theta' \in C(\textbf{X})) \quad \text{对所有 } \theta' < \theta.
$$

上述定理表明：反转 UMP $\mathrm{Im}plies$ UMA（一致最大置信度）。


**证明**

设 $\theta'$ 为任意小于 $\theta$ 的值，即 $\theta' < \theta$。
- $A(\theta')$：由反转置信集 $C$ 得到的检验 $H_0: \theta = \theta'$ 的水平 $\alpha$ 的接受域。
- $A^*(\theta')$：检验 $H_0: \theta = \theta'$ 对于 $H_1: \theta > \theta'$ 的 UMP 接受域。

由于 $\theta > \theta'$（备择假设空间），有：
$$
\begin{aligned}
P_\theta(\theta' \in C^*(X)) &= P_\theta(X \in A^*(\theta')) \quad \text{(反转置信集)} \\
&\leq P_\theta(X \in A(\theta')) \quad \text{(对任何 $A$ 成立，因为 $A^*$ 是 UMP)} \\
&= P_\theta(\theta' \in C(X)) \quad \text{(反转 $A$ 得到 $C$)}
\end{aligned}
$$

"$\leq$"是因为在处理接受域的概率时：$1-$ 功效 $\to$ UMP 最小化接受域概率。

因此，对于 $\theta' < \theta$，由反转 UMP 检验得到的区间最小化了错误覆盖的概率。


对于 $H_0: \theta = \theta_0$ 对于 $H_1: \theta < \theta_0$



**回忆：置信集的形式由备择假设决定。**


**无偏性**对于假设检验（即在 $H_1$ 下的功率 $\geq$ 在 $H_0$ 下的功率）来说是"令人信服且有用的"，尤其是在处理双边备择假设时。

同样地，在处理双边置信区间时，我们将注意力限制在 \underline{无偏置信集} 上。

**定义 无偏置信集**

一个 $1-\alpha$ 置信集 $C(\mathbf{x})$ 是无偏的，如果对于所有 $\theta \neq \theta'$，有
$$ P_{\theta}(\theta' \in C(\mathbf{X})) \leq 1 - \alpha. $$

$$
\mathrm{Im}plies \underbrace{P_{\theta}(\theta \in C(\mathbf{X}))}\_{\geq (1-\alpha)} \geq \underbrace{P_{\theta}(\theta' \in C(\mathbf{X}))}\_{\leq 1-\alpha}
$$

注意，上述定义表明，对于任何无偏置信集，假值覆盖的概率永远不会超过真实覆盖概率的最小值。

**定理 Pratt**

设 $X$ 是一个实值随机变量，满足 $X \sim f(x \mid \theta)$，其中 $\theta$ 是一个实值参数。设 $C(x) = [L(x), U(x)]$ 是 $\theta$ 的一个置信区间。如果 $L(x)$ 和 $U(x)$ 都是 $x$ 的递增函数，则对于任意值 $\theta^*$，
$$
\mathbb{E}\_{\theta^*}(\text{Length}[C(X)]) = \int_{\theta \neq \theta^*} P_{\theta^*}(\theta \in C(X)) \, d\theta.
$$

### Bayesian

**定义 Bayes 可信区间**

Bayes 集合和经典的置信集合在概率解释上有显著差异。为了区分两者，Bayes 估计集合被称为 **可信集合（credible sets）**，而不是置信集合。具体来说：

- 若 $\pi(\theta\|x)$ 是给定观测数据 $X=x$ 条件下参数 $\theta$ 的后验分布，则对于任意集合 $A \subseteq \Theta$，集合 $A$ 的 **可信概率** 定义为：
$$
P(\theta \in A \| x) = \int_A \pi(\theta\|x) \, d\theta
$$
如果 $\pi(\theta\|x)$ 是一个概率质量函数，则上述积分应替换为求和。

-  可见，Bayes 可信集合的解释和构造比经典的置信集合更为直观和直接。然而，这种省力的解释和构造需要付出代价：Bayes 模型要求更多的输入，例如先验分布，而经典模型则不需要这些额外假设。

总结而言，Bayes 可信集合与经典置信集合的核心区别在于其基于后验分布的概率解释，但这种优势是以引入更多主观假设为代价的。

### Bayesian Optimality Interval

获得具有指定覆盖概率的最小置信集合的目标也能利用 Bayes 准则达到。如果我们有一个后验分布 $\pi(\theta \mid x)$，即给定 $X = x$ 时 $\theta$ 的后验分布，而我们欲求集合 $C(x)$，满足

i. $\int_{C(x)} \pi(\theta \mid x) \, d\theta = 1 - \alpha$.
ii. 尺寸$(C(x)) \leqslant$ 尺寸$(C'(x))$

对于任何满足 $\int_{C'(x)} \pi(\theta \mid x) \, d\theta \geqslant 1 - \alpha$ 的集合 $C'(x)$ 成立。

如果用长度当作尺寸大小的测度，则我们得到以下的结果。

**推论**

如果后验密度 $\pi(\theta \mid x)$ 是单峰的，则对于一个给定的 $\alpha$ 值，关于 $\theta$ 的最短可信区间由

$$
\{\theta : \pi(\theta \mid x) \geq k\}
$$

其中

$$
\int_{\{\theta : \pi(\theta \mid x) \geq k\}} \pi(\theta \mid x) \, d\theta = 1 - \alpha
$$

给出。

