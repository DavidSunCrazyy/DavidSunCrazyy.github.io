---
layout: post
title: "第二部分：Lebesgue积分理论"
permalink: /posts/02-Lebesgue积分理论/
---

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


