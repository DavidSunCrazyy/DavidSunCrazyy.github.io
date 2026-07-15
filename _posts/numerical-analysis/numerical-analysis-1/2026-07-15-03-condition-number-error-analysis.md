---
note: true
layout: post
title: "数值分析（三）：矩阵的条件数及高斯消去法的误差分析"
permalink: /posts/numerical-analysis-1/03-condition-number-error-analysis/
categories: numerical-analysis
tags: [numerical-analysis, condition-number, error-analysis, gaussian-elimination]
use_math: true
---

本文讨论矩阵条件数的定义与性质、解的扰动分析、以及列主元 Gauss 消去法的舍入误差分析，包括增长因子等概念。

### 3.4 矩阵的条件数

定理: $A \in  {\mathbb{R}}^{n \times  n},\det A \neq  0,x,x + {\delta x}$ 分别满足

$$
A x = b, \quad (A + \delta A) (x + \delta x) = b + \delta b
$$

其中 $b \neq 0$ 。设 $\|\delta A\|$ 充分小，使得

$$
\| A ^ {- 1} \| \| \delta A \| <   1
$$

则有

$$
\frac {\| \delta x \|}{\| x \|} \leq \frac {\| A \| (\| A ^ {- 1} \|)}{1 - \| A ^ {- 1} \| (\| \delta A \|)} \left(\frac {\| \delta A \|}{\| A \|} + \frac {\| \delta b \|}{\| b \|}\right)
$$

其中的范数为任一种向量范数及其从属矩阵范数.

证明：首先由 $\left\|  {A}^{-1}\right\|  \left\|  {\delta A}\right\|  < 1$ 可得

$A+\delta A$ 可逆 并且

$$
\left\| \left(I + A ^ {- 1} \delta A\right) ^ {- 1} \right\| \leq \frac {1}{1 - \left\| A ^ {- 1} \delta A \right\|} \leq \frac {1}{1 - \left\| A ^ {- 1} \right\| \left\| \delta A \right\|}
$$

那么

$$
\begin{array}{r l} {x + \delta x} & {= (A + \delta A) ^ {- 1} (b + \delta b)} \\ {\Rightarrow \quad \delta x} & {= (A + \delta A) ^ {- 1} (b + \delta b - (A + \delta A) x)} \\ & {= (I + A ^ {- 1} \delta A) ^ {- 1} A ^ {- 1} (\delta b - \delta A x)} \end{array}
$$

$$
\Rightarrow \quad \| \delta x \| \leq \frac {\| A ^ {- 1} \|}{1 - \| A ^ {- 1} \| \| \delta A \|} \left(\frac {\| \delta A \|}{\| A \|} \| A \| \| x \| + \frac {\| \delta b \|}{\| b \|} \| A \| \| x \|\right)
$$

$$
\Rightarrow \frac {\| \delta x \|}{\| x \|} \leq \frac {\| A \| (\| A ^ {- 1} \|)}{1 - \| A ^ {- 1} \| (\| \delta A \|)} \left(\frac {\| \delta A \|}{\| A \|} + \frac {\| \delta b \|}{\| b \|}\right)
$$

定义: $A \in \mathbb{R}^{n \times n}$ , $\det A \neq 0$ , 对任一种从属矩阵范数

$$
\text { cond } (A) = | | A | | | | A ^ {- 1} | |
$$

称为矩阵 $A$ 的条件数

矩阵的条件数具有以下性质：

(1) $\text{cond}(A) \geq 1, \text{cond}(A) = \text{cond}(A^{-1})$

> **证明：** 由 $I = AA^{-1}$，有 $1 = \|I\| = \|AA^{-1}\| \leq \|A\|\|A^{-1}\| = \text{cond}(A)$。又 $\text{cond}(A^{-1}) = \|A^{-1}\|\|(A^{-1})^{-1}\| = \|A^{-1}\|\|A\| = \text{cond}(A)$。

