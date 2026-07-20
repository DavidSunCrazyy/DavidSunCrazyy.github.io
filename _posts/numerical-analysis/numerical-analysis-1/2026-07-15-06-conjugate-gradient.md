---
note: true
layout: post
title: "Numerical Analysis I 共轭梯度法——最速下降与 Krylov 子空间方法"
permalink: /posts/numerical-analysis-1/06-conjugate-gradient/
categories: numerical-analysis
tags: [numerical-analysis, conjugate-gradient, krylov-subspace, preconditioning]
use_math: true
---

上一章的 Jacobi 和 Gauss-Seidel 迭代收敛较慢，特别是对大规模稀疏问题。共轭梯度法（CG）是求解对称正定方程组的更高效方法，它在理论上最多 $n$ 步即可收敛到精确解。CG 的核心思想是把解方程 $Ax = b$ 转化为等价的二次函数极小化问题，然后在 $A$-共轭方向上逐步搜索。

## 4.5 共轭梯度法

考虑线性方程组 $Ax = b$，其中 $A$ 对称正定。求解此方程组等价于极小化二次函数

$$
A x = b\tag{4.5.1}
$$

$A \in \mathbb{R}^{n \times n}$ 对称正定， $b \in \mathbb{R}^n$

定义二次函数

$$
\varphi (x) = \frac {1}{2} x ^ {T} A x - b ^ {T} x
$$

**定理 4.5.1** A 对称正定 则 ${Ax} = b$ 的解 等价于

求 $\varphi(x)$ 的极小值点，即

$A{x}^{ * } = b\;\Leftrightarrow\;{x}^{ * } = \operatorname*{argmin}\limits_{x \in {\mathbb{R}^{n}}} \varphi \left( x\right)$

**证明：** 若 $x^{*}$ 是 $\varphi(x)$ 的极小值点，则有

$$
\nabla \varphi (x ^ {*}) = 0
$$

直接计算得 $\nabla\varphi(x^{*})=Ax^{*}-b=0$

另一方面，若 $A{x}^{ * } = b$ ，则 ${\forall y} \in {\mathbb{R}}^{n}$

$$
\begin{array}{r l} {\varphi (x ^ {*} + y)} & {= \frac {1}{2} (x ^ {*} + y) ^ {T} A (x ^ {*} + y) - b ^ {T} (x ^ {*} + y)} \\ & {= \frac {1}{2} (x ^ {*}) ^ {T} A x ^ {*} - b ^ {T} x ^ {*} + y ^ {T} (A x ^ {*} - b)} \\ & {+ \frac {1}{2} y ^ {T} A y} \\ & {= \varphi (x ^ {*}) + \frac {1}{2} y ^ {T} A y \geq \varphi (x ^ {*})} \end{array}
$$

$$
\Rightarrow x ^ {*} = \underset {x \in \mathbb {R} ^ {n}} {\arg \min} \varphi (x)
$$

### 最速下降法

$$
x ^ {k + 1} = x ^ {k} - \alpha_ {k} \nabla \varphi (x ^ {k})
$$

$$
\mathrm{其中} \quad \alpha_ {k} = \underset {\alpha \in \mathbb {R}} {\arg \min} \varphi (x ^ {k} - \alpha \nabla \varphi (x ^ {k}))
$$

$$
\nabla \varphi (x ^ {k}) = A x ^ {k} - b = - r ^ {k} \quad \mathrm{残差}
$$

${\alpha }_{k}$ 的计算方法为

$$
\begin{array}{r l} {0 = \frac {d}{d \alpha} \varphi (x ^ {k} - \alpha \nabla \varphi (x ^ {k}))} & {= - \nabla \varphi (x ^ {k}) \cdot \nabla \varphi (x ^ {k} + \alpha r ^ {k})} \\ & {= - r ^ {k} \cdot (b - A (x ^ {k} + \alpha r ^ {k}))} \\ & {= - (r ^ {k}, r ^ {k}) + \alpha (r ^ {k}, A r ^ {k})} \end{array}
$$

$$
\Rightarrow \alpha_ {k} = \frac {(r ^ {k} , r ^ {k})}{(r ^ {k} , A r ^ {k})}
$$

