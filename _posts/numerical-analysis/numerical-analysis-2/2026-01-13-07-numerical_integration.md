---
layout: post
title: "Numerical Analysis II 数值积分"
permalink: /posts/numerical-analysis-2-07-数值积分/
tags: numerical-analysis
use_math: true
---

# 数值积分

计算定积分 $\int_a^b p(x)f(x)\,dx$

设：

-   $p$: 权函数

-   $f$: 被积函数

找出近似求积公式

$$\int_a^b p(x)f(x)\,dx \approx \sum_{k=0}^n A_k f(x_k)$$

其中：

-   $x_k$, $k=0,\dots,n$: 求积节点

-   $A_k$, $k=0,\dots,n$: 求积系数

定义误差为：
$$E_n(f) = \int_a^b p(x)f(x)\,dx - \sum_{k=0}^n A_k f(x_k)$$

**Definition**
如果 $E_n(x^m) = 0$, $m=0,\dots,k$ 且
$E_n(x^{k+1}) \neq 0$，则称求积公式具有 $k$ 次代数精度。
:::

**Example**
给定求积公式为如下形式：
$$\int_0^1 f(x)\,dx \approx c_0 f(0) + c_1 f(x_1)$$ 求 $x_1$, $c_0$,
$c_1$，使得求积公式代数精度最高。

解：未知数为 3 个，故至少可要求对于 $1$, $x$, $x^2$
求积公式精确成立。由此可得： 
$$\begin{aligned}
\int_0^1 1\,dx &= 1 = c_0 + c_1 \\
\int_0^1 x\,dx &= \frac{1}{2} = c_1 x_1 \\
\int_0^1 x^2\,dx &= \frac{1}{3} = c_1 x_1^2
\end{aligned}$$
 由此可解得：
$$x_1 = \frac{2}{3}, \quad c_1 = \frac{3}{4}, \quad c_0 = \frac{1}{4}$$
对于 $x^3$ 有：
$$\int_0^1 x^3\,dx = \frac{1}{4} \neq \frac{3}{4} \left(\frac{2}{3}\right)^3 = \frac{2}{9}$$
故代数精度为 2。
:::

---

## 插值型求积公式

设 $x_0,\dots,x_n \in [a,b]$ 为求积节点，构造 $n$ 次 Lagrange
插值多项式： $$L_n(x) = \sum_{k=0}^n f(x_k) l_k(x)$$ 其中：
$$l_k(x) = \prod_{\substack{j=0 \\ j \neq k}}^n \frac{x-x_j}{x_k-x_j}, \quad k=0,1,\dots,n$$

于是： 
$$\begin{aligned}
\int_a^b p(x)f(x)\,dx &= \int_a^b p(x)L_n(x)\,dx + \int_a^b p(x)R_n(x)\,dx \\
&= \sum_{k=0}^n \int_a^b p(x)l_k(x)\,dx \cdot f(x_k) + \int_a^b p(x)R_n(x)\,dx  
\end{aligned}
\tag{7.1.1}$$ 其中： $$A_k = \int_a^b p(x)l_k(x)\,dx$$

(7.1.1) 称为插值型求积公式。

$n$ 次 Lagrange 插值多项式余项为：
$$R_n(x) = \frac{1}{(n+1)!} f^{(n+1)}(\xi(x)) \omega_{n+1}(x)$$
由此可得：
$$E_n(f) = \frac{1}{(n+1)!} \int_a^b p(x) f^{(n+1)}(\xi(x)) \omega_{n+1}(x)\,dx$$
$\Rightarrow$ 求积公式 (7.1.1) 代数精度至少为 $n$。

反之，若求积公式代数精度至少为 $n$，则有：
$$\int_a^b p(x)l_k(x)\,dx = \sum_{j=0}^n A_j l_k(x_j) = A_k, \quad k=0,1,\dots,n$$
$\Rightarrow$ 该求积公式为插值型求积公式。

---

## Newton-Cotes 求积公式

在 $[a,b]$ 取端点 $a$, $b$ 为求积节点，则可得梯形求积公式：
$$I_1(f) = \frac{b-a}{2} \left[f(a) + f(b)\right] \tag{7.2.1}$$

**Theorem**
设 $f, g \in C[a,b]$ 且 $g(x)$ 在 $[a,b]$ 上不变号，则存在
$\xi \in [a,b]$ 使得：
$$\int_a^b f(x)g(x)\,dx = f(\xi) \int_a^b g(x)\,dx$$
:::

**Theorem**
$f \in C^2[a,b]$，梯形求积公式的误差为： 
$$\begin{aligned}
E_1(f) &= \int_a^b f(x)\,dx - \frac{b-a}{2} \left[f(a) + f(b)\right] \\
&= -\frac{(b-a)^3}{12} f''(\eta), \quad \eta \in [a,b]
\end{aligned}$$

:::


*Proof.* 利用 Newton 均差得： $$R_1(x) = f[a,b,x] \omega_2(x)$$
$\Rightarrow$ $$E_1(f) = \int_a^b f[a,b,x] \omega_2(x)\,dx$$ 由于
$\omega_2(x)$ 不变号，可得：
$$E_1(f) = f[a,b,\xi] \int_a^b \omega_2(x)\,dx = -\frac{(b-a)^3}{12} f''(\eta), \quad \eta \in [a,b]$$
取求积节点为 $x_0=a$, $x_1=\frac{1}{2}(a+b)$,
$x_2=b$，利用二次插值多项式，可得：
$$I_2(f) = \frac{b-a}{6} \left[f(a) + 4f\left(\frac{a+b}{2}\right) + f(b)\right]$$
称为 Simpson 求积公式。 ◻
:::

**Theorem**
设 $f \in C^4[a,b]$，Simpson 求积公式的误差为
$$E_2(f) = -\frac{(b-a)^5}{2880} f^{(4)}(\eta), \quad \eta \in [a,b].$$
:::


*Proof.* 二次插值多项式的余项为
$$R_2(x) = f[a, \frac{a+b}{2}, b, x] w_3(x),$$ 其中
$$w_3(x) = (x-a)\left(x-\frac{a+b}{2}\right)(x-b).$$ 于是有
$$E_2(f) = \int_a^b R_2(x) \, dx = \int_a^b f[a, \frac{a+b}{2}, b, x] w_3(x) \, dx.$$
注意到
$$x - \frac{1}{2}(a+b) = \frac{1}{2} \frac{d}{dx} \left((x-a)(x-b)\right),$$
从而有 
$$\begin{aligned}
E_2(f) &= \frac{1}{2} \int_a^b f[a, \frac{a+b}{2}, b, x] (x-a)(x-b) \, d\left((x-a)(x-b)\right) \\
&= \frac{1}{4} \int_a^b f[a, \frac{a+b}{2}, b, x] \, d\left[(x-a)^2(x-b)^2\right] \\
&= -\frac{1}{4} \int_a^b (x-a)^2(x-b)^2 f[a, \frac{a+b}{2}, b, x] \, dx.
\end{aligned}$$
 利用重节点均差的性质，可以进一步化简为