(2) $\text{cond}(\alpha A)=\text{cond}(A)$ , $\forall\alpha\in\mathbb{R},\alpha\neq0$

> **证明：** $\text{cond}(\alpha A) = \|\alpha A\| \cdot \|(\alpha A)^{-1}\| = |\alpha|\|A\| \cdot \frac{1}{|\alpha|}\|A^{-1}\| = \|A\|\|A^{-1}\| = \text{cond}(A)$。

(3) 若 $A$ 正交，则 $\text{Cond}(A)_{2}=1$

> **证明：** A 正交 $\Rightarrow$ $A^{\top}A = I$，故 $\|A\|_2 = \sqrt{\rho(A^{\top}A)} = 1$。又 $A^{-1}=A^{\top}$ 亦正交，故 $\|A^{-1}\|_2 = 1$。从而 $\text{cond}(A)_2 = 1$。

(4) $\|\mathbf{A}\|_{2} = \max \left\{ y^{\top} A x : \|x\|_{2} = \|y\|_{2} = 1 \right\}$

$$
\text { cond } (A) _ {2} = \text { cond } (A ^ {\top}) _ {2}
$$

> **证明：** 前一式为谱范数的等价定义（由 $\|A\|_2 = \max_{\|x\|_2=1} \|Ax\|_2$ 及对偶性可得）。后一式由 $\|A^{\top}\|_2 = \|A\|_2$ 及 $\|(A^{\top})^{-1}\|_2 = \|(A^{-1})^{\top}\|_2 = \|A^{-1}\|_2$ 相乘即得。

(5) 若 U 为正交阵则

$$
\text { cond } (A) _ {2} = \text { cond } (U A) _ {2} = \text { cond } (A U) _ {2}
$$

> **证明：** $\|UA\|_2 = \max_{\|x\|_2=1}\|UAx\|_2 = \max_{\|x\|_2=1}\|Ax\|_2 = \|A\|_2$（正交变换保 2-范数）。同理 $\|(UA)^{-1}\|_2 = \|A^{-1}U^{\top}\|_2 = \|A^{-1}\|_2$。故 $\text{cond}(UA)_2 = \text{cond}(A)_2$。$\text{cond}(AU)_2$ 同理。

(6) 设 $\lambda_{1}, \lambda_{n}$ 为 A 按模最大和最小的特征值，则

$$
\text { cond } (A) \geq \frac {| \lambda_ {1} |}{| \lambda_ {n} |}
$$

若A对称，则 $\operatorname{cond}(A)_2 = \frac{|\lambda_1|}{|\lambda_n|}$

> **证明：** 对任意特征值 $\lambda$ 及对应特征向量 $x \neq 0$，有 $|\lambda|\|x\| = \|Ax\| \leq \|A\|\|x\| \Rightarrow |\lambda| \leq \|A\|$。对 $A^{-1}$ 应用此结论，其按模最大特征值为 $\lambda_n^{-1}$，故 $|\lambda_n|^{-1} \leq \|A^{-1}\|$。相乘即得 $\text{cond}(A) \geq |\lambda_1|/|\lambda_n|$。
>
> 若 A 对称，则 $\|A\|_2 = \rho(A) = |\lambda_1|$，$\|A^{-1}\|_2 = \rho(A^{-1}) = |\lambda_n|^{-1}$，故等式成立。

(7)

$$
\frac {1}{n} \operatorname{cond} (A) _ {2} \leq \operatorname{cond} (A) _ {1} \leq n \operatorname{cond} (A) _ {2}
$$

$$
\frac {1}{n} \text { cond } (A) _ {\infty} \leq \text { cond } (A) _ {2} \leq n \text { cond } (A) _ {\infty}
$$

$$
\frac {1}{n ^ {2}} \text { cond } (A), \quad \leq \quad \text { cond } (A) _ {\infty} \quad \leq \quad n ^ {2} \text { cond } (A),
$$