由此可得求解 $\varphi(x)$ 极小值点的最速下降法

$$
\begin{align*}
r^{0}=b-Ax^{0} \\
\text{对于 } k=0,1,\dots \\
r^{k}=b-Ax^{k} \\
\alpha_{k}=\frac{(r^{k},r^{k})}{(r^{k},Ar^{k})} \\
x^{k+1}=x^{k}+\alpha_{k}r^{k} \\
\end{align*}
$$

**定理 4.5.2** 设 $A$ 的特征值为 $0 < \lambda_{1} \leq \lambda_{2} \leq \cdots \leq \lambda_{n}$

则由最速下降法产生的 $\{x^k\}$ 满足

$$
\| x ^ {k} - x ^ {*} \| _ {A} \leq \left(\frac {\lambda_ {n} - \lambda_ {1}}{\lambda_ {n} + \lambda_ {1}}\right) ^ {k} \| x ^ {0} - x ^ {*} \| _ {A}
$$

其中 $\|x\|_A = (x^T A x)^{1/2}$

**证明：** 由最速下降法知 $\forall \alpha \in R$

$$
\varphi (x ^ {k}) \leq \varphi (x ^ {k - 1} + \alpha r ^ {k - 1})
$$

则有

$$
\begin{array}{r l} & {(x ^ {k} - x ^ {*}) ^ {T} A (x ^ {k} - x ^ {*})} \\ & {= 2 \varphi (x ^ {k}) + (x ^ {*}) ^ {T} A x ^ {*}} \\ & {\leq 2 \varphi (x ^ {k - 1} + \alpha r ^ {k - 1}) + (x ^ {*}) ^ {T} A x ^ {*}} \\ & {= (x ^ {k - 1} + \alpha r ^ {k - 1} - x ^ {*}) ^ {T} A (x ^ {k - 1} + \alpha r ^ {k - 1} - x ^ {*})} \\ & {= [ (I - \alpha A) (x ^ {k - 1} - x ^ {*}) ] ^ {T} A [ (I - \alpha A) (x ^ {k - 1} - x ^ {*}) ]} \end{array}
$$

$$
\Rightarrow \quad \| x ^ {k} - x ^ {*} \| _ {A} \leq \min _ {\alpha \in \mathbb {R}} \| (I - \alpha A) (x ^ {k - 1} - x ^ {*}) \| _ {A}
$$

设 $u_{1} \cdots u_{n}$ 是 $A$ 的对应于 $\lambda_{1} \cdots \lambda_{n}$ 的特征向量，则 ${u}_{1}\cdots {u}_{n}$ 构成了一组单位正交基

令

$$
x ^ {k - 1} - x ^ {*} = \sum_ {i = 1} ^ {n} \beta_ {i} u _ {i}
$$

则

$$
\begin{array}{l} \left\| (I - \alpha A) (x ^ {k - 1} - x ^ {*}) \right\| _ {A} ^ {2} \\ = \left\| \sum_ {i = 1} ^ {n} \beta_ {i} (1 - \alpha \lambda_ {i}) u _ {i} \right\| _ {A} ^ {2} \end{array}
$$

$$
\begin{array}{r l} & {= \left(\sum_ {i = 1} ^ {n} \beta_ {i} (1 - \alpha \lambda_ {i}) u _ {i}\right) ^ {T} \left(\sum_ {i = 1} ^ {n} \lambda_ {i} \beta_ {i} (1 - \alpha \lambda_ {i}) u _ {i}\right)} \\ & {= \sum_ {i = 1} ^ {n} \lambda_ {i} \beta_ {i} ^ {2} (1 - \alpha \lambda_ {i}) ^ {2}} \\ & {\leq \max _ {1 \leq i \leq n} (1 - \alpha \lambda_ {i}) ^ {2} \sum_ {i = 1} ^ {n} \lambda_ {i} \beta_ {i} ^ {2}} \\ & {= \max _ {1 \leq i \leq n} (1 - \alpha \lambda_ {i}) ^ {2} \| x ^ {k - 1} - x ^ {*} \| _ {A} ^ {2}} \end{array}
$$