$$E_2(f) = -\frac{(b-a)^5}{2880} f^{(4)}(\eta), \quad \eta \in [a,b].$$ ◻
:::

一般情况：Newton-Cotes 求积公式

将区间 $[a,b]$ 分成 $n$ 等份，令 $x_k = a + kh$, $h = \frac{b-a}{n}$,
$k=0,1,\dots,n$。函数 $f$ 在 $[a,b]$ 上关于节点 $x_k$ 的 $n$ 阶 Lagrange
插值多项式为
$$L_n(x) = \sum_{k=0}^n f(x_k) l_k(x), \quad l_k(x) = \prod_{\substack{j=0 \\ j \neq k}}^n \frac{x-x_j}{x_k-x_j}.$$
由此可得求积公式
$$\int_a^b f(x) \, dx \approx \int_a^b L_n(x) \, dx = \sum_{k=0}^n f(x_k) \int_a^b l_k(x) \, dx.$$
令 $C_k^{(n)} = \frac{1}{b-a} \int_a^b l_k(x) \, dx$，则有
$$\int_a^b f(x) \, dx \approx (b-a) \sum_{k=0}^n C_k^{(n)} f(x_k).$$
称为 $n$ 阶 Newton-Cotes 求积公式，其中 $C_k^{(n)}$ 称为 Cotes
求积系数。

**Definition**
$C_k^{(n)}$ 定义为 $$C_k^{(n)} = \frac{1}{b-a} \int_a^b l_k(x) \, dx.$$
并且有
$$C_k^{(n)} = C_{n-k}^{(n)}, \quad k=0,1,\dots,\lfloor n/2 \rfloor.$$
:::

**Theorem**
$n$ 阶 Newton-Cotes 求积公式的误差为：

1.  若 $n$ 为偶数，设 $f \in C^{n+2}[a,b]$，则
    $$E_n(f) = \frac{C_n}{(n+2)!} f^{(n+2)}(\eta), \quad \eta \in [a,b],$$
    其中 $$C_n = \int_a^b x w_{n+1}(x) \, dx < 0.$$

2.  若 $n$ 为奇数，设 $f \in C^{n+1}[a,b]$，则
    $$E_n(f) = \frac{\overline{C}_n}{(n+1)!} f^{(n+1)}(\xi), \quad \xi \in [a,b],$$
    其中 $$\overline{C}_n = \int_a^b w_{n+1}(x) \, dx < 0.$$
:::

**Corollary**
当 $n$ 为偶数时，Newton-Cotes 求积公式具有 $n+1$ 次代数精度；当 $n$
为奇数时，具有 $n$ 次代数精度。
:::

### Newton-Cotes 求积公式的数值稳定性

设 $f(x_k)$, $k=0,1,\dots,n$ 有误差，记为 $\widetilde{f}(x_k)$，则有
$$\left| \sum_{k=0}^n C_k^{(n)} \widetilde{f}(x_k) - \sum_{k=0}^n C_k^{(n)} f(x_k) \right| \leq \max_{0 \leq k \leq n} |\widetilde{f}(x_k) - f(x_k)| \sum_{k=0}^n |C_k^{(n)}|.$$
另一方面，Newton-Cotes 求积公式至少具有 1 次代数精度，故有
$$\int_a^b 1 \, dx = (b-a) \sum_{k=0}^n C_k^{(n)} \implies \sum_{k=0}^n C_k^{(n)} = 1.$$
若 $C_k^{(n)} \geq 0$，则
$$\sum_{k=0}^n |C_k^{(n)}| = \sum_{k=0}^n C_k^{(n)} = 1,$$ 因此
$$\left| \sum_{k=0}^n C_k^{(n)} \widetilde{f}(x_k) - \sum_{k=0}^n C_k^{(n)} f(x_k) \right| \leq \max_{0 \leq k \leq n} |\widetilde{f}(x_k) - f(x_k)|.$$
即 Newton-Cotes 求积公式数值稳定。

当 $n \leq 7$ 时，$C_k^{(n)}$ 均为正数，求积公式稳定；当 $n \geq 8$
时，$C_k^{(n)}$ 出现负数，则有
$$\sum_{k=0}^n |C_k^{(n)}| > \sum_{k=0}^n C_k^{(n)} = 1,$$
求积公式可能不稳定。

---

## 复合求积公式

### 复合梯形求积公式

将区间 $[a,b]$ 分为 $n$ 等份，令 $x_k = a + kh$, $h = \frac{b-a}{n}$,
$k=0,1,\dots,n$。在每个子区间 $[x_{k-1}, x_k]$ 均采用梯形公式，则有
$$\int_a^b f(x) \, dx = \sum_{k=1}^n \int_{x_{k-1}}^{x_k} f(x) \, dx.$$
令
$$T_n(f) = \frac{h}{2} \sum_{k=1}^n \left[ f(x_{k-1}) + f(x_k) \right],$$
则
$$T_n(f) = \frac{h}{2} \left( f(a) + 2 \sum_{k=1}^{n-1} f(x_k) + f(b) \right).$$
称为 **复合梯形求积公式**。

由梯形公式的误差可得
$$\int_a^b f(x) \, dx = T_n(f) - \frac{h^3}{12} \sum_{k=1}^n f''(\eta_k), \quad \eta_k \in [x_{k-1}, x_k].$$
若 $f \in C^2[a,b]$，由介值定理存在 $\eta \in [a,b]$ 使得
$$f''(\eta) = \frac{1}{n} \sum_{k=1}^n f''(\eta_k).$$ 由此可得
$$E_n(f) = -\frac{b-a}{12} h^2 f''(\eta),$$ 从而
$$\lim_{n \to \infty} E_n(f) = 0.$$

### 复合 Simpson 求积公式

在每个子区间 $[x_{k-1}, x_k]$ 上采用 Simpson 求积公式可得
$$\int_a^b f(x) \, dx = \sum_{k=1}^n \int_{x_{k-1}}^{x_k} f(x) \, dx.$$
其中 $x_{k-\frac{1}{2}} = \frac{1}{2}(x_{k-1} + x_k)$，令
$$S_n(f) = \frac{h}{6} \sum_{k=1}^n \left[ f(x_{k-1}) + 4f(x_{k-\frac{1}{2}}) + f(x_k) \right],$$
称为**复合 Simpson 求积公式**。

