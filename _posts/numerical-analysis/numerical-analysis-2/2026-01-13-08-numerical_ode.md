---
layout: post
title: "Numerical Analysis II 常微分方程初值问题的数值方法"
permalink: /posts/numerical-analysis-2-08-常微分方程初值问题的数值方法/
tags: numerical-analysis
use_math: true
---

# 常微分方程初值问题的数值方法

## 一阶非线性常微分方程

考虑初值问题： $$\begin{cases}
\frac{dy}{dx} = f(x, y), & x \in [a, b] \\
y(a) = y_0.
\end{cases}
\tag{8.1.1}$$

::: definition
设 $D \subset \mathbb{R}^2$，二元函数 $f$ 在 $D$ 上有定义，如果存在
$L > 0$ 使得
$$|f(x, y_1) - f(x, y_2)| \leq L |y_1 - y_2|, \quad \forall (x, y_1), (x, y_2) \in D,$$
则称 $f$ 关于 $y$ 满足 Lipschitz 条件，$L$ 称为 $f$ 的 Lipschitz 常数。
:::

::: definition
设 $D \subset \mathbb{R}^2$，若 $\forall (x_1, y_1), (x_2, y_2) \in D$
均有
$$((1-\lambda)x_1 + \lambda x_2, \quad (1-\lambda)y_1 + \lambda y_2) \in D, \quad \forall \lambda \in [0, 1],$$
则称 $D$ 是一个凸集。
:::

::: definition
如果初值问题 (8.1.1) 满足：

1.  存在唯一的解，

2.  $\exists \delta > 0$，使得当 $|\varepsilon| < \delta$，在 $[a, b]$
    上 $\delta$ 连续并且 $|S(x)| < \delta$ 时，初值问题 $$\begin{cases}
        \frac{dZ}{dx} = f(x, Z) + S(x), & x \in [a, b] \\
        Z(a) = y_0 + \varepsilon_0
        \end{cases}$$ 存在唯一的解，并满足
    $$|Z(x) - y(x)| < \varepsilon, \quad x \in [a, b]$$

则称初值问题 (8.1.1) 是适定的。
:::

::: theorem
设 $D = \{(x, y) \mid a \leq x \leq b, -\infty < y < +\infty\}$， 函数
$f$ 在 $D$ 上连续并对 $y$ 满足 Lipschitz 条件， 那么初值问题 (8.1.1)
是适定的。
:::

## Euler 方法

引入对 $x$ 的离散化：$x_n = a + nh$, $n = 0, 1, 2, \dots$

对于 $\frac{dy}{dx} = f(x, y)$ 在 $[x_n, x_{n+1}]$ 上积分得：
$$\begin{aligned}
y(x_{n+1}) &= y(x_n) + \int_{x_n}^{x_{n+1}} f(x, y(x)) \, dx \\
&\approx y(x_n) + f(x_n, y(x_n)) h.
\end{aligned}$$ 由此可得离散方法： $$y_{n+1} = y_n + f(x_n, y_n) h,$$
称为显式 Euler 方法。

类似地，可以得到隐式 Euler 方法：
$$y_{n+1} = y_n + f(x_{n+1}, y_{n+1}) h.$$

梯形方法： $$\begin{aligned}
y(x_{n+1}) &= y(x_n) + \int_{x_n}^{x_{n+1}} f(x, y(x)) \, dx \\
&\approx y(x_n) + \frac{1}{2} h \left[ f(x_n, y(x_n)) + f(x_{n+1}, y(x_{n+1})) \right].
\end{aligned}$$ 改进 Euler 法： $$\begin{aligned}
\text{(预估)} \quad & \widetilde{y}_{n+1} = y_n + f(x_n, y_n) h, \\
\text{(校正)} \quad & y_{n+1} = y_n + \frac{1}{2} h \left[ f(x_n, y_n) + f(x_{n+1}, \widetilde{y}_{n+1}) \right].
\end{aligned}$$

## 显式单步法

设显式单步法为： $$y_{n+1} = y_n + h \varphi(x_n, y_n; h),$$ 其中
$\varphi$ 称为增量函数。

::: example
$$\varphi(x_n, y_n; h) = f(x_n, y_n).$$

改进 Euler 法：
$$\varphi(x_n, y_n; h) = \frac{1}{2} \left[ f(x_n, y_n) + f(x_{n+1}, y_n + h f(x_n, y_n)) \right].$$

令 $e_n = y(x_n) - y_n$，整体截断误差为：
$$T_{n+1} = T(x_n, y_n; h) = y(x+h) - y(x) - h \varphi(x, y(x); h).$$
:::

::: definition
设 $y(x)$ 是 (8.1.1) 的精确解，则
$$T(x, y; h) = y(x+h) - y(x) - h \varphi(x, y(x); h)$$
称为显式单步法的局部截断误差。
:::

::: example
$$\begin{aligned}
T_{n+1} &= y(x_{n+1}) - y(x_n) - h f(x_n, y(x_n)) \\
&= y(x_{n+1}) - y(x_n) - h y'(x_n) \\
&= \frac{h^2}{2} y''(\xi_n), \quad \xi_n \in [x_n, x_{n+1}].
\end{aligned}$$ 若 $y \in C^2[a, b]$，令
$$M = \max_{a \leq x \leq b} |y''(x)|,$$ 则有
$$|T_{n+1}| \leq \frac{1}{2} M h^2.$$
:::

### 相容性 {#相容性 .unnumbered}

::: definition
若 $$\lim_{h \to 0} \frac{1}{h} T(x, y; h) = 0,$$ 且关于 $x, y$
一致收敛，则称显式单步法（与初值问题）是相容的。

若存在 $C > 0$ 使得 $$|T(x, y; h)| \leq C h^{p+1},$$ 则称单步法 $p$
阶相容。
:::

::: theorem
单步法相容当且仅当 $$\lim_{h \to 0} \varphi(x, y; h) = f(x, y).$$
:::

::: proof
*Proof.* $$\begin{aligned}
0 &= \lim_{h \to 0} \frac{1}{h} T(x, y; h) \\
&= \lim_{h \to 0} \frac{y(x+h) - y(x)}{h} - \varphi(x, y; h) \\
&= y'(x) - \lim_{h \to 0} \varphi(x, y; h) \\
&= f(x, y) - \lim_{h \to 0} \varphi(x, y; h).
\end{aligned}$$ 因此，$\lim_{h \to 0} \varphi(x, y; h) = f(x, y)$。 ◻
:::

::: example
Euler 法：

考虑 Euler 法的局部截断误差： $$\begin{aligned}
T(x, y; h) &= y(x+h) - y(x) - h f(x, y) \\
&= y'(x)h + \frac{1}{2}y''(x)h^2 + O(h^3) - h y'(x) \\
&= O(h^2).
\end{aligned}$$ 因此，Euler 法是 1 阶相容的。

改进 Euler 法

考虑改进 Euler 法的局部截断误差： $$\begin{aligned}
T(x, y; h) &= y(x+h) - y(x) - \frac{1}{2}h \left[ f(x, y) + f(x+h, y+hf(x, y)) \right] \\
&= y'(x)h + \frac{1}{2}y''(x)h^2 + O(h^3) \\
&\quad - \frac{1}{2}h \left[ f(x, y) + f(x+h, y+hf(x, y)) \right] \\
&= \frac{1}{2}y''(x)h^2 - \frac{1}{2}h^2 \left( \frac{\partial f}{\partial x} + \frac{dy}{dx}\frac{\partial f}{\partial y} \right) + O(h^3) \\
&= O(h^3).
\end{aligned}$$ 因此，改进 Euler 法是 2 阶相容的。
:::

### 收敛性 {#收敛性 .unnumbered}

令 $E(h) = \max_n |e_n(h)| = \max_n |y(x_n) - y_n|$。若
$$\lim_{h \to 0} E(h) = 0,$$ 则称单步法收敛。若存在 $C > 0$ 使得
$$E(h) \leq C h^p,$$ 则称单步法 $p$ 阶收敛。

::: corollary
设 $\varepsilon_j \in \mathbb{R}$，$j = 0, 1, \dots$ 满足
$$|\varepsilon_{j+1}| \leq (1+A)|\varepsilon_j| + B, \quad j = 0, 1, \dots,$$
其中 $A, B$ 为常数。则有
$$|\varepsilon_j| \leq |\varepsilon_0| e^{jA} + \frac{B}{A}(e^{jA} - 1), \quad j = 0, 1, \dots.$$
:::

::: proof
*Proof.* 用归纳法证明。 - 当 $j = 0$ 时显然成立。 - 假设对于 $j$
成立，则有 $$\begin{aligned}
|\varepsilon_{j+1}| &\leq (1+A)|\varepsilon_j| + B \\
&\leq (1+A)\left(|\varepsilon_0| e^{jA} + \frac{B}{A}(e^{jA} - 1)\right) + B \\
&= |\varepsilon_0| e^{(j+1)A} + \frac{B}{A}(e^{(j+1)A} - 1).
\end{aligned}$$ 因此结论成立。 ◻
:::

::: theorem
设增量函数 $\varphi(x, y; h)$ 关于 $x, y, h$ 连续，对于 $y$ 满足
Lipschitz 条件，即
$$|\varphi(x, y; h) - \varphi(x, z; h)| \leq L|y-z|.$$
那么单步法收敛当且仅当单步法相容。
:::

::: proof
*Proof.* 设单步法相容。由单步法的定义和局部截断误差的定义，有
$$\begin{aligned}
y_{n+1} &= y_n + h \varphi(x_n, y_n; h), \\
y(x_{n+1}) &= y(x_n) + h \varphi(x_n, y(x_n); h) + T(x_n, y(x_n); h).
\end{aligned}$$ 两式相减得
$$e_{n+1} = e_n + h \left[ \varphi(x_n, y(x_n); h) - \varphi(x_n, y_n; h) \right] + T(x_n, y(x_n); h).$$
由于 $\varphi(x, y; h)$ 对 $y$ 满足 Lipschitz 条件，有
$$|e_{n+1}| \leq (1+hL)|e_n| + h \alpha(h),$$ 其中
$\alpha(h) = \max_x \frac{1}{h}|T(x, y(x); h)|$。由引理可知
$$|e_n| \leq \frac{\alpha(h)}{L}(e^{Ln} - 1), \quad n = 0, 1, \dots.$$
因此 $$E(h) \leq \frac{\alpha(h)}{L}(e^{L(b-a)} - 1).$$
由于单步法相容，$\lim_{h \to 0} \alpha(h) = 0$，故
$$\lim_{h \to 0} E(h) = 0.$$ 即单步法收敛。

反之，若单步法收敛，则 $h \to 0$ 时单步法的解收敛到初值问题
$$y'(x) = f(x, y), \quad y(a) = y_0$$
的解。同时单步法的解也收敛到上述初值问题的解。由初值问题的适定性得
$$\varphi(x, y; 0) = f(x, y),$$ 即得相容性。 ◻
:::

::: theorem
设单步法满足定理 8.3.2 的条件且是 $p$ 阶相容的，即
$|T(x, y; h)| \leq K h^{p+1}$，那么有
$$|e_n| \leq \frac{K}{L} \left[ e^{L(b-a)} - 1 \right] h^p.$$
即收敛阶也是$p$。
:::

### 稳定性 {#稳定性 .unnumbered}

::: definition
如果存在常数 $K$ 及 $h_0$，使得对应于初值为 $y_0$ 和 $z_0$ 的单步法
$$y_{n+1} = y_n + h \varphi(x_n, y_n; h)$$ 的解 $y_n$, $z_n$ 满足
$$|y_n - z_n| \leq K |y_0 - z_0|, \quad 0 < h < h_0, \, nh \leq b-a,$$
那么称单步法是稳定的.
:::

::: theorem
设增量函数 $\varphi(x, y; h)$ 关于 $y$ 满足 Lipschitz 条件
$$|\varphi(x, y_1; h) - \varphi(x, y_2; h)| \leq L |y_1 - y_2|,$$
那么单步法是稳定的.
:::

