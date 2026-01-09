---
layout: post
title: "Statistical Inference 概率论基础"
permalink: /posts/statistical-inference-probability/
tags: statistical-inference
use\_math: true
---



# 概率论基础

## 独立随机变量



**定义 独立随机变量**

设 $\mathbf{X}\_1, \ldots, \mathbf{X}\_n$ 为一列随机向量，其联合概率密度（或质量）函数为 $f(\mathbf{x}\_1, \ldots, \mathbf{x}\_n)$，$\mathbf{X}\_i$ 的边缘概率密度（或质量）函数为 $f\_{\mathbf{X}\_i}(\mathbf{x}\_i)$。如果对任意 $(\mathbf{x}\_1, \ldots, \mathbf{x}\_n)$，都有
$$
f(\mathbf{x}\_1, \ldots, \mathbf{x}\_n) = f\_{\mathbf{X}\_1}(\mathbf{x}\_1) \cdot \ldots \cdot f\_{\mathbf{X}\_n}(\mathbf{x}\_n) = \prod\_{i=1}^{n} f\_{\mathbf{X}\_i}(\mathbf{x}\_i)
$$
则称 $\mathbf{X}\_1, \ldots, \mathbf{X}\_n$ 是相互独立的随机向量（mutually independent vectors）。如果每个 $\mathbf{X}\_i$ 都是一维的，则称 $\mathbf{X}\_1, \ldots, \mathbf{X}\_n$ 是相互独立的随机变量（mutually independent variables）。

**命题**

设 $\mathbf{X}\_1, \ldots, \mathbf{X}\_n$ 是一列随机向量，则 $\mathbf{X}\_1, \ldots, \mathbf{X}\_n$ 相互独立当且仅当存在函数 $g\_i(\mathbf{x}\_i)$，$i=1, \ldots, n$，使得 $(\mathbf{X}\_1, \ldots, \mathbf{X}\_n)$ 的联合概率密度（或质量）函数可以写为：
$$
f(\mathbf{x}\_1, \ldots, \mathbf{x}\_n) = g\_1(\mathbf{x}\_1) \cdot \ldots \cdot g\_n(\mathbf{x}\_n)
$$

**命题**

设 $\mathbf{X}\_1, \ldots, \mathbf{X}\_n$ 是一列相互独立的随机向量，$g\_i(\mathbf{x}\_i)$ 是 $\mathbf{x}\_i$ 的一元函数，$i=1, \ldots, n$。则随机变量 $U\_i = g\_i(\mathbf{X}\_i)$，$i=1, \ldots, n$ 相互独立。


## Distributions

**定理 概率分布的变量变换公式**

设 $X$ 是一个连续型随机变量，其概率密度函数 (PDF) 为 $f\_X(x)$。
设 $Y = g(X)$，其中函数 $g(x)$ 在 $X$ 的取值范围内是严格单调（即严格递增或严格递减）且可导的。
假设 $g(x)$ 的反函数为 $x = h(y)$（即 $h(y) = g^{-1}(y)$）。

则随机变量 $Y$ 的概率密度函数 $f\_Y(y)$ 为：
$$f\_Y(y) = f\_X(h(y)) \left| \frac{d}{dy} h(y) \right|$$
或者，更详细地表示为：
$$f\_Y(y) = f\_X(g^{-1}(y)) \left| \frac{d}{dy} g^{-1}(y) \right|$$
其中， $y$ 的取值范围是 $X$ 的取值范围通过函数 $g(x)$ 映射后得到的范围。

**例子 Gamma Distribution**

Gamma分布表示为：
$$
\text{Gamma}(\alpha, \beta)
$$

Gamma分布的概率密度函数（PDF）定义为：
$$
P(X = x \mid \alpha, \beta) = \frac{1}{\Gamma(\alpha)\beta^{\alpha}} x^{\alpha-1} e^{-x/\beta}, \quad 0 \leq x < \infty
$$

