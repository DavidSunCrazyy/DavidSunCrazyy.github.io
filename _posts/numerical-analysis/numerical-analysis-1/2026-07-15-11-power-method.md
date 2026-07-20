---
note: true
layout: post
title: "Numerical Analysis I 幂法——特征值估计、幂法与收缩方法"
permalink: /posts/numerical-analysis-1/11-power-method/
categories: numerical-analysis
tags: [numerical-analysis, power-method, eigenvalue, gershgorin, deflation]
use_math: true
---

线性方程组的求解方法我们已经讨论得很充分了。现在转向数值代数中另一个核心问题：矩阵的特征值和特征向量。幂法是最简单实用的特征值计算方法——它利用"矩阵反复右乘一个向量，该向量会逐渐与最大特征值对应的特征向量对齐"这一朴素想法。本章先建立特征值扰动理论，再介绍幂法和反幂法。

# 矩阵特征值问题的数值方法

## 6.1. 特征值的估计和扰动

在迭代求解特征值之前，我们首先需要知道特征值大致落在复平面的什么位置。Gershgorin 圆盘定理提供了一个极其简单的估计工具：每个特征值一定落在以对角元为中心、以该行非对角元绝对值之和为半径的某个圆盘之中。

**定理 6.1.1** (Gershgorin) 设 $A = [a_{ij}] \in \mathbb{C}^{n \times n}$，则 $A$ 的所有特征值满足

$$
\lambda \in \bigcup_{i=1}^{n} D_{i}, \quad
D_{i} = \{z \mid |z - a_{ii}| \leq r_{i}, \; z \in \mathbb{C}\}, \quad
r_{i} = \sum_{\substack{j=1 \\ j \neq i}}^{n} |a_{ij}|
$$

即每个特征值都落在以 $a_{ii}$ 为圆心、$r_i$ 为半径的 $n$ 个圆盘的并集之中。

**证明：** 记 $D = \operatorname{diag}\{a_{11}, a_{22}, \dots, a_{nn}\}$，设 $\lambda \in \sigma(A)$ 且 $x$ 为相应的特征向量。将 $Ax = \lambda x$ 改写为 $(A - D)x = (\lambda I - D)x$。若 $\lambda \neq a_{ii}$（否则 $\lambda$ 显然落在第 $i$ 个圆盘内），则 $\lambda I - D$ 可逆，两边左乘 $(\lambda I - D)^{-1}$ 得

$$
(\lambda I - D)^{-1} (A - D) x = x
$$

取无穷范数并利用相容性：

$$
\|x\|_{\infty} \leq \|(\lambda I - D)^{-1}(A - D)\|_{\infty} \|x\|_{\infty}
\quad\Rightarrow\quad
\|(\lambda I - D)^{-1}(A - D)\|_{\infty} \geq 1
$$

注意到 $(\lambda I - D)^{-1}(A - D)$ 的第 $i$ 行第 $j$ 列元素为 $\frac{a_{ij}}{\lambda - a_{ii}}$（$j \neq i$），对角元为 $0$，因此该矩阵的无穷范数为

$$
\|(\lambda I - D)^{-1}(A - D)\|_{\infty} = \max_{1 \leq i \leq n} \frac{r_i}{|\lambda - a_{ii}|}
$$

于是 $\displaystyle\max_{1 \leq i \leq n} \frac{r_i}{|\lambda - a_{ii}|} \geq 1$，即存在某个 $i$ 使得 $|\lambda - a_{ii}| \leq r_i$，故 $\lambda \in \bigcup_{i=1}^{n} D_i$。

定理 6.1.1 告诉我们特征值落在所有圆盘的并集中，但它没有说明每个圆盘里到底有多少个特征值。下面的定理解决了这个问题。

**定理 6.1.2** 设定理 6.1.1 中的 $n$ 个圆盘里有 $m$ 个构成了一个连通区域 $S$，且 $S$ 与其余 $n-m$ 个圆盘严格分离（即不相交），则在 $S$ 中有且仅有 $A$ 的 $m$ 个特征值（重特征值按重数计算）。

