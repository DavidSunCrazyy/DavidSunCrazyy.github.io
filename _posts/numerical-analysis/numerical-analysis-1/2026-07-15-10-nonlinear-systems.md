---
note: true
layout: post
title: "数值分析（十）：非线性方程组迭代方法——Newton法与拟Newton法"
permalink: /posts/numerical-analysis-1/10-nonlinear-systems/
categories: numerical-analysis
tags: [numerical-analysis, nonlinear-systems, broyden, quasi-newton]
use_math: true
---

本文介绍非线性方程组的迭代求解方法，包括 $\mathbb{R}^n$ 上的压缩映射原理、Newton 法的局部收敛性与超线性/二次收敛性，以及拟 Newton 法（Broyden 秩1方法）和 Sherman-Morrison 公式的应用。

设 $F: D \subset  {\mathbb{R}}^{n} \rightarrow  {\mathbb{R}}^{n}$ ,把方程组 $F\left( x\right)  = 0$ 改写成

等价的不动点形式

$$
x = \Phi (x)
$$

$\Phi : D \subset \mathbb{R}^{n} \rightarrow \mathbb{R}^{n}$ 为连续函数.

相应的构造不动点迭代

$$
x ^ {k + 1} = \Phi (x ^ {k})
$$

定义 5.4.1 设 $\Phi: D \subset \mathbb{R}^{n} \to \mathbb{R}^{n}$ ，若存在 $L \in (0,1)$ 使得

$$
\| \Phi (y) - \Phi (x) \| \leq L \| x - y \|, \quad \forall x, y \in D _ {0} \subset D
$$

则称 $\Phi$ 在 $D_{0}$ 上是一个压缩映射

定理 5.4.1 设 $\Phi: D \subset \mathbb{R}^{n} \rightarrow \mathbb{R}^{n}$ ，如果 $\Phi$ 在凸域 $D_{0} \subset D$ 可导

$\Phi(x) = (\varphi_{1}(x), \varphi_{2}(x), \cdots, \varphi_{n}(x))^{\mathrm{T}}$ 满足 存在 $L \in (0,1)$

$$
\left| \frac {\partial \varphi_ {i} (x)}{\partial x _ {j}} \right| \leq \frac {L}{n}, \quad \forall x \in D _ {0}
$$

则 $\Phi$ 在 $D_{0}$ 上对 $\infty$ 范数是压缩的.

证明： $\forall x,y\in D_{0}$ 由微分中值定理

$$
\begin{array}{r l} {\Phi (y) - \Phi (x)} & {= \left[ \begin{array}{l} {\nabla \varphi_ {1} (x + \xi_ {1} h)} \\ {\nabla \varphi_ {2} (x + \xi_ {2} h)} \\ {\vdots} \\ {\nabla \varphi_ {n} (x + \xi_ {n} h)} \end{array} \right]} \end{array}
$$

其中 $h = y - x,\; \xi_i \in (0,1),\;i = 1,2,\cdots,n$

$$
令 \quad A = [ a _ {i j} ] \in \mathbb {R} ^ {n \times n}, \quad a _ {i j} = \frac {\partial \varphi_ {i} (x + \xi_ {i} h)}{\partial x _ {j}}
$$

因为 $D_{0}$ 是凸集，所以 $x + \xi_{i}h \in D_{0}$ ， $i = 1,2,\dots,n$

$$
\| A \| _ {\infty} = \max _ {1 \leq i \leq n} \left(\sum_ {j = 1} ^ {n} \left| \frac {\partial \varphi_ {i} (x + \xi_ {i} h)}{\partial x _ {j}} \right|\right) \leq n \cdot \frac {L}{n} = L
$$

所以

$$
\| \Phi (y) - \Phi (x) \| _ {\infty} \leq \| A \| _ {\infty} \| y - x \| _ {\infty} \leq L \| y - x \| _ {\infty}
$$