其中：
- $x$ 是随机变量（$x \geq 0$），
- $\alpha$ 是**形状参数**（$\alpha > 0$），
- $\beta$ 是**尺度参数**（$\beta > 0$），
- $\Gamma(\alpha)$ 是**Gamma函数**，定义为：
  $$
  \Gamma(\alpha) = \int\_0^\infty t^{\alpha-1} e^{-t} \, dt
  $$

**均值与方差：**
$$
\text{均值: } \mathbb{E}[X] = \alpha \beta
$$
$$
\text{方差: } \operatorname{Var}(X) = \alpha \beta^2
$$

**矩生成函数（MGF）：**
Gamma分布的矩生成函数（MGF）为：
$$
M\_X(t) = \left( \frac{1}{1 - \beta t} \right)^\alpha, \quad t < \frac{1}{\beta}
$$

**Gamma函数的性质：**
Gamma函数 $\Gamma(\alpha)$ 具有以下性质：
1. 对于 $\alpha > 0$，有 $\Gamma(\alpha+1) = \alpha \Gamma(\alpha)$。
2. 对于任意正整数 $n > 0$，有 $\Gamma(n) = (n-1)!$。


**例子 Normal Distribution**

正态分布表示为：
$$
\mathcal{N}(\mu, \sigma^2)
$$

正态分布的概率密度函数（PDF）定义为：
$$
f(x \mid \mu, \sigma^2) = \frac{1}{\sqrt{2\pi \sigma^2}} \exp\left(-\frac{(x - \mu)^2}{2\sigma^2}\right), \quad -\infty < x < \infty
$$

其中：
- $x$ 是随机变量，
- $\mu$ 是**均值**（决定分布的中心位置），
- $\sigma^2$ 是**方差**（决定分布的宽度，$\sigma > 0$）。

**性质：**
1. 正态分布是对称的，其峰值位于 $\mu$。
2. 标准正态分布是正态分布的一种特殊情况，记作 $\mathcal{N}(0, 1)$，即 $\mu = 0$ 且 $\sigma^2 = 1$。
3. 如果 $X \sim \mathcal{N}(\mu, \sigma^2)$，则标准化后的随机变量 $Z = \frac{X - \mu}{\sigma}$ 服从标准正态分布 $\mathcal{N}(0, 1)$。

**均值与方差：**
$$
\text{均值: } \mathbb{E}[X] = \mu
$$
$$
\text{方差: } \operatorname{Var}(X) = \sigma^2
$$

**矩生成函数（MGF）：**
正态分布的矩生成函数（MGF）为：
$$
M\_X(t) = \exp\left(\mu t + \frac{\sigma^2 t^2}{2}\right), \quad t \in \mathbb{R}
$$



**例子 Beta 分布**

Beta分布是一种定义在区间 $[0, 1]$ 上的连续概率分布，通常用于建模随机变量在有限区间内的行为。Beta分布的概率密度函数（PDF）定义为：

$$
P(X = x \mid \alpha, \beta) = \frac{1}{B(\alpha, \beta)} x^{\alpha-1} (1-x)^{\beta-1}, \quad 0 \leq x \leq 1
$$

其中：
- $x$ 是随机变量（$0 \leq x \leq 1$），
- $\alpha$ 是**形状参数**（$\alpha > 0$），
- $\beta$ 是**形状参数**（$\beta > 0$），
- $B(\alpha, \beta)$ 是**Beta函数**，定义为：
  $$
  B(\alpha, \beta) = \int\_0^1 t^{\alpha-1} (1-t)^{\beta-1} \, dt
  $$

Beta函数 $B(\alpha, \beta)$ 可以通过Gamma函数表示为：
$$
B(\alpha, \beta) = \frac{\Gamma(\alpha) \Gamma(\beta)}{\Gamma(\alpha + \beta)}
$$


**均值与方差**