**证明思路：** 记 $D = \operatorname{diag}\{a_{11}, \dots, a_{nn}\}$，构造一族矩阵 $A_{\theta} = D + \theta(A - D)$，$\theta \in [0, 1]$。当 $\theta = 0$ 时 $A_0 = D$，其特征值就是对角元 $a_{ii}$，每个正好落在一个圆盘中心。当 $\theta$ 从 $0$ 连续变化到 $1$ 时，$A_{\theta}$ 的特征值也连续变化，而圆盘半径从 $0$ 逐渐扩大到 $r_i$。由于 $S$ 与其余圆盘始终严格分离，特征值无法「跳跃」到另一个连通区域，因此 $S$ 中始终保持 $m$ 个特征值。$\square$

这个定理在应用中非常方便。来看一个具体例子：

**例** 考虑矩阵

$$
A = \begin{bmatrix}
0.9 & 0.01 & 0.12 \\
0.01 & 0.8 & 0.13 \\
0.01 & 0.02 & 0.4
\end{bmatrix}
$$

$A$ 对应的三个 Gershgorin 圆盘为：
- $D_1 = \{|z - 0.9| \leq 0.13\}$（$r_1 = 0.01 + 0.12 = 0.13$）
- $D_2 = \{|z - 0.8| \leq 0.14\}$（$r_2 = 0.01 + 0.13 = 0.14$）
- $D_3 = \{|z - 0.4| \leq 0.03\}$（$r_3 = 0.01 + 0.02 = 0.03$）

$D_1$ 与 $D_2$ 相交构成一个连通区域，而 $D_3$ 与该区域严格分离。由定理 6.1.2，$D_3$ 中包含 $A$ 的恰好一个特征值，记为 $\lambda_3$。由于实矩阵的复特征值成对出现，而 $D_3$ 关于实轴对称且只含一个特征值，因此 $\lambda_3$ 必为实特征值。

为了进一步分离 $D_1$ 和 $D_2$，我们可以利用相似变换缩放矩阵的某些行/列来缩小圆盘半径。令 $B = \operatorname{diag}(1, 1, 0.1)$，考虑相似变换 $B^{-1}AB$：

$$
B^{-1}AB = \begin{bmatrix}
0.9 & 0.01 & 0.012 \\
0.01 & 0.8 & 0.013 \\
0.1 & 0.2 & 0.4
\end{bmatrix}
$$

变换后的圆盘变为：
- $\overline{D}_1 = \{|z - 0.9| \leq 0.022\}$（$0.01 + 0.012 = 0.022$）
- $\overline{D}_2 = \{|z - 0.8| \leq 0.023\}$（$0.01 + 0.013 = 0.023$）
- $\widehat{D}_3 = \{|z - 0.4| \leq 0.3\}$（$0.1 + 0.2 = 0.3$）

三个圆盘现在全部严格分离。注意 $\widehat{D}_3$ 的半径虽然变大了，但由于原本的 $D_3$ 半径只有 $0.03$，我们可以从中取更紧的界。最终得到：

$$
|\lambda_1 - 0.9| \leq 0.022, \quad |\lambda_2 - 0.8| \leq 0.023, \quad |\lambda_3 - 0.4| \leq 0.03
$$

通过选取合适的相似变换矩阵（对角元不全为 $1$），我们可以在不改变特征值的前提下缩小某些圆盘半径、放大另一些，从而获得更精确的特征值估计。

接下来考虑特征值的扰动问题：当矩阵受到一个小扰动时，其特征值会变化多少？Bauer-Fike 定理给出了一个上界。

**定理 6.1.3** (Bauer-Fike) 设 $\mu$ 是 $A + E \in \mathbb{C}^{n \times n}$ 的一个特征值，且存在 $X \in \mathbb{C}^{n \times n}$ 使得 $X^{-1}AX = D = \operatorname{diag}(\lambda_1, \dots, \lambda_n)$（即 $A$ 可对角化）。则

$$
\min_{\lambda \in \sigma(A)} |\lambda - \mu| \leq \|X^{-1}\|_p \|X\|_p \|E\|_p
$$

其中 $\|\cdot\|_p$ 为矩阵的 $p$-范数，$p = 1, 2, \infty$。