> **证明：** 由矩阵范数的等价性：$\|A\|_2 \leq \|A\|_1 \leq \sqrt{n}\|A\|_2$（更精确地，$\|A\|_1 \leq n\|A\|_2$ 等）。将这些不等式应用于 A 和 $A^{-1}$ 并相乘，即得各条件数之间的不等式关系。具体地，例如 $\|A\|_1 \leq n\|A\|_2$ 且 $\|A^{-1}\|_1 \leq n\|A^{-1}\|_2$，相乘得 $\text{cond}_1(A) \leq n^2\text{cond}_2(A)$；更精细的估计可利用 $\|A\|_1 \leq \sqrt{n}\|A\|_2$ 得到 $\text{cond}_1(A) \leq n\,\text{cond}_2(A)$。其余不等式同理可得。

定理: $A \in \mathbb{R}^{n \times n}$ , $\det A \neq 0$ , 则

$\min_{A+\delta A \text{奇异}} \frac{||\delta A||_{2}}{||A||_{2}} = \frac{1}{\text{Cond}(A)_{2}}$

证明：只需证 $\min_{A+\delta A \text{奇异}} \|\delta A\|_{2} = \frac{1}{\|A^{-1}\|_{2}}$

若 $\vert\vert A^{-1}\vert\vert_{2}\quad\vert\vert\delta A\vert\vert_{2}<1$ 则有 $A+\delta A$ 非奇异

故有

$$
\min _ {A + S A \mathrm{奇异}} \| S A \| _ {2} \geq \frac {1}{\| A ^ {- 1} \| _ {2}}
$$

另一方面 由从属范数的定义知 存在 $x \in \mathbb{R}^n$ , $\| x \|_2 = 1$ 使得

$$
\| A ^ {- 1} x \| _ {2} = \| A ^ {- 1} \| _ {2}
$$

$$
\hat {\mathrm{令}} \quad y = \frac {A ^ {- 1} x}{\| A ^ {- 1} x \| _ {2}} = \frac {A ^ {- 1} x}{\| A ^ {- 1} \| _ {2}}, \delta A = - \frac {x y ^ {T}}{\| A ^ {- 1} \| _ {2}}
$$

则有 $\|y\|_{2}=1$

$$
(A + \delta A) y = A y + (\delta A) y = \frac {x}{\| A ^ {- 1} \| _ {2}} - \frac {x}{\| A ^ {- 1} \| _ {2}} = 0
$$

$\Rightarrow A + \delta A$ 奇异

又

$$
\begin{array}{r l} {\| \delta A \| _ {2}} & = {\max _ {1 | z | | _ {2} = 1} \left\| \frac {x y ^ {T}}{| | A ^ {- 1} | | _ {2}} z \right\| _ {2}} \\ & = {\frac {| | x | | _ {2}}{| | A ^ {- 1} | | _ {2}}} {\max _ {1 | z | | _ {2} = 1} | y ^ {T} z |} \\ & = {\frac {1}{| | A ^ {- 1} | | _ {2}}} \end{array}
$$

$\Rightarrow \quad \min_{A + \delta A\text{奇异}} ||\delta A||_2 \leq ||\frac{xy^T}{||A^{-1}||_2}||_2 = \frac{1}{||A^{-1}||_2}$

定理: $A \in \mathbb { R } ^ { n \times n } , b \in \mathbb { R } ^ { n } , b \neq 0 , A \text { 非奇异, } x \text { 是 } A x = b \text { 的解, } x \text { 是方程组的一个近似解, } r = b - A \widetilde { x } , \text { 则有 }$

$$
\frac {1}{\text { cond } (A)} \frac {| | r | |}{| | b | |} \leq \frac {| | \hat {x} - x | |}{| | x | |} \leq \text { cond } (A) \frac {| | r | |}{| | b | |}
$$