Beta分布的均值和方差分别为：
$$
\text{均值: } \mathbb{E}[X] = \frac{\alpha}{\alpha + \beta}
$$
$$
\text{方差: } \operatorname{Var}(X) = \frac{\alpha \beta}{(\alpha + \beta)^2 (\alpha + \beta + 1)}
$$

**矩生成函数（MGF）**

Beta分布的矩生成函数（MGF）没有闭式表达式，但可以通过其定义直接计算各阶矩。

**Beta函数的性质**

Beta函数 $B(\alpha, \beta)$ 具有以下性质：
1. 对称性：$B(\alpha, \beta) = B(\beta, \alpha)$。
2. 与Gamma函数的关系：$B(\alpha, \beta) = \frac{\Gamma(\alpha) \Gamma(\beta)}{\Gamma(\alpha + \beta)}$。
3. 特殊情况：当 $\alpha = \beta = 1$ 时，$B(1, 1) = 1$，此时Beta分布退化为均匀分布 $U(0, 1)$。

**Beta分布的应用**

Beta分布广泛应用于以下领域：
- **贝叶斯统计**：作为二项分布或伯努利分布的共轭先验。
- **概率建模**：用于描述概率、比例等取值范围在 $[0, 1]$ 的随机变量。
- **机器学习**：在变分推断和生成模型中常用作隐变量的先验分布。


**特殊情形**

1. 当 $\alpha = \beta = 1$，Beta分布退化为均匀分布 $U(0, 1)$，即：
   $$
   P(X = x \mid 1, 1) = 1, \quad 0 \leq x \leq 1
   $$

2. 当 $\alpha, \beta > 1$ 时，Beta分布呈现单峰形状；当 $\alpha, \beta < 1$ 时，Beta分布呈现U形。

3. 当 $\alpha = \beta$ 时，Beta分布在 $[0, 1]$ 区间上对称。


通过上述定义和性质，我们可以看到Beta分布是一个极其灵活的概率分布，能够适应多种实际应用场景。

**例子 指数分布**

指数分布是一种连续概率分布，常用于描述事件之间的时间间隔，例如在泊松过程中两次事件发生的时间间隔。

指数分布表示为：
$$
\text{Exp}(\lambda)
$$

其中：
- $\lambda > 0$ 是**率参数**（rate parameter），表示单位时间内事件发生的平均次数。
- 指数分布的概率密度函数（PDF）定义为：
  $$
  f(x \mid \lambda) =
  \begincases}
  \lambda e^{-\lambda x}, & x \geq 0, \\
  0, & x < 0.
  \end{cases}
  $$

或者等价地用累积分布函数（CDF）表示为：
$$
F(x \mid \lambda) =
\begin{cases}
1 - e^{-\lambda x}, & x \geq 0, \\
0, & x < 0.
\end{cases}
$$

性质
1. 无记忆性（Memoryless Property）：
指数分布是唯一具有无记忆性的连续分布。对于任意 $s, t \geq 0$，满足：
$$
P(X > s + t \mid X > s) = P(X > t).
$$
这一性质表明，过去的时间不会影响未来事件发生的概率。

2. **与泊松分布的关系：**
如果事件的发生服从泊松过程，则时间间隔服从指数分布。具体来说，若单位时间内事件发生的次数服从泊松分布 $\text{Pois}(\lambda)$，则事件之间的时间间隔服从 $\text{Exp}(\lambda)$。

均值与方差
$$
\text{均值: } \mathbb{E}[X] = \frac{1}{\lambda}
$$
$$
\text{方差: } \operatorname{Var}(X) = \frac{1}{\lambda^2}
$$

矩生成函数 (MGF)
指数分布的矩生成函数（MGF）为：
$$
M\_X(t) = \frac{\lambda}{\lambda - t}, \quad t < \lambda
$$
注意，MGF 在 $t \geq \lambda$ 时未定义。

**标准形式**
当 $\lambda = 1$ 时，分布称为**标准指数分布**，其 PDF 为：
$$
f(x) = e^{-x}, \quad x \geq 0.
$$



