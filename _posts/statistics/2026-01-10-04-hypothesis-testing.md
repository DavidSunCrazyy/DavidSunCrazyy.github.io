---
layout: post
title: "Statistical Inference 假设检验"
permalink: /posts/statistical-inference-hypothesis-testing/
tags: statistical-inference
use_math: true
---

本文系统研究统计假设检验理论。首先建立假设检验的基本框架，包括原假设、备择假设、拒绝域和接受域等概念。然后引入似然比检验、联合-交集检验和交集-联合检验等构造方法。接着建立检验的评价体系，通过功效函数分析第一类错误和第二类错误的权衡，引入显著性水平和水平检验的概念。深入研究一致最大功效（UMP）检验，证明Neyman-Pearson引理和Karlin-Rubin定理，为构造最优检验提供理论依据。最后讨论无偏检验以及UIT和IUT的大小界限问题，形成完整的假设检验理论体系。

**定义 假设，原假设，备择假设**

**假设（hypothesis）**就是关于总体参数的一个陈述。

这个定义是颇为笼统的，但其重点在于假设作出的是关于总体的陈述。假设检验的目的就是依靠来自总体的样本去决定互补的两个假设哪个为真。

一个假设检验问题中两个互补的假设称为**原假设（null hypothesis，注：原假设也叫零假设）**和**备择假设（alternative hypothesis）**。把它们分别记作 $H_0$ 和 $H_1$。

原假设是一个默认的、没有差异或没有关系的假设。表示"无效果"、"无变化"、"无差别"等。假设检验的目标通常是试图拒绝零假设。

备择假设是与零假设对立的假设，表示存在某种效应或差异。研究者希望通过数据证明的是这个假设。

若 $\theta$ 表示一个总体参数，原假设和备择假设的一般格式是 $H_0: \theta \in \Theta_0$ 和 $H_1: \theta \in \Theta_0^c$，这里 $\Theta_0$ 是参数空间的某子集而 $\Theta_0^c$ 是它的补集。

**定义 拒绝局域，接受区域**

一个假设检验过程或者说一个假设检验是一个法则，它明确描述：
1. 对于哪些样本值应该决定接受 $H_0$ 为真。
2. 对于哪些样本值应该拒绝 $H_0$ 而接受 $H_1$ 为真。
那些由拒绝 $H_0$ 的样本构成的样本空间的子集叫做**拒绝区域（rejection region）**或者临界区域（critical region）。拒绝区域的补集叫做接受区域（acceptance region）。


**定义 似然比检验 Likelihood Ratio Test**

设 $\Theta$ 表示整个参数空间，似然比检验的定义如下：

关于检验 $H_0: \theta \in \Theta_0$ 对 $H_1: \theta \in \Theta_0^c$ 的似然比检验统计量是
$$
\lambda(x) = \frac{\sup_{\theta \in \Theta_0} L(\theta \mid x)}{\sup_{\theta \in \Theta} L(\theta \mid x)}.
$$
任何一个拒绝区域的形式为 $\{x : \lambda(x) \leq c\}$ 的检验都叫做似然比检验（likelihood ratio test，简记为 LRT）。这里 $c$ 是任意一个满足 $0 \leq c \leq 1$ 的数。

**命题 基于充分统计量的推断与基于原始数据的推断是等价的**

设 $T(X)$ 是关于 $\theta$ 的一个充分统计量，而 $\lambda^\ast(t)$ 和 $\lambda(x)$ 分别是依赖于 $T$ 和 $X$ 的 LRT 统计量，则对于样本空间内每一个 $x$，有 $\lambda^\ast(T(x)) = \lambda(x)$。

**证明**

根据 Factorization Theorem，$X$ 的概率密度函数或概率质量函数可以写成 $f(x \| \theta) = g(T(x) \| \theta) h(x)$，其中 $g(t \| \theta)$ 是 $T$ 的概率密度函数或概率质量函数而 $h(x)$ 不依赖于 $\theta$。于是
$$
\begin{aligned}
\lambda(x) &= \frac{\sup_{\theta_0} L(\theta \| x)}{\sup_{\theta} L(\theta \| x)} \\
&= \frac{\sup_{\theta_0} f(x \| \theta)}{\sup_{\theta} f(x \| \theta)} \\
&= \frac{\sup_{\theta_0} g(T(x) \| \theta) h(x)}{\sup_{\theta} g(T(x) \| \theta) h(x)} \text{$T$ 是充分的} \\
&= \frac{\sup_{\theta_0} g(T(x) \| \theta)}{\sup_{\theta} g(T(x) \| \theta)} \text{$h(x)$ 不依赖于 $\theta$} \\
&= \frac{\sup_{\theta_0} L^*(\theta \| T(x))}{\sup_{\theta} L^*(\theta \| T(x))} \text{$g(t \| \theta)$ 是 $T$ 的 pdf 或 pmf} \\
&= \lambda^*(T(x)).
\end{aligned}
$$

