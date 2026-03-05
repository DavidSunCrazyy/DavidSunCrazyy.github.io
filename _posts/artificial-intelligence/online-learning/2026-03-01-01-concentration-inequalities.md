---
layout: post
title: "Online Learning 集中不等式"
permalink: /posts/ai/online-learning/concentration-inequalities/
tags: online-learning
use_math: true
---

这篇文章系统性地介绍了**集中不等式**，这是在线学习与强化学习中量化探索阶段不确定性的核心数学工具。文章以**动态定价**中的“探索后承诺”策略为例，指出需要建立估计误差的置信区间，这引出了对独立随机变量和（如伯努利变量之和）偏离其期望的概率上界的研究。文章首先回顾了**中心极限定理**及其带误差界的**贝里-埃森定理**，指出其在尾部概率估计上的局限性。随后重点转向更精确的**尾部（切尔诺夫）界限**，通过矩生成函数方法，推导出比基于方差（切比雪夫）或更高阶矩的方法更紧的概率上界，并给出了经典的**切尔诺夫不等式**、**霍夫丁不等式**和**伯恩斯坦不等式**的具体形式及其比较，阐明了在不同应用场景（如变量有界、方差已知等）下如何选择最合适的集中不等式来为在线决策算法提供理论保证。

# 集中不等式

##### 问题背景

双价格动态定价：$p \in \{\alpha, \beta\}$。$$d = D(p) + \varepsilon \to \text{独立波动}$$

##### 简单策略：探索后承诺（ETC）

1.  以 $p = \alpha$ 定价 $m$ 个周期，观察需求 $d_1, \dots, d_m$

2.  以 $p = \beta$ 定价 $m$ 个周期，观察需求 $d_{m+1}, \dots, d_{2m}$

3. 估计 $\widehat{D}(\alpha) = \frac{1}{m}(d_1 + \dots + d_m)$，$\widehat{D}(\beta) = \frac{1}{m}(d_{m+1} + \dots + d_{2m})$

4.  在剩余的$(T - 2m)$个时段内，承诺采用价格$\arg\max_{p \in \{\alpha, \beta\}} \widehat{D}(p)$

##### 问题

如何确定$m$？需平衡探索阶段（步骤1&2）与开发阶段（步骤4）的关系。

通常需要建立置信区间（长度）、置信水平与$m$之间的定量关系：
$$\operatorname{Prb}\left[ |D(\alpha) - \widehat{D}(\alpha)| \leq \tau \right] \geq 1 - \Delta$$
其中
-   $\tau$ 为置信区间半径，

-   $1- \Delta$ 为置信水平，

##### 备注

若 $\varepsilon_t \sim \mathcal{N}(0,1)$，则 $\widehat{D}(\alpha) \sim \mathcal{N}(D(\alpha), \frac{1}{m})$。$\tau$ 与 $\Delta$ 的关系易于推导。一般情况下需借助集中不等式。

##### 模型设定

设 $X_1, X_2, \dots, X_m$ 为独立同分布随机变量。为简化，进一步假设 $X_i \in \{0,1\}$。$\operatorname{Prb}[X_i=1] = q$，$\operatorname{Prb}[X_i=0] = 1-q$（伯努利随机变量）。

设 $S_m = X_1 + \dots + X_m$：需理解其性质。

-   $\mathbb{E}[S_m] = m \cdot q$（期望的线性性）

-   $\mathrm{Var}[S_m] = \sum_{i=1}^{m} \mathrm{Var}[X_i] = m \cdot q(1-q)$，故 $\mathrm{Stdev}[S_m] = \sqrt{m q (1-q)}$

考虑线性变换： $$Z_m = \frac{S_m - \mathbb{E}[S_m]}{\mathrm{Stdev}[S_m]} = \frac{S_m - mq}{\sqrt{mq(1-q)}}$$ 此时 $\mathbb{E}[Z_m] = 0$（无偏）且 $\mathrm{Var}[Z_m] = 1$。

##### 回顾：中心极限定理

