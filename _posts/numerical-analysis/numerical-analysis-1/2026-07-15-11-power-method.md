---
note: true
layout: post
title: "Numerical Analysis I 幂法——特征值估计、幂法与收缩方法"
permalink: /posts/numerical-analysis-1/11-power-method/
categories: numerical-analysis
tags: [numerical-analysis, power-method, eigenvalue, gershgorin, deflation]
use_math: true
---

本文介绍特征值的估计与扰动理论（Gershgorin 圆盘定理、Bauer-Fike 定理）、幂法与逆幂法（含原点位移），以及特征值的收缩方法（Householder 收缩与 Wielandt 收缩）。

## 1. 特征值的估计和扰动

定理 6.1.1 (Gershgorin) $A = [a_{ij}] \in \mathbb{C}^{n \times n}$ 则 $A$ 的

特征值 $\lambda\in\bigcup_{i=1}^{n}D_{i}$ ，其中 $D_{i}$ 为复平面上从 $a_{ii}$ 为中心

$r_{i}=\sum\limits_{j=1\atop j\neq i}^{n}|a_{ij}|$ 为半径的圆盘，即

$$
D _ {i} = \{z \mid | z - a _ {i i} | \leq r _ {i}, z \in \mathbb {C} \}, i = 1, 2, \dots , n
$$

证明：令 D = diag {a\_{11}, a\_{22}, ..., a\_{nn}}，设 $\lambda \in \sigma(A)$

x为相应的特征向量，则有

$$
(A - D) x = (\lambda I - D) x
$$

不妨设 $\lambda \neq a_{ii}$ , 则有

$$
(\lambda I - D) ^ {- 1} (A - D) x = x
$$

$\Rightarrow ||x||_{\infty} \leq ||(\lambda I - D)^{-1}(A - D)||_{\infty} ||x||_{\infty}$

$\Rightarrow \|(\lambda I - D)^{-1}(A - D)\|_{\infty} \geq 1$

$$
\max _ {1 \le i \le n} \frac {r _ {i}}{| \lambda - a _ {i i} |} \ge 1
$$

定理 6.1.2 设 定理 6.1.1 中的 n 个圆盘中，有 m 个圆盘构成了一个连通区域 S，且 S 与其余 n-m 个圆盘严格分离，则在 S 中有且只有 A 的 m 个特征值

证明：记 $D = \operatorname{diag}\left\{  {a}_{11}\cdots {a}_{nn}\right\} \; ,\;{A}_{\theta } = D + \theta \left( {A - D}\right)$ $\theta  \in  \left\lbrack  {0,1}\right\rbrack$ .

$A_{\theta}$ 的特征多项式的系数是 $\theta$ 的多项式，从而 $A_{0}$ 的特征值是 $\theta$ 的连续函数。令

$$
D _ {i} (\theta) = \{z | | z - a _ {i i} | \leq \theta r _ {i} \}, i = 1, 2, \dots , n
$$

有 $D_{i}(\theta) \subset D_{i}$ 不失一般性，设前 $m$ 个圆盘连通即 $S = \bigcup_{i=1}^{m} D_{i}$ ，令 $S(\theta) = \bigcup_{i=1}^{m} D_{i}(\theta)$ $\overline{S}(\theta) = \bigcup_{i=m+1}^{n} D_{i}(\theta)$ 则有 $S(\theta)$ 与 $\overline{S}(\theta)$ 严格分离利用 $A_{\theta}$ 的特征值关于 $\theta$ 连续 易证定理结论

例

$$
A = \left[ \begin{array}{l l l} 0.9 & 0.01 & 0.12 \\ 0.01 & 0.8 & 0.13 \\ 0.01 & 0.02 & 0.4 \end{array} \right]
$$

A对应的圆盘为 $D_{1}=\{|z-0.9|\leq0.13\}$ $D_{2}=\{|z-0.8|\leq0.14\}$ ， $D_{3}=\{|z-0.4|\leq0.03\}$ $D_{3}$ 与 $D_{1}\cup D_{2}$ 严格分离则 $D_{3}$ 中包含A的一个特征值记为 $\lambda_{3}$ 且 $\lambda_{3}$ 为实特征值

令 B = diag(1, 1, 0.1), 则

