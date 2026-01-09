---
layout: post
title: "Statistical Inference 点估计"
permalink: /posts/statistical-inference-point-estimation/
tags: statistical-inference
use\_math: true
---


**定义 点估计量**

一个**点估计量**是样本的任意函数 $W(X\_1,...,X\_n)$；也就是说，任何统计量都是点估计量。

- 我们对点估计量的定义 $W(X\_1,...,X\_n)$ 可能看起来"不必要地模糊"，原因是不希望"排除任何候选者"。

**注意：**
1. 估计量是样本 $X\_1,...,X\_n$ 的函数。
2. 估计值是估计量的实现值，是 $x\_1,...,x\_n$ 的函数。

- 在许多情况下，存在一个明显或自然的点估计量候选者（例如，样本均值：总体均值的自然估计量）。
- 在复杂情况下："直觉不仅可能抛弃我们，还可能误导我们。"

**命题 MOM**

矩估计法步骤（以单参数为例）

假设我们有一个总体分布，含有一个未知参数 $\theta$，从总体中抽取了一个简单随机样本 $X\_1, X\_2, \dots, X\_n$。

步骤如下：

1. 计算总体的前 $k$ 阶矩（通常是原点矩），并表示为参数 $\theta$ 的函数。
2. 计算对应的样本矩。
3.  将样本矩代替总体矩，建立方程。
4. 解这个方程，得到参数 $\theta$ 的估计量 $\hat{\theta}$。


## 极大似然估计量（MLEs）

**定义 似然函数 Likelihood Function**

设 $f(x | \theta)$ 表示样本 $X = (X\_1, ..., X\_n)$ 的联合概率密度函数（pdf）或概率质量函数（pmf）。那么，当观察到 $X = x$ 时，由
$$L(\theta | x) = f(x | \theta)$$
定义的关于 $\theta$ 的函数称为**似然函数**。

注意:
- 概率密度函数或概率质量函数 $f(x | \theta)$：$\theta$ 固定，$x$ 为变量。
- 似然函数 $L(\theta | x)$：$x$ 为观察到的样本点，$\theta$ 在所有可能的参数值上变化。


**命题 似然原理**

    如果 $x$ 和 $y$ 是两个样本点，且 $L(\theta \mid x)$ 与 $L(\theta \mid y)$ 成比例，即存在一个常数 $C(x, y)$，使得对于所有的 $\theta$，都有
    那么从 $x$ 和 $y$ 得出的结论应该是相同的。

寻找最大似然估计量（MLEs）：

首先假设我们可以找到一阶和二阶导数...

$$\frac{\partial}{\partial \theta\_i} L(\theta | x) = 0, \, i = 1, ..., k$$

一阶导数等于零 $\implies$
局部或全局最小值/最大值, 拐点

但是，极值可能出现在边界上，因此必须单独检查边界。


**定理 极大似然估计的不变性**

若 $\hat{\theta}$ 是 $\theta$ 的极大似然估计（MLE），则对于 $\theta$ 的任何函数 $\tau(\theta)$，$\tau(\hat{\theta})$ 是 $\tau(\theta)$ 的 MLE。

**证明**

令 $\eta$ 表示使 $L^* (\eta|x)$ 达到极大的值。我们需要证明 $L^* (\eta|x) = L^* [\tau(\hat{\theta})|x]$。根据前面的讨论，$L$ 的极大值与 $L^*$ 的极大值是一致的，因此我们有
$$L^* (\eta|x) = \sup\_{\eta} \sup\_{(\theta: \tau(\hat{\theta}) = \eta)} L(\theta|x) \quad (L^* \text{ 的定义})$$
$$= \sup\_{\theta} L(\theta|x)$$
$$= L(\hat{\theta}|x) \quad (\hat{\theta} \text{ 的定义})$$

这里第二个等式成立的原因是累次极大化等于 $\theta$ 上的无条件极大化，而后者在 $\hat{\theta}$ 达到。此外，
$$L(\hat{\theta}|x) = \sup\_{(\theta: \tau(\hat{\theta}) = \tau(\hat{\theta}))} L(\theta|x) \quad (\hat{\theta} \text{ 是 MLE})$$
$$= L^* [\tau(\hat{\theta})|x] \quad (L^* \text{ 的定义})$$

因此，以上等式串证明了 $L^* (\eta|x) = L^* [\tau(\hat{\theta})|x]$ 和 $\tau(\hat{\theta})$ 是 $\tau(\theta)$ 的 MLE。

### MLE in exponential family




## Bayes估计

**定义 Bayes估计**

-  $\pi(\theta)$ 先验分布 Prior Distribution
-  $f(\mathbf{x}\mid\theta)$  Sampling Distribution
-  $\pi(\theta \mid \mathbf{x})$ 后验分布 Posterior Distribution

$$
\pi(\theta \mid \mathbf{x}) = \frac{f(\mathbf{x}, \theta)}{f(\mathbf{x})} = \frac{f(\mathbf{x}\mid \theta)\pi(\theta)} {\int\_\theta f(\mathbf{x}\mid \theta) \pi(\theta) \, d \theta}
$$