由此可得

$$
\| x ^ {k} - x ^ {*} \| _ {A} \leq \min _ {\alpha \in \mathbb {R}} \max _ {1 \leq i \leq n} | 1 - \alpha \lambda_ {i} | \| x ^ {k - 1} - x ^ {*} \| _ {A}
$$

容易验证

$$
\min _ {\alpha \in \mathbb {R}} \max _ {1 \le i \le n} | 1 - \alpha \lambda_ {i} | \le \frac {\lambda_ {n} - \lambda_ {1}}{\lambda_ {n} + \lambda_ {1}}
$$

代入即定理得证.

### 共轭梯度法

在共轭梯度法中，下降方向不再取为 $\nabla \varphi (x^k)$，而是取为 $\{p^{(0)}, p^{(1)}\cdots\}$ 满足

$$
(A p ^ {(i)}, p ^ {(j)}) = 0, \quad i \neq j
$$

$\{p^{(0)}, p^{(1)}, \cdots\}$ 称为 $\mathbb{R}^{n}$ 中的 A-共轭向量组

若 $p^{(0)}, p^{(1)} \cdots$ 已给出，则有迭代方法

$$
\begin{array}{r l} & x ^ {(k + 1)} = x ^ {(k)} + \alpha_ {k} p ^ {(k)} \\ & \alpha_ {k} = \underset {\alpha \in \mathbb {R}} {\operatorname{argmin}} \varphi (x ^ {(k)} + \alpha p ^ {(k)}) \\ & = \frac {(r ^ {(k)} , p ^ {(k)})}{(p ^ {(k)} , A p ^ {(k)})} \end{array}\tag{4.5.2}
$$

**定理 4.5.3** 若 $\{p^{(0)}, p^{(1)}, \cdots\}$ 为 A-共轭向量组

则由(4.5.2)给出的序列满足

$$
x ^ {(k)} = \arg \min _ {x - x ^ {(0)} \in \operatorname{span} \{p ^ {(0)}, \dots p ^ {(k - 1)} \}} \varphi (x)
$$

**证明：** 对 $k$ 用归纳法

k=0 时显然成立.

假设 $k = \ell$ 时成立，

令

$$
\begin{aligned}
\tilde{x}^{(l+1)} 
&= \underset{\substack{x - x^{(0)} \in \operatorname{span}\{p^{(0)},\dots,p^{(l)}\} \\ z \in \operatorname{span}\{p^{(0)},\dots,p^{(l+1)}\} \\ \alpha \in \mathbb{R}}}{\operatorname{argmin}} \varphi(x) \\[6pt]
&= \underset{\substack{z \in \operatorname{span}\{p^{(0)},\dots,p^{(l+1)}\} \\ \alpha \in \mathbb{R}}}{\operatorname{argmin}} \varphi\bigl(x^{(0)} + z + \alpha p^{(l)}\bigr)
\end{aligned}
$$


对于 $z \in \operatorname{span}\left\{ {p}^{\left( 0\right) }, \cdots ,{p}^{\left( {\ell - 1}\right) }\right\}$

$$
\begin{array}{r l} & {\varphi (x ^ {(0)} + z + \alpha p ^ {(\ell)})} \\ {=} & {\frac {1}{2} (x ^ {(0)} + z + \alpha p ^ {(\ell)}) ^ {T} A (x ^ {(0)} + z + \alpha p ^ {(\ell)})} \\ & {- b ^ {T} (x ^ {(0)} + z + \alpha p ^ {(\ell)})} \\ {=} & {\varphi (x ^ {(0)} + z) + \frac {1}{2} \alpha^ {2} (p ^ {(\ell)}) ^ {T} A p ^ {(\ell)} - \alpha (b - A (x ^ {(0)} + z)) ^ {T} p ^ {(\ell)}} \\ {=} & {\varphi (x ^ {(0)} + z) + \frac {1}{2} \alpha^ {2} (p ^ {(\ell)}, A p ^ {(\ell)}) - \alpha (b - A x ^ {(\ell)}) ^ {T} p ^ {(\ell)}} \\
= & \varphi (x ^ {(0)} + z) + \frac {1}{2} \alpha^ {2} (p ^ {(l)}, A p ^ {(l)}) - \alpha (r ^ {(l)}) ^ {T} p ^ {(l)}
\end{array}
$$

