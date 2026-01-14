---
layout: post
title: "Numerical Analysis II 高维分片多项式逼近"
permalink: /posts/numerical-analysis-2-04-高维分片多项式逼近/
tags: numerical-analysis
use_math: true
---

# 高维（二维）分片多项式逼近

## 有限元空间（分片多项式空间）

有限元空间有以下要求：

(1) 对区域 $\overline{\Omega}$ 作剖分 $\mathcal{T}_h$，满足：

-   $\overline{\Omega} = \bigcup_{K \in \mathcal{T}_h} K$

-   $K \neq \emptyset$, $\forall K \in \mathcal{T}_h$

-   $\forall K_1, K_2 \in \mathcal{T}_h$, $K_1 \neq K_2$ 有
    $K_1^o \cap K_2^o = \emptyset$

-   $\forall K \in \mathcal{T}_h$, $\partial K$ Lipschitz 连续.

(2) $\forall K \in \mathcal{T}_h$, $V_h$ 限制在 $K$ 上为多项式.

(3) $V_h$ 有一组支集 "小"的基.

### 一维有限元空间

$\Omega = (a, b)$，剖分 $\Omega$: $a = x_0 < x_1 < \cdots < x_N = b$

-   线性元
    $$V_h = \left\{ v \in C_0(\overline{\Omega}) : v|_{[x_{i-1}, x_i]} \text{ 为一次多项式 } \right\}_{i=1,\dots,N}$$
    基函数为： $$\varphi_i(x) =
            \begin{cases}
                \dfrac{x - x_{i-1}}{x_i - x_{i-1}}, & x \in [x_{i-1}, x_i] \\
                \dfrac{x_{i+1} - x}{x_{i+1} - x_i}, & x \in [x_i, x_{i+1}] \\
                0, & \text{else}
            \end{cases}$$ $i = 1, 2, \dots, N-1$

-   二次元
    $$V_h = \left\{ v \in C_0(\overline{\Omega}) : v|_{[x_{i-1}, x_i]} \text{ 为二次多项式 } \right\}_{i=1,\dots,N}$$
    在区间 $[x_{i-1}, x_i]$ 上插值节点取为 $x_{i-1}$,
    $\frac{1}{2}(x_{i-1} + x_i)$, $x_i$. 插值条件为 $$\begin{aligned}
            I(f)(x_{i-1}) &= f(x_{i-1}) \\
            I(f)(x_i) &= f(x_i) \\
            I(f)\left(\frac{1}{2}(x_{i-1} + x_i)\right) &= f\left(\frac{1}{2}(x_{i-1} + x_i)\right)

    \end{aligned}$$

-   三次 Hermite 元
    $$V_h = \left\{ v \in C_0^1(\overline{\Omega}) : v|_K \text{ 为三次多项式, } K \in \mathcal{T}_h \right\}$$
    插值节点取为三个顶点及重心. 插值条件为 $$\begin{aligned}
            I(f)(x_{i-1}) &= f(x_{i-1}), \quad I(f)(x_i) = f(x_i) \\
            I(f)'(x_{i-1}) &= f'(x_{i-1}), \quad I(f)'(x_i) = f'(x_i)

    \end{aligned}$$

![一维有限元的基函数示意图](images/一位有限元.png){width="80%"}

### 二维有限元空间

首先对区域 $\Omega$ 进行三角剖分，此时每个单元为三角形.

![二维有限元的三角形单元示意图](images/二维有限元.png){width="80%"}

-   线性元
    $$V_h = \left\{ v \in C_0(\Omega) : v|_K \text{ 为一次多项式 } \right\}$$
    插值节点取为三角形的顶点，插值条件为函数值（Lagrange 插值）

-   二次元 插值节点取为三个顶点及三条边的中点，插值条件为 Lagrange 插值

-   三次元 插值节点取为三个顶点、三等分点及重心，插值条件为 Lagrange
    插值

