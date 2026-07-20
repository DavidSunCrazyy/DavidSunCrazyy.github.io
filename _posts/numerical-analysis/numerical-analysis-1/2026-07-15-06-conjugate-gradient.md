---
note: true
layout: post
title: "Numerical Analysis I 共轭梯度法——最速下降与 Krylov 子空间方法"
permalink: /posts/numerical-analysis-1/06-conjugate-gradient/
categories: numerical-analysis
tags: [numerical-analysis, conjugate-gradient, krylov-subspace, preconditioning]
use_math: true
---

本文介绍共轭梯度法（CG），从二次函数极小化出发，涵盖最速下降法、A-共轭方向、CG 算法的推导与性质（正交性、Krylov 子空间、有限终止性）、基于 Chebyshev 多项式的收敛性分析，以及预处理共轭梯度法（PCG）。

## 4.5 共轭梯度法

考虑线性方程组

$$
A x = b\tag{4.5.1}
$$

$A \in \mathbb{R}^{n \times n}$ 对称正定， $b \in \mathbb{R}^n$

定义二次函数

$$
\varphi (x) = \frac {1}{2} x ^ {T} A x - b ^ {T} x
$$

定理 4.S.1 A 对称正定 则 ${Ax} = b$ 的解 等价于

求 $\varphi(x)$ 的极小值点，即

$A{x}^{ * } = b\;\Leftrightarrow\;{x}^{ * } = \operatorname*{argmin}\limits_{x \in  {\mathbb{R}^{n}}} \varphi \left( x\right)$

证明：若 $x^{*}$ 是 $\varphi(x)$ 的极小值点，则有

$$
\nabla \varphi (x ^ {*}) = 0
$$

直接计算得 $\nabla\varphi(x^{*})=Ax^{*}-b=0$

另一方面，若 $A{x}^{ * } = b$ ，则 ${\forall y} \in  {\mathbb{R}}^{n}$

$$
\begin{array}{r l} {\varphi (x ^ {*} + y)} & {= \frac {1}{2} (x ^ {*} + y) ^ {T} A (x ^ {*} + y) - b ^ {T} (x ^ {*} + y)} \\ & {= \frac {1}{2} (x ^ {*}) ^ {T} A x ^ {*} - b ^ {T} x ^ {*} + y ^ {T} (A x ^ {*} - b)} \\ & {+ \frac {1}{2} y ^ {T} A y} \\ & {= \varphi (x ^ {*}) + \frac {1}{2} y ^ {T} A y \geq \varphi (x ^ {*})} \end{array}
$$

$$
\Rightarrow x ^ {*} = \underset {x \in \mathbb {R} ^ {n}} {\arg \min} \varphi (x)
$$

## ，最速下降法

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
r ^ {0} = b - A x ^ {0}
$$

$$
\mathrm{对于} k = 0, 1, \dots
$$

$$
r ^ {k} = b - A x ^ {k}
$$

$$
\alpha_ {k} = \frac {(r ^ {k} , r ^ {k})}{(r ^ {k} , A r ^ {k})}
$$

$$
x ^ {k + 1} = x ^ {k} + \alpha_ {k} r ^ {k}
$$

定理 4.5.2 设 A 的特征值为 $0 < \lambda_{1} \leq \lambda_{2} \leq \cdots \leq \lambda_{n}$

则由最速下降法产生的 $\{x^k\}$ 满足

$$
\| x ^ {k} - x ^ {*} \| _ {A} \leq \left(\frac {\lambda_ {n} - \lambda_ {1}}{\lambda_ {n} + \lambda_ {1}}\right) ^ {k} \| x ^ {0} - x ^ {*} \| _ {A}
$$

其中 $\|x\|_A = (x^T A x)^{1/2}$

证明：由最速下降法知 $\forall \alpha \in R$

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

设 $u_{1} \cdots u_{n}$ 是 $A$ 的对应于 $\lambda_{1} \cdots \lambda_{n}$ 的特征向

量, 则 ${u}_{1}\cdots {u}_{n}$ 构成了一组单位正交基

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

在共轭梯度法中 下降方向 不再取为 $\nabla \varphi (x^k)$

而是取为 $\{P^{(0)}, P^{(1)}\cdots\}$ 满足

$$
(A P ^ {(i)}, P ^ {(j)}) = 0, \quad i \neq j
$$