**证明：** 若 $\mu \in \sigma(A)$ 则不等式左边为 $0$，显然成立。下设 $\mu \notin \sigma(A)$。由 $A = XDX^{-1}$ 可得

$$
A + E - \mu I = X\bigl[D - \mu I + X^{-1}EX\bigr] X^{-1}
$$

因为 $\mu$ 是 $A + E$ 的特征值，$A + E - \mu I$ 奇异，从而 $D - \mu I + X^{-1}EX$ 也奇异。于是存在非零向量 $y \in \mathbb{C}^n$ 使得

$$
(D - \mu I)y = -(X^{-1}EX)y
$$

由于 $\mu \notin \sigma(A)$，$D - \mu I$ 可逆，左乘其逆得 $y = -(D - \mu I)^{-1}(X^{-1}EX)y$。取范数并消去 $\|y\|$：

$$
1 \leq \|(D - \mu I)^{-1}\|_p \cdot \|X^{-1}\|_p \cdot \|E\|_p \cdot \|X\|_p
$$

而 $(D - \mu I)^{-1}$ 是对角矩阵，其 $p$-范数为 $\max_i |\lambda_i - \mu|^{-1} = (\min_i |\lambda_i - \mu|)^{-1}$，因此

$$
\|X^{-1}\|_p \|X\|_p \|E\|_p \geq \|(D - \mu I)^{-1}\|_p^{-1} = \min_{\lambda \in \sigma(A)} |\lambda - \mu|
$$

$\|X^{-1}\| \|X\|$ 称为矩阵 $A$ 关于特征值问题的**条件数**。当 $A$ 是正规矩阵时，可以取 $X$ 为酉矩阵，此时条件数为 $1$——正规矩阵的特征值问题是最稳定的。

对于单个特征值，我们还可以给出更精细的条件数。设 $A \in \mathbb{C}^{n \times n}$，$\lambda$ 为 $A$ 的一个单特征值，$x$ 和 $y$ 分别为对应的右、左特征向量：

$$
Ax = \lambda x, \quad y^H A = \lambda y^H, \quad \|x\|_2 = \|y\|_2 = 1
$$

考虑扰动 $A + \varepsilon F$（$\|F\|_2 = 1$），可以证明存在可微函数 $x(\varepsilon)$ 和 $\lambda(\varepsilon)$ 使得

$$
(A + \varepsilon F) x(\varepsilon) = \lambda(\varepsilon) x(\varepsilon), \quad \lambda(0) = \lambda, \; x(0) = x
$$

对 $\varepsilon$ 求导并在 $\varepsilon = 0$ 处取值：

$$
Fx + A\dot{x}(0) = \dot{\lambda}(0)x + \lambda \dot{x}(0)
$$

两边左乘 $y^H$ 并利用 $y^H A = \lambda y^H$：

$$
y^H F x + \lambda y^H \dot{x}(0) = \dot{\lambda}(0) y^H x + \lambda y^H \dot{x}(0)
$$

消去 $\lambda y^H \dot{x}(0)$ 后得到 $\dot{\lambda}(0) = \frac{y^H F x}{y^H x}$，因此

$$
|\dot{\lambda}(0)| \leq \frac{1}{|y^H x|}
$$

量 $\frac{1}{|y^H x|}$ 称为 $A$ 关于特征值 $\lambda$ 的**特征值条件数**。注意 $y^H x$ 是左右特征向量的内积：当 $A$ 为对称矩阵时左右特征向量相同，$|y^H x| = 1$，条件数为 $1$；当 $A$ 严重非正规时左右特征向量近乎正交，条件数可以非常大，这意味着特征值对扰动极其敏感。

## 6.2. 幂法和逆幂法

有了特征值估计和扰动分析的基础，我们现在转向具体的计算方法。幂法的核心直觉非常简单：将一个向量反复乘以矩阵 $A$，它会在模最大的特征值对应的特征向量方向上不断增长。

为了便于描述算法，先定义向量的「最大分量」记号：对 $z = (z_1, \dots, z_n)^T \in \mathbb{R}^n$，定义

$$
\max(z) = z_i, \quad \text{其中 } |z_i| = \|z\|_{\infty}
$$

