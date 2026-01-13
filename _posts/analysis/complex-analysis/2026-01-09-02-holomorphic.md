---
layout: post
title: "Complex Analysis 全纯函数与复积分"
permalink: /posts/complex-analysis-holomorphic/
tags: complex-analysis
use\_math: true
---

本文系统研究全纯函数与复积分理论。首先定义复积分并证明Goursat定理，建立Cauchy积分公式，这是全纯函数理论的基石。我们导出全纯函数的无限可微性，并证明Liouville定理和代数基本定理等重要结果。然后详细研究全纯函数的零点结构，包括孤立零点、可去奇点、极点和本性奇点的分类。最后介绍开映射定理和最大模原理，这些结果深刻揭示了全纯函数的几何性质。

## 复积分

设 $f:U\subset \mathbb{C} \to \mathbb{C}$ 是连续函数，$\gamma:[a,b]\to \mathbb{C}$ 是连续曲线。$f$ 沿 $\gamma$ 的线积分定义为 $\int\_\gamma f(z) dz = \int\_a^b f(\gamma(t)) \gamma'(t) dt$.

路径是连续曲线 $\gamma:[a,b]\to \mathbb{C}$。如果 $\gamma$ 连续可微，则称路径为光滑的。

设 $f:U\subset \mathbb{C} \to \mathbb{C}$ 是全纯函数且满足 $F' = f$。则对于任意光滑路径 $\gamma:[a,b]\to \mathbb{C}$，我们有 $\int\_\gamma f(z) dz = F(\gamma(b)) - F(\gamma(a))$。

曲线 $\gamma:[a,b]\to \mathbb{C}$ 的长度定义为 $l(\gamma) = \int\_a^b \|\gamma'(t)\| dt$.

$f:U\to C$, $\gamma:[a,b]\to \mathbb{C}$, $\|f(\gamma(t))\|\le M, \forall t\in [a,b]$, 则 $\|\int\_\gamma f(z) dz\| \le M \cdot l(\gamma)$.

设 $f:U\to \mathbb{C}$ 是全纯函数，$U$ 是开集，$R$ 是 $U$ 中的矩形。则 $\int\_{\partial R} f(z) dz = 0$。

（使用 Stokes 定理。） 假设 $f$ 是 $C^2$ 类的。

$\int\_\Gamma f dz = \int\_Q df \wedge dz = \int\_Q (\frac{\partial f}{\partial z} dz + \frac{\partial f}{\partial \bar{z}}d \bar{z})\wedge dz = \int\_Q \frac{\partial f}{\partial \bar{z}} d\bar{z} \wedge dz = 0$。

（Goursat 的证明不需要任何额外假设。）

设 $\varepsilon>0$。将四边形分解为四个大小相等的四边形 $Q\_1^1, \ldots, Q\_1^4$，相应地 $\Gamma = \Gamma\_1^1 + \ldots + \Gamma\_1^4$，其中 $\Gamma\_1^i$ 是 $Q\_1^i$ 的边界。定义 $\Gamma\_1: = \Gamma\_1^m$，其中 $\|\int\_{\Gamma\_1^m} f dz \| = \max\_l \|\int\_{\Gamma\_1^l}fdz\|$。重复此过程得到嵌套的四边形序列 $Q\_0  = Q\supset Q\_1 \supset Q\_2 \supset \ldots$，满足 $l(Q\_n) = 2^{-n } l(Q) = 2^{-n} l$（且直径 $(Q\_n)\le 2^{-n} l$）

则 $\bigcap\_{n=0}^\infty Q\_n = \{p\}$。（因为 $Q\_n$ 的顶点定义了 Cauchy 序列且 $\\operatorname{diam}(Q\_n)\to 0$）

因为 $f$ 全纯，对于给定的 $\varepsilon>0$，$\exists \delta>0$ 使得 $\forall z$ 满足 $\|z\|< \delta$：$f(p+z) = f(p) + f'(p)z + h(p+z)$，其中 $\|\frac{f(p+z)}{z}\|<\varepsilon$ 或 $\|h(p+z)\|\le \varepsilon \|z\|$。

因为 $\\operatorname{diam}(Q\_n)\to 0$，$\exists N$ 使得 $Q\_n \subset D\_\delta(r)$ 对所有 $n\ge N$ 成立。