设 $f \in C^4[a,b]$，利用 Simpson 公式的误差可得
$$E_n(f) = -\frac{1}{2880} (b-a) h^4 f^{(4)}(\eta), \quad \eta \in [a,b].$$

### Hermite 插值对应的求积公式

设 $f \in C^1[a,b]$，$H_3(x)$ 为 $[a,b]$ 上 $f$ 的三次 Hermite
插值多项式，即 $H_3$ 满足 $$H_3(a) = f(a), \quad H_3(b) = f(b),$$
$$H_3'(a) = f'(a), \quad H_3'(b) = f'(b).$$

由此可得求积公式
$$\int_a^b f(x) \, dx = \int_a^b H_3(x) \, dx + \int_a^b R_3(x) \, dx,$$
其中 $$R_3(x) = f(x) - H_3(x) = f[a,a,b,b,x] (x-a)^2(x-b)^2.$$ 于是
$$E(f) = \int_a^b R_3(x) \, dx = f[a,a,b,b,\eta] \int_a^b (x-a)^2(x-b)^2 \, dx,$$
$$E(f) = \frac{1}{720} (b-a)^5 f^{(4)}(\eta), \quad \eta \in [a,b].$$

作复合求积时有
$$\int_a^b f(x) \, dx = \sum_{k=1}^n \int_{x_{k-1}}^{x_k} f(x) \, dx,$$
$$= h \left[ \frac{1}{2} \left( f(a) + f(b) \right) + \sum_{k=1}^{n-1} f(x_k) \right] + \frac{h^2}{12} \left( f'(a) - f'(b) \right) + E_n(f),$$

$$= \underbrace{h \left[ \frac{1}{2} \left( f(a) + f(b) \right) + \sum_{k=1}^{n-1} f(x_k) \right]}_{\text{复合梯形求积公式}} + \underbrace{\frac{h^2}{12} \left( f'(a) - f'(b) \right)}_{\text{端点修正}}
+ \frac{1}{720} h^4 (b-a) f^{(4)}(\eta), \quad \eta \in [a,b].$$

---

## Gauss 求积公式

**Theorem**
求积公式 $$\int_a^b p(x) f(x) \, dx \approx \sum_{k=0}^n A_k f(x_k)$$
具有 $2n+1$ 次代数精度的充分必要条件为：

1.  $x_0, \dots, x_n$ 是 $[a, b]$ 上权函数为 $p(x)$ 的 $n+1$
    次正交多项式的零点。

2.  $$A_k = \int_a^b p(x) l_k(x) \, dx, \quad k = 0, 1, \dots, n$$ 其中
    $l_k(x)$ 为 Lagrange 插值基函数。
:::


*Proof.* **(必要性)** 设求积公式具有 $2n+1$ 次代数精度。令
$$w_{n+1}(x) = (x - x_0) \cdots (x - x_n),$$ 则 $\forall g(x) \in P_n$
有
$$\int_a^b p(x) g(x) w_{n+1}(x) \, dx = \sum_{k=0}^n A_k g(x_k) w_{n+1}(x_k) = 0.$$
即 $w_{n+1}$ 与 $P_n$ 正交，所以 $w_{n+1}$ 为 $n+1$ 次正交多项式。

另一方面，有 $l_k \in P_n$，所以
$$\int_a^b p(x) l_k(x) \, dx = \sum_{j=0}^n A_j l_k(x_j) = A_k.$$

**(充分性)** 设 $f \in P_{2n+1}$ 则有 $$f(x) = q(x) w_{n+1}(x) + r(x),$$
其中 $q, r \in P_n$。

于是 


$$\begin{aligned}
\int_a^b p(x) f(x) \, dx &= \int_a^b p(x) q(x) w_{n+1}(x) \, dx + \int_a^b p(x) r(x) \, dx \\
&= \int_a^b p(x) r(x) \, dx \\
&= \sum_{k=0}^n A_k r(x_k) = \sum_{k=0}^n A_k f(x_k).
\end{aligned}$$
 

◻
:::

**Remark**
若 $f(x) = \prod_{j=0}^n (x - x_j)^2$，则 $f \in P_{2n+2}$ 且
$$\int_a^b p(x) f(x) \, dx > 0 = \sum_{k=0}^n A_k f(x_k).$$ 因此求积公式
$\sum_{k=0}^n A_k f(x_k)$ 的代数精度最高为 $2n+1$。

若 $\sum_{k=0}^n A_k f(x_k)$ 具有 $2n+1$ 次代数精度，则称其为 Gauss
型求积公式，$x_0, \dots, x_n$ 称为 Gauss 点。
:::