由此可得

$$
\tilde {x} ^ {(l + 1)} = x ^ {(l)} + \frac {(r ^ {(l)} , p ^ {(l)})}{(p ^ {(l)} , A p ^ {(l)})} \cdot p ^ {(l)} = x ^ {(l + 1)}
$$

下面确定 $p^{(0)}, p^{(1)}, \cdots$ 的取法。令 ${p}^{\left( 0\right) } = {r}^{\left( 0\right) }$，设 ${p}^{\left( 0\right) }{p}^{\left( 1\right) }\cdots {p}^{\left( k - 1\right) }$ 已给出，取 $p^{(k)}$ 与 $p^{(0)}$ $\cdots$ $p^{(k-1)}$ A-共轭即可（不唯一!）。

在 CG 中取

$$
p ^ {(k)} = r ^ {(k)} + \beta_ {k - 1} p ^ {(k - 1)} (4. 5. 3)
$$

则由 $(p^{(k)}, A p^{(k-1)}) = 0$ 可得

$$
\beta_ {k - 1} = - \frac {(r ^ {(k)} , A p ^ {(k - 1)})}{(p ^ {(k - 1)} , A p ^ {(k - 1)})}\tag{4.5.4}
$$

**定理 4.5.4.** 由 (4.5.2) - (4.5.4) 给出的序列有以下性质：

(1)

$$
(r ^ {(i)}, r ^ {(j)}) = 0, \quad i \ne j
$$

$$
(A p ^ {(i)}, p ^ {(j)}) = 0, \quad i \neq j
$$

**证明：** 首先有

$$
\begin{array}{r l} {r ^ {(k + 1)} =} & {b - A x ^ {(k + 1)} = b - A x ^ {(k)} - \alpha_ {k} A p ^ {(k)}} \\ {=} & {r ^ {(k)} - \alpha_ {k} A p ^ {(k)}} \end{array}
$$

$$
\Rightarrow (r ^ {(k + 1)}, p ^ {(k)}) = (r ^ {(k)}, p ^ {(k)}) - \alpha_ {k} (p ^ {(k)}, A p ^ {(k)}) = 0
$$

由 $(4.5.3)$ 得

$$
(r ^ {(k)}, p ^ {(k)}) = (r ^ {(k)}, r ^ {(k)} + \beta_ {k - 1} p ^ {(k - 1)}) = (r ^ {(k)}, r ^ {(k)})\tag{4.5.5}
$$

所以有

$$
\alpha_ {k} = \frac {(r ^ {(k)} , r ^ {(k)})}{(p ^ {(k)} , A p ^ {(k)})}
$$

下面利用数学归纳法证明定理.

$$
\begin{array}{r l} {(r ^ {(0)}, r ^ {(1)})} & {= (r ^ {(0)}, r ^ {(0)}) - \alpha_ {0} (r ^ {(0)}, A r ^ {(0)}) = 0} \\ {(p ^ {(1)}, A p ^ {(0)})} & {= 0} \end{array}
$$

假设 $r^{(0)} \cdots r^{(k)}$ 相互正交, $p^{(0)} \cdots p^{(k)}$ A-共轭

对于 $k+1$ 有

$$
(r ^ {(k + 1)}, r ^ {(j)}) = (r ^ {(k)}, r ^ {(j)}) - \alpha_ {k} (A p ^ {(k)}, r ^ {(j)})
$$

若 j = k

$$
\begin{array}{r l}{(r ^ {(k + 1)}, r ^ {(k)}) =}&{(r ^ {(k)}, r ^ {(k)}) - \alpha_ {k} (A p ^ {(k)}, p ^ {(k)} - \beta_ {k - 1} p ^ {(k - 1)})}\\{(4. 5. 3) \rightarrow}&{= (r ^ {(k)}, r ^ {(k)}) - \alpha_ {k} (A p ^ {(k)}, p ^ {(k)})}\\&{= 0}\end{array}
$$