**定义 共轭族**

设 $\mathcal{F}$ 是概率密度函数或概率质量函数 $f(x \mid \theta)$ 的类（以 $\theta$ 为指标）。称一个先验分布类 $\Pi$ 为 $\mathcal{F}$ 的一个共轭族（conjugate family），如果对所有的 $f \in \mathcal{F}$，所有的 $\Pi$ 中的先验分布和所有的 $x \in X$，其后验分布仍在 $\Pi$ 中。

| Distribution of $X$ | Parameter | Conjugate prior distribution |
|---------------------|-----------|------------------------------|
| Binomial | Prob. of success | Beta |
| Poisson | Mean | Gamma |
| Exponential | Reciprocal of mean | Gamma |
| Normal | Mean (variance known) | Normal |
| Normal | Variance (mean known) | Inverse Gamma |


### 指数族的共轭族

1. Exponential Family Representation

An exponential family of distributions is a class of probability distributions whose probability mass function (pmf) or probability density function (pdf) can be written in the following canonical form:

$$
f(x \mid \boldsymbol{\eta}) = h(x) c^*(\boldsymbol{\eta}) \exp(\boldsymbol{\eta}^T \mathbf{t}(x)),
$$

where:
-  $h(x)$: A base measure that depends only on $x$.
- $\mathbf{t}(x) = (t\_1(x), \dots, t\_k(x))^T$: A vector of sufficient statistics.
-  $\boldsymbol{\eta} = (\eta\_1, \dots, \eta\_k)^T$: The natural parameters.
-  $c^*(\boldsymbol{\eta})$: The normalizing constant, ensuring that $f(x \mid \boldsymbol{\eta})$ integrates to 1.

The normalizing constant $c^*(\boldsymbol{\eta})$ is defined as:

$$
c^*(\boldsymbol{\eta}) = \left[ \int\_{\infty} h(x) \exp(\boldsymbol{\eta}^T \mathbf{t}(x)) \, dx \right]^{-1}.
$$

To simplify notation, we define the log-partition function $A(\boldsymbol{\eta})$ as:

$$
A(\boldsymbol{\eta}) = \log \left[ \int\_{\infty} h(x) \exp(\boldsymbol{\eta}^T \mathbf{t}(x)) \, dx \right].
$$

Using this, the pdf can be rewritten as:

$$
f(x \mid \boldsymbol{\eta}) = h(x) \exp(\boldsymbol{\eta}^T \mathbf{t}(x) - A(\boldsymbol{\eta})).
$$

2. Likelihood Function for IID Data

Suppose we have $n$ independent and identically distributed (i.i.d.) observations $X\_1, X\_2, \dots, X\_n$ from the exponential family with pdf $f(x \mid \boldsymbol{\eta})$. The joint likelihood function is:

$$
f(\mathbf{x} \mid \boldsymbol{\eta}) = \prod\_{i=1}^n f(x\_i \mid \boldsymbol{\eta}).
$$

Substituting the exponential family form of $f(x\_i \mid \boldsymbol{\eta})$:

$$
f(\mathbf{x} \mid \boldsymbol{\eta}) = \prod\_{i=1}^n \left[ h(x\_i) \exp(\boldsymbol{\eta}^T \mathbf{t}(x\_i) - A(\boldsymbol{\eta})) \right].
$$

This can be simplified as:

$$
f(\mathbf{x} \mid \boldsymbol{\eta}) = \left( \prod\_{i=1}^n h(x\_i) \right) \exp \left( \boldsymbol{\eta}^T \sum\_{i=1}^n \mathbf{t}(x\_i) - n A(\boldsymbol{\eta}) \right).
$$

Thus, the likelihood function is:

$$
f(\mathbf{x} \mid \boldsymbol{\eta}) = \left[ \prod\_{i=1}^n h(x\_i) \right] \cdot \exp \left( \boldsymbol{\eta}^T \sum\_{i=1}^n \mathbf{t}(x\_i) - n A(\boldsymbol{\eta}) \right).
$$

3. Conjugate Prior

A conjugate prior for an exponential family is a prior distribution whose functional form remains the same after observing data. To construct such a prior, we mimic the form of the likelihood function as a function of the natural parameter $ \boldsymbol{\eta} $.

The conjugate prior is given by:

$$
\pi(\boldsymbol{\eta} \mid \boldsymbol{\tau}, n\_0) = H(\boldsymbol{\tau}, n\_0) \exp \left( \boldsymbol{\eta}^T \boldsymbol{\tau} - n\_0 A(\boldsymbol{\eta}) \right),
$$

where:
- $ H(\boldsymbol{\tau}, n\_0) $: A normalizing constant that ensures $ \pi(\boldsymbol{\eta} \mid \boldsymbol{\tau}, n\_0) $ is a valid probability density function.
-  $\boldsymbol{\tau}$: A vector of hyperparameters.
-  $n\_0$: A scalar hyperparameter.