$$
B ^ {- 1} A B = \left[ \begin{array}{l l l} 0.9 & 0.01 & 0.012 \\ 0.01 & 0.8 & 0.013 \\ 0.1 & 0.2 & 0.4 \end{array} \right]
$$

$$
\overline {D} _ {1} = \{|z - 0.9| \leq 0.022\}, \quad \overline {D} _ {2} = \{|z - 0.8| \leq 0.023\}
$$

$$
\widehat {D} _ {3} = \{|z - 0.4| \leq 0.3\}
$$

$\overline{D}_{1}, \overline{D}_{2}, \overline{D}_{3}$ 均严格分离 则有

$$
\vert \lambda_ {1} - 0.9 \vert \le 0.022, \quad \vert \lambda_ {2} - 0.8 \vert \le 0.023
$$

$$
|\lambda_ {3} - 0.4| \leq 0.03
$$

定理 6.1.3 设 $\mu$ 是矩阵 $A + E \in \mathbb{C}^{n \times n}$ 的一个特征值

且存在 $X \in \mathbb{C}^{n \times n}$ , $X^{-1} A X = D = \text{diag}(\lambda_1, \cdots, \lambda_n)$ 则 $\min_{\lambda \in \sigma(A)} |\lambda - \mu| \leq \|X^{-1}\|_P \|X\|_P \|E\|_P$

其中 $\left( 1,1\right) p$ 为矩阵的 $P$ 范数, $P = 1,2,\infty$

证明：设 $\mu \notin \sigma(A)$ 则有

$$
A + E - \mu I = X [ D - \mu I + X ^ {- 1} E X ] X ^ {- 1}
$$

$\mu$ 为 $A + E$ 的特征值，所以 $D - \mu I + X^{-1} E X$ 奇异

存在 $y \in \mathbb{C}^n$ 使得

$$
(D - \mu I) y = - (x ^ {- 1} E x) y
$$

$\Rightarrow y = - (D - \mu I)^{-1}(X^{-1} E X) y$

$\Rightarrow \|(D - \mu I)^{-1}\|_P \cdot \|X^{-1}\|_P \cdot \|E\|_P \cdot \|X\|_P \geq 1$

$$
\| X ^ {- 1} \| _ {p} \quad \| X \| _ {p} \| E \| _ {p} \geq \| (D - \mu) ^ {- 1} \| _ {p} ^ {- 1} = \min _ {\lambda \in \sigma (A)} |\lambda - \mu|
$$

$\|X^{-1}\| \|X\|$ 称为矩阵 A 关于特征值问题的条件数设 $A \in \mathbb{C}^{n \times n}$ ， $\lambda$ 为 A 的一个单特征值，x, y 分别为 A 的左右特征向量。即

$$
A x = \lambda x, \quad y ^ {H} A = \lambda y ^ {H}
$$

设 $\| x\| _2 = \| y\| _2 = 1$ . 可以证明存在可微函数

$x(\varepsilon), \lambda(\varepsilon)$ 使得

$$
(A + \varepsilon F) x (\varepsilon) = \lambda (\varepsilon) x (\varepsilon), \quad \| F \| _ {2} = 1
$$

其中 $\lambda(0)=\lambda,\quad x(0)=x$ 。对 $\varepsilon$ 求导得

$$
F x + A \dot {x} (0) = \dot {\lambda} (0) x + \lambda \dot {x} (0)
$$

$$
\Rightarrow y ^ {H} F x + y ^ {H} A \dot {x} (0) = \dot {\lambda} (0) y ^ {H} x + \lambda y ^ {H} \dot {x} (0)
$$

$$
y ^ {H} A = \lambda y ^ {H} \Rightarrow \dot{\lambda} (0) = - \frac {y ^ {H} F x}{y ^ {H} x}
$$

$$
\Rightarrow | \dot {\lambda} (0) | \leq \frac {1}{| y ^ {H} x |}
$$

$\frac{1}{|y^{H}x|}$ 称为 A 关于特征值 $\lambda$ 的条件数

## 2. 幂法和逆幂法.

设 $z = (z_1 \cdots z_n)^T \in \mathbb{R}^n$ , 定义