若 $j < k$

$$
(r ^ {(k + 1)}, r ^ {(j)}) = (r ^ {(k)}, r ^ {(j)}) - \alpha_ {k} (A p ^ {(k)}, p ^ {(j)} - \beta_ {j - 1} p ^ {(j - 1)})
$$

归纳假设 → = 0

由 (4.5.3) (4.5.4) 显然

$$
(p ^ {(k + 1)}, A p ^ {(k)}) = 0
$$

对于 $j < k$

$$
\begin{array}{r l}{(p ^ {(k + 1)}, A p ^ {(j)})}&{= (r ^ {(k + 1)}, A p ^ {(j)}) + \beta_ {k} (p ^ {(k)}, A p ^ {(j)})}\\{\mathrm{归纳假设} \rightarrow}&{= (r ^ {(k + 1)}, \frac {r ^ {(j)} - r ^ {(j + 1)}}{\alpha_ {j}})}\\&{= 0}\end{array}
$$

由定理结论

$$
\begin{array}{r l} \beta_ {k} & = - \frac {(r ^ {(k + 1)} , A p ^ {(k)})}{(p ^ {(k)} , A p ^ {(k)})} = - \frac {(r ^ {(k + 1)} , \alpha_ {k} ^ {- 1} (r ^ {(k)} - r ^ {(k + 1)}))}{(p ^ {(k)} , A p ^ {(k)})} \\ & = \frac {(r ^ {(k + 1)} , r ^ {(k + 1)})}{(r ^ {(k)} , r ^ {(k)})} \end{array}
$$

### 共轭梯度法算法 (Conjugate Gradient Method)

取 $x^{(0)} \in \mathbb{R}^{n}$

$$
\begin{aligned}
& r^{(0)} = b - A x^{(0)}, \quad p^{(0)} = r^{(0)} \\
& k = 0,1,2,\dots \\
& \alpha_{k} = \frac{(r^{(k)}, r^{(k)})}{(p^{(k)}, A p^{(k)})} \\
& x^{(k+1)} = x^{(k)} + \alpha_{k} p^{(k)} \\
& r^{(k+1)} = b - A x^{(k+1)} \\
& \beta_{k} = \frac{(r^{(k+1)}, r^{(k+1)})}{(r^{(k)}, r^{(k)})} \\
& p^{(k+1)} = r^{(k+1)} + \beta_{k} p^{(k)}
\end{aligned}
$$

**定理 4.5.5** 共轭梯度法有以下性质.

(1) $(r^{(j)}, p^{(i)}) = 0, \quad i < j$

(2) $\operatorname{span} \{r^{(0)} \cdots r^{(k)}\} = \operatorname{span} \{p^{(0)} \cdots p^{(k)}\}$ $= \operatorname{span} \{r^{(0)}, Ar^{(0)}, \cdots A^{k}r^{(0)}\}$

证明、利用数学归纳法

首先由 (4.5.5) 得

$$
(r ^ {(1)}, p ^ {(0)}) = 0
$$

并且显然 $\operatorname{span} \{r^{(0)}\} = \operatorname{span}\{p^{(0)}\}$

假设 (1) 对于 $i < j \leq k$ 成立 (2) 对于 $k$ 成立.

对于 $k + 1$

$$
(r ^ {(k + 1)}, p ^ {(k)}) = 0 \quad (\mathrm{由} (4. 5. 5))
$$

对于 $i < k$

$$
\begin{array}{r l} {(r ^ {(k + 1)}, p ^ {(i)})} & {= (r ^ {(k)}, p ^ {(i)}) - \alpha_ {k} (A p ^ {(k)}, p ^ {(i)})} \\ & {= 0} \end{array}
$$

由共轭梯度法知

$$
\begin{array}{r l} & p ^ {(k + 1)} \in \operatorname{span} \{r ^ {(k + 1)}, p ^ {(k)} \} \\ & \subset \operatorname{span} \{r ^ {(k + 1)}, r ^ {(0)}, \dots , r ^ {(k)} \} \end{array}
$$