The prior mimics the likelihood's dependence on $ \boldsymbol{\eta} $ through the term $\exp(\boldsymbol{\eta}^T \boldsymbol{\tau} - n\_0 A(\boldsymbol{\eta}))$.

4. Posterior Distribution

Given the prior $\pi(\boldsymbol{\eta} \mid \boldsymbol{\tau}, n\_0)$ and the likelihood $f(\mathbf{x} \mid \boldsymbol{\eta})$, the posterior distribution is proportional to their product:

$$
\pi(\boldsymbol{\eta} \mid \mathbf{x}, \boldsymbol{\tau}, n\_0) \propto \pi(\boldsymbol{\eta} \mid \boldsymbol{\tau}, n\_0) f(\mathbf{x} \mid \boldsymbol{\eta}).
$$

Substituting the expressions for the prior and likelihood:

$$
\pi(\boldsymbol{\eta} \mid \mathbf{x}, \boldsymbol{\tau}, n\_0) \propto \left[ H(\boldsymbol{\tau}, n\_0) \exp \left( \boldsymbol{\eta}^T \boldsymbol{\tau} - n\_0 A(\boldsymbol{\eta}) \right) \right] \cdot \left[ \exp \left( \boldsymbol{\eta}^T \sum\_{i=1}^n \mathbf{t}(x\_i) - n A(\boldsymbol{\eta}) \right) \right].
$$

Combining the terms:

$$
\pi(\boldsymbol{\eta} \mid \mathbf{x}, \boldsymbol{\tau}, n\_0) \propto \exp \left( \boldsymbol{\eta}^T \boldsymbol{\tau} + \boldsymbol{\eta}^T \sum\_{i=1}^n \mathbf{t}(x\_i) - (n\_0 + n) A(\boldsymbol{\eta}) \right).
$$

This can be rewritten as:

$$
\pi(\boldsymbol{\eta} \mid \mathbf{x}, \boldsymbol{\tau}, n\_0) \propto \exp \left( \boldsymbol{\eta}^T \left( \boldsymbol{\tau} + \sum\_{i=1}^n \mathbf{t}(x\_i) \right) - (n\_0 + n) A(\boldsymbol{\eta}) \right).
$$

Notice that the posterior has the same functional form as the prior, but with updated hyperparameters:

$$
\boldsymbol{\tau} \to \boldsymbol{\tau} + \sum\_{i=1}^n \mathbf{t}(x\_i),
$$
$$
n\_0 \to n\_0 + n.
$$

Thus, the posterior is also a member of the same exponential family, confirming that the prior is conjugate.

5. Original Form of Exponential Families

Exponential families can also be expressed in terms of the original parameters $\boldsymbol{\theta}$ instead of the natural parameters $\boldsymbol{\eta}$. In this case, the natural parameters $\eta\_i$ are related to the original parameters $\theta\_i$ through a transformation $\eta\_i = w\_i(\boldsymbol{\theta})$. The conjugate prior can be derived similarly by replacing $\eta\_i$ with $w\_i(\boldsymbol{\theta})$ in the expressions above.

Summary

- Exponential Family: A probability distribution can be written in the form $f(x \mid \boldsymbol{\eta}) = h(x) \exp(\boldsymbol{\eta}^T \mathbf{t}(x) - A(\boldsymbol{\eta}))$.
- Likelihood: For i.i.d. data, the likelihood is $f(\mathbf{x} \mid \boldsymbol{\eta}) = \left[ \prod\_{i=1}^n h(x\_i) \right] \exp \left( \boldsymbol{\eta}^T \sum\_{i=1}^n \mathbf{t}(x\_i) - n A(\boldsymbol{\eta}) \right)$.
- Conjugate Prior: A prior of the form $\pi(\boldsymbol{\eta} \mid \boldsymbol{\tau}, n\_0) = H(\boldsymbol{\tau}, n\_0) \exp \left( \boldsymbol{\eta}^T \boldsymbol{\tau} - n\_0 A(\boldsymbol{\eta}) \right)$ ensures that the posterior has the same functional form.
- Posterior: The posterior updates the hyperparameters as $\boldsymbol{\tau} \to \boldsymbol{\tau} + \sum\_{i=1}^n \mathbf{t}(x\_i)$ and $n\_0 \to n\_0 + n$.



The final answer is:

$$
\boxed{\pi(\boldsymbol{\eta} \mid \mathbf{x}, \boldsymbol{\tau}, n\_0) \propto \exp \left( \boldsymbol{\eta}^T \left( \boldsymbol{\tau} + \sum\_{i=1}^n \mathbf{t}(x\_i) \right) - (n\_0 + n) A(\boldsymbol{\eta}) \right)}
$$



## 估计量的评价方法

**定义 MSE**