**例子 Poisson 分布**

泊松分布是一种离散概率分布，用于描述在固定时间或空间内某事件发生的次数。它常用于建模稀疏事件的发生频率，例如单位时间内电话呼叫次数、放射性粒子衰变次数等。

泊松分布表示为：
$$
\text{Poisson}(\lambda)
$$

其中：
- $\lambda > 0$ 是**事件发生率**（rate parameter），表示在给定时间或空间内事件的平均发生次数。
- 泊松分布的概率质量函数（PMF）定义为：
  $$
  P(X = k \mid \lambda) = \frac{\lambda^k e^{-\lambda}}{k!}, \quad k = 0, 1, 2, \ldots
  $$

**性质**
1. **非负性：**
泊松分布仅适用于非负整数 $k$，即 $k \in \{0, 1, 2, \ldots\}$。

2. **均值与方差相等：**
泊松分布的均值和方差都等于参数 $\lambda$。

3. **可加性：**
如果 $X\_1 \sim \text{Pois}(\lambda\_1)$ 和 $X\_2 \sim \text{Pois}(\lambda\_2)$ 是独立的泊松随机变量，则其和 $X\_1 + X\_2$ 也服从泊松分布，且参数为 $\lambda\_1 + \lambda\_2$。

4. **与指数分布的关系：**
如果事件发生的时间间隔服从指数分布 $\text{Exp}(\lambda)$，则在固定时间内的事件发生次数服从泊松分布 $\text{Pois}(\lambda)$。

**均值与方差**
$$
\text{均值: } \mathbb{E}[X] = \lambda
$$
$$
\text{方差: } \operatorname{Var}(X) = \lambda
$$

**矩生成函数（MGF）**

泊松分布的矩生成函数（MGF）为：
$$
M\_X(t) = \exp\left(\lambda (e^t - 1)\right), \quad t \in \mathbb{R}
$$




**例子 卡方分布**

卡方分布（Chi-Squared Distribution）是统计学中一种重要的连续型概率分布。

**定义**

设 $ Z\_1, Z\_2, \dots, Z\_k $ 是独立的标准正态随机变量，则其平方和：

$$
X = Z\_1^2 + Z\_2^2 + \cdots + Z\_k^2
$$

服从自由度为 $ k $ 的卡方分布，记作：

$$
X \sim \chi^2(k)
$$

**概率密度函数**

$$
f(x; k) =
\begin{cases}
\displaystyle \frac{1}{2^{k/2} \Gamma(k/2)} x^{k/2 - 1} e^{-x/2}, & x > 0 \\
0, & \text{其他}
\end{cases}
$$

**数学期望与方差**

$$
\mathbb{E}[X] = k,\quad \operatorname{Var}(X) = 2k
$$

**主要性质**
- 可加性：若 $ X\_1 \sim \chi^2(k\_1) $，$ X\_2 \sim \chi^2(k\_2) $，独立，则
    $$
    X\_1 + X\_2 \sim \chi^2(k\_1 + k\_2)
    $$

- 是伽马分布的特例：$\chi^2(k) \equiv \Gamma\left( \frac{k}{2}, 2 \right)$




**例子 t 分布**

Student's t 分布是统计学中常用的一种连续型概率分布，特别适用于小样本情况下的统计推断。

**定义**

设 $ Z \sim \mathcal{N}(0,1) $，$ V \sim \chi^2(k) $，且相互独立，则：

$$
T = \frac{Z}{\sqrt{V / k}} \sim t(k)
$$

称为自由度为 $ k $ 的 Student's t 分布。

**概率密度函数**

其概率密度函数为：

$$
f(t; k) = \frac{\Gamma\left(\frac{k+1}{2}\right)}{\sqrt{k\pi} \, \Gamma\left(\frac{k}{2}\right)} \left(1 + \frac{t^2}{k} \right)^{-\frac{k+1}{2}}
$$