$$
\max (z) = z _ {i}, \text{其中} | z _ {i} | = \| z \| _ {\infty}
$$

幂法为

$$
v ^ {(0)} \in \mathbb {R} ^ {n}
$$

$$
k = 1, 2, \dots
$$

$$
z ^ {(k)} = A v ^ {(k - 1)}
$$

$$
m _ {k} = \max (z ^ {(k)})
$$

$$
v ^ {(k)} = z ^ {(k)} / m _ {k}
$$

定理 6.2.1 $A \in \mathbb{R}^{n \times n}$ 存在 $n$ 个线性无关的特征

向量 $x_{1}, x_{2}, \cdots, x_{n}$ 对应的特征值满足

$$
| \lambda_ {1} | > | \lambda_ {2} | \geq \cdots \geq | \lambda_ {n} |
$$

且 $v^{(0)}$ 在 $x_1$ 方向投影非零则有

$$
\lim _ {k \to \infty} v ^ {(k)} = \frac {x _ {1}}{\max (x _ {1})}
$$

$$
\lim _ {k \to \infty} m _ {k} = \lambda_1
$$

证明: $v^{(k)} = \frac{A v^{(k-1)}}{m_k} = \cdots = \frac{A^k v^{(0)}}{m_k m_{k-1} \cdots m_1}$

由 $v^{(k)}$ 的最大分量为 1 可得

$$
v ^ {(k)} = \frac {A ^ {k} v ^ {(0)}}{\max (A ^ {k} v ^ {(0)})}
$$

设 $v^{(0)} = \sum_{i=1}^{n} \alpha_i x_i$

$$
A ^ {k} v ^ {(0)} = \lambda_ {1} ^ {k} [ \alpha_ {1} x _ {1} + \sum_ {i = 2} ^ {n} \alpha_ {i} (\frac {\lambda_ {i}}{\lambda_ {1}}) ^ {k} x _ {i} ]
$$

$$
\Rightarrow \lim _ {k \to \infty} \frac {A ^ {k} v ^ {(0)}}{\lambda_ {1} ^ {k} \alpha_ {1}} = x _ {1}
$$

$$
\Rightarrow \lim _ {k \to \infty} \frac {A ^ {k} v ^ {(0)}}{\max (A ^ {k} v ^ {(0)})} = \frac {x _ {1}}{\max (x _ {1})}
$$

## 另一方面

$$
\begin{array}{r l} {m _ {k}} & {= \max (z ^ {(k)}) = \max (A v ^ {(k - 1)})} \\ & {= \frac {\max (A ^ {k} v ^ {(0)})}{\max (A ^ {k - 1} v ^ {(0)})}} \\ & {= \lambda_ {1} \frac {\max (\alpha_ {1} x _ {1} + \sum_ {i = 2} ^ {n} \alpha_ {i} (\frac {\lambda_ {i}}{\lambda_ {1}}) ^ {k} x _ {i})}{\max (\alpha_ {1} x _ {1} + \sum_ {i = 2} ^ {n} \alpha_ {i} (\frac {\lambda_ {i}}{\lambda_ {1}}) ^ {k - 1} x _ {i})}} \end{array}
$$

$$
\Rightarrow \lim _ {k \to \infty} m _ {k} = \lambda_ {1}
$$

### 逆幂法.

$A \in  {\mathbb{R}}^{n \times  n}$ 非奇异 有 $n$ 个线性无关的特征向量

$x_{1} \cdots x_{n}$ 对应的特征值满足

$$
| \lambda_ {1} | \geq | \lambda_ {2} | \geq \dots \geq | \lambda_ {n - 1} | > | \lambda_ {n} | > 0
$$

将幂法用于 ${A}^{-1}$ 可得逆幂法.

$$
A z ^ {(b)} = v ^ {(b - 1)}
$$

$$
m _ {k} = \max (z ^ {(k)})
$$

$$
v ^ {(k)} = \frac {z ^ {(k)}}{m _ {k}}
$$

在逆幂法基础上选择参数 $\delta \neq \lambda_i$ $i=1 \cdots n$

将幂法用于 $(A-\delta I)^{-1}$ 可得原点位移的逆幂法

$$
(A - \delta I) z ^ {(k)} = v ^ {(k - 1)}
$$