$$
r ^ {(k + 1)} \in \operatorname{span} \{r ^ {(k)}, A p ^ {(k)} \}
$$

归纳假设 → ⊂ $\operatorname{span}\{r^{(0)}, Ar^{(0)}, \cdots, A^{k}r^{(0)}, A^{k+1}r^{(0)}\}$，其中 $\operatorname{span}\{r^{(0)}, Ar^{(0)}, \cdots, A^{k-1}r^{(0)}\}$ 称为 Krylov 子空间
记为 $\mathcal{K}(A, r^{(0)}, k)$

**定理 4.5.6** 共轭梯度法 有如下的误差估计

$$
\| x ^ {(k)} - x ^ {*} \| _ {A} \le 2 \left(\frac {\sqrt {\kappa_2} - 1}{\sqrt {\kappa_2} + 1}\right) ^ {k} \| x ^ {(0)} - x ^ {*} \| _ {A}
$$

其中 $\kappa_2(A) = \text{cond}_2(A) = \|A\|_2 \|A^{-1}\|_2$

**证明：** 令 $P_{k}$ 为常数项为 $1$、次数不超过 $k$ 的实系数多项式全体。

设 $A$ 的特征值为 $0 < \lambda_{1} \leq \lambda_{2} \leq \cdots \leq \lambda_{n}$，对应单位正交特征向量 $u_{1}, \dots, u_{n}$。

首先，展开 $A$-范数的平方：

$$
\begin{aligned}
\|x - x^{*}\|_A^2 &= (x - x^{*})^T A (x - x^{*}) \\
&= x^T A x - 2(x^{*})^T A x + (x^{*})^T A x^{*} \\
&= x^T A x - 2b^T x + (x^{*})^T A x^{*} \quad (\text{利用 } Ax^{*} = b) \\
&= 2\varphi(x) + (x^{*})^T A x^{*}
\end{aligned}
$$

由定理 4.5.3，$x^{(k)}$ 在 $x^{(0)} + \mathcal{K}(A, r^{(0)}, k)$ 上极小化 $\varphi(x)$，因此

$$
\begin{aligned}
\|x^{(k)} - x^{*}\|_A^2 &= 2\varphi(x^{(k)}) + (x^{*})^T A x^{*} \\
&= \min_{x \in x^{(0)} + \mathcal{K}(A, r^{(0)}, k)} \bigl(2\varphi(x) + (x^{*})^T A x^{*}\bigr) \\
&= \min_{x \in x^{(0)} + \mathcal{K}(A, r^{(0)}, k)} \|x - x^{*}\|_A^2
\end{aligned}
$$

下面将 Krylov 子空间极小化转化为多项式极小化。对任意 $x \in x^{(0)} + \mathcal{K}(A, r^{(0)}, k)$，存在次数不超过 $k-1$ 的多项式 $q_{k-1}$ 使得

$$
x = x^{(0)} + q_{k-1}(A) \, r^{(0)}
$$

注意到 $r^{(0)} = b - A x^{(0)} = A(x^{*} - x^{(0)})$，故 $x^{(0)} - x^{*} = -A^{-1} r^{(0)}$。于是

$$
\begin{aligned}
x - x^{*} &= (x^{(0)} - x^{*}) + q_{k-1}(A) \, r^{(0)} \\
&= -A^{-1} r^{(0)} + q_{k-1}(A) \, r^{(0)} \\
&= -A^{-1}\bigl(I - A \, q_{k-1}(A)\bigr) \, r^{(0)}
\end{aligned}
$$

令 $p_k(t) = 1 - t \cdot q_{k-1}(t)$，则 $p_k$ 次数不超过 $k$ 且常数项为 $1$，即 $p_k \in P_k$，且

$$
x - x^{*} = -A^{-1} \, p_k(A) \, r^{(0)}
$$

反之，对任意 $p_k \in P_k$，取 $q_{k-1}(t) = (1 - p_k(t))/t$，可逆推得 $x \in x^{(0)} + \mathcal{K}(A, r^{(0)}, k)$。因此