### 3.5 列主元素消去法的舍入误差分析（扩展内容）

定理：若 $\left|\delta_{i}\right| \leq \varepsilon$ 且 $n\varepsilon \leq 0.01$ 那么

$$
1 - n \varepsilon \leq \prod_ {i = 1} ^ {n} (1 + \delta_ {i}) \leq 1 + (1, 0) n \varepsilon
$$

或写成

$$
\prod_ {i = 1} ^ {n} (1 + \delta_ {i}) = 1 + \delta , \quad | \delta | \leq 1. 0 1 n \varepsilon
$$

证明：由 $|\delta i| \leq \varepsilon$ 得

$$
(1 - \varepsilon) ^ {n} \leq \prod_ {i = 1} ^ {n} (1 + \delta_ {i}) \leq (1 + \varepsilon) ^ {n}
$$

利用函数 $(1-x)^{n}$ 的 Taylor 展开

$$
(1 - x) ^ {n} = 1 - n x + \frac {n (n - 1)}{2} (1 - \theta x) ^ {n - 2} x ^ {2}
$$

得

$$
1 - n x \le (1 - x) ^ {n}
$$

⇒

$$
1 - 1. 0 1 n \varepsilon \leq 1 - n \varepsilon \leq (1 - \varepsilon) ^ {n}
$$

由 $e^{x}$ 的 Taylor 展开

$$
\begin{array}{r l} {e ^ {x}} & {= 1 + x + \frac {x ^ {2}}{2} + \frac {x ^ {3}}{3 !} + \dots} \\ & {= 1 + x + \frac {x}{2} \cdot x \cdot (1 + \frac {x}{3} + \frac {2 x ^ {2}}{4 !} + \dots)} \end{array}
$$

若 $0 \leq x \leq 0.01$ 有

$$
1 + x \le e ^ {x} \le 1 + x + \frac {0 . 0 1}{2} x e ^ {x} \le 1 + 1. 0 1 x
$$

这里用到了 $e^{0.01} < 2$ . 由此可得

$$
(1 + \varepsilon) ^ {n} \le e ^ {n \varepsilon} \le 1 + 1. 0 1 n \varepsilon
$$

例: $x, y \in F^{n}$ , $F$ 为浮点数集合, 估计 $|f_{l}(x^{T}y) - x^{T}y|$ 的上界

令 ${S}_{1} = {fe}\left( {{x}_{1}{y}_{1}}\right)  = {x}_{1}y,\left( {1 + {\delta }_{1}}\right) ,\;{|\delta }_{1}| \leq  \varepsilon$

$$
\begin{array}{r l} {S _ {k}} & {= f \ell (S _ {k - 1} + f \ell (x _ {k} y _ {k}))} \\ & {= (S _ {k - 1} + x _ {k} y _ {k} (1 + \delta_ {k})) (1 + \gamma_ {k}), | \delta_ {k} |, | \gamma_ {k} | \leq \varepsilon .} \end{array}
$$

于是有

$$
\begin{array}{r l} {f _ {\ell} (x ^ {\intercal} y)} & {= S _ {n} = \sum_ {i = 1} ^ {n} x _ {i} y _ {i} (1 + \delta_ {i}) \prod_ {j = i} ^ {n} (1 + \gamma_ {j})} \\ & {= \sum_ {i = 1} ^ {n} (1 + \alpha_ {i}) x _ {i} y _ {i}} \end{array}
$$

其中 $\alpha_{i} = (1+\delta_{i})\prod_{j=i}^{n}(1+\gamma_{j})-1$

$$
\Rightarrow \quad | f _ {\ell} (x ^ {T} y) - x ^ {T} y | \leq \sum_ {i = 1} ^ {n} | \alpha_ {i} | | x _ {i} y _ {i} | \leq 1. 0 1 n \varepsilon \sum_ {i = 1} ^ {n} | x _ {i} y _ {i} |
$$