**数学期望与方差**

若 $ T \sim t(k) $，则：

$$
\mathbb{E}[T] =
\begin{cases}
0, & k > 1 \\
\text{不存在}, & k \leq 1
\end{cases},
\quad
\operatorname{Var}(T) =
\begin{cases}
\displaystyle \frac{k}{k - 2}, & k > 2 \\
\text{不存在}, & k \leq 2
\end{cases}
$$

**主要性质**
- 关于 0 对称；
- 当 $ k \to \infty $，$ t(k) \to \mathcal{N}(0,1) $；
- 尾部比正态分布更厚。

**应用**
- 单样本 t 检验
- 独立两样本 t 检验
- 配对样本 t 检验
- 均值的置信区间估计


## 指数族 (exponential family)

**定义 指数组 (exponential family)**

一组概率密度函数（pdfs）或概率质量函数（pmfs）被称为指数族，如果它可以表示为

$$f(x \mid \boldsymbol{\theta}) = h(x) c(\boldsymbol{\theta}) \exp\left( \sum\_{i=1}^{k} w\_i(\boldsymbol{\theta}) t\_i(x) \right) $$

- $\boldsymbol{\theta}$ : 参数
- $h(x) \geq 0$ 和 $t\_1(x), \ldots, t\_k(x)$ 是 $x$ 的实值函数（不能依赖于 $\boldsymbol{\theta}$!）；$h(x)$ 可以包含支持/样本空间的指示器。
- $c(\boldsymbol{\theta}) \geq 0$ 和 $w\_1(\boldsymbol{\theta}), \ldots, w\_k(\boldsymbol{\theta})$ 是 $\boldsymbol{\theta}$ 的实值函数（不能依赖于 $x$!）
- 如果样本空间是 $\boldsymbol{\theta}$ 的函数，则它不能表示为指数族。例如，$f(x \mid \theta) = \theta^{-1} \exp(1 - (x/\theta))$，$0 < \theta < x < \infty$
- 许多常见的分布族是指数族，如正态、伽玛、贝塔、二项、泊松和负二项分布...
- 对于指数族，我们可以交换积分 $\int$ 和偏导数 $\frac{d}{d\theta}$ 的顺序！


**定义 curved exponential family, full exponential family**

A **curved exponential family** is a family of densities of the form (3.4.1) (i.e., exponential family) for which the dimension of the vector $\theta$ is equal to $d < k$. If $d = k$, the family is a **full exponential family**.

**命题 reparametrization**

An exponential family is sometimes reparameterized as

$$
f(x | \eta) = h(x) c^*(\eta) \exp\left( \sum\_{i=1}^k \eta\_i t\_i(x) \right)
$$

- The set $\mathcal{H} = \{\eta = (\eta\_1, \ldots, \eta\_k) : \int\_{-\infty}^\infty h(x) \exp\left( \sum\_{i=1}^k \eta\_i t\_i(x) \right) dx < \infty\}$ is called the **natural parameter space** for the family.
-  $c^*(\eta) = \left[ \int\_{-\infty}^\infty h(x) \exp\left( \sum\_{i=1}^k \eta\_i t\_i(x) \right) dx \right]^{-1}$
-  $\{\eta = (w\_1(\theta), \ldots, w\_k(\theta)) : \theta \in \Theta\} \in \mathcal{H}$


## Delta Method

**定理 $\Delta$ 方法**