即 $\max(z)$ 取 $z$ 中绝对值最大的那个分量（其值可正可负，与其本身符号一致）。注意这里 $\max$ 并非通常意义下的最大值，而是一个特殊的记号。

**幂法迭代格式**如下：

$$
\begin{aligned}
&v^{(0)} \in \mathbb{R}^n \quad \text{(任意初始向量)} \\
&\text{for } k = 1, 2, \dots: \\
&\qquad z^{(k)} = A v^{(k-1)} \\
&\qquad m_k = \max(z^{(k)}) \\
&\qquad v^{(k)} = z^{(k)} / m_k
\end{aligned}
$$

每一步将当前向量乘 $A$，然后用最大分量做归一化，防止向量溢出或趋于零。$m_k$ 收敛到主特征值，$v^{(k)}$ 收敛到对应的特征向量。

**定理 6.2.1** 设 $A \in \mathbb{R}^{n \times n}$ 有 $n$ 个线性无关的特征向量 $x_1, x_2, \dots, x_n$，对应的特征值满足

$$
|\lambda_1| > |\lambda_2| \geq \cdots \geq |\lambda_n|
$$

且初始向量 $v^{(0)}$ 在 $x_1$ 方向上的投影非零（即 $v^{(0)}$ 的展开式中 $\alpha_1 \neq 0$），则

$$
\lim_{k \to \infty} v^{(k)} = \frac{x_1}{\max(x_1)}, \qquad
\lim_{k \to \infty} m_k = \lambda_1
$$

**证明：** 首先注意到

$$
v^{(k)} = \frac{A v^{(k-1)}}{m_k} = \cdots = \frac{A^k v^{(0)}}{m_k m_{k-1} \cdots m_1}
$$

由于每次归一化使 $v^{(k)}$ 的最大分量为 $1$，等价地有

$$
v^{(k)} = \frac{A^k v^{(0)}}{\max(A^k v^{(0)})}
$$

将 $v^{(0)}$ 按特征向量展开：$v^{(0)} = \sum_{i=1}^{n} \alpha_i x_i$，其中 $\alpha_1 \neq 0$。则

$$
A^k v^{(0)} = \lambda_1^k \left[ \alpha_1 x_1 + \sum_{i=2}^{n} \alpha_i \left(\frac{\lambda_i}{\lambda_1}\right)^k x_i \right]
$$

当 $k \to \infty$ 时，由于 $|\lambda_i / \lambda_1| < 1$（$i \geq 2$），求和项趋于零，因此

$$
\lim_{k \to \infty} \frac{A^k v^{(0)}}{\lambda_1^k \alpha_1} = x_1
\quad\Rightarrow\quad
\lim_{k \to \infty} \frac{A^k v^{(0)}}{\max(A^k v^{(0)})} = \frac{x_1}{\max(x_1)}
$$

这就证明了特征向量的收敛性。对于 $m_k$，注意到

$$
\begin{aligned}
m_k &= \max(z^{(k)}) = \max(A v^{(k-1)})
     = \frac{\max(A^k v^{(0)})}{\max(A^{k-1} v^{(0)})} \\
    &= \lambda_1 \cdot \frac{\max\!\left(\alpha_1 x_1 + \sum_{i=2}^{n} \alpha_i (\frac{\lambda_i}{\lambda_1})^k x_i\right)}
                            {\max\!\left(\alpha_1 x_1 + \sum_{i=2}^{n} \alpha_i (\frac{\lambda_i}{\lambda_1})^{k-1} x_i\right)}
\end{aligned}
$$

取极限 $k \to \infty$，分子和分母中的求和项均趋于零，因此 $\lim_{k \to \infty} m_k = \lambda_1$。

收敛速度取决于比值 $|\lambda_2 / \lambda_1|$：这个比值越小，收敛越快。当 $|\lambda_2| \approx |\lambda_1|$ 时幂法收敛非常慢，这时需要考虑加速技巧或换用其他方法。

### 逆幂法

幂法求的是模最大的特征值。如果我们想求模最小的特征值呢？一个自然的想法是：对 $A^{-1}$ 应用幂法。因为 $A^{-1}$ 的特征值是 $1/\lambda_i$，模最大的那个正好对应 $A$ 的模最小的特征值。