类似可得 $A: B \in F^{n \times n}, \alpha \in F$

$$
f l (\alpha A) = \alpha A + E, | E | \leq \varepsilon | \alpha A |
$$

$$
f \ell (A + B) = (A + B) + E, \quad | E | \leq \varepsilon | A + B |
$$

$$
f l (A B) = A B + E, \quad | E | \leq 1. 0 1 n E | A | | B |
$$

引理：设 $A = [a_{ij}] \in F^{n \times n}$ 有三角分解且

1.01nε ≤ 0.01 ，则用 Gauss 消去法计算得到的单

位下三角矩阵 $\tilde{L}$ 与上三角矩阵 $\tilde{U}$ 满足

$$
\tilde {L} \tilde {U} = A + E
$$

其中 $|E| \leq 2.05 n \in |\widetilde{L}||\widetilde{U}|$

证明：设 $\widetilde{U}=[\widetilde{u}_{ij}]$ $\widetilde{L}=[\widetilde{\ell}_{ij}]$ 由 Gauss 消去法

的实现过程知

$$
\begin{array}{l} a _ {i j} ^ {(0)} = a _ {i j} \\ a _ {i j} ^ {(k)} = f e (a _ {i j} ^ {(k - 1)} - f e (\tilde {\lambda} _ {i k} \tilde {u} _ {k j})), k = 1, \dots , i - 2 \end{array}
$$

$$
\tilde {u} _ {i j} = a _ {i j} ^ {(i - 1)} = f \ell (a _ {i j} ^ {(i - 2)} - f \ell (\tilde {\ell} _ {i, i - 1}, \tilde {u} _ {i - 1, j})) , i \le j
$$

$$
\Rightarrow a _ {i j} ^ {(k)} = (a _ {i j} ^ {(k - 1)} - (\tilde {\ell} _ {i k} \tilde {u} _ {k j}) (1 + \delta_ {k})) (1 + \gamma_ {k})
$$

其中 $|\delta_k| \leq \varepsilon$ , $|\gamma_k| \leq \varepsilon$ , $k = 1, \cdots, i-1$

由此可得

$$
\widetilde {u} _ {i j} = a _ {i j} (1 + \alpha_ {i}) - \sum_ {k = 1} ^ {i - 1} (\tilde {\ell} _ {i k} \widetilde {u} _ {k j}) (1 + \alpha_ {k})
$$

其中 $\left| {{\alpha }_{k}}\right|  \leq  {1.0}\ln \varepsilon$

$$
\begin{array}{r l} {\Rightarrow a _ {i j}} & {= \frac {\tilde {u} _ {i j}}{1 + \alpha_ {i}} + \sum_ {k = 1} ^ {i - 1} (\hat {\ell} _ {i k} \tilde {u} _ {k j}) \frac {1 + \alpha_ {k}}{1 + \alpha_ {i}}} \\ & {= \sum_ {k = 1} ^ {i} \tilde {\ell} _ {i k} \tilde {u} _ {k j} - e _ {i j}} \\ {\mathrm{其中} \tilde {\ell} _ {i i}} & {= 1, e _ {i j} = (\tilde {\ell} _ {i i} \tilde {u} _ {i j}) \frac {\alpha_ {i}}{1 + \alpha_ {i}} + \sum_ {k = 1} ^ {i - 1} (\hat {\ell} _ {i k} \tilde {u} _ {k j}) \frac {\alpha_ {i} - \alpha_ {k}}{1 + \alpha_ {i}}} \end{array}
$$

注意到 $|\alpha_k| \leq 1.01n\varepsilon < 0.01$ ，则有

$$
| e _ {i j} | \leq \frac {2 . 0 2 n \varepsilon}{1 - 0 . 0 1} \sum_ {k = 1} ^ {i} | \tilde {\ell} _ {i k} | | \tilde {u} _ {k j} | \leq 2. 0 5 n \varepsilon \sum_ {k = 1} ^ {i} | \tilde {\ell} _ {i k} | | \tilde {u} _ {k j} |
$$