$$
m _ {k} = \max (z ^ {(k)})
$$

$$
v ^ {(k)} = \frac {z ^ {(k)}}{m _ {k}}
$$

### 收缩方法

设 $|\lambda_1| > |\lambda_2| > |\lambda_3| \geq \cdots \geq |\lambda_n|$ 收缩

方法为 求出 $\lambda_{1}$ 后求 $\lambda_{2}$ 的方法

方法1. 设 $x_1, x_2$ 已知，计算 Householder 矩阵

H，使得 $Hx_{1}=e_{1}$ （设 $\|x_{1}\|_{2}=1$ ）

由 $A{x}_{1} = {\lambda }_{1}{x}_{1}$ 得

$$
H A H ^ {- 1} e _ {1} = \lambda_ {1} e _ {1}
$$

即

$$
A _ {2} = H A H ^ {- 1} = \left[ \begin{array}{l l} \lambda_ {1} & b _ {1} ^ {T} \\ 0 & B _ {2} \end{array} \right]
$$

其中 $B_{2} \in \mathbb{R}^{(n-1) \times (n-1)}$ 具有特征值 $\lambda_{2} \cdots \lambda_{n}$

利用幂法求 $B_{2}$ 的主特征值 $\lambda_{2}$ 及特征向量

$y_{2}$ 满足 $B_{2}y_{2}=\lambda_{2}y_{2}$

则 ${A}_{2}$ 的特征向量为 ${z}_{2} = \begin{bmatrix} {\frac{b}_{1}^{T}{y}_{2}{\lambda }_{2} - {\lambda }_{1}} \\  y_{2} \end{bmatrix}$

A 相应的特征向量为 $H^{-1}z_{2}$

\- 定理 6.2.2 $A = [a_{ij}] \in \mathbb{R}^{n \times n}$ 特征值为

$x_{1} \cdots x_{n}, x_{1} \cdots x_{n}$ 为相应的特征向量.

且 $\lambda_{1}$ 的重数为 1， $v \in \mathbb{R}^{n}$ 满足 $v^{T}x_{1} = 1$ 则

$$
B = A - \lambda_ {1} x _ {1} v ^ {T}
$$

的特征值为 0, ${\lambda }_{2}\cdots {\lambda }_{n}$ 对应特征向量为

$$
x _ {1}, y _ {2} \dots y _ {n} \quad \text { 且 }
$$

$$
x _ {i} = (\lambda_ {i} - \lambda_ {1}) y _ {i} + \lambda_ {1} (v ^ {T} y _ {i}) x _ {1}, i = 2 \dots n
$$

\- Wielandt 收缩方法、

设 ${x}_{1} = \left( {x}_{11}\cdots {x}_{1n}\right) ^{T}$ 令

$$
v = \frac {1}{\lambda_ {1} x _ {1 i}} (a _ {i 1} \dots a _ {i n}) ^ {\mathrm{T}}
$$

$x_{i}$ 为 $x_{1}$ 的非零分量，则有

$$
v ^ {T} x _ {1} = \frac {1}{\lambda_ {1} x _ {1 i}} \sum_ {j = 1} ^ {n} a _ {i j} x _ {1 j} = 1
$$

并且

$$
B = A - \lambda_1 x_1 v ^ {T}
$$

第i行为零

若 $y$ 为 $B$ 的特征向量, 且 $\lambda \neq 0$ 则

By = λy

$\Rightarrow y_{i}=0,\quad y=(y_{1}\cdots y_{n})$

## 可删去B的第i行第i列得到

${B}^{\prime } \in  {\mathbb{R}}^{\left( n - 1\right)  \times  \left( {n - 1}\right) }$ .

采用幂法 计算 $B'$ 的主特征值 $\lambda_2$ 及特征向

量 $y_{2}^{\prime}$ . 在 $y_{2}^{\prime}$ 第 $c$ 个分量位置插入 0

得到 $y_{2}$ 再利用定理 6.2.2 中的公式可以

得到 ${x}_{2}$

[← 上一篇：非线性方程组迭代方法](/posts/numerical-analysis-1/10-nonlinear-systems/)

[下一篇：QR方法 →](/posts/numerical-analysis-1/12-qr-method/)
