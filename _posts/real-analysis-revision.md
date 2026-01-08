---
layout: post
title: Real Analysis Revision
permalink: /2025/01/real-analysis-revision/
---

# 实分析复习提纲

> 本提纲涵盖实分析的核心内容，按照逻辑顺序组织，确保知识体系的连贯性和完整性。

## 目录

- [第一部分：测度论基础](#第一部分测度论基础)
  - [1. 集合系的构造](#1-集合系的构造)
  - [2. 测度的构造](#2-测度的构造)
  - [3. Lebesgue测度](#3-lebesgue测度)
  - [4. 可测映射与可测函数](#4-可测映射与可测函数)
  - [5. 乘积测度](#5-乘积测度)
- [第二部分：Lebesgue积分理论](#第二部分lebesgue积分理论)
- [第三部分：收敛模式](#第三部分收敛模式)
- [第四部分：函数空间](#第四部分函数空间)
- [第五部分：Lp空间理论](#第五部分lp空间理论)
- [第六部分：微分理论](#第六部分微分理论)
- [第七部分：Hausdorff测度与维数](#第七部分hausdorff测度与维数)
- [第八部分：拓扑空间测度](#第八部分拓扑空间测度)

---

## 第一部分：测度论基础

**前置知识**：集合论基础、实数系
**核心思想**：从集合系到σ-代数，从预测度到测度，通过Carathéodory条件构造完备的测度空间

### 1. 集合系的构造

> **目标**：建立可测性的基础，理解从简单集合系到σ-代数的层次结构

#### 1.1 扩充实数系
- **定义**：$\overline{\mathbb{R}} = \mathbb{R} \cup \{\pm\infty\}$
- **关键约定**：$0 \times (\pm\infty) = 0$
- **序关系**：$-\infty < a < \infty$ 对所有 $a \in \mathbb{R}$

#### 1.2 基础集合系（按包含关系）

```
半环 ⊂ 环 ⊂ 代数 ⊂ σ-代数
```

**π-系**：对有限交封闭

**半环**：
- 是π-系
- 差集可表示为有限个不交集合的并
- 典型例子：$\mathscr{Q}_{\mathbb{R}} = \{(a,b]: a \leq b\}$

**环**：
- 对有限并和差封闭
- 等价刻画：对差和有限并封闭

**代数**：
- 包含空集
- 对补、有限交、有限并封闭
- 等价刻画：$\emptyset \in \mathcal{A}$，对补封闭，有限并封闭

**σ-代数**：
- 对补、可数交、可数并封闭
- 等价刻画：$\emptyset \in \mathscr{F}$，对补封闭，可数并封闭

**重要性质**：
- σ-子代数仍是σ-代数
- σ-代数的任意交仍是σ-代数
- De Morgan法则成立

#### 1.3 集合序列的极限

**单调递增序列**：$A_n \nearrow A = \cup_{n=1}^\infty A_n$

**单调递减序列**：$A_n \searrow A = \cap_{n=1}^\infty A_n$

**一般序列**：
- $\limsup_{n\to\infty} A_n = \cap_{k=1}^\infty \cup_{n \geq k} A_n$（无穷多次发生）
- $\liminf_{n\to\infty} A_n = \cup_{k=1}^\infty \cap_{n \geq k} A_n$（最终总发生）

#### 1.4 生成σ-代数

**定义**：$\sigma(\mathcal{E}) = \cap\{A: A \text{是包含} \mathcal{E} \text{的} \sigma\text{-代数}\}$

**存在性**：由于$\mathcal{P}(X) \in \Sigma(\mathcal{E})$，交集非空

**典型例子**：
- $\mathcal{B}(\mathbb{R}) = \sigma(\{(a,b): a,b \in \mathbb{R}\})$

#### 1.5 可测空间

**定义**：$(X, \mathscr{F})$，其中$\mathscr{F}$是$X$上的σ-代数

**可测集**：$A \in \mathscr{F}$

#### 1.6 Borel代数

**定义**：$\mathcal{B}(X)$ 是拓扑空间$X$上由开集生成的σ-代数

**特殊集合**：
- $G_\delta$集：可数个开集的交
- $F_\sigma$集：可数个闭集的并

**重要定理**：$(\mathbb{R}, \mathcal{M}(\mathbb{R}), m)$ 是 $(\mathbb{R}, \mathcal{B}(\mathbb{R}), m|_{\mathcal{B}(\mathbb{R})})$ 的完备化

**与下一节的联系**：σ-代数为测度的定义提供了基础框架

---

### 2. 测度的构造

> **目标**：理解如何从简单的集函数（预测度）通过外测度和Carathéodory条件构造完备的测度空间

#### 2.1 测度的定义

**定义**：非负集函数 $\mu: \mathscr{F} \to [0,\infty]$，满足：
1. $\mu(\emptyset) = 0$
2. 可数可加性：对两两不交的 $\{A_n\}$，$\mu(\cup A_n) = \sum \mu(A_n)$

**基本性质**（命题1.1）：
- **有限可加性**：对有限个不交集成立
- **单调性**：$A \subset B \Rightarrow \mu(A) \leq \mu(B)$
- **可数次可加性**：$\mu(\cup A_n) \leq \sum \mu(A_n)$
- **下连续性**：$A_n \nearrow A \Rightarrow \mu(A_n) \to \mu(A)$
- **上连续性**：$A_n \searrow A, \mu(A_1) < \infty \Rightarrow \mu(A_n) \to \mu(A)$

#### 2.2 测度空间

**定义**：$(X, \mathscr{F}, \mu)$，其中 $(X, \mathscr{F})$ 是可测空间，$\mu$ 是测度

**特殊集**：
- **零测集**：$A \in \mathscr{F}$ 且 $\mu(A) = 0$
- **可略集**：零测集的子集

#### 2.3 预测度

**定义**：半环 $\mathscr{Q}$ 上的集函数 $\mu$，满足：
1. $\mu(\emptyset) = 0$
2. 可数可加性

**性质**（命题1.6）：
- 单调性
- 可减性：$\mu(B \setminus A) = \mu(B) - \mu(A)$（当 $B \setminus A \in \mathscr{Q}$）
- 可数次可加性
- 有限可加性
- 下连续性和上连续性

#### 2.4 外测度

**定义**：$\tau: \mathcal{P}(X) \to [0,\infty]$，满足：
1. $\tau(\emptyset) = 0$
2. 单调性
3. 可数次可加性

**构造方法**：
$$\mu^*(A) = \inf\{\sum_{n=1}^\infty \mu(E_n): \{E_n\} \subset \mathscr{E}, A \subset \cup E_n\}$$

#### 2.5 Carathéodory条件

**定义**：集合 $A \subset X$ 满足 Carathéodory 条件，如果：
$$\tau(D) = \tau(D \cap A) + \tau(D \cap A^c), \quad \forall D \subset X, \tau(D) < \infty$$

**直观意义**：$A$ 能够完美分割任意集合 $D$ 的外测度

#### 2.6 Carathéodory测度构造定理

**定理**：设 $\tau$ 是外测度，定义 $\mathscr{F}_\tau = \{A: A \text{满足 Carathéodory 条件}\}$，则：
1. $\mathscr{F}_\tau$ 是 σ-代数
2. $(X, \mathscr{F}_\tau, \tau)$ 是完备测度空间
3. $\tau$ 在 $\mathscr{F}_\tau$ 上是测度（满足可数可加性）

**证明思路**：
- 验证对补、有限并、可数并封闭
- 利用递归分解证明可数可加性
- 通过单调性和零测集子集验证完备性

#### 2.7 Carathéodory-Hahn-Kolmogorov测度扩张定理

**定理**：设 $\mu$ 是半环 $\mathscr{Q}$ 上的预测度，通过外测度构造扩张到 $\sigma(\mathscr{Q})$：
1. $\sigma(\mathscr{Q}) \subset \mathscr{F}$，$(X, \sigma(\mathscr{Q}), \mu|_{\sigma(\mathscr{Q})})$ 和 $(X, \mathscr{F}, \mu)$ 都是测度空间，后者完备
2. 若 $\nu$ 是 $\sigma(\mathscr{Q})$ 上的测度扩张，则 $\nu(A) \leq \mu(A)$，有限时等号成立
3. **唯一性**：若 $\nu$ σ-有限且是预测度，则扩张唯一

**应用**：Lebesgue测度的构造

#### 2.8 完备化

**定义**：$\overline{\mathscr{F}} = \{A \cup B: A \in \mathscr{F}, B \in \mathcal{N}\}$，$\bar{\mu}(A \cup B) = \mu(A)$

**定理**：$(X, \overline{\mathscr{F}}, \bar{\mu})$ 是完备测度空间

**完备的等价刻画**（命题1.37）：
- $\mu$ 完备
- 若 $f$ 可测，$f = g$ a.e.，则 $g$ 可测
- 若 $f_n$ 可测且 $f_n \to f$ a.e.，则 $f$ 可测

**例子**：Borel测度不完备，Lebesgue测度是其完备化

#### 2.9 测度的前推

**定义**：$\Phi_* \mu(E) = \mu(\Phi^{-1}(E))$

**定理**：$\Phi_* \mu$ 是 $(Y, \mathscr{G})$ 上的测度

**与下一节的联系**：测度构造理论为具体的Lebesgue测度提供了理论基础

---

### 3. Lebesgue测度

> **目标**：理解最重要的具体测度——Lebesgue测度的构造和性质

#### 3.1 Lebesgue测度的构造

**准分布函数**：$F: \mathbb{R} \to \mathbb{R}$ 单调递增且右连续

**构造步骤**：
1. 半环 $\mathscr{Q}_{\mathbb{R}^n}$（长方体）
2. 预测度 $\nu_F((a,b]) = F(b) - F(a)$
3. Carathéodory扩张得到 $(\mathbb{R}^n, \mathcal{M}(\mathbb{R}^n), m)$

**特殊情形**：$F(x) = x$ 生成标准Lebesgue测度

#### 3.2 Lebesgue测度的正则性

**外正则性**：$m^*(E) = \inf\{m(G): E \subset G, G \text{开集}\}$

**内正则性**：$m(E) = \sup\{m(K): K \subset E, K \text{紧集}\}$

**等价刻画**：$E \in \mathcal{M}(\mathbb{R}^n) \Leftrightarrow \forall \varepsilon > 0, \exists$ 开集 $G \supset E, m^*(G \setminus E) < \varepsilon$

**逼近定理**（推论1.19）：任意可测集可用 $G_\delta$ 集和 $F_\sigma$ 集逼近（差集为零测集）

#### 3.3 Lebesgue测度的不变性

**定理**：
- **平移不变性**：$m(E + x) = m(E)$
- **反射不变性**
- **线性变换**：$m(T(E)) = |\det T| \cdot m(E)$

**证明思路**：通过外测度的平移不变性和Carathéodory条件

**例子**：对角矩阵（拉伸）的不变性

#### 3.4 不可测集

**Vitali集的构造**：
1. 等价关系 $x \sim y \Leftrightarrow x - y \in \mathbb{Q}^n$
2. 用选择公理选代表元构造 $W$
3. 用Steinhaus定理导出矛盾

**定理**：任意正测度集 $E$ 都包含非Lebesgue可测子集

#### 3.5 Steinhaus定理

**引理**：正测度集 $E$ 必存在长方体 $I$ 使得 $m(I \cap E) > \lambda |I|$（$\lambda < 1$ 任意接近1）

**Steinhaus定理**：若 $m(E) > 0$，则 $\exists r > 0, B(0,r) \subset E - E$

**应用**：证明Vitali集不可测

#### 3.6 度量空间上的测度

**度量外测度**：$d(A,B) > 0 \Rightarrow \tau(A \cup B) = \tau(A) + \tau(B)$

**定理**（命题1.22）：度量外测度的Carathéodory可测集包含所有Borel集

**正则性**（定理1.23）：局部有界Borel测度具有正则性

#### 3.7 以ρ为密度的测度

**定义**：$\nu = \rho \mu$，其中 $\rho: X \to [0,\infty]$ 是非负可测函数，$\nu(A) = \int_X \rho \mathbf{1}_A d\mu$

**定理**：
- $\nu$ 是 σ-有限的测度
- $\int f d\nu = \int f\rho d\mu$（$\rho$ 是Radon-Nikodym导数）

**与下一节的联系**：Lebesgue测度为积分理论奠定了基础

---

### 4. 可测映射与可测函数

> **目标**：建立函数与测度的联系，理解可测性的判定和函数逼近

#### 4.1 可测映射

**定义**：$f: (X, \mathscr{A}) \to (Y, \mathscr{B})$ 是可测映射，如果 $\forall B \in \mathscr{B}$，$f^{-1}(B) \in \mathscr{A}$

**判定定理**（命题1.26）：若 $\mathscr{M} = \sigma(\mathscr{E})$，则 $f$ 可测 $\Leftrightarrow f^{-1}E \in \mathscr{F}, \forall E \in \mathscr{E}$

**基本性质**：
- 连续函数是Borel可测的
- 单调函数是Borel可测的
- 复合：$g \circ f$ 可测若 $f, g$ 都可测

**拉回**：$f^* \mathscr{G} = \{f^{-1}A: A \in \mathscr{G}\}$ 是 $X$ 上的σ-代数

**前推**：$f_* \mathscr{F} = \{B \subset Y: f^{-1}(B) \in \mathscr{F}\}$ 是 $Y$ 上的σ-代数

**定理**（引理1.29）：$f^{-1}(\sigma(\mathscr{E})) = \sigma(f^{-1}\mathscr{E})$

#### 4.2 可测函数

**定义**：$f: (X, \mathscr{F}) \to (\overline{\mathbb{R}}, \mathscr{B}(\overline{\mathbb{R}}))$ 是可测映射

**判定定理**：$f$ 可测 $\Leftrightarrow f^{-1}([-\infty, a)) \in \mathscr{F}, \forall a$

**可测函数序列极限**：$\sup f_n, \inf f_n, \limsup f_n, \liminf f_n$ 都可测

**定理**：任意Lebesgue可测函数 $f$，存在Borel可测函数 $\tilde{f}$ 使得 $f = \tilde{f}$ a.e.

#### 4.3 函数逼近

**阶梯函数逼近定理**（定理1.35）：对任意可测函数 $f$，存在阶梯函数序列 $\{\psi_k\}$ 和零测集 $N$，使得 $\psi_k \to f$ 在 $N^c$ 上逐点成立

**证明思路**：
1. 利用简单函数逼近
2. 用Littlewood第一原理将简单函数改造为阶梯函数
3. 用Borel-Cantelli引理控制例外集

**与下一节的联系**：可测函数为积分的定义提供了基础

---

### 5. 乘积测度

> **目标**：理解高维空间的测度结构，掌握Tonelli-Fubini定理

#### 5.1 σ-有限性

**定义**：测度 $\mu$ 是 σ-有限的，若存在可数集序列 $\{E_n\}$ 使得 $X = \cup E_n$ 且 $\mu(E_n) < \infty$

**例子**：Lebesgue测度是 σ-有限的

**重要性**：保证乘积测度扩张的唯一性

#### 5.2 乘积σ-代数

**可测矩形**：$\mathscr{E} = \{A \times B: A \in \mathscr{F}_1, B \in \mathscr{F}_2\}$

**乘积σ-代数**：$\mathscr{F}_1 \otimes \mathscr{F}_2 = \sigma(\mathscr{E})$

#### 5.3 截口

**集合的截口**：
- $E_x = \{y: (x,y) \in E\}$
- $E^y = \{x: (x,y) \in E\}$

**函数的截口**：
- $f_{(x,\cdot)} = f(x,\cdot)$
- $f_{(\cdot,y)} = f(\cdot,y)$

**定理**：若 $E \in \mathscr{F}_1 \otimes \mathscr{F}_2$，则 $E_x \in \mathscr{F}_2, E^y \in \mathscr{F}_1$

**证明思路**：通过示性函数和单调类定理

#### 5.4 乘积测度空间

**定义**：$\nu[A \times B] = \mu_1(A)\mu_2(B)$ 对可测矩形

**定理**：$\nu$ 是预测度

**Carathéodory-Hahn-Kolmogorov扩张**：在 σ-有限条件下，扩张唯一

**与下一部分的联系**：乘积测度为Tonelli-Fubini定理提供了基础

---

### 第一部分小结

**逻辑链条**：
```
集合系 → σ-代数 → 预测度 → 外测度 → Carathéodory条件
→ 测度空间 → 完备化 → Lebesgue测度 → 乘积测度
```

**关键定理**：
1. Carathéodory测度构造定理
2. Carathéodory-Hahn-Kolmogorov测度扩张定理
3. Lebesgue测度的正则性和不变性
4. Steinhaus定理

**核心技巧**：
- 通过生成集验证可测性
- 利用Carathéodory条件构造测度
- 通过内外正则性进行逼近

---

**下一步：第二部分 Lebesgue积分理论** →

## 第二部分：Lebesgue积分理论

**前置知识**：测度论基础、可测函数
**核心思想**：从简单函数到一般函数，通过逼近建立积分理论，利用三大收敛定理处理极限交换

### 1. 简单函数

**定义**：$f = \sum_{i=1}^N a_i \mathbf{1}_{E_i}$，有限个可测集指示函数的线性组合

**规范表示**：$f = \sum_{i=1}^M b_i \mathbf{1}_{F_i}$，其中 $\{F_i\}$ 是 $X$ 的分割，$\{b_i\}$ 两两不同

**性质**：$f \in \overline{\mathbb{R}}^X$ 属于 $\mathcal{SP}(X)$ 当且仅当 $f$ 可测且 $f(X)$ 为有限集

**简单函数积分**：$\int f = \sum_{i=1}^N a_i \mu(E_i)$

**逼近定理**：
- 对非负函数 $f$，存在递增简单函数序列 $\{f_n\}$ 使得 $f_n \to f$ 逐点
- 对一般函数 $f$，存在简单函数序列 $\{f_n\}$ 满足 $|f_n| \leq |f_{n+1}|$ 且 $f_n \to f$ 逐点

**证明思路**（对非负函数）：
- 对每个 $n$，记 $T_n = \{f \geq n\}$，$E_{n,k} = \{\frac{k-1}{2^n} \leq f < \frac{k}{2^n}\}$
- 定义 $f_n = n\mathbf{1}_{T_n} + \sum_{k=1}^{n2^n} \frac{k-1}{2^n} \mathbf{1}_{E_{n,k}}$
- 则 $0 \leq f(\omega) - f_n(\omega) \leq \frac{1}{2^n}, \forall \omega \in T_n^c$

---

### 2. Lebesgue积分的定义

**层次定义**：

**第一层**：简单函数 $f = \sum_{i=1}^N a_i \mathbf{1}_{E_i}$
$$\int f = \sum_{i=1}^N a_i \mu(E_i)$$

**第二层**：非负可测函数 $f \in \mathcal{L}_+(X)$
$$\int f d\mu = \sup \{\int \phi d\mu: \phi \in \mathcal{SP}_+(X), \phi \leq f\}$$

**第三层**：一般可测函数 $f \in \mathcal{L}(X)$
$$\int f = \int f_+ - \int f_-$$
其中 $f_+ = \max(f,0)$，$f_- = \max(-f,0)$

**可积性**：
- **积分存在**：$\int f_+$ 和 $\int f_-$ 至少有一个有限
- **可积**：$\int |f| < \infty$，记 $f \in \mathcal{L}^1(X)$

**几乎处处有限**：$|f| < \infty, \mu$-a.e.，记 $f \in \mathcal{L}^0(X)$

---

### 3. 积分的性质

**核心性质**：
1. **零函数性质**：若 $f = 0$ a.e.，则 $\int f = \int |f| = 0$
2. **可积函数几乎处处有限**：若 $f \in \mathcal{L}^1(X)$，则 $f \in \mathcal{L}^0(X)$
3. **Chebyshev不等式**：若 $f \in \mathcal{L}^1(X) \cap \mathcal{L}_+(X)$，则对任意 $\alpha > 0$：
   $$\mu\{f \geq \alpha\} \leq \frac{1}{\alpha} \int_X f$$
4. **线性性质**：$\mathcal{L}^1(X)$ 是线性空间，积分是线性映射
5. **几乎处处相等的函数积分相同**
6. **单调性**：若 $f \leq g$ a.e.，则 $\int f \leq \int g$
7. **三角不等式**：$|\int f| \leq \int |f|$

---

### 4. 三大收敛定理

**重要性排序**：MCT → Fatou → DCT（强度递增）

#### 4.1 单调收敛定理（MCT, Beppo Levi）

**定理**：设 $\{f_n\} \subset \mathcal{L}_+(X)$，$f_n \leq f_{n+1}$，$f_n \to f$ 逐点，则：
$$\lim_{n\to\infty} \int f_n d\mu = \int f d\mu$$

**级数形式**：设 $\{f_n\} \subset \mathcal{L}_+(X)$，则：
$$\int \sum_{n=0}^\infty f_n d\mu = \sum_{n=0}^\infty \int f_n d\mu$$

**反例**（说明单调性必要）：
- $X = \mathbb{R}, f_n = \mathbf{1}_{[n,\infty)}$：$f_n \to 0$ 但 $\int f_n = \infty \not\to 0$
- $X = (0,1], f_n = n\mathbf{1}_{(0,1/n]}$：$f_n \to 0$ 但 $\int f_n = 1 \not\to 0$

#### 4.2 Fatou引理

**定理**：若 $\{f_n\} \subset \mathcal{L}_+(X)$，则：
$$\int \liminf_{n\to\infty} f_n d\mu \leq \liminf_{n\to\infty} \int f_n d\mu$$

**证明思路**：
1. 令 $g_m = \inf_{n \geq m} f_n$，则 $g_m$ 递增
2. $\int g_n \leq \int f_n, \forall n$
3. 由 MCT 知 $\int \liminf f_n = \int \lim g_n = \lim \int g_n \leq \liminf \int f_n$

**Lieb形式**：设 $\{f_n\}$ 和 $f$ 都可积，$f_n \to f$ a.e.，则：
$$\lim_{n\to\infty} |\int (f_n - f)| = 0 \Leftrightarrow \lim_{n\to\infty} \int |f_n| = \int |f|$$

#### 4.3 控制收敛定理（DCT）

**定理**：设 $\{f_n\} \subset \mathcal{L}^1(X)$，$|f_n| \leq g$ a.e.（其中 $g \in \mathcal{L}^1(X)$），$f_n \to f$ a.e.，则：
$$\lim_{n\to\infty} \int f_n d\mu = \int f d\mu$$
且 $\lim_{n\to\infty} \int |f_n - f| d\mu = 0$

**证明思路**：
1. 由可积的控制判别，$f_n, f \in \mathcal{L}^1(X)$
2. 不妨设 $f_n \to f, |f_n| \leq g$ 逐点成立
3. $\int f + \int g = \int \lim (f_n+g) \leq \liminf \int (f_n+g) = \liminf \int f + \int g$
4. 因此 $\int f \leq \liminf \int f$，同理 $\int -f \leq \liminf \int -f$

**变形**：
- 若 $|f_n| \leq g_n$，$g_n \to g$ a.e.，且 $\|g_n\|_{L^1} \to \|g\|_{L^1}$，则 $\int f_n \to \int f$
- $f_n \xrightarrow{L^1} f \Leftrightarrow \|f_n\|_{L^1} \to \|f\|_{L^1}$

#### 4.4 有界控制定理（BCT）

**定理**：设 $|f_n| \leq M$ a.e.，$\mu(X) < \infty$，$f_n \to f$ a.e.，则 $f_n \xrightarrow{L^1} f$

**意义**：DCT 在有限测度空间和有界序列情形的特例

---

### 5. Tonelli-Fubini定理

**重要性**：将高维积分化为一维，是多元微积分的基础

#### 5.1 Tonelli定理（非负函数）

**定理**：设 $(\Omega_i, \mathscr{F}_i, \mu_i)$ 是 σ-有限测度空间，$(\Omega, \mathscr{F}, \mu) = (\Omega_1 \times \Omega_2, \mathscr{F}_1 \otimes \mathscr{F}_2, \mu_1 \otimes \mu_2)$

若 $f \in \mathcal{L}_+(\Omega)$，则：
- 对 a.e. $x \in \Omega_1$，截口 $f(x,\cdot) \in \mathcal{L}_+(\Omega_2)$
- $g(x) = \int f(x,\cdot) d\mu_2 \in \mathcal{L}_+(\Omega_1)$
- **积分交换**：
  $$\int_\Omega f d\mu = \int_{\Omega_1} \left(\int_{\Omega_2} f(x,y) d\mu_2(y)\right) d\mu_1(x) = \int_{\Omega_2} \left(\int_{\Omega_1} f(x,y) d\mu_1(x)\right) d\mu_2(y)$$

#### 5.2 Fubini定理（可积函数）

**定理**：若 $f \in \mathcal{L}^1(\Omega)$，则：
- 对 a.e. $x \in \Omega_1$，$f(x,\cdot) \in \mathcal{L}^1(\Omega_2)$
- 对 a.e. $y \in \Omega_2$，$f(\cdot,y) \in \mathcal{L}^1(\Omega_1)$
- 积分交换公式成立

**应用**：计算重积分、验证可积性

---

### 6. 积分换元公式

#### 6.1 抽象积分换元公式

**定理**：设 $\Phi: (X, \mathscr{F}) \to (Y, \mathscr{G})$ 是可测映射，$\nu = \Phi_* \mu$，则：
$$\int_Y f(y) d\nu(y) = \int_X (f \circ \Phi)(x) d\mu(x)$$

**证明思路**：
1. 对指示函数 $f = \mathbf{1}_E$ 验证
2. 对简单函数（利用线性）
3. 对非负可测函数（用MCT）
4. 对一般函数（分解为正负部）

#### 6.2 $\mathbb{R}^n$ 上的积分换元公式

**定理**：设 $\Omega_1, \Omega_2 \subset \mathbb{R}^n$ 是开集，$\Phi: \Omega_1 \to \Omega_2$ 是微分同胚，则：
$$\int_{\Omega_2} f(y) dy = \int_{\Omega_1} (f \circ \Phi)(x) |\mathbf{J}_\Phi(x)| dx$$

其中 $\mathbf{J}_\Phi(x) = \det(Jac(\Phi)(x)) = \det\left(\frac{\partial \Phi_i}{\partial x_j}\right)$

**证明思路**（五步法）：
1. 闭方体的体积变换：$m(\Phi(Q)) \leq (\sup_{x \in Q} \|Jac(\Phi)(x)\|_\infty)^n m(Q)$
2. 推论：零测集的像仍是零测集
3. 闭方体不等式：$m(\Phi(Q)) \leq \int_Q |\mathbf{J}_\Phi(x)| dx$
4. 开集和Borel集的不等式
5. 函数的积分换元

**典型例子**：
- **球面坐标**（2维）：$\iint f(x,y) dxdy = \iint f(r\cos\theta, r\sin\theta) r dr d\theta$
- **球面坐标**（3维）：$\iiint f(x,y,z) dxdydz = \iiint f(r\sin\theta\cos\varphi, r\sin\theta\sin\varphi, r\cos\theta) r^2\sin\theta dr d\theta d\varphi$

---

### 7. 含参积分的连续性和求导

#### 7.1 连续性

**定理**：设 $(X, \mathscr{F}, \mu)$ 是测度空间，$I$ 是度量空间，$f: X \times I \to \mathbb{R}$ 满足：
1. 对任意 $t \in I$，$\omega \mapsto f(\omega,t) \in \mathcal{L}^1(X)$
2. $t \mapsto f(\omega,t)$ 连续，$\forall \omega$ a.e.
3. 存在 $g \in \mathcal{L}^1(X)$ 使得 $|f(\omega,t)| \leq g(\omega)$ a.e., $\forall t \in I$

则 $F(t) = \int_X f(\omega,t) d\mu$ 连续

#### 7.2 方向导数

**定理**：设 $\Omega \subset \mathbb{R}^n$ 是开集，$(X, \mathscr{F}, \mu)$ 完备，$f: X \times \Omega \to \mathbb{R}$，$v \in \mathbb{R}^n \setminus \{0\}$，满足：
1. 对任意 $x \in \Omega$，$\omega \mapsto f(\omega,x) \in \mathcal{L}^1(X)$
2. $x \mapsto f(\omega,x)$ 连续且方向可导，$\forall \omega$ a.e.
3. 存在 $g \in \mathcal{L}^1(X)$ 使得 $|\nabla_v f(\omega,x)| \leq g(\omega)$ a.e., $\forall x \in \Omega$

则 $\nabla_v F(x) = \int \nabla_v f(\omega,x) d\mu$

---

### 8. Lebesgue积分与Riemann积分的关系

**定理**：若 $f$ 在 $[a,b]$ 上 Riemann 可积，则：
1. $f$ 是 Lebesgue 可积的
2. 两种积分值相等

**反例**：$f(x) = \frac{\sin x}{x}$ 在 $\mathbb{R}$ 上
- 有反常 Riemann 积分（条件收敛）
- 不是 Lebesgue 可积的（因为 $\int |f| = \infty$）

**Lebesgue积分的优势**：
- 可处理更广泛的函数类
- 极限交换条件更宽松（DCT vs. 一致收敛）
- 乘积空间理论更完善（Tonelli-Fubini）

---

### 第二部分小结

**逻辑链条**：
```
简单函数 → 非负函数 → 一般函数 → 积分性质
→ 三大收敛定理 → Tonelli-Fubini → 积分换元
```

**关键定理**（按重要性排序）：
1. MCT：建立积分收敛性的基础
2. DCT：最常用的极限交换工具
3. Tonelli-Fubini：处理高维积分
4. Fatou：提供不等式估计
5. 积分换元公式：变量替换的基础

**核心技巧**：
- 简单函数逼近
- 寻找控制函数
- 利用单调性

---

**下一步：第三部分 收敛模式** →


## 第三部分：收敛模式

**前置知识**：Lebesgue积分、测度论
**核心思想**：理解不同收敛模式的定义、关系和转换，掌握Egorov定理和Riesz定理

### 1. 几乎处处收敛

**定义**：$f_n \to f$ a.e. 表示 $\mu\{x: f_n(x) \not\to f(x)\} = 0$

**性质**：
- 在零测集上可以任意定义极限
- 不蕴含依测度收敛（测度无限时）

**反例**：$f_n = \mathbf{1}_{[n,\infty)}$，$f_n \to 0$ 逐点但不依测度收敛

---

### 2. 近一致收敛

**定义**：$f_n \xrightarrow{a.u.} f$，如果 $\forall \varepsilon > 0$，存在 $A_\varepsilon \in \mathscr{F}$ 使得 $\mu(A_\varepsilon) < \varepsilon$，且 $f_n \rightrightarrows f$ 在 $X \setminus A_\varepsilon$ 上一致收敛

**直观理解**：去掉一个测度任意小的集合后，函数列一致收敛

**与L∞收敛的关系**：$L^\infty$ 收敛等价于在零测集外一致收敛

---

### 3. 依测度收敛

**定义**：$f_n \xrightarrow{\mu} f$，如果 $\forall \varepsilon > 0$：
$$\lim_{n\to\infty} \mu\{x: |f_n(x) - f(x)| \geq \varepsilon\} = 0$$

**性质**：
- 不要求逐点收敛
- 测度有限时，a.e.收敛蕴含依测度收敛

**反例**（测度无限）：$f_n = \mathbf{1}_{[n,n+1]}$，$f_n \to 0$ 依测度但不 a.e. 收敛

---

### 4. L1收敛

**定义**：$f_n \xrightarrow{L^1} f$，如果：
$$\lim_{n\to\infty} \int |f_n - f| d\mu = 0$$

**性质**：
- $L^1$ 收敛蕴含依测度收敛（Chebyshev不等式）
- 与范数收敛等价：$\|f_n - f\|_{L^1} \to 0$

**判定**（DCT变形）：$f_n \xrightarrow{a.e.} f$ 且 $\|f_n\|_{L^1} \to \|f\|_{L^1}$，则 $f_n \xrightarrow{L^1} f$

---

### 5. 收敛模式之间的关系

**蕴含关系**：
$$L^\infty \Rightarrow a.u. \Rightarrow a.e. \Rightarrow \text{依测度} \Leftarrow L^1$$

**定理**：
1. **近一致收敛 ⇒ 依测度收敛**（命题1.56(1)）
2. **a.e.收敛 + 有限测度 ⇒ 近一致收敛**（Egorov定理）
3. **依测度收敛 ⇒ 存在子列a.e.收敛**（Riesz定理）
4. **L¹收敛 ⇒ 依测度收敛**

**反例**（反向不成立）：
- a.e.收敛 ⇏ 依测度收敛：$f_n = \mathbf{1}_{[n,\infty)}$（测度无限）
- 近一致收敛 ⇏ $L^\infty$ 收敛：$f_n = \mathbf{1}_{[0,1/n]}$（$L^\infty$ 范数恒为1）

---

### 6. Egorov定理

**定理**：设 $\mu(E) < \infty$，$f_n \to f$ a.e.，则 $f_n \xrightarrow{a.u.} f$

**证明思路**：
1. 构造 $A_n(k) = \cup_{m \geq n} \{|f_m - f| \geq 1/k\}$
2. 利用测度的上连续性和收敛级数控制
3. 通过有限并和一致收敛的定义验证

**推论**：在有限测度空间中，a.e. 收敛和近一致收敛等价

---

### 7. Riesz定理

**定理**：若 $f_n \xrightarrow{\mu} f$，则存在子列 $\{f_{n_k}\}$ 使得 $f_{n_k} \xrightarrow{a.u.} f$，从而 a.e. 收敛

**证明思路**：
1. 对每个 $k$，令 $E_{n,k} = \{|f_n - f| > 1/k\}$
2. 根据 $f_n \xrightarrow{\mu} f$，存在 $N_k$ 使得对 $n \geq N_k$，$\mu(E_{n,k}) < 2^{-k}$
3. 取 $N_k$ 严格递增，得到子列 $\{f_{N_k}\}$
4. 考虑 $E = \cup_{k=K}^\infty E_{N_k,k}$，则 $\mu(E) < \varepsilon$ 且在 $X \setminus E$ 上一致收敛

**应用**：从依测度收敛提取几乎处处收敛的子列

---

### 8. Littlewood三原则

**第一原则**：每个可测集都接近基础集（有限长方体并）
- 利用正则性：$\forall \varepsilon > 0$，存在开集 $G \supset E$，$m(G \setminus E) < \varepsilon$

**第二原则**：每个可测函数都接近连续函数（Lusin定理）
- $\forall \varepsilon > 0$，存在闭集 $F$ 和 $g \in C(\mathbb{R}^n)$ 使得 $g = f$ 在 $F$ 上，$m(\{f \neq g\}) < \varepsilon$

**第三原则**：每个收敛的可测函数序列都接近一致收敛（Egorov定理）
- 在有限测度空间中，a.e. 收敛蕴含近一致收敛

**直观意义**：在实分析中，"坏"的情形只发生在很小的集合上

---

### 第三部分小结

**收敛模式对比表**：

| 收敛模式 | 定义 | 强度 | 有限测度时 |
|---------|------|------|-----------|
| $L^\infty$ | sup范数收敛 | 最强 | 强 |
| 近一致 | 去掉小集后一致 | 强 | 等价于a.e. |
| a.e. | 除零测集外收敛 | 中 | 等价于近一致 |
| 依测度 | 测度偏差收敛 | 弱 | 弱于a.e. |
| $L^1$ | 积分范数收敛 | 特殊 | 蕴含依测度 |

**关键定理**：
1. Egorov定理：a.e. → 近一致（有限测度）
2. Riesz定理：依测度 → 子列a.e.
3. Littlewood三原则：可测性的逼近性质

**核心技巧**：
- 利用Egorov定理将a.e.收敛转为一致收敛
- 利用Riesz定理提取收敛子列
- 利用测度控制例外集

---

**下一步：第四部分 函数空间** →


## 第四部分：函数空间

**前置知识**：Lebesgue积分、收敛模式
**核心思想**：建立函数的完备空间，理解稠密性和逼近

### 1. L¹空间

**定义**：
- $\mathcal{L}^1(X) = \{f \in \mathcal{L}(X): \int |f| < \infty\}$
- $L^1(X) = \mathcal{L}^1(X)/\mathcal{N}$（几乎处处相等的函数视为同一元素）

**范数**：$\|f\|_{L^1} = \int_X |f| d\mu$

**定理**（Riesz-Fischer）：$(L^1(X), \|\cdot\|_{L^1})$ 是 Banach 空间（完备）

**稠密子空间**：
- 可积简单函数空间 $\mathcal{SP} \cap L^1(X)$
- 阶梯函数空间 $ST(\mathbb{R}^n)$
- 光滑紧支函数空间 $C_c^\infty(\mathbb{R}^n)$

**变换连续性**：
- **平移**：$\lim_{h \to 0} \|\tau_h f - f\|_{L^1} = 0$，其中 $\tau_h f(x) = f(x+h)$
- **伸缩**：$S_\delta f(x) = f(\delta x)$，$\|S_\delta f\|_{L^1} = \delta^{-n} \|f\|_{L^1}$（在 $\mathbb{R}^n$ 上）

---

### 2. L²空间

**定义**：$L^2(X) = \mathcal{L}^2(X)/\mathcal{N}$，其中 $\mathcal{L}^2(X) = \{f: \int |f|^2 < \infty\}$

**范数**：$\|f\|_{L^2} = \left(\int_X |f|^2 d\mu\right)^{1/2}$

**内积**：$\langle f, g \rangle = \int_X f \overline{g} d\mu$

**性质**：$L^2$ 是 Hilbert 空间，具有最丰富的结构

---

### 3. L∞空间

**定义**：
- $\mathcal{L}^\infty(X) = \{f \in \mathcal{L}^0(X): \|f\|_{L^\infty} < \infty\}$
- $L^\infty(X) = \mathcal{L}^\infty(X)/\mathcal{N}$

**本质极大模**：$\|f\|_{L^\infty} = \text{esssup}_X |f| = \inf\{a: |f| \leq a \text{ a.e.}\}$

**定理**：$(L^\infty(X), \|\cdot\|_{L^\infty})$ 是 Banach 空间

**性质**：
- $C_0(\mathbb{R}^n) = \{f \in C(\mathbb{R}^n): \lim_{|x| \to \infty} f(x) = 0\}$ 是 $C_c(\mathbb{R}^n)$ 在 $L^\infty$ 中的闭包
- $L^\infty(\mathbb{R}^n)$ 不可分（与 $L^1$ 形成对比）
- 平移和伸缩算子不连续

**反例**：$f(x) \equiv 1$ 不能被有紧支集的函数在 $L^\infty$ 中逼近

---

### 4. 局部L¹空间

**定义**：$f \in L^1_{\text{loc}}(\Omega)$ 当且仅当 $f$ 可测且对任意紧集 $K \subset \Omega$，$\int_K |f| < \infty$

**关系**：$L^1(\Omega) \subsetneq L^1_{\text{loc}}(\Omega)$

**应用**：每个 $f \in L^1_{\text{loc}}(\Omega)$ 定义正则分布：
$$\langle f, \phi \rangle = \int_\Omega f(x)\phi(x) dx$$

---

### 5. 连续紧支函数空间

**定义**：$C_c(\mathbb{R}^n) = C(\mathbb{R}^n) \cap \{f: \text{supp}(f) \text{ 紧}\}$

**性质**：$C_c(\mathbb{R}^n)$ 是 Banach 空间

**稠密性**：在 $L^p$（$1 \leq p < \infty$）中稠密，但在 $L^\infty$ 中不然

---

### 6. 光滑紧支函数空间

**定义**：$C_c^\infty(\mathbb{R}^n) = C^\infty(\mathbb{R}^n) \cap C_c(\mathbb{R}^n)$

**性质**：在 $L^1(\mathbb{R}^n)$ 中稠密

---

### 7. 支集

**定义**：$\text{supp}(f) = \overline{\{x: f(x) \neq 0\}}$

**性质**：紧支集函数在分布理论中很重要

---

### 8. 卷积

**定义**：对 $f, g \in C_c(\mathbb{R}^n)$：
$$f * g(x) = \int_{\mathbb{R}^n} f(x-y)g(y) dy$$

**性质**：
1. **$L^1$ 性质**：对 $f, g \in L^1$，$\|f * g\|_{L^1} \leq \|f\|_{L^1} \|g\|_{L^1}$（Banach 代数）
2. **正则性**：若 $f \in L^1, g \in L^\infty$，则 $f * g$ 连续有界且一致连续
3. **逼近**：对一族好核 $K_\varepsilon$，$f * K_\varepsilon \xrightarrow{L^1} f$

**支集性质**：$\text{supp}(f * g) \subset \overline{\text{supp}(f) + \text{supp}(g)}$

**典型例子**：截断函数 $\rho_\varepsilon$ 构成好核

---

### 9. 可分性

**定义**：度量空间可分，如果它有可数的稠密子集

**例子**：
- $L^1(\mathbb{R}^n)$ 可分：二进闭方体的指示函数的有理线性组合
- $L^\infty(\mathbb{R}^n)$ 不可分

---

### 10. 阶梯函数逼近

**定义**：阶梯函数形如 $f = \sum_{\ell=1}^N a_\ell \mathbf{1}_{R_\ell}$，其中 $R_\ell$ 是长方体

**定理**：对可测函数 $f$，存在阶梯函数序列 $\{\psi_k\}$ 和零测集 $N$，使得 $\psi_k \to f$ 在 $\mathbb{R}^n \setminus N$ 上逐点成立

**证明思路**：
1. 利用简单函数逼近
2. 用 Littlewood 第一原理将简单函数改造为阶梯函数
3. 用 Borel-Cantelli 引理控制例外集

---

### 第四部分小结

**函数空间对比表**：

| 空间 | 范数 | 性质 | 稠密子空间 | 可分性 |
|------|------|------|-----------|--------|
| $L^1$ | $\int |f|$ | Banach | $C_c^\infty$ | 可分 |
| $L^2$ | $(\int |f|^2)^{1/2}$ | Hilbert | $C_c^\infty$ | 可分 |
| $L^\infty$ | esssup|f|| | Banach | $C_0$ | 不可分 |
| $C_c$ | sup范数 | Banach | - | 不可分 |
| $C_c^\infty$ | - | 不完备 | - | 可分 |

**关键定理**：
1. Riesz-Fischer 定理：完备性
2. 稠密性定理：$C_c^\infty$ 在 $L^p$ 中稠密
3. 卷积的正则性

**核心技巧**：
- 利用稠密性进行逼近
- 利用卷积改善函数正则性
- 利用好核进行平均

---

**下一步：第五部分 Lp空间理论** →


## 第五部分：Lp空间理论

**前置知识**：函数空间、积分理论
**核心思想**：建立 $L^p$ 空间的完整理论，包括不等式、对偶空间和弱收敛

### 1. Lp空间的定义

**定义**：
- $\mathcal{L}^p = \{f \in \mathcal{L}(X, \mu; \mathbb{C}): \|f\|_p < \infty\}$
- $L^p = \mathcal{L}^p/\mathcal{N}$（几乎处处相等的函数视为同一元素）

**范数**：
- $0 < p < \infty$：$\|f\|_p = \left(\int_X |f|^p d\mu\right)^{1/p}$
- $p = \infty$：$\|f\|_\infty = \text{esssup}_X |f|$

**Hölder 共轭指标**：$\frac{1}{p} + \frac{1}{q} = 1$，记 $q = p'$

---

### 2. Young不等式

**定理**：对 $a, b \geq 0$ 和 $p \in (1, \infty)$：
$$ab \leq \frac{1}{p}a^p + \frac{1}{q}b^q$$
其中 $q = \frac{p}{p-1}$

**证明思路**：利用 $x \mapsto \log x$ 的凹性

**应用**：证明 Hölder 不等式

---

### 3. Hölder不等式

**定理**：设 $f \in L^p$，$g \in L^q$，$\frac{1}{p} + \frac{1}{q} = 1$，则：
$$\|fg\|_{L^1} \leq \|f\|_{L^p} \|g\|_{L^q}$$

**证明思路**：
1. 归一化到 $\|f\|_p = \|g\|_q = 1$
2. 利用 Young 不等式：$|f(x)g(x)| \leq \frac{1}{p}|f(x)|^p + \frac{1}{q}|g(x)|^q$
3. 积分得到 $\|fg\|_{L^1} \leq \frac{1}{p} + \frac{1}{q} = 1$

**推广**：对 $\frac{1}{p_1} + \cdots + \frac{1}{p_n} = 1$：
$$\left\|\prod_{i=1}^n f_i\right\|_{L^1} \leq \prod_{i=1}^n \|f_i\|_{L^{p_i}}$$

**反向 Hölder 不等式**：对 $p \in (0, 1)$，$q = \frac{p}{p-1} < 0$：
$$\int_X |fg| d\mu \geq \|f\|_p \|g\|_q$$

---

### 4. Minkowski不等式

**定理**：对 $p \in [1, \infty]$，$f, g \in L^p$：
$$\|f + g\|_{L^p} \leq \|f\|_{L^p} + \|g\|_{L^p}$$

**证明思路**（对 $p \in (1, \infty)$）：
1. 写成 $|f+g|^p \leq |f+g|^{p-1}(|f| + |g|)$
2. 对两项分别应用 Hölder 不等式
3. 利用 $\||f+g|^{p-1}\|_q = \|f+g\|_p^{p-1}$

**反例**：对 $p \in (0, 1)$，Minkowski 不等式一般不成立（有反向不等式）

**意义**：证明 $L^p$ 是赋范线性空间

---

### 5. Riesz-Fischer定理（完备性）

**定理**：对 $p \in [1, \infty]$，$(L^p, \|\cdot\|_p)$ 是 Banach 空间

**证明思路**：
1. 选取快速收敛子列：$\|f_n - f_m\|_p < 2^{-j}$ 对 $n, m \geq n_j$
2. 通过望远镜级数构造候选函数：$f = f_{n_1} + \sum_{k=1}^\infty (f_{n_{k+1}} - f_{n_k})$
3. 利用级数形式的 MCT 和 DCT 证明收敛
4. 利用 Cauchy 列性质完成证明

**稠密性**：$C_c^\infty$ 在 $L^p$ 中稠密（$1 \leq p < \infty$），但在 $L^\infty$ 中不然

---

### 6. Lp空间的比较

**有限测度空间**：若 $\mu(X) < \infty$，$0 < p < r \leq \infty$，则：
$$L^r \subset L^p, \quad \|f\|_{L^p} \leq \|f\|_{L^r} \mu(X)^{\frac{1}{p} - \frac{1}{r}}$$

**数列情形**：若 $0 < p < r \leq \infty$，则 $\ell^p \subset \ell^r$，且：
$$\|\{a_k\}\|_{\ell^r} \leq \|\{a_k\}\|_{\ell^p}^{p/r} \|\{a_k\}\|_{\ell^\infty}^{1-p/r}$$

**典型例子**：
- $f(x) = \frac{1}{|x|^\alpha}\mathbf{1}_{B_1(0)}(x) \in L^p(\mathbb{R}^d) \Leftrightarrow \alpha p < d$
- $f(x) = \frac{1}{|x|^\alpha}\mathbf{1}_{\mathbb{R}^d \setminus B_1(0)}(x) \in L^p(\mathbb{R}^d) \Leftrightarrow \alpha p > d$

---

### 7. Lp空间的交和和空间

**定义**：
- $L^p \cap L^r$：配上范数 $\|f\|_{L^p \cap L^r} = \|f\|_{L^p} + \|f\|_{L^r}$
- $(L^p + L^r)(\mu) = \{f = g + h: g \in L^p, h \in L^r\}/\mathcal{N}$，配上范数 $\|f\|_{L^p + L^r} = \inf\{\|g\|_p + \|h\|_r: f = g + h\}$

**插值不等式**：若 $f \in L^p \cap L^r$，$0 < p < r$，则对所有 $q \in [p, r]$：
$$\|f\|_q \leq \|f\|_p^\lambda \|f\|_r^{1-\lambda}$$
其中 $\frac{1}{q} = \frac{\lambda}{p} + \frac{1-\lambda}{r}$

**定理**：
- $L^p \cap L^r$ 是 Banach 空间，且连续嵌入 $L^q$
- $L^p + L^r$ 是 Banach 空间，且 $L^q$ 连续嵌入 $L^p + L^r$

---

### 8. 对偶空间

**定义**：Banach 空间 $X$ 的对偶空间 $X^*$ 是 $X$ 上有界线性泛函全体，配以算子范数：
$$\|\ell\|_{X^*} = \sup_{f \neq 0} \frac{|\ell(f)|}{\|f\|}$$

**Hilbert 空间的 Riesz 表示定理**：对任意 $\ell \in \mathcal{H}^*$，存在唯一的 $h \in \mathcal{H}$ 使得：
$$\ell(z) = \langle z, h \rangle, \quad \|\ell\|_{\mathcal{H}^*} = \|h\|_{\mathcal{H}}$$

因此 $(L^2(\mu))^* \simeq L^2(\mu)$

---

### 9. Lp空间的Riesz表示定理

**定理3.16**（范数的等价刻画）：对 $1 \leq q < \infty$：
$$\|g\|_q = \|\phi_g\|_{\mathcal{L}} = \sup\{|\int fg|: \|f\|_p = 1\}$$
若 $\mu$ 是 σ-有限的，则对 $q = \infty$ 也成立

**定理3.18**（Riesz 表示定理）：对 $1 < p < \infty$，任给 $\phi \in (L^p)^*$，存在唯一的 $g \in L^q$ 使得：
$$\phi(f) = \int fg d\mu, \quad \forall f \in L^p$$

若 $\mu$ 是 σ-有限的，则对 $p = 1$（即 $q = \infty$）也成立

**证明思路**：
1. 构造符号测度 $\nu(E) = \phi(\mathbf{1}_E)$
2. 应用 Radon-Nikodym 定理得到 $g$
3. 使用引理 3.19 证明 $g \in L^q$
4. 对 σ-有限情形，通过递增集列逼近

**反例**：
- $q = \infty, p = 1$：若 $\mu$ 不是半有限，$g \mapsto \phi_g$ 不一定是单射
- $q = \infty, p = 1$：若 $\mu$ 不是 σ-有限，$g \mapsto \phi_g$ 不一定是满射
- $q = 1, p = \infty$：$L^1 \to (L^\infty)^*$ 是单射但几乎从来不是满的（例如 $\phi(f) = f(0)$ 不能表示为积分）

---

### 10. Lp空间的自反性

**定义**：Banach 空间 $X$ 是自反的，如果自然映射 $x \mapsto \hat{x}$（其中 $\hat{x}(\phi) = \phi(x)$）是 $X$ 到 $X^{**}$ 的等距线性同构

**定理**（推论3.20）：对任意测度空间，如果 $1 < p < \infty$，则 $L^p(\mu)$ 是自反的

**推论**：$L^1$ 和 $L^\infty$ 不自反

---

### 11. 弱收敛和弱星收敛

**弱收敛**：$\{f_n\} \subset L^p$ 弱收敛到 $f$（记 $f_n \rightharpoonup f$），如果：
$$\lim_{n\to\infty} \int f_n g d\mu = \int fg d\mu, \quad \forall g \in L^q$$

**弱星收敛**：$\{g_n\} \subset L^q$ 弱*收敛到 $g$，如果：
$$\lim_{n\to\infty} \int f g_n d\mu = \int fg d\mu, \quad \forall f \in L^p$$

**核心区分**：
- **弱收敛**：原空间 $X$ 中序列 $x_n$，对任意 $f \in X^*$，$\lim f(x_n) = f(x)$
- **弱*收敛**：对偶空间 $X^*$ 中序列 $f_n$，对任意 $x \in X$，$\lim f_n(x) = f(x)$

**性质**：
- 弱*收敛序列必有界（一致有界原理）
- 若 $X$ 自反，则弱*收敛等价于弱收敛
- 强收敛（范数收敛）蕴含弱收敛

---

### 12. Riesz-Thorin插值定理

**定理**：假设 $T$ 既是 $L^{p_0} \to L^{q_0}$ 又是 $L^{p_1} \to L^{q_1}$ 的有界线性算子，记：
$$M_0 = \|T\|_{L^{p_0} \to L^{q_0}}, \quad M_1 = \|T\|_{L^{p_1} \to L^{q_1}}$$

则对 $0 \leq t \leq 1$，$T$ 是 $L^{p_t} \to L^{q_t}$ 的有界线性算子，且：
$$\|T\|_{L^{p_t} \to L^{q_t}} \leq M_0^{1-t}M_1^t$$
其中 $\frac{1}{p_t} = \frac{1-t}{p_0} + \frac{t}{p_1}$，$\frac{1}{q_t} = \frac{1-t}{q_0} + \frac{t}{q_1}$

**证明思路**：利用三线引理（复分析中的极大模原理）

**应用**：
- 证明 Young 不等式（卷积）：$\|f * g\|_r \leq \|f\|_p \|g\|_q$，其中 $\frac{1}{p} + \frac{1}{q} = 1 + \frac{1}{r}$
- 证明积分算子的有界性

---

### 13. Young不等式（卷积形式）

**定理**：对 $f \in L^p$，$g \in L^q$，$\frac{1}{p} + \frac{1}{q} = 1 + \frac{1}{r}$：
$$\|f * g\|_r \leq \|f\|_p \|g\|_q$$

**证明思路**：利用 Riesz-Thorin 插值定理

---

### 第五部分小结

**Lp空间理论体系**：
```
不等式体系：Young → Hölder → Minkowski
完备性：Riesz-Fischer
对偶理论：Riesz表示定理 → 自反性
收敛理论：弱收敛、弱*收敛
插值理论：Riesz-Thorin
```

**关键定理**：
1. Hölder 不等式：积分估计的基础
2. Minkowski 不等式：三角不等式
3. Riesz-Fischer 定理：完备性
4. Riesz 表示定理：对偶结构
5. Riesz-Thorin 插值定理：算子插值

**核心技巧**：
- 利用 Hölder 共轭进行对偶性论证
- 利用插值定理推广算子有界性
- 利用弱收敛处理有界性问题

---

**下一步：第六部分 微分理论** →


## 第六部分：微分理论

**前置知识**：积分理论、测度论
**核心思想**：建立微分与积分的联系，推广微积分基本定理到Lebesgue积分

### 1. 符号测度

**定义**：集函数 $\nu: \mathscr{F} \to [-\infty, \infty]$，满足：
1. $\nu(\emptyset) = 0$
2. 可数可加性

**性质**：
- 值域不能同时有 $\infty$ 和 $-\infty$
- 可数可加性中级数收敛则绝对收敛，发散则取 $\infty$ 且负项和有限

---

### 2. 绝对连续与相互奇异

**绝对连续**：$\nu \ll \mu$，如果 $\mu(E) = 0$ 则 $\nu(E) = 0$

**相互奇异**：$\mu \perp \nu$，如果 $\exists A \in \mathscr{F}$ 使得：
$$\mu(E) = \mu(E \cap A), \quad \nu(E) = \nu(E \cap A^c), \quad \forall E \in \mathscr{F}$$

**性质**：
- $\nu \ll \mu \Leftrightarrow \|\nu\| \ll \mu \Leftrightarrow \nu^+ \ll \mu$ 且 $\nu^- \ll \mu$
- $\nu \perp \mu \Leftrightarrow \|\mu\|(A^c) = 0$ 且 $\|\nu\|(A) = 0$
- 若 $\nu \ll \mu$ 且 $\nu \perp \mu$，则 $\nu \equiv 0$

---

### 3. Hahn分解定理

**定理**：存在不交的 $X^+, X^- \in \mathscr{F}$ 使得 $X = X^+ \sqcup X^-$，且对所有 $E \in \mathscr{F}$：
$$\nu(X^+ \cap E) \geq 0 \geq \nu(X^- \cap E)$$

**唯一性**：在全变差测度下几乎处处唯一

**证明思路**：
- 构造全非负集和全非正集
- 利用反证法和单调性证明存在性

---

### 4. 符号测度的Jordan分解

**定义**：
- $\nu^+(E) = \nu(E \cap X^+)$（正变差）
- $\nu^-(E) = -\nu(E \cap X^-)$（负变差）
- $|\nu|(E) = \nu^+(E) + \nu^-(E)$（全变差）

**定理**：$\nu = \nu^+ - \nu^-$，且 $|\nu| = \nu^+ + \nu^-$ 是有限测度

---

### 5. Radon-Nikodym定理

**定理**：设 $\mu$ 是 σ-有限的测度空间，$\nu$ 是其上的符号测度且 $\nu \ll \mu$，则存在在扩充意义下 $\mu$-可积的函数 $f$ 使得：
$$\nu(E) = \int_E f d\mu, \quad \forall E \in \mathscr{F}$$
且 $f$ 在几乎处处相等意义下唯一

**记号**：$f = \frac{d\nu}{d\mu}$ 称为 Radon-Nikodym 导数

**证明思路**：
1. $\mu, \nu$ 均为有限测度时，通过上确界方法构造
2. 利用 Jordan 分解推广到符号测度
3. 通过空间分解推广到 σ-有限情形

**反例**（说明 σ-有限必要）：可数余可数 σ-代数上计数测度 $\#$

---

### 6. Radon-Nikodym导数的性质

**链式法则**：若 $\nu \ll \mu \ll \lambda$，则：
$$\frac{d\nu}{d\lambda} = \frac{d\nu}{d\mu} \cdot \frac{d\mu}{d\lambda} \quad \text{a.e.}$$

**线性性**：$\frac{d(\alpha\nu_1 + \beta\nu_2)}{d\mu} = \alpha\frac{d\nu_1}{d\mu} + \beta\frac{d\nu_2}{d\mu}$ a.e.

---

### 7. Lebesgue分解定理

**定理**：设 $\mu$ 是 σ-有限测度，$\nu$ 是 σ-有限的符号测度，则存在唯一的分解：
$$\nu = \nu_a + \nu_s$$
其中 $\nu_a \ll \mu$（绝对连续部分），$\nu_s \perp \mu$（奇异部分）

**证明思路**：利用 Radon-Nikodym 定理和 Hahn 分解

---

### 8. Dini导数

**定义**：
$$D^+(F)(x) = \limsup_{h \searrow 0} \frac{F(x+h) - F(x)}{h}$$
$$D_+(F)(x) = \liminf_{h \searrow 0} \frac{F(x+h) - F(x)}{h}$$
（类似定义 $D^-, D_-$）

**定理**：对单调递增 $F$，Dini 导数都是可测函数

---

### 9. Riesz日出引理

**定理**：考虑 $E = \{x: \exists h_x > 0, G(x) < G(x+h)\}$，则：
1. $E$ 是开集且可写成不交并 $\cup (a_k, b_k)$
2. $G(a_k) = G(b_k)$

**证明思路**：利用连续函数的介值定理和紧致性论证

---

### 10. Vitali覆盖定理

**定理**：设 $E \subset \mathbb{R}^d$ 满足 $m^*(E) < \infty$，$\mathscr{B}$ 是 $E$ 的 Vitali 覆盖，则对任意 $\delta > 0$，存在有限个两两不交的 $B_j \in \mathscr{B}$ 使得：
$$m^*\left(E \setminus \bigcup_{j} B_j\right) < \delta$$

**证明思路**：
1. 取开集 $G$ 覆盖 $E$
2. 利用无限 Vitali 覆盖引理选择子族
3. 利用测度的可数可加性和单调性

---

### 11. Hardy-Littlewood极大函数

**定义**：$\mathcal{M}(f)(x) = \sup_{B: x \in B} \int_B |f(y)| dy$

**定理**：
1. $\mathcal{M}f$ 是 Borel 可测的
2. $\mathcal{M}f$ 几乎处处有限
3. **弱型不等式**：$m(\{\mathcal{M}f > \alpha\}) \leq \frac{3^d \|f\|_{L^1}}{\alpha}$

**证明思路**：利用 Vitali 覆盖引理和有限覆盖引理

---

### 12. Lebesgue微分定理

**一维情形**：若 $f \in L^1([a,b])$，则对几乎处处的 $x$：
$$\lim_{h \to 0} \frac{1}{h}\int_x^{x+h} f(t) dt = f(x)$$

**高维情形**（$\mathbb{R}^d$）：对 $f \in L^1(\mathbb{R}^d)$，对几乎处处的 $x$：
$$\lim_{|B| \to 0, x \in B} ⨍_B f(y) dy = f(x)$$

**证明思路**：
1. 对连续函数显然成立
2. 用连续函数逼近
3. 利用极大函数的弱型不等式

---

### 13. 单调函数微分定理

**定理**：设 $F$ 是 $[a,b]$ 上的单调递增函数，则：
1. $F$ 几乎处处可微
2. $F' \in L^+([a,b])$（非负可积）
3. $\int_a^b F' dm \leq F(b) - F(a)$（不等式可能严格）

**证明思路**：
1. 将 $F$ 分解为连续部分和跳跃部分
2. 对连续部分利用 Riesz 日出引理和覆盖方法
3. 对跳跃部分直接计算导数为 0

---

### 14. 有界变差函数

**定义**：$V_I(f) = \sup_\sigma \sum |f(a_k) - f(a_{k-1})|$，若 $V_I(f) < \infty$ 则称 $f$ 为有界变差函数

**性质**：
- $BV([a,b])$ 是线性空间、代数、Banach 空间（配备 $\|f\|_{BV} = \sup|f| + V_I(f)$）
- $f \in BV \Leftrightarrow f$ 是两个单调函数之差

---

### 15. Jordan分解

**定理**：$f \in BV([a,b])$ 当且仅当 $f$ 是一个单调递增函数和一个单调递减函数的和

**证明思路**：定义：
$$g(x) = \frac{V_{[a,x]}(f) + f(x)}{2}, \quad h(x) = \frac{V_{[a,x]}(f) - f(x)}{2}$$

---

### 16. 绝对连续函数

**定义**：$F \in AC([a,b])$ 如果 $\forall \varepsilon > 0$，$\exists \delta > 0$，使得只要两两不交区间 $\{(a_i, b_i)\}$ 满足 $\sum |(a_i, b_i)| < \delta$，就有：
$$\sum |F(b_i) - F(a_i)| < \varepsilon$$

**等价刻画**：
(a) $f \in AC(I)$
(b) $f'$ 几乎处处存在且可积，且 $f(x) - f(a) = \int_a^x f'(t) dt$
(c) 存在 $g \in L^1([a,b])$ 使得 $f(x) = f(a) + \int_a^x g(t) dt$

**包含关系**：$Lip(I) \subset AC(I) \subset BV(I) \cap C_u(I)$

**性质**：绝对连续函数是一致连续的、有界变差的、几乎处处可导

---

### 17. 微积分基本定理

**定理**：假设 $F \in AC([a,b])$，则：
1. $F$ 几乎处处可微，$F'$ 可积
2. **Newton-Leibniz 公式**：
   $$F(b) - F(a) = \int_a^b F'(t) dt$$

**逆定理**：若 $F'$ 几乎处处存在且可积，且 $F(x) - F(a) = \int_a^x F'(t) dt$，则 $F \in AC([a,b])$

**证明思路**：
1. $AC \subset BV$ 故 $F$ 几乎处处可微
2. 令 $G(x) = \int_a^x F'(t) dt$，则 $G \in AC$ 且 $G' = F'$ 几乎处处
3. 证明 $F - G$ 为常值函数（利用引理：若 $AC$ 函数几乎处处导数为 0 则为常数）

**关键引理**：若 $F \in AC([a,b])$ 且 $F' = 0$ a.e.，则 $F$ 为常值函数

---

### 18. Lebesgue分解定理（函数）

**定理**：若 $f \in BV \cap C([a,b])$，则 $f = f_a + f_c$，其中：
- $f_a$ 绝对连续
- $f_c$ 奇异连续（导数几乎处处为 0 但非常值）

若 $f$ 单调递增，则 $f = f_a + f_c + f_j$，其中 $f_j$ 是跳跃函数

---

### 第六部分小结

**微分理论体系**：
```
符号测度 → Hahn分解 → Radon-Nikodym定理
→ Dini导数 → Riesz日出引理 → Vitali覆盖
→ 极大函数 → Lebesgue微分定理
→ 单调函数 → 有界变差 → 绝对连续
→ 微积分基本定理
```

**关键定理**（按重要性）：
1. Radon-Nikodym 定理：测度与密度的联系
2. 微积分基本定理：微分与积分的互逆
3. Lebesgue 微分定理：几乎处部的微分性质
4. Vitali 覆盖定理：覆盖引理的基础
5. Hahn 分解定理：符号测度的分解

**核心技巧**：
- 利用覆盖引理控制例外集
- 利用极大函数进行弱型估计
- 利用 Jordan 分解化简问题

---

**下一步：第七部分 Hausdorff测度与维数** →


## 第七部分：Hausdorff测度与维数

**前置知识**：测度论、微分理论
**核心思想**：推广测度概念到任意维数，研究分形集合的几何性质

### 1. Hausdorff外测度的定义

**定义**：对 $s \geq 0$ 和 $\delta > 0$：
$$\mathcal{H}_\delta^s(E) = \inf\left\{\sum_{j=1}^\infty \alpha(s)\left(\frac{\text{diam}(C_j)}{2}\right)^s: E \subset \bigcup_{j=1}^\infty C_j, \text{diam}(C_j) \leq \delta\right\}$$

其中 $\alpha(s) = \frac{\pi^{s/2}}{\Gamma(s/2 + 1)}$（归一化常数）

**Hausdorff测度**：$\mathcal{H}^s(E) = \lim_{\delta \to 0} \mathcal{H}_\delta^s(E)$

---

### 2. Hausdorff测度的性质

**定理**：
1. $\mathcal{H}^s$ 是 $\mathbb{R}^n$ 上的度量外测度，所有 Borel 集都可测
2. **特殊情形**：
   - $\mathcal{H}^0$ 是计数测度
   - $\mathcal{H}^1$ 在 $\mathbb{R}$ 上等于 Lebesgue 测度
   - $s > n$ 时 $\mathbb{R}^n$ 上的 $\mathcal{H}^s \equiv 0$
3. **缩放性**：$\mathcal{H}^s(\lambda E) = \lambda^s \mathcal{H}^s(E)$
4. **不变性**：平移和正交变换不变

**证明思路**：利用 Carathéodory 准则和度量外测度的性质

---

### 3. Hausdorff维数

**定义**：$\dim_H E = \inf\{s \geq 0: \mathcal{H}^s(E) = 0\}$

**临界性质**：
- 若 $\mathcal{H}^s(E) < \infty$，则 $\dim_H E \leq s$
- 若 $\mathcal{H}^s(E) > 0$，则 $\dim_H E \geq s$
- 对 $0 \leq s < s'$，若 $0 < \mathcal{H}^s(E) \leq \infty$，则 $\mathcal{H}^{s'}(E) = 0$

**典型例子**：
- $\mathbb{R}^n$ 中非空开集的 Hausdorff 维数为 $n$
- $\mathbb{Q}$ 的 Hausdorff 维数为 0，$\mathbb{Q}^c$ 的维数为 1
- Cantor 集的 Hausdorff 维数为 $\log_2 2 / \log_2 3 = \frac{\ln 2}{\ln 3}$

---

### 4. ℝⁿ上n维Hausdorff测度与Lebesgue测度的关系

**定理**：在 $(\mathbb{R}^n, \mathscr{B})$ 上，$\mathcal{H}^n = m_n$（Lebesgue 测度）

**证明思路**：
1. 利用唯一性刻画：平移不变的 Radon 测度必为 $c \cdot m_n$
2. 利用 Vitali 覆盖定理
3. 利用等直径不等式

---

### 5. Steiner对称化和等直径不等式

**Steiner对称化**：
$$S_\omega(E) = \{z + \tfrac{1}{2}[-\ell_z, \ell_z]: z \in \Pi_\omega E, \ell_z = m_{L(z,\omega)}(E \cap L(z,\omega))\}$$

**定理**：
1. $m(S_\omega(E)) = m(E)$
2. $\text{diam}(S_\omega(E)) \leq \text{diam}(E)$

**等直径不等式**：$m(E) \leq \alpha(n)\left(\frac{\text{diam}(E)}{2}\right)^n$，即直径相等时球体积最大

**证明思路**：
1. 用 Tonelli-Fubini 定理证明测度相等
2. 利用坐标分解证明直径不增
3. 通过 $n$ 次对称化得到中心对称集，包含在球内

---

### 6. Hölder和Lipschitz映射下的Hausdorff测度

**γ-Hölder连续**：$d_Y(f(x), f(x')) \leq C[d_X(x, x')]^\gamma$

**定理**：
1. $\mathcal{H}^{s/\gamma}(f(A)) \leq c_s([f]_{C^{0,\gamma}})^{s/\gamma}\mathcal{H}^s(A)$
2. $\dim_H f(A) \leq \frac{1}{\gamma} \dim_H A$

**推论**：若 $f$ 是 Lipschitz 映射（$\gamma = 1$），则：
$$\mathcal{H}^s(f(A)) \leq [f]_{\text{Lip}}^s \mathcal{H}^s(A), \quad \dim_H f(A) \leq \dim_H A$$

**应用**：计算 Cantor 集的 Hausdorff 维数

---

### 7. Lipschitz映射的像和图像的Hausdorff测度

**定理**：
1. **像的测度**：$\mathcal{H}^s(f(A)) \leq [f]_{\text{Lip}}^s \mathcal{H}^s(A)$
2. **图形的测度**：若 $\mathcal{H}^n(A) > 0$ 且 $f$ Lipschitz，则 $\dim_H \Gamma(f; A) = n$

**证明思路**：利用投影和二进方体分解

---

### 8. ℝⁿ中的C¹微分子流形的Hausdorff维数和测度

**定理**：设 $M = f(V) \subset \mathbb{R}^n$ 是 $k$ 维 $C^1$ 子流形，则：
1. $f(\mathscr{B}_V) = \mathscr{B}_M$（Borel 集的像仍是 Borel 集）
2. **面积公式**：$\mathcal{H}^k(f(A)) = \int_A J(Df)(x) d\mathcal{H}^k(x)$
   其中 $J(Df)(x) = \sqrt{\det(Df(x)^T Df(x))}$ 是 $k$ 维体积元
3. **积分换元**：$\int_{f(V)} g d\mathcal{H}^k = \int_V (g \circ f) J(Df) d\mathcal{H}^k$

**证明思路**：
1. 利用局部线性化引理
2. 利用面积公式的证明技巧
3. 利用极式分解和奇异值分解

---

### 9. Area公式

**定理**：对 $f \in \text{Lip}(\mathbb{R}^d, \mathbb{R}^n)$，$1 \leq d \leq n$：
$$\int_{\mathbb{R}^n} \mathcal{H}^0(A \cap f^{-1}(\{p\})) d\mathcal{H}^d(p) = \int_A J(Df(x)) d\mathcal{H}^d(x)$$

其中 $J(Df(x)) = \sqrt{\det(Df(x)^T Df(x))}$ 是 Jacobian 行列式的推广

**Rademacher定理**：Lipschitz 函数几乎处处可微

**证明思路**：
1. 证明方向导数几乎处处存在
2. 证明方向导数等于 $Df(x) \cdot v$
3. 利用可数稠密集和 Lipschitz 条件

---

### 10. Co-Area公式

**定理**：对 $f \in \text{Lip}(\mathbb{R}^n, \mathbb{R}^d)$，$n \geq d$：
$$\int_{\mathbb{R}^d} \mathcal{H}^{n-d}(A \cap f^{-1}\{y\}) dy = \int_A J(Df(x)^*) dx$$

其中 $J(Df(x)^*)$ 是 $d \times d$ 子矩阵的 Jacobian

**证明思路**：
1. 线性情形用 Fubini 定理
2. 一般情形用局部线性近似
3. 分解为可微点集和非可微点集讨论

**应用**：几何测度论、偏微分方程

---

### 第七部分小结

**Hausdorff测度理论体系**：
```
外测度定义 → Hausdorff测度 → Hausdorff维数
→ Lipschitz映射下的性质 → C¹流形
→ Area公式、Co-Area公式 → 几何应用
```

**关键定理**：
1. Hausdorff 测度的度量外测度性质
2. Hausdorff 维数的临界性
3. $\mathbb{R}^n$ 上 $\mathcal{H}^n = m_n$
4. Area 公式和 Co-Area 公式
5. 等直径不等式

**核心技巧**：
- 利用覆盖定义测度
- 利用缩放性估计维数
- 利用 Jacobian 计算流形测度

**应用领域**：
- 分形几何
- 几何测度论
- 偏微分方程
- 调和分析

---

**下一步：第八部分 拓扑空间测度** →


## 第八部分：拓扑空间测度

**前置知识**：拓扑空间、测度论、函数空间
**核心思想**：在拓扑空间上建立测度理论，通过连续函数研究测度（Riesz表示定理）

### 1. Radon测度的定义

**定义**：拓扑空间 $X$ 上的 Borel 测度 $\mu$ 是 Radon 测度，如果：
1. $\mu$ 在所有紧集上有限
2. 所有 Borel 集**外正则**：$\mu(E) = \inf\{\mu(U): E \subset U, U \text{开}\}$
3. 所有开集**内正则**：$\mu(U) = \sup\{\mu(K): K \subset U, K \text{紧}\}$

**正则性**：
- **外正则**：用开集从外部逼近
- **内正则**：用紧集从内部逼近

**定理**：对 σ-有限的 Radon 测度，所有 Borel 集都内正则

**例子**：紧度量空间上所有有限 Borel 测度都是正则 Radon 测度

---

### 2. Lusin定理

**定理**：设 $X$ 是局部紧 Hausdorff 空间，$\mu$ 是 Radon 测度，$f$ 是 Borel 可测且支集测度有限，则 $\forall \varepsilon > 0$，存在紧集 $K$ 和 $\phi \in C_c(X)$ 使得：
1. $K \subset \text{supp}(f)$，$\phi = f$ 在 $K$ 上成立
2. $\mu(\{f \neq \phi\}) < \varepsilon$

**直观意义**：可测函数在去掉一个测度很小的集合后，可以延拓为连续函数

**应用**：表明在测度论中，连续函数在 $L^p$ 空间中稠密

---

### 3. Cc(X)上的正线性泛函

**定义**：$I: C_c(X) \to \mathbb{R}$ 是**正线性泛函**，如果 $f \geq 0 \Rightarrow I(f) \geq 0$

**Riesz表示定理**：对 $C_c(X)$ 上的正线性泛函 $\phi$，存在唯一 Radon 测度 $\mu$ 使得：
$$\phi(f) = \int_X f d\mu, \quad \forall f \in C_c(X)$$

且满足：
- $\mu(G) = \sup\{\phi(f): f \in C_c(X), f \prec G\}$ 对开集 $G$
- $\mu(K) = \inf\{\phi(f): f \in C_c(X), f \geq \mathbf{1}_K\}$ 对紧集 $K$

**证明思路**：
1. 对开集定义 $\mu(G) = \sup\{\phi(f): f \in C_c(X), f \prec G\}$
2. 推广到外测度
3. 用 Carathéodory 准则构造 Borel 测度
4. 验证正则性和表示公式

---

### 4. C₀(X)上的线性泛函

**定义**：$C_0(X) = \{f \in C(X): \forall \varepsilon > 0, \{x: |f(x)| \geq \varepsilon\} \text{紧}\}$

**定理**：$\phi \in (C_c(X))^*$ 是正线性泛函当且仅当 $\exists$ 有限 Radon 测度 $\mu$ 使得 $\phi = I_\mu$，且：
$$\|\phi\|_{\mathcal{L}} = \mu(X)$$

---

### 5. 实Radon有号测度和Radon复测度

**定义**：$\nu$ 是 Radon 有号测度，如果 $\|\nu\|$ 是 Radon 测度（全变差有限）

**性质**：
- $\mu \in \mathcal{M}(X) \Leftrightarrow \mu(X) < \infty$（有限 Radon 测度空间）
- 若 $\mu_1, \mu_2 \in \mathcal{M}(X)$，则 $\mu_1 \pm \mu_2 \in \mathcal{M}(X)$
- $\nu$ 是 Radon 有号测度 $\Leftrightarrow$ $\nu$ 是两个有限 Radon 测度之差
- $(\mathcal{M}(X), \|\cdot\|_{TV})$ 是 Banach 空间

**全变差范数**：$\|\nu\|_{TV} = \|\nu\|(X)$

---

### 6. Riesz-Kakutani-Markov表示定理

**定理**：$\Phi: \mathcal{M}(X) \to (C_0(X))^*$，$\nu \mapsto I_\nu$ 是等距线性同构，其中：
$$I_\nu(f) = \int_X f d\nu$$

**证明思路**：
1. 对 $\phi \in (C_0(X))^*$ 进行 Jordan 分解 $\phi = \phi^+ - \phi^-$
2. 对正线性泛函应用 Riesz 表示定理
3. 证明 $\|I_\nu\|_{\mathcal{L}} = \|\nu\|_{TV}$

**意义**：建立了连续函数空间的对偶与 Radon 测度之间的深刻联系

---

### 7. 函数列的弱收敛

**定义**：
- **强收敛**：$f_n \to f$ 一致收敛
- **弱收敛**：$\int f_n d\mu \to \int f d\mu$ 对所有 $\mu \in \mathcal{M}(X)$
- **弱*收敛**：$\int f d\mu_n \to \int f d\mu$ 对所有 $f \in C_0(X)$

**关系**：
- 强收敛 $\Rightarrow$ 弱收敛
- 在有限测度空间中，一致收敛蕴含弱*收敛

**应用**：概率论中的依分布收敛

---

### 第八部分小结

**拓扑空间测度理论体系**：
```
Radon测度定义 → 正则性 → Lusin定理
→ C_c(X)上的正线性泛函 → Riesz表示定理
→ C_0(X)上的线性泛函 → Riesz-Kakutani-Markov定理
→ 弱收敛理论
```

**关键定理**（按重要性）：
1. Riesz-Kakutani-Markov 表示定理：对偶关系
2. Riesz 表示定理（$C_c(X)$）：正线性泛函的表示
3. Lusin 定理：可测函数的连续逼近
4. Radon 测度的正则性

**核心技巧**：
- 利用 Urysohn 引理构造检验函数
- 利用正则性进行内外逼近
- 利用弱收敛处理紧性问题

**应用领域**：
- 调和分析
- 概率论
- 偏微分方程
- 泛函分析

---

## 全文总结

### 实分析的核心思想

1. **测度的构造**：从简单的集合系通过 Carathéodory 条件构造完备的测度空间
2. **积分的建立**：通过简单函数逼近，建立 Lebesgue 积分理论
3. **极限的交换**：三大收敛定理（MCT、Fatou、DCT）提供极限交换的充分条件
4. **空间的完备化**：$L^p$ 空间的完备性为泛函分析奠定基础
5. **微分的推广**：Radon-Nikodym 定理和微积分基本定理推广微分理论
6. **几何的推广**：Hausdorff 测度推广测度概念到任意维数
7. **对偶的理论**：Riesz 表示定理建立函数空间与测度空间的对偶关系

### 逻辑联系图

```
集合系 → σ-代数 → 测度 → Lebesgue测度
    ↓
可测函数 → 简单函数逼近 → Lebesgue积分
    ↓
收敛定理 → Tonelli-Fubini → Lp空间
    ↓
对偶空间 → Riesz表示定理 → Radon-Nikodym
    ↓
微分定理 → 微积分基本定理 → Hausdorff测度
    ↓
几何测度论 → 拓扑空间测度
```

### 重要定理排序

**基石性定理**（最核心）：
1. Carathéodory 测度构造定理
2. 三大收敛定理（MCT、Fatou、DCT）
3. Tonelli-Fubini 定理
4. Radon-Nikodym 定理
5. Riesz 表示定理
6. 微积分基本定理

**技术性定理**（重要但依赖上述）：
1. Egorov 定理
2. Riesz 定理（依测度收敛提取子列）
3. Riesz-Fischer 定理（完备性）
4. Vitali 覆盖定理
5. Lusin 定理

**推广性定理**（理论的高潮）：
1. Riesz-Thorin 插值定理
2. Area 公式和 Co-Area 公式
3. 等直径不等式
4. Steinhaus 定理

### 学习建议

1. **第一遍**：理解测度和积分的定义，掌握三大收敛定理
2. **第二遍**：深入 $L^p$ 空间和对偶理论，理解 Riesz 表示定理
3. **第三遍**：学习微分理论和 Hausdorff 测度，体会几何应用
4. **复习阶段**：通过本提纲的系统回顾，建立完整的知识体系

### 典型问题

**测度论**：
- Carathéodory 条件的意义？
- 为什么要 σ-有限？
- Lebesgue 测度的唯一性如何证明？

**积分论**：
- MCT、Fatou、DCT 的区别和联系？
- 什么时候极限和积分可以交换？
- Tonelli 和 Fubini 的区别？

**函数空间**：
- $L^1$ 和 $L^\infty$ 为什么不自反？
- 为什么 $C_c^\infty$ 在 $L^p$ 中稠密？
- 弱收敛和强收敛的关系？

**微分理论**：
- Radon-Nikodym 导数的直观意义？
- 绝对连续函数的刻画？
- 微积分基本定理的推广？

**几何测度论**：
- Hausdorff 维数的直观意义？
- Area 公式的几何解释？
- 等直径不等式的应用？

---

**提纲完成时间**：2026年1月8日
**覆盖文件数**：130+ Markdown 文件
**总字数**：约 20,000 字
**适用场景**：实分析课程复习、考研复习、学术研究参考

---

## 附录：重要概念索引

### A
- **绝对连续**（Absolute Continuity）：测度和函数的双重概念
- **Area 公式**：几何测度论的核心定理
- **几乎处处**（Almost Everywhere）：测度论中的"零测集例外"

### B
- **Banach 空间**：$L^p$ 空间的完备性
- **Borel 代数**：由开集生成的 σ-代数
- **不等式体系**：Young → Hölder → Minkowski

### C
- **Carathéodory 条件**：测度构造的核心
- **Co-Area 公式**：Area 公式的对偶形式
- **卷积**：函数空间的平滑工具

### D
- **Dini 导数**：单调函数的广义导数
- **DCT**：控制收敛定理
- **对偶空间**：$L^p$ 和 $L^q$ 的对偶关系

### E
- **Egorov 定理**：a.e. 收敛 → 近一致收敛
- **外测度**：测度构造的第一步

### F
- **Fatou 引理**：下极限的积分不等式
- **Fubini 定理**：积分交换次序
- **符号测度**：可取负值的测度

### G
- **规范表示**：简单函数的标准形式
- **共轭指标**：$\frac{1}{p} + \frac{1}{q} = 1$

### H
- **Hahn 分解**：符号测度的正负部分
- **Hausdorff 测度**：任意维数的测度
- **Hausdorff 维数**：分形集合的维数
- **Hölder 不等式**：积分估计的基础
- **Hardy-Littlewood 极大函数**：微分理论的工具

### J
- **Jordan 分解**：有界变差函数的分解
- **积空间**：乘积测度的载体

### L
- **Lusin 定理**：可测函数的连续逼近
- **Lebesgue 测度**：最重要的具体测度
- **Lebesgue 点**：微分定理的概念
- **Lipschitz 映射**：Hausdorff 测度下的性质
- **Littlewood 三原则**：可测性的逼近性质

### M
- **MCT**：单调收敛定理
- **Minkowski 不等式**：三角不等式
- **完备性**：Cauchy 列收敛

### N
- **内正则/外正则**：测度的逼近性质
- **Newton-Leibniz 公式**：微积分基本定理

### R
- **Radon 测度**：拓扑空间上的正则测度
- **Radon-Nikodym 定理**：测度的密度表示
- **Radon-Nikodym 导数**：$d\nu/d\mu$
- **Riesz 表示定理**：对偶关系的核心
- **Riesz 日出引理**：微分理论的工具
- **Riesz-Fischer 定理**：完备性定理
- **Riesz 定理**：依测度收敛提取子列
- **Riesz-Thorin 插值定理**：算子插值

### S
- **σ-代数**：可数集合运算封闭
- **σ-有限**：可数个有限测度集覆盖
- **Steinhaus 定理**：正测度集的差集性质
- **Steiner 对称化**：等直径不等式的工具
- **阶梯函数**：可测函数的逼近

### T
- **Tonelli 定理**：非负函数的积分交换
- **拓扑空间测度**：连续函数与测度的联系

### V
- **Vitali 覆盖定理**：微分理论的覆盖引理
- **Vitali 集**：不可测集的例子

### W
- **完备化**：将零测集的子集加入 σ-代数
- **弱收敛**：按对偶空间元素收敛
- **弱*收敛**：对偶空间序列的收敛