对于 i > j 利用 $\tilde{l}_{ij}$ 的计算过程

$$
a _ {i j} ^ {(k)} = f l (a _ {i j} ^ {(k - 1)} - f l (\hat {\ell} _ {i k} \hat {u} _ {k j})), \quad k = 1, 2, \dots , j - 1
$$

$$
\widetilde {\ell} _ {i j} = f \ell (a _ {i j} ^ {(j - 1)} / \widetilde {u} _ {j j})
$$

类似分析可证

$$
a _ {i j} = \sum_ {k = 1} ^ {j} \tilde {e} _ {i h} \hat {u} _ {k j} - e _ {i j}
$$

$$
| e _ {i j} | \le 2. 0 5 n \varepsilon \sum_ {k = 1} ^ {j} | \hat {e} _ {i k} | | \hat {u} _ {k j} |
$$

注意到交换矩阵的行不引入舍入误差，则有

推论： $A \in F^{n \times n}$ 非奇异， $1.01n\varepsilon \leq 0.01$ ，则用选列

主元的 Gauss 消去法 计算得到的单位 下三角阵

$\tilde{U}$ , 上三角阵 $\tilde{U}$ 以及排列方阵 $\tilde{U}$ 满足.

$$
\tilde {L} \tilde {U} = \tilde {P} A + E
$$

其中 $|E| \leq 2.05n \in |\tilde{L}||\tilde{O}|$

引理: 三角阵 $S \in F^{n \times n}$ 非奇异, $1.01 n \varepsilon \leq 0.01$

则用解三角方程组的方法计算 ${sx} = b$ 得

到的解 $\approx$ 满足

$$
(S + H) \tilde {x} = b
$$

其中 $|H| \leq 1.01n\varepsilon|S|$

证明：对 n 用数学归纳法．不妨设 S 为下三角 n=1 时显然成立.

假设对于 $n-1$ 阶下三角矩阵引理成立.

设 $b = \begin{bmatrix} b_{1} \\ c \end{bmatrix}$ , $\widetilde{x} = \begin{bmatrix} \widetilde{x}_{1} \\ \widetilde{y} \end{bmatrix}$

$$
S = \left[ \begin{array}{l l} S _ {1 1} & 0 \\ S _ {1} & S _ {1} \end{array} \right]
$$

$$
s _ {1} \in F ^ {(n - 1) \times (n - 1)}, c \in F ^ {n - 1}, \tilde {y} \in F ^ {n - 1}
$$

则有

$$
\widetilde {x} _ {1} = f l \left(\frac {b _ {1}}{s _ {1 1}}\right) = \frac {b _ {1}}{s _ {1 1} (1 + \delta_ {1})}, \quad | \delta_ {1} | \leq \varepsilon
$$

$\tilde{y}$ 是 $S,y = f\ell(c - \tilde{x}_1s_1)$ 的数值解

由归纳假设得 $\tilde{y}$ 满足

$$
(S _ {i} + H _ {i}) \tilde {y} = f l (C - \tilde {x} _ {i} s _ {i})
$$

其中

$$
| H _ {1} | \leq 1. 0 | (n - 1) \in | S _ {i} |
$$

$$
\begin{array}{r l} {f _ {\ell} (c - \widetilde {x} _ {i} s _ {i})} & {= f _ {\ell} (c - f _ {\ell} (\widetilde {x} _ {i} s _ {i}))} \\ & {= (I + D _ {\gamma}) ^ {- 1} (c - \widetilde {x} _ {i} s _ {i} - \widetilde {x} _ {i} D _ {\delta} s _ {i})} \end{array}
$$

其中

