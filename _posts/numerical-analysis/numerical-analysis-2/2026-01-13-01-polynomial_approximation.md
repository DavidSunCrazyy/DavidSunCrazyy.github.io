---
layout: post
title: "Numerical Analysis II 多项式逼近一般理论"
permalink: /posts/numerical-analysis-2-01-多项式逼近一般理论/
tags: numerical-analysis
use_math: true
---

# 多项式逼近一般理论

## Weierstrass 定理

我们知道连续函数可以使用多项式逼近.

::: theorem
如果 $f(x)$ 在区间 $[a,b]$ 上连续，则对于$\forall \epsilon >0$,
存在一个$n$次多项式$p_n(x)$使得:
$$\|f(x)-p_n(x)\|_\infty\leqslant \epsilon$$
:::

::: proof
*Proof.*
令$B_n^f (x) = \sum_{k=0}^n f(\frac{k}{n}) {n \choose k} x^k (1-x)^{n-k}$.
这是Bernstein 多项式的线性组合.

不妨设 $f(x) \in C[0, 1]$。

注意到： $$\begin{aligned}
\sum_{k=0}^{n} \binom{n}{k} x^k (1-x)^{n-k} &= 1 \\
\sum_{k=0}^{n} (nx - k)^2 \binom{n}{k} x^k (1-x)^{n-k} &= nx(1-x)
\end{aligned}$$

令
$$E_n(x) = \max_{|x - \frac{k}{n}| < n^{-\frac{1}{4}}} |f(x) - f(\frac{k}{n})|$$

由 $f(x) \in C[0, 1]$，则 $f$ 在 $[0, 1]$ 上一致连续。
$\forall \varepsilon > 0$, $\exists \delta_\varepsilon > 0$ 使得对于任意
$x, y \in [0, 1]$， 当 $|x - y| < \delta_\varepsilon$ 时，
$$|f(x) - f(y)| < \varepsilon$$

取 $N = \lceil \delta_\varepsilon^{-4} \rceil$，则有 $\forall n > N$ 有
$$E_n = \max_{x \in [0, 1]} E_n(x) \leq \varepsilon$$ 即
$$\lim_{n \to \infty} E_n = 0$$

$$\begin{aligned}
    \left| f(x) - B_n f(x) \right| &= \left| \sum_{k=0}^{n} \left( f(x) - f\left(\frac{k}{n}\right) \right) \lambda_{n,k}(x) \right| \\
    &\leq \sum_{|x - \frac{k}{n}| < n^{-\frac{1}{4}}} \left| f(x) - f\left(\frac{k}{n}\right) \right| \lambda_{n,k}(x) \\
    &\quad + \sum_{|x - \frac{k}{n}| \geq n^{-\frac{1}{4}}} \left| f(x) - f\left(\frac{k}{n}\right) \right| \lambda_{n,k}(x) \\
    &\leq E_n(x) + \sum_{k=0}^{n} \left| \frac{k}{n} - x \right|^2 n^{\frac{1}{2}} \left| f(x) - f\left(\frac{k}{n}\right) \right| \lambda_{n,k}(x) \\
    &\leq E_n + 2M n^{-\frac{3}{2}} \sum_{k=0}^{n} (nx - k)^2 \lambda_{n,k}(x) \\
    &= E_n + 2M n^{-\frac{3}{2}} nx(1-x) \\
    &\leq E_n + \frac{1}{2} M n^{-\frac{1}{2}} \to 0 \quad (\text{对 } x \text{ 一致收敛})
\end{aligned}$$ ◻
:::

我们定义几个记号.

::: definition
令$C_{2\pi} = \{ f\in C(\mathbb{R}): f(x) = f(x+2\pi), \forall x\in \mathbb{R}\}$.
:::

::: definition
若$|a_n| + |b_n|>0$ 则称
$T_n(x) = A + \sum_{k=1}^n (a_k \cos k x + b_k \sin kx)$
为$n$阶三角多项式.
:::

周期性连续函数则可以使用三角多项式逼近.

::: theorem
如果$f(x)\in C_{2\pi}$，则存在$n$阶三角多项式$T(x)$使得:
$\forall x\in \mathbb{R}$, $|T(x) - f(x)| < \varepsilon$.
:::