::: proof
*Proof.* 考虑两个解序列 $y_n$ 和 $z_n$，它们满足 $$\begin{aligned}
        y_{n+1} &= y_n + h \varphi(x_n, y_n; h), \\
        z_{n+1} &= z_n + h \varphi(x_n, z_n; h).
    
\end{aligned}$$ 两式相减，令 $E_n = y_n - z_n$，则有
$$|E_{n+1}| \leq |E_n| + h L |E_n|.$$ 递推可得 $$\begin{aligned}
        |E_{n+1}| &\leq (1 + hL)^{n+1} |E_0| \\
                  &\leq e^{(n+1)hL} |E_0| \leq e^{L(b-a)} |E_0|.
    
\end{aligned}$$ 因此，单步法是稳定的. ◻
:::

考虑试验方程 $$y'(x) = \lambda y, \quad \text{Re}(\lambda) < 0.$$
一般单步法用于试验方程可以写成 $$y_{n+1} = E(\lambda h) y_n.$$

::: definition
如果 $|E(\lambda h)| < 1$，称单步法是绝对稳定的.

-   $\{\lambda h \in \mathbb{C}: |E(\lambda h)| < 1\}$：绝对稳定区域

-   $\{\lambda h \in \mathbb{R}: |E(\lambda h)| < 1\}$：绝对稳定区间
:::

::: example
Euler 法的绝对稳定区域和区间.

解：Euler 法用于 $y' = \lambda y$ 得 $$y_{n+1} = (1 + \lambda h) y_n.$$
所以 $E(\lambda h) = 1 + \lambda h$. 因此，
$$|E(\lambda h)| = |1 + \lambda h|.$$ 绝对稳定区域为
$$\{\lambda h \in \mathbb{C}: |1 + \lambda h| < 1\}.$$ 绝对稳定区间为
$$(-2, 0).$$
:::

::: example
隐式 Euler 法的绝对稳定区间.

解：隐式 Euler 法用于 $y' = \lambda y$ 得
$$y_{n+1} = \frac{1}{1 - \lambda h} y_n.$$ 所以
$E(\lambda h) = \frac{1}{1 - \lambda h}$. 因此，
$$|E(\lambda h)| = \left|\frac{1}{1 - \lambda h}\right|.$$
绝对稳定区间为 $$(-\infty, 0).$$
:::

::: example
改进 Euler 法的绝对稳定区间.

解：改进 Euler 法用于 $y' = \lambda y$ 得
$$y_{n+1} = \left(1 + \lambda h + \frac{1}{2} (\lambda h)^2\right) y_n.$$
所以
$E(\lambda h) = 1 + \lambda h + \frac{1}{2} (\lambda h)^2 = \frac{1}{2} (\lambda h + 1)^2 + \frac{1}{2}$.
因此，
$$|E(\lambda h)| = \left|1 + \lambda h + \frac{1}{2} (\lambda h)^2\right|.$$
绝对稳定区间为 $$(-2, 0).$$
:::

::: example
梯形法的绝对稳定区间.

解：梯形法用于 $y' = \lambda y$ 得
$$y_{n+1} = \frac{1 + \frac{1}{2} \lambda h}{1 - \frac{1}{2} \lambda h} y_n.$$
所以
$E(\lambda h) = \frac{1 + \frac{1}{2} \lambda h}{1 - \frac{1}{2} \lambda h}$.
因此，
$$|E(\lambda h)| = \left|\frac{1 + \frac{1}{2} \lambda h}{1 - \frac{1}{2} \lambda h}\right|.$$
绝对稳定区间为 $$(-\infty, 0).$$
:::

## Runge-Kutta 方法

初值问题的 Taylor 展开