对于任意 $X_1, X_2, \dots$（独立同分布，取值不限于0/1），有 $$Z_n \to Z = \mathcal{N}(0,1)$$ 满足：$\forall u \in \mathbb{R}, \quad \operatorname{Prb}[Z_n \leq u] \xrightarrow{m \to \infty} \operatorname{Prb}[Z \leq u]$

##### 备注

实际应用价值有限。未提供收敛速率信息。

##### 贝里-埃森定理（带误差界限的中心极限定理）

设 $X_1, X_2, \dots, X_m$ 为相互独立的随机变量。

设 $\mathbb{E}X_i = 0$，$\mathrm{Var}[X_i] = \mathbb{E}X_i^2 = \sigma_i^2$，且 $\sum_{i=1}^{m} \sigma_i^2 = 1$（不妨设）

令 $S = X_1 + \dots + X_m$（故 $\mathbb{E}S = 0$，$\mathrm{Var}[S] = 1$）

则对于任意实数 $u$，有 $$\left\| \operatorname{Prb}[S \leq u] - \operatorname{Prb}_{Z \sim \mathcal{N}(0,1)} [Z \leq u] \right\| \leq O(1) \cdot \beta$$ 其中 $\beta = \sum_{i=1}^{m} \mathbb{E}\left[\|X_i\|^3\right]$，$O(1) \approx 0.5514$ 由 \[Shevtsoua' 2013\] 给出

##### 示例

$m$ 次抛硬币，$X_i = \begin{cases} +\frac{1}{\sqrt{m}} & \text{概率 } \frac{1}{2} \\ -\frac{1}{\sqrt{m}} & \text{概率 } \frac{1}{2} \end{cases}$

计算：$\mathbb{E}X_i = 0$。$\sigma_i^2 = \frac{1}{m}$。$\sum_{i=1}^{m} \sigma_i^2 = 1$ $\checkmark$。$\beta = m \cdot \mathbb{E}\left[\|X_i\|^3\right] = m \cdot \frac{1}{m^{1.5}} = \frac{1}{\sqrt{m}}$

$\Rightarrow \forall u \in \mathbb{R}, \quad \left\| \operatorname{Prb}[S \leq u] - \operatorname{Prb}_{\mathcal{N}(0,1)}[Z \leq u] \right\| \leq \frac{0.56}{\sqrt{m}}$

##### 注释（该界限的紧密度如何？）

注意到 $S = \frac{\\#H - \\#T}{\sqrt{m}}$；若 $m$ 为偶数，则 $S = 0 \Leftrightarrow \\#H = \\#T = \frac{m}{2}$

计算：$\operatorname{Prb}[\\#H = \\#T] = \operatorname{Prb}[S=0] = \operatorname{Prb}[S \leq 0] - \operatorname{Prb}[S \leq -\varepsilon]$（令 $\varepsilon \to 0^+$，设 $\varepsilon = X_m$）

$$\begin{aligned}
&= \left( \operatorname{Prb}[S \leq 0] - \operatorname{Prb}[Z \leq 0] \right) - \left( \operatorname{Prb}[S \leq -\varepsilon] - \operatorname{Prb}[Z \leq -\varepsilon] \right) \\
&\leq \frac{0.56}{\sqrt{m}} + \frac{0.56}{\sqrt{m}} = \frac{1.12}{\sqrt{m}}  \text{(Berry-Esseen)} \\
\end{aligned}$$

另一方面，
$$
\frac{\binom{m}{m/2}}{2^m} = \frac{m!}{2^m \cdot (m/2)! (m/2)!} \approx \frac{\sqrt{2\pi m} \left(\frac{m}{e}\right)^m}{2^m \cdot \sqrt{2\pi \cdot m/2} \cdot \left(\frac{m/2}{e}\right)^{m}} = \sqrt{\frac{2}{\pi m}} \approx \frac{0.798}{\sqrt{m}}  \text{(斯特林近似)}
$$

-   可见对于一般误差界，0.5514的因子难以显著改善。

-   然而在“尾部”区域，该界限可获得显著改善。


## 切诺夫/尾部界限

##### 动机示例

设 $X_i = \begin{cases} +1 & \text{w.p. } \frac{1}{2} \\ -1 & \text{w.p. } \frac{1}{2} \end{cases}$ 为独立同分布随机变量，$S = \sum_{i=1}^{n} X_i$

根据贝里-埃森定理：$\operatorname{Prb}[S \geq t \cdot \sqrt{n}] \approx \operatorname{Prb}_{g \sim \mathcal{N}(0,1)}[g \geq t] \pm \frac{O(1)}{\sqrt{n}}$

其中 $\operatorname{Prb}[g \geq t] = \int_{t}^{\infty} \frac{1}{\sqrt{2\pi}} e^{-\frac{t^2}{2}} dt \sim \Theta\left(\frac{1}{t} \cdot e^{-\frac{t^2}{2}}\right)$ ($t > 1$)

令 $t = 10\sqrt{\ln n}$： $\operatorname{Prb}[S \geq t \cdot \sqrt{n}] \leq O\left(\frac{1}{\sqrt{\ln n}} \cdot \frac{1}{n^{50}}\right) \pm O\left(\frac{1}{\sqrt{n}}\right) \leq O\left(\frac{1}{\sqrt{n}}\right)$

##### 目标

利用切尔诺夫不等式获得更优结果（当尾部概率较小时）。

##### 随机变量上界：信息量越多 $\Rightarrow$ 上界越精确

###### 马可夫不等式（仅知均值时）

设 $X \geq 0$。则 $\operatorname{Prb}[X \geq t \cdot \mathbb{E}X] \leq \frac{1}{t}$ $\forall t > 0$。

##### 证明

$\mathbb{E}X \geq \operatorname{Prb}[X \geq \alpha] \cdot \alpha + \operatorname{Prb}[X < \alpha] \cdot 0 \Rightarrow \operatorname{Prb}[X \geq \alpha] \leq \frac{1}{\alpha} \cdot \mathbb{E}X$ ($\alpha > 0$)。取 $\alpha = t \cdot \mathbb{E}X$。

###### 切比雪夫不等式（需知均值与方差）

设 $\mathbb{E}X = \mu$，$\mathrm{Var}[X] = \sigma^2$（$\sigma \geq 0$）。则对任意 $t > 0$，有 $$\operatorname{Prb}\left[ \|X - \mu\| \geq t \cdot \sigma \right] \leq \frac{1}{t^2}.$$

##### 证明

令 $Y = (X - \mu)^2$。验证 $\mathbb{E}Y = \sigma^2$ 且 $Y \geq 0$ 几乎必然成立。

由马尔可夫不等式：$\operatorname{Prb}[Y \geq t^2 \cdot \mathbb{E}Y] \leq \frac{1}{t^2}$

$$\begin{aligned}
\operatorname{Prb}[(X-\mu)^2 \geq t^2 \cdot \sigma^2] &= \operatorname{Prb}[\|X - \mu\| \geq t \cdot \sigma] \\
&\leq \frac{1}{t^2}
\end{aligned}$$

##### 回到情景（*）

$S = \sum_{i=1}^{n} X_i$，$X_i = \begin{cases} +1 & \text{w.p. } \frac{1}{2} \\ -1 & \text{w.p. } \frac{1}{2} \end{cases}$ {cases}$

###### 基于马尔可夫原理

令 $T = S + n \geq 0$。$\mathbb{E}T = \mathbb{E}S + n = n$。

则 $\operatorname{Prb}[S \geq 10\sqrt{n \ln n}] = \operatorname{Prb}[T \geq n + 10\sqrt{n \ln n}] = \operatorname{Prb}\left[T \geq \frac{n + 10\sqrt{n \ln n}}{n} \cdot \mathbb{E}T\right]$

$$\leq \frac{n}{n + 10\sqrt{n \ln n}} = 1 - \Theta\left(\sqrt{\frac{\ln n}{n}}\right) \quad \boxed{\text{甚至不趋于} 0。}$$

###### 契比雪夫不等式

令 $\mu = \mathbb{E}S = 0$。$\sigma^2 = \mathrm{Var}[S] = n$

则 $\operatorname{Prb}[S \geq 10\sqrt{n \ln n}] \leq \operatorname{Prb}[\|S - \mu\| \geq 10\sqrt{n \ln n}] = \operatorname{Prb}[\|S - \mu\| \geq 10\sqrt{\ln n} \cdot \sigma]$

$$\leq \frac{1}{100 \ln n} \quad \boxed{\text{趋近于 } 0; \text{远大于 } \frac{1}{n^{50}}}$$

##### 注释

切比雪夫不等式无需完全独立性，仅需“成对”独立性：

$$\begin{aligned}
\mathrm{Var}[S] &= \mathrm{Var}[X_1 + \dots + X_n] = \mathbb{E}\left[(X_1 + \dots + X_n)^2\right] - \left(\mathbb{E}(X_1 + \dots + X_n)\right)^2 \\
&= \mathbb{E}\left[(X_1 + \dots + X_n)^2\right] = \mathbb{E}X_1^2 + \dots + \mathbb{E}X_n^2 + \sum_{i \neq j} \mathbb{E}X_i X_j \\
&\quad \left( = \sum_{i \neq j} (\mathbb{E}X_i)(\mathbb{E}X_j) = 0 \text{ 由“两两”独立性得} \right)
\end{aligned}$$



“四阶矩方法”（适用于四元独立性）

$$
\mathbb{E}|S^4| = \mathbb{E}S^4 = \mathbb{E}\left[\left(\sum_{i=1}^{n} X_i\right)^4\right]$$ 

$$\begin {aligned}
&= \underbrace{\sum_{i=1}^{n} \mathbb{E}X_i^4}_{= n \cdot 1 = n} + \underbrace{\sum_{i \neq j} \mathbb {E}X_i^2 X_j^2}_{= \binom{n}{2} \cdot \binom{4}{2} \cdot 1 = \frac{n(n-1)}{2} \cdot 6} + \underbrace{\mathbb{E}X_i X_j^3 \text{ 项}}_{= 0} + \underbrace{\mathbb {E}X_i X_j X_k^2 \text{ 项}}_{= 0} + \underbrace{\mathbb{E}X_i X_j X_k X_l \text{ 项}}_{= 0} \\
&= n + 3n(n-1) = 3n^2 - 2n \leq 3n^2
\end{aligned}
$$

对$S^4$应用马尔可夫公式： $$\operatorname{Prb}[\\|S\\| \geq t \cdot \sqrt{n}] = \operatorname{Prb}[S^4 \geq t^4 \cdot n^2] \leq \frac{\mathbb{E}S^4}{t^4 \cdot n^2} \leq \frac{3n^2}{t^4 \cdot n^2} = \frac{3}{t^4}$$

取 $t = 10\sqrt{\ln n}$：$\operatorname{Prb}[S \geq t \cdot \sqrt{n}] \leq \frac{3}{10000 (\ln n)^2}$

##### 继续推导

对于每个 $k$：建立 $\mathbb{E}S^{2k} \leq C_k \cdot n^k$

对$S^{2k}$应用马尔可夫公式：$\operatorname{Prb}[\|S\| \geq t\sqrt{n}] = \operatorname{Prb}[S^{2k} \geq t^{2k} \cdot n^k] \leq \frac{C_k}{t^{2k}}$

优化$k$。

##### “切尔诺夫方法”

考虑用 $e^{\lambda S}$ 替代 $S^{2k}$（$\lambda > 0$）

$$\begin{aligned}
\mathbb{E}e^{\lambda S} &= \mathbb{E}e^{\lambda \cdot \sum X_i} = \mathbb{E}\prod_{i=1}^{n} e^{\lambda X_i} = \prod_{i=1}^{n} \mathbb{E}e^{\lambda X_i} \quad \text{(完全独立)} \\
\text{其中}
\mathbb{E}e^{\lambda X_i} &= \frac{1}{2}e^{\lambda} + \frac{1}{2}e^{-\lambda} \\
&= \frac{1}{2}(1 + \lambda + \frac{\lambda^2}{2!} + \frac{\lambda^3}{3!} + \dots) + \frac{1}{2}(1 - \lambda + \frac{\lambda^2}{2!} - \frac{\lambda^3}{3!} + \dots) \\
&= 1 + \frac{\lambda^2}{2!} + \frac{\lambda^4}{4!} + \frac{\lambda^6}{6!} + \dots \leq e^{\frac{\lambda^2}{2}}
\end{aligned}$$

因此：$\mathbb{E}e^{\lambda S} \leq e^{n \frac{\lambda^2}{2}}$

对 $e^{\lambda S} \geq 0$ 应用马尔可夫不等式：

$$\begin{aligned}
\operatorname{Prb}[S \geq 10\sqrt{n \ln n}] &= \operatorname{Prb}[e^{\lambda S} \geq e^{\lambda \cdot 10\sqrt{n \ln n}}] \leq \frac{\mathbb{E}e^{\lambda S}}{e^{\lambda \cdot 10\sqrt{n \ln n}}} \\
&\leq e^{n \frac{\lambda^2}{2} - \lambda \cdot 10\sqrt{n \ln n}}
\end{aligned}$$

取 $\lambda = 10\sqrt{\frac{\ln n}{n}}$：$\operatorname{Prb}[S \geq 10\sqrt{n \ln n}] \leq e^{-50 \ln n} = \frac{1}{n^{50}}$

##### 切诺夫界

设 $X_1, X_2, \dots, X_n$ 为互不相关且取值于区间 $[0,1]$ 的随机变量（可放宽至 $[0,1]$）。令 $\mathbb{E}X_i = p_i$，$X = \sum_{i=1}^{n} X_i$，$\mu = \mathbb{E}X$。则对于任意 $\Delta > 0$，

1.  $\operatorname{Prb}[X \geq (1+\Delta)\mu] \leq \left[\frac{e^{\Delta}}{(1+\Delta)^{1+\Delta}}\right]^{\mu}$

2.  $\operatorname{Prb}[X \leq (1-\Delta)\mu] \leq \left[\frac{e^{-\Delta}}{(1-\Delta)^{1-\Delta}}\right]^{\mu}$

##### 备注

更简洁地表示为：

1.  $\Rightarrow \operatorname{Prb}[X \geq (1+\Delta)\mu] \leq \exp\left(-\frac{\Delta^2 \mu}{2+\Delta}\right)$ ($\forall \Delta > 0$)

2.  $\Rightarrow \operatorname{Prb}[X \leq (1-\Delta)\mu] \leq \exp\left(-\frac{\Delta^2 \mu}{2}\right)$ ($\forall \Delta \in (0,1)$)


##### 证明

仅证明1)，2)类似。

对于任意$\lambda > 0$，有$\operatorname{Prb}[X \geq (1+\Delta)\mu] = \operatorname{Prb}[e^{\lambda X} \geq e^{\lambda \cdot (1+\Delta)\mu}]$

$$\begin{aligned}
&\overset{\text{(马尔可夫)}}{\leq} \frac{\mathbb{E}e^{\lambda X}}{e^{\lambda \cdot (1+\Delta)\mu}} \text{(**)} \\
\text{其中，}
\mathbb{E}e^{\lambda X} &= \prod_{i=1}^{n} \mathbb{E}e^{\lambda X_i} \\
&\leq \prod_{i=1}^{n} \exp(p_i(e^{\lambda}-1)) = \exp\left(\sum_{i=1}^{n} p_i(e^{\lambda}-1)\right)
\end{aligned}$$

因此，$(**)$ $\leq \exp\left( \sum_{i=1}^{n} p_i(e^{\lambda}-1) - \lambda(1+\Delta)\mu \right)$

令 $\lambda = \ln(1+\Delta) > 0$，最终得到： $$\operatorname{Prb}[X \geq (1+\Delta)\mu] \leq \exp\left( \mu \cdot (1+\Delta - 1 - (1+\Delta)\ln(1+\Delta)) \right) = \exp\left( \mu \cdot (\Delta - (1+\Delta)\ln(1+\Delta)) \right)$$

##### 其他有用的集中不等式.


| 名称 | 特点/条件 | 备注 |
|------|-----------|------|
| 霍夫丁不等式 | $X_i \in [a_i, b_i]$ | 适用于随机游走 |
| 阿祖马不等式 |  |  |
| 伯恩斯坦不等式 | 涉及 $X_i$ 方差 |  |
| 弗里德曼不等式 |  |  |

##### 霍夫丁不等式

设$X_1, X_2, \dots, X_n$为独立随机变量，满足$X_i \in [a_i, b_i]$。设 $S = X_1 + \dots + X_n$。则对所有 $t > 0$ 成立： $$\operatorname{Prb}[S - \mathbb{E}S \geq t] \leq \exp\left(-\frac{2t^2}{\sum_{i=1}^{n} (b_i - a_i)^2}\right).$$

##### 伯恩斯坦不等式

设 $X_1, X_2, \dots, X_n$ 为相互独立的随机变量，且 $\mathbb{E}X_i = 0$。假设对所有 $i$ 几乎必然成立 $\|X_i\| \leq M$。则对于任意 $t > 0$： $$\operatorname{Prb}\left[\sum_{i=1}^{n} X_i \geq t\right] \leq \exp\left(-\frac{\frac{1}{2}t^2}{\sum_{i=1}^{n} \mathbb{E}X_i^2 + \frac{1}{3}Mt}\right).$$

### 切诺夫、霍夫丁与伯恩斯坦不等式的比较：一个实例

考虑独立随机变量序列 $\{X_i\}_{i=1}^{n}$，满足 $\forall i$ 时 $X_i \in [0,1]$。

设 $X = \sum_{i=1}^{n} X_i$，$p_i = \mathbb{E}X_i$，$\mu = \mathbb{E}X$。考虑 $\mu \ll n$ 且 $\Delta \ll 1$。

对于 $\operatorname{Prb}[X \geq (1+\Delta)\mu]$ 能得到什么上界？

1.  切尔诺夫不等式：$\exp\left(-\frac{\Delta^2 \mu}{2+\Delta}\right) < \exp\left(-\frac{\Delta^2 \mu}{3}\right)$。

2.  霍夫丁公式：设 $[a_i, b_i] = [0,1]$ $\forall i$，则 $$\operatorname{Prb}[X \geq (1+\Delta)\mu] = \operatorname{Prb}[X - \mathbb {E}X \geq \Delta\mu] \leq \exp\left(-\frac{2\Delta^2 \mu^2}{n}\right) = \exp\left(-2\Delta^2 \mu \cdot \frac{\mu}{n}\right).$$

3.  伯恩斯坦：令 $Y_i = X_i - p_i$（使得 $\mathbb{E}Y_i = 0$）。

    我们有 $\|Y_i\| \leq 1$ 几乎必然成立 $\forall i$，且 $\mathbb{E}Y_i^2 \leq p_i(1-p_i)$。于是，$$\operatorname{Prb}[X \geq (1+\Delta)\mu] = \operatorname{Prb}\left[\sum_{i=1}^{n} Y_i \geq \Delta\mu\right] \leq \exp\left(-\frac{\frac{1}{2}\Delta^2 \mu^2}{\sum_{i=1}^{n} p_i(1-p_i) + \frac{1}{3}\Delta\mu}\right)$$ $$\leq \exp\left(-\frac{\frac{1}{2}\Delta^2 \mu^2}{\mu + \frac{1}{3}\Delta\mu}\right) \leq \exp\left(-\frac{\Delta^2 \mu}{4}\right).$$

##### 观察点\*

-   本例中，切诺夫和伯恩斯坦公式具有可比性，且均优于霍夫丁公式。

-   然而，霍夫丁公式可处理支撑域差异极大的随机变量。

##### 补充说明

存在切诺夫公式优于伯恩斯坦公式的实例。（作业题）