::: proposition
Weierstrass 第一定理 和 Weierstrass 第二定理 等价.
:::

::: lemma
若$f(x) \in C[0,\pi]$, $\forall \varepsilon >0$, 存在一个偶的三角多项式
$T(x)$ 使得 $$|f(x)-T(x)| < \varepsilon, \forall x\in [0,\pi].$$
:::

::: proof
*Proof.* $f(\arccos y) \in C[-1, 1]$。由 Weierstrass
第一定理，存在多项式 $$\sum_{k=0}^{n} c_k y^k$$ 使得
$$|f(\arccos y) - \sum_{k=0}^{n} c_k y^k| < \varepsilon, \quad y \in [-1, 1].$$
令 $x = \arccos y$，则有
$$|f(x) - \sum_{k=0}^{n} c_k \cos^k x| < \varepsilon, \quad \forall x \in [0, \pi].$$
$\sum_{k=0}^{n} c_k \cos^k x$ 为偶的三角多项式。

### 第一定理 $\Rightarrow$ 第二定理： {#第一定理-rightarrow-第二定理 .unnumbered}

$f(x) \in C_{2\pi}$，由引理 1，存在偶的三角多项式
$T_1(x)$、$T_2(x)$，使得
$$|f(x) + f(-x) - T_1(x)| < \frac{\varepsilon}{2}, \quad \forall x \in [0, \pi],$$
$$|(f(x) - f(-x)) \sin x - T_2(x)| < \frac{\varepsilon}{2}.$$

由于 $f(x) + f(-x)$、$(f(x) - f(-x)) \sin x$ 均为偶的
$2\pi$-周期函数，则有，$\forall x \in \mathbb{R}$，
$$f(x) + f(-x) = T_1(x) + Q_1(x), \quad (1)$$
$$(f(x) - f(-x)) \sin x = T_2(x) + Q_2(x), \quad (2)$$ 其中
$|Q_1(x)| < \frac{\varepsilon}{2}$，$|Q_2(x)| < \frac{\varepsilon}{2}$。

由 $(1) \times \sin^2 x + (2) \times \sin x$ 得
$$f(x) \sin^2 x = \frac{1}{2} \left[ T_1(x) \sin^2 x + T_2(x) \sin x \right]$$
$$+ \frac{1}{2} \left[ Q_1(x) \sin^2 x + Q_2(x) \sin x \right].$$ 则
$T_3(x)$ 为三角多项式，且 $|b(x)| < \frac{\varepsilon}{2}$。

由于 $f(t - \frac{\pi}{2}) \in C_{2\pi}$，则有
$$f(x) \sin^2 x = T_4(x) + C(x),$$ 其中 $T_4(x)$
为三角多项式，$|C(x)| < \frac{\varepsilon}{2}$。

令 $t - \frac{\pi}{2} = x$，则
$$f(x) \sin^2 \left( x + \frac{\pi}{2} \right) = f(x) \cos^2 x = T_4(x + \frac{\pi}{2}) + C(x + \frac{\pi}{2}).$$
由此可得
$$f(x) = T_3(x) + T_4(x + \frac{\pi}{2}) + b(x) + C(x + \frac{\pi}{2}),$$
即 $$|f(x) - T_3(x) - T_4(x + \frac{\pi}{2})| \leq \varepsilon.$$

### 第二定理 $\Rightarrow$ 第一定理： {#第二定理-rightarrow-第一定理 .unnumbered}

设 $f(x) \in C[-\pi, \pi]$，令
$$g(x) = f(x) + \frac{f(-\pi) - f(\pi)}{2\pi} x, \quad x \in [-\pi, \pi].$$
则有 $g(x) = g(-x)$，将 $g(x)$ 周期延拓到 $(-\infty, \infty)$，则
$g(x) \in C_{2\pi}$。

由第二定理，$\forall \varepsilon > 0$ 存在三角多项式
$$T(x) = A + \sum_{k=1}^{n} a_k \cos kx + b_k \sin kx,$$ 使得
$$|g(x) - T(x)| < \frac{\varepsilon}{2}, \quad \forall x \in \mathbb{R}.$$

令 $M = \sum_{k=1}^{n} |a_k| + |b_k|$，则
$$Q(x) = A + \sum_{k=1}^{n} a_k C_m(kx) + b_k S_m(kx).$$ 易得
$$|g(x) - Q(x)| < \varepsilon.$$