设 $y$ 为初值问题的解，并且充分光滑，由 Taylor 展开得
$$y(x+h) = y(x) + h y'(x) + \frac{1}{2} h^2 y''(x) + \frac{1}{3!} h^3 y'''(x) + \cdots$$
其中 $$\begin{aligned}
y'(x) &= f(x, y(x)) \\
y''(x) &= \frac{\partial}{\partial x} \left( f(x, y(x)) \right) \\
&= \frac{\partial f}{\partial x} + \frac{\partial f}{\partial y} f \\
y'''(x) &= \frac{\partial}{\partial x} \left( \frac{\partial f}{\partial x} + \frac{\partial f}{\partial y} f \right) \\
&= \frac{\partial^2 f}{\partial x^2} + 2 \frac{\partial^2 f}{\partial x \partial y} f + \frac{\partial^2 f}{\partial y^2} f^2 \\
&\quad + \frac{\partial f}{\partial x} \frac{\partial f}{\partial y} + \left( \frac{\partial f}{\partial y} \right)^2 f
\end{aligned}$$

由此可得各阶方法：

1.  1 阶方法：
    $$y_{n+1} = y_n + h f(x_n, y_n) \quad \leftarrow \text{Euler 法}$$

2.  2 阶方法：
    $$y_{n+1} = y_n + h f(x_n, y_n) + \frac{h^2}{2} \left[ \frac{\partial f}{\partial x}(x_n, y_n) + \frac{\partial f}{\partial y}(x_n, y_n) f(x_n, y_n) \right]$$

3.  3 阶方法：
    $$y_{n+1} = y_n + h f(x_n, y_n) + \frac{h^2}{2} \left[ \frac{\partial f}{\partial x}(x_n, y_n) + \frac{\partial f}{\partial y}(x_n, y_n) f(x_n, y_n) \right]$$
    $$+ \frac{h^3}{6} \left[ \frac{\partial^2 f}{\partial x^2} + 2 \frac{\partial^2 f}{\partial x \partial y} f + \frac{\partial^2 f}{\partial y^2} f^2 + \frac{\partial f}{\partial x} \frac{\partial f}{\partial y} + \left( \frac{\partial f}{\partial y} \right)^2 f \right](x_n, y_n)$$

### 显式 Runge-Kutta 方法 {#显式-runge-kutta-方法 .unnumbered}

R-K 方法的一般形式为： $$y_{n+1} = y_n + h \varphi(x_n, y_n; h)$$
$$\varphi(x_n, y_n; h) = \sum_{i=1}^s b_i k_i$$
$$k_i = f(x_n + c_i h, y_n + h \sum_{j=1}^s a_{ij} k_j)$$ 其中
$$c_i = \sum_{j=1}^s a_{ij}, \quad i = 1, 2, \cdots, s \quad \text{(行和条件)}$$
令 $$A = \begin{bmatrix}
a_{11} & \cdots & a_{1s} \\
\vdots & \ddots & \vdots \\
a_{s1} & \cdots & a_{ss}
\end{bmatrix}, \quad
c = \begin{bmatrix}
c_1 \\
\vdots \\
c_s
\end{bmatrix}, \quad
b = \begin{bmatrix}
b_1 \\
\vdots \\
b_s
\end{bmatrix}$$ 如果 $A$ 是严格下三角矩阵，即
$$a_{ij} = 0, \, j \geq i,$$ 此时有
$$k_i = f(x_n + c_i h, y_n + h \sum_{j=1}^{i-1} a_{ij} k_j)$$ 为显式
Runge-Kutta 方法。

**一级方法：$s = 1$**

$$\varphi(x_n, y_n; h) = b_1 k_1$$ $$k_1 = f(x_n, y_n)$$
$$\Rightarrow y_{n+1} = y_n + b_1 h f(x_n, y_n)$$ 利用 Taylor 展开
$$y(x_n + h) = y(x_n) + h y'(x_n) + \frac{1}{2} h^2 y''(x_n) + \cdots$$
$$\Rightarrow b_1 = 1$$ $$\Rightarrow 1 \text{ 阶 } RK \text{ 方法 }$$
$$y_{n+1} = y_n + h f(x_n, y_n) \quad \leftarrow \text{Euler 法}$$

**二级方法：$s = 2$**

$$\varphi(x_n, y_n; h) = b_1 k_1 + b_2 k_2$$ 其中 $$k_1 = f(x_n, y_n)$$
$$k_2 = f(x_n + c_2 h, y_n + h a_{21} f(x_n, y_n))$$ 对 $k_2$ 进行
Taylor 展开得
$$k_2 = f(x_n, y_n) + c_2 h \frac{\partial f}{\partial x} + h a_{21} f \frac{\partial f}{\partial y} + O(h^2)$$
代入 $\varphi$ 得
$$\varphi(x_n, y_n; h) = (b_1 + b_2) f + h b_2 c_2 \frac{\partial f}{\partial x}$$
$$+ h b_2 a_{21} f \frac{\partial f}{\partial y} + O(h^2)$$

与 $y(x+h)$ 的 Taylor 展开比较得
$$b_1 + b_2 = 1, \quad b_2 c_2 = \frac{1}{2}, \quad b_2 a_{21} = \frac{1}{2}$$
二级二阶 RK 方法不唯一。

-   $c_2 = \frac{1}{2}$ :
    $$y_{n+1} = y_n + h f(x_n + \frac{1}{2} h, y_n + \frac{1}{2} h f(x_n, y_n)) \quad \textbf{中点法}$$

-   $c_2 = 1$ :
    $$y_{n+1} = y_n + \frac{h}{2} \left[ f(x_n, y_n) + f(x_{n+1}, y_n + h f(x_n, y_n)) \right] \quad \textbf{改进 Euler 法}$$

**三阶方法：$s = 3$**

$$\varphi(x_n, y_n; h) = b_1 k_1 + b_2 k_2 + b_3 k_3$$
$$k_1 = f(x_n, y_n)$$ $$k_2 = f(x_n + c_2 h, y_n + h a_{21} k_1)$$
$$k_3 = f(x_n + c_3 h, y_n + h a_{31} k_1 + h a_{32} k_2)$$ 对
$k_2, k_3$ 作 Taylor 展开并匹配系数可得 $$b_1 + b_2 + b_3 = 1$$
$$b_2 c_2 + b_3 c_3 = \frac{1}{2}$$
$$b_2 c_2^2 + b_3 c_3^2 = \frac{1}{3}$$ $$b_3 c_2 a_{32} = \frac{1}{6}$$

-   Heun 三阶方法：
    $$c_1 = 0, \quad c_2 = \frac{1}{3}, \quad c_3 = \frac{2}{3}$$
    $$b_1 = \frac{1}{4}, \quad b_2 = 0, \quad b_3 = \frac{3}{4}$$
    $$a_{21} = \frac{1}{3}, \quad a_{31} = 0, \quad a_{32} = \frac{2}{3}$$

-   Kutta 三阶方法： $$c_1 = 0, \quad c_2 = \frac{1}{2}, \quad c_3 = 1$$
    $$b_1 = \frac{1}{6}, \quad b_2 = \frac{2}{3}, \quad b_3 = \frac{1}{6}$$
    $$a_{21} = \frac{1}{2}, \quad a_{31} = -1, \quad a_{32} = 2$$

**四阶方法：$S = 4$**

经典 Runge-Kutta 方法：
$$y_{n+1} = y_n + \frac{1}{6} h \left( k_1 + 2 k_2 + 2 k_3 + k_4 \right)$$
$$k_1 = f(x_n, y_n)$$
$$k_2 = f(x_n + \frac{1}{2} h, y_n + \frac{1}{2} h k_1)$$
$$k_3 = f(x_n + \frac{1}{2} h, y_n + \frac{1}{2} h k_2)$$
$$k_4 = f(x_n + h, y_n + h k_3)$$

**收敛性**

Runge-Kutta 方法的相容性由推导过程易得。只需验证 $\varphi(x, y; h)$ 关于
$y$ Lipschitz 连续。

故只需验证 $k_i, i = 1, \dots, s$ 关于 $y$ Lipschitz 连续。

由归纳法易证 $k_i, i = 1, \dots, s$ 关于 $y$ Lipschitz 连续。

从而可得 R-K 方法的收敛性。

**绝对稳定性**

**二阶 Runge-Kutta 方法**

$$y_{n+1} = y_n + h \varphi(x_n, y_n; h)$$
$$\varphi(x_n, y_n; h) = b_1 k_1 + b_2 k_2$$ $$k_1 = f(x_n, y_n),$$
$$k_2 = f(x_n + c_2 h, y_n + h a_{21} f(x_n, y_n))$$

将 $f(x, y) = \lambda y$ 代入得 $$\begin{aligned}
y_{n+1} &= y_n \left( 1 + (b_1 + b_2) \lambda h + b_2 a_{21} (\lambda h)^2 \right) \\
&= y_n \left( 1 + \lambda h + \frac{1}{2} (\lambda h)^2 \right)
\end{aligned}$$

$\Rightarrow$ 绝对稳定区间为 $(-2, 0)$

**三阶方法**

$$E(\lambda h) = 1 + \lambda h + \frac{(\lambda h)^2}{2} + \frac{(\lambda h)^3}{6}$$

**四阶方法**

$$E(\lambda h) = 1 + \lambda h + \frac{(\lambda h)^2}{2} + \frac{(\lambda h)^3}{6} + \frac{(\lambda h)^4}{24}$$

**隐式 Runge-Kutta 方法**

**一级方法：$S = 1$**

$$\varphi(x_n, y_n; h) = b_1 k_1$$
$$k_1 = f(x_n + c_1 h, y_n + h a_{11} k_1)$$

对 $k_1$ 作 Taylor 展开
$$k_1 = f(x_n, y_n) + c_1 h \frac{\partial f}{\partial x} + h a_{11} k_1 \frac{\partial f}{\partial y} + O(h^2)$$

代入 $\varphi$ 可得
$$y_{n+1} = y_n + h b_1 f + b_1 c_1 h^2 \frac{\partial f}{\partial x} + b_1 a_{11} h^2 \frac{\partial f}{\partial y} f + O(h^3)$$

与 $y(x_n + h)$ 的 Taylor 展开比较得
$$b_1 = 1, \quad b_1 c_1 = \frac{1}{2}, \quad b_1 a_{11} = \frac{1}{2}$$

$\Rightarrow$ 相应的 RK 方法为
$$y_{n+1} = y_n + h f(x_n + \frac{1}{2} h, \frac{1}{2}(y_n + y_{n+1}))$$

**隐式中点方法**

**二级二阶方法**

$$y_{n+1} = y_n + h \left( \frac{1}{2} k_1 + \frac{1}{2} k_2 \right)$$
$$k_1 = f(x_n, y_n)$$
$$k_2 = f(x_n + h, y_n + \frac{1}{2} h k_1 + \frac{1}{2} h k_2)$$
$$= f(x_{n+1}, y_{n+1})$$

$\Rightarrow$ 梯形方法

**二级四阶方法：（Gauss 方法）**

$$y_{n+1} = y_n + h \left( \frac{1}{2} k_1 + \frac{1}{2} k_2 \right)$$
$$k_1 = f(x_n + \left( \frac{1}{2} - \frac{\sqrt{3}}{6} \right) h, y_n + \frac{1}{4} h k_1 + \left( \frac{1}{4} - \frac{\sqrt{3}}{6} \right) h k_2)$$
$$k_2 = f(x_n + \left( \frac{1}{2} + \frac{\sqrt{3}}{6} \right) h, y_n + \left( \frac{1}{4} + \frac{\sqrt{3}}{6} \right) h k_1 + \frac{1}{4} h k_2)$$

半隐式 RK 方法

RK 矩阵为下三角矩阵，即 $$a_{ij} = 0, \quad j > i$$

**二级三阶半隐式 RK 方法**

$$y_{n+1} = y_n + \frac{h}{2} (k_1 + k_2)$$
$$k_1 = f(x_n + r h, y_n + r h k_1)$$
$$k_2 = f(x_n + (1-r) h, y_n + (1-2r) h k_1 + r h k_2)$$

其中 $$r = \frac{1}{2} \pm \frac{1}{2} \sqrt{5}$$

## 线性多步法

线性多步法的一般形式可以表示为：
$$\sum_{j=0}^{k} \alpha_j y_{n+j} = h \sum_{j=0}^{k} \beta_j f(x_{n+j}, y_{n+j})$$
其中 $\alpha_j$, $\beta_j$, $j=0,1,\dots,k$ 为常数。

-   $\beta_k = 0$: 显式方法

-   $\beta_k \neq 0$: 隐式方法

::: definition
设 $y(x)$ 为初值问题的解。定义
$$T_{n+k} = \sum_{j=0}^{k} \alpha_j y(x_{n+j}) - h \sum_{j=0}^{k} \beta_j f(x_{n+j}, y(x_{n+j}))$$
称为 $k$ 步法在 $x_{n+k}$ 处的局部截断误差。
:::

::: example
Simpson 方法的局部截断误差 $$\begin{aligned}
y_{n+1} &= y_{n-1} + \frac{h}{3} \left[ f(x_{n+1}, y_{n+1}) + 4 f(x_n, y_n) + f(x_{n-1}, y_{n-1}) \right] \\
T_{n+1} &= y(x_{n+1}) - y(x_{n-1}) - \frac{h}{3} \left[ f(x_{n+1}, y(x_{n+1})) + 4 f(x_n, y(x_n)) \right. \\
&\quad \left. + f(x_{n-1}, y(x_{n-1})) \right] \\
&= 2 h y'(x_n) + \frac{1}{3} h^3 y'''(x_n) + \frac{1}{60} h^5 y^{(5)}(x_n) + O(h^7) \\
&\quad - \frac{h}{3} \left[ 2 y'(x_n) + h y''(x_n) + \frac{1}{12} h^4 y^{(5)}(x_n) + O(h^6) \right] \\
&\quad + 4 y'(x_n) \\
&= -\frac{1}{90} h^5 y^{(5)}(x_n) + O(h^7)
\end{aligned}$$
:::

### 数值积分构造线性多步法 {#数值积分构造线性多步法 .unnumbered}

将 $y' = f(x, y)$ 在 $[x_{n+1-\ell}, x_{n+1}]$ 上积分：
$$y(x_{n+1}) = y(x_{n+1-\ell}) + \int_{x_{n+1-\ell}}^{x_{n+1}} f(x, y(x)) \, dx$$
用等距节点 $x_{n+1}$, $x_n$, $\dots$, $x_{n-r}$
的插值多项式代替被积函数进行数值积分，可以得到相应的线性多步法。

1.  取 $\ell = 4$，插值节点取为 $x_{n-2}$, $x_{n-1}$, $x_n$：
    $$L_2(x) = \sum_{i=0}^{2} f(x_{n-2+i}, y(x_{n-2+i})) \ell_i(x)$$
    其中
    $$\ell_i(x) = \prod_{\substack{j=0 \\ j \neq i}}^{2} \frac{x - x_{n-2+j}}{x_{n-2+i} - x_{n-2+j}}$$
    由此可得多步法（Milne 方法）：
    $$y_{n+1} = y_{n-3} + \frac{4}{3} h \left[ 2 f(x_{n-2}, y_{n-2}) - f(x_{n-1}, y_{n-1}) + 2 f(x_n, y_n) \right]$$
    其局部截断误差为 $$\begin{aligned}
        T_{n+1} &= y(x_{n+1}) - y(x_{n-3}) - \frac{4}{3} h \left[ 2 y'(x_{n-2}) - y'(x_{n-1}) + 2 y'(x_n) \right] \\
        &= \frac{14}{45} h^5 y^{(5)}(x_n) + O(h^6)
        
    \end{aligned}$$

2.  取 $\ell = 2$，插值节点取为 $x_n$, $x_{n-1}$, $\dots$, $x_{n-r}$：
    $$L_r(x) = \sum_{j=1}^{r+1} f(x_{n+1-j}, y(x_{n+1-j})) \ell_j(x)$$
    其中
    $$\ell_j(x) = \prod_{\substack{m=1 \\ m \neq j}}^{r+1} \frac{x - x_{n+1-m}}{x_{n+1-j} - x_{n+1-m}}, \quad j=1,\dots,r+1$$
    由此可得 Nyström 方法：
    $$y_{n+1} = y_{n-1} + h \left[ p_{r,0} f(x_n, y_n) + p_{r,1} f(x_{n-1}, y_{n-1}) \right.$$
    $$\left. + \cdots + p_{r,r} f(x_{n-r}, y_{n-r}) \right]$$ 其中
    $$p_{r,j} = \int_{-1}^{1} \prod_{\substack{m=0 \\ m \neq j}}^{r} \frac{m+s+1}{m-j} \, ds, \quad j=0,1,\dots,r$$
    取 $r=0$ 可得
    $$y_{n+1} = y_{n-1} + 2h f(x_n, y_n) \quad \text{中点格式}$$
    插值节点取为 $x_{n+1}$, $x_n$, $\dots$, $x_{n+1-r}$ 可得
    $$y_{n+1} = y_{n-1} + h \left[ p_{r,0} f(x_{n+1}, y_{n+1}) + \cdots + p_{rr} f(x_{n+1-r}, y_{n+1-r}) \right]$$
    其中
    $$p_{r,j} = \int_{-2}^{0} \prod_{\substack{m=0 \\ m \neq j}}^{r} \frac{m+s}{m-j} \, ds, \quad j=0,1,\dots,r$$
    称为广义 Milne-Simpson 格式

3.  取 $\ell = 1$（Adams 方法），插值节点取为 $x_n$, $x_{n-1}$, $\dots$,
    $x_{n+1-r}$：
    $$L_{r-1}(x) = \sum_{j=0}^{r-1} f(x_{n-j}, y(x_{n-j})) \ell_j(x)$$
    其中
    $$\ell_j(x) = \prod_{\substack{i=0 \\ i \neq j}}^{r-1} \frac{x - x_{n-i}}{x_{n-j} - x_{n-i}}$$
    由此可得
    $$y_{n+1} = y_n + h \sum_{j=0}^{r} \beta_j f(x_{n-j}, y_{n-j})$$
    其中 $$\beta_j = \frac{1}{h} \int_{x_n}^{x_{n+1}} \ell_j(x) \, dx$$
    称为显式 Adams 方法（Adams-Bashforth 方法）

    ::: example
    取 $r=2$ 有
    $$y_{n+1} = y_n + \frac{h}{2} \left[ 3 f(x_n, y_n) - f(x_{n-1}, y_{n-1}) \right]$$
    局部截断误差为 $$\begin{aligned}
        T_{n+1} &= y(x_{n+1}) - y(x_n) - \frac{h}{2} \left[ 3 y'(x_n) - y'(x_{n-1}) \right] \\
        &= \frac{5}{12} h^3 y'''(x_n) + O(h^4)
        
    \end{aligned}$$
    :::

4.  取插值节点为 $x_{n+1}$, $x_n$, $\dots$, $x_{n+1-r}$ 可得隐式方法
    $$y_{n+1} = y_n + h \sum_{j=0}^{k} \beta_j f(x_{n+1-j}, y_{n+1-j})$$
    称为隐式 Adams 方法（Adams-Moulton 方法）

    ::: example
    取 $r=2$
    $$y_{n+1} = y_n + \frac{h}{12} \left[ 5 f(x_{n+1}, y_{n+1}) + 8 f(x_n, y_n) - f(x_{n-1}, y_{n-1}) \right]$$
    相应的局部截断误差为 $$\begin{aligned}
        T_{n+1} &= y(x_{n+1}) - y(x_n) - \frac{h}{12} \left[ 5 y'(x_{n+1}) + 8 y'(x_n) - y'(x_{n-1}) \right] \\
        &= -\frac{1}{24} h^4 y^{(4)}(x_n) + O(h^5)
        
    \end{aligned}$$
    :::

## 线性差分方程

常系数线性差分方程为
$$a_k y_{n+k} + a_{k-1} y_{n+k-1} + \cdots + a_0 y_n = c_{n+k} \tag{8.6.1}$$
其中 $a_j$, $j = 0, 1, \ldots, k$ 为常数，$c_{n+k}$ 为非齐次项。若
$a_k, a_0 \neq 0$，则称 (8.6.1) 为 $k$ 阶常系数线性差分方程。

::: theorem
给定 $k$ 个初始条件
$$y_0 = \nu_0, \quad \ldots, \quad y_{k-1} = \nu_{k-1}$$ 则 (8.6.1)
有唯一解。
:::

若 $c_{n+k} = 0$，则称 (8.6.1) 为 $k$ 阶齐次线性差分方程。

1.  设 $\{y_n^{(u)}\}$，$u = 1, 2, \ldots, k$
    是齐次差分方程的解，则其线性组合
    $$\{z_n\} = \left\{\sum_{u=1}^k c_u y_n^{(u)}\right\}$$ 也是解。

2.  设 $\{y_n^{(u)}\}$，$u = 1, 2, \ldots, k$ 是齐次差分方程的解，并且
    $k$ 阶 Wronski 行列式 $$\begin{vmatrix}
        y_0^{(1)} & \cdots & y_{k-1}^{(1)} \\
        \vdots & \ddots & \vdots \\
        y_0^{(k)} & \cdots & y_{k-1}^{(k)}
        \end{vmatrix} \neq 0$$ 那么
    $\{y_n^{(u)}\}$，$u = 1, 2, \ldots, k$ 线性无关。

3.  非齐次方程的解为 $\{y_n + u_n\}$，其中 $\{y_n\}$
    为齐次方程的通解，$\{u_n\}$ 为非齐次方程的一个特解。

::: definition
若 $\{y_n^{(u)}\}$，$u = 1, 2, \ldots, k$
是齐次方程线性无关的解，则称其为基本解组
$$\{z_n\} = \left\{\sum_{u=1}^k c_u y_n^{(u)}\right\}$$
称为齐次方程的通解。
:::

::: theorem
设 $\{y_n^{(u)}\}$ 是 $k$ 阶齐次差分方程的基本解组，并满足条件
$$y_i^{(u)} = \delta_{iu}, \quad i, u = 0, 1, \ldots, k-1$$
那么满足初始条件
$$y_0 = \nu_0, \quad \ldots, \quad y_{k-1} = \nu_{k-1}$$ 的 $k$
阶差分方程的解为
$$y_n = \sum_{u=0}^{k-1} \nu_u y_n^{(u)} + \frac{1}{a_k} \sum_{j=0}^{n-k} c_{j+k} y_{n-j-1}^{(k-1)}, \quad n = 0, 1, \ldots$$
其中 $i < 0$ 时 $y_i^{(k-1)} = 0$ 且 $n < k$ 时 $c_n = 0$。
:::

::: proof
*Proof.* $\sum_{u=0}^{k-1} \nu_u y_n^{(u)}$
满足齐次差分方程和初始条件，故仅需证
$$w_n = \frac{1}{a_k} \sum_{j=0}^{n-k} c_{j+k} y_{n-j-1}^{(k-1)}$$
满足非齐次差分方程和齐次初始条件。

由于 $i \leq k-2$ 时 $y_i^{(k-1)} = 0$，且 $n < k$ 时 $c_n = 0$，所以
$$w_n = 0, \quad n = 0, 1, \ldots, k-1$$ 另一方面，由 $i < 0$ 时
$y_i^{(k-1)} = 0$ 可得
$$\sum_{s=0}^k a_s w_{n+s} = \frac{1}{a_k} \sum_{s=0}^k a_s \sum_{j=0}^{n+s-k} c_{j+k} y_{n+s-j-1}^{(k-1)}$$
$$= \frac{1}{a_k} \sum_{j=0}^n \sum_{s=0}^k a_s c_{j+k} y_{n+s-j-1}^{(k-1)}$$
$$= \frac{1}{a_k} \sum_{j=0}^n c_{j+k} \sum_{s=0}^k a_s y_{n+s-j-1}^{(k-1)}$$
由于 $y_i^{(k-1)}$ 满足齐次差分方程，所以
$$\sum_{s=0}^k a_s y_{n-j-1+s}^{(k-1)} = 0, \quad \text{当 } n-j-1 \geq 0 \text{ 时}$$
因此
$$\sum_{s=0}^k a_s w_{n+s} = \frac{1}{a_k} c_{n+k} \sum_{s=0}^k a_s y_{s-1}^{(k-1)}$$
由
$y_i^{(k-1)} = \begin{cases} 0, & i = 0, 1, \ldots, k-2 \\ 1, & i = k-1 \end{cases}$
可推出
$$\sum_{s=0}^k a_s w_{n+s} = \frac{1}{a_k} c_{n+k} a_k = c_{n+k}$$ ◻
:::

对于 $k$ 阶齐次差分方程，考虑解的形式为 $$\{y_n\} = \{\xi^n\}.$$
代入方程得
$$a_k \xi^k + a_{k-1} \xi^{k-1} + \cdots + a_1 \xi + a_0 = 0$$ $\xi$
是代数方程 $$a_k x^k + \cdots + a_1 x + a_0 = 0 \tag{特征方程}$$ 的根。

设 $\xi_1, \ldots, \xi_k$ 是特征方程的根，$\xi_j$ 是 $\xi_j$
的重数。那么
$$\{\xi_j^n\}, \{n \xi_j^n\}, \ldots, \{n^{r_j-1} \xi_j^n\}, \quad j = 1, \ldots, k$$
是齐次差分方程的基本解组。

## 线性多步法的相容性、收敛性及稳定性

### 相容性 {#相容性-1 .unnumbered}

::: definition
若线性多步法的局部截断误差满足 $$\lim_{h \to 0} \frac{T_{n+k}}{h} = 0$$
则称线性多步法与初值问题相容。
:::

对于线性多步法
$$\sum_{j=0}^{k} \alpha_j y_{n+j} = h \sum_{j=0}^{k} \beta_j f(x_{n+j}, y_{n+j}),$$
引入多项式 $$\begin{aligned}
p(x) &= \sum_{j=0}^{k} \alpha_j x^j \tag{第一特征多项式}, \\
\sigma(x) &= \sum_{j=0}^{k} \beta_j x^j \tag{第二特征多项式}.
\end{aligned}$$

::: theorem
线性多步法相容当且仅当 $$p(1) = 0, \quad p'(1) = \sigma(1).$$
:::

::: proof
*Proof.* $$\begin{aligned}
T_{n+k} &= \sum_{j=0}^{k} \alpha_j y(x_{n+j}) - h \sum_{j=0}^{k} \beta_j f(x_{n+j}, y(x_{n+j})) \\
&= \left( \sum_{j=0}^{k} \alpha_j \right) y(x_n) + \sum_{j=0}^{k} \alpha_j \cdot jh \, y'(x_n) + O(h^2) \\
&\quad - h \sum_{j=0}^{k} \beta_j y'(x_{n+j}) \\
&= p(1) y(x_n) + h \sum_{j=0}^{k} (j \alpha_j - \beta_j) y'(x_n) + O(h^2) \\
&= p(1) y(x_n) + h \big( p'(1) - \sigma(1) \big) y'(x_n) + O(h^2).
\end{aligned}$$ 所以
$$\lim_{h \to 0} \frac{T_{n+k}}{h} = 0 \iff p(1) = 0, \quad p'(1) = \sigma(1).$$ ◻
:::

::: theorem
线性多步法 $P$ 阶相容，当且仅当存在 $C \neq 0$，使得 $\omega \to 1$ 时有
$$p(\omega) - \sigma(\omega)\ln(\omega) = C(\omega - 1)^{P+1} + O(|\omega - 1|^{P+2})$$
:::

采用多步法计算需给出适当的离散初始条件： $$\begin{aligned}
\sum_{j=0}^{k} \alpha_{j} y_{n+j} &= h \sum_{j=0}^{k} \beta_{j} f(x_{n+j}, y_{n+j}) \\
y_{\mu} &= \eta_{\mu}(h), \quad \mu = 0, 1, \dots, k-1
\end{aligned}$$

### 收敛性 {#收敛性-1 .unnumbered}

::: definition
如果当初始条件满足
$$\lim_{h \to 0} \eta_{\mu}(h) = y(a), \quad \mu = 0, 1, \dots, k-1$$
线性多步法的解 $\{y_n\}$ 有
$$\lim_{h \to 0} y_n = y(x), \quad \forall x \in [a, b]$$ 则称线性多步法
**收敛**.
:::

::: example
考虑两步法：
$$y_{n+2} - 3y_{n+1} + 2y_n = h \left[ \frac{13}{12} f(x_{n+2}, y_{n+2}) - \frac{5}{2} f(x_{n+1}, y_{n+1}) - \frac{5}{12} f(x_n, y_n) \right]$$
该方法二阶相容. 求解初值问题： $$\begin{aligned}
y' &= 0 \\
y(0) &= 1.
\end{aligned}$$
:::

此时两步法变为 $$\begin{aligned}
y_{n+2} - 3y_{n+1} + 2y_n = 0
\end{aligned}$$

该齐次差分方程特征方程为 $$\begin{aligned}
x^2 - 3x + 2 = 0
\end{aligned}$$

$\Rightarrow \lambda_1 = 1$, $\lambda_2 = 2$.

$\Rightarrow y_n = C_1 + C_2 \cdot 2^n$, $n = 0, 1, \dots$

取初始条件为 $y_0 = 1$, $y_1 = 1 + h$

$\Rightarrow C_1 + C_2 = 1$, $C_1 + 2C_2 = 1 + h$

$\Rightarrow C_1 = 1 - h$, $C_2 = h$

$\Rightarrow y_n = 1 + h(2^n - 1)$

$$\begin{aligned}
\lim_{h \to 0} y_n = \lim_{n \to \infty} 1 + \frac{2^n - 1}{n} \cdot x = \infty \neq y(x) = 1
\end{aligned}$$

故两步法不收敛.

::: definition
如果第一特征多项式 $P$
的零点都在单位圆内或单位圆周上，并且在单位圆周上的根均为单根，则称线性多步法满足
**根条件**.
:::

::: proof
*引理 (Gronwall 不等式).* 设 $\{\varepsilon_j\}$ 是 $\mathbb{R}$
中数列，并满足 $$\begin{aligned}
|\varepsilon_j| \leq A \sum_{m=0}^{j-1} |\varepsilon_m| + B, \quad j = 1, 2, \dots
\end{aligned}$$ 其中 $A > 0$, $B \geq 0$. 那么有 $$\begin{aligned}
|\varepsilon_j| \leq \big( A |\varepsilon_0| + B \big) e^{(j-1)A}, \quad j = 1, 2, \dots
\end{aligned}$$ ◻
:::

::: proof
*Proof.* 采用归纳法证明
$|\varepsilon_j| \leq (A|\varepsilon_0| + B)(1 + A)^{j-1}$。

当 $j = 1$ 时，显然成立。

假设对于 $j$ 成立： $$\begin{aligned}
|\varepsilon_{j+1}| &\leq A \sum_{m=0}^j |\varepsilon_m| + B \\
&\leq (A|\varepsilon_0| + B) + A \sum_{m=1}^j (A|\varepsilon_0| + B)(1 + A)^{m-1} \\
&= (A|\varepsilon_0| + B) \left[1 + A \sum_{m=1}^j (1 + A)^{m-1}\right] \\
&= (A|\varepsilon_0| + B)(1 + A)^j
\end{aligned}$$ ◻
:::

::: theorem
线性多步法收敛当且仅当满足根条件并相容。
:::

::: proof
*Proof.* （充分性） 由局部截断误差的定义有：
$$\sum_{j=0}^k \alpha_j y(x_{n+j}) = h \sum_{j=0}^k \beta_j f(x_{n+j}, y(x_{n+j})) + T_{n+k}$$

令 $e_n = y(x_n) - y_n$，有：
$$\sum_{j=0}^k \alpha_j e_{n+j} = C_{n+k}$$

其中
$$C_{n+k} = h \sum_{j=0}^k \beta_j \left[f(x_{n+j}, y(x_{n+j})) - f(x_{n+j}, y_{n+j})\right] + T_{n+k}$$

利用差分方程的解可得：
$$e_n = \sum_{\nu=0}^{k-1} e_{\nu} z_n^{(\nu)} + \frac{1}{\alpha_k} \sum_{j=0}^{n-k} C_{j+k} z_{n-j-1}^{(k-1)} \tag{8.7.1}$$

其中 $z_{n}^{(\nu)}$, $\nu = 0, 1, \dots, k-1$ 是齐次差分方程
$$\sum_{j=0}^{k} \alpha_j z_{n+j} = 0$$ 的基本解组.

由[根条件]{style="color: red"}可得，存在 $Q$ 不依赖于 $n$ 和 $\nu$ 使得
$$|z_{n}^{(\nu)}| \leq Q, \quad \forall n, \nu$$

另一方面， $$\begin{aligned}
|C_{j+k}| &\leq h \sum_{\nu=0}^{k} |\beta_\nu| \left| f(x_{j+\nu}, y(x_{j+\nu})) - f(x_{j+\nu}, y_{j+\nu}) \right| \\
&\qquad\qquad + |T_{j+k}| \\
&\leq h L \sum_{\nu=0}^{k} |\beta_\nu| |e_{j+\nu}| + h \tau(h).
\end{aligned}$$

-   [Lipschitz 条件]{style="color: red"}: $L$ 是 $f$ 的 Lipschitz 常数.

-   [相容]{style="color: red"}: $|T_{j+k}| \leq h \tau(h)$, 其中
    $\tau(h) \to 0$ as $h \to 0$.

设 $B = L \cdot \max_{0 \leq \nu \leq k} |\beta_\nu|$, 则
$$|C_{j+k}| \leq h B \sum_{\nu=0}^{k} |e_{j+\nu}| + h \tau(h).$$

由 $(8.7.1)$ 得 $$\begin{aligned}
|e_n| &\leq Q k \max_{0 \leq \nu \leq k-1} |e_\nu| + \frac{h}{|\alpha_k|} Q \sum_{j=0}^{n-k} |C_{j+k}| \\
&= Q k \max_{0 \leq \nu \leq k-1} |e_\nu| + \frac{h}{|\alpha_k|} Q \sum_{j=0}^{n-k} \left[ h B \sum_{\nu=0}^{k} |e_{j+\nu}| + h \tau(h) \right] \\
&= Q k \max_{0 \leq \nu \leq k-1} |e_\nu| + \frac{h}{|\alpha_k|} Q B \sum_{j=0}^{n-k} \sum_{\nu=0}^{k} |e_{j+\nu}| \\
&\qquad + \frac{h Q}{|\alpha_k|} (n-k+1) \tau(h) \\
&= Q k \max_{0 \leq \nu \leq k-1} |e_\nu| + \frac{h}{|\alpha_k|} Q B (k+1) \sum_{j=0}^{n} |e_j| \\
&\qquad + \frac{Q}{|\alpha_k|} (b-a) \tau(h),
\end{aligned}$$ 其中 $b-a$ 是区间长度.

$$\Rightarrow \quad |e_n| \leq R(h) + P(h) h \sum_{j=0}^{n-1} |e_j|$$
其中 $$\begin{aligned}
R &= \frac{1}{1 - \frac{1}{|\alpha_k|} Q B h (k+1)} \left[ k Q \max_{0 \leq j \leq k-1} |e_j| + \frac{1}{|\alpha_k|} Q (b-a) \tau(h) \right], \\
P &= \frac{1}{1 - \frac{1}{|\alpha_k|} Q B h (k+1)} \frac{1}{|\alpha_k|} Q B (k+1).
\end{aligned}$$

取 $h$ 充分小，使得
$$1 - \frac{1}{|\alpha_k|} Q B h (k+1) > \frac{1}{2}.$$

则有 $$\begin{aligned}
0 < R &\leq 2 \left[ k Q \max_{0 \leq j \leq k-1} |e_j| + \frac{1}{|\alpha_k|} Q (b-a) \tau(h) \right], \\
0 < P &\leq \frac{2}{|\alpha_k|} Q B (k+1).
\end{aligned}$$

由 Gronwall 不等式得 $$\begin{aligned}
|e_n| &\leq (P h |e_0| + R) e^{(n-1)h P} \\
&\leq (P h |e_0| + R) e^{P(b-a)}.
\end{aligned}$$

由初始条件收敛性可得
$$\lim_{h \to 0} \max_{0 \leq j \leq k-1} |e_j| = 0.$$

由相容性得 $$\lim_{h \to 0} \tau(h) = 0.$$

所以 $$\lim_{h \to 0} R = 0.$$

$$\Rightarrow \quad \lim_{h \to 0} |e_n| = 0.$$

必要性：

设线性多步法是收敛的，考虑初值问题 $$\begin{aligned}
        y' &= 0 \\
        y(a) &= 0
    
\end{aligned}$$ 相应的线性多步法为 $$\begin{aligned}
        \sum_{j=0}^k \alpha_j y_{n+j} &= 0 \\
        y_0 &= v_0, \, y_1 = v_1, \dots, y_{k-1} = v_{k-1}
    
\end{aligned}$$ 初值条件满足
$$\max_{0 \leq j \leq k-1} |v_j| \to 0 \quad \text{as} \quad h \to 0.$$
由收敛性得
$$\lim_{\substack{h \to 0 \\ x = a + nh}} y_n = y(x) = 0, \quad \forall x \in [a, b].$$
假设根条件不满足，设 $|\lambda_i| > 1$。

令 $$y_n = h (\lambda_i^n + \overline{\lambda}_i^n)$$ $y_n$
是线性多步法的解并且满足初始条件
$$y_j = h (\lambda_i^j + \overline{\lambda}_i^j), \quad j = 0, 1, \dots, k-1.$$
由收敛性有 $$\lim_{\substack{h \to 0 \\ x = a + nh}} y_n = 0$$ 与
$|\lambda_i| > 1$ 矛盾。

若 $|\lambda| = 1$ 且 $\lambda_i$ 为重根，令
$$y_n = h_n (\lambda_i^n + \overline{\lambda_i}^n)$$ 可得
$$\lim_{h \to 0} y_n = (x - a)(\lambda_i^n + \overline{\lambda_i}^n) \neq 0$$
与收敛性矛盾。故有根条件成立。

下面证明相容性。考虑初值问题 $$\begin{cases}
y' = 0 \\
y(0) = 1
\end{cases}$$ 取初值 $y_i = 1$, $i = 0, 1, \dots, k-1$。

相应的线性多步法为 $$\sum_{j=0}^{k} \alpha_j y_{n+j} = 0$$

由收敛性得 $$\begin{aligned}
\lim_{h \to 0} y_n & = \lim_{h \to 0} y_n = 1 \\
& \Rightarrow 0 = \lim_{n \to \infty} \sum_{j=0}^{k} \alpha_j y_{n+j} = \sum_{j=0}^{k} \alpha_j \\
& \Rightarrow p(1) = 0
\end{aligned}$$

为证明 $p'(1) = \sigma(1)$，考虑初值问题 $$\begin{aligned}
  \begin{cases}
    y' = 1 \\
    y(0) = 0
  \end{cases}
\end{aligned}$$

由于线性多步法收敛，故满足根条件。由于 $p(1) = 0$ 且 $p'(1) \neq 0$，令
$$\begin{aligned}
  c = \sigma(1) / p'(1)
\end{aligned}$$ 构造线性多步法 $$\begin{aligned}
  \begin{cases}
    \sum_{j=0}^k \alpha_j y_{n+j} = h \sum_{j=0}^k \beta_j \\
    y_m = mhc \quad (m = 0, 1, \dots, k-1)
  \end{cases}
\end{aligned}$$

利用数学归纳法证明 $y_n = nhc$。

设 $y_{n+k} = (n+k)hc$，则有 $$\begin{aligned}
  \sum_{j=0}^k \alpha_j y_{n+1+j} = h \sum_{j=0}^k \beta_j = h \sigma(1)
\end{aligned}$$ $$\begin{aligned}
  \implies \quad \alpha_k y_{n+k+1} &= h \sigma(1) - \sum_{j=0}^{k-1} \alpha_j y_{n+1+j} \\
  \text{归纳假设} \rightarrow &= h \sigma(1) - \sum_{j=0}^{k-1} \alpha_j h c (n+1+j) \\
                               &= h \sigma(1) - h c (n+1) \sum_{j=0}^{k-1} \alpha_j - h c \sum_{j=0}^k j \alpha_j + \alpha_k h c (n+1+k) 
\end{aligned}$$ 由
$\sum_{j=0}^k \alpha_j = 0, \sum_{j=0}^k j \alpha_j = p'(1), c = \sigma(1)/p'(1)$
可证.

由收敛性 $$\begin{aligned}
  x = y(x) = \lim_{\substack{n \to \infty \\ x = nh}} nhc = xc
\end{aligned}$$ $$\begin{aligned}
  \Rightarrow \quad c = 1 \quad \Rightarrow \quad p'(1) = \sigma(1)
\end{aligned}$$ ◻
:::

### 稳定性 {#稳定性-1 .unnumbered}

考虑对线性多步法进行扰动

$$\begin{aligned}
\sum_{j=0}^k \alpha_j z_{n+j} &= h \left[ \sum_{j=0}^k \beta_j f(x_{n+j}, z_{n+j}) + s_{n+k} \right] \\
z_\mu &= y_\mu(h) + s_\mu, \quad \mu = 0, 1, \dots, k-1
\end{aligned}$$

其中 $s_n$, $n = 0, 1, \dots$ 是线性多步法的扰动.

::: definition
设 $s_n$ 和 $s_n^*$, $n = 0, 1, \dots$ 是线性多步法的两个扰动, 并设
$z_n$, $z_n^*$ 是相应的扰动解. 若存在常数 $S$ 和 $h_0$, 使得对于任意
$h \leq h_0$ 当 $$|s_n - s_n^*| \leq \varepsilon$$ 有
$$|z_n - z_n^*| \leq S \varepsilon$$ 则称线性多步法是稳定的.
:::

::: theorem
线性多步法稳定当且仅当满足根条件.
:::

::: proof
*Proof.* *(充分性)* 仿照收敛性的证明可得.

设线性多步法满足根条件，我们来证明它是稳定的。

考虑线性多步法的两个扰动方程和相应的扰动解 $z_n$ 和 $z_n^*$：
$$\begin{aligned}
\sum_{j=0}^k \alpha_j z_{n+j} &= h \left[ \sum_{j=0}^k \beta_j f(x_{n+j}, z_{n+j}) + s_{n+k} \right] \\
z_\mu &= y_\mu(h) + s_\mu, \quad \mu = 0, 1, \dots, k-1
\end{aligned}$$ 以及 $$\begin{aligned}
\sum_{j=0}^k \alpha_j z_{n+j}^* &= h \left[ \sum_{j=0}^k \beta_j f(x_{n+j}, z_{n+j}^*) + s_{n+k}^* \right] \\
z_\mu^* &= y_\mu(h) + s_\mu^*, \quad \mu = 0, 1, \dots, k-1
\end{aligned}$$ 令误差
$e_n = z_n - z_n^*$。将两个方程相减，得到误差方程：
$$\sum_{j=0}^k \alpha_j (z_{n+j} - z_{n+j}^*) = h \left[ \sum_{j=0}^k \beta_j (f(x_{n+j}, z_{n+j}) - f(x_{n+j}, z_{n+j}^*)) + (s_{n+k} - s_{n+k}^*) \right]$$
即
$$\sum_{j=0}^k \alpha_j e_{n+j} = h \sum_{j=0}^k \beta_j (f(x_{n+j}, z_{n+j}) - f(x_{n+j}, z_{n+j}^*)) + h (s_{n+k} - s_{n+k}^*)$$
我们定义
$F_{n+k} = h \sum_{j=0}^k \beta_j (f(x_{n+j}, z_{n+j}) - f(x_{n+j}, z_{n+j}^*)) + h (s_{n+k} - s_{n+k}^*)$。
利用 $f$ 的 **Lipschitz 条件**
$|f(x, y_1) - f(x, y_2)| \leq L |y_1 - y_2|$，以及扰动条件
$|s_n - s_n^*| \leq \varepsilon$，我们有：
$$|F_{n+k}| \leq h L \sum_{j=0}^k |\beta_j| |e_{n+j}| + h |s_{n+k} - s_{n+k}^*|$$
令 $M_\beta = \sum_{j=0}^k |\beta_j|$，则
$$|F_{n+k}| \leq h L M_\beta \max_{0 \leq \nu \leq k} |e_{n+\nu}| + h \varepsilon$$
误差方程 $\sum_{j=0}^k \alpha_j e_{n+j} = F_{n+k}$ 的解可以表示为：
$$e_n = \sum_{\nu=0}^{k-1} e_{\nu} z_n^{(\nu)} + \frac{1}{\alpha_k} \sum_{j=0}^{n-k} F_{j+k} z_{n-j-1}^{(k-1)}$$
其中 $z_n^{(\nu)}$ 是齐次差分方程 $\sum_{j=0}^k \alpha_j z_{n+j} = 0$
的基本解组。

由于线性多步法满足 **根条件**，存在常数 $Q$ 不依赖于 $n$ 和 $\nu$，使得
$|z_n^{(\nu)}| \leq Q$ 对所有 $n \geq 0$ 和 $\nu = 0, \dots, k-1$ 成立。

取 $e_n$ 表达式的绝对值并放缩：
$$|e_n| \leq \sum_{\nu=0}^{k-1} |e_{\nu}| |z_n^{(\nu)}| + \frac{1}{|\alpha_k|} \sum_{j=0}^{n-k} |F_{j+k}| |z_{n-j-1}^{(k-1)}|$$
$$|e_n| \leq Q \sum_{\nu=0}^{k-1} |e_{\nu}| + \frac{Q}{|\alpha_k|} \sum_{j=0}^{n-k} |F_{j+k}|$$
由初始条件 $e_\mu = z_\mu - z_\mu^* = s_\mu - s_\mu^*$，因此
$\max_{0 \leq \mu \leq k-1} |e_\mu| = \max_{0 \leq \mu \leq k-1} |s_\mu - s_\mu^*| \leq \varepsilon$。
代入 $|F_{j+k}|$ 的上界：
$$|e_n| \leq Q k \varepsilon + \frac{Q}{|\alpha_k|} \sum_{j=0}^{n-k} \left( h L M_\beta \max_{0 \leq \nu \leq k} |e_{j+\nu}| + h \varepsilon \right)$$
$$|e_n| \leq Q k \varepsilon + \frac{Q h L M_\beta}{|\alpha_k|} \sum_{j=0}^{n-k} \max_{0 \leq \nu \leq k} |e_{j+\nu}| + \frac{Q h (n-k+1)}{|\alpha_k|} \varepsilon$$
设我们考虑的区间为 $[a,b]$，则 $x_n = a+nh$，所以 $hn \leq b-a$。因此
$h(n-k+1) \leq hn \leq b-a$。 所以上式变为：
$$|e_n| \leq (Q k + \frac{Q (b-a)}{|\alpha_k|}) \varepsilon + \frac{Q h L M_\beta (k+1)}{|\alpha_k|} \sum_{j=0}^{n} |e_j|$$
（我们将 $\max_{0 \leq \nu \leq k} |e_{j+\nu}|$ 替换为 $(k+1)$ 倍的
$\max |e_j|$，然后放缩为 $\sum |e_j|$）

令 $A_1 = \frac{Q h L M_\beta (k+1)}{|\alpha_k|}$ 和
$B_1 = (Q k + \frac{Q (b-a)}{|\alpha_k|}) \varepsilon$。 则不等式变为：
$$|e_n| \leq B_1 + A_1 \sum_{j=0}^{n} |e_j|$$ 对于 $n=0$:
$|e_0| \leq B_1 + A_1 |e_0|$. 由于 $e_0$ 是初始误差，通常 $A_1$ 包含 $h$
因子，对于足够小的 $h$, $1-A_1 h > 0$. 我们可以将
$A_1 \sum_{j=0}^n |e_j|$ 重新写成
$A_1 \sum_{j=0}^{n-1} |e_j| + A_1 |e_n|$. 那么
$|e_n| (1 - A_1) \leq B_1 + A_1 \sum_{j=0}^{n-1} |e_j|$. 取 $h$
足够小，使得 $A_1 = \frac{Q h L M_\beta (k+1)}{|\alpha_k|} < 1/2$。 则
$1 - A_1 > 1/2$. $$|e_n| \leq 2 B_1 + 2 A_1 \sum_{j=0}^{n-1} |e_j|$$
这符合 Gronwall 不等式的形式。由 Gronwall
不等式引理（或其离散形式）可知： $$|e_n| \leq (2 B_1) e^{2 A_1 n}$$ 将
$A_1$ 和 $B_1$ 的表达式代回：
$$|e_n| \leq 2 \left( Q k + \frac{Q (b-a)}{|\alpha_k|} \right) \varepsilon \cdot \exp\left( 2 \frac{Q h L M_\beta (k+1)}{|\alpha_k|} n \right)$$
由于 $hn \leq b-a$，所以 $hn$ 是有界的。令
$C = \frac{2 Q L M_\beta (k+1)(b-a)}{|\alpha_k|}$ 为一个常数。
$$|e_n| \leq 2 \left( Q k + \frac{Q (b-a)}{|\alpha_k|} \right) \varepsilon \cdot e^C$$
令 $S = 2 \left( Q k + \frac{Q (b-a)}{|\alpha_k|} \right) e^C$。显然 $S$
是一个与 $\varepsilon$ 无关的常数。 因此，我们得到：
$$|e_n| \leq S \varepsilon$$ 这正是线性多步法稳定的定义。

所以，如果线性多步法满足根条件，那么它是稳定的。

*(必要性)* 考虑微分方程 $y' = 0$. 相应的多步法为
$$\sum_{j=0}^k \alpha_j y_{n+j} = 0$$ 考虑扰动 $s_n$, $s_n^*$, 满足
$s_n = s_n^* = 0$, $n = k, k+1, \dots$. 则 $z_n$, $z_n^*$ 均满足
$$\sum_{j=0}^k \alpha_j y_{n+j} = 0$$

设 $e_n = z_n - z_n^*$ 满足 $$\begin{aligned}
\sum_{j=0}^k \alpha_j e_{n+j} = 0
\end{aligned}$$ 则 $$\begin{aligned}
e_n = \sum_{j=1}^{k_0} \sum_{\ell=1}^{r_j} c_{j,\ell} n^{\ell-1} \lambda_j^n
\end{aligned}$$ 其中 $\lambda_j$ 为特征方程 $p(\lambda) = 0$ 的根，$r_j$
为 $\lambda_j$ 的重数。 ◻
:::

由稳定性得 $$\begin{aligned}
|e_n| \leq S \max_{0 \leq j \leq k-1} |s_j - s_j^*|
\end{aligned}$$ 从而 $$\begin{aligned}
|\lambda_j| < 1 \quad \text{或者} \quad |\lambda_j| = 1, \, r_j = 1
\end{aligned}$$

### 绝对稳定性 {#绝对稳定性 .unnumbered}

考虑试验方程 $$\begin{aligned}
y' = \lambda y
\end{aligned}$$ 代入多步法得 $$\begin{aligned}
\sum_{j=0}^k \alpha_j y_{n+j} = \lambda h \sum_{j=0}^k \beta_j y_{n+j}
\end{aligned}$$

差分方程的特征方程为 $$\begin{aligned}
p(r) - \lambda h q(r) = 0
\end{aligned}$$ 令 $$\begin{aligned}
\pi(r, \lambda h) = p(r) - \lambda h q(r)
\end{aligned}$$ 稳定性多项式

::: definition
对于给定的 $\lambda h$，如果 $\pi(r, \lambda h)$ 的根满足
$$|r_s| < 1, \quad s = 1, 2, \ldots, k$$ 则称线性多步法关于此
$\lambda h$ 绝对稳定.
:::

::: definition
$$\begin{aligned}
\{ \lambda h \in \mathbb{C}: \, & \text{线性多步法关于 } \lambda h \text{ 绝对稳定} \} & \textbf{绝对稳定性区域}\\
\{ \lambda h \in \mathbb{R}: \, & \text{线性多步法关于 } \lambda h \text{ 绝对稳定} \} & \textbf{绝对稳定性区间}
\end{aligned}$$
:::

::: example
$y_{n+2} = y_{n+1} + \frac{h}{2} \left[ 3f(x_{n+1}, y_{n+1}) - f(x_n, y_n) \right]$

的绝对稳定性区域.
:::

解: 稳定性多项式为
$$\pi(r, \lambda h) = r^2 - r - \frac{1}{2} \lambda h (3r - 1)$$

$$\lambda h = \frac{2(r^2 - r)}{3r - 1}$$

取 $r = e^{i\theta}$ 代入得
$$\lambda h = \frac{2(e^{i2\theta} - e^{i\theta})}{3e^{i\theta} - 1} = x(\theta) + i y(\theta)$$

$$x(\theta) = \frac{-\cos 2\theta + 4\cos \theta - 3}{5 - 3 \cos \theta}$$
$$y(\theta) = \frac{4 \sin \theta - \sin 2\theta}{5 - 3 \sin \theta}$$

::: example
考虑以下差分方程：
$$y_{n+1} = y_n + \frac{h}{2} \left[ f(x_n, y_n) + f(x_{n+1}, y_{n+1}) \right]$$
的绝对稳定性区域。
:::

::: proof
*Proof.* 稳定性多项式为：
$$\pi(r, \lambda h) = r - 1 - \frac{1}{2} \lambda h (1 + r)$$

解得： $$\lambda h = \frac{2(r-1)}{r+1}$$

令 $r = e^{i\theta}$，则有：
$$\lambda h = \frac{i \sin \theta}{1 + \cos \theta}$$ ◻
:::

::: example
考虑 Simpson 方法：
$$y_{n+2} = y_n + \frac{h}{3} \left[ f(x_n, y_n) + 4f(x_{n+1}, y_{n+1}) + f(x_{n+2}, y_{n+2}) \right]$$
的绝对稳定性区域。
:::

::: proof
*Proof.* 稳定性多项式为：
$$\pi(r, \lambda h) = r^2 - 1 - \frac{1}{3} \lambda h (r^2 + 4r + 1)$$

绝对稳定性区域的边界为：
$$\lambda h = \frac{e^{i2\theta} - 1}{\frac{1}{3}(e^{i2\theta} + 4e^{i\theta} + 1)} = \frac{3i \sin \theta}{2 + \cos \theta}$$

因此，Simpson 方法的绝对稳定性区域为空集。 ◻
:::

## Hamilton 系统的辛几何算法

### Hamilton 系统 {#hamilton-系统 .unnumbered}

设 $M \subset \mathbb{R}^d$，$H: \mathbb{R}^d \times M \to \mathbb{R}$
为 $C^1$ 函数。下列一阶 ODE 系统称为一个 Hamilton 系统： $$\begin{cases}
\frac{dp}{dt} = -\frac{\partial H}{\partial q}(p, q) \\
\frac{dq}{dt} = \frac{\partial H}{\partial p}(p, q)
\end{cases}
\tag{8.8.1}$$ 其中 $H$ 称为相应的 Hamilton 量（Hamiltonian）。

::: example
$$H(p, q) = \frac{p^2}{2m} + \frac{1}{2}kq^2$$ 其中 $m$: 质量，$k$:
弹性系数。
:::

::: example
$$H(p, q) = \frac{1}{2}p^2 - \cos q$$
:::

::: proposition
在 Hamilton 系统中，$H$ 是不变量
:::

::: proof
*Proof.*
$$\frac{dH(p, q)}{dt} = \frac{\partial H}{\partial p}\frac{dp}{dt} + \frac{\partial H}{\partial q}\frac{dq}{dt} = 0$$
证毕。 ◻
:::

### Hamilton 系统的另一种形式 {#hamilton-系统的另一种形式 .unnumbered}

令
$x = (p, q)^T$，$J = \begin{pmatrix} 0 & I \\ -I & 0 \end{pmatrix} \in \mathbb{R}^{2d \times 2d}$，则
Hamilton 系统可写为： $$\frac{dx}{dt} = J^{-1} \nabla H(x),
\tag{8.8.2}$$

::: definition
若 $A \in \mathbb{R}^{2d \times 2d}$ 满足 $$A^T J A = J$$ 则称 $A$
为辛矩阵。
:::

::: definition
若 $g: U \subset \mathbb{R}^{2d} \to \mathbb{R}^{2d}$
为可微映射，且对任意 $(p, q) \in U$ 有 $$g'(p, q)^T J g'(p, q) = J$$
其中 $g'(p, q)$ 为 $g$ 的 Jacobian 矩阵，则称 $g$ 为辛映射。
:::

::: theorem
若 $g$ 是一个辛映射，$x$ 满足 Hamilton 系统
$$\frac{dx}{dt} = J^{-1} \nabla H(x)$$ 则 $y = g(x)$ 也满足一个 Hamilton
系统 $$\frac{dy}{dt} = J^{-1} \nabla G(y),$$ 其中 $G(y) = H(x)$。
:::

::: proof
*Proof.* $$\frac{dy}{dt} = g'(x)\frac{dx}{dt}$$
$$= g'(x) J^{-1} \frac{\partial H}{\partial x}$$
$$= g'(x)^T J^{-1} g'(x) \nabla G(y(x))$$ $$= J^{-1} \nabla G$$ 证毕。 ◻
:::

::: definition
$\phi_t: U \subset \mathbb{R}^{2d} \to \mathbb{R}^{2d}$，$\phi_t(p_0, q_0) = (p(t, p_0, q_0), q(t, p_0, q_0))$
称为 Hamilton 系统对应的流，初值为 $p_0, q_0$。
:::

::: theorem
若 $H$ 是阶可微，则相应的流 $\phi_t$ 为辛映射。
:::

::: proof
*Proof.* 令 $y_0 = (p_0, q_0)$，则
$$\frac{d}{dt} \left( \frac{\partial \phi_t}{\partial y_0} \right) = \frac{\partial}{\partial y_0} \left( \frac{d \phi_t}{dt} \right)$$
$$= \frac{\partial}{\partial y_0} \left( J^{-1} \nabla H(\phi_t(y_0)) \right)$$
$$= \frac{d}{dt} \left( \frac{\partial \phi_t}{\partial y_0} \right)^T J \left( \frac{\partial \phi_t}{\partial y_0} \right)$$
$$= \left( \frac{\partial \phi_t}{\partial y_0} \right)^T \nabla^2 H(\phi_t(y_0)) \frac{\partial \phi_t}{\partial y_0}$$
$$+ \left( \frac{\partial \phi_t}{\partial y_0} \right)^T J J^{-1} \nabla H(\phi_t(y_0))$$
$$= 0$$ 所以
$$\left( \frac{\partial \phi_t}{\partial y_0} \right)^T J \left( \frac{\partial \phi_t}{\partial y_0} \right) = J$$
证毕。 ◻
:::

::: theorem
$f: U \subset \mathbb{R}^{2d} \to \mathbb{R}^{2d}$ 连续可微，则
$\frac{dx}{dt} = f(x)$ 是局部 Hamilton 系统 当且仅当其相应的流
$\phi_t(x)$ 对于任意 $x \in U$ 及充分小的 $t$ 是辛映射。
:::

::: proof
*Proof.* 设 $\phi_t$ 是辛映射，则有
$$0 = \frac{d}{dt} \left( \frac{\partial \phi_t}{\partial y_0} \right)^T J \left( \frac{\partial \phi_t}{\partial y_0} \right)$$
$$= \left( \frac{\partial \phi_t}{\partial y_0} \right)^T \left[ f'(\phi_t(y_0))^T J + J f'(\phi_t(y_0)) \right] \left( \frac{\partial \phi_t}{\partial y_0} \right)$$
取 $t = 0$，则 $\frac{\partial \phi_t}{\partial y_0} = I$
$$J f'(y_0) = -f'(y_0)^T J = f'(y_0)^T J^T$$ 令
$$H(y) = \int_0^1 y^T J f(y_0 + t y) \, dt$$ 则
$$\frac{\partial H}{\partial y_k}(y) = \int_0^1 J_k f(y_0 + t z) + y^T J \frac{\partial f}{\partial y_k}(y_0 + t z) t \, dt$$
$$= \int_0^1 J_k f(y_0 + t z) + t J_k \frac{\partial f}{\partial y}(y_0 + t z) z \, dt$$
$$= \int_0^1 \frac{d}{dt} \left( t J_k f(y_0 + t z) \right) \, dt$$
$$= J_k f(y)$$ 证毕。 ◻
:::

### 保辛结构算法 (Symplectic methods) {#保辛结构算法-symplectic-methods .unnumbered}

考虑 Hamilton 系统 $$x = (P, \mathcal{Q})^T$$ $$\begin{cases}
\frac{dx}{dt} = f(x) = J^{-1} \nabla H(x) \\
x(0) = x_0 \in \mathbb{R}^{2d}
\end{cases} \quad (8.8.3)$$

::: definition
单步法 $\Phi_{\Delta t}(P^k, \mathcal{Q}^k)$ 被称为是辛算法 如果 对于
任意 $(P, \mathcal{Q})$ 以及 任意 $\Delta t$ 有
$$\Phi_{\Delta t}'(P, \mathcal{Q})^T J \Phi_{\Delta t}'(P, \mathcal{Q}) = J$$
:::

::: theorem
$$\begin{cases}
P^{k+1} = P^k - \Delta t \frac{\partial H}{\partial \mathcal{Q}} (P^{k+1}, \mathcal{Q}^k) \\
\mathcal{Q}^{k+1} = \mathcal{Q}^k + \Delta t \frac{\partial H}{\partial P} (P^{k+1}, \mathcal{Q}^k)
\end{cases} \quad (8.8.4)$$ 是辛算法.
:::

::: proof
*Proof.* 令
$\Phi_{\Delta t}'(P^k, \mathcal{Q}^k) = \frac{\partial (P^{k+1}, \mathcal{Q}^{k+1})}{\partial (P^k, \mathcal{Q}^k)}$
由 $(8.8.4)$ 可得 $$\begin{pmatrix}
I + \Delta t \frac{\partial^2 H}{\partial P \partial \mathcal{Q}} & 0 \\
-\Delta t \frac{\partial^2 H}{\partial P^2} & I
\end{pmatrix}
\Phi_{\Delta t}'(P^k, \mathcal{Q}^k) =
\begin{pmatrix}
I & -\Delta t \frac{\partial^2 H}{\partial \mathcal{Q}^2} \\
0 & I + \Delta t \frac{\partial^2 H}{\partial P \partial \mathcal{Q}}
\end{pmatrix}$$直接计算可验证$$\Phi_{\Delta t}'(P^k, \mathcal{Q}^k)^T J \Phi_{\Delta t}'(P^k, \mathcal{Q}^k) = J \quad \text{证毕.}$$ ◻
:::

::: remark
$$\begin{cases}
P^{k+1} = P^k - \Delta t \frac{\partial H}{\partial \mathcal{Q}} (P^k, \mathcal{Q}^k) \\
\mathcal{Q}^{k+1} = \mathcal{Q}^k + \Delta t \frac{\partial H}{\partial P} (P^k, \mathcal{Q}^k)
\end{cases} \quad (8.8.5)$$ 是辛算法.

$$\begin{cases}
P^{k+\frac{1}{2}} = P^k - \frac{\Delta t}{2} \frac{\partial H}{\partial \mathcal{Q}} (P^{k+\frac{1}{2}}, \mathcal{Q}^k) \\
\mathcal{Q}^{k+1} = \mathcal{Q}^k + \frac{\Delta t}{2} \left( \frac{\partial H}{\partial P} (P^{k+\frac{1}{2}}, \mathcal{Q}^k) + \frac{\partial H}{\partial P} (P^{k+\frac{1}{2}}, \mathcal{Q}^{k+1}) \right) \\
P^{k+1} = P^{k+\frac{1}{2}} - \frac{\Delta t}{2} \frac{\partial H}{\partial \mathcal{Q}} (P^{k+\frac{1}{2}}, \mathcal{Q}^{k+1})
\end{cases}$$ 称为 Leap-frog 算法 (Verlet 方法, Störmer-Verlet)
:::

::: theorem
Leap-frog 算法是辛的.
:::

::: proof
*Proof.* Leap-frog 可以看作是 $(8.8.4)$ $(8.8.5)$ 的复合 $$\begin{cases}
P^{k+\frac{1}{2}} = P^k - \frac{\Delta t}{2} \frac{\partial H}{\partial \mathcal{Q}} (P^{k+\frac{1}{2}}, \mathcal{Q}^k) \\
\mathcal{Q}^{k+\frac{1}{2}} = \mathcal{Q}^k + \frac{\Delta t}{2} \frac{\partial H}{\partial P} (P^{k+\frac{1}{2}}, \mathcal{Q}^k)
\end{cases}$$ $$\begin{cases}
P^{k+1} = P^{k+\frac{1}{2}} - \frac{\Delta t}{2} \frac{\partial H}{\partial \mathcal{Q}} (P^{k+\frac{1}{2}}, \mathcal{Q}^{k+1}) \\
\mathcal{Q}^{k+1} = \mathcal{Q}^{k+\frac{1}{2}} + \frac{\Delta t}{2} \frac{\partial H}{\partial P} (P^{k+\frac{1}{2}}, \mathcal{Q}^{k+1})
\end{cases}$$ 容易验证辛映射的复合仍是辛映射. 证毕. ◻
:::

::: definition
单步法 $\Phi_{\Delta t}$ 称为是对称的如果
$$\Phi_{\Delta t} = \Phi_{-\Delta t}^{-1} \doteq \Phi_{\Delta t}^* \quad (\text{对偶})$$
:::

::: theorem
Leap-frog 是对称的.
:::

::: remark
$(8.8.4)$ $(8.8.5)$ 互为对偶算法.
:::

### 保守恒量算法 {#保守恒量算法 .unnumbered}

::: definition
$\Phi_{\Delta t}$ 保持守恒量 $F$ 如果 对于 任意
$P, \mathcal{Q}, \Delta t$
$$F(\Phi_{\Delta t}(P, \mathcal{Q})) = F(P, \mathcal{Q})$$
:::

::: theorem
Leap-frog 方法保持线性守恒量 和 具有下列形式的二次守恒量
$$F(P, \mathcal{Q}) = P^T(B\mathcal{Q}+b)$$
:::

::: proof
*Proof.* 设 $F(P, \mathcal{Q}) = b^T\mathcal{Q}+c^T P$ 是一个线性守恒量,
则有
$$b^T \frac{\partial H}{\partial P} (P, \mathcal{Q}) - c^T \frac{\partial H}{\partial \mathcal{Q}} (P, \mathcal{Q}) = 0$$
由此易得 Leap-frog 的守恒性.

对于二次守恒量 $F(P, \mathcal{Q}) = P^T(B\mathcal{Q}+b)$
$$\frac{dF}{dt} = -(\frac{\partial H}{\partial \mathcal{Q}})^T (B\mathcal{Q}+b) + P^T(B \frac{\partial H}{\partial P}) = 0$$
Leap-frog 为 $(8.8.4)$ $(8.8.5)$ 复合. 且 $$\begin{aligned}
(P^{k+1})^T (B\mathcal{Q}^{k+1}+b) &= (P^{k+\frac{1}{2}} - \frac{\Delta t}{2} \frac{\partial H}{\partial \mathcal{Q}} (P^{k+\frac{1}{2}}, \mathcal{Q}^{k+1}))^T (B(\mathcal{Q}^{k+\frac{1}{2}} + \frac{\Delta t}{2} B \frac{\partial H}{\partial P} (P^{k+\frac{1}{2}}, \mathcal{Q}^{k+1}))+b) \\
&= (P^{k+\frac{1}{2}})^T (B\mathcal{Q}^{k+\frac{1}{2}}+b) + \frac{\Delta t}{2} (P^{k+\frac{1}{2}})^T B \frac{\partial H}{\partial P} (P^{k+\frac{1}{2}}, \mathcal{Q}^{k+1}) \\
&- \frac{\Delta t}{2} (\frac{\partial H}{\partial \mathcal{Q}} (P^{k+\frac{1}{2}}, \mathcal{Q}^{k+1}))^T (B\mathcal{Q}^{k+\frac{1}{2}}+b) \\
&= (P^{k+\frac{1}{2}})^T (B\mathcal{Q}^{k+\frac{1}{2}}+b) \quad \text{证毕.}
\end{aligned}$$ ◻
:::

::: remark
Leap-frog 对于一般 Hamilton 量不守恒
$H(P, \mathcal{Q}) = \frac{1}{2} (P^2+\mathcal{Q}^2)$ $$\begin{pmatrix}
P^{k+1} \\
\mathcal{Q}^{k+1}
\end{pmatrix} =
\begin{pmatrix}
1 - \frac{\Delta t^2}{2} & -\Delta t (1 - \frac{\Delta t^2}{4}) \\
\Delta t & 1 - \frac{\Delta t^2}{2}
\end{pmatrix}
\begin{pmatrix}
P^k \\
\mathcal{Q}^k
\end{pmatrix}$$ 能量不守恒.
:::

### 保体积算法 {#保体积算法 .unnumbered}

::: theorem
辛映射 $\Phi: U \to \mathbb{R}^{2d}$ 保持体积, 即
$Vol(\Phi(\Omega)) = Vol(\Omega)$, $\forall \Omega \subset U$.
:::

::: proof
*Proof.* 由 $(\Phi_t')^T J \Phi_t' = J$ 可得 $$\begin{aligned}
1 &= \det(J) \\
&= \det((\Phi_t')^T J \Phi_t') \\
&= |\det(\Phi_t')|^2
\end{aligned}$$ $\implies |\det(\Phi_t')| = 1$.

另一方面
$$Vol(\Phi(\Omega)) = \int_\Omega |\det(\Phi_t'(y))| dy = Vol(\Omega).$$
证毕. ◻
:::

::: theorem
(Liouville) 设 $f: \mathbb{R}^d \rightarrow \mathbb{R}^d$ 连续可微且
$\nabla \cdot f(x) = 0$, $\forall x$. 则 $\frac{dx}{dt} = f(x)$ 对应的流
$\phi_t$ 保体积.
:::

::: proof
*Proof.* 首先
$$\frac{d\phi_t(y)}{dt} = f(\phi_t(y))$$则$$\frac{d}{dt} \phi_t'(y) = f'(\phi_t(y)) \phi_t'(y)$$$$\implies \left(\frac{d}{dt} \phi_t'(y)\right) \phi_t'(y)^{-1} = f'(\phi_t(y))$$$$\implies 0 = tr(f'(\phi_t(y))) = tr\left(\left(\frac{d}{dt} \phi_t'(y)\right) \phi_t'(y)^{-1}\right)$$Jacobi
公式：
$\frac{d}{dt} (\det \phi_t'(y)) = \det \phi_t'(y) tr\left(\left(\frac{d}{dt} \phi_t'(y)\right) \phi_t'(y)^{-1}\right)$$$\implies \det \phi_t'(y) = \det \phi_{t=0}'(y) = I$$
证毕. ◻
:::

::: remark
Hamilton 系统保体积. 保体积系统不一定是 Hamilton 系统. 对于 Hamilton
系统, 辛格式保体积. 对于一般保体积系统, 没有一般能保体积算法.
:::

### 分裂格式 {#分裂格式 .unnumbered}

考虑 Hamilton 系统
$$\frac{dx}{dt} = f(x) = J^{-1} \nabla H(x), \quad H(x) = H_1(x) + H_2(x)$$
设 $\frac{dx}{dt} = J^{-1} \nabla H_1(x)$,
$\frac{dx}{dt} = J^{-1} \nabla H_2(x)$ 均可以精确求解, $\phi_t^{(1)}$,
$\phi_t^{(2)}$ 分别是对应流.

则可构造分裂形式的辛格式 (一阶)
$\Phi_{\Delta t} = \Phi_{\Delta t}^{(2)} \circ \Phi_{\Delta t}^{(1)}$,
$\Phi_{\Delta t}^* = \Phi_{\Delta t}^{(1)} \circ \Phi_{\Delta t}^{(2)}$
(二阶)
$\Phi_{\Delta t} = \Phi_{\Delta t/2}^{(2)} \circ \Phi_{\Delta t}^{(1)} \circ \Phi_{\Delta t/2}^{(2)}$
或
$\Phi_{\Delta t/2}^{(1)} \circ \Phi_{\Delta t}^{(2)} \circ \Phi_{\Delta t/2}^{(1)}$

考虑可分的 Hamilton 量 $H(P, \mathcal{Q}) = U(P)+V(\mathcal{Q})$
以及分裂的 Hamilton 系统 $$\begin{cases}
\frac{dP}{dt} = 0 \\
\frac{d\mathcal{Q}}{dt} = \frac{\partial U}{\partial P}(P) \\
P(0)=P_0, \mathcal{Q}(0)=\mathcal{Q}_0
\end{cases}
\quad
\begin{cases}
\frac{dP}{dt} = -\frac{\partial V}{\partial \mathcal{Q}}(\mathcal{Q}) \\
\frac{d\mathcal{Q}}{dt} = 0 \\
P(0)=P_0, \mathcal{Q}(0)=\mathcal{Q}_0
\end{cases}$$上述系统能解为$$\begin{cases}
P(t) = P_0 \\
\mathcal{Q}(t) = \mathcal{Q}_0 + t \frac{\partial U}{\partial P}(P_0)
\end{cases}
\quad
\begin{cases}
P(t) = P_0 - t \frac{\partial V}{\partial \mathcal{Q}}(\mathcal{Q}_0) \\
\mathcal{Q}(t) = \mathcal{Q}_0
\end{cases}$$ 则辛 Euler 格式可写作
$\Phi_{\Delta t}^U \circ \Phi_{\Delta t}^V$ 或
$\Phi_{\Delta t}^V \circ \Phi_{\Delta t}^U$. Leap-frog 格式为
$\Phi_{\Delta t/2}^V \circ \Phi_{\Delta t}^U \circ \Phi_{\Delta t/2}^V$.

### Runge-Kutta 格式 {#runge-kutta-格式 .unnumbered}

考虑 Runge-Kutta 格式 $$\begin{cases}
x_{i,k} = x^k + \Delta t \sum_{j=1}^m a_{ij} f(x_{j,k}) \\
x^{k+1} = x^k + \Delta t \sum_{j=1}^m b_j f(x_{j,k})
\end{cases}$$

::: theorem
1.  Runge-Kutta 格式保线性不变量

2.  若 $b_i a_{ij} + b_j a_{ji} - b_i b_j = 0$, $i, j = 1, \dots, m$
    (8.8.6) 则 Runge-Kutta 格式保二次不变量.
:::

::: proof
*Proof.* 设 $F(x) = C^T x$ 是线性不变量. 则
$\frac{dF}{dt} = C^T \frac{dx}{dt} = C^T f(x) = 0$.
$F(\Phi_{\Delta t}(x^k)) = C^T (x^k + \Delta t \sum_{j=1}^m b_j f(x_{j,k})) = C^T x^k$.
设 $F(x) = x^T C x$ 为二次不变量, $C \in \mathbb{R}^{d \times d}$
为对称矩阵. 则
$$\frac{dF}{dt} = x^T C \frac{dx}{dt} + \frac{dx^T}{dt} C x = 2x^T C f(x) = 0$$
$$\implies x^T C f(x) = 0$$ $$\begin{aligned}
F(\Phi_{\Delta t}(x^k)) &= (x^k + \Delta t \sum_{j=1}^m b_j f(x_{j,k}))^T C (x^k + \Delta t \sum_{j=1}^m b_j f(x_{j,k})) \\
&= (x^k)^T C x^k + \Delta t \sum_{j=1}^m b_j (x^k)^T C f(x_{j,k}) + \Delta t \sum_{j=1}^m b_j f(x_{j,k})^T C x^k \\
&+ (\Delta t)^2 \sum_{i=1}^m \sum_{j=1}^m b_i b_j f(x_{i,k})^T C f(x_{j,k})
\end{aligned}$$ 另一方面
$x^k = x_{i,k} - \Delta t \sum_{j=1}^m a_{ij} f(x_{j,k})$. 由此可得
$$F(\Phi_{\Delta t}(x^k)) = (x^k)^T C x^k - (\Delta t)^2 \sum_{i=1}^m \sum_{j=1}^m (b_i a_{ij} + b_j a_{ji} - b_i b_j) f(x_{i,k})^T C f(x_{j,k}) = (x^k)^T C x^k$$
证毕. ◻
:::

::: theorem
满足 $(8.8.6)$ 的 Runge-Kutta 格式是辛格式.
:::

::: proof
*Proof.* 令
$\Psi(t) = \frac{\partial \phi_t(x_0)}{\partial x_0} = \phi_t'$ 则有
$$\begin{cases}
\frac{dx}{dt} = f(x) \\
\frac{d\Psi}{dt} = f'(x) \Psi \\
x(t_k) = x^k, \Psi(t_k) = I
\end{cases}$$ 用 Runge-Kutta 格式求解一步上述 ODE 系统, 得到
$x^{k+1}, \Psi^{k+1}$. 由于 $\Psi^T J \Psi$ 是上述系统的二次不变量, 则有
$$(\Psi^{k+1})^T J \Psi^{k+1} = J$$ 下面只需证
$\Psi^{k+1} = \frac{\partial x^{k+1}}{\partial x^k}$. 由 Runge-Kutta
格式得
$$\frac{\partial x^{k+1}}{\partial x^k} = I + \Delta t \sum_{i=1}^m b_i f'(x_{i,k}) \frac{\partial x_{i,k}}{\partial x^k}$$
$$\frac{\partial x_{i,k}}{\partial x^k} = I + \Delta t \sum_{j=1}^m a_{ij} f'(x_{j,k}) \frac{\partial x_{j,k}}{\partial x^k}$$
同时有
$$\Psi^{k+1} = I + \Delta t \sum_{i=1}^m b_i f'(x_{i,k}) \Psi_{i,k}$$
$$\Psi_{i,k} = I + \Delta t \sum_{j=1}^m a_{ij} f'(x_{j,k}) \Psi_{j,k}$$
对比上述格式可得
$$\Psi^{k+1} = \frac{\partial x^{k+1}}{\partial x^k}, \quad \Psi_{i,k} = \frac{\partial x_{i,k}}{\partial x^k}$$
证毕. ◻
:::

::: example
中点 Euler 格式
$$x^{k+1} = x^k + \Delta t f\left(\frac{x^k+x^{k+1}}{2}\right)$$
二级四阶隐式 RK 格式
$$x^{k+1} = x^k + \frac{1}{2} \Delta t (f(k_1) + f(k_2))$$
$$k_1 = x^k + \Delta t \left( \frac{1}{4} f(k_1) + \left(\frac{1}{4} - \frac{\sqrt{3}}{6}\right) f(k_2) \right)$$
$$k_2 = x^k + \Delta t \left( \left(\frac{1}{4} + \frac{\sqrt{3}}{6}\right) f(k_1) + \frac{1}{4} f(k_2) \right)$$
:::