**定义 联合-交集检验（Union-Intersection Test）**

联合-交集检验是一种用于检验多个假设的统计方法。它通常用于测试一个复合假设 $ H_0 $，其中 $ H_0 $ 是多个简单或复合假设的并集（union）。具体来说，如果 $ H_0 $ 可以表示为 $ H_0: \theta \in \Theta_0 $，而 $ \Theta_0 $ 是多个子集的并集，那么联合-交集检验会通过分别检验每个子集来判断是否拒绝原假设。

**基本思想：**
联合-交集检验的逻辑是：如果在所有子集中都拒绝原假设，则整体上也拒绝原假设。换句话说，只有当所有子假设都被拒绝时，才能拒绝原假设。

**定义 交集-联合检验（Intersection-Union Test）**

交集-联合检验是一种用于检验多个假设的统计方法。它通常用于测试一个复合假设 $ H_0 $，其中 $ H_0 $ 是多个简单或复合假设的交集（intersection）。具体来说，如果 $ H_0 $ 可以表示为 $ H_0: \theta \in \Theta_0 $，而 $ \Theta_0 $ 是多个子集的交集，那么交集-联合检验会通过分别检验每个子集来判断是否拒绝原假设。

**基本思想：**
交集-联合检验的逻辑是：如果在至少一个子集中拒绝原假设，则整体上拒绝原假设。换句话说，只要有一个子假设被拒绝，就拒绝原假设。





## 检验的评价方法

|  |  | **判决** |
|---|---|---|
|  |  | 接受 $H_0$ | 拒绝 $H_0$ |
|**真实情况** | $H_0$ | 正确判决 | 第一类错误 |
|  | $H_1$ | 第二类错误 | 正确判决 |

**注 第一类错误和第二类错误**

第一类错误是指 零假设是对的，但我们却错误地拒绝了它。（误判了一个无辜的人有罪）。第二类错误是指 零假设是错的，但我们却错误地接受了它。（放过了一个有罪的人）

第一类错误发生的概率叫做 显著性水平（$\alpha$）。第二类错误发生的概率记作$\beta$。


**定义 功效函数（power function）**

一个拒绝区域为 $R$ 的假设检验的功效函数（power function）是由
$$
\beta(\theta) = P_\theta(X \in R)
$$
所定义的函数.



假设样本量固定，通常不可能同时使两种类型的错误概率任意小：第一类错误和第二类错误之间的权衡。怎么办？！

- 将第一类错误固定在指定的水平（例如 0.05）。
-  然后，选择具有最小第二类错误的检验。

Focus on Controlling Type I Error Probabilities

**定义 size $\alpha$ 检验， level $\alpha$ 检验**

对于 $0 \leq \alpha \leq 1$，如果满足 $\sup_{\theta \in \Theta_0} \beta(\theta) = \alpha$，则具有功效函数 $\beta(\theta)$ 的检验称为 size $\alpha$ 的检验。

对于 $0 \leq \alpha \leq 1$，如果满足 $\sup_{\theta \in \Theta_0} \beta(\theta) \leq \alpha$，则具有功效函数 $\beta(\theta)$ 的检验称为 level $\alpha$ 的检验。

注意：
- level $\alpha$ 的集合包含 size $\alpha$ 的集合。
- 构造一个 size $\alpha$ 的检验可能是"计算上"不可能的。


**定义 无偏检验**

如果对于每一个 $\theta' \in \Theta_0^c$ 和 $\theta'' \in \Theta_0$，都有 $\beta(\theta') \geq \beta(\theta'')$，则具有功效函数 $\beta(\theta)$ 的检验称为**无偏检验**。