Mean Squared Error
$$\operatorname{E}\_\theta (W-\theta)^2 = \operatorname{Var}[W] + (\operatorname{E} W-\theta)^2 = \operatorname{Var}[W] + (\operatorname{Bias}[W])^2$$

**定义 最佳无偏估计量, BUE, UMVUE**

估计量 $W^*$ 称为 $\tau(\theta)$ 的最佳无偏估计量（best unbiased estimator），如果它满足：
$$
\mathbb{E}\_\theta W^* = \tau(\theta)
$$
对所有 $\theta$ 成立，并且对任何一个其他的满足 $\mathbb{E}\_\theta(W) = \tau(\theta)$ 的估计量 $W$，都有：
$$
\operatorname{Var}\_\theta W^* \leq \operatorname{Var}\_\theta W
$$
对所有 $\theta$ 成立。$W^*$ 也称为 $\tau(\theta)$ 的一致最小方差无偏估计量（uniform minimum variance unbiased estimator，简记 UMVUE）。


**定理 Cramér-Rao 不等式**

设 $X\_1, \dots, X\_n$ 是具有概率密度函数 $f(x|\theta)$ 的样本，令 $W(X) = W(X\_1, \dots, X\_n)$ 是任意的一个估计量，满足
$$
\frac{\mathrm{d}}{\mathrm{d}\theta} \mathbb{E}\_\theta W(\mathbf{X}) = \int\_x \frac{\partial}{\partial \theta}[W(x)f(x|\theta)] \, \mathrm{d}x
$$

和
$$
\operatorname{Var}\_\theta W(\mathbf{X}) < \infty
$$

则有
$$
\operatorname{Var}\_\theta(W(\mathbf{X})) \geqslant \frac{\left(\frac{\mathrm{d}}{\mathrm{d}\theta} \mathbb{E}\_\theta W(\mathbf{X})\right)^2}{\mathbb{E}\_\theta\left(\left(\frac{\partial}{\partial \theta} \log f(\mathbf{X} \mid \theta)\right)^2\right)}
$$

其中 $I(\theta): = \mathbb{E}\_\theta\left(\left(\frac{\partial}{\partial \theta} \log f(\mathbf{X} \mid\theta)\right)^2\right)$ 是**Fisher信息量**。

**证明**

这个定理的证明手法简洁漂亮，它是 Cauchy-Schwarz 不等式的一次聪明的运用，或用统计的语言说，证明利用了这样的事实：对于任意两个随机变量 $X$ 和 $Y$，有
$$
[\text{Cov}(X, Y)]^2 \leq (\text{Var}X)(\text{Var}Y)
$$
重新安排一下式 (7.3.6)，我们就可以得到 $X$ 方差的一个下界，
$$
\text{Var}X \geq \frac{[\text{Cov}(X, Y)]^2}{\text{Var}Y}.
$$
这个定理证明的聪明之处从 $X$ 和 $Y$ 的选择开始。把 $X$ 选为估计量 $W(\mathbf{X})$ 而 $Y$ 选为 $\frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)$，然后应用 Cauchy-Schwarz 不等式。

首先注意有
$$
\begin{aligned}
\frac{\mathrm{d}}{\mathrm{d}\theta}\mathbb{E}\_\theta W(\mathbf{X}) &= \int\_{x} W(x)\left[\frac{\partial}{\partial\theta}f(\mathbf{x} \mid \theta)\right]\mathrm{d}x \\
&= \mathbb{E}\_\theta\left[W(\mathbf{X})\frac{\frac{\partial}{\partial\theta}f(\mathbf{X} \mid \theta)}{f(\mathbf{X} \mid \theta)}\right] \quad \text{(前式乘以 $f(\mathbf{X} \mid \theta)/f(\mathbf{X} \mid \theta)$)} \\
&= \mathbb{E}\_\theta\left[W(\mathbf{X})\frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)\right] \quad \text{(对数的性质)}
\end{aligned}
$$
这暗示我们应考虑 $W(\mathbf{X})$ 与 $\frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)$ 之间的协方差，为了使它化为一个协方差，需要减去两期望值的乘积，于是我们来计算 $\mathbb{E}\_\theta\left(\frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)\right)$。假如我们在式 (7.3.7) 中特别地取 $W(x) = 1$，就得到
$$
\mathbb{E}\_\theta\left(\frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)\right) = \frac{\mathrm{d}}{\mathrm{d}\theta}\mathbb{E}\_\theta[1] = 0
$$
因此 $\text{Cov}\_\theta\left(W(\mathbf{X}), \frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)\right)$ 就等于乘积的期望，于是由式 (7.3.7) 和式 (7.3.8)，就得到
$$
\text{Cov}\_\theta\left(W(\mathbf{X}), \frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)\right) = \mathbb{E}\_\theta\left(W(\mathbf{X})\frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)\right) = \frac{\mathrm{d}}{\mathrm{d}\theta}\mathbb{E}\_\theta W(\mathbf{X})
$$
同样，因为 $\mathbb{E}\_\theta\left(\frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)\right) = 0$，我们有
$$
\text{Var}\_\theta\left(\frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)\right) = \mathbb{E}\_\theta\left(\left(\frac{\partial}{\partial\theta}\log f(\mathbf{X} \mid \theta)\right)^2\right)
$$
对式 (7.3.9) 和式 (7.3.10) — 并使用 Cauchy-Schwarz 不等式，我们就得到
$$
\text{Var}\_\theta(W(\mathbf{X})) \geq \frac{\left(\frac{\mathrm{d}}{\mathrm{d}\theta}\mathbb{E}\_\theta W(\mathbf{X})\right)^2}{\mathbb{E}\_\theta\left(\left(\frac{\partial}{\partial \theta} \log f(\mathbf{X} \mid \theta)\right)^2\right)}.
$$