$\{P^{(0)}, P^{(1)}, \cdots\}$ 称为 $\mathbb{R}^{n}$ 中的 A-共轭向量组

若 $P^{(0)}, P^{(1)} \cdots$ 已给出，则有迭代方法

$$
\begin{array}{r l} & x ^ {(k + 1)} = x ^ {(k)} + \alpha_ {k} p ^ {(k)} \\ & \alpha_ {k} = \underset {\alpha \in \mathbb {R}} {\operatorname{argmin}} \varphi (x ^ {(k)} + \alpha p ^ {(k)}) \\ & = \frac {(r ^ {(k)} , p ^ {(k)})}{(p ^ {(k)} , A p ^ {(k)})} \end{array}\tag{4.5.2}
$$

定理 4.5.3 若 $\{P^{(0)}, P^{(1)}, \cdots\}$ 为 A-共轭向量组

则由(4.5.2)给出的序列满足

$$
x ^ {(k)} = \arg \min _ {x - x ^ {(0)} \in s p a n \{p ^ {(0)}, \dots p ^ {(k - 1)} \}} \varphi (x)
$$

证明：对 $k$ 用归纳法

k=0 时显然成立.

假设 $k = \ell$ 时成立，

令

$$
\begin{array}{r l} {\tilde {x} ^ {(l + 1)}} & {= \underset { \begin{array}{l} x - x ^ {(0)} \in s p a n \{p ^ {(0)} \dots p ^ {(l)} \} \\ z \in s p a n \{p ^ {(0)} \dots p ^ {(l + 1)} \} \\ \alpha \in \mathbb {R} \end{array} } {\operatorname{argmin}} \varphi (x)} \\ & {= \underset { \begin{array}{l} z \in s p a n \{p ^ {(0)} \dots p ^ {(l + 1)} \} \\ \alpha \in \mathbb {R} \end{array} } {\operatorname{argmin}} \varphi (x ^ {(0)} + z + \alpha p ^ {(l)})} \end{array}
$$

对于 $z \in \operatorname{span}\left\{  {p}^{\left( 0\right) } - \cdots  {p}^{\left( {\ell - 1}\right) }\right\}$

$$
\begin{array}{r l} & {\varphi (x ^ {(0)} + z + \alpha p ^ {(\ell)})} \\ {=} & {\frac {1}{2} (x ^ {(0)} + z + \alpha p ^ {(\ell)}) ^ {T} A (x ^ {(0)} + z + \alpha p ^ {(\ell)})} \\ & {- b ^ {T} (x ^ {(0)} + z + \alpha p ^ {(\ell)})} \\ {=} & {\varphi (x ^ {(0)} + z) + \frac {1}{2} \alpha^ {2} (p ^ {(\ell)}) ^ {T} A P ^ {(\ell)} - \alpha (b - A (x ^ {(0)} + z)) ^ {T} P ^ {(\ell)}} \\ {=} & {\varphi (x ^ {(0)} + z) + \frac {1}{2} \alpha^ {2} (p ^ {(\ell)}, A P ^ {(\ell)}) - \alpha (b - A x ^ {(\ell)}) ^ {T} P ^ {(\ell)}} \end{array}
$$

$$
= \varphi (x ^ {(0)} + z) + \frac {1}{2} \alpha^ {2} (P ^ {(l)}, A P ^ {(l)}) - \alpha (r ^ {(l)}) ^ {T} P ^ {(l)}
$$

由此可得

$$
\tilde {x} ^ {(l + 1)} = x ^ {(l)} + \frac {(r ^ {(l)} , p ^ {(l)})}{(p ^ {(l)} , A p ^ {(l)})} \cdot p ^ {(l)} = x ^ {(l + 1)}
$$

下面确定 $P^{(0)}, P^{(1)}, \cdots$ 的取法

令 ${p}^{\left( 0\right) } = {r}^{\left( 0\right) }$ ,设 ${p}^{\left( 0\right) }{p}^{\left( 1\right) }\cdots {p}^{\left( k - 1\right) }$ 已给出

取 $p^{(k)}$ 与 $p^{(0)}$ $\cdots$ $p^{(k-1)}$ A-共轭即可. (不唯一!)

在 CG 中取