定理 5.4.2 $\Phi$: $D \subset \mathbb{R}^{n} \to \mathbb{R}^{n}$ , 在闭集 $D_{0} \subset D$ 中压缩且 $\Phi(x) \in D_{0}, \forall x \in D_{0}$

则 $\Phi$ 在 $D_0$ 中存在唯一的不动点 $x^*$ ，且对任意

$x^{0} \in D_{0}$ ，不动点迭代收敛到 $x^{*}$ ，并

$$
\| x ^ {k} - x ^ {k} \| \leq \frac {1}{1 - L} \| x ^ {k + 1} - x ^ {k} \| \leq \frac {L ^ {k}}{1 - L} \| x ^ {1} - x ^ {0} \|
$$

证明: $\forall x^{0} \in D$ 。因为 $\Phi$ 把 $D_{0}$ 映为自身, 所以有

${x}^{k} \in  {D}_{0}$ 并且

$$
\| x ^ {k + 1} - x ^ {k} \| = \| \Phi (x ^ {k}) - \Phi (x ^ {k - 1}) \| \leq L \| x ^ {k} - x ^ {k - 1} \|
$$

$$
\Rightarrow \left\| x ^ {k + 1} - x ^ {k} \right\| \leq L ^ {k} \left\| x ^ {1} - x ^ {0} \right\|
$$

$$
\begin{array}{r l} {\| x ^ {k + p} - x ^ {k} \| \leq \sum_ {j = 1} ^ {p} \| x ^ {k + j} - x ^ {k + j - 1} \|} \\ & {\leq (L ^ {p - 1} + \dots + L + 1) \| x ^ {k + 1} - x ^ {k} \|} \\ & {\leq \frac {1}{1 - L} \| x ^ {k + 1} - x ^ {k} \| \leq \frac {L ^ {k}}{1 - L} \| x ^ {1} - x ^ {0} \|} \end{array}
$$

由此可得 $\{x^{k}\}$ 为 Cauchy 列 所以存在

$x^{*} \in \mathbb{R}^{n}$ , 使得 $\lim _{k \to \infty} x^{k} = x^{*}$

又因为 $D_0$ 为闭集，有 $x^* \in D_0$ 。且

$$
x ^ {*} = \lim _ {k \to \infty} x ^ {k} = \lim _ {k \to \infty} \Phi (x ^ {k - 1}) = \Phi (x ^ {*})
$$

$\Phi$ 连续

定义 5.4.2 $\Phi$: $D \subset \mathbb{R}^{n} \to \mathbb{R}^{n}$ , $x^{*}$ 为 $\Phi$ 的一个不动点, 若存在 $x^{*}$ 的一个邻域 $S \subset D$ , 对一切 $x^{0} \in S$ 迭代法产生的序列 $\{x^{k}\} \subset S$ , $\lim _{k \to \infty} x^{k} = x^{*}$ , 则称迭代法局部收敛

定义 5.4.3. 设向量序列 $\{x^{k}\}$ 收敛于 $x^{*}$ ，若存在 $P \geq 1$ 及 C > 0

使

$$
\lim _ {k \to \infty} \frac {\| x ^ {k + 1} - x ^ {*} \|}{\| x ^ {k} - x ^ {*} \| ^ {p}} = c
$$

则称 $\{x^{k}\}$ P 阶收敛

若存在 $p \geq 1$ 及 $c > 0$ , 以及整数 $k > 0$ , 使得当 $k > k$ 时 ${\left\| {x}^{k + 1} - {x}^{ * }\right\| } \leq  C{\left\| {x}^{k} - {x}^{ * }\right\| }^{p}$

则称 $\{x^{k}\}$ 至少 P 阶收敛

定理 5.4.3 设 $\Phi$: $D \subset \mathbb{R}^{n} \to \mathbb{R}^{n}$ , $x^{*} \in D$ 是 $\Phi$ 的不动点.

且 $\Phi$ 在 $x^{*}$ 可导满足