**推论 i.i.d. 情形**

如果满足定理 7.3.9 的假设，并且进一步假设 $X\_1, ..., X\_n$ 是独立同分布的随机变量，其概率密度函数为 $f(x | \theta)$，那么有

$$
\operatorname{Var}\_\theta W(\mathbf{X}) \geq \frac{\left( \frac{d}{d\theta} \mathbb{E}\_\theta W(\mathbf{X}) \right)^2}{n \mathbb{E}\_\theta \left( \left( \frac{\partial}{\partial \theta} \log f(X \mid \theta) \right)^2 \right)}
$$

**例子 错误使用情形**

设 $X\_1, \ldots, X\_n$ 是独立同分布的随机变量，其概率密度函数为：
$$ f(x \mid \theta) = \frac{1}{\theta}, \quad 0 < x < \theta \quad \text{(注意：危险！)} $$
如果错误地应用克拉默-劳下界（Cramér-Rao lower bound）：

对于一个无偏估计量 $W(X)$，满足 $\operatorname{E}\_\theta[W(X)] = \theta$：
$$
\operatorname{Var}\_\theta W(X) \geq \frac{1}{n \operatorname{E}\_\theta \left( \left( \frac{\partial}{\partial \theta} \log f(X \mid \theta) \right)^2 \right)} = \frac{1}{n \cdot \frac{1}{\theta^2}} = \frac{\theta^2}{n}.
$$

现在让我们寻找一个方差更小的无偏估计量：
考虑 $Y = X\_{(n)}$（最大顺序统计量）。

$$
\operatorname{E}\_\theta(Y) = \int\_0^\theta y \frac{n y^{n-1}}{\theta^n} \, dy = \int\_0^\theta \frac{n y^n}{\theta^n} \, dy = \frac{n}{n+1} \theta \implies \operatorname{E}\_\theta \left[ \frac{n+1}{n} Y \right] = \theta.
$$

$\operatorname{E}\_\theta \left[ \frac{n+1}{n} Y \right]$ 是一个无偏估计量。
$$
\operatorname{Var} \left[ \frac{n+1}{n} Y \right] = \left( \frac{n+1}{n} \right)^2 \operatorname{Var}[Y] = \cdots = \frac{\theta^2}{n(n+2)}.
$$

然而，显然有：
$$
\operatorname{Var} \left[ \frac{n+1}{n} Y \right] = \frac{\theta^2}{n(n+2)} < \frac{\theta^2}{n} = \text{假设的克拉默-劳下界？！！}
$$

为什么克拉默-劳下界不适用于这个概率密度函数？

$$
\frac{d}{d\theta} \int\_0^\theta h(x) f(x \mid \theta) \, dx = \frac{d}{d\theta} \int\_0^\theta h(x) \frac{1}{\theta} \, dx
$$
$$
= \int\_0^\theta h(x) \frac{d}{d\theta} \left( \frac{1}{\theta} \right) \, dx + \frac{h(\theta)}{\theta}
$$
$$
= \int\_0^\theta h(x) \frac{d}{d\theta} f(x \mid \theta) \, dx + \frac{h(\theta)}{\theta}
$$
$$
\neq \int\_0^\theta h(x) \frac{d}{d\theta} f(x \mid \theta) \, dx,
$$
除非 $\frac{h(\theta)}{\theta} = 0$ 对所有 $\theta$ 成立。




**推论 达到下界**

设 $X\_1, \dots, X\_n$ 是 iid 的，具有概率密度函数 $f(x|\theta)$，其 $f(x|\theta)$ 满足 Cramér-Rao 定理的条件。令
$$ L(\theta|x) = \prod\_{i=1}^n f(x\_i|\theta) $$
表示似然函数。如果 $W(X) = W(X\_1, \dots, X\_n)$ 是 $\tau(\theta)$ 的任意一个无偏估计量，则 $W(X)$ 达到 Cramér-Rao 下界当且仅当

$$
a(\theta)[W(x) - \tau(\theta)] = \frac{\partial}{\partial\theta}\log L(\theta|x)
$$

对某一函数 $a(\theta)$ 成立。


**定理 Rao-Blackwell定理**