考虑控制第一类错误概率 $ P(\text{Type I Error}) $ 的检验类，即，对于所有 $ \theta \in \Theta_0 $，水平为 $ \alpha $ 的检验满足 $ P_\theta(\text{Type I Error}) \leq \alpha $。将注意力限制在水平为 $ \alpha $ 的检验上，我们希望找到最小化第二类错误概率（或等价地，最大化功效）的检验。

**定义 UMP 检验**

设 $ \mathcal{C} $ 是用于检验 $ H_0: \theta \in \Theta_0 $ 对于 $ H_1: \theta \in \Theta_0^c $ 的检验类。如果对于每个 $ \theta \in \Theta_0^c $ 和 $ \mathcal{C} $ 类中任何其他检验的功效函数 $ \beta'(\theta) $，该类中的一个检验具有功效函数 $ \beta(\theta) $，且满足 $ \beta(\theta) \geq \beta'(\theta) $，则称该检验为 **均匀最优功效 (UMP) 检验**。

我们关注 $ \mathcal{C} $ 为所有水平为 $ \alpha $ 的检验类，并寻找 UMP 水平为 $ \alpha $ 的检验。UMP 检验并不总是存在，但如果存在，"UMP 检验可以被认为是该类中最好的"。

**定理 Neyman-Pearson 引理**

考虑检验 $ H_0: \theta = \theta_0 $ 对于 $ H_1: \theta = \theta_1 $，其中对应于 $ \theta_i $ 的概率密度函数或概率质量函数为 $ f(\mathbf{x} \mid \theta_i), i = 0, 1 $，使用一个拒绝域为 $ R $ 的检验，满足：

$$
\mathbf{x} \in R \quad \text{if} \quad f(\mathbf{x} \mid \theta_1) > k f(\mathbf{x} \mid \theta_0)
$$

和

$$
\mathbf{x} \in R^c \quad \text{if} \quad f(\mathbf{x} \mid \theta_1) < k f(\mathbf{x} \mid \theta_0)
$$

对于某个 $ k \geq 0 $，并且

$$
\alpha = P_{\theta_0}(\mathbf{X} \in R).
$$

那么：

a. （充分性）任何满足条件 (1) 和 (2) 的检验都是 UMP  level $ \alpha $ 的检验。

b. （必要性）如果存在一个满足条件 (1) 和 (2) 的检验（其中 $ k > 0 $），则每个 UMP 水平为 $ \alpha $ 的检验都是大小为 $ \alpha $ 的检验（满足 (3)），并且每个 UMP 水平为 $ \alpha $ 的检验都满足 (1)，除非可能在一个集合 $ A $ 上，该集合满足 $ P_{\theta_0}(\mathbf{X} \in A) = P_{\theta_1}(\mathbf{X} \in A) = 0 $。

**总结，N-P 引理：** $ H_0: \theta = \theta_0 $ 对于 $ H_1: \theta = \theta_1 $$

$$
*\begin{cases}
\mathbf{x} \in R \quad \text{if} \quad f(\mathbf{x} \| \theta_1) > k f(\mathbf{x} \| \theta_0) \\
\mathbf{x} \in R^c \quad \text{if} \quad f(\mathbf{x} \| \theta_1) < k f(\mathbf{x} \| \theta_0)
\end{cases}, \quad k \geq 0
$$

$$
** \alpha = P_{\theta_0}(\mathbf{X} \in R).
$$

a.（充分性）* & ** $\mathrm{Im}plies$ UMP
b. （必要性）如果存在满足 * & ** 的检验，则 UMP $\mathrm{Im}plies$ * & **，除非可能在一个集合 $ A $ 上，该集合满足 $ P_{\theta_i}(\mathbf{X} \in A) = 0, i = 0, 1 $。



**证明**

我们考虑简单假设检验问题：

- 原假设：$ H_0: \theta = \theta_0 $
- 备择假设：$ H_1: \theta = \theta_1 $

设 $ f(x \| \theta_0) $ 和 $ f(x \| \theta_1) $ 分别为原假设和备择假设下的概率密度函数（或概率质量函数）。

目标是找到一个拒绝域 $ R $，使得：
1. 第一类错误的概率 $ P_{\theta_0}(X \in R) \leq \alpha $；
2. 在满足条件 (1) 的前提下，第二类错误的概率 $ P_{\theta_1}(X \notin R) $ 最小化（等价于功效最大化）。