令 $$P(x) = Q(x) - \frac{f(-\pi) - f(\pi)}{2\pi} x,$$ 则
$\forall x \in [-\pi, \pi]$ 有 $$|f(x) - P(x)| < \varepsilon.$$

$$S_m(z) = \sum_{k=0}^{m} (-1)^k \frac{z^{2k+1}}{(2k+1)!}, \quad C_m(z) = \sum_{k=0}^{m} (-1)^k \frac{z^{2k}}{(2k)!}.$$
$S_m(z)$、$C_m(z)$ 在 $[-n\pi, n\pi]$ 上一致收敛到
$\sin z$、$\cos z$，则存在 $m$ 充分大使得
$$|\cos z - C_m(z)| < \frac{\varepsilon}{2M}, \quad |\sin z - S_m(z)| < \frac{\varepsilon}{2M}.$$

令 $$Q(x) = A + \sum_{k=1}^{n} a_k C_m(kx) + b_k S_m(kx).$$ 易得
$$|g(x) - Q(x)| < \varepsilon.$$

令 $$P(x) = Q(x) - \frac{f(-\pi) - f(\pi)}{2\pi} x,$$ 则
$\forall x \in [-\pi, \pi]$ 有 $$|f(x) - P(x)| < \varepsilon.$$ ◻
:::

我们可以推广Weierstrass定理到更一般的函数空间.

::: definition
设 $X$ 为紧距离空间. $A\subset C(X)$. 称 $A$ 分离$X$中的点, 如果
$\forall x,y\in X$, $x\ne y$, 存在$f\in A$ 使得 $f(x) \ne f(y)$.
:::

回忆代数的定义.

::: definition
$\mathcal{X}$ 称为一个代数，如果满足以下条件：

\(1\) $\mathcal{X}$ 是一个线性空间。

\(2\) $\mathcal{X}$
上有乘法运算，且满足：$\forall f, g, h \in \mathcal{X}$，$\alpha \in \mathbb{R}$，
$$\begin{aligned}
f(g + h) &= fg + fh \\
(f + g)h &= fh + gh \\
f(gh) &= (fg)h \\
\alpha(fg) &= (\alpha f)g = f(\alpha g)
\end{aligned}$$
:::

::: theorem
设 $X$ 是紧距离空间, $A$ 是 $C(X)$ 的子代数. 若$1\in A$,
且$A$分离$X$中的点, 则$A$在$C(X)$中稠密.
:::

## Chebyshev 定理

在本节我们证明最佳逼近多项式存在 (Chebyshev 定理). 并给出刻画它的方法.

::: definition
$\Delta(p) = \max_{x\in [a,b]} |f(x) - p(x)|$.
:::

::: remark
偏差是指一个特定的多项式到原函数$f$的距离 (最大差值).
:::

::: definition
$E_n = \inf_{p\in P_n} \Delta(p)$, 其中 $P_n$ 是至多 $n$ 次多项式的集合.
:::

::: remark
最小偏差是$P_n$中所有多项式的偏差的最小值.
:::

::: theorem
对于$\forall f(x) \in C[a,b]$, 存在$n$次多项式$p^*(x)$使得:
$$\Delta (p^*) = E_n$$
:::

::: remark
Borel 定理告诉我们确实存在一个多项式可以取到最小偏差.
:::

::: remark
证明使用了泛函分析中的思想.
:::

::: proof
*Proof.* 定理 Borel 对于$\forall f(x) \in C[a,b]$,
存在$n$次多项式$p^*(x)$使得: $$\Delta (p^*) = E_n$$

证明: (deepseek)

Borel定理断言，对于任意连续函数$f \in C[a,b]$，存在次数不超过$n$的多项式$p^*(x)$，使得其偏差$\Delta(p^*) = E_n$，即达到最小偏差。以下是该定理的核心证明步骤：

1.  **极小化序列的存在性**

    根据$E_n$的定义（$\inf_{p \in P_n} \Delta(p)$），存在一列多项式$\{p_k\} \subset P_n$，使得$\Delta(p_k) \to E_n$。此序列称为极小化序列。