设 $A \in \mathbb{R}^{n \times n}$ 非奇异且有 $n$ 个线性无关的特征向量 $x_1, \dots, x_n$，对应的特征值满足

$$
|\lambda_1| \geq |\lambda_2| \geq \cdots \geq |\lambda_{n-1}| > |\lambda_n| > 0
$$

则对 $A^{-1}$ 应用幂法，得到**逆幂法**：

$$
\begin{aligned}
&\text{for } k = 1, 2, \dots: \\
&\qquad A z^{(k)} = v^{(k-1)} \quad \text{(解线性方程组而非求逆)} \\
&\qquad m_k = \max(z^{(k)}) \\
&\qquad v^{(k)} = z^{(k)} / m_k
\end{aligned}
$$

注意实现时并不显式计算 $A^{-1}$（求逆开销大且数值不稳定），而是每步求解一个线性方程组 $A z^{(k)} = v^{(k-1)}$。由于 $A$ 不变，可以预先对 $A$ 做 LU 分解，之后每步只需 $O(n^2)$ 的回代操作。

### 原点位移的逆幂法

逆幂法的思想可以进一步推广：如果我们想求离某个给定值 $\delta$ 最近的特征值，只需对 $(A - \delta I)^{-1}$ 应用幂法。$(A - \delta I)^{-1}$ 的特征值是 $1/(\lambda_i - \delta)$，模最大的对应 $\lambda_i$ 中离 $\delta$ 最近的那个。这就是**原点位移的逆幂法**：

$$
\begin{aligned}
&\text{for } k = 1, 2, \dots: \\
&\qquad (A - \delta I) z^{(k)} = v^{(k-1)} \\
&\qquad m_k = \max(z^{(k)}) \\
&\qquad v^{(k)} = z^{(k)} / m_k
\end{aligned}
$$

这个方法的威力在于：如果 $\delta$ 非常接近某个特征值 $\lambda_i$，那么 $|\lambda_i - \delta|^{-1}$ 会远大于其他 $|\lambda_j - \delta|^{-1}$，收敛速度极快——常常只需一两步迭代就能得到高精度的特征向量。这使它成为计算单个特征值的利器。

### 收缩方法

幂法只能求出模最大的特征值（及其特征向量）。如果想求次大特征值，就需要用到**收缩（deflation）**技术：在求出 $\lambda_1$ 和 $x_1$ 之后，将原问题降阶，消除 $\lambda_1$ 的影响，从而继续用幂法求 $\lambda_2$。

以下假设特征值满足严格不等式 $|\lambda_1| > |\lambda_2| > |\lambda_3| \geq \cdots \geq |\lambda_n|$。

**方法一：Householder 相似变换。** 假设已求得 $x_1$（且已归一化使 $\|x_1\|_2 = 1$）。构造 Householder 矩阵 $H$ 使得 $H x_1 = e_1$（即将 $x_1$ 变换到第一个坐标轴方向）。由 $A x_1 = \lambda_1 x_1$ 可得

$$
H A H^{-1} e_1 = \lambda_1 e_1
$$

这意味着 $HAH^{-1}$ 的第一列除了 $(1,1)$ 位置为 $\lambda_1$ 外其余元素全为零。记

$$
A_2 = H A H^{-1} = \begin{bmatrix}
\lambda_1 & b_1^\top \\
0 & B_2
\end{bmatrix}, \quad B_2 \in \mathbb{R}^{(n-1) \times (n-1)}
$$

由于相似变换不改变特征值，$B_2$ 的特征值正好是 $\lambda_2, \dots, \lambda_n$。现在对 $B_2$ 应用幂法求其主特征值 $\lambda_2$ 和特征向量，设 $B_2 y_2 = \lambda_2 y_2$。$A_2$ 的对应特征向量为

$$
z_2 = \begin{bmatrix}
\dfrac{b_1^\top y_2}{\lambda_2 - \lambda_1} \\[6pt]
y_2
\end{bmatrix}
$$