$$
\rho (\Phi^ {\prime} (x ^ {*})) = \sigma <   1
$$

则存在开球 $S = S(x^{*}, s) \subset D$ ， $\forall x^{0} \in S$ ，迭代法产生的序列 $\{x^{k}\}$ 收敛到 $x^{*}$

## 5. 方程组的 Newton 法和拟 Newton 法

考虑方程组 $F(x)=0$

已知 $x^{k}$ 是一个近似解. 由一阶 Taylor 近似

$$
0 = F (x ^ {*}) \approx F (x ^ {k}) + F ^ {\prime} (x ^ {k}) (x ^ {*} - x ^ {k})
$$

由此解得新的近似解，记为 $x^{k+1}$

$$
x ^ {k + 1} = x ^ {k} - \left(F ^ {\prime} (x ^ {k})\right) ^ {- 1} F (x ^ {k})
$$

定理 5.5.1 设 $F: D \subset \mathbb{R}^n \to \mathbb{R}^n$ , $x^* \in D$ 满足 $F(x^*) = 0$

在 $x^{*}$ 的开邻域 $S_{0} \subset D$ , $F$ 可导, $F'(x)$ 连续且 $F'(x^{*})$ 可逆则

(1) 存在闭球 $B(x^{*}, \delta) \subset S$ 。使得 Newton 迭代对 $\forall x \in B(x^{*}, \delta)$ 有意义

(2) Newton 法产生的序列 $\{x^{k}\}$ 局部收敛于 $x^{*}$ ，且是超线性收敛

(3) 若存在 $\gamma > 0$ 使得

$$
\| F ^ {\prime} (x) - F ^ {\prime} (x ^ {*}) \| \leq \gamma \| x - x ^ {*} \|, \quad \forall x \in S
$$

则 $\{x^{k}\}$ 至少平方收敛

证明：(1) 因为 ${F}^{\prime }\left( {x}^{ * }\right)$ 可逆,令 $\alpha  = \|{F}^{\prime }\left( {x}^{ * }\right) ^{-1}\|$

$F'(x)$ 在 $x^{*}$ 处连续，存在 $\delta > 0$

$\forall x \in B(x^{*}, \delta) \subset S_{0} \text{ 有}$

$$
\| F ^ {\prime} (x) - F ^ {\prime} (x ^ {*}) \| <   \frac {1}{2 \alpha}
$$

所以有 $F'(x)$ 可逆且

$$
\| F ^ {\prime} (x) ^ {- 1} \| \leq \frac {\alpha}{1 - \frac {\alpha}{2 \alpha}} = 2 \alpha , \quad \forall x \in B (x ^ {*}, \delta)
$$

$$
\begin{array}{r l} & {(2) \quad | | x ^ {k + 1} - x ^ {*} | |} \\ & {= | | F ^ {\prime} (x ^ {k}) ^ {- 1} (F (x ^ {k}) + F ^ {\prime} (x ^ {k}) (x ^ {*} - x ^ {k})) | |} \\ & {\leq 2 \alpha | | F (x ^ {*}) - F (x ^ {k}) - F ^ {\prime} (x ^ {k}) (x ^ {*} - x ^ {k}) | |} \\ & {= 2 \alpha | | F (x ^ {*}) - F (x ^ {k}) - F ^ {\prime} (x ^ {*}) (x ^ {*} - x ^ {k}) + (F ^ {\prime} (x ^ {*}) - F ^ {\prime} (x ^ {k})) (x ^ {*} - x ^ {k}) | |} \\ & {\leq 2 \alpha | | F (x ^ {k}) - F (x ^ {*}) - F ^ {\prime} (x ^ {*}) (x ^ {k} - x ^ {*}) | | + 2 \alpha | | F ^ {\prime} (x ^ {*}) - F ^ {\prime} (x ^ {k}) | | | x ^ {k} - x ^ {*} | |} \end{array}
$$