$$
\min_{x \in x^{(0)} + \mathcal{K}(A, r^{(0)}, k)} \|x - x^{*}\|_A = \min_{p_k \in P_k} \|A^{-1} p_k(A) \, r^{(0)}\|_A
$$

利用特征分解，将 $r^{(0)} = \sum_{i=1}^{n} \xi_i u_i$ 代入：

$$
\begin{aligned}
\|A^{-1} p_k(A) \, r^{(0)}\|_A^2 &= \Bigl\|\sum_{i=1}^{n} \frac{p_k(\lambda_i)}{\lambda_i} \, \xi_i \, u_i\Bigr\|_A^2 \\
&= \sum_{i=1}^{n} \lambda_i \left(\frac{p_k(\lambda_i)}{\lambda_i} \, \xi_i\right)^2 = \sum_{i=1}^{n} \frac{p_k(\lambda_i)^2}{\lambda_i} \, \xi_i^2 \\
&\leq \max_{1 \leq i \leq n} p_k(\lambda_i)^2 \sum_{i=1}^{n} \frac{\xi_i^2}{\lambda_i} \\
&= \max_{1 \leq i \leq n} |p_k(\lambda_i)|^2 \cdot \|A^{-1} r^{(0)}\|_A^2
\end{aligned}
$$

开方后取最小值得

$$
\|x^{(k)} - x^{*}\|_A \leq \min_{p_k \in P_k} \max_{1 \leq i \leq n} |p_k(\lambda_i)| \cdot \|A^{-1} r^{(0)}\|_A
$$

将离散特征值放宽到连续区间 $[\lambda_1, \lambda_n]$：

$$
\|x^{(k)} - x^{*}\|_A \leq \min_{p_k \in P_k} \max_{\lambda_1 \leq \lambda \leq \lambda_n} |p_k(\lambda)| \cdot \|A^{-1} r^{(0)}\|_A
$$

注意到 $\|A^{-1} r^{(0)}\|_A = \|x^{(0)} - x^{*}\|_A$（因 $x^{(0)} - x^{*} = -A^{-1} r^{(0)}$）。

由 Chebyshev 多项式逼近定理，

$$
\min_{p_k \in P_k} \max_{\lambda_1 \leq \lambda \leq \lambda_n} |p_k(\lambda)| = \frac{1}{T_k\!\left(\frac{\lambda_n + \lambda_1}{\lambda_n - \lambda_1}\right)} \leq 2\left(\frac{\sqrt{\kappa_2} - 1}{\sqrt{\kappa_2} + 1}\right)^k
$$

其中 $T_k$ 为 $k$ 次 Chebyshev 多项式，$\kappa_2 = \lambda_n / \lambda_1 = \|A\|_2 \|A^{-1}\|_2$。

代回即得

$$
\|x^{(k)} - x^{*}\|_A \leq 2\left(\frac{\sqrt{\kappa_2} - 1}{\sqrt{\kappa_2} + 1}\right)^k \|x^{(0)} - x^{*}\|_A
$$

### 预处理共轭梯度法

$Ax=b$ 可以改写为等价方程组

$$
\tilde {A} \tilde {x} = \tilde {b}
$$

其中 $\tilde{A} = S^{-1} A S^{-T}$ , $\tilde{x} = S^{T}x$ , $\tilde{b} = S^{-1}b$

对于 新方程组 使用 CG

$$
\quad \tilde {r} ^ {(0)} = \tilde {b} - \tilde {A} \tilde {x} ^ {(0)}, \quad \tilde {p} ^ {(0)} = \tilde {r} ^ {(0)}
$$

$$
k = 0, 1, 2, \dots
$$

$$
\widetilde {\alpha} _ {k} = \frac {(\widetilde {r} ^ {(k)} , \widetilde {r} ^ {(k)})}{(\widetilde {p} ^ {(k)} , \widetilde {A} \widetilde {p} ^ {(k)})}
$$

$$
\tilde {x} ^ {(k + 1)} = \tilde {x} ^ {(k)} + \tilde {\alpha} _ {k} \tilde {p} ^ {(k)}
$$