因此我们得到对所有 $n\ge N$： $$\|\int\_{\Gamma\_n} f dz\| = \|\int\_{\Gamma\_n} f(p) + f'(p)z+ h(p+z)dz\| = \|\int\_{\Gamma\_n} h(p+z) dz\| \le \varepsilon4^{-n} l.$$ 通过反证法，$\|\int\_\Gamma f dz\|\le 4^n \|\int\_{\Game\_n} f dz\| \le \varepsilon$.

设 $U=D$ 是开圆盘，$f:U\to \mathbb{C}$ 是全纯函数。则 $f$ 有原函数 $F:U\to \mathbb{C}$，$F$ 是全纯函数且满足 $F' = f$。

定义 $F(z\_1) = \int\_{x\_0}^{x\_1} f(x+y\_0 i) d x+ \int\_{y\_0}^{y\_1} f(x\_1+y i) d y$.

首先我们证明 $F$ 是全纯的。这通过矩形的 Cauchy 定理完成。

直接计算得到 $F' = f$。

设 $f:U\to \mathbb{C}$ 是全纯函数，$U$ 是开集，$\omega\in U$，$D$ 是以 $\omega$ 为中心且包含在 $U$ 中的圆盘。则 $$f(\omega) = \frac{1}{2\pi i} \int\_{\partial D} \frac{f(z)}{z-\omega} dz$$

考虑固定的 $\omega \in D$，$T:U\setminus \{p\}\to \mathbb{C}$, $T(z)=\frac{f(z)-f(\omega)}{z-\omega}$，则 $T$ 在 $U\setminus \{\omega\}$ 上全纯，且在 $z=\omega$ 处连续延拓到 $T(\omega) = f'(\omega)$，因为在 $z=\omega$ 处全纯。由矩形的 Cauchy 定理，我们有 $\int\_{\partial D} T(z) dz = 0$。于是我们有 $\int\_{\partial D} \frac{f(z)}{z-\omega} dz = 2\pi i f(\omega)$。

设 $f:U\to \mathbb{C}$ 是全纯函数，$U$ 是开集，$\omega\in U$，$D$ 是以 $\omega$ 为中心且包含在 $U$ 中的圆盘。则 $f$ 在 $D$ 上**无限可微**且 $$f^{(n)}(\omega) = \frac{n!}{2\pi i} \int\_{\partial D} \frac{f(z)}{(z-\omega)^{n+1}} dz$$

在 Cauchy 积分公式两边求导。

函数 $f:\mathbb{C}\to \mathbb{C}$ 称为整函数，如果 $f$ 在 $\mathbb{C}$ 上全纯。

设 $f:\mathbb{C}\to \mathbb{C}$ 是整函数且有界。则 $f$ 是常值函数。

设 $\|f(z)\|\le M, \forall z\in \mathbb{C}$ 对于所有 $z\in D\_r(z)$，我们有 $f(z) = \frac{1}{2\pi i} \int\_{\partial D\_r(z)} \frac{f(w)}{w-z} dw$。于是 $\|f'(z)\| \le \frac{1}{2\pi} \int\_{\partial D\_r(z)} \frac{\|f(w)\|}{\|w-z\|^2} dw \le \frac{M}{r}$。令 $r\to \infty$ 我们得到 $f(z)' = 0$。于是 $f$ 局部为常值，因此为常值。（$\mathbb{C}$ 是连通的）

设 $p(z) = a\_n z^n + \cdots + a\_0$ 是次数为 $n\ge 1$ 的多项式。则 $p$ 在 $\mathbb{C}$ 中有根。

假设 $p$ 没有根。则 $f(z) = \frac{1}{p(z)}$ 是整函数。于是 $\|f(z)\| \le \frac{1}{\|a\_n\| \|z\|^n} \to 0$ 当 $\|z\|\to \infty$。于是 $f$ 有界，因此 $f$ 是常值函数。于是 $p$ 是常值函数，矛盾。

设 $f:U\mathring{\subset} \mathbb{C}\to \mathbb{C}$ 连续，且对 $U$ 中所有闭路径 $\gamma$ 有 $\int\_\gamma f(z) dz = 0$。则 $f$ 是全纯函数。

首先我们可以通过 $F(z) = \int\_{z\_0}^z f(\omega) d\omega$ 定义 $f$ 的原函数 $F$。则 $F$ 全纯且 $F'=f$。于是 $f$ 全纯。

