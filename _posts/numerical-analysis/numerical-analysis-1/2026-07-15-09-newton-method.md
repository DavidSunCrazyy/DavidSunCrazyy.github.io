---
note: true
layout: post
title: "数值分析（九）：Newton迭代法与割线法"
permalink: /posts/numerical-analysis-1/09-newton-method/
categories: numerical-analysis
tags: [numerical-analysis, newton-method, secant-method]
use_math: true
---

本文介绍求解非线性方程的 Newton 迭代法和割线法，包括 Newton 法的二阶收敛性、重根情形的处理、以及割线法的超线性收敛性（收敛阶为黄金比例 $(1+\sqrt{5})/2$）。

## 3. Newton 迭代法和割线法

求解方程 $f(x)=0$ ，设已有近似值 $x_{k}$

由 Taylor 展开得

$$
0 = f (x ^ {*}) \approx f (x _ {k}) + f ^ {\prime} (x _ {k}) (x ^ {*} - x _ {k})
$$

由此解得 $x^{*}$ 的近似值作为 $x_{k+1}$

$$
x _ {k + 1} = x _ {k} - \frac {f (x _ {k})}{f ^ {\prime} (x _ {k})}
$$

(5.3.1)

相应的迭代函数为

$$
\varphi (x) = x - \frac {f (x)}{f ^ {\prime} (x)}
$$

定理 5.3.1. 设 $f(x^{*})=0$ , $f'(x^{*})\neq0$ , 且 f 在 $x^{*}$ 的邻域上有二阶连续导数, 则 Newton 迭代法局部收敛到 $x^{*}$ 且至少二阶收敛

$$
\lim _ {k \to \infty} \frac {x _ {k + 1} - x ^ {*}}{(x _ {k} - x ^ {*}) ^ {2}} = \frac {f ^ {\prime \prime} (x ^ {*})}{2 f ^ {\prime} (x ^ {*})}
$$

证明：由于 $f$ 有二阶连续导数，所以 $\varphi'$ 存在

且连续，且有

$$
\varphi (x ^ {*}) = x ^ {*}, \quad \varphi^ {\prime} (x ^ {*}) = 0
$$

所以 Newton 迭代局部收敛

由 Taylor 展开可得

$$
0 = f (x ^ {*}) = f (x _ {k}) + f ^ {\prime} (x _ {k}) (x ^ {*} - x _ {k}) + \frac {f ^ {\prime \prime} (\xi_ {k})}{2} (x ^ {*} - x _ {k}) ^ {2}
$$

$$
0 = f (x _ {k}) + f ^ {\prime} (x _ {k}) (x _ {k + 1} - x _ {k})
$$

$\Rightarrow$

$$
\frac {x _ {k + 1} - x ^ {*}}{(x _ {k} - x ^ {*}) ^ {2}} = \frac {f ^ {\prime \prime} (\xi _ {k})}{2 f ^ {\prime} (x _ {k})}
$$

$$
\Rightarrow \lim _ {k \to \infty} \frac {x _ {k + 1} - x ^ {*}}{(x _ {k} - x ^ {*}) ^ {2}} = \frac {f ^ {\prime \prime} (x ^ {*})}{2 f ^ {\prime} (x ^ {*})}
$$

\- 重根情形

$$
f (x) = (x - x ^ {*}) ^ {m} g (x)
$$

$m > 1,\;g(x^{*})\neq0,\;g$ 有二阶导数.

$$
\varphi (x) = x - \frac {f (x)}{f ^ {\prime} (x)} = x - \frac {(x - x ^ {*}) g (x)}{m g (x) + (x - x ^ {*}) g ^ {\prime} (x)}
$$

$$
\varphi^ {\prime} (x ^ {*}) = 1 - \frac {1}{m}
$$

此时 Newton 法局部线性收敛.

方法 1.

$$
\varphi (x) = x - \frac {m f (x)}{f ^ {\prime} (x)}
$$

$$
\varphi (x ^ {*}) = x ^ {*}, \quad \varphi^ {\prime} (x ^ {*}) = 0.
$$

则迭代法

$$
x _ {k + 1} = x _ {k} - \frac {m f (x _ {k})}{f ^ {\prime} (x _ {k})}
$$

至少二阶收敛.