2.  **系数有界性的证明**

    假设极小化序列的系数无界，则存在子列$\{p_k\}$的系数向量$\mathbf{a}_k = (a_0^{(k)}, \dots, a_n^{(k)})$满足$\|\mathbf{a}_k\| \to \infty$。考虑标准化向量$\mathbf{v}_k = \mathbf{a}_k / \|\mathbf{a}_k\|$，由Heine-Borel定理，存在收敛子列$\mathbf{v}_{k_m} \to \mathbf{v} \neq \mathbf{0}$。对应的多项式$q_{k_m}(x) = \mathbf{v}_{k_m} \cdot (1, x, \dots, x^n)$收敛到非零多项式$q(x)$。此时，$p_{k_m}(x) = \|\mathbf{a}_{k_m}\| q_{k_m}(x)$在$[a,b]$上某点的值趋于无穷，导致$\Delta(p_{k_m}) \to \infty$，与$\Delta(p_k) \to E_n$矛盾。故系数必有界。

3.  **紧性与收敛性**

    由于$P_n$是有限维空间，系数向量有界序列存在收敛子列$\mathbf{a}_{k_m} \to \mathbf{a}^*$，对应多项式$p_{k_m} \to p^* \in P_n$（系数收敛蕴含多项式一致收敛）。

4.  **连续性与极值达成**

    偏差函数$\Delta(p) = \|f - p\|_\infty$是连续的。因此，$$\Delta(p^*) = \lim_{m \to \infty} \Delta(p_{k_m}) = E_n,$$
    即$p^*$是最优逼近多项式。

5.  **结论**

    利用有限维空间的紧性及偏差函数的连续性，确保了极小化序列的极限$p^* \in P_n$存在，并达到最小偏差$E_n$。因此，Borel定理得证。

$\boxed{\text{存在这样的多项式 } p^* \text{ 使得 } \Delta(p^*) = E_n}$ ◻
:::

::: definition
记$\varepsilon (x) = p(x) - f(x)$, 若$|\varepsilon(x_0)| = \Delta (p)$,
则称$x_0$为**偏离点**. $\varepsilon(x_0) >0$, 正偏离点;
$\varepsilon(x_0) <0$, 负偏离点.
:::

::: lemma
若$p(x)$为$f(x)$的最佳逼近多项式, 则正负偏离点必须都存在.
:::

::: theorem
设$p(x) \in P_n$, $\varepsilon(x)$ 在 $x_1 < x_2 < \cdots < x_n$
上取值为非零的正负相间值
$\lambda_1, -\lambda_2, \cdots, (-1)^{N-1} \lambda_N$, $\lambda_j>0$,
$j=1,2,\cdots,N$, 且$N\ge n+2$, 则$\forall Q(x) \in P_n$,
$\Delta(Q) \ge \min_{1\le i\le N} \lambda_i.$
:::

::: proof
*Proof.* 假设存在 $Q(x) \in P_n$ 使得
$\Delta (Q) < \min_{1\le i \le N} \lambda_i$. 令
$\eta(x) = P(x) - Q(x) = (P(x) - f(x)) - (Q(x) - f(x))$

则 $$\begin{aligned}
\operatorname{sgn}(\eta(x_j)) &= \operatorname{sgn}(P(x_j) - f(x_j)) \\
&= \operatorname{sgn}(\varepsilon(x_j)) = (-1)^{j-1}, \quad j = 1, 2, \ldots, N
\end{aligned}$$

则 $\eta$ 存在至少 $N-1 \geq n+1$ 个零点。

由 $\eta \in P_n$ 得 $\eta = 0$. ◻
:::

::: theorem
对于任意 $f(x) \in C[a,b]$, $P_n$ 中的最佳逼近多项式存在且唯一,
且$P(x)$为最佳逼近多项式当且仅当存在$a\le x_1 < x_2 < \cdots < x_N \le b$,
$N \ge n+2$, 使得 $|E(x_j)| = \Delta(p)$,
$E(x_j) = (-1)^{j-1}E(x_1), j=1,2,\cdots,N$.
:::

::: proof
*Proof.* **充分性\"$\impliedby$\"**

由 Vallée-Poussin 定理可得.

**必要性: \"$\implies$\"**

