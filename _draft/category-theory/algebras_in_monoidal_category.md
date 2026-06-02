---
title: "Category Theory 结合代数和模"
date: 2026-01-25
categories: [algebra, category-theory]
tags: [algebra, monoidal-category, module]
use_math: true
---

# 结合代数和模
============

设 $\mathcal{C}$ 是一个幺半范畴. $\mathcal{C}$ 中的一个代数 $A$
由下列要素组成

1.  一个对象 $A \in \mathcal{C}$;

2.  一个态射 $u: \mathbf{1} \to A$, 称为单位;

3.  一个态射 $m: A \otimes A \to A$, 称为乘法;

使得下列图表交换 $$\begin{tikzcd}
& A \otimes A \arrow[dr, "m"] & \
\mathbf{1} \otimes A \arrow[ur, "u \otimes \mathrm{Id}_A"] \arrow[rr, "\lambda_A"] & & A,
\end{tikzcd}
\quad
\begin{tikzcd}
& A \otimes A \arrow[dr, "m"] & \
A \otimes \mathbf{1} \arrow[ur, "\mathrm{Id}_A \otimes u"] \arrow[rr, "\rho_A"] & & A,
\end{tikzcd}
\quad
\begin{tikzcd}
A \otimes A \otimes A \arrow[r, "\mathrm{Id}_A \otimes m"] \arrow[d, "m \otimes \mathrm{Id}_A"] & A \otimes A \arrow[d, "m"] \
A \otimes A \arrow[r, "m"] & A.
\end{tikzcd}$$ 设 $A, B$ 是 $\mathcal{C}$ 中的两个代数. 一个代数同态
$f: A \to B$ 是一个态射, 使得下列图表交换 $$\begin{tikzcd}
& \mathbf{1} \arrow[dl, "u"'] \arrow[dr, "u"] & \
A \arrow[rr, "f"] & & B,
\end{tikzcd}
\quad
\begin{tikzcd}
A \otimes A \arrow[r, "f \otimes f"] \arrow[d, "m"] & B \otimes B \arrow[d, "m"] \
A \arrow[r, "f"] & B.
\end{tikzcd}$$ $\mathcal{C}$ 中的代数和代数同态构成一个范畴, 记作
$\mathrm{Alg}(\mathcal{C})$. $\mathcal{C}^{\mathrm{op}}$
中的一个代数称为 $\mathcal{C}$ 中的一个余代数.

1.  赋予 $\mathrm{Set}$ 乘积幺半范畴结构. 则
    $\mathrm{Alg}(\mathrm{Set})$ 是由通常的半群和半群同态组成的范畴.

2.  赋予 $\mathrm{Abel}$ 通常的幺半范畴结构. 则
    $\mathrm{Alg}(\mathrm{Abel}) \simeq \mathrm{Ring}$.

3.  $\mathrm{Alg}(\mathrm{Vect}_k)$ 是 $k$ 代数及 $k$
    代数同态组成的范畴.

4.  $\mathrm{Alg}(\mathrm{Rep}\,G)$ 是有限维 $G$ 代数及 $G$
    代数同态组成的范畴.

5.  全体范畴及函子的同构类组成一个范畴 $\mathrm{Cat}$,
    它在范畴乘积下构成一个幺半范畴. 每个幺半范畴都是其中的代数.
    (反之不然, 正确的做法是保留函子同构将 $\mathrm{Cat}$
    做成一个二阶范畴.)

<!-- -->

1.  幺半范畴 $\mathcal{C}$ 中的每个代数 $A$ 都可看作是
    $\mathcal{C}^{\mathrm{rev}}$ 中的代数, 记作 $A^{\mathrm{rev}}$,
    因为一个态射 $m: A \otimes A \to A$ 等价于一个态射
    $m: A \otimes^{\mathrm{rev}} A \to A$. 于是
    $\mathrm{Alg}(\mathcal{C}) \simeq \mathrm{Alg}(\mathcal{C}^{\mathrm{rev}})$.

2.  若 $\mathcal{C}, \mathcal{D}$ 是幺半范畴, 则
    $\mathrm{Alg}(\mathcal{C} \times \mathcal{D}) = \mathrm{Alg}(\mathcal{C}) \times \mathrm{Alg}(\mathcal{D})$.

3.  幺半范畴 $\mathcal{C}$ 的单位对象 $\mathbf{1}$ 本身是一个代数, 它是
    $\mathrm{Alg}(\mathcal{C})$ 的始对象. 一个代数称为平凡代数, 若它是
    $\mathrm{Alg}(\mathcal{C})$ 的始对象.

证明: 若幺半范畴 $\mathcal{C}$ 中的一个代数 $A$ 作为对象是可逆的, 则 $A$
是平凡代数.

1.  若幺半范畴 $\mathcal{C}$ 有所有小(或者有限)极限, 则
    $\mathrm{Alg}(\mathcal{C})$ 也有所有小(或者有限)极限, 并且遗忘函子
    $G: \mathrm{Alg}(\mathcal{C}) \to \mathcal{C}$ 保持小(或者有限)极限.

2.  若幺半范畴 $\mathcal{C}$ 有小正向极限, 并且 $\mathcal{C}$
    的张量积分别关于每个变量保持小正向极限, 则
    $\mathrm{Alg}(\mathcal{C})$ 也有小正向极限, 并且遗忘函子
    $G: \mathrm{Alg}(\mathcal{C}) \to \mathcal{C}$ 保持小正向极限.

<!-- -->

1.  设
    $p: \Lambda \to \mathrm{Alg}(\mathcal{C}), \alpha \mapsto A_\alpha$
    是一个小(或者有限)图表. 令 $A = \varprojlim G(A_\alpha)$. 则单位
    $\mathbf{1} \to A_\alpha$ 确定一个态射 $u: \mathbf{1} \to A$.
    复合态射 $A \otimes A \to A_\alpha \otimes A_\alpha \to A_\alpha$
    确定一个态射 $m: A \otimes A \to A$. 它们将 $A$ 提升为一个代数, 使得
    $A$ 是图表 $p$ 的极限.

2.  设
    $p: \Lambda \to \mathrm{Alg}(\mathcal{C}), \alpha \mapsto A_\alpha$
    是一个小正向图表. 令 $A = \varinjlim G(A_\alpha)$. 则复合态射
    $u: \mathbf{1} \to A_\alpha \to A$ 与 $\alpha$ 选取无关. 复合态射
    $A_\alpha \otimes A_\beta \to A_\gamma \otimes A_\gamma \to A_\gamma \to A$
    与 $\alpha, \beta$ 的上界 $\gamma$ 选取无关, 从而确定态射
    $m: A \otimes A \cong \varinjlim (A_\alpha \otimes A_\beta) \to A$.
    它们将 $A$ 提升为一个代数, 使得 $A$ 是图表 $p$ 的正向极限.

设 $\mathcal{C}$ 是幺半范畴, $\mathcal{M}$ 是一个左 $\mathcal{C}$-模,
$A$ 是 $\mathcal{C}$ 中的一个代数. $\mathcal{M}$ 中的一个左 $A$-模 $M$
由下列要素组成

1.  一个对象 $M \in \mathcal{M}$;

2.  一个态射 $m: A \otimes M \to M$;

使得下列图表交换 $$\begin{tikzcd}
& A \otimes M \arrow[dr, "m"] & \
\mathbf{1} \otimes M \arrow[ur, "u \otimes \mathrm{Id}_M"] \arrow[rr, "\lambda_M"] & & M,
\end{tikzcd}
\quad
\begin{tikzcd}
A \otimes A \otimes M \arrow[r, "\mathrm{Id}_A \otimes m"] \arrow[d, "m \otimes \mathrm{Id}_M"] & A \otimes M \arrow[d, "m"] \
A \otimes M \arrow[r, "m"] & M.
\end{tikzcd}$$ 设 $M, N$ 是两个 $\mathcal{M}$ 中的左 $A$-模. 一个模同态
$f: M \to N$ 是一个态射, 使得下列图表交换 $$\begin{tikzcd}
A \otimes M \arrow[r, "\mathrm{Id}_A \otimes f"] \arrow[d, "m"] & A \otimes N \arrow[d, "m"] \
M \arrow[r, "f"] & N.
\end{tikzcd}$$ $\mathcal{M}$ 中的左 $A$-模及模同态构成一个范畴, 记作
$\mathrm{LMod}_A(\mathcal{M})$ 或 ${}_A\mathcal{M}$.

设 $\mathcal{D}$ 是幺半范畴, $\mathcal{M}$ 是一个右 $\mathcal{D}$-模,
$B$ 是 $\mathcal{D}$ 中的一个代数. $\mathcal{M}$ 中的左
$B^{\mathrm{rev}}$-模范畴记作 $\mathrm{RMod}_B(\mathcal{M})$ 或
$\mathcal{M}_B$, 其中的对象也称为一个右 $B$-模.

设 $\mathcal{C}, \mathcal{D}$ 是幺半范畴, $\mathcal{M}$ 是一个
$\mathcal{C}$-$\mathcal{D}$ 双模, $(A,B)$ 是
$\mathcal{C} \times \mathcal{D}$ 中的一个代数. $\mathcal{M}$ 中的左
$(A, B^{\mathrm{rev}})$-模范畴记作 $\mathrm{BMod}_{A|B}(\mathcal{M})$ 或
${}_A\mathcal{M}_B$, 其中的对象也称为一个 $A$-$B$ 双模.

设 $A, B$ 是两个环. 则 $\mathrm{LMod}_A(\mathrm{Abel})$,
$\mathrm{RMod}_B(\mathrm{Abel})$, $\mathrm{BMod}_{A|B}(\mathrm{Abel})$
分别是通常的左 $A$-模范畴, 右 $B$-模范畴, $A$-$B$ 双模范畴.

若 $\mathcal{M}$ 是一个 $\mathcal{C}$-$\mathcal{D}$ 双模, 则
${}_A\mathcal{M}$ 是一个右 $\mathcal{D}$-模, 并且
${}_A\mathcal{M}_B \simeq ({}_A\mathcal{M})_B$. 特别地,
${}_A\mathcal{C}$ 是一个右 $\mathcal{C}$-模.

设 $\mathcal{C}$ 是一个幺半范畴, $A \in \mathrm{Alg}(\mathcal{C})$
是一个代数, $\mathcal{M}$ 是一个左 $\mathcal{C}$-模.

1.  遗忘函子 $G: {}_A\mathcal{M} \to \mathcal{M}$ 是保守的.

2.  $G$ 有左伴随函子 $F: X \mapsto A \otimes X$. 其中 $A \otimes X$
    称为由 $X$ 生成的自由 $A$-模.

<!-- -->

1.  若模同态 $f: M \to N$ 是 $\mathcal{M}$ 中的同构, 则 $f^{-1}$
    自动是模同态.

2.  自然态射 $X \xrightarrow{u \otimes X} A \otimes X = GF(X)$ 和
    $FG(M) = A \otimes M \xrightarrow{m} M$ 使得 $F$ 是 $G$ 的左伴随.

遗忘函子给出等价 ${}_\mathbf{1}\mathcal{M} \simeq \mathcal{M}$.

自然态射 $X \xrightarrow{u \otimes X} \mathbf{1} \otimes X = GF(X)$
是同构, 所以 $F$ 完全忠实. 又因为 $G$ 保守, 所以是等价.

设 $\mathcal{C}$ 是一个幺半范畴, $A \in \mathrm{Alg}(\mathcal{C})$
是一个代数, $\mathcal{M}$ 是一个左 $\mathcal{C}$-模.

1.  如果 $\mathcal{M}$ 有所有小(或者有限)极限, 则 ${}_A\mathcal{M}$
    也有所有小(或者有限)极限, 并且遗忘函子
    ${}_A\mathcal{M} \to \mathcal{M}$ 保持小(或者有限)极限.

2.  如果 $\mathcal{M}$ 有所有小(或者有限)余极限, 并且函子
    $A \otimes - : \mathcal{M} \to \mathcal{M}$ 保持小(或者有限)余极限,
    则 ${}_A\mathcal{M}$ 也有所有小(或者有限)余极限, 并且遗忘函子
    ${}_A\mathcal{M} \to \mathcal{M}$ 保持小(或者有限)余极限.

<!-- -->

1.  设 $p: J \to {}_A\mathcal{M}, \alpha \mapsto M_\alpha$ 是一个图表.
    则复合态射
    $A \otimes \varprojlim G(M_\alpha) \to \varprojlim A \otimes G(M_\alpha) \to \varprojlim G(M_\alpha)$
    赋予 $\varprojlim G(M_\alpha)$ 一个左 $A$-模结构, 使得它成为图表 $p$
    的极限.

2.  设 $p: J \to {}_A\mathcal{M}, \alpha \mapsto M_\alpha$ 是一个图表.
    则复合态射
    $A \otimes \varinjlim G(M_\alpha) \cong \varinjlim A \otimes G(M_\alpha) \to \varinjlim G(M_\alpha)$
    赋予 $\varinjlim G(M_\alpha)$ 一个左 $A$-模结构, 使得它成为图表 $p$
    的余极限.

<!-- -->

1.  对于 $M \in {}_A\mathcal{M}$, 有余等化子图表
    $A \otimes A \otimes M \rightrightarrows A \otimes M \xrightarrow{m} M$.
    特别地, $m$ 是一个满射.

2.  设 $N \in \mathcal{C}_A, M \in {}_A\mathcal{M}$. 我们以
    $N \otimes_A M$ 表示图表
    $N \otimes A \otimes M \rightrightarrows N \otimes M$ 的余等化子.
    根据 (1), 我们有 $A \otimes_A M \cong M$.

设 $\mathcal{C}$ 有余等化子, 并且张量积关于每个变量都保持余等化子. 则
${}_A\mathcal{C}_A$ 是一个幺半范畴, 张量积为 $\otimes_A$.
并且有辫幺半函子
$\mathfrak{Z}(\mathcal{C}) \to \mathfrak{Z}({}_A\mathcal{C}_A), X \mapsto X \otimes A$.
$\mathcal{C}_A$ 是一个 $\mathcal{C}$-${}_A\mathcal{C}_A$ 双模,
${}_A\mathcal{C}$ 是一个 ${}_A\mathcal{C}_A$-$\mathcal{C}$ 双模.

设 $f: A \to B$ 是 $\mathcal{C}$ 中的一个代数同态, $\mathcal{M}$
是一个左 $\mathcal{C}$-模, $M \in {}_B\mathcal{M}$. 则复合态射
$A \otimes M \xrightarrow{f \otimes \mathrm{Id}_M} B \otimes M \xrightarrow{m} M$
赋予 $M$ 一个左 $A$-模结构. 特别地, $B$ 是一个 $A$-$A$ 双模.

设 $f: A \to B$ 是幺半范畴 $\mathcal{C}$ 中的一个代数同态, $\mathcal{M}$
是一个左 $\mathcal{C}$-模. 假设 $\mathcal{M}$ 有余等化子, 并且函子
$B \otimes - : \mathcal{M} \to \mathcal{M}$ 保持余等化子. 则有自然双射
$\mathrm{Hom}_{{}_B\mathcal{M}}(B \otimes_A M, N) \cong \mathrm{Hom}_{{}_A\mathcal{M}}(M, N)$,
$M \in {}_A\mathcal{M}, N \in {}_B\mathcal{M}$.

自然态射
$M \cong A \otimes_A M \xrightarrow{f \otimes_A \mathrm{Id}_M} B \otimes_A M$
和 $B \otimes_A N \to B \otimes_B N \cong N$ 使得
$M \mapsto B \otimes_A M$ 是 $N \mapsto N$ 的左伴随.

交换代数
========

设 $\mathcal{C}$ 是一个辫幺半范畴. 一个 $\mathcal{C}$ 中的代数 $A$
称为交换的, 如果下列图表交换 $$\begin{tikzcd}
& A \otimes A \arrow[dr, "m"] & \
A \otimes A \arrow[ur, "\beta_{A,A}"] \arrow[rr, "m"] & & A.
\end{tikzcd}$$ $\mathrm{Alg}(\mathcal{C})$
中由交换代数组成的完全子范畴记作 $\mathrm{CAlg}(\mathcal{C})$.

设 $\mathcal{C}$ 是一个辫幺半范畴. 对于
$A, B \in \mathrm{Alg}(\mathcal{C})$, 复合态射
$$(A \otimes B) \otimes (A \otimes B) \xrightarrow{\mathrm{Id}_A \otimes \beta_{A,B}^{-1} \otimes \mathrm{Id}_B} A \otimes A \otimes B \otimes B \xrightarrow{m \otimes m} A \otimes B$$
赋予了 $A \otimes B$ 一个代数结构, 使 $\mathrm{Alg}(\mathcal{C})$
成为一个幺半范畴. 若 $\mathcal{C}$ 是对称的, 则
$\mathrm{Alg}(\mathcal{C})$ 成为一个对称幺半范畴.

设 $\mathcal{C}$ 是一个辫幺半范畴. 则遗忘函子
$\mathrm{Alg}(\mathrm{Alg}(\mathcal{C})) \simeq \mathrm{Alg}(\mathcal{C})$
诱导等价
$\mathrm{Alg}(\mathrm{Alg}(\mathcal{C})) \simeq \mathrm{CAlg}(\mathcal{C})$.

根据定义, $\mathrm{Alg}(\mathrm{Alg}(\mathcal{C}))$ 的一个对象由一个代数
$A \in \mathrm{Alg}(\mathcal{C})$ 及两个代数同态 $u: \mathbf{1} \to A$,
$m: A \otimes A \to A$ 组成. $u: \mathbf{1} \to A$
是一个代数同态等价于说 $u$ 与代数 $A$ 的单位一致. 进而,
$m: A \otimes A \to A$ 是一个代数同态等价于说 $m$ 与代数 $A$ 的乘法一致,
并且 $A$ 是一个交换代数. 这给出了一个函子
$\Phi: \mathrm{Alg}(\mathrm{Alg}(\mathcal{C})) \to \mathrm{CAlg}(\mathcal{C})$.
上述构造过程可逆回, 因此 $\Phi$ 是等价.

$\mathrm{Alg}(\mathrm{Ring}) \simeq \mathrm{CRing}$.

设 $\mathcal{C}$ 是一个对称幺半范畴. 证明: 遗忘函子
$\mathrm{Alg}(\mathrm{Alg}(\mathcal{C}^{\mathrm{op}})^{\mathrm{op}}) \to \mathrm{Alg}(\mathcal{C}^{\mathrm{op}})^{\mathrm{op}}$
可提升为一个对称幺半等价
$\mathrm{Alg}(\mathrm{Alg}(\mathcal{C}^{\mathrm{op}})^{\mathrm{op}}) \simeq \mathrm{Alg}(\mathrm{Alg}(\mathcal{C})^{\mathrm{op}})^{\mathrm{op}}$,
其中的对象称为双代数.

设 $\mathcal{C}$ 是一个辫幺半范畴, $A \in \mathrm{CAlg}(\mathcal{C})$.
一个局部 $A$-模是一个右 $A$-模 $M$, 使得下列图表交换: $$\begin{tikzcd}
A \otimes M \arrow[r, "\beta_{A,M}"] \arrow[d, "\beta_{M,A}"'] & M \otimes A \arrow[d, "m"] \
M \otimes A \arrow[r, "m"] & M.
\end{tikzcd}$$ 全体局部 $A$-模组成 $\mathcal{C}_A$ 的一个完全子范畴,
记作 $\mathcal{C}_A^0$.

设辫幺半范畴 $\mathcal{C}$ 有余等化子,
并且张量积关于每个变量都保持余等化子. 设
$A \in \mathrm{CAlg}(\mathcal{C})$.

1.  一个右 $A$-模 $M$ 自动成为一个 $A$-$A$ 双模, 其中左作用定义为
    $A \otimes M \xrightarrow{\beta_{A,M}} M \otimes A \xrightarrow{m} M$.
    我们得到一个完全忠实函子 $\mathcal{C}_A \to {}_A\mathcal{C}_A$, 使得
    $\mathcal{C}_A$ 成为一个幺半范畴.

2.  $\mathcal{C}_A^0$ 是一个辫幺半范畴, 辫结构
    $M \otimes_A N \cong N \otimes_A M$ 由
    $\beta_{M,N}: M \otimes N \to N \otimes M$ 所诱导. 如果
    $\mathcal{C}$ 是对称的, 则 $\mathcal{C}_A^0 = \mathcal{C}_A$
    也是对称的.

3.  有辫幺半函子
    $\mathcal{C} \to \mathfrak{Z}(\mathcal{C}_A), X \mapsto X \otimes A$,
    以及
    $\mathcal{C}_A^0 \hookrightarrow \mathfrak{Z}(\mathcal{C}_A), M \mapsto M$.

内蕴 Hom
========

设 $\mathcal{C}$ 是一个幺半范畴, $\mathcal{M}$ 是一个左
$\mathcal{C}$-模. 两个对象 $M, N \in \mathcal{M}$ 的内蕴 $\mathrm{Hom}$
是一个 $\mathcal{C}$ 的对象 ${[M,N]}$ 使得
$\mathrm{Hom}_{\mathcal{M}}(- \otimes M, N) \cong \mathrm{Hom}_{\mathcal{C}}(-, {[M,N]})$.
若 ${[M,N]}$ 对所有 $M, N \in \mathcal{M}$ 都存在, 则称范畴
$\mathcal{M}$ enriched 于 $\mathcal{C}$ 中.

1.  将幺半范畴 $\mathcal{C}$ 视为左 $\mathcal{C}$-模. 若 $X$ 有左对偶,
    则 $[X,Y] \cong Y \otimes X^L$. 特别地, 若 $\mathcal{C}$ 是刚性的,
    则它 enrich 于自身中.

2.  一个交换环 $A$ 的模范畴 $\mathrm{LMod}_A$ enrich 于自身中, 且
    ${[M,N]} \cong \mathrm{hom}_A(M,N)$.

3.  集合范畴 $\mathrm{Set}$ 取乘积幺半范畴结构, enrich 于自身中, 且
    ${[M,N]} \cong \mathrm{Hom}_{\mathrm{Set}}(M,N)$.

在上述定义中, 假设 $[M,-]: \mathcal{M} \to \mathcal{C}$ 存在.

1.  由定义 $[M,-]$ 是 $- \otimes M$ 的右伴随.

2.  恒同态射 ${[M,N]} \to {[M,N]}$ 诱导态射 ${[M,N]} \otimes M \to N$.
    态射 $X \otimes {[M,N]} \otimes M \to X \otimes N$ 诱导态射
    $X \otimes {[M,N]} \to [M, X \otimes N]$.

3.  根据下述命题, ${[M,M]}$ 定义了一个 $\mathcal{C}$ 中的代数, 且
    ${[M,N]}$ 定义了一个右 ${[M,M]}$-模. 于是我们得到一个函子
    $\mathcal{M} \to \mathcal{C}_{{[M,M]}}, N \mapsto {[M,N]}$.
    稍后我们将证明, 在适当的条件下这个函子是左 $\mathcal{C}$-模等价.

若下列图表中的内蕴 $\mathrm{Hom}$ 存在, 则图表交换: $$\begin{tikzcd}
\mathbf{1} \otimes {[M,M]} \arrow[dr, "\sim"] \arrow[dd, "\lambda_{{[M,M]}}"'] & & {[M,N]} \otimes \mathbf{1} \arrow[dl, "\sim"'] \arrow[dd, "\rho_{{[M,N]}}"] \
& {[M,M]} \otimes {[N,M]} \arrow[r] & {[N,M]}, \
{[M,M]} \otimes {[N,M]} \arrow[rr] & & {[N,M]},
\end{tikzcd}
\quad
\begin{tikzcd}
{[P,Q]} \otimes {[N,P]} \otimes {[M,N]} \arrow[r] \arrow[d] & {[P,Q]} \otimes {[M,P]} \arrow[d] \
{[N,Q]} \otimes {[M,N]} \arrow[r] & {[M,Q]}.
\end{tikzcd}$$ 其中态射 $\mathbf{1} \to {[M,M]}$ 由
$\mathbf{1} \otimes M \cong M$ 诱导, 态射
$[N,P] \otimes {[M,N]} \to [M,P]$ 由复合态射
$[N,P] \otimes {[M,N]} \otimes M \to [N,P] \otimes N \to P$ 诱导.

有交换图表: $$\begin{tikzcd}
\mathbf{1} \otimes {[N,M]} \otimes N \arrow[r] \arrow[d] & \mathbf{1} \otimes M \arrow[d] \arrow[dr, "\sim"] & \
{[M,M]} \otimes {[N,M]} \otimes N \arrow[r] & {[M,M]} \otimes M \arrow[r] & M,
\end{tikzcd}
\quad
\begin{tikzcd}
{[M,N]} \otimes \mathbf{1} \otimes M \arrow[d] \arrow[dr, "\sim"] & \
{[M,N]} \otimes {[M,M]} \otimes M \arrow[r] & {[M,N]} \otimes M \arrow[r] & N,
\end{tikzcd}$$

设 $\mathcal{C}$ 是一个幺半范畴, 左 $\mathcal{C}$-模 $\mathcal{M}$
enrich 于 $\mathcal{C}$ 中. 若 $X \in \mathcal{C}$ 有左对偶, 则对于
$M, N \in \mathcal{M}$, 典范态射
$X \otimes {[M,N]} \to [M, X \otimes N]$ 是同构.

复合态射
$[M, X \otimes N] \to X \otimes X^L \otimes [M, X \otimes N] \to X \otimes [M, X^L \otimes X \otimes N] \to X \otimes {[M,N]}$
是典范态射的逆.

设 $\mathcal{C}$ 是刚性的幺半范畴, $A \in \mathrm{Alg}(\mathcal{C})$. 若
$M$ 是一个右 $A$-模, 则 $m: M \otimes A \to M$ 诱导一个态射
$A \otimes M^R \to M^R$, 使得 $M^R$ 成为一个左 $A$-模. 于是有等价
$\mathcal{C}_A \simeq ({}_A\mathcal{C})^{\mathrm{op}}, M \mapsto M^R$,
它的逆是 $N \mapsto N^L$.

设 $\mathcal{C}$ 是刚性的幺半范畴有余等化子,
$A \in \mathrm{Alg}(\mathcal{C})$. 有自然双射
$\mathrm{Hom}_{\mathcal{C}_A}(M, X \otimes N) \cong \mathrm{Hom}_{\mathcal{C}}(M \otimes_A N^R, X)$,
$X \in \mathcal{C}, M, N \in \mathcal{C}_A$.

左边是图表
$\mathrm{Hom}_{\mathcal{C}}(M, X \otimes N) \rightrightarrows \mathrm{Hom}_{\mathcal{C}}(M \otimes A, X \otimes N)$
的等化子. 右边是图表
$\mathrm{Hom}_{\mathcal{C}}(M \otimes_A N^R, X) \rightrightarrows \mathrm{Hom}_{\mathcal{C}}(M \otimes A \otimes N^R, X)$
的等化子.

设刚性的幺半范畴 $\mathcal{C}$ 有余等化子, $A$ 是一个 $\mathcal{C}$
中的代数. 视 $\mathcal{C}_A$ 为一个左 $\mathcal{C}$-模. 则
$\mathcal{C}_A$ enrich 于 $\mathcal{C}$ 中, 且有典范同构
${[M,N]} \cong (M \otimes_A N^R)^L$.

我们有
$\mathrm{Hom}_{\mathcal{C}_A}(X \otimes M, N) \cong \mathrm{Hom}_{\mathcal{C}_A}(M, X^R \otimes N) \cong \mathrm{Hom}_{\mathcal{C}}(M \otimes_A N^R, X^R) \cong \mathrm{Hom}_{\mathcal{C}}(X, (M \otimes_A N^R)^L)$.

代数的中心
==========

设 $\mathcal{C}$ 是辫幺半范畴 $\mathcal{D}$ 上的幺半范畴.

$\mathrm{Alg}(\mathcal{C})$ 是 $\mathrm{Alg}(\mathcal{D})$ 的左模. 对于
$A \in \mathrm{Alg}(\mathcal{C})$ 和 $B \in \mathrm{Alg}(\mathcal{D})$,
$B \otimes A$ 的乘法由
$(B \otimes A) \otimes (B \otimes A) \cong B \otimes B \otimes A \otimes A \xrightarrow{m \otimes m} B \otimes A$
给出.

一个代数 $A \in \mathrm{Alg}(\mathcal{C})$ 在 $\mathcal{D}$
中的中心是一个代数 $Z_{\mathcal{D}}(A) \in \mathrm{Alg}(\mathcal{D})$
及一个代数同态 $m: Z_{\mathcal{D}}(A) \otimes A \to A$,
使得下列图表交换: $$\begin{tikzcd}
& Z_{\mathcal{D}}(A) \otimes A \arrow[dr, "m"] & \
A \arrow[ur, "u \otimes \mathrm{Id}_A"] \arrow[rr, "\mathrm{Id}_A"] & & A,
\end{tikzcd}$$ 并且满足下述泛性质. 对任意代数
$B \in \mathrm{Alg}(\mathcal{D})$ 及代数同态 $f: B \otimes A \to A$,
若下列图表交换 $$\begin{tikzcd}
& B \otimes A \arrow[dr, "f"] & \
A \arrow[ur, "u \otimes \mathrm{Id}_A"] \arrow[rr, "\mathrm{Id}_A"] & & A,
\end{tikzcd}$$ 则存在唯一的代数同态 $g: B \to Z_{\mathcal{D}}(A)$,
使得下列图表交换 $$\begin{tikzcd}
& Z_{\mathcal{D}}(A) \otimes A \arrow[dr, "m"] & \
B \otimes A \arrow[ur, "g \otimes \mathrm{Id}_A"] \arrow[rr, "f"] & & A.
\end{tikzcd}$$

当 $\mathcal{D} = \mathfrak{Z}(\mathcal{C})$ 时, 我们将
$Z_{\mathcal{D}}(A)$ 记作 $Z(A)$, 称为 $A$ 的完全中心.

复合代数同态
$Z_{\mathcal{D}}(A) \otimes Z_{\mathcal{D}}(A) \otimes A \xrightarrow{\mathrm{Id}_{Z_{\mathcal{D}}(A)} \otimes m} Z_{\mathcal{D}}(A) \otimes A \xrightarrow{m} A$
诱导一个代数同态
$Z_{\mathcal{D}}(A) \otimes Z_{\mathcal{D}}(A) \to Z_{\mathcal{D}}(A)$,
使得
$Z_{\mathcal{D}}(A) \in \mathrm{Alg}(\mathrm{Alg}(\mathcal{D})) \simeq \mathrm{CAlg}(\mathcal{D})$.
因此 $Z_{\mathcal{D}}(A)$ 是交换代数.

假设 $[A,A]_{\mathcal{D}}$ 存在, 其中 $A$ 视为 ${}_A\mathcal{C}_A$
的对象. 则 ${}_A\mathcal{C}_A$ 中的典范态射
$m: [A,A]_{\mathcal{D}} \otimes A \to A$ 是 $\mathcal{C}$ 中的代数同态,
使得 $[A,A]_{\mathcal{D}}$ 实现中心 $Z_{\mathcal{D}}(A)$.

令 $Z = [A,A]_{\mathcal{D}}$. 由交换图表 $$\begin{tikzcd}
Z \otimes A \otimes Z \otimes A \arrow[r, "\sim"] \arrow[d, "\mathrm{Id}_Z \otimes \mathrm{Id}_A \otimes m"'] & Z \otimes Z \otimes A \otimes A \arrow[d, "\mathrm{Id}_Z \otimes m \otimes \mathrm{Id}_A"] \
Z \otimes A \otimes A \arrow[r, "\mathrm{Id}_Z \otimes m"] & Z \otimes A
\end{tikzcd}
\begin{tikzcd}
Z \otimes A \arrow[r, "m"] & A
\end{tikzcd}$$ 的外层方块可知 $m: Z \otimes A \to A$ 是代数同态.

由交换图表 $$\begin{tikzcd}
A \otimes B \otimes A \otimes A \arrow[r, "\sim"] \arrow[d] & B \otimes A \otimes A \otimes A \arrow[r, "\mathrm{Id}_B \otimes m"] \arrow[d] & B \otimes A \arrow[d, "f"] \
B \otimes A \otimes B \otimes A \otimes B \otimes A \arrow[r, "\sim"] \arrow[d, "f \otimes f \otimes f"'] & B \otimes B \otimes B \otimes A \otimes A \otimes A \arrow[r, "m \otimes m"] \arrow[d] & B \otimes A \arrow[d, "f"] \
A \otimes A \otimes A \arrow[rr, "m"] & & A
\end{tikzcd}$$ 的外层方块可知 $f: B \otimes A \to A$ 是 $A$-$A$
双模同态. 因此存在唯一 $\mathcal{D}$ 中的态射 $g: B \to Z$ 使得
$m \circ (g \otimes \mathrm{Id}_A) = f$. 由 $Z$ 的万有性质可知 $g$
是代数同态.

如果
$[\mathbf{1}_{\mathcal{C}}, \mathbf{1}_{\mathcal{C}}]_{\mathcal{D}}$
存在, 则它是平凡代数 $\mathbf{1}_{\mathcal{C}}$ 在 $\mathcal{D}$
中的中心. 特别地, 它是一个交换代数.

当 $\mathcal{C} = \mathcal{D} = \mathrm{Abel}$ 时,
$[A,A]_{\mathcal{D}} = \mathrm{hom}_{A|A}(A,A)$.

Barr-Beck 定理
==============

设 $\mathcal{C}$ 是一个范畴. 幺半范畴
$\mathrm{Fun}(\mathcal{C}, \mathcal{C})$ 中的一个代数 $T$ 称为
$\mathcal{C}$ 上的一个单子. 我们称一个函子
$G: \mathcal{D} \to \mathcal{C}$ 是单子的, 如果存在 $\mathcal{C}$
上的一个单子 $T$ 和范畴等价
$\mathcal{D} \simeq \mathrm{LMod}_T(\mathcal{C})$, 使得 $G$
同构于复合函子
$\mathcal{D} \simeq \mathrm{LMod}_T(\mathcal{C}) \to \mathcal{C}$.

若函子 $F: \mathcal{C} \to \mathcal{D}$ 是
$G: \mathcal{D} \to \mathcal{C}$ 的左伴随, 则 $G \circ F$ 是
$\mathcal{C}$ 上的一个单子, 单位是
$\mathrm{Id}_{\mathcal{C}} \xrightarrow{\eta} G \circ F$, 乘法是
$G \circ F \circ G \circ F \xrightarrow{\mathrm{Id}_G \circ \epsilon \circ \mathrm{Id}_F} G \circ F$.
反之, 若 $T$ 是 $\mathcal{C}$ 上的一个单子, 则 $T = G \circ F$, 其中
$G: \mathrm{LMod}_T(\mathcal{C}) \to \mathcal{C}$ 是遗忘函子, $F$ 是 $G$
的左伴随 $X \mapsto T(X)$.

称一对态射 $f, g: X \to Y$ 有可裂的余等化子, 若存在交换图表

设 $A$ 是幺半范畴 $\mathcal{C}$ 中的代数. 则左 $A$-模 $M$ 是
$\mathcal{C}$ 中图表
$A \otimes A \otimes M \rightrightarrows A \otimes M$ 的可裂的余等化子.

函子将可裂的余等化子映为可裂的余等化子.

$Z$ 是态射 $f, g: X \to Y$ 的余等化子.

设有态射 $r: Y \to W$ 使得 $r \circ f = r \circ g$. 则
$r \circ (s \circ h) = r \circ g \circ t = r \circ f \circ t = r$. 由于
$Z$ 是 $Y$ 的收缩核, $r$ 唯一地穿过 $Z$.

一个函子 $G: \mathcal{D} \to \mathcal{C}$ 是单子的, 当且仅当 $G$
满足下列条件:

1.  $G$ 有左伴随函子 $F: \mathcal{C} \to \mathcal{D}$.

2.  $G$ 是保守的.

3.  对任意 $\mathcal{D}$ 中的图表 $X \rightrightarrows Y$, 若它在
    $\mathcal{C}$ 中的像有可裂的余等化子, 则它在 $\mathcal{D}$
    中有余等化子, 并且 $G$ 保持这个余等化子.

必要性. 假设 $\mathcal{D} = \mathrm{LMod}_T(\mathcal{C})$, $G$
是遗忘函子, $T = G \circ F$, $F$ 是 $G$ 的左伴随 $X \mapsto T(X)$. 若
$\mathcal{D}$ 中的一对态射 $f, g: X \to Y$ 在 $\mathcal{C}$
中的像有可裂的余等化子 $Z$, 则根据注4.5.5, $T(Z)$ 是 $TG(f), TG(g)$
的可裂的余等化子. 诱导态射 $T(Z) \to Z$ 将 $Z$ 提升至 $\mathcal{D}$,
使得 $Z$ 是 $f, g$ 的余等化子.

充分性. 令 $T = G \circ F$. 则 $G$ 是函子
$G': \mathcal{D} \to \mathrm{LMod}_T(\mathcal{C}), X \mapsto G(X)$
与遗忘函子的复合. 我们需要证明 $G'$ 是等价. 由于 $G$ 是保守的, 所以 $G'$
也是保守的. 所以我们只需证明 $G'$ 有左伴随
$F': \mathrm{LMod}_T(\mathcal{C}) \to \mathcal{D}$, 并且
$u: \mathrm{Id}_{\mathrm{LMod}_T(\mathcal{C})} \to G' \circ F'$ 是同构.

设 $M \in \mathrm{LMod}_T(\mathcal{C})$. 根据例4.5.4,
$T^2(M) \rightrightarrows T(M)$ 在 $\mathcal{C}$ 中有可裂的余等化子 $M$.
所以根据条件 (3), $FT(M) \rightrightarrows F(M)$ 有余等化子 $X$, 使得
$G(X) \cong M$. 令 $F'(M) = X$. 则自然同构 $u_M: G'F'(M) \cong M$
和自然态射 $v_X: F'G'(X) \to X$ 使得 $F'$ 是 $G'$ 的左伴随.

设 $G: \mathcal{A} \to \mathcal{B}$ 是 Abel 范畴间的正合函子.

1.  $G$ 是保守的, 当且仅当 $G$ 将非零对象映为非零对象.

2.  若 $G$ 是保守的, 则 $G$ 是忠实的, 并且 $G(f)$ 是满射 (单射) 当且仅当
    $f$ 也是.

<!-- -->

1.  充分性. 若 $G(f)$ 是同构, 则
    $\mathrm{Ker}\, G(f) = \mathrm{Coker}\, G(f) = 0$, 所以
    $\mathrm{Ker}\, f = \mathrm{Coker}\, f = 0$, 所以 $f$ 是同构.
    必要性. 若 $G(X) = 0$, 则 $G$ 将态射 $X \to 0$ 映为同构, 所以
    $X = 0$.

2.  若 $G(f) = 0$, 则 $\mathrm{Ker}\, G(f) = G(X)$,
    $\mathrm{Coker}\, G(f) = G(Y)$, 所以 $\mathrm{Ker}\, f = X$,
    $\mathrm{Coker}\, f = Y$, 所以 $f = 0$. 若 $G(f)$ 满, 则
    $\mathrm{Coker}\, G(f) = 0$, 所以根据 (1) 有
    $\mathrm{Coker}\, f = 0$, 所以 $f$ 满.

设 $\mathcal{C}$ 是刚性的幺半范畴, $\mathcal{M}$ 是一个左
$\mathcal{C}$-模, 其中 $\mathcal{C}$ 和 $\mathcal{M}$ 都是 Abel 范畴.
存在一个 $A \in \mathrm{Alg}(\mathcal{C})$ 及左 $\mathcal{C}$-模等价
$\mathcal{M} \simeq \mathcal{C}_A$ 的充分必要条件是:

1.  $\mathcal{M}$ enrich 于 $\mathcal{C}$ 中;

2.  存在一个对象 $P \in \mathcal{M}$ 使得
    $[P,-]: \mathcal{M} \to \mathcal{C}$ 保守且右正合.

此时有左 $\mathcal{C}$-模等价
$\mathcal{M} \simeq \mathcal{C}_{[P,P]}, M \mapsto [P,M]$.

必要性. 假设 $\mathcal{M} = \mathcal{C}_A$. (1) 由命题4.3.8立得. (2) 取
$P = A$. 则 $[A,-]: \mathcal{C}_A \to \mathcal{C}$ 是遗忘函子.

充分性. 函子 $F = - \otimes P: \mathcal{C} \to \mathcal{M}$ 是
$G = [P,-]$ 的左伴随. 函子
$F' = - \otimes [P,P]: \mathcal{C} \to \mathcal{C}_{[P,P]}$ 是遗忘函子
$G'$ 的左伴随. 根据 Barr-Beck 定理, 函子 $G$ 和 $G'$ 是单子的.
根据命题4.3.5, 我们有
$G \circ F = [P,- \otimes P] \cong - \otimes [P,P] = G' \circ F'$, 所以
$\mathcal{M} \simeq \mathcal{C}_{[P,P]}$.