$$
p ^ {(k)} = r ^ {(k)} + \beta_ {k - 1} p ^ {(k - 1)} (4. 5. 3)
$$

则由 $(P^{(k)}, AP^{(k-1)}) = 0$ 可得

$$
\beta_ {k - 1} = - \frac {(r ^ {(k)} , A P ^ {(k - 1)})}{(P ^ {(k - 1)} , A P ^ {(k - 1)})}\tag{4.5.4}
$$

定理 4.5.4. 由 (4.5.2) - (4.5.4) 给出的序列有以下性质：

(1)

$$
(r ^ {(i)}, r ^ {(j)}) = 0, \quad i \ne j
$$

$$
(A P ^ {(i)}, p ^ {(j)}) = 0, \quad i \neq j
$$

证明：首先有

$$
\begin{array}{r l} {r ^ {(k + 1)} =} & {b - A x ^ {(k + 1)} = b - A x ^ {(k)} - \alpha_ {k} A P ^ {(k)}} \\ {=} & {r ^ {(k)} - \alpha_ {k} A P ^ {(k)}} \end{array}
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

假设 $r^{(0)} \cdots r^{(k)}$ 相互正交, $p^{(0)} \cdots p^{(k)}$ $A-$ 共轭

对于 $k+1$ 有

$$
(r ^ {(k + 1)}, r ^ {(j)}) = (r ^ {(k)}, r ^ {(j)}) - \alpha_ {k} (A p ^ {(k)}, r ^ {(j)})
$$

若 j = k

$$
\begin{array}{r l}{(r ^ {(k + 1)}, r ^ {(k)}) =}&{(r ^ {(k)}, r ^ {(k)}) - \alpha_ {k} (A P ^ {(k)}, P ^ {(k)} - \beta_ {k - 1} P ^ {(k - 1)})}\\{(4. 5. 3) \rightarrow}&{= (r ^ {(k)}, r ^ {(k)}) - \alpha_ {k} (A P ^ {(k)}, P ^ {(k)})}\\&{= 0}\end{array}
$$

若 $j < k$

$$
(r ^ {(k + 1)}, r ^ {(j)}) = (r ^ {(k)}, r ^ {(j)}) - \alpha_ {k} (A p ^ {(k)}, p ^ {(j)} - \beta_ {j - 1} p ^ {(j - 1)})
$$

归纳假设 → = 0

由 (4.5.3) (4.5.4) 显然

$$
(P ^ {(k + 1)}, A P ^ {(k)}) = 0
$$

对于 $j < k$

$$
\begin{array}{r l}{(P ^ {(k + 1)}, A P ^ {(j)})}&{= (r ^ {(k + 1)}, A P ^ {(j)}) + \beta_ {k} (P ^ {(k)}, A P ^ {(j)})}\\{\mathrm{归纳假设} \rightarrow}&{= (r ^ {(k + 1)}, \frac {r ^ {(j)} - r ^ {(j + 1)}}{\alpha_ {j}})}\\&{= 0}\end{array}
$$

由定理结论

$$
\begin{array}{r l} \beta_ {k} & = - \frac {(r ^ {(k + 1)} , A p ^ {(k)})}{(p ^ {(k)} , A p ^ {(k)})} = - \frac {(r ^ {(k + 1)} , \alpha_ {k} ^ {- 1} (r ^ {(k)} - r ^ {(k + 1)}))}{(p ^ {(k)} , A p ^ {(k)})} \\ & = \frac {(r ^ {(k + 1)} , r ^ {(k + 1)})}{(r ^ {(k)} , r ^ {(k)})} \end{array}
$$

### 共轭梯度法算法

• 取 $x^{(0)} \in \mathbb{R}^{n}$

$$
r ^ {(0)} = b - A x ^ {(0)}, \quad P ^ {(0)} = r ^ {(0)}
$$

$$
k = 0, 1, \dots
$$

$$
\alpha_ {k} = \frac {(r ^ {(k)} , r ^ {(k)})}{(P ^ {(k)} , A P ^ {(k)})}
$$

$$
x ^ {(k + 1)} = x ^ {(k)} + \alpha_ {k} P ^ {(k)}
$$

$$
r ^ {(k + 1)} = b - A x ^ {(k + 1)}
$$

$$
\beta_ {k} = \frac {(r ^ {(k + 1)} , r ^ {(k + 1)})}{(r ^ {(k)} , r ^ {(k)})}
$$