$$
\widetilde {r} ^ {(k + 1)} = \widetilde {r} ^ {(k)} - \widetilde {\alpha} _ {k} \widetilde {A} \widetilde {p} ^ {(k)}
$$

$$
\tilde {\beta} _ {k} = \frac {(\tilde {r} ^ {(k + 1)} , \tilde {r} ^ {(k + 1)})}{(\tilde {r} ^ {(k)} , \tilde {r} ^ {(k)})}
$$

$$
\tilde {p} ^ {(k + 1)} = \tilde {r} ^ {(k + 1)} + \tilde {\beta} _ {k} \tilde {p} ^ {(k)}
$$

换回原始变量，令 $x^{(k)} = S^{-T} \tilde{x}^{(k)}$

$$
\begin{array}{r l r} {\tilde {r} ^ {(k)}} & = & {\tilde {b} - \tilde {A} \tilde {x} ^ {(k)} = s ^ {- 1} (b - A s ^ {- T} s ^ {T} x ^ {(k)})} \\ & & {= s ^ {- 1} r ^ {(k)}} \end{array}
$$

$$
\begin{array}{r l} {\mathrm{令}} & {p ^ {(k)} = s ^ {- T} \tilde {p} ^ {(k)}, p ^ {(0)} = s ^ {- T} \tilde {p} ^ {(0)} = s ^ {- T} s ^ {- 1} r ^ {(0)}} \\ & { \mathrm{M=SST}} \\ & {\mathrm{M} ^ {- 1} r ^ {(0)}} \end{array}
$$

$$
\hat {z} ^ {(k)} = M ^ {- 1} r ^ {(k)}
$$

可得预处理共轭梯度法.

$\cdot x^{(0)} \in \mathbb{R}^{n}$

$$
r ^ {(0)} = b - A x ^ {(0)}, z ^ {(0)} = M ^ {- 1} r ^ {(0)}, p ^ {(0)} = z ^ {(0)}
$$

$$
k = 0, 1, \dots
$$

$$
\alpha_ {k} = \frac {(z ^ {(k)} , r ^ {(k)})}{(p ^ {(k)} , A p ^ {(k)})}
$$

$$
x ^ {(k + 1)} = x ^ {(k)} + \alpha_ {k} p ^ {(k)}
$$

$$
r ^ {(k + 1)} = r ^ {(k)} - \alpha_ {k} p ^ {(k)}
$$

$$
M z ^ {(k + 1)} = r ^ {(k + 1)}
$$

$$
\beta_ {k} = \frac {(z ^ {(k + 1)} , r ^ {(k + 1)})}{(z ^ {(k)} , r ^ {(k)})}
$$

$$
p ^ {(k + 1)} = z ^ {(k + 1)} + \beta_ {k} p ^ {(k)}
$$

预处理矩阵 $M$ 的选择.

(1) 对角阵 $M = D$，$A = D - L - U$

(2) 不完全 Cholesky 分解

(3). 多项式预处理矩阵

$$
A = M _ {1} - N _ {1}
$$

可构造迭代法

$$
M _ {1} z ^ {(k + 1)} = N _ {1} z ^ {(k)} + r.
$$

取 ${M}^{-1} = \left( {I + G + \cdots + {G}^{p - 1}}\right) {M}_{i}^{-1}$

$$
G = M _ {i} ^ {- 1} N _ {i}
$$

在实际计算时只需由迭代格式

$$
M _ {i} z ^ {(k + 1)} = N_ {i} z ^ {(k)} + r
$$

计算 z 即可.

---

**本章小结：** 共轭梯度法的巧妙之处在于将解线性方程组转化为二次函数极小化，并在 $A$-共轭方向上搜索——这保证了每个方向的搜索互不干扰，理论上 $n$ 步内收敛。收敛速度由条件数决定：$\text{cond}(A)$ 越小收敛越快。预处理技术本质上是在不改变解的前提下减小等价问题的条件数。下一章将介绍另一种利用问题结构的加速方法——多重网格法。

[← 上一篇：线性方程组的迭代解法](/posts/numerical-analysis-1/05-iterative-methods-linear-systems/)

[下一篇：多重网格法 →](/posts/numerical-analysis-1/07-multigrid/)