根据 Neyman-Pearson 引理，最优的拒绝域 $ R $ 应满足以下规则：
$$
x \in R \quad \text{if} \quad f(x \| \theta_1) > k f(x \| \theta_0),
$$
$$
x \notin R \quad \text{if} \quad f(x \| \theta_1) < k f(x \| \theta_0),
$$
其中 $ k \geq 0 $ 是一个常数，用于确保第一类错误的概率不超过 $ \alpha $。


(1) 充分性

假设某个检验 $ \phi(x) $ 满足：
$$
\phi(x) =
\begin{cases}
1, & \text{if } f(x \| \theta_1) > k f(x \| \theta_0), \\
0, & \text{if } f(x \| \theta_1) < k f(x \| \theta_0).
\end{cases}
$$

我们需要证明该检验在所有水平为 $ \alpha $ 的检验中是最优的。

**目标：**
对于任何其他检验 $ \psi(x) $，如果 $ P_{\theta_0}(\psi(X) = 1) \leq \alpha $，则 $ P_{\theta_1}(\phi(X) = 1) \geq P_{\theta_1}(\psi(X) = 1) $。

**证明步骤：**

1. 定义两个集合：
$$
A = \{x : f(x \| \theta_1) > k f(x \| \theta_0)\}, \quad B = \{x : f(x \| \theta_1) < k f(x \| \theta_0)\}.
$$
根据定义，检验 $ \phi(x) $ 在 $ A $ 上取值 1，在 $ B $ 上取值 0。

2. 比较两种检验的功效：
$$
P_{\theta_1}(\phi(X) = 1) - P_{\theta_1}(\psi(X) = 1) = \int_A [1 - \psi(x)] f(x \| \theta_1) \, dx - \int_B \psi(x) f(x \| \theta_1) \, dx.
$$

3. 注意到在 $ A $ 上 $ f(x \| \theta_1) > k f(x \| \theta_0) $，在 $ B $ 上 $ f(x \| \theta_1) < k f(x \| \theta_0) $。因此，可以将上式重写为：
$$
P_{\theta_1}(\phi(X) = 1) - P_{\theta_1}(\psi(X) = 1) \geq k \left[ \int_A [1 - \psi(x)] f(x \| \theta_0) \, dx - \int_B \psi(x) f(x \| \theta_0) \, dx \right].
$$

4. 因为 $ \psi(x) $ 是水平为 $ \alpha $ 的检验，且 $ \phi(x) $ 满足第一类错误的概率恰好为 $ \alpha $，所以：
$$
\int_A [1 - \psi(x)] f(x \| \theta_0) \, dx - \int_B \psi(x) f(x \| \theta_0) \, dx \geq 0.
$$

5. 因此，$ P_{\theta_1}(\phi(X) = 1) \geq P_{\theta_1}(\psi(X) = 1) $，即 $ \phi(x) $ 是功效最大的检验。

(2) 必要性

假设存在一个检验 $ \phi^*(x) $ 是 UMP 检验，但不满足 Neyman-Pearson 规则。我们需要证明这会导致矛盾。

**反证法：**

1. 假设存在一个点 $ x_0 $，使得：
$$
f(x_0 \| \theta_1) > k f(x_0 \| \theta_0), \quad \text{但 } \phi^*(x_0) = 0.
$$

2. 构造一个新的检验 $ \phi'(x) $，使得：
$$
\phi'(x) =
\begin{cases}
1, & \text{if } x = x_0, \\
\phi^*(x), & \text{otherwise}.
\end{cases}
$$

3. 检查新检验的性质：
- 新检验的第一类错误概率不会超过原检验，因为 $ x_0 $ 对应的 $ f(x_0 \| \theta_0) $ 很小。
- 新检验的功效大于原检验，因为 $ f(x_0 \| \theta_1) > k f(x_0 \| \theta_0) $。

4. 这与 $ \phi^*(x) $ 是 UMP 检验的假设矛盾。

因此，UMP 检验必须满足 Neyman-Pearson 规则。

总结

通过充分性和必要性的证明，我们得出结论：Neyman-Pearson 引理成立。具体来说：
- 如果一个检验满足似然比规则 $ f(x \| \theta_1) > k f(x \| \theta_0) $，则它是 UMP 检验。
- 反之，任何 UMP 检验都必须满足该规则。