由于 $F'(x^{*})$ 存在 $\forall \varepsilon > 0, \exists \delta_{1}(\varepsilon) > 0$ 使得 $\forall x \in B(x^{*}, \delta_{1}(\varepsilon))$

$$
\| F (x) - F (x ^ {*}) - F ^ {\prime} (x ^ {*}) (x - x ^ {*}) \| \leq \varepsilon \| x - x ^ {*} \|
$$

由 $F'(x)$ 在 $x^*$ 的连续性 $\exists \delta_2(\varepsilon) > 0$ 使得 $\forall x \in B(x^*, \delta_2(\varepsilon))$

$$
\| F ^ {\prime} (x) - F ^ {\prime} (x ^ {*}) \| \leq \varepsilon
$$

取 $\varepsilon=\frac{1}{8\alpha}$ , $\tilde{\delta}=\min\left\{\delta_{1}\left(\frac{1}{8\alpha}\right),\delta_{2}\left(\frac{1}{8\alpha}\right)\right\}$

若 $x^{k} \in B(x^{*}, \tilde{\delta})$ 有

$$
\| x ^ {k + 1} - x ^ {*} \| \leq \frac {1}{2} \| x ^ {k} - x ^ {*} \|
$$

由此可得 $\{x^{k}\}$ 局部收敛，即 $\lim_{k\to\infty}x^{k}=x^{*}$

则 $\forall \varepsilon > 0,\exists N > 0$ 使得 $\forall k > N$ 有

$$
\| x ^ {k} - x ^ {*} \| <   \min \left\{\delta_ {1} (\frac {\varepsilon}{4 \alpha}), \delta_ {2} (\frac {\varepsilon}{4 \alpha}) \right\}
$$

$$
\| x ^ {k + 1} - x ^ {*} \| \le \varepsilon \| x ^ {k} - x ^ {*} \|
$$

$\Rightarrow  \lim _{k \to  \infty }\frac{\left| {\left| {x}^{k + 1} - {x}^{ * }\right| }\right| }{\left| {\left| {x}^{k} - {x}^{ * }\right| }\right| } = 0$

即 $\{x^{k}\}$ 超线性收敛

(3) 令 $g(t) = F(x^* + t(x^k - x^*))$ , $t \in [0,1]$ $g'(t) = F'(x^* + t(x^k - x^*)) (x^k - x^*)$ , $t \in [0,1]$

且

$$
\begin{array}{r l} {\| g ^ {\prime} (t) - g ^ {\prime} (0) \| \leq \| F ^ {\prime} (x ^ {*} + t (x ^ {k} - x ^ {*})) - F ^ {\prime} (x ^ {*}) \| \| x ^ {k} - x ^ {*} \|} \\ {\leq \gamma_ {t} \| x ^ {k} - x ^ {*} \| ^ {2}} \end{array}
$$

从而有

$$
\begin{array}{r l} & {\| F (x ^ {k}) - F (x ^ {*}) - F ^ {\prime} (x ^ {*}) (x ^ {k} - x ^ {*}) \|} \\ & {= \| g (1) - g (0) - g ^ {\prime} (0) \|} \\ & {= \| \int_ {0} ^ {1} g ^ {\prime} (t) - g ^ {\prime} (0) d t \|} \\ & {\leq \int_ {0} ^ {1} \| g ^ {\prime} (t) - g ^ {\prime} (0) \| d t} \\ & {\leq \int_ {0} ^ {1} \gamma t \| x ^ {k} - x ^ {*} \| ^ {2} d t = \frac {1}{2} \gamma \| x ^ {k} - x ^ {*} \| ^ {2}} \end{array}
$$

由此可得

$$
\begin{array}{r l} {\| x ^ {k + 1} - x ^ {*} \| \leq \alpha \gamma \| x ^ {k} - x ^ {*} \| ^ {2} + 2 \alpha \gamma \| x ^ {k} - x ^ {*} \| ^ {2}} \\ {= 3 \alpha \gamma \| x ^ {k} - x ^ {*} \| ^ {2}} \end{array}
$$