设随机变量序列 $Y\_n$ 满足：$\sqrt{n}(Y\_n - \theta)$ 依分布收敛于 $\mathcal{N}(0, \sigma^2)$，函数 $g$ 在指定的 $\theta$ 处满足：$g'(\theta)$ 存在且不为零，则
    $$
    \sqrt{n}[g(Y\_n) - g(\theta)] \xrightarrow{\text{d}} \mathcal{N}(0, \sigma^2 [g'(\theta)]^2)
    $$

**证明**

使用 Taylor 展开.

**定理 二阶 $\Delta$ 方法**

设随机变量序列 $Y\_n$ 满足：$\sqrt{n}(Y\_n - \theta)$ 依分布收敛于 $\mathcal{N}(0, \sigma^2)$，函数 $g$ 在指定的 $\theta$ 处满足 $g'(\theta) = 0$、$g''(\theta)$ 存在且不为零，则
$$
n[g(Y\_n) - g(\theta)] \xrightarrow{\text{d}} \frac{\sigma^2 g''(\theta)}{2} \chi\_1^2
$$



**定理 多元 $\Delta$ 方法**

设随机样本 $\mathbf{X}\_1, \ldots, \mathbf{X}\_n$ 满足：$\mathbb{E}(\mathbf{X}\_{ij}) = \mu\_i$ 且 $\operatorname{Cov}(\mathbf{X}\_{ik}, \mathbf{X}\_{jk}) = \sigma\_{ij}$。函数 $g$ 有连续一阶偏导，且在指定的 $\boldsymbol{\mu} = (\mu\_1, \ldots, \mu\_p)$ 处满足：
$$
\tau^2 = \sum\_{i=1}^{p} \sum\_{j=1}^{p} \sigma\_{ij} \frac{\partial g(\boldsymbol{\mu})}{\partial \mu\_i} \cdot \frac{\partial g(\boldsymbol{\mu})}{\partial \mu\_j} > 0,
$$
则
$$
\sqrt{n}[g(\overline{\mathbf{X}}\_1, \ldots, \overline{\mathbf{X}}\_p) - g(\mu\_1, \ldots, \mu\_p)] \xrightarrow{\text{d}} \mathcal{N}(0, \tau^2)
$$

## Order Statistics

**定理 次序统计量的概率密度函数**

设随机样本 $X\_1, \ldots, X\_n$ 取自累积分布函数为 $F\_X(x)$、概率密度函数为 $f\_X(x)$ 的连续型总体，$X\_{(1)}, \ldots, X\_{(n)}$ 为其次序统计量，则 $X\_{(j)}$ 的概率密度函数为
$$
f\_{X\_{(j)}}(x) = \frac{n!}{(j-1)!(n-j)!} f\_X(x) [F\_X(x)]^{j-1} [1 - F\_X(x)]^{n-j}
$$


**定理 次序统计量的联合概率密度函数**

Let $X\_{(1)}, \ldots, X\_{(n)}$ denote the order statistics of a random sample, $X\_1, \ldots, X\_n$, from a continuous population with cdf $F\_X(x)$ and pdf $f\_X(x)$. Then the joint pdf of $X\_{(i)}$ and $X\_{(j)}$, $1\le i < j \le n$, is
$$f\_{X\_{(i)}, X\_{(j)}} = \frac{n!}{(i-1)! (j-1-i)!(n-j)!} f\_X(u) f\_X(v) [F\_X(u)]^{i-1}  [F\_X(v)-F\_X(u)]^{j-1-i}  [1-F\_X(v)]^{n-j}$$

$$
f\_{X\_{(1)}, \ldots, X\_{(n)}}(x\_1, \ldots, x\_n) =
\begin{cases}
n! \cdot f\_X(x\_1) \cdot \ldots \cdot f\_X(x\_n) & -\infty < x\_1 < \ldots < x\_n < +\infty \\
0 & \text{其他}
\end{cases}
$$


## 正态分布的抽样

**定义 样本均值和样本方差**

$$\overline{X} = \frac{1}{n} \sum\_{i=1}^n X\_i, \quad S^2 = \frac{1}{n-1} \sum\_{i=1}^n (X\_i - \overline{X})^2$$



**定理 样本均值和样本方差的分布**

设随机样本 $X\_1, \dots, X\_n$ 取自服从 $\mathcal{N}(\mu, \sigma^2)$ 分布的总体，$\overline{X} = \frac{1}{n} \sum\_{i=1}^n X\_i$ 且 $S^2 = \frac{1}{n-1} \sum\_{i=1}^n (X\_i - \overline{X})^2$，则

a. $\overline{X}$ 和 $S^2$ 是独立随机变量；
b. $\overline{X}$ 服从 $\mathcal{N}(\mu, \sigma^2/n)$ 分布；
c. $(n-1)S^2/\sigma^2$ 服从自由度为 $n-1$ 的 $\chi^2$ 分布

**证明** 根据 3.5 节关于位置-尺度族的讨论，不失一般性，我们可以假定 $\mu = 0$ 且 $\sigma = 1$（也可参考定理 5.2.11 前面的讨论）. 此外，注意到例 5.2.8 中已经证明了 (b)，所以此处只需要证明 (a) 和 (c).

为证明 (a)，只需证明 $\overline{X}$ 和 $S^2$ 是独立随机向量的函数. 我们可以将 $S^2$ 写成 $n-1$ 个离差的函数，事实上我们有：
$$
\begin{aligned}
S^2 &= \frac{1}{n-1} \sum\_{i=1}^n (X\_i - \overline{X})^2 \\
&= \frac{1}{n-1} \left( (X\_1 - \overline{X})^2 + \sum\_{i=2}^n (X\_i - \overline{X})^2 \right) \\
&= \frac{1}{n-1} \left( \left[ \sum\_{i=2}^n (X\_i - \overline{X}) \right]^2 + \sum\_{i=2}^n (X\_i - \overline{X})^2 \right) \quad (\text{因为 } \sum\_{i=1}^n (X\_i - \overline{X}) = 0)
\end{aligned}
$$
即，$S^2$ 仅仅是 $(X\_2 - \overline{X}, \dots, X\_n - \overline{X})$ 的函数. 下面我们证明 $(X\_2 - \overline{X}, \dots, X\_n - \overline{X})$ 与 $\overline{X}$ 独立. 随机样本 $X\_1, \dots, X\_n$ 的联合概率密度函数为
$$
f(x\_1, \dots, x\_n) = \frac{1}{(2\pi)^{n/2}} e^{-(1/2) \sum\_{i=1}^n x\_i^2}, \quad -\infty < x\_i < +\infty
$$
做变量替换
$$
\begin{aligned}
y\_1 &= \overline{x}, \\
y\_2 &= x\_2 - \overline{x}, \\
&\vdots \\
y\_n &= x\_n - \overline{x}.
\end{aligned}
$$
该变换的 Jacobi 行列式等于 $1/n$. 于是
$$
\begin{aligned}
f(y\_1, \dots, y\_n) &= \frac{n}{(2\pi)^{n/2}} e^{-(1/2)(y\_1 - \sum\_{i=2}^n y\_i)^2} e^{-(1/2) \sum\_{i=2}^n (y\_i + y\_1)^2}, \quad -\infty < y\_i < +\infty \\
&= \left[ \left( \frac{n}{2\pi} \right)^{1/2} e^{(-ny\_1^2)/2} \right] \left[ \frac{n^{1/2}}{(2\pi)^{(n-1)/2}} e^{-(1/2) \left[ \sum\_{i=2}^n y\_i^2 + (\sum\_{i=2}^n y\_i)^2 \right]} \right], \quad -\infty < y\_i < +\infty
\end{aligned}
$$
根据定理 4.6.11 以及 $Y\_1, \dots, Y\_n$ 的联合概率密度函数的上述分解可知，$Y\_1$ 与 $Y\_2, \dots, Y\_n$ 独立. 再由定理 4.6.12，$\overline{X}$ 与 $S^2$ 独立.

为证明 (c) 我们必须求出 $S^2$ 的分布. 在开始证明之前，我们首先讨论 $\chi^2$ 分布的性质，这对我们推导 $S^2$ 的分布很有帮助. 回忆 3.3 节，我们知道 $\chi^2$ 概率密度函数是伽玛概率密度函数的特例，其表达式为

$$
f(x) = \frac{1}{\Gamma(p/2)} e^{p/2} x^{(p/2)-1} e^{-x/2}, \quad 0 < x < +\infty
$$
其中 $p$ 称为自由度. 下面列出即将用到的有关 $\chi^2$ 分布的一些事实.

**引理 关于 $\chi^2$ 随机变量的若干事实**

以 $\chi\_p^2$ 记自由度为 $p$ 的 $\chi^2$ 随机变量.
a.  如果 $Z$ 是 $\mathcal{N}(0, 1)$ 随机变量，则 $Z^2 \sim \chi\_1^2$，即标准正态随机变量的平方是 $\chi^2$ 随机变量；

b. 如果 $X\_1, \dots, X\_n$ 独立且 $X\_i \sim \chi\_{p\_i}^2$，则 $X\_1 + \cdots + X\_n \sim \chi\_{p\_1 + \cdots + p\_n}^2$，即独立的 $\chi^2$ 随机变量之和仍为 $\chi^2$ 随机变量，且其自由度为原随机变量自由度之和.



**证明**

下面我们归纳地求 $S^2$ 的分布. 以 $\overline{X}\_k$ 和 $S\_k^2$ 分别记前 $k$ 个观测值的样本均值和方差（注意各个观测值可能原本是无序的，此处将它们看成有序的原因，仅仅是为了方便证明）. 我们很容易证明（见习题 5.15）：
$$
\begin{equation}
(n-1) S\_n^2 = (n-2) S\_{n-1}^2 + \left(\frac{n-1}{n}\right)(X\_n - \overline{X}\_{n-1})^2 \tag{5.3.1}
\end{equation}
$$
现在令 $n=2$，并定义 $0 \times S\_1^2 = 0$，则由式 (5.3.1) 有：
$$
S\_2^2 = \frac{1}{2}(X\_2 - X\_1)^2
$$
由于 $(X\_2 - X\_1)/\sqrt{2}$ 服从 $\mathcal{N}(0, 1)$ 分布，于是根据引理 5.3.2 有 $S\_2^2 \sim \chi\_1^2$. 利用归纳法，假设当 $n=k$ 时有 $(k-1)S\_k^2 \sim \chi\_{k-1}^2$，则对 $n=k+1$，根据式 (5.3.1) 有：
$$
\begin{equation}
k S\_{k+1}^2 = (k-1) S\_k^2 + \left(\frac{k}{k+1}\right)(X\_{k+1} - \overline{X}\_k)^2 \tag{5.3.2}
\end{equation}
$$
根据归纳假设 $(k-1)S\_k^2 \sim \chi\_{k-1}^2$，如果我们能够证明 $(k/(k+1))(X\_{k+1} - \overline{X}\_k)^2 \sim \chi\_1^2$ 且与 $S\_k^2$ 独立，则由引理 5.3.2(b) 可得 $kS\_{k+1}^2 \sim \chi\_k^2$，从而定理得证.

$(X\_{k+1} - \overline{X}\_k)^2$ 与 $S\_k^2$ 的独立性仍可利用定理 4.6.12 加以证明. 事实上，向量 $(X\_{k+1}, \overline{X}\_k)$ 与 $S\_k^2$ 独立，故任意其函数均与 $S\_k^2$ 独立. 此外，注意到 $X\_{k+1} - \overline{X}\_k$ 是正态随机变量，且其期望为 0，方差为
$$
\operatorname{Var}(X\_{k+1} - \overline{X}\_k) = \frac{k+1}{k}
$$
因此 $(k/(k+1))(X\_{k+1} - \overline{X}\_k)^2 \sim \chi\_1^2$，定理得证.


 通过分解联合概率密度函数证明了 $\overline{X}$ 和 $S^2$ 的独立性，事实上，我们还可以利用下面的引理完成该证明. 这个引理将正态随机样本的独立性与相关联在一起.