-   三次 Hermite 型单元
    $$V_h = \left\{ v \in C_0^1(\Omega) : v|_K \text{ 为三次多项式, } K \in \mathcal{T}_h \right\}$$
    插值节点取为三个顶点及重心.

    **插值条件为：**

    $$\begin{cases}
        \mathcal{I}(f)(A_i) = f(A_i) \\
        \frac{\partial}{\partial x}(\mathcal{I}(f))(A_i) = \frac{\partial f}{\partial x}(A_i) \\
        \frac{\partial}{\partial y}(\mathcal{I}(f))(A_i) = \frac{\partial f}{\partial y}(A_i) & i = 1, 2, 3 \\
        \mathcal{I}(f)(C) = f(C)
    \end{cases}$$

-   双线性矩形单元

    $$V_h = \left\{ v \in C_0(\Omega) : v|_K \text{ 上为双线性多项式 } \right\}$$

    双线性函数有 4 个自由度： $$1, x, y, xy$$

    插值节点取为矩形单元的 4 个顶点，插值类型为 Lagrange 插值。

-   双二次矩形单元

    $$V_h = \left\{ v \in C_0^1(\Omega) : v|_K \text{ 上为双二次多项式 } \right\}$$

    双二次函数有 9 个自由度：
    $$1, x, y, x^2, xy, y^2, x^2y, xy^2, x^2y^2$$

    插值节点取为 4 个顶点、4 条边的中点、重心，插值类型为 Lagrange
    插值。

-   不完全双二次矩形单元

    将双二次函数的基函数 $x^2y^2$
    去掉，可以减少一个自由度，同时不影响对二次多项式的精确表示。

    插值节点取为 4 个顶点、4 条边的中点、重心，插值类型为 Lagrange
    插值。

-   双三次 Hermite 矩形单元

    $$V_h = \left\{ v \in C_0^1(\Omega) : v|_K \text{ 上为双三次多项式 } \right\}$$

    双三次多项式有 16 个自由度。

    插值节点取为 4 个顶点，每个顶点上的插值条件为：
    $$f(A_i), \quad \frac{\partial f}{\partial x}(A_i), \quad \frac{\partial f}{\partial y}(A_i), \quad \frac{\partial^2 f}{\partial x \partial y}(A_i), \quad i = 1, 2, 3, 4.$$

## Sobolev 空间插值

**Definition**
一个三元组 $(K, P_k, \Sigma_k)$ 称为一个有限元，如果

1.  $K \subset \mathbb{R}^n$ 为闭集，$\partial K$ Lipschitz 连续.

2.  $P_k$ 是定义在 $K$ 上的光滑函数构成的有限维空间（一般取多项式）.

3.  $\Sigma_k$ 是一组定义在 $C^\infty(K)$ 上的线性无关的线性泛函
    $\{\varphi_i\}_{i=1}^N$，称为自由度，且
    $\varphi_1, \dots, \varphi_N$ 构成了 $P_k$ 的一组对偶基。定义了
    $P_k$ 上的一组规范化基底，即存在 $P_1, \dots, P_N$ 使得
    $$\varphi_i(P_j) = \delta_{ij} =
       \begin{cases}
           0, & i \neq j \\
           1, & i = j
       \end{cases}$$
:::

**Definition**
设 $(K, P_k, \Sigma_k)$
为一给定的有限元。$\{\varphi_1, \dots, \varphi_N\}$
为自由度集，$\{P_1, \dots, P_N\}$ 为 $P_k$ 相应的基，即
$$\varphi_i(P_j) = \delta_{ij}.$$ 定义 $$\Pi_K: C^\infty(K) \to P_k,$$
$$\Pi_K(v) = \sum_{i=1}^N \varphi_i(v) P_i, \quad \forall v \in C^\infty(K).$$
称 $\Pi_K$ 为 $P_k$ 插值算子，$\Pi_K(v)$ 为 $v$ 的 $P_k$ 插值函数。
:::

**Definition**
令 $P_k(\Omega)$ 为 $\Omega$ 上不超过 $k$ 次多项式构成的空间。

定义等价类 $$[v] = \{w \in W^{k+1,p}: w - v \in P_k\}.$$ 等价类的范数
$$\| [v] \|_{k+1,p} = \inf_{w \in P_k(\Omega)} \| v + w \|_{k+1,p}.$$
半范
$$| [v] |_{k+1,p} = \inf_{w \in P_k(\Omega)} \| v + w \|_{k+1,p} = |v|_{k+1,p}.$$
:::