设 $W$ 是 $\tau(\theta)$ 的任意一个无偏估计量，而 $T$ 是关于 $\theta$ 的一个充分统计量。定义 $\phi(T) = \mathbb{E}(W \mid T)$。则 $\mathbb{E}\_\theta \phi(T) = \tau(\theta)$ 而且 $\operatorname{Var}\_\theta \phi(T) \leq \operatorname{Var}\_\theta W$ 对所有 $\theta$ 成立；即是说 $\phi(T)$ 是 $\tau(\theta)$ 的一个一致较优的无偏估计量。

**注**

    Rao-Blackwell 定理的核心思想是：通过使用充分统计量 $T$ 的信息，我们可以"过滤掉"样本中无关的噪声，从而得到一个更精确的估计量。具体来说，条件期望 $\mathbb{E}(W \mid T)$ 利用了 $T$ 所包含的全部信息，而丢弃了样本中与 $\theta$ 无关的部分，从而降低了估计量的方差。


**命题 BUE 的唯一性**

如果 $W$ 是 $\tau(\theta)$ 的一个最佳无偏估计量，则 $W$ 是唯一的.

**证明**

假如 $W'$ 是另一个最佳无偏估计量，考虑估计量 $W^* = \frac{1}{2}(W + W')$. 注意到 $\mathbb{E}\_\theta W^* = \tau(\theta)$ 并且
$$
\begin{aligned}
\operatorname{Var}\_\theta W^* &= \operatorname{Var}\_\theta \left( \frac{1}{2}W + \frac{1}{2}W' \right)  \\
&= \frac{1}{4}\operatorname{Var}\_\theta W + \frac{1}{4}\operatorname{Var}\_\theta W' + \frac{1}{2}\operatorname{Cov}\_\theta(W, W') \\
&\leq \frac{1}{4}\operatorname{Var}\_\theta W + \frac{1}{4}\operatorname{Var}\_\theta W' + \frac{1}{2}\big[\operatorname{Var}\_\theta W \cdot \operatorname{Var}\_\theta W'\big]^{1/2} \quad \text{(Cauchy-Schwarz 不等式)} \\
&= \operatorname{Var}\_\theta W \quad \text{($\operatorname{Var}\_\theta W = \operatorname{Var}\_\theta W'$)}
\end{aligned}
$$
但如果以上不等式是严格的，则与 $W$ 的最佳无偏性矛盾，所以上边式子必须对所有 $\theta$ 都是等式. 因为上边的不等式是 Cauchy-Schwarz 不等式的一个运用，所以只有在 $W' = a(\theta)W + b(\theta)$ 时才有等号成立. 现在使用协方差的性质，我们有
$$
\begin{aligned}
\operatorname{Cov}\_\theta(W, W') &= \operatorname{Cov}\_\theta\big[W, a(\theta)W + b(\theta)\big] \\
&= \operatorname{Cov}\_\theta\big[W, a(\theta)W\big] \\
&= a(\theta)\operatorname{Var}\_\theta W
\end{aligned}
$$
但是由于在式 (7.3.14) 中等号成立，从而 $\operatorname{Cov}\_\theta(W, W') = \operatorname{Var}\_\theta W$. 所以 $a(\theta) = 1$, 而且由于 $\mathbb{E}\_\theta W' = \tau(\theta)$, 因此一定有 $b(\theta) = 0$, 于是 $W = W'$, 这就证明了 $W$ 是唯一的.

**命题**

    如果 $E\_\theta W = \tau(\theta)$，那么 $W$ 是 $\tau(\theta)$ 的最佳无偏估计量当且仅当 $W$ 与所有零的无偏估计量不相关。

**定理 完全性和最佳无偏性**

设 $ T $ 是一个参数 $ \theta $ 的完全充分统计量，而 $ \phi(T) $ 是任意的一个仅基于 $ T $ 的估计量。则 $ \phi(T) $ 是其期望值的唯一最佳无偏估计量。

**定理 Lehmann-Scheffé Theorem**

    设 $ T(X) $ 是参数 $ \theta $ 的一个充分且完全统计量，$ U(X) $ 是 $ \theta $ 的一个无偏估计量。那么，基于 $ T(X) $ 构造的条件期望 $ \mathbb{E}[U(X) \mid T(X)] $ 是 $ \theta $ 的UMVUE。

    Unbiased estimators based on complete sufficient statistics are unique.


## EM算法

**定义 基本记号**

- **完整数据 (Complete Data)**:
    记为 $ x $，表示完整的数据集。
    完整数据包括观测到的数据 $ y $ 和缺失数据或隐变量 $ z $，即：
    $$
    x = (y, z)
    $$
- **观测数据 (Observed Data)**:
    记为 $ y $，表示实际观测到的数据。
- **缺失数据 (Missing Data)**:
    记为 $ z $，表示未观测到的部分（可能是隐变量或缺失值）。
- **参数**:
    记为 $ \theta $，表示需要估计的模型参数。


**定义 缺失数据机制**

    $R$ 被定义为**响应指示向量（Response Indicator Vector）**，用于描述数据是否缺失。具体定义如下：
    $ R $ 是一个向量，其每个元素 $ R\_i $ 表示第 $ i $ 个观测值是否被观测到：
    - $ R\_i = 1 $：表示第 $ i $ 个观测值 $ X\_i $ 被观测到。
    - $ R\_i = 0 $：表示第 $ i $ 个观测值 $ X\_i $ 缺失。
  那么，根据 $ R $ 的条件分布，缺失数据机制可以分为以下三类：
  - **完全随机缺失 (MCAR)**:
      缺失与数据本身无关：
      $$
      p(R | Y, Z, \xi) = p(R | \xi), \quad \text{即 } R \perp (Z, Y)
      $$

    - **随机缺失 (MAR)**:
      缺失仅与观测数据有关，与缺失数据无关：
      $$
      p(R | Y, Z, \xi) = p(R | Y, \xi), \quad \text{即 } R \perp Z | Y
      $$
    - **非随机缺失 (MNAR)**:
      缺失与缺失数据相关：
      $$
      R \not\perp Z | Y
      $$


**命题 参数独立性**

参数的独立性指的是：
- 模型中的两个参数集 $\theta$ 和 $\xi$ 是**独立的**，即它们的联合参数空间是各自参数空间的乘积。

-  数学上可以表示为：
  $$
  \Theta \times \Xi = \{(\theta, \xi) : \theta \in \Theta, \xi \in \Xi\}
  $$

其中：
- $\theta$ 是我们感兴趣的模型参数（如分布的均值、方差等）。
- $\xi$ 是与缺失数据机制相关的参数（如缺失概率模型的参数）。



**命题 The missing data mechanism is ignorable if MAR+distinctness**

假设数据的生成过程如下：
- 完整数据 $X = (Y, Z)$ 的联合分布为 $f(X | \theta)$。
- 观测数据 $Y$ 的边际分布为 $g(Y | \theta)$。
- 缺失数据机制由 $p(R | Y, Z, \xi)$ 描述。

在参数独立性条件下，联合分布可以分解为：
$$
p(R, Y | \theta, \xi) = \int p(R | Y, Z, \xi) p(Y, Z | \theta) dZ
$$
利用 MAR 假设（$R \perp Z | Y$），可以进一步简化为：
$$
p(R, Y | \theta, \xi) = p(R | Y, \xi) \int p(Y, Z | \theta) dZ
$$
由于参数独立性，$\theta$ 和 $\xi$ 的估计可以分开进行，最终的目标函数仅依赖于 $\theta$：
$$
L(\theta | Y) \propto g(Y | \theta)
$$

**命题 EM算法**

EM算法的一般步骤

EM算法（Expectation-Maximization Algorithm）是一种迭代优化方法，用于处理不完全数据的最大似然估计问题。以下是EM算法的一般步骤：
1. 初始化: 选择一个初始参数值 $ \theta^{(0)} $。
2. 迭代过程: 对于第 $ (t+1) $ 次迭代，EM算法包括以下两个步骤：
    a. E步（期望步，Expectation Step）
    在E步中，计算完整数据对数似然的期望值，给定观测数据 $ y $ 和当前参数估计 $ \theta^{(t)} $：
    $$
    Q(\theta | \theta^{(t)}) = \mathbb{E}[\log f(y, Z | \theta) | y, \theta^{(t)}]
    $$
    其中：
    - $ f(y, Z | \theta) $ 是完整数据的联合概率密度函数。
    - $ Z $ 是缺失数据或隐变量。
    - 条件分布 $ f(Z | y, \theta^{(t)}) $ 表示在观测数据 $ y $ 和当前参数估计 $ \theta^{(t)} $ 下，缺失数据 $ Z $ 的分布。
    具体计算公式为：
    $$
    Q(\theta | \theta^{(t)}) = \int (\log f(y, z | \theta)) f(z | y, \theta^{(t)}) \, dz
    $$
    b. M步（最大化步，Maximization Step）
    在M步中，最大化E步得到的目标函数 $ Q(\theta | \theta^{(t)}) $，以更新参数估计：
    $$\theta^{(t+1)} = \arg\max\_\theta Q(\theta | \theta^{(t)})$$
3. 迭代
重复执行E步和M步，直到参数估计收敛，即：
$$
\theta^{(t+1)} \approx \theta^{(t)}
$$


## 损失函数最优性

**定义 动作空间**

    考虑一个统计模型，其中观测向量 \( X \sim f(x | \theta), \theta \in \Theta \)，需要对参数 \(\theta\) 做出决策。允许的决策集合称为动作空间。

    **动作空间** \(\mathcal{A}\) 是我们能够考虑采取的一系列动作、决策或声明的集合。
    在点估计问题中，通常 \(\mathcal{A}\) 等于 \(\Theta\)。

**定义 损失函数**

    比起动作空间的选择，损失函数的选择更为重要。在目标为估计参数 \(\theta\) 的估计问题中，我们可以定义一个函数 \(L: \Theta \times \mathcal{A} \to \mathbb{R}^+\)。损失函数是一个非负函数，通常随着动作 \(a\) 与参数 \(\theta\) 之间的距离增大而增大。
    - **绝对损失函数** (Absolute Loss Function):
        $$L(\theta, a) = |a - \theta|$$
    - **平方损失函数** (Squared Loss Function):
        $$L(\theta, a) = (a - \theta)^2$$

**定义 风险函数**

    对于给定的参数 \(\theta\) 的估计量 \(\delta(X)\)，我们使用风险函数来衡量估计量的质量：
    $$
    R(\theta, \delta) = \mathbb{E}\_\theta L(\theta, \delta(X))
    $$
    在给定 \(\delta\) 的情况下，风险函数是未知参数 \(\theta\) 的函数。

### Bayes' Rule

另一种比较风险函数的主要方法是通过全局标准，而不是逐点比较。例如，贝叶斯准则。

**定义 贝叶斯风险**



 \( R(\theta, \delta) = \mathbb{E}[L(\theta, \delta(X)) | \theta] \)，即在使用估计量 \(\delta\) 且参数值为 \(\theta\) 的情况下，期望的损失。从贝叶斯的观点来看，参数 \(\theta\) 具有分布，我们可以计算随着 \(\theta\) 变化时我们平均会损失多少。

考虑一个先验分布 \(\pi(\theta)\)，我们可以利用这个先验分布来计算平均风险：
$$
\int\_\Theta R(\theta, \delta) \pi(\theta) d\theta
$$
这被称为 **贝叶斯风险** (Bayesian Risk)，它是对所有参数 \(\theta\) 的平均损失。对风险函数取平均值可以得到一个数值，用于评估估计量相对于给定损失函数的性能。

使得贝叶斯风险最小化的估计量称为 **贝叶斯规则** (Bayes Rule)，相对于先验分布 \(\pi(\theta)\)。

当 \(X \sim f(x | \theta)\) 且 \(\theta \sim \pi(\theta)\) 时，贝叶斯风险为：
$$
\int\_\Theta R(\theta, \delta) \pi(\theta) d\theta = \int\_\Theta \left( \int\_{\mathcal{X}} L(\theta, \delta(x)) f(x | \theta) dx \right) \pi(\theta) d\theta
$$

现在我们将 $f(x | \theta) \pi(\theta)$ 写成 $\pi(\theta | x) m(x)$，其中 $m(x)$ 是 $X$ 的边缘分布：
$$
\int\_\Theta R(\theta, \delta) \pi(\theta) d\theta = \int\_{\mathcal{X}} \left( \int\_\Theta L(\theta, \delta(x)) \pi(\theta | x) d\theta \right) m(x) dx
$$

$\int\_\Theta L(\theta, \delta(x)) \pi(\theta | x) d\theta$ 被称为 **后验期望损失**，它仅是 $x$ 的函数，而不是 $\theta$ 的函数。因此，对于每个 $x$，如果我们选择动作 $\delta(x)$ 来最小化后验期望损失，那么我们将最小化贝叶斯风险。

**例子 Two Bayes rules**

Consider a point estimation problem for a real-valued parameter $\theta$.

1. For squared error loss, the posterior expected loss is
    $$
        \int\_{\Theta} (\theta - a)^2 \pi(\theta \mid x) d\theta = \mathbb{E}[(\theta - a)^2 \mid X = x]
    $$
    The expected value is minimized by $\delta^\pi(x) = \mathbb{E}(\theta \mid x)$.

    2. For absolute error loss, the posterior expected loss is
    $$
        \int\_{\Theta} |\theta - a| \pi(\theta \mid x) d\theta = \mathbb{E}[|\theta - a| \mid X = x]
    $$
    The expected value is minimized by $\delta^\pi(x) = \text{median of } \pi(\theta \mid x)$.


### Minimax Rule

**定义 最小最大规则 minimax rule**

    另一种全局标准是比较风险函数时考虑最坏情况。

    估计量（或过程、决策规则）的最坏可能风险由 $\sup\_\theta R(\theta, \delta)$ 给出。
    使用 $\sup\_\theta R(\theta, \delta)$ 作为比较两个估计量 $\delta$ 和 $\delta'$ 的标准，我们偏好 $\delta$ 而非 $\delta'$，当且仅当：
    $$
    \sup\_\theta R(\theta, \delta) < \sup\_\theta R(\theta, \delta').
    $$

    令 $\mathfrak{D}$ 表示所有待考虑的决策过程集合，具有以下性质的程序 $\delta^*$：
    $$
    \sup\_\theta R(\theta, \delta^*) = \inf\_{\delta \in \mathfrak{D}} \sup\_\theta R(\theta, \delta)
    $$
    被称为 **最小最大规则**（最小化最大风险）。

    这一最优性准则非常保守，旨在最大程度地保护免受最坏情况的发生。