设 $U\subset \mathbb{C}$ 是开集，$f:U\to \mathbb{C}$ 是全纯函数，$U$ 关于实轴对称。则 $f$ 延拓为 $U\cup \bar{U}$ 上的全纯函数 $\hat{f} = \begin{cases}
        f & \text{如果 } z\in U\\
        \overline{f(\bar{z})} & \text{如果 } z\in\bar{U}
    \end{cases}$。

只需验证 Morera 定理。

## 零点和奇点

设 $f:U\to \mathbb{C}$ 是全纯函数，$U$ 是开集，$p\in U$。

$f$ 在 $p$ 处的阶定义为 $$\\operatorname{ord}\_r f = \begin{cases}
            \infty & \text{如果 } f^{(n)}(p) = 0, \forall n\ge 0\\
            n & \text{如果 } f^{(k)}(p) = 0, \forall k<n, f^{(n)}(p) \ne 0
        \end{cases}$$

如果 $f$ 在 $p$ 处全纯且 $\\operatorname{ord}\_p f=\infty$，则存在 $r$ 使得对所有 $z\in D\_r(p)$ 有 $f(z) = 0$。

局部上我们可以将 $f$ 延拓为幂级数，于是 $f$ 恒为零。

假设 $f:\mathring{U}\to \mathbb{C}$ 全纯。假设 $\\operatorname{ord}\_p f = n$。则存在全纯函数 $g$ 使得 $f(z) = (z-p)^n g(z)$。

通过归纳法。

设 $f:U\mathring{\subset}\mathbb{C}\to \mathbb{C}$ 解析。则 $f$ 恒为零或具有孤立零点。

设 $f,g:U\to \mathbb{C}$ 是全纯函数，$U$ 是开集，$f=g$ 在 $U$ 中具有极限点的集合上成立，即 $\exists \{z\_n\},f(z\_n) = g(z\_n), \lim\_{n\to \infty} z\_n = p\in U$。则在 $U$ 上 $f=g$。

直接由前一定理得出。

这个定理意味着存在唯一的"最大"方式延拓全纯函数。

设 $g:U \to \mathbb{C}$ 是全纯函数，$g(p)\ne 0, n\ge 0$，则存在 $V\mathring{\subset} U$ 和全纯函数 $h,r:V\to \mathbb{C}$ 满足 $g = e^h$ 且 $g = r^n$。

考虑 $U$ 的单连通开子集 $V$，则 $h=\log (g)$ 在 $V$ 上全纯。

定义 $r = e^{h/n}$，则 $r^n = e^h = g$。

设 $U\mathring{\subset} \mathbb{C}$ 是连通的，$f:U\to \mathbb{C}$ 是全纯函数且非常值。则 $f(U)\subset \mathbb{C}$ 是开集。

对于 $v\in U$，取 $D(v,\epsilon)\subset U$，考虑 $\tilde{g}(z) = g(z) - g(v)$，于是 $\tilde{g}$ 在 $v$ 处有零点。于是 $\tilde{g} = (z-p)^n h$，其中 $n$ 是 $\tilde{g}$ 在 $v$ 处的阶。我们有 $h(v) = \frac{g^{(n)}}{n!} \ne 0$。于是存在 $r$ 使得 $h = r^n$。于是 $\tilde{g} = ((z-p)r)^n$。记 $s(z) = (z-p)r(z)$，因此 $s'(p) = r'(p) \ne 0$，由复隐函数定理，$s$ 局部可逆。因此 $v$ 的邻域通过 $s$ 映射到 $s(v)$ 的邻域，因此通过 $g=s^n$ 映射到 $g(v)$ 的邻域。

设 $U\mathring{\subset} \mathbb{C}$ 是连通的，$f:U\to \mathbb{C}$ 是全纯函数且非常值。则 $\|f\|$ 在 $U$ 中没有局部最大值。

由上述定理易得。

设 $f:U\setminus \{p\} \mathring{\subset} \mathbb{C} \to \mathbb{C}$ 是全纯函数，$p\in U$。定义

1)  $p$ 称为**可去奇点 (removable singularity)**，如果 $\exists \varepsilon$ 使得 $f\|\_{D\_\varepsilon^*(p)}$ 有界。

2)  $p$ 称为**极点 (pole)**，如果 $\lim\_{z\to p} f(z) = \infty$。