$$
P ^ {(k + 1)} = r ^ {(k + 1)} + \beta_ {k} P ^ {(k)}
$$

定理 4.5.5 共轭梯度法有以下性质.

(1) $(r^{(j)}, P^{(i)}) = 0, \quad i < j$

(2) span $\{r^{(0)} \cdots r^{(k)}\} = \text{span} \{p^{(0)} \cdots p^{(k)}\}$ $= \text{span} \{r^{(0)}, Ar^{(0)}, \cdots A^{k}r^{(0)}\}$

证明、利用数学归纳法

首先由 (4.5.5) 得

$$
(r ^ {(1)}, P ^ {(0)}) = 0
$$

并且显然 span $\{r^{(0)}\} = \text{span}\{p^{(0)}\}$

假设 (1) 对于 $i < j \leq k$ 成立 (2) 对于 $k$ 成立.

对于 $k + 1$

$$
(r ^ {(k + 1)}, p ^ {(k)}) = 0 \quad (\mathrm{由} (4. 5. 5))
$$

对于 $i < k$

$$
\begin{array}{r l} {(r ^ {(k + 1)}, P ^ {(i)})} & {= (r ^ {(k)}, P ^ {(i)}) - \alpha_ {k} (A P ^ {(k)}, P ^ {(i)})} \\ & {= 0} \end{array}
$$

由共轭梯度法知

$$
\begin{array}{r l} & P ^ {(k + 1)} \in s p a n \{r ^ {(k + 1)}, P ^ {(k)} \} \\ & \subset s p a n \{r ^ {(k + 1)}, r ^ {(0)}, \dots , r ^ {(k)} \} \end{array}
$$

$$
r ^ {(k + 1)} \in s p a n \{r ^ {(k)}, A P ^ {(k)} \}
$$

归纳假设 → ⊂ span $\{r^{(0)}, Ar^{(0)}, \cdots, A^{k}r^{(0)}, A^{k+1}r^{(0)}\}$，其中 span $\{r^{(0)}, Ar^{(0)}, \cdots, A^{k-1}r^{(0)}\}$ 称为 Krylov 子空间
记为 $X(A, r^{(0)}, k)$

定理 4.5.6 共轭梯度法 有如下的误差估计

$$
\| x ^ {(k)} - x ^ {*} \| _ {A} \le 2 \left(\frac {\sqrt {\kappa_2} - 1}{\sqrt {\kappa_2} + 1}\right) ^ {k} \| x ^ {(0)} - x ^ {*} \| _ {A}
$$

其中 $\kappa_2(A) = \text{cond}_2(A) = \|A\|_2 \|A^{-1}\|_2$

证明：令 $P_{k}$ 为常数项为1次数小于等于 $k$ 的实系数多项式全体

$$
\begin{array}{r l} & {\| x ^ {(k)} - x ^ {*} \| _ {A} = 2 \varphi (x ^ {(k)}) + (x ^ {*}) ^ {T} A (x ^ {*})} \\ & {= \min \left\{2 \varphi (x) + (x ^ {*}) ^ {T} A (x ^ {*}), x \in x ^ {(0)} + \chi (A, r ^ {(0)}, k) \right\}} \\ & {= \min \left\{\| x - x ^ {*} \| _ {A}, x \in x ^ {(0)} + \chi (A, r ^ {(0)}, k) \right\}} \\ & {= \min _ {P _ {k} \in P _ {k}} \| A ^ {- 1} P _ {k} (A) r ^ {(0)} \| _ {A}} \\ & {= \min _ {P _ {k} \in P _ {k}} \| P _ {k} (A) A ^ {- 1} r ^ {(0)} \| _ {A}} \\ & {\leq \min _ {P _ {k} \in P _ {k}} \max _ {1 \le i \le n} | P _ {k} (\lambda_ {i}) | \| A ^ {- 1} r ^ {(0)} \| _ {A}} \\ & {\leq \min _ {P _ {k} \in P _ {k}} \max _ {\lambda_ {i} \le \lambda \le \lambda_ {n}} | P _ {k} (\lambda) | \| A ^ {- 1} r ^ {(0)} \| _ {A}} \end{array}
$$

其中 $\lambda_{1}\leq\lambda_{2}\leq\cdots\leq\lambda_{n}$ 为 A 的特征值

