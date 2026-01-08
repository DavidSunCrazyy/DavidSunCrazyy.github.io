---
layout: post
title: "第七部分：Hausdorff测度与维数"
permalink: /posts/07-Hausdorff测度与维数/
---

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