$$
\boxed{\text{Neyman-Pearson 引理得证。}}
$$



**推论 充分统计量**

假设 $T(X)$ 是参数 $\theta$ 的充分统计量，且 $g(t \| \theta_i)$ 是对应于 $\theta_i$ 的 $T$ 的概率密度函数（pdf）或概率质量函数（pmf），其中 $i = 0, 1$。那么，基于 $T$ 的任何检验，其拒绝域为 $S$（即 $T$ 的样本空间的一个子集），如果满足以下条件，则该检验是水平为 $\alpha$ 的一致最大功效 (UMP) 检验：

1.
$$
t \in S \quad \text{当且仅当} \quad g(t \| \theta_1) > k g(t \| \theta_0)
$$
2.
$$
t \in S^c \quad \text{当且仅当} \quad g(t \| \theta_1) < k g(t \| \theta_0)
$$
对于某个 $k \geq 0$，并且
3.
$$
\alpha = P_{\theta_0}(T \in S).
$$

**定义 MLR**

如果对于一个具有实值参数 $\theta$ 的单变量随机变量 $T$，其概率密度函数（pdf）或概率质量函数（pmf）族 $\{ g(t \| \theta) : \theta \in \Theta \}$ 满足：对于任意 $\theta_2 > \theta_1$，比值 $\frac{g(t \| \theta_2)}{g(t \| \theta_1)}$ 在集合 $\{ t : g(t \| \theta_1) > 0 \text{ 或 } g(t \| \theta_2) > 0 \}$ 上是关于 $t$ 的单调非减函数，则称该族具有 **单调似然比性质（Monotone Likelihood Ratio, MLR）**。

注意，如果 $0 < c$，则 $\frac{c}{0}$ 被定义为 $\infty$。

**定理 Karlin-Rubin**

考虑检验假设 $H_0: \theta \leq \theta_0$ 对于备择假设 $H_1: \theta > \theta_0$。假设 $T$ 是参数 $\theta$ 的充分统计量，且 $T$ 的概率密度函数（pdf）或概率质量函数（pmf）族 $\{ g(t \| \theta): \theta \in \Theta \}$ 具有单调似然比性质（MLR）。那么，对于任意 $t_0$，如果拒绝 $H_0$ 当且仅当 $T > t_0$，则该检验是一个水平为 $\alpha$ 的一致最大功效 (UMP) 检验，其中 $\alpha = P_{\theta_0}(T > t_0)$。

Karlin-Rubin 定理给出了找到一个UMP校验的最简单方式。


**例子 Non-existence of UMP test**



假设我们想要一个大小为 $\alpha$ 的检验，但 UIT（联合检验）或 IUT（交集检验）的大小难以评估。基于构建 UIT 或 IUT 的各个检验的大小，我们能否提供关于其大小的界限？

**UIT**

在这里，我们正在检验零假设的形式 $H_0: \theta \in \Theta_0$，其中 $\Theta_0 = \bigcap_{\gamma \in \Gamma} \Theta_\gamma$。令 $\lambda_\gamma(x)$ 为检验 $H_{0\gamma}: \theta \in \Theta_\gamma$ 对 $H_{1\gamma}: \theta \in \Theta_\gamma^c$ 的似然比检验统计量，而 $\lambda(x)$ 为检验 $H_0: \theta \in \Theta_0$ 对 $H_1: \theta \in \Theta_0^c$ 的似然比检验统计量。我们有以下结果：

**命题**

考虑检验 $H_0: \theta \in \Theta_0$ 对 $H_1: \theta \in \Theta_0^c$，其中 $\Theta_0 = \bigcap_{\gamma \in \Gamma} \Theta_\gamma$，且 $\lambda_\gamma(x)$ 如上定义。定义 $T(x) = \inf_{\gamma \in \Gamma} \lambda_\gamma(x)$，并构造具有拒绝域的 UIT：
$$
\{x: \lambda_\gamma(x) < c \text{ for some } \gamma \in \Gamma\} = \{x: T(x) < c\}.
$$
同时考虑通常的 LRT，其拒绝域为 $\{x: \lambda(x) < c\}$。则有以下结论：