所以 $\{x^{k}\}$ 至少二阶收敛

### 拟 Newton 法

令

$$
x ^ {k + 1} = x ^ {k} - A _ {k} ^ {- 1} F (x ^ {k})
$$

其中 $A_{k}$ 是 $F'(x^{k})$ 的近似

${A}_{k + 1}$ 满足下面的条件

$$
A _ {k + 1} = A _ {k} + \Delta A _ {k}
$$

$$
A _ {k + 1} (x ^ {k + 1} - x ^ {k}) = F (x ^ {k + 1}) - F (x ^ {k})
$$

想法：取 $\Delta A_{k}$ 为满足上述约束中 Frobenius 范数最小的. 即

$$
\Delta A _ {k} = \underset {A \in Q} {\operatorname{argmin}} \| A \| _ {F}
$$

$$
Q = \{A \in \mathbb {R} ^ {n \times n}: (A _ {k} + A) p ^ {k} = q ^ {k} \}
$$

$$
p ^ {k} = x ^ {k + 1} - x ^ {k}, \quad q ^ {k} = F (x ^ {k + 1}) - F (x ^ {k})
$$

考虑 优化问题

$$
\min _ {A \in \mathbb {R} ^ {n \times n}} \| A \| _ {F}, \quad \text {   s.t.   } A p ^ {k} = \tilde {q} ^ {k} = q ^ {k} - A _ {k} p ^ {k}
$$

最优解为 $A = \left( q^{k} - A_{k} p^{k} \right) ( p^{k})^{T} / \| p^{k} \|_{2}^{2}$

解满足 $\operatorname{rank}(A)=1$

由此可得Broyden 秩 1 方法：

$$
x ^ {k + 1} = x ^ {k} - A _ {k} ^ {- 1} F (x ^ {k})
$$

$$
p ^ {k} = x ^ {k + 1} - x ^ {k}, \quad q ^ {k} = F (x ^ {k + 1}) - F (x ^ {k})
$$

$$
A _ {k + 1} = A _ {k} + \frac {(q ^ {k} - A _ {k} p ^ {k}) (p ^ {k}) ^ {T}}{\| p ^ {k} \| _ {2} ^ {2}}
$$

引理 5.5.1 (Sherman - Morrison 公式) $A \in \mathbb{R}^{n \times n}$

A 非奇异， $u, v \in \mathbb{R}^{n}$ 当且仅当

$1 + {v}^{T}{A}^{-1}u \neq  0$ 时 $A + {uv}^{T}$ 可逆,并且

$$
(A + u v ^ {T}) ^ {- 1} = A ^ {- 1} - \frac {A ^ {- 1} u v ^ {T} A ^ {- 1}}{1 + v ^ {T} A ^ {- 1} u}
$$

更一般地有 Woodbury 公式

$$
(A + U C V ^ {T}) ^ {- 1} = A ^ {- 1} - A ^ {- 1} U (C ^ {- 1} + V ^ {T} A ^ {- 1} U) ^ {- 1} V ^ {T} A ^ {- 1}
$$

利用 Sherman - Morrison 公式可得

逆Broyden 秩1方法

$$
x ^ {k + 1} = x ^ {k} - B _ {k} F (x ^ {k})
$$

$$
p ^ {k} = x ^ {k + 1} - x ^ {k}, \quad q ^ {k} = F (x ^ {k + 1}) - F (x ^ {k})
$$

$$
B _ {k + 1} = B _ {k} + \frac {(p ^ {k} - B _ {k} q ^ {k}) (p ^ {k}) ^ {T} B _ {k}}{(p ^ {k}) ^ {T} B _ {k} q ^ {k}}
$$

[← 上一篇：Newton迭代法](/posts/numerical-analysis-1/09-newton-method/)

[下一篇：幂法 →](/posts/numerical-analysis-1/11-power-method/)