**Theorem**
Gauss 型求积公式的求积系数为
$$A_k = \frac{1}{[w'_{n+1}(x_k)]^2} \int_a^b p(x) \left[\frac{w_{n+1}(x)}{x - x_k}\right]^2 \, dx.$$
:::


*Proof.* 令
$f(x) = [l_k(x)]^2 = \left[\frac{w_{n+1}(x)}{x - x_k}\right]^2$，则有
$f \in P_{2n}$ 且 


$$f(x_j) =
\begin{cases}
0, & j \neq k \\
[w'_{n+1}(x_k)]^2, & j = k
\end{cases}$$ 

Gauss 型求积公式代数精度为 $2n+1$，所以
$$\int_a^b p(x) f(x) \, dx = \sum_{j=0}^n A_j f(x_j) = A_k [w'_{n+1}(x_k)]^2.$$
从而 $$A_k = \frac{\int_a^b p(x) l_k^2(x) \, dx}{[w'_{n+1}(x_k)]^2}.$$ ◻
:::

**Corollary**
Gauss 型求积公式的求积系数均为正。
:::

**Theorem**
设 $f \in C^{2n+2}[a, b]$，Gauss 型求积公式的误差为
$$E_n(f) = \frac{1}{(2n+2)!} f^{(2n+2)}(\eta) \int_a^b p(x) [w_{n+1}(x)]^2 \, dx,$$
其中 $\eta \in [a, b]$。
:::


*Proof.* $2n+1$ 次 Hermite 插值多项式 $H_{2n+1}$ 满足
$$H_{2n+1}(x_j) = f(x_j), \quad H'_{2n+1}(x_j) = f'(x_j), \quad j = 0, 1, \dots, n,$$
且
$$f(x) = H_{2n+1}(x) + f[x_0, x_0, \dots, x_n, x_n, x] w_{n+1}^2(x).$$
所以 
$$\begin{aligned}
\int_a^b p(x) f(x) \, dx &= \int_a^b p(x) H_{2n+1}(x) \, dx + \int_a^b p(x) f[x_0, x_0, \dots, x_n, x_n, x] w_{n+1}^2(x) \, dx \\
&= \sum_{k=0}^n A_k f(x_k) + \frac{1}{(2n+2)!} f^{(2n+2)}(\eta) \int_a^b p(x) w_{n+1}^2(x) \, dx.
\end{aligned}$$
 ◻
:::

### Gauss 求积公式的收敛性 

**Theorem**
$$|Q_n(f) - Q_n(g)| \leq \max_{0 \leq k \leq n} |f(x_k) - g(x_k)| \int_a^b p(x) \, dx.$$
:::


*Proof.* 
$$\begin{aligned}
|Q_n(f) - Q_n(g)| &= \left| \sum_{k=0}^n A_k (f(x_k) - g(x_k)) \right| \\
&\leq \left( \sum_{k=0}^n A_k \right) \max_{0 \leq k \leq n} |f(x_k) - g(x_k)| \\
&= \max_{0 \leq k \leq n} |f(x_k) - g(x_k)| \int_a^b p(x) \, dx.
\end{aligned}$$
 ◻
:::

**Theorem**
设 $f \in C[a, b]$，则有
$$\lim_{n \to \infty} Q_n(f) = \int_a^b p(x) f(x) \, dx,$$ 其中
$Q_n(f) = \sum_{k=0}^n A_k f(x_k)$ 为 Gauss 型求积公式。
:::


*Proof.* $f \in C[a, b]$，所以 $\forall \varepsilon > 0$ 存在多项式
$P$（设为 $m$ 次）使得
$$\|f - P\|_\infty < \frac{\varepsilon}{2 \int_a^b p(x) \, dx}.$$ 那么

$$\begin{aligned}
|Q_n(f) - \int_a^b p(x) f(x) \, dx| &\leq \left| \int_a^b p(x) f(x) \, dx - \int_a^b p(x) P(x) \, dx \right| \\
&\quad + \left| \int_a^b p(x) P(x) \, dx - Q_n(P) \right| + |Q_n(P) - Q_n(f)| \\
&\leq \frac{\varepsilon}{2} + \|f - P\|_\infty \int_a^b p(x) \, dx \\
&= \frac{\varepsilon}{2} + \|f - P\|_\infty \int_a^b p(x) \, dx \\
&< \varepsilon.
\end{aligned}$$
 即 $\forall \varepsilon > 0$，存在
$N > 0$，$\forall n > N$ 有
$$|Q_n(f) - \int_a^b p(x) f(x) \, dx| < \varepsilon.$$ ◻
:::

---

## Romberg 求积方法

**Definition**
Bernoulli 多项式 $B_n(x)$ 满足： $$\begin{cases}
B_0(x) = 1 \\
B_n'(x) = B_{n-1}(x), \quad \int_0^1 B_n(x) \, dx = 0, \quad n \in \mathbb{N}.
\end{cases}$$
:::

**Theorem**
对于 Bernoulli 多项式，有
$$B_n(x) = (-1)^n B_n(1-x), \quad n = 0, 1, 2, \dots$$
:::


*Proof.* 采用数学归纳法证明。

1\. 当 $n = 0$ 时，显然成立，因为 $B_0(x) = 1$。

2\. 假设对于 $n$ 成立，即 $$B_n(x) = (-1)^n B_n(1-x).$$ 则有

$$\begin{aligned}
   B_{n+1}(x) &= \int_0^x B_n(y) \, dy + C \\
               &= \int_0^x (-1)^n B_n(1-y) \, dy + C \\
               &= \int_1^{1-x} (-1)^n B_n(z) \, dz + C \\
               &= (-1)^{n+1} \int_0^{1-x} B_n(z) \, dz + C \\
               &= (-1)^{n+1} \left[ B_{n+1}(1-x) - C \right] + C \\
               &= (-1)^{n+1} B_{n+1}(1-x) + (1 - (-1)^{n+1})C.
\end{aligned}$$
 

由 $\int_0^1 B_{n+1}(x) \, dx = 0$ 得
$(1 - (-1)^{n+1})C = 0$，因此 $$B_{n+1}(x) = (-1)^{n+1} B_{n+1}(1-x).$$
归纳完毕。 ◻
:::

**Corollary**
$$B_{2m+1}(1) = B_{2m+1}(0) = 0, \quad m = 1, 2, \dots$$
:::


*Proof.* 由 $\int_0^1 B_n(x) \, dx = 0$，得
$$B_n(1) = B_n(0), \quad n = 2, 3, \dots$$ 由此即得
$$B_{2m+1}(1) = B_{2m+1}(0), \quad m = 1, 2, \dots$$ ◻
:::

**Theorem**
设 $f \in C^m[a, b]$，$m \geq 3$，且
$$x_k = a + kh, \quad h = \frac{b-a}{n}, \quad k = 0, 1, 2, \dots, n,$$
则
$$T_h(f) = \frac{h}{2} \sum_{k=0}^{n-1} \left[ f(x_k) + f(x_{k+1}) \right].$$
则有 
$$\begin{aligned}
\int_a^b f(x) \, dx &= T_h(f) - \sum_{j=1}^{\lfloor \frac{m}{2} \rfloor} \frac{b_{2j} h^{2j}}{(2j)!} \left[ f^{(2j-1)}(b) - f^{(2j-1)}(a) \right] \\
&\quad + (-1)^m h^m \int_a^b \widetilde{B}_m\left(\frac{x-a}{h}\right) f^{(m)}(x) \, dx,
\end{aligned}$$
 其中 $b_n = n! B_n(0)$，$\widetilde{B}_n$ 为 $B_n$
的周期延拓，即
$$\widetilde{B}_n(x) = B_n(x), \quad x \in [0, 1], \quad \widetilde{B}_n(x+1) = \widetilde{B}_n(x).$$
:::


*Proof.* 设 $g(x) \in C^m[0, 1]$，由分部积分得 
$$\begin{aligned}
\int_0^1 g(z) \, dz &= \int_0^1 B_0(z) g(z) \, dz \\
&= \frac{1}{2} \left[ g(0) + g(1) \right] - \sum_{j=2}^m (-1)^j B_j(0) \left[ g^{(j-1)}(1) - g^{(j-1)}(0) \right] \\
&\quad + (-1)^m \int_0^1 B_m(z) g^{(m)}(z) \, dz.
\end{aligned}$$
 令 $x = x_k + hz$，$g(z) = f(x_k + hz)$，得

$$\begin{aligned}
\int_{x_k}^{x_{k+1}} f(x) \, dx &= \frac{h}{2} \left[ f(x_k) + f(x_{k+1}) \right] \\
&\quad - \sum_{j=1}^{\lfloor \frac{m}{2} \rfloor} \frac{b_{2j}}{(2j)!} \left[ f^{(2j-1)}(x_{k+1}) - f^{(2j-1)}(x_k) \right] \\
&\quad + (-1)^m h^m \int_{x_k}^{x_{k+1}} B_m\left(\frac{x-x_k}{h}\right) f^{(m)}(x) \, dx.
\end{aligned}$$
 对 $k = 0, 1, 2, \dots, n-1$ 求和即得定理结论。 ◻
:::

### Romberg 求积方法

设
$f \in C^{2m+2}[a, b]$，$x_k = a + kh$，$h = \frac{b-a}{n}$，$k = 0, 1, \dots, n$，令
$$(T_1 f)(h) = \frac{h}{2} \sum_{k=0}^{n-1} \left[ f(x_k) + f(x_{k+1}) \right].$$
则有
$$\int_a^b f(x) \, dx - (T_1 f)(h) = \alpha_2 h^2 + \alpha_4 h^4 + \cdots + \alpha_{2m} h^{2m} + O(h^{2m+2}).$$

令
$$(T_1 f)\left(\frac{h}{2}\right) = \frac{h}{4} \sum_{k=0}^{2n-1} \left[ f(x_k) + 2f(x_{k+\frac{1}{2}}) + f(x_{k+1}) \right].$$
则
$$\int_a^b f(x) \, dx - (T_1 f)\left(\frac{h}{2}\right) = \alpha_2 \left(\frac{h}{2}\right)^2 + \alpha_4 \left(\frac{h}{2}\right)^4 + \cdots + \alpha_{2m} \left(\frac{h}{2}\right)^{2m} + O(h^{2m+2}).$$

令
$$(T_2 f)(h) = \frac{4 (T_1 f)\left(\frac{h}{2}\right) - (T_1 f)(h)}{3}.$$
那么有
$$\int_a^b f(x) \, dx - (T_2 f)(h) = \alpha_4 h^4 + \cdots + \alpha_{2m} h^{2m} + O(h^{2m+2}),$$
其中
$$\alpha_{2\ell+2} = -\frac{1 - (\frac{1}{2})^{2\ell}}{3} \alpha_{2\ell+2}, \quad 1 \leq \ell \leq m-1.$$

设 $(T_k f)(h)$ 已得，则有
$$\int_a^b f(x) \, dx - (T_k f)(h) = \alpha_{2k} h^{2k} + \cdots + \alpha_{2m} h^{2m} + O(h^{2m+2}).$$

令
$$(T_{k+1} f)(h) = \frac{4^k (T_k f)\left(\frac{h}{2}\right) - (T_k f)(h)}{4^k - 1}.$$
则有 $$\int_a^b f(x) \, dx - (T_{k+1} f)(h) = O(h^{2k+2}).$$

## 奇异积分的数值方法

### 区间截断

若 $\int_a^b f(x) \, dx$ 且
$\lim_{x \to a} f(x) = \infty$，则可对区间进行分割计算积分。

**Example**
设 $g \in C^m[0, 1]$，$|g(x)| \leq 1$，$x \in [0, 1]$，计算
$$\int_0^1 \frac{g(x)}{x^{1/2} + x^{3/2}} \, dx.$$
:::


*解.* 在 $[0, 1]$ 上有 
$$\begin{aligned}
\left| \frac{g(x)}{x^{1/2} + x^{3/2}} \right| &\leq \frac{1}{2x^{1/2}}, \\
\Rightarrow \left| \int_0^\varepsilon \frac{g(x)}{x^{1/2} + x^{3/2}} \, dx \right| &\leq \frac{1}{2} \int_0^\varepsilon x^{-1/2} \, dx = \varepsilon^{1/2}, \\
\Rightarrow \left| \int_0^1 \frac{g(x)}{x^{1/2} + x^{3/2}} \, dx - \int_\varepsilon^1 \frac{g(x)}{x^{1/2} + x^{3/2}} \, dx \right| &\leq \varepsilon^{1/2}.
\end{aligned}$$
 ◻
:::

**Example**
计算 $$\int_0^6 \sqrt{x} \sin x \, dx.$$
:::


*解：.* 令 $f(x) = \sqrt{x} \sin x$，则
$f'(x) = \frac{1}{2\sqrt{x}} \sin x + \sqrt{x} \cos x$。$f'$ 在 $x = 0$
处奇异。

$$\left| \int_0^\varepsilon \sqrt{x} \sin x \, dx \right| \leq \int_0^\varepsilon \sqrt{x} \, dx = \frac{2}{3} \varepsilon^{3/2}.$$
由此可以选取合适的 $\varepsilon$ 采用
$$\int_\varepsilon^6 \sqrt{x} \sin x \, dx \quad \text{逼近} \quad \int_0^6 \sqrt{x} \sin x \, dx.$$
另一种精度更高的方法为对 $\sin x$ 作 Taylor 展开：
$$\int_0^\varepsilon \sqrt{x} \sin x \, dx = \int_0^\varepsilon \sqrt{x} \left( x - \frac{x^3}{3!} + \cdots \right) dx.$$
取前几项计算积分。 ◻
:::

### 变量替换

计算定积分 $$\int_0^1 x^{-n} f(x) \, dx, \quad n \geq 2.$$

令 $t^n = x$，则有 
$$\begin{aligned}
\int_0^1 x^{-n} f(x) \, dx &= \int_0^1 f(x) \, dx \\
&= n \int_0^1 f(t^n) t^{n-2} \, dt.
\end{aligned}$$


**Example**
计算 $$\int_0^1 \frac{e^x}{\sqrt{x}} \, dx.$$

令 $t = \sqrt{x}$，则有
$$\int_0^1 \frac{e^x}{\sqrt{x}} \, dx = 2 \int_0^1 e^{t^2} \, dt.$$
:::

### Kontorovich 奇点分离法

**Example**
计算 $$\int_0^1 \frac{\cos x}{x^{1/2}} \, dx.$$
:::

**解：** 
$$\begin{aligned}
\int_0^1 \frac{\cos x}{x^{1/2}} \, dx &= \int_0^1 \frac{1}{\sqrt{x}} \, dx + \int_0^1 \frac{\cos x - 1}{\sqrt{x}} \, dx \\
&= 2 + \int_0^1 \frac{\cos x - 1}{\sqrt{x}} \, dx \\
&= 2 - \int_0^1 \frac{1}{2} x^{3/2} \, dx + \int_0^1 \frac{\cos x - 1 + \frac{1}{2} x^2}{\sqrt{x}} \, dx.
\end{aligned}$$


一般方法为：
$$\int_a^b f(x) \, dx, \quad f(x) \text{ 在 } [a, b] \text{ 上有奇点.}$$
选取 $g(x)$ 满足：

1.  $g$ 与 $f$ 有相同的奇点，

2.  $f - g$ 有必要阶导数，

3.  $\int_a^b g(x) \, dx$ 可以解析计算.

则
$$\int_a^b f(x) \, dx = \int_a^b g(x) \, dx + \int_a^b [f(x) - g(x)] \, dx.$$

-   $\int_a^b g(x) \, dx$ 解析计算，

-   $\int_a^b [f(x) - g(x)] \, dx$ 数值计算.

设 $f$ 具有如下形式
$$f(x) = (x - x_0)^\alpha \varphi(x), \quad x_0 \in [a, b],$$ 其中
$-1 < \alpha < 0$，$\varphi \in C^k[a, b]$.

利用 Taylor 展开
$$\varphi(x) = \varphi(x_0) + (x - x_0) \varphi'(x_0) + \cdots + \frac{(x - x_0)^k}{k!} \varphi^{(k)}(x_0),$$
令
$$g(x) = (x - x_0)^\alpha \left[ \varphi(x_0) + (x - x_0) \varphi'(x_0) + \cdots + \frac{(x - x_0)^k}{k!} \varphi^{(k)}(x_0) \right].$$
则
$$\int_a^b f(x) \, dx = \int_a^b g(x) \, dx + \int_a^b [f(x) - g(x)] \, dx.$$

-   $g(x)$ 为幂函数，$\int_a^b g(x) \, dx$ 可解析计算，

-   $f(x) - g(x) \in C^k[a, b]$ 可用数值方法计算积分.

## Monte Carlo 方法

**Theorem**
设 $X_n$, $n = 1, 2, \dots$ 为独立同分布的随机变量，令
$$S_N = X_1 + X_2 + \cdots + X_N,$$ 若 $\mathbb{E}|X_1| < +\infty$，则有
$\frac{S_N}{N}$ 依概率收敛到 $\mathbb{E}X_1$，即
$$\frac{S_N}{N} \xrightarrow{P} \mathbb{E}X_1.$$
:::


*Proof.* 设 $X_i$, $i = 1, 2, \dots, N$ 为独立同分布于 $[0, 1]$
上均匀分布的随机变量（简记为 $X_i \sim U[0, 1]$），则有
$$I_N(f) = \frac{1}{N} \sum_{i=1}^N f(X_i)$$ 依概率收敛到
$$I(f) = \int_0^1 f(x) \, dx.$$

令 $\epsilon_N = I_N(f) - I(f)$，则 
$$\begin{aligned}
\mathbb{E}|\epsilon_N|^2 &= \mathbb{E}\left[I_N(f) - I(f)\right]^2 \\
&= \mathbb{E}\left[\frac{1}{N} \sum_{i=1}^N (f(X_i) - I(f))\right]^2 \\
&= \frac{1}{N^2} \sum_{i,j=1}^N \mathbb{E}\left[(f(X_i) - I(f))(f(X_j) - I(f))\right] \\
&= \frac{1}{N} \mathbb{E}\left[f(X_i) - I(f)\right]^2 \\
&= \frac{1}{N} \text{Var}(f),
\end{aligned}$$
 其中
$\text{Var}(f) = \mathbb{E}\left[f(X) - I(f)\right]^2$ 为 $f(X)$
的方差。

由 Schwartz 不等式，
$$\mathbb{E}|\epsilon_N| \leq \sqrt{\mathbb{E}|\epsilon_N|^2} = \sqrt{\frac{\text{Var}(f)}{N}}.$$

若 $\text{Var}(f) < +\infty$，则 Monte Carlo
方法具有半阶收敛性（与维数无关）。 ◻
:::

### 重要性抽样法

**Definition**
令
$$I(f) = \int_0^1 f(x) \, dx = \int_0^1 \frac{f(x)}{p(x)} p(x) \, dx,$$
其中 $p(x)$ 为 $[0, 1]$ 上的一个概率密度函数。利用 Monte Carlo 方法可得
$$I(f) \approx \frac{1}{N} \sum_{i=1}^N \frac{f(Y_i)}{p(Y_i)},$$ 其中
$Y_i$, $i = 1, 2, \dots, N$ 为独立同分布于 $p$ 的随机变量。
:::

此时有 
$$\begin{aligned}
\text{Var}_Y\left(\frac{f}{p}\right) &= \int_0^1 \left(\frac{f}{p} - I(f)\right)^2 p \, dy \\
&= \int_0^1 \left(\frac{f}{p}\right)^2 p \, dy - [I(f)]^2 \\
\text{Var}_X(f) &= \int_0^1 f^2 \, dx - [I(f)]^2.
\end{aligned}$$


选取适当的 $p$，使得
$$\int_0^1 \frac{f^2}{p} \, dy < \int_0^1 f^2 \, dx.$$

若 $p = \frac{|f|}{I(|f|)}$，则有
$\text{Var}_Y\left(\frac{f}{p}\right) = 0$。

**Theorem**
极小化 $\text{Var}_Y\left(\frac{f}{p}\right)$ 的分布为
$$p^* = \frac{|f(x)|}{\int_0^1 |f(y)| \, dy}.$$
:::


*Proof.* 
$$\begin{aligned}
\left(\int_0^1 |f(x)| \, dx\right)^2 &= \int_0^1 \frac{|f(x)|}{p(x)} p(x) \, dx \\
&\leq \int_0^1 \left(\frac{f(x)}{p(x)}\right)^2 p(x) \, dx.
\end{aligned}$$
 等号在 $p = p^*$ 时取到。 ◻
:::

## 采样方法

### 非负矩阵基本理论

**Definition**
设 $A = [a_{ij}]$, $B = [b_{ij}] \in \mathbb{R}^{n \times r}$。如果
$a_{ij} \geq b_{ij}$，$i = 1, \dots, n$，$j = 1, \dots, r$，则称
$A \geq B$。记 $\mathbf{0}$ 为全零矩阵，若 $A \geq \mathbf{0}$，则称 $A$
为非负矩阵；若 $A > \mathbf{0}$，则称 $A$ 为正矩阵。
:::

**Lemma**
设 $A \in \mathbb{R}^{n \times n}$ 不可约且 $A \geq \mathbf{0}$，则
$$(I + A)^{n-1} > \mathbf{0}.$$
:::


*Proof.* 下证：对任意 $x \in \mathbb{R}^n$，若 $x \geq \mathbf{0}$，则有
$(I + A)^{n-1} x > \mathbf{0}$。

令 $$x_{k+1} = (I + A)x_k = x_k + Ax_k, \quad x_0 = x.$$

由于 $A \geq \mathbf{0}$，$x_0 \geq \mathbf{0}$，可得
$x_k \geq \mathbf{0}$，且 $Ax_k \geq \mathbf{0}$。

注意到 $x_{k+1}$ 的零元素个数不大于 $x_k$ 的零元素个数。若 $x_{k+1}$ 和
$x_k$ 的零元素个数相等，则 $x_{k+1}$ 和 $x_k$ 的零元素位置相同。

存在置换矩阵 $P \in \mathbb{R}^{n \times n}$，使得
$$Px_{k+1} = \begin{bmatrix} \alpha \\ \mathbf{0} \end{bmatrix}, \quad Px_k = \begin{bmatrix} \beta \\ \mathbf{0} \end{bmatrix}, \quad \alpha, \beta \in \mathbb{R}^m, \ |m| < n.$$

则有 $$Px_{k+1} = Px_k + PAP^\top Px_k,$$ 即
$$\begin{bmatrix} \alpha \\ \mathbf{0} \end{bmatrix} = \begin{bmatrix} \beta \\ \mathbf{0} \end{bmatrix} + \begin{bmatrix} A_{11} & A_{12} \\ A_{21} & A_{22} \end{bmatrix} \begin{bmatrix} \beta \\ \mathbf{0} \end{bmatrix}.$$

由此可得 $$A_{21} \beta = \mathbf{0}.$$

由于 $\beta > \mathbf{0}$，且 $A_{21} \geq \mathbf{0}$，故
$A_{21} = \mathbf{0}$，这与 $A$ 不可约矛盾。

所以 $x_{k+1}$ 的零元素个数小于 $x_k$ 的零元素个数。由于 $x_0$
的零元素个数至多为 $n-1$，因此 $$(I + A)^{n-1} x > \mathbf{0}.$$ ◻
:::

**Lemma**
设 $A \geq \mathbf{0}$ 是不可约的 $n \times n$ 方阵，则 $r > 0$ 且为 $A$
的特征值，相应的特征向量为 $z$ 满足 $\lambda(z) = r$。
:::


*Proof.* 令 $\bar{x} \in \mathbb{R}^n$，$\bar{x} > \mathbf{0}$。由于 $A$
不可约，则有 $A\bar{x} > \mathbf{0}$，所以 $\lambda(\bar{x}) > 0$。

于是 $$r \geq \lambda(\bar{x}) > 0.$$

记 $\eta = Az - rz$，其中 $z \in S$ 满足 $\lambda(z) = r$。由
$\lambda(z)$ 的定义知 $\eta \geq \mathbf{0}$。

若 $\eta \neq \mathbf{0}$，由引理 7.8.1 得
$$A\eta - r\eta > \mathbf{0}, \quad \text{其中 } \eta = (I + A)^{n-1} z > \mathbf{0}.$$

由 $\lambda$ 的定义知 $$\lambda(\eta) > r,$$ 这与 (7.8.2) 矛盾，故有
$$Az - rz = \mathbf{0}.$$

另一方面， $$\eta = (I + A)^{n-1} z = (1 + r)^{n-1} z > \mathbf{0}.$$
因此 $z > \mathbf{0}$。 ◻
:::

**Lemma**
设 $A = [a_{ij}] \geq \mathbf{0}$ 是不可约的 $n \times n$
方阵，$B = [b_{ij}] \in \mathbb{C}^{n \times n}$，且 $|B| \leq A$。则
$$\rho(B) \leq r,$$ 且 $\rho(B) = r$ 当且仅当
$$B = e^{i\phi} DAD^{-1},$$ 其中
$D = \text{diag}(d_j)$，$d_j \in \mathbb{C}$，$|d_j| = 1$，$j = 1, 2, \dots, n$。
:::


*Proof.* 设 $\beta$ 为 $B$ 的特征值，即存在 $y \neq \mathbf{0}$，使得
$$By_i = \sum_{j=1}^n b_{ij} y_j.$$

于是 

$$|\beta||y| \leq |B||y| \leq A|y|.$$

若 $\|\beta\| = r$，则 

$$\lambda(|y|) \geq |\beta| = r.$$

由引理 7.8.2，$\lambda(\|y\|) = r\|y\| = A\|y\|$，且 $\|y\| > \mathbf{0}$。

令
$$D = \text{diag}\left(\frac{y_i}{|y_i|}\right), \quad i = 1, \dots, n.$$

则 $$y = D\|y\|.$$

记 $\beta = re^{i\phi}$，则 

$$\beta y = re^{i\phi} D|y| = By = BD|y|.$$

于是 

$$C|y| = r|y|, \quad C = e^{-i\phi} D^{-1}BD.$$

另一方面， 

$$C|y| = r|y| = A|y| = |C||y|,$$ 

故 

$$C = |C| = A.$$

因此 $$B = e^{i\phi} DAD^{-1}.$$

另一方面，易证。 ◻
:::

**Corollary**
设 $A \geq \mathbf{0}$ 是不可约的 $n \times n$ 方阵，则 $$\rho(A) = r.$$
:::

**Lemma**
设 $A \geq \mathbf{0}$ 是不可约的 $n \times n$ 矩阵，$B$ 为 $A$
的主子式，则 $$\rho(B) \leq \rho(A).$$
:::


*Proof.* 不妨设
$$A = \begin{bmatrix} B & A_{12} \\ A_{21} & A_{22} \end{bmatrix}, \quad B \in \mathbb{R}^{m \times m}, \quad A_{22} \in \mathbb{R}^{(n-m) \times (n-m)}.$$

令
$$C = \begin{bmatrix} B & \mathbf{0} \\ \mathbf{0} & \mathbf{0} \end{bmatrix} \in \mathbb{R}^{n \times n}.$$

则有 $C = |C| \neq A$，且 $\rho(B) = \rho(C)$。由引理 7.8.3 得
$$\rho(C) \leq \rho(A).$$ 因此 $$\rho(B) \leq \rho(A).$$ ◻
:::

**Theorem**
设 $A \geq \mathbf{0}$ 是不可约的 $n \times n$ 矩阵，则有：

1.  $r = \rho(A)$ 为 $A$ 的特征值，相应的特征向量为正向量。

2.  若 $0 \leq B \leq A$，则 $\rho(B) \leq \rho(A)$。

3.  $\rho(A)$ 为 $A$ 的单特征值。
:::


*Proof.* (1), (2) 由引理 7.8.2 和 7.8.3 可得。

下证 (3)：

令 $\phi(t) = \det(tI - A)$，则
$$\phi'(t) = \sum_{i=1}^n \det(tI - A_i),$$ 其中 $A_i$ 为 $A$
的顺序主子式。

由引理 7.8.4 得 $$\det(\rho(A)I - A_i) > 0.$$

因此 $$\phi'(\rho(A)) > 0.$$

故 $\rho(A)$ 为 $\phi(t) = 0$ 的单根。 ◻
:::

**Lemma**
设 $A \geq \mathbf{0}$ 是不可约的 $n \times n$ 矩阵，则
$$\sum_{j=1}^n a_{ij} = \rho(A), \quad i = 1, \dots, n,$$ 或者
$$\min_{1 \leq i \leq n} \left( \sum_{j=1}^n a_{ij} \right) < \rho(A) < \max_{1 \leq i \leq n} \left( \sum_{j=1}^n a_{ij} \right).$$
:::


*Proof.* 若 $\sum_{j=1}^n a_{ij} = \alpha$，$i = 1, \dots, n$，则

令 $\bar{x} = [1, \dots, 1]^T \in \mathbb{R}^n$，则
$$A\bar{x} = \alpha \bar{x}.$$

另一方面，由圆盘定理，$\rho(A) \leq \alpha$。故有 $$\rho(A) = \alpha.$$

若
$\min_{1 \leq i \leq n} \left( \sum_{j=1}^n a_{ij} \right) < \max_{1 \leq i \leq n} \left( \sum_{j=1}^n a_{ij} \right)$，则存在
$0 \leq B \leq A$ 使得
$$\sum_{j=1}^n b_{kj} = \min_{1 \leq i \leq n} \left( \sum_{j=1}^n a_{ij} \right) = \alpha_{\text{min}}.$$

由定理 7.8.1 得 $$\rho(B) < \rho(A).$$

因此 $$\alpha_{\text{min}} < \rho(A).$$

同样可证 $$\rho(A) < \alpha_{\text{max}}.$$ ◻
:::

### 反变换法 

**Definition**
设 $F: \mathbb{R} \to [0, 1]$ 是非减函数。令
$$F^{-1}(u) = \inf \{ x : F(x) \geq u \}.$$
:::

**Theorem**
设 $U \sim U[0, 1]$，则随机变量 $F^{-1}(U)$ 的分布为 $F$。
:::


*Proof.* $$P(F^{-1}(U) \leq x) = P(U \leq F(x)) = F(x).$$ ◻
:::

**Example**
设 $X \sim \exp(-x)$，则
$$F(x) = 1 - e^{-x}, \quad F^{-1}(u) = -\log(1-u).$$
:::

**Example**
设 $X \sim N(0, 1)$，则
$$F(x) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^x \exp\left(-\frac{z^2}{2}\right) dz.$$

近似公式为
$$F^{-1}(x) \approx t - \frac{a_0 + a_1 t}{1 + b_1 t + b_2 t^2},$$ 其中
$t^2 = \log(x^{-2})$，$a_0 = 2.30753$，$a_1 = 0.27061$，$b_1 = 0.99229$，$b_2 = 0.04481$。
:::

**Example**
设 $X_1, X_2 \overset{\text{iid}}{\sim} N(0, 1)$，$(R, \theta)$ 为
$(X_1, X_2)$ 的极坐标，则
$$R^2 = X_1^2 + X_2^2 \sim \exp(-\frac{1}{2}x), \quad \theta \sim U[0, 2\pi].$$

令 $U_1, U_2 \overset{\text{iid}}{\sim} U[0, 1]$，则
$$X_1 = \sqrt{-2\log U_1} \cos(2\pi U_2), \quad X_2 = \sqrt{-2\log U_1} \sin(2\pi U_2).$$

于是 $X_1, X_2 \overset{\text{iid}}{\sim} N(0, 1)$。
:::

### 接受-拒绝方法 

**Theorem**
设 $X, U$ 为随机变量，$X$ 的取值范围为 $(0, 1)$。若
$(X, U) \sim U\{(x, u): 0 < u < f(x), 0 < x < 1\}$，则 $X \sim f(x)$。
:::


*Proof.* 
$$\begin{aligned}
P(X < x) &= \int_0^x \left( \int_0^{f(y)} \frac{du}{\int_0^1 f(z) dz} \right) dy \\
&= \frac{1}{\int_0^1 f(z) dz} \int_0^x f(y) dy.
\end{aligned}$$
 因此，$X \sim f(x)$。 ◻
:::

### 算法 1 {#算法-1 .unnumbered}

::: algorithm
::: algorithmic
选择 $M \geq \sup_x f(x)$ 生成 $Y \sim U[0, 1]$，$U \sim U[0, M]$ 接受
$X = Y$
:::
:::

### 算法 2 {#算法-2 .unnumbered}

::: algorithm
::: algorithmic
选择 $g(x)$、常数 $M$，使得 $f(x) \leq Mg(x)$，且 $g(x)$ 为密度函数 生成
$Y \sim g$，$U \sim U[0, 1]$ 接受 $X = Y$
:::
:::

### 算法 (Metropolis-Hastings) {#算法-metropolis-hastings .unnumbered}

::: algorithm
::: algorithmic
给定初始值 $X^{(0)}$，选定条件密度函数 $Q(y|x)$ 生成
$Y_t \sim Q(y|X^{(t)})$，$U \sim U[0, 1]$ 计算接受概率：
$$p(X^{(t)}, Y_t) = \min\left\{ \frac{\pi(Y_t)}{\pi(X^{(t)})} \cdot \frac{Q(X^{(t)}|Y_t)}{Q(Y_t|X^{(t)})}, 1 \right\}$$
$X^{(t+1)} \gets Y_t$ $X^{(t+1)} \gets X^{(t)}$
:::
:::

**Theorem**
设 $(X^{(t)})$ 是 MH 算法生成的 Markov 链。若
$$\bigcup_{x \in \text{supp}(\pi)} \text{supp}(Q(\cdot|x)) \supset \text{supp}(\pi),$$
则：

1.  转移概率满足细致平衡条件，即 $$K(x, y)\pi(x) = K(y, x)\pi(y).$$

2.  $\pi$ 是平稳分布。
:::

**Theorem**
若 $X^{(t)}$ 不可约，则：

1.  若 $h \in L^1(\pi)$，则
    $$\lim_{T \to \infty} \frac{1}{T} \sum_{t=1}^T h(X^{(t)}) = \int h(x) \pi(x) dx.$$

2.  若 $(X^{(t)})$ 非周期，则对于任意分布 $\mu$，
    $$\lim_{n \to \infty} \left\| \int k^n(x, \cdot) \mu(dx) - \pi \right\|_{TV} = 0.$$
:::