1. 对于每个 $x$，$T(x) \geq \lambda(x)$；
2. 如果 $\beta_T(\theta)$ 和 $\beta_\lambda(\theta)$ 分别是基于 $T$ 和 $\lambda$ 的检验的势函数，则对于每个 $\theta \in \Theta$，$\beta_T(\theta) \leq \beta_\lambda(\theta)$；
3. 如果 LRT 是一个水平为 $\alpha$ 的检验，则 UIT 也是一个水平为 $\alpha$ 的检验。

证明很简单。注意到由于 $\Theta_0 = \bigcap_{\gamma \in \Gamma} \Theta_\gamma \subset \Theta_\gamma$，我们有 $\lambda_\gamma(x) \geq \lambda(x), \forall x$。

**IUT**

在这里，我们正在检验零假设的形式 $H_0: \theta \in \Theta_0$ 对 $H_1: \theta \in \Theta_0^c$，其中 $\Theta_0 = \bigcup_{\gamma \in \Gamma} \Theta_\gamma$。一个 IUT 的拒绝域形式为 $R = \bigcap_{\gamma \in \Gamma} R_\gamma$，其中 $R_\gamma$ 是检验 $H_{0\gamma}: \theta \in \Theta_\gamma$ 对 $H_{1\gamma}: \theta \in \Theta_\gamma^c$ 的拒绝域。我们有以下结果：

**命题**

设 $\alpha_\gamma$ 为具有拒绝域 $R_\gamma$ 的检验 $H_{0\gamma}$ 的大小。那么，具有拒绝域 $R = \bigcap_{\gamma \in \Gamma} R_\gamma$ 的 IUT 是一个水平为 $\alpha = \sup_{\gamma \in \Gamma} \alpha_\gamma$ 的检验。


证明很简单。注意到 $R \subset R_\gamma$。对于所有 $\theta \in \Theta_0$，存在某个 $\gamma$ 使得 $\theta \in \Theta_\gamma$。因此，
$$
P_\theta(X \in R) \leq P_\theta(X \in R_\gamma) \leq \alpha_\gamma \leq \alpha.
$$

注意命题 4.2 仅适用于由似然比检验构建的 UIT。相比之下，命题 4.3 适用于任何 IUT。

IUT 在定理 4.3 中是一个水平为 $\alpha$ 的检验。但是，IUT 的大小可能远小于 $\alpha$。以下定理给出了 IUT 的大小恰好为 $\alpha$ 且 IUT 不太保守的条件。


**命题**

考虑检验 $H_0: \theta \in \bigcup_{j=1}^k \Theta_j$，其中 $k$ 是一个有限正整数。对于每个 $j = 1, \ldots, k$，设 $R_j$ 为检验 $H_{0j}$ 的一个水平为 $\alpha$ 的检验的拒绝域。假设对于某些 $i = 1, \ldots, k$，存在参数点序列 $\theta_l \in \Theta_i, l = 1, 2, \ldots$，满足以下条件：

1. $\lim_{l \to \infty} P_{\theta_l}(X \in R_i) = \alpha$
2. 对于每个 $j = 1, \ldots, k, j \neq i$，$\lim_{l \to \infty} P_{\theta_l}(X \in R_j) = 1$

那么，具有拒绝域 $R = \bigcap_{j=1}^k R_j$ 的 UIT 是一个大小为 $\alpha$ 的检验。

**证明**

根据命题 4.3，$R$ 是一个水平为 $\alpha$ 的检验，即 $\sup_{\theta \in \Theta_0} P_\theta(X \in R) \leq \alpha$。另一方面，对于 $\theta_l \in \Theta_i \subset \Theta_0, l = 1, 2, \ldots$，
$$
\sup_{\theta \in \Theta_0} P_\theta(X \in R) \geq \lim_{l \to \infty} P_{\theta_l}(X \in R)
$$
$$
= \lim_{l \to \infty} P_{\theta_l}\left(X \in \bigcap_{j=1}^k R_j\right)
$$
$$
\geq \lim_{l \to \infty} \sum_{j=1}^k P_{\theta_l}(X \in R_j) - (k-1)
$$
$$
= (k-1) + \alpha - (k-1)
$$
$$
= \alpha,
$$
其中第二个不等式是 Bonferroni 不等式的应用。因此，$\sup_{\theta \in \Theta_0} P_\theta(X \in R) = \alpha$。