**Theorem**
存在只依赖于 $\Omega$ 的常数 $C$，使得
$$\| [v] \|_{k+1,p} \leq C |v|_{k+1,p}, \quad \forall v \in W^{k+1,p}.$$
:::

**证明：** 设 $P_1, \dots, P_N$ 是 $P_k(\Omega)$ 的一组基，即
$f_i(P_j) = \delta_{ij}$。则有 $\forall w \in P_k(\Omega)$，
$$f_i(w) = 0, \quad i = 1, \dots, N \mathrm{Im}plies w = 0.$$ 由 Hahn-Banach
定理，$f_i$, $i = 1, \dots, N$ 可以延拓为 $W^{k+1,p}$ 上的有界线性泛函。

下面证明存在 $C$ 使得
$$\| v \|_{k+1,p} \leq C \left( |v|_{k+1,p} + \sum_{i=1}^N |f_i(v)| \right), \quad \forall v \in W^{k+1,p}.$$
采用反证法。若结论非真，则有 $\{v_j\}_{j=1}^\infty \subset W^{k+1,p}$
满足 $$\| v_j \|_{k+1,p} = 1, \quad \forall j \geq 1,$$
$$\lim_{j \to \infty} \left( |v_j|_{k+1,p} + \sum_{i=1}^N |f_i(v_j)| \right) = 0.$$
由 Sobolev 空间的嵌入定理
$$W^{k+1,p}(\Omega) \hookrightarrow W^{k,p}(\Omega),$$ 即存在
$\{v_j\}_{j=1}^\infty$ 的子列（不妨仍记为 $\{v_j\}_{j=1}^\infty$）和
$v \in W^{k,p}(\Omega)$ 使得
$$\lim_{j \to \infty} \| v_j - v \|_{k,p} = 0.$$ 则
$\{v_j\}_{j=1}^\infty$ 是 $W^{k,p}$ 中的 Cauchy 列。

由 (4.2.2) 得 $\{v_j\}_{j=1}^\infty$ 也是 $W^{k+1,p}$ 中的 Cauchy 列，且
$$\lim_{j \to \infty} \| v_j - v \|_{k+1,p} = 0.$$

特别有
$$|D^\alpha v|_{0,p} = \lim_{j \to \infty} |D^\alpha v_j|_{0,p} = 0, \quad |\alpha| = k+1.$$
由此可得 $v \in P_k(\Omega)$。

由 (4.2.2) 可得
$$f_i(v) = \lim_{j \to \infty} f_i(v_j) = 0, \quad i = 1, \dots, N.$$
因此 $v = 0$ 与 $\|v\|_{k+1,p} = 1$ 矛盾。

于是
$$\| [v] \|_{k+1,p} = \inf_{w \in P_k(\Omega)} \| v + w \|_{k+1,p} \leq \| v + \widetilde{w} \|_{k+1,p} \leq C |v|_{k+1,p},$$
其中 $\widetilde{w} = -\sum_{j=1}^N f_j(v) P_j$。

设 $\Omega_1, \Omega_2$ 是两个仿射等价的开集，即存在可逆的方阵
$B \in \mathbb{R}^{n \times n}$，$b \in \mathbb{R}^n$ 使得
$$\Omega_2 = F(\Omega_1),$$ 其中 $$F(x) = Bx + b.$$ 令
$v \in W^{m,p}(\Omega_1)$，令
$\tilde{v}(x) = v(F(x)) \in W^{m,p}(\Omega_2)$。

**Theorem**
存在常数 $C = C(m,n)$ 使得
$$|\tilde{v}|_{m,p,\Omega_2} \leq C \|B\|_2^m |\det(B)|^{-1/p} |v|_{m,p,\Omega_1},$$
$$|v|_{m,p,\Omega_1} \leq C \|B^{-1}\|_2^m |\det(B)|^{1/p} |\tilde{v}|_{m,p,\Omega_2}.$$
其中 $\|\cdot\|_2$ 是矩阵的 2-范数。
:::

**证明：** 留作练习。