由 Chebyshev 多项式逼近定理知

$$
\min _ {P _ {k} \in P _ {k}} \max _ {\lambda_ {1} \leq \lambda \leq \lambda_ {n}} | P _ {k} (\lambda) | = \frac {1}{T _ {k} \left(\frac {\lambda_ {1} + \lambda_ {n}}{\lambda_ {n} - \lambda_ {1}}\right)} \le 2 \left(\frac {\sqrt {\kappa_2} - 1}{\sqrt {\kappa_2} + 1}\right) ^ {k}
$$

其中 $T_{k}$ 为 $k$ 次 Chebyshev 多项式

### 预处理共轭梯度法

Ax=b 可以改写为等价方程组

$$
\tilde {A} \tilde {x} = \tilde {b}
$$

其中 $\tilde{A} = S^{-1} A S^{-T}$ , $\tilde{x} = S^{T}x$ , $\tilde{b} = S^{-1}b$

对于 新方程组 使用 CG

$$
\cdot \quad \tilde {r} ^ {(0)} = \tilde {b} - \tilde {A} \tilde {x} ^ {(0)}, \quad \tilde {p} ^ {(0)} = \tilde {r} ^ {(0)}
$$

$$
\cdot k = 0, 1, 2, \dots
$$

$$
\widetilde {\alpha} _ {k} = \frac {(\widetilde {r} ^ {(k)} , \widetilde {r} ^ {(k)})}{(\widetilde {p} ^ {(k)} , \widetilde {A} \widetilde {p} ^ {(k)})}
$$

$$
\tilde {x} ^ {(k + 1)} = \tilde {x} ^ {(k)} + \tilde {\alpha} _ {k} \tilde {p} ^ {(k)}
$$

$$
\widetilde {r} ^ {(k + 1)} = \widetilde {r} ^ {(k)} - \widetilde {\alpha} _ {k} \widetilde {A} \widetilde {P} ^ {(k)}
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
\begin{array}{r l} {\mathrm{令}} & {p ^ {(k)} = s ^ {- T} \tilde {p} ^ {(k)}, p ^ {(0)} = s ^ {- T} \tilde {p} ^ {(0)} = s ^ {- T} s ^ {- 1} r ^ {(0)}} \\ & {\qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \mathrm{M=SST}} \\ & {\qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \qquad \mathrm{M} ^ {- 1} r ^ {(0)}} \end{array}
$$

$$
\hat {z} ^ {(k)} = M ^ {- 1} r ^ {(k)}
$$

可得预处理共轭梯度法.

$\cdot x^{(0)} \in \mathbb{R}^{n}$

$$
r ^ {(0)} = b - A x ^ {(0)}, z ^ {(0)} = M ^ {- 1} r ^ {(0)}, P ^ {(0)} = z ^ {(0)}
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
r ^ {(k + 1)} = r ^ {(k)} - \alpha_ {k} P ^ {(k)}
$$

$$
M z ^ {(k + 1)} = r ^ {(k + 1)}
$$

$$
\beta_ {k} = \frac {(z ^ {(k + 1)} , r ^ {(k + 1)})}{(z ^ {(k)} , r ^ {(k)})}
$$

$$
P ^ {(k + 1)} = z ^ {(k + 1)} + \beta_ {k} P ^ {(k)}
$$

预处理矩阵 $M$ 的选择.

(1) 对角阵 M = D，A = D - L - U

(2) 不完全 Cholesky 分解

(3). 多项式预处理矩阵

$$
A = M _ {1} - N _ {1}
$$

可构造迭代法

$$
M _ {1} z ^ {(k + 1)} = N _ {1} z ^ {(k)} + r.
$$

取 ${M}^{-1} = \left( {I + G + \cdots  + {G}^{p - 1}}\right) {M}_{i}^{-1}$

$$
G = M _ {i} ^ {- 1} N _ {i}
$$

在实际计算时只需由迭代格式

$$
M _ {i} z ^ {(k + 1)} = N_ {i} z ^ {(k)} + r
$$

计算 z 即可.

[← 上一篇：线性方程组的迭代解法](/posts/numerical-analysis-1/05-iterative-methods-linear-systems/)

[下一篇：多重网格法 →](/posts/numerical-analysis-1/07-multigrid/)