（直接验证 $A_2 z_2 = \lambda_2 z_2$ 即可）。最后 $A$ 的特征向量为 $H^{-1} z_2$。

**方法二：秩一修改（Wielandt 收缩）。** 这个方法的想法是：从 $A$ 中减去 $\lambda_1 x_1$ 对应的秩一矩阵，把 $\lambda_1$「抹成」$0$，而其余特征值不变。

**定理 6.2.2** 设 $A \in \mathbb{R}^{n \times n}$ 的特征值为 $\lambda_1, \dots, \lambda_n$，对应特征向量为 $x_1, \dots, x_n$，且 $\lambda_1$ 的重数为 $1$。取 $v \in \mathbb{R}^n$ 满足 $v^T x_1 = 1$，令

$$
B = A - \lambda_1 x_1 v^T
$$

则 $B$ 的特征值为 $0, \lambda_2, \dots, \lambda_n$，其中 $0$ 对应特征向量 $x_1$，而 $\lambda_i$（$i \geq 2$）对应的特征向量可用下式从 $B$ 的特征向量还原：

$$
x_i = (\lambda_i - \lambda_1) y_i + \lambda_1 (v^T y_i) x_1, \quad i = 2, \dots, n
$$

其中 $y_i$ 是 $B$ 对应于 $\lambda_i$ 的特征向量。

**Wielandt 收缩的具体实施：** 取 $x_1 = (x_{11}, \dots, x_{1n})^T$，设 $x_{1i}$ 为 $x_1$ 的某个非零分量。令

$$
v = \frac{1}{\lambda_1 x_{1i}} (a_{i1}, \dots, a_{in})^T
$$

容易验证 $v^T x_1 = \frac{1}{\lambda_1 x_{1i}} \sum_{j=1}^{n} a_{ij} x_{1j} = 1$（因为 $Ax_1 = \lambda_1 x_1$ 的第 $i$ 个分量正是 $\sum_j a_{ij} x_{1j} = \lambda_1 x_{1i}$）。构造 $B = A - \lambda_1 x_1 v^T$，可以证明 $B$ 的第 $i$ 行全为零。

现在设 $y = (y_1, \dots, y_n)$ 是 $B$ 的属于非零特征值 $\lambda$ 的特征向量：$By = \lambda y$。由 $B$ 的第 $i$ 行为零可知 $\lambda y_i = 0$，从而 $y_i = 0$。这意味着 $y$ 的第 $i$ 个分量恒为零，我们可以直接删去 $B$ 的第 $i$ 行和第 $i$ 列，得到一个 $(n-1) \times (n-1)$ 的矩阵 $B'$。$B'$ 的特征值就是 $\lambda_2, \dots, \lambda_n$。

此时对 $B'$ 应用幂法求其主特征值 $\lambda_2$ 及特征向量 $y_2'$，然后在 $y_2'$ 的第 $i$ 个分量位置插入 $0$ 得到 $(n-1)$ 维向量 $y_2$，再利用定理 6.2.2 中的公式还原出 $A$ 的特征向量 $x_2$。

Wielandt 收缩的巧妙之处在于：每次降阶会消去一行一列，得到的矩阵比原矩阵小一阶，反复操作即可逐一求出所有特征值。

---

**本章小结：** Gershgorin 圆盘定理给出了特征值位置的简单估计，通过相似变换可以进一步缩紧圆盘。Bauer-Fike 定理量化了特征值对扰动的敏感度，特征值条件数 $\frac{1}{|y^H x|}$ 则解释了为什么非正规矩阵的特征值难以精确计算。幂法利用反复左乘的原理，计算量小、实现简单，是求最大（或最小）特征值的首选方法；其收敛速度由 $|\lambda_2/\lambda_1|$ 决定。逆幂法配合原点位移技巧，可以快速计算离任意给定值最近的特征值。收缩方法（Householder 降阶和 Wielandt 秩一修改）则使我们能逐个求出所有特征值。下一章介绍的 QR 方法是计算全部特征值的最通用算法。

[← 上一篇：非线性方程组迭代方法](/posts/numerical-analysis-1/10-nonlinear-systems/)

[下一篇：QR方法 →](/posts/numerical-analysis-1/12-qr-method/)