$$
\begin{array}{l l} D _ {r} = \operatorname{diag} (\gamma_ {2} \dots \gamma_ {n}), & D _ {\delta } = \operatorname{diag} (\delta_ {2} \dots \delta_ {n}) \\ | \gamma_ {i} | \leq \varepsilon , & | \delta_ {i} | \leq \varepsilon \end{array}
$$

于是

$$
\tilde {x} _ {1} s _ {1} + \tilde {x} _ {1} D _ {\delta} s _ {1} + (I + D y) (S _ {1} + H _ {1}) \tilde {y} = c
$$

从而有

其中

$\Rightarrow$

$$
\begin{array}{r l} & (S + H) \widetilde {x} = b \\ & H = \left[ \begin{array}{l l} \delta_ {1} S _ {1 1} & 0 \\ D _ {\delta} S _ {1} & H _ {1} + D r (S _ {i} + H _ {1}) \end{array} \right] \\ & | H | \leq \left[ \begin{array}{l l} \varepsilon | S _ {1 1} | & 0 \\ \varepsilon | S _ {1} | & | H _ {1} | + \varepsilon (| S _ {1} | + | H _ {1} |) \end{array} \right] \\ & \leq \varepsilon \left[ \begin{array}{l l} | S _ {1 1} | & 0 \\ | S _ {1} | & (1. 0 1 (n - 1) + 1 + 1. 0 1 (n - 1) \varepsilon) | S _ {1} | \end{array} \right] \\ & \leq 1. 0 1 n \varepsilon | S | \end{array}
$$

最终 选列主元的 Gauss 消去法得到的解通过求解三角方程组

$$
\tilde {L} y = \tilde {P} b, \quad \tilde {U} x = y
$$

得到

由上述定理知又满足

$$
(\tilde {L} + F) (\tilde {U} + G) \hat {x} = \hat {P} b
$$

即 $(\tilde{L}\tilde{U}+F\tilde{U}+\tilde{L}G+F G)\tilde{x}=\tilde{P}b$

其中

$$
| F | \le 1. 0 1 n \varepsilon | \tilde {L} |, \quad | G | \le 1. 0 1 n \varepsilon | \tilde {U} |
$$

将 $\widetilde{L}\widetilde{U}=\widetilde{P}A+E$ 代入得

$$
(A + \delta A) \tilde {x} = b
$$

其中

$$
\delta A = \tilde {p} ^ {T} (E + F \tilde {U} + \tilde {L} G + F G)
$$

$$
\begin{array}{r l} {\Rightarrow} & {| \delta A | \leq \tilde {P} ^ {T} (| E | + | F | | \tilde {U} | + | \tilde {Z} | | G | + | F | | G |)} \\ & {\leq 4. 0 9 n \varepsilon \tilde {P} ^ {T} | \tilde {Z} | | \tilde {U} |} \end{array}
$$

$$
\Rightarrow \quad | | \delta  A | | _ {\infty} \leq 4. 0 9 n \varepsilon | | \tilde {L} | | _ {\infty} | | \tilde {U} | | _ {\infty}
$$

注意到 $|\widetilde{L}| \leq 1 \Rightarrow ||\widetilde{L}||_{\infty} \leq n$

$$
\| \tilde {U} \| _ {\infty} \le n \max _ {i, j} | \tilde {u} _ {i j} | = n \rho \max _ {i, j} | a _ {i j} | \le n \rho \| A \| _ {\infty}
$$

其中

$$
\rho = \max _ {i: j} | \widehat {u} _ {i j} | / \max _ {i: j} | a _ {i j} |
$$

称为选列主元 Gauss 消去法的增长因子

$$
\| \delta A \| _ {\infty} \le 4. 0 9 n ^ {3} \rho \varepsilon \| A \| _ {\infty}
$$

[← 上一篇：线性方程组的直接解法](/posts/numerical-analysis-1/02-direct-methods-linear-systems/)

[下一篇：最小二乘问题的解法 →](/posts/numerical-analysis-1/04-least-squares/)