3)  $p$ 称为**本性奇点 (essential singularity)**，如果 $p$ 既不是可去奇点也不是极点。

设 $p$ 是 $f:U\setminus \{p\} \mathring{\subset} \mathbb{C} \to \mathbb{C}$ 的可去奇点。则 $f$ 全纯延拓到 $U$，满足 $f(p) = \lim\_{z\to p} f(z)$。

考虑 $g(z) = \begin{cases}
        f(z)\cdot (z-p) & \text{如果 } z\ne p\\
        0 & \text{如果 } z = p
    \end{cases}$，因为 $f$ 在 $p$ 附近有界，$g$ 在 $p$ 处连续。因为 $p$ 是 $g$ 的零点，$f=g/(z-p)$ 在 $p$ 处连续。因此 $f$ 在 $p$ 处全纯。

如果 $f$ 在 $p$ 处有极点，则存在 $n\ge 1$ 和全纯函数 $g:U\to \mathbb{C}$ 使得 $f(z) = \frac{g(z)}{(z-p)^n}$。且 $g$ 在 $p$ 处有可去奇点，满足 $g(p)\ne 0$。$n$ 称为 $f$ 在 $p$ 处的极点阶数。

考虑 $\tilde{f}: \tilde{U} \to \mathbb{C}$ 满足 $\tilde{f} = 1/ f$。则 $\tilde{f}$ 在 $p$ 处有可去奇点，且因为 $\tilde{f}(p)=0$，存在 $n\ge 1$ 和在 $p$ 处全纯的 $g$，使得 $\tilde{f}(z) = (z-p)^n \tilde{g}(z)$ 且 $\tilde{g}(p)\ne 0$。于是 $f(z) = \frac{1}{(z-p)^n} g(z)$，其中 $g(z) = 1/\tilde{g}(z)$。

如果 $f$ 全纯且在 $\infty$ 处有可去奇点，则 $f$ 是常值函数。

如果 $f$ 在 $\infty$ 处没有本性奇点，则 $f$ 是多项式。

考虑 $\phi(z) = f(1/z)$。则 $f$ 在 $z=0$ 处有非本性奇点，因此 $\phi(z) = g(z) / z^n$，其中 $n\in \mathbb{N}$ 且 $g$ 全纯。因此 $f(z) = g(1/z) z^n$。

使用 Cauchy 积分公式，$f^{(n)}(z) = \frac{n!}{2\pi i} \int\_{\partial D\_r(0)} \frac{f(w)}{(w-z)^{n+1}} dw = 0$ 对所有 $z\in \mathbb{C}\setminus \{0\}$ 成立，因此 $f^{(n)}(z) = 0$ 对所有 $z\in \mathbb{C}$ 成立，因此 $f$ 是多项式。

设 $p\in U\mathring{\subset}\mathbb{C}$，$f:U\setminus \{p\}\to \mathbb{C}$ 全纯。则 $f$ 在 $p$ 处有本性奇点当且仅当对所有 $\varepsilon$，$D\_\varepsilon(p)\subset U$，$\\operatorname{Im}(f\|\_{D\_\varepsilon(p)\setminus p})$ 在 $\mathbb{C}$ 中稠密。

如果 $p$ 是可去奇点或极点，则 $D\_\varepsilon(p)\setminus p$ 的像在 $\mathbb{C}$ 中不稠密。

假设对某个 $\varepsilon >0$，$\\operatorname{Im}(f\|\_{D\_\varepsilon^*(p)})$ 在 $\mathbb{C}$ 中不稠密。我们证明它有本性奇点。

存在某个 $\delta>0,a\in \mathbb{C}$，使得 $D\_\delta(a)\cap \\operatorname{Im}(f\|\_{D\_\varepsilon^*(p)})=\emptyset$。

考虑全纯函数 $g=\frac{1}{f-a}$。我们有 $\|g\|<1/\delta$，因此 $g$ 有界。于是 $p$ 是 $g$ 的可去奇点，因此 $f$ 有可去奇点。

Picard 定理指出：如果 $f$ 是整函数且非常值，则 $f$ 的像是 $\mathbb{C}$ 或对某个 $a\in \mathbb{C}$ 为 $\mathbb{C}\setminus \{a\}$。且 $f^{-1}(\cdot)$ 不是有限的。