方法2. 令 $\mu(x) = \frac{f(x)}{f'(x)}$

$$
\mu (x) = (x - x ^ {*}) \frac {g (x)}{m g (x) + (x - x ^ {*}) g ^ {\prime} (x)}
$$

则 $x^{*}$ 是 $\mu(x)=0$ 的单根. 使用 Newton 法

$$
\varphi (x) = x - \frac {\mu (x)}{\mu^ {\prime} (x)} = x - \frac {f (x) f ^ {\prime} (x)}{[ f ^ {\prime} (x) ] ^ {2} - f (x) f ^ {\prime \prime} (x)}
$$

由此得到的迭代法 至少二阶收敛.

\- 割线法

采用差商近似导数即

$$
f ^ {\prime} (x _ {k}) \approx \frac {f (x _ {k}) - f (x _ {k - 1})}{x _ {k} - x _ {k - 1}}
$$

Newton 法变为

$$
x _ {k + 1} = x _ {k} - \frac {f (x _ {k}) (x _ {k} - x _ {k - 1})}{f (x _ {k}) - f (x _ {k - 1})}
$$

定理 5.3.2. 设 $f(x^{*}) = 0$ , 在区间 $\Delta = [x^{*} - \delta, x^{*} + \delta]$

$f'(x) \neq 0$ 且 $f \in C^{2}(\Delta)$ ，设 $M\delta < 1$ 其中

$$
M = \frac {\max _ {x \in \Delta} | f ^ {\prime \prime} (x) |}{2 \min _ {x \in \Delta} | f ^ {\prime} (x) |}
$$

则当 $x_0, x_1 \in \Delta$ 时，割线法按 $P = \frac{1}{2}(1 + \sqrt{5})$ 收敛到

$x^{*}$ .

证明：设 ${x}_{k - 1},{x}_{k} \in  \Delta$ ,令

$$
P _ {1} (x) = f (x _ {k}) \frac {x - x _ {k - 1}}{x _ {k} - x _ {k - 1}} + f (x _ {k - 1}) \frac {x - x _ {k}}{x _ {k - 1} - x _ {k}}
$$

$$
R (x) = P _ {1} (x) - f (x), E (t) = R (t) - \frac {R (x ^ {*})}{(x ^ {*} - x _ {k - 1}) (x ^ {*} - x _ {k})} (t - x _ {(k - 1)}) (t - x _ {k})
$$

则有

$$
E (x ^ {*}) = 0, \quad E (x _ {k - 1}) = R (x _ {k - 1}) = 0, \quad E (x _ {k}) = R (x _ {k}) = 0
$$

根据微分中值定理有存在 $\xi$ 在 $x^{*}, x_{k-1}, x_{k}$ 之间有

$$
E ^ {\prime \prime} (\xi) = - f ^ {\prime \prime} (\xi) - 2 \frac {R (x ^ {*})}{(x ^ {*} - x _ {k - 1}) (x ^ {*} - x _ {k})} = 0
$$

$$
\Rightarrow R (x ^ {*}) = - \frac {1}{2} f ^ {\prime \prime} (\xi) (x ^ {*} - x _ {k - 1}) (x ^ {*} - x _ {k})
$$

$$
\Rightarrow P _ {1} (x ^ {*}) = - \frac {1}{2} f ^ {\prime \prime} (\xi) (x ^ {*} - x _ {k - 1}) (x ^ {*} - x _ {k})
$$

另一方面

$$
\begin{array}{r l} {P _ {1} (x ^ {*})} & {= P _ {1} (x ^ {*}) - P _ {1} (x _ {k + 1})} \\ & {= \frac {f (x _ {k}) - f (x _ {k - 1})}{x _ {k} - x _ {k - 1}} (x ^ {*} - x _ {k + 1})} \\ & {= f ^ {\prime} (\eta) (x ^ {*} - x _ {k + 1})} \end{array}
$$

其中 $\eta$ 在 $x_{k}, x_{k-1}$ 之间

$$
x ^ {*} - x _ {k + 1} = - \frac {1}{2} \frac {f ^ {\prime \prime} (\xi)}{f ^ {\prime} (\eta)} (x ^ {*} - x _ {k - 1}) (x ^ {*} - x _ {k})
$$

$$
|e _ {k + 1}| = \left| \frac {f ^ {\prime \prime} (\xi)}{2 f ^ {\prime} (\eta)} \right| |e _ {k}| |e _ {k - 1}|
$$

$$
\le M e _ {k} e _ {k - 1} \le M \delta \cdot \delta <   \delta
$$

$$
x _ {k + 1} \in \Delta \quad \mathrm{且}
$$

$$
e _ {k} \leq (M \delta) ^ {k} \delta \rightarrow 0
$$

$$
\Rightarrow \lim _ {k \to \infty} x _ {k} = x ^ {*}
$$

关于收敛阶，仅给出启发式分析

当 $k \to +\infty$ 时有

$$
e _ {k + 1} = c e _ {k} e _ {k - 1}, \quad c = \left| \frac {f ^ {\prime \prime} (x ^ {*})}{2 f ^ {\prime} (x ^ {*})} \right|
$$

$$
\mathrm{令} E _ {k} = C e _ {k} \quad \mathrm{则有}
$$

$$
\begin{array}{r l} {E _ {k + 1}} & {= E _ {k} E _ {k - 1}} \\ {\Rightarrow} & {P _ {k + 1} = P _ {k} + P _ {k - 1}, \qquad P _ {k} = \ln E _ {k}} \end{array}
$$

$$
\Rightarrow P _ {k} = c _ {1} \lambda_ {1} ^ {k} + c _ {2} \lambda_ {2} ^ {k}
$$

$$
\lambda_ {1} = \frac {1 + \sqrt {5}}{2}, \quad \lambda_ {2} = \frac {1 - \sqrt {5}}{2}
$$

$$
\Rightarrow \quad e _ {k} \approx \quad e ^ {G \lambda_ {1} ^ {k}}
$$

$\Rightarrow$ 收敛阶数为 ${\lambda }_{1} = \frac{1 + \sqrt{5}}{2}$

[← 上一篇：不动点迭代一般概念](/posts/numerical-analysis-1/08-fixed-point-iteration/)

[下一篇：非线性方程组迭代方法 →](/posts/numerical-analysis-1/10-nonlinear-systems/)