(反证法) 设 $P(x)$ 交错偏离点数 $N' \leq n+1$, 则存在 $\alpha > 0$ 和
$\xi_1, \ldots, \xi_{N'-1} \in [a,b]$ 将 $[a,b]$ 分割为
$$[a, \xi_1], [\xi_1, \xi_2], \ldots, [\xi_{N'-1}, b]$$ 使得在任一区间上
$E(x)$ 满足 $$-\Delta(P) \leq E(x) < \Delta(P) - \alpha$$ 或者
$$-\Delta(P) + \alpha < E(x) \leq \Delta(P)$$

令 $$\phi(x) = \prod_{i=1}^{N'-1} (x - \xi_i) \in P_n$$ 则
$$Q(x) = P(x) + \omega \phi(x) \in P_n$$ 取 $|\omega|$
充分小，并适当选择 $\omega$ 的符号可有 $$\Delta(Q) < \Delta(P)$$ 矛盾.

最后证明唯一性. (反证法)

设存在 $Q(x) \in P_n$ 使得 $Q(x) \neq P(x)$ 且
$$\Delta(P) = \Delta(Q) = E_n$$ 则由充要条件知 $P, Q$ 分别存在
$N_P = n+2$, $N_Q \geq n+2$ 个交错偏离点. 不妨设 $N_Q \geq N_P$
且相应的交错偏离点为 $\beta_1 < \beta_2 < \cdots < \beta_{N_Q}$

令 $\eta(x) = Q(x) - P(x)$

(1) 若 $\eta(\beta_j) = 0$ 的点数 $= n+1$ 则有 $\eta \equiv 0$

(2) 若 $\eta(\beta_j) = 0$ 的点数 $< n+1$

则 $\eta(\beta_j) \neq 0$ 的点数至少为 2 个.

设 $\beta_{i-1}, \beta_{i+k+1}$ 是相邻的 $\eta$ 的非零点. 即
$\eta(\beta_{i-1}) \neq 0$, $\eta(\beta_{i+k+1}) \neq 0$.

则有
$$\operatorname{sgn}(\eta(\beta_{i-1})) = \operatorname{sgn}(Q(\beta_{i-1}) - f(\beta_{i-1})), \operatorname{sgn}(\eta(\beta_{i+k+1})) = \operatorname{sgn}(Q(\beta_{i+k+1}) - f(\beta_{i+k+1}))$$

由于 $\beta_j$ 为 $Q$ 的交错偏离点，可得 若 $k$ 为偶数，则
$\eta(\beta_{i-1})$ 与 $\eta(\beta_{i+k+1})$ 同号

$\eta$ 在 $[\beta_{i-1}, \beta_{i+k+1}]$ 中有偶数个根

$\eta$ 在 $[\beta_{i-1}, \beta_{i+k+1}]$ 中已有 $k+1$ 个根，则至少有
$k+2$ 个根;

若 $k$ 为奇数，则 $\eta(\beta_{i-1})$ 与 $\eta(\beta_{i+k+1})$ 异号

则 $\eta$ 在 $[\beta_{i-1}, \beta_{i+k+1}]$ 中有奇数个根

已有 $k+1$ 个根，则至少有 $k+2$ 个根

由此可得 $\eta$ 在 $[a,b]$ 中至少存在 $N_Q - 1 \geq n+1$ 个根. 故有
$\eta \equiv 0$. ◻
:::

## Jackson 定理

最小偏差的估计

::: definition
设$f(x)$ 定义于$[a,b]$上, 则
$\omega(t) = \omega(t,f) = \sup_{|x-y|\le t, x,y\in [a,b]} |f(x) - f(y)|$
称为 $f(x)$ 在 $[a,b]$ 上的**连续模**.
:::

::: proposition
1.  若$f(x) \in C[a,b]$ 则 $\omega(t)$是$t$的连续非减函数. 且
    $\lim_{t\to 0} \omega(t) = 0$.

2.  (半可加性) $\forall t_1, t_2 \ge 0$,
    $\omega(t_1 + t_2)  \le \omega(t_1) + \omega(t_2)$.

3.  若$\omega(t) = o(t), t\to 0$, 则$f(x) = const$.
:::

::: definition
若$\omega(t,f) \le M t^\alpha$, $0<\alpha\le 1$, 则称 $f(x)$ 在 $[a,b]$
上 满足 $\alpha$ 阶 Lipschitz 条件. 记作 $f(x) \in \Lip \alpha$.
:::

::: theorem
设$f(x) \in C_{2\pi}$, 则 $E_n(f) \le 12 \omega(\frac{1}{n}, f).$
:::

::: proof
*证明Jackson定理的最佳三角多项式逼近误差估计.*
设$f(x)$为$2\pi$-周期连续函数，其最佳三角多项式逼近的最小偏差定义为：
$$E_n(f) = \inf_{T_n} \max_x |f(x) - T_n(x)|,$$
其中$T_n(x)$为次数不超过$n$的三角多项式。以下是证明的详细步骤：

1.  **构造Jackson核**

    定义Jackson核：
    $$K_n(t) = c_n \left( \frac{\sin(nt/2)}{\sin(t/2)} \right)^4,$$
    其中$c_n$是归一化常数，使得：
    $$\frac{1}{\pi} \int_{-\pi}^{\pi} K_n(t) dt = 1.$$
    该核是次数为$2n-2$的非负三角多项式。

2.  **构造逼近三角多项式**

    通过卷积定义三角多项式：
    $$T_n(x) = \frac{1}{\pi} \int_{-\pi}^{\pi} f(x+t) K_n(t) dt.$$
    由于$K_n(t)$为三角多项式，$T_n(x)$也为次数不超过$2n-2$的三角多项式。

3.  **估计逼近误差**

    对任意$x$，误差为：
    $$|f(x) - T_n(x)| \leq \frac{1}{\pi} \int_{-\pi}^{\pi} |f(x) - f(x+t)| K_n(t) dt.$$
    利用连续模$\omega(t, f)$的性质，将积分分为两部分：

    -   当$|t| \leq \frac{1}{n}$时：
        $$|f(x) - f(x+t)| \leq \omega\left(|t|, f\right) \leq \omega\left(\frac{1}{n}, f\right).$$

    -   当$|t| > \frac{1}{n}$时，利用核的快速衰减性进行估计。

4.  **积分估计与归一化常数**

    通过计算归一化常数$c_n$和积分性质：

    -   归一化常数满足：
        $$\frac{1}{\pi} \int_{-\pi}^{\pi} K_n(t) dt = 1, \quad K_n(t) \geq 0.$$

    -   对于$|t| > \frac{1}{n}$，利用核的估计：
        $$\int_{|t| > 1/n} K_n(t) dt \leq C n^3 \int_{1/n}^{\pi} t^{-4} dt = O(1).$$

5.  **综合误差上界**

    通过积分估计可得：
    $$|f(x) - T_n(x)| \leq 12 \omega\left(\frac{1}{n}, f\right).$$
    因此，存在次数$\leq 2n-2$的三角多项式$T_n(x)$，使得：
    $$E_n(f) \leq \max_x |f(x) - T_n(x)| \leq 12 \omega\left(\frac{1}{n}, f\right).$$

**结论**

通过构造Jackson核并分析逼近误差，我们证明了对于$2\pi$-周期连续函数$f(x)$，其最佳三角多项式逼近满足：
$$\boxed{E_n(f) \leq 12 \omega\left(\frac{1}{n}, f\right)}.$$ ◻
:::

::: corollary
$f\in C_{2\pi}$, 且$f' \in C_{2\pi}$, 则
$E_n (f) \le \frac{12}{n} \|f'\|_\infty$
:::

::: theorem
$f\in C_{2\pi}$, $f^{(r)} \in C_{2\pi}$, 则
$E_n (f) \le \frac{12^{r+1}}{n^r} \omega(\frac{1}{n}, f^{(r)})$.
:::

::: corollary
$f\in C_{2\pi}$, $f^{(r)} \in Lip \alpha$, 则
$E_n(f) \le \frac{12^{r+1}}{n^{r+\alpha}} M$. 定理 (区间)
设$f(x) \in C[-1,1]$, 则$E_n(f) \le 12 \omega(\frac{1}{n},f)$.
:::

::: proof
*Proof.* 对于$\varphi(\theta) = f(\cos \theta)$ 应用 周期函数 Jackson
定理即得. ◻
:::

::: theorem
$f(x) \in C^{(r)}[-1,1]$, 则对于 $n>r$,
$E_n(f) \le \frac{12^{r+1}}{n(n-1)\cdots (n-r+1)} \omega(\frac{1}{n-r}, f^{(r)})$.
:::

::: theorem
$f\in C_{2\pi}$ , 则$E_n(f)\le \frac{3}{2}\omega(\frac{\pi}{n+1})$.
:::

::: proof
*Proof.*

::: corollary
若$k<n$, 则$$\int_0^\pi \sin kx \operatorname{sgn}(\sin(nx)) dx = 0$$
:::

::: proof
*Proof.* 对 $\operatorname{sgn}(\sin(nx))$ 进行傅里叶展开. ◻
:::

::: lemma
$$\min_{\alpha_k \in \mathbb{R}} \int_0^\pi \left|x-\sum_{k=1}^{n-1} \alpha_k \sin kx\right| dx = \frac{\pi^2}{2n}.$$
:::

::: proof
*Proof.*
$$\int_0^\pi \left|x-\sum_{k=1}^{n-1} \alpha_k \sin kx \right| dx \ge \int_0^\pi (x-\sum_{k=1}^{n-1} \alpha_k \sin kx) \operatorname{sgn} (\sin nx) \, dx = \frac{\pi^2}{2n}.$$ ◻
:::

令 $f\in C_{2\pi}$ 定义
$$(L_nf)(x) = \frac{a_0}{2} + \sum_{k=1}^n A_k (a_k \cos kx + b_k \sin kx)$$
其中 $a_k = \frac{1}{\pi} \int_{-\pi}^{\pi} f(s) \cos (ks) ds$,
$b_k = \frac{1}{\pi}\int_{-\pi}^{\pi} f(s) \sin (ks) ds$.

::: lemma
$f\in C_{2\pi}, f'\in C_{2\pi}$, 则
$$(L_n f - f) (x) = \frac{1}{\pi}\int_{-\pi}^{\pi} \left[\frac{1}{2}t + \sum_{k=1}^n \frac{(-1)^k}{k}A_k \sin(kt)\right]f'(x+\pi-t) dt$$
:::

::: proof
*Proof.* ◻
:::

取 $\delta > 0$，

$$\phi(x) = \frac{1}{2\delta} \int_{x-\delta}^{x+\delta} f(t) \, dt$$

则有

$$|\phi'(x)| = \frac{1}{2\delta} |f(x+\delta) - f(x-\delta)| \leq \frac{1}{2\delta} \omega(2\delta)$$

并且

$$|(L_n \phi)(x) - \phi(x)| = \frac{1}{\pi} \left| \int_{-\pi}^{\pi} \left[ \frac{1}{2} t + \sum_{k=1}^n \frac{(-1)^k}{k} A_k \sin kt \right] \phi'(x+t) \, dt \right|$$

$$\leq \frac{\omega(2\delta)}{2\pi\delta} \int_0^\pi \left| t + \sum_{k=1}^n \frac{2(-1)^k}{k} A_k \sin kt \right| \, dt$$

$$\leq \frac{\pi}{4(n+1)\delta} \omega(2\delta)$$

另一方面，

$$|\phi(x) - f(x)| \leq \frac{1}{2\delta} \int_{x-\delta}^{x+\delta} |f(t) - f(x)| \, dt \leq \omega(2\delta)$$

取 $\delta = \frac{\pi}{2(n+1)}$，则有

$$E_n(f) \leq \| L_n \phi - \phi \|_\infty + \| \phi - f \|_\infty$$

$$\leq \frac{3}{2} \omega\left(\frac{\pi}{n+1}\right)$$ ◻
:::

::: remark
更精细的结果为
$E_n(f) \leq \omega\left(\frac{\pi}{n+1}\right)$，并且该结果中常数为最优。
:::

::: example
设
$0 < \varepsilon < \frac{1}{2}$，$h = \frac{\pi}{n+1}$，$\beta \in (0, \frac{2\varepsilon}{(n+1)^2})$，$x_i = ih - (n-i+1)\beta$，$i = 1, \dots, n+1$

则

$$x_{i+1} - x_i = h + \beta, \quad x_{n+1} = \pi$$

则 $\omega(h, f) = 1$，令

$$p(x) = \frac{1}{n+1} \left( \frac{1}{2} + \cos x + \cdots + \cos nx \right)
= \frac{\sin((n+\frac{1}{2})x)}{2(n+1)\sin\frac{x}{2}}$$

则有

$$p(0) = \frac{(n+\frac{1}{2})}{(n+1)}$$

$$p(ih) = (-1)^{i+1} \frac{(n+1)}{(2n+2)}$$

$$\| p' \|_\infty \leq \frac{1}{n+1} (1+2+\cdots+n) = \frac{n}{2}$$

因此

$$|p(x_i) - p(ih)| \leq \frac{n}{2}(n-i+1)\beta \leq \varepsilon$$

于是

$$f(x_i) - p(x_i) = (-1)^{i+1} - \frac{(-1)^{i+1}}{2n+2} + \delta_i, \quad |\delta_i| \leq \varepsilon$$

则有 $f-p$ 在 $[-\pi, \pi]$ 上 $2n+2$ 个点交替取正负值，且

$$\min_i |f(x_i) - p(x_i)| \geq \frac{2n+1}{2n+2} - \varepsilon$$

由之前的定理，$E_n(f) \geq \frac{2n+1}{2n+2} - \varepsilon$.
:::

::: theorem
$f\in C_{2\pi}$, $f' \in C_{2\pi}$, 则
$E_n(f) \le \frac{\pi}{2(n+1)}\|f'\|_\infty$.
:::

::: proof
*Proof.* ◻
:::

::: theorem
若 $f \in C_{2\pi}$，$E_n(f) \leq A n^{-p-\alpha}$，其中
$p \in \mathbb{N}$，$\alpha \in (0, 1)$，则有

$$f', \dots, f^{(p)} \in C_{2\pi} \quad \text{且} \quad f^{(p)} \in \text{Lip } \alpha$$
:::

记
$$B_n(f) = \sum_{k=0}^n f\left(\frac{k}{n}\right) \binom{n}{k} x^k (1-x)^{n-k}$$
为 $f$ 的 Bernstein 多项式。

::: theorem
若 $f(x) \in C[0, 1]$，则有
$$|B_n(f) - f| \leq \frac{3}{2} \omega\left(\frac{1}{\sqrt{n}}\right)$$
:::

::: proof
*Proof.*
$$|B_n(f) - f| = \left| \sum_{k=0}^n \left( f\left(\frac{k}{n}\right) - f(x) \right) \binom{n}{k} x^k (1-x)^{n-k} \right|$$

由连续模性质，

$$\left| f\left(\frac{k}{n}\right) - f(x) \right| \leq \omega\left( \left| \frac{k}{n} - x \right| \right) = \omega\left( \left| \frac{k}{n} - x \right| \sqrt{n} \cdot \frac{1}{\sqrt{n}} \right)$$

因此，

$$|B_n(f) - f| \leq \omega\left(\frac{1}{\sqrt{n}}\right) \left[ 1 + \sqrt{n} \sum_{k=0}^n \left| \frac{k}{n} - x \right| \binom{n}{k} x^k (1-x)^{n-k} \right]$$

由 Hölder 不等式，

$$\left[ \sum_{k=0}^n \left| \frac{k}{n} - x \right| \binom{n}{k} x^k (1-x)^{n-k} \right]^2 \leq \left[ \sum_{k=0}^n \left( \frac{k}{n} - x \right)^2 \binom{n}{k} x^k (1-x)^{n-k} \right] \left[ \sum_{k=0}^n \binom{n}{k} x^k (1-x)^{n-k} \right]$$

$$= \frac{x(1-x)}{n} \leq \frac{1}{4n}$$

由此可证

$$|B_n(f) - f| \leq \frac{3}{2} \omega\left(\frac{1}{\sqrt{n}}\right)$$ ◻
:::

::: corollary
若 $f(x) \in \text{Lip } \alpha$，$0 < \alpha \leq 1$，则

$$|B_n(f) - f| \leq \frac{3M}{2n^{\alpha/2}}$$
:::

另一方面，令 $f(x) = x^2$，则有

$$B_n(f) = \sum_{k=0}^n \left( \frac{k}{n} \right)^2 \binom{n}{k} x^k (1-x)^{n-k} = x^2 + \frac{1}{n} x(1-x)$$

该例子表明 $B_n(f)$ 的逼近阶不可能高于 $\frac{1}{n}$.
