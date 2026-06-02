---
title: "Category Theory 融合范畴"
date: 2026-01-25
categories: [algebra, category-theory]
tags: [fusion-category, monoidal-category, rigid-category]
use_math: true
---

# 融合范畴
========

设 $k$ 是一个特征零的代数闭域. 令 $\mathrm{Vec}$ 为有限维 $k$
线性空间组成的范畴.

融合范畴
--------

一个 $k$ 线性范畴是一个加法范畴 $\mathcal{C}$, 对任意
$X,Y \in \mathcal{C}$, Abel 群 $\mathrm{Hom}_{\mathcal{C}}(X,Y)$
赋予了一个 $k$ 线性空间结构, 使得态射复合是 $k$ 双线性的. 设
$\mathcal{C}, \mathcal{D}$ 是 $k$ 线性范畴. 一个 $k$ 线性函子
$F: \mathcal{C} \to \mathcal{D}$ 是一个加法函子, 使得映射
$\mathrm{Hom}_{\mathcal{C}}(X,Y) \to \mathrm{Hom}_{\mathcal{D}}(F(X), F(Y))$
是 $k$ 线性映射. 设 $\mathcal{C}, \mathcal{D}, \mathcal{E}$ 是 $k$
线性范畴. 一个 $k$ 双线性函子
$F: \mathcal{C} \times \mathcal{D} \to \mathcal{E}$ 是一个函子, 使得 $F$
对于每个变量是一个加法函子, 并且在态射上是 $k$ 双线性的.

一个 $k$ 线性幺半范畴是一个幺半范畴 $\mathcal{C}$, 范畴 $\mathcal{C}$
上有一个 $k$ 线性结构, 使得张量积函子
$\otimes: \mathcal{C} \times \mathcal{C} \to \mathcal{C}$ 是 $k$
双线性的.

设 $\mathcal{C}$ 是一个 $k$ 线性幺半范畴. 一个 $k$ 线性左 $\mathcal{C}$
模是一个左 $\mathcal{C}$ 模 $\mathcal{M}$, 范畴 $\mathcal{M}$ 有一个 $k$
线性结构, 使得函子
$\otimes: \mathcal{C} \times \mathcal{M} \to \mathcal{M}$ 是 $k$
双线性的. 类似地可定义 $k$ 线性右模和 $k$ 线性双模.

除非做特别说明, 我们假设 $k$ 线性范畴间的函子都是 $k$ 线性的, 并且对于
$k$ 线性范畴 $\mathcal{C}$ 和 $\mathcal{D}$, 用记号
$\mathrm{Fun}(\mathcal{C}, \mathcal{D})$ 表示 $k$ 线性函子组成的范畴.
对于 $k$ 线性范畴 $\mathcal{C}$ 及 $k$ 线性左模 $\mathcal{M}$ 和
$\mathcal{N}$, 我们用记号
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N})$ 表示 $k$ 线性左
$\mathcal{C}$ 模函子组成的范畴.

若 $\mathcal{C}, \mathcal{D}$ 是 $k$ 线性范畴, 则
$\mathcal{C}^{\mathrm{op}}, \mathcal{C} \oplus \mathcal{D}$ 与
$\mathrm{Fun}(\mathcal{C}, \mathcal{D})$ 亦然. 并且对于 $k$ 线性范畴
$\mathcal{E}$, 有
$\mathrm{Fun}(\mathcal{C} \oplus \mathcal{D}, \mathcal{E}) \simeq \mathrm{Fun}(\mathcal{C}, \mathcal{E}) \oplus \mathrm{Fun}(\mathcal{D}, \mathcal{E})$
以及
$\mathrm{Fun}(\mathcal{E}, \mathcal{C} \oplus \mathcal{D}) \simeq \mathrm{Fun}(\mathcal{E}, \mathcal{C}) \oplus \mathrm{Fun}(\mathcal{E}, \mathcal{D})$.

一个 $k$ 线性范畴 $\mathcal{C}$ 称为半单的, 如果它 $k$ 线性等价于有限个
$\mathrm{Vec}$ 的直和.

一个 $k$ 线性范畴 $\mathcal{C}$ 是半单的, 当且仅当它满足下列条件:

1.  $\mathcal{C}$ 是半单的 Abel 范畴.

2.  $\mathcal{C}$ 有有限个单对象.

3.  对任意 $X,Y \in \mathcal{C}$, $\mathrm{Hom}_{\mathcal{C}}(X,Y)$
    是有限维 $k$ 线性空间.

只需证充分性. 设 $\mathcal{C}$ 有 $n$ 个单对象. 有 $k$ 线性函子
$F: \mathrm{Vec}^{\oplus n} \to \mathcal{C}$,
将不同的单对象映为不同的单对象. 根据 (3), 对于每个单对象
$X \in \mathcal{C}$ 有 $\mathrm{Hom}_{\mathcal{C}}(X,X) = k$. 若单对象
$X,Y$ 不同构, 则 $\mathrm{Hom}_{\mathcal{C}}(X,Y) = 0$. 所以 $F$
是完全忠实的. 根据 (1) 和 (3), $\mathcal{C}$
的每个对象都是有限个单对象的直和, 所以 $F$ 本质满. 所以 $F$ 是等价.

每个 $k$ 线性范畴都可视为一个 $k$ 线性 $\mathrm{Vec}$ 模, 并且每个 $k$
线性函子可唯一地提升为一个 $k$ 线性 $\mathrm{Vec}$ 模函子. 特别地,
我们有 $\mathrm{Fun}(\mathrm{Vec}, \mathrm{Vec}) \simeq \mathrm{Vec}$.
所以半单 $k$ 线性范畴间的 $k$ 线性函子都是正合的, 并且有左右伴随.
特别地, 若 $\mathcal{C}$ 是半单 $k$ 线性范畴, 则每个 $k$ 线性函子
$F: \mathcal{C}^{\mathrm{op}} \to \mathrm{Vec}$ 都可表示.

一个多重融合范畴是一个刚性的 $k$ 线性幺半范畴 $\mathcal{C}$, 其中
$\mathcal{C}$ 是半单的 $k$ 线性范畴. 如果 $\mathcal{C}$
的单位对象是一个单对象, 则称 $\mathcal{C}$ 是一个融合范畴.

若 $G$ 是一个有限群, 则 $\mathrm{Vec}_G$ 是一个融合范畴,
$\mathrm{Rep}\, G$ 是一个对称融合范畴. 更一般地, 如果 $H$ 是一个半单
Hopf 代数, 则 $\mathrm{Rep}\, H$ 是一个融合范畴.

设 $\mathcal{C}$ 是一个多重融合范畴. 一个半单左 $\mathcal{C}$ 模是一个
$k$ 线性左 $\mathcal{C}$ 模 $\mathcal{M}$, 其中 $\mathcal{M}$ 是半单 $k$
线性范畴. 类似地可定义半单右模和半单双模.

1.  若 $\mathcal{M}$ 是多重融合范畴 $\mathcal{C}$ 的半单左模, 则
    $\mathcal{M}$ enrich 于 $\mathcal{C}$ 中, 因为对于每个
    $M \in \mathcal{M}$, 函子 $- \otimes M: \mathcal{C} \to \mathcal{M}$
    都有右伴随.

2.  若 $\mathcal{M}, \mathcal{N}$ 是半单 $k$ 线性范畴, 则
    $\mathrm{Fun}(\mathcal{M}, \mathcal{M})$ 是多重融合范畴, 并且
    $\mathrm{Fun}(\mathcal{M}, \mathcal{N})$ 是一个半单右
    $\mathrm{Fun}(\mathcal{M}, \mathcal{M})$ 模.

3.  设 $\mathcal{C}, \mathcal{D}$ 是多重融合范畴. 给一个半单左
    $\mathcal{C}$ 模, 等价于给一个半单 $k$ 线性范畴 $\mathcal{M}$ 和一个
    $k$ 线性幺半函子
    $\mathcal{C} \to \mathrm{Fun}(\mathcal{M}, \mathcal{M})$. 给一个半单
    $\mathcal{C}$-$\mathcal{D}$ 双模, 等价于给一个半单 $k$ 线性范畴
    $\mathcal{M}$ 和一个 $k$ 双线性幺半函子
    $\mathcal{C} \times \mathcal{D}^{\mathrm{rev}} \to \mathrm{Fun}(\mathcal{M}, \mathcal{M})$.

设 $\mathcal{C}$ 是多重融合范畴, $\mathcal{M}$ 是半单左 $\mathcal{C}$
模. 则存在代数 $A \in \mathrm{Alg}(\mathcal{C})$ 和 $k$ 线性左
$\mathcal{C}$ 模等价 $\mathcal{M} \simeq \mathcal{C}_A$.

令 $P$ 是 $\mathcal{M}$ 的所有单对象的直和. 因为
$\mathrm{Hom}_{\mathcal{C}}(\mathbf{1}, [P,-]) \simeq \mathrm{Hom}_{\mathcal{M}}(P,-)$
保守, 所以 $[P,-]$ 保守. 应用定理
[\[thm:4.5.9\]](#thm:4.5.9){reference-type="ref" reference="thm:4.5.9"}
得 $\mathcal{M} \simeq \mathcal{C}_{[P,P]}$.

设 $\mathcal{C}$ 是多重融合范畴, $\mathcal{M}$ 和 $\mathcal{N}$ 是半单左
$\mathcal{C}$ 模. 假设 $\mathcal{M} = \mathcal{C}_A$. 则
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N}) \simeq {}_A\mathcal{N}$.

函子
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N}) \to {}_A\mathcal{N}$,
$F \mapsto F(A)$ 与函子
${}_A\mathcal{N} \to \mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N})$,
$V \mapsto - \otimes_A V$ 互逆.

设 $\mathcal{C}$ 是多重融合范畴, $\mathcal{M}, \mathcal{N}$ 是半单左
$\mathcal{C}$ 模. 则
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N})$ 是半单的. 特别地,
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{M})$ 是多重融合范畴.

可分代数
========

设 $\mathcal{C}$ 是多重融合范畴. 一个代数
$A \in \mathrm{Alg}(\mathcal{C})$ 是可分的, 如果存在 $A$-$A$ 双模同态
$\iota: A \to A \otimes A$ 使得 $m \circ \iota = \mathrm{Id}_A$.

设 $\mathcal{C}$ 是多重融合范畴, $A \in \mathrm{Alg}(\mathcal{C})$ 可分.
对任意半单左 $\mathcal{C}$ 模 $\mathcal{M}$, ${}_A\mathcal{M}$ 是半单
$k$ 线性范畴. 对任意半单右 $\mathcal{C}$ 模 $\mathcal{N}$,
$\mathcal{N}_A$ 是半单 $k$ 线性范畴.

对于 $M \in \mathcal{M}$,
$\mathrm{Hom}_{{}_A\mathcal{M}}(A \otimes M, -) \cong \mathrm{Hom}_{\mathcal{M}}(M, -)$
正合, 因此自由模 $A \otimes M$ 是投射的. 对于 $V \in {}_A\mathcal{M}$,
左 $A$ 模同态
$V \cong A \otimes_A V \xrightarrow{\iota \otimes_A \mathrm{Id}_V} (A \otimes A) \otimes_A V \cong A \otimes V$
使得 $V$ 是 $A \otimes V$ 的直和项, 所以 $V$ 是投射的. 这证明了
${}_A\mathcal{M}$ 是半单的 Abel 范畴.

令 $S$ 是 $\mathcal{M}$ 的所有单对象的直和. 则任意单对象
$V \in {}_A\mathcal{M}$,
$\mathrm{Hom}_{{}_A\mathcal{M}}(A \otimes S, V) \cong \mathrm{Hom}_{\mathcal{M}}(S, V)$
非零, 所以 $V$ 是 $A \otimes S$ 的直和项. 这证明了 ${}_A\mathcal{M}$
只有有限个单对象. 根据命题
[\[prop:5.1.6\]](#prop:5.1.6){reference-type="ref"
reference="prop:5.1.6"}, 命题得证.

设 $\mathcal{C}$ 是多重融合范畴. 代数 $A \in \mathrm{Alg}(\mathcal{C})$
是可分的, 当且仅当 $\mathcal{C}_A$ 是半单 $k$ 线性范畴.

必要性由上述命题立得. 充分性. 令 $\mathcal{M} = \mathcal{C}_A$. 根据事实
[\[fact:5.1.14\]](#fact:5.1.14){reference-type="ref"
reference="fact:5.1.14"},
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{M})$ 是半单的.
所以由命题 [\[prop:5.1.13\]](#prop:5.1.13){reference-type="ref"
reference="prop:5.1.13"}, ${}_A\mathcal{C}_A$ 是半单的. 所以 $A$ 可分.

模的张量积
==========

设 $\mathcal{C}$ 是多重融合范畴, $\mathcal{M}$ 是一个半单右
$\mathcal{C}$ 模, $\mathcal{N}$ 是一个半单左 $\mathcal{C}$ 模,
$\mathcal{P}$ 是一个半单 $k$ 线性范畴. 一个 $\mathcal{C}$
双线性函子或平衡 $\mathcal{C}$ 模函子是一个 $k$ 双线性函子
$F: \mathcal{M} \times \mathcal{N} \to \mathcal{P}$ 及一个自然同构
$F(M \otimes X, N) \cong F(M, X \otimes N)$ 使得下列图表交换:
$$\begin{tikzcd}
& F(M, N) & \
F(M \otimes \mathbf{1}, N) \arrow[ru, "\sim"] \arrow[rr, "\sim"] & & F(M, \mathbf{1} \otimes N), \arrow[lu, "\sim"]
\end{tikzcd}$$ $$\begin{tikzcd}
& F(M \otimes X, Y \otimes N) & \
F(M \otimes X \otimes Y, N) \arrow[ru, "\sim"] \arrow[rr, "\sim"] & & F(M, X \otimes Y \otimes N). \arrow[lu, "\sim"]
\end{tikzcd}$$ $\mathcal{C}$ 双线性函子间的一个自然变换 $\xi: F \to G$
是 $\mathcal{C}$ 双线性的, 如果下列图表交换: $$\begin{tikzcd}
F(M \otimes X, N) \arrow[r, "\sim"] \arrow[d, "\xi_{M \otimes X, N}"'] & F(M, X \otimes N) \arrow[d, "\xi_{M, X \otimes N}"] \
G(M \otimes X, N) \arrow[r, "\sim"] & G(M, X \otimes N).
\end{tikzcd}$$ 我们以
$\mathrm{Fun}_{\mathcal{C}}^{bi}(\mathcal{M} \times \mathcal{N}, \mathcal{P})$
表示 $\mathcal{C}$ 双线性函子和 $\mathcal{C}$ 双线性自然变换组成的范畴.

$\mathcal{M}$ 与 $\mathcal{N}$ 在 $\mathcal{C}$ 上的张量积是一个半单 $k$
线性范畴 $\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$, 及一个
$\mathcal{C}$ 双线性函子
$\boxtimes_{\mathcal{C}}: \mathcal{M} \times \mathcal{N} \to \mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$,
使得对任意半单 $k$ 线性范畴 $\mathcal{P}$, 与 $\boxtimes_{\mathcal{C}}$
复合诱导范畴等价
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}, \mathcal{P}) \simeq \mathrm{Fun}_{\mathcal{C}}^{bi}(\mathcal{M} \times \mathcal{N}, \mathcal{P})$.

对于半单 $k$ 线性范畴 $\mathcal{M}, \mathcal{N}$, 我们将
$\mathcal{M} \boxtimes_{\mathrm{Vec}} \mathcal{N}$ 简记为
$\mathcal{M} \boxtimes \mathcal{N}$, 称为 $\mathcal{M}$ 与 $\mathcal{N}$
的 Deligne 张量积. 一个 $k$ 双线性函子
$\mathcal{M} \times \mathcal{N} \to \mathcal{P}$ 自动是一个
$\mathrm{Vec}$ 双线性函子. 所以给一个 $k$ 双线性函子
$\mathcal{M} \times \mathcal{N} \to \mathcal{P}$ 等价于给一个 $k$
线性函子 $\mathcal{M} \boxtimes \mathcal{N} \to \mathcal{P}$.

因为
$\mathrm{Fun}_{\mathcal{C}}^{bi}(\mathcal{M} \times \mathcal{N}, \mathcal{P}) \simeq \mathrm{Fun}_{\mathcal{C}}(\mathcal{N}, \mathrm{Fun}(\mathcal{M}, \mathcal{P})) \simeq \mathrm{Fun}_{\mathcal{C}^{\mathrm{rev}}}(\mathcal{M}, \mathrm{Fun}(\mathcal{N}, \mathcal{P}))$,
所以有典范等价:

1.  $\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{C} \simeq \mathcal{M}$,
    $\mathcal{C} \boxtimes_{\mathcal{C}} \mathcal{N} \simeq \mathcal{N}$.

2.  $(\mathcal{M} \oplus \mathcal{M}') \boxtimes_{\mathcal{C}} \mathcal{N} \simeq (\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}) \oplus (\mathcal{M}' \boxtimes_{\mathcal{C}} \mathcal{N})$,
    $\mathcal{M} \boxtimes_{\mathcal{C}} (\mathcal{N} \oplus \mathcal{N}') \simeq (\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}) \oplus (\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}')$.

3.  $(\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}) \boxtimes_{\mathcal{D}} \mathcal{P} \simeq \mathcal{M} \boxtimes_{\mathcal{C}} (\mathcal{N} \boxtimes_{\mathcal{D}} \mathcal{P})$.

设 $\mathcal{C}$ 是多重融合范畴, $\mathcal{M} = {}_A\mathcal{C}$,
$\mathcal{N} = \mathcal{C}_B$, 其中 $A,B$ 是 $\mathcal{C}$ 中的可分代数.
则 $\mathcal{C}$ 双线性函子
$\phi: \mathcal{M} \times \mathcal{N} \to {}_A\mathcal{C}_B$,
$(M,N) \mapsto M \otimes N$ 使得 ${}_A\mathcal{C}_B$ 实现张量积
$\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$.

设 $F: \mathcal{M} \times \mathcal{N} \to \mathcal{P}$ 是一个
$\mathcal{C}$ 双线性函子, 其中 $\mathcal{P}$ 是一个半单 $k$ 线性范畴. 设
$V \in {}_A\mathcal{C}_B$. 我们有余等化子图表
$V \otimes B \otimes B \rightrightarrows V \otimes B \to V$. 令
$\widetilde{F}(V)$ 是图表 $F(V \otimes B, B) \rightrightarrows F(V, B)$
的余等化子, 从而得到一个 $k$ 线性函子
$\widetilde{F}: {}_A\mathcal{C}_B \to \mathcal{P}$. 这给出一个函子
$\mathrm{Fun}_{\mathcal{C}}^{bi}(\mathcal{M} \times \mathcal{N}, \mathcal{P}) \to \mathrm{Fun}_{\mathcal{C}}({}_A\mathcal{C}_B, \mathcal{P})$,
$F \mapsto \widetilde{F}$.

由于 $\widetilde{F}(M \otimes N)$ 是图表
$F(M, N \otimes B \otimes B) \rightrightarrows F(M, N \otimes B)$
的余等化子, 所以同构于 $F(M, N)$, 从而
$\widetilde{F} \circ \phi \simeq F$. 反之对于 $k$ 线性函子
$G: {}_A\mathcal{C}_B \to \mathcal{P}$, 有
$\widetilde{G \circ \phi} \simeq G$. 所以函子 $F \mapsto \widetilde{F}$
是等价.

在定理 [\[thm:5.3.4\]](#thm:5.3.4){reference-type="ref"
reference="thm:5.3.4"} 中, 令 $\mathcal{M}' = \mathcal{C}_A$. 则
$\mathcal{C}$ 双线性函子
$\mathcal{M} \times \mathcal{N} \to \mathrm{Fun}_{\mathcal{C}}(\mathcal{M}', \mathcal{N})$,
$(M,N) \mapsto - \otimes_A M \otimes N$ 使得
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}', \mathcal{N})$ 实现张量积
$\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$.

因为每个 $A$-$B$ 双模 $V$ 都是 $V \otimes B$ 的商, 所以
$\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$ 的每个对象都是形如
$M \boxtimes_{\mathcal{C}} N$ 的对象的商.

设 $\mathcal{C}$ 是刚性的幺半范畴. 若 $\mathcal{M}$ 是一个左
$\mathcal{C}$ 模, 则函子
$\mathcal{M}^{\mathrm{op}} \times \mathcal{C} \to \mathcal{M}^{\mathrm{op}}$,
$(M,X) \mapsto X^L \otimes M$ 使得 $\mathcal{M}^{\mathrm{op}}$
成为一个右 $\mathcal{C}$ 模, 我们将其记作 $\mathcal{M}^{\mathrm{op}|L}$;
函子
$\mathcal{M}^{\mathrm{op}} \times \mathcal{C} \to \mathcal{M}^{\mathrm{op}}$,
$(M,X) \mapsto X^R \otimes M$ 也使得 $\mathcal{M}^{\mathrm{op}}$
成为一个右 $\mathcal{C}$ 模, 我们将其记作 $\mathcal{M}^{\mathrm{op}|R}$.
类似地, 若 $\mathcal{N}$ 是一个右 $\mathcal{C}$ 模, 则函子
$\mathcal{C} \times \mathcal{N}^{\mathrm{op}} \to \mathcal{N}^{\mathrm{op}}$,
$(X,N) \mapsto N \otimes X^L$ 使得 $\mathcal{N}^{\mathrm{op}}$
成为一个左 $\mathcal{C}$ 模, 我们将其记作 $\mathcal{N}^{L|\mathrm{op}}$;
函子
$\mathcal{C} \times \mathcal{N}^{\mathrm{op}} \to \mathcal{N}^{\mathrm{op}}$,
$(X,N) \mapsto N \otimes X^R$ 也使得 $\mathcal{N}^{\mathrm{op}}$
成为一个左 $\mathcal{C}$ 模, 我们将其记作 $\mathcal{N}^{R|\mathrm{op}}$.

设 $\mathcal{C}$ 是多重融合范畴, $\mathcal{M}, \mathcal{N}$ 是半单左
$\mathcal{C}$ 模.

1.  有 $k$ 线性等价
    $\mathcal{M}^{\mathrm{op}|L} \boxtimes_{\mathcal{C}} \mathcal{N} \simeq \mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N})$,
    $M \boxtimes_{\mathcal{C}} N \mapsto [-,M]^R \otimes N$.

2.  有 $k$ 线性等价
    $\mathcal{M}^{\mathrm{op}|R} \boxtimes_{\mathcal{C}} \mathcal{N} \simeq (\mathcal{N}^{\mathrm{op}|L} \boxtimes_{\mathcal{C}} \mathcal{M})^{\mathrm{op}}$,
    $M \boxtimes_{\mathcal{C}} N \mapsto N \boxtimes_{\mathcal{C}} M$.

设 $\mathcal{M} = \mathcal{C}_A$, $\mathcal{N} = \mathcal{C}_B$.

1.  有 $\mathcal{M}^{\mathrm{op}|L} \simeq {}_A\mathcal{C}$,
    $M \mapsto M^R$, 以及
    $$\mathcal{M}^{\mathrm{op}|L} \boxtimes_{\mathcal{C}} \mathcal{N} \simeq {}_A\mathcal{C}_B \simeq \mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N})$$
    $$M \boxtimes_{\mathcal{C}} N \mapsto M^R \otimes N \mapsto - \otimes_A M^R \otimes N \simeq [-,M]^R \otimes N.$$

2.  有 $\mathcal{M}^{\mathrm{op}|R} \simeq {}_{AL}\mathcal{C}$,
    $M \mapsto M^L$, 以及
    $$\mathcal{M}^{\mathrm{op}|R} \boxtimes_{\mathcal{C}} \mathcal{N} \simeq {}_{AL}\mathcal{C}_B \simeq ({}_B\mathcal{C}_A)^{\mathrm{op}} \simeq (\mathcal{N}^{\mathrm{op}|L} \boxtimes_{\mathcal{C}} \mathcal{M})^{\mathrm{op}}$$
    $$M \boxtimes_{\mathcal{C}} N \mapsto M^L \otimes N \mapsto N^R \otimes M \mapsto N \boxtimes_{\mathcal{C}} M.$$

设 $\mathcal{C}$ 和 $\mathcal{D}$ 是多重融合范畴, $\mathcal{M}$
是一个半单左 $\mathcal{C}$ 模, $\mathcal{N}$ 是一个半单
$\mathcal{C}$-$\mathcal{D}$ 双模, $\mathcal{P}$ 是一个半单左
$\mathcal{D}$ 模. 有范畴等价
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N}) \boxtimes_{\mathcal{D}} \mathcal{P} \simeq \mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N} \boxtimes_{\mathcal{D}} \mathcal{P})$,
$F \boxtimes_{\mathcal{D}} P \mapsto F(-) \boxtimes_{\mathcal{D}} P$.

根据推论 [\[cor:5.3.8\]](#cor:5.3.8){reference-type="ref"
reference="cor:5.3.8"}(1), 有范畴等价
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N}) \boxtimes_{\mathcal{D}} \mathcal{P} \simeq \mathcal{M}^{\mathrm{op}|L} \boxtimes_{\mathcal{C}} \mathcal{N} \boxtimes_{\mathcal{D}} \mathcal{P} \simeq \mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N} \boxtimes_{\mathcal{D}} \mathcal{P})$,
$([- , M]^R \otimes N) \boxtimes_{\mathcal{D}} P \mapsto M \boxtimes_{\mathcal{C}} N \boxtimes_{\mathcal{D}} P \mapsto [-, M]^R \otimes (N \boxtimes_{\mathcal{D}} P)$.

设 $\mathcal{C}$ 和 $\mathcal{C}'$ 是多重融合范畴.

1.  若 $A,B \in \mathrm{Alg}(\mathcal{C})$ 和
    $A',B' \in \mathrm{Alg}(\mathcal{C}')$ 是可分代数, 则有 $k$ 线性等价
    $${}_A\mathcal{C}_B \boxtimes {}_{A'}\mathcal{C}'_{B'} \simeq {}_{A \boxtimes A'}(\mathcal{C} \boxtimes \mathcal{C}')_{B \boxtimes B'}, \quad M \boxtimes M' \mapsto M \boxtimes M'.$$

2.  若 $\mathcal{M}$ 是半单右 $\mathcal{C}$ 模, $\mathcal{M}'$ 是半单右
    $\mathcal{C}'$ 模, $\mathcal{N}$ 是半单左 $\mathcal{C}$ 模,
    $\mathcal{N}'$ 是半单左 $\mathcal{C}'$ 模, 则有 $k$ 线性等价
    $$(\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}) \boxtimes (\mathcal{M}' \boxtimes_{\mathcal{C}'} \mathcal{N}') \simeq (\mathcal{M} \boxtimes \mathcal{M}') \boxtimes_{\mathcal{C} \boxtimes \mathcal{C}'} (\mathcal{N} \boxtimes \mathcal{N}'),$$
    $$(\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}) \boxtimes (\mathcal{M}' \boxtimes_{\mathcal{C}'} \mathcal{N}') \mapsto (\mathcal{M} \boxtimes \mathcal{M}') \boxtimes_{\mathcal{C} \boxtimes \mathcal{C}'} (\mathcal{N} \boxtimes \mathcal{N}').$$

3.  若 $\mathcal{M}, \mathcal{N}$ 是半单左 $\mathcal{C}$ 模,
    $\mathcal{M}' \mathcal{N}'$ 是半单左 $\mathcal{C}'$ 模, 则有 $k$
    线性等价
    $$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{N}) \boxtimes \mathrm{Fun}_{\mathcal{C}'}(\mathcal{M}', \mathcal{N}') \simeq \mathrm{Fun}_{\mathcal{C} \boxtimes \mathcal{C}'}(\mathcal{M} \boxtimes \mathcal{M}', \mathcal{N} \boxtimes \mathcal{M}'),$$
    $$F \boxtimes F' \mapsto F \boxtimes F'.$$

<!-- -->

1.  令
    $G: {}_{A \boxtimes A'}(\mathcal{C} \boxtimes \mathcal{C}')_{B \boxtimes B'} \to \mathcal{C} \boxtimes \mathcal{C}'$
    和
    $G: {}_A\mathcal{C}_B \boxtimes {}_{A'}\mathcal{C}'_{B'} \to \mathcal{C} \boxtimes \mathcal{C}'$
    为遗忘函子, $F,F'$ 是它们的左伴随. 由单子同构
    $G \circ F \simeq G' \circ F'$, 结论得证.

2.  结合 (1) 和定理 [\[thm:5.3.4\]](#thm:5.3.4){reference-type="ref"
    reference="thm:5.3.4"}.

3.  结合 (1) 和命题 [\[prop:5.1.13\]](#prop:5.1.13){reference-type="ref"
    reference="prop:5.1.13"}.

设 $\mathcal{C}$ 和 $\mathcal{D}$ 是多重融合范畴. 则
$\mathfrak{Z}(\mathcal{C} \boxtimes \mathcal{D}) \simeq \mathfrak{Z}(\mathcal{C}) \boxtimes \mathfrak{Z}(\mathcal{D})$.

多重融合范畴的张量积
====================

一个幺半范畴 $\mathcal{C}$ 是刚性的, 当且仅当它满足下列条件:

1.  $\mathcal{C}$ enrich 于自身, 并且函子
    $[-,\mathbf{1}]: \mathcal{C}^{\mathrm{op}} \to \mathcal{C}$
    是范畴等价.

2.  对所有 $X,Y \in \mathcal{C}$, 典范态射
    $Y \otimes [X,\mathbf{1}] \to [X,Y]$ 是同构.

必要性. (1) $[X,Y] = Y \otimes X^L$. 特别地, $[X,\mathbf{1}] = X^L$. (2)
由命题 [\[prop:4.3.5\]](#prop:4.3.5){reference-type="ref"
reference="prop:4.3.5"} 立得.

充分性. 态射 $u: \mathbf{1} \to [X,X] \cong X \otimes [X,\mathbf{1}]$,
及 $v: [X,\mathbf{1}] \otimes X \to \mathbf{1}$ 使得 $[X,\mathbf{1}]$ 是
$X$ 的左对偶. 又因为 $[-,\mathbf{1}]$ 是等价, $\mathcal{C}$
的对象有右对偶.

设 $\mathcal{C}$ 是辫多重融合范畴, $\mathcal{M}$ 是 $\bar{\mathcal{C}}$
上的多重融合范畴, $\mathcal{N}$ 是 $\mathcal{C}$ 上的多重融合范畴.
$\mathcal{C} \boxtimes \mathcal{C}$ 双线性函子
$(\mathcal{M} \boxtimes \mathcal{M}) \times (\mathcal{N} \boxtimes \mathcal{N}) \to \mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$,
$(M \boxtimes M', N \boxtimes N') \mapsto (M \otimes M') \boxtimes_{\mathcal{C}} (N \otimes N')$
决定了一个函子
$(\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}) \boxtimes (\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}) \to \mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$,
使得 $\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$ 成为一个幺半范畴.
它的单位对象为
$\mathbf{1}_{\mathcal{M}} \boxtimes_{\mathcal{C}} \mathbf{1}_{\mathcal{N}}$,
张量积为
$(M \boxtimes_{\mathcal{C}} N) \otimes (M' \boxtimes_{\mathcal{C}} N') = (M \otimes M') \boxtimes_{\mathcal{C}} (N \otimes N')$.
若 $\mathcal{C}$ 是对称多重融合范畴, $\mathcal{M}$ 和 $\mathcal{N}$ 是
$\mathcal{C}$ 上的辫多重融合范畴, 则 $\mathcal{M}$ 和 $\mathcal{N}$
辫结构诱导了 $\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$
的一个辫结构.

设 $\mathcal{C}$ 是辫多重融合范畴, $\mathcal{M}$ 是 $\bar{\mathcal{C}}$
上的多重融合范畴, $\mathcal{N}$ 是 $\mathcal{C}$ 上的多重融合范畴. 则
$\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$ 是多重融合范畴.

我们需要证明 $\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$ 是刚性的.
为此我们需要验证上述命题的两个条件. 易见
$M^L \boxtimes_{\mathcal{C}} N^L$ 是 $M \boxtimes_{\mathcal{C}} N$
的左对偶. 因此
$[M \boxtimes_{\mathcal{C}} N, \mathbf{1}] = M^L \boxtimes_{\mathcal{C}} N^L$.
有范畴等价
$\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N} \simeq \mathcal{N}^{\mathrm{op}|L} \boxtimes_{\mathcal{C}} \mathcal{M}^{L|\mathrm{op}} \simeq (\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N})^{\mathrm{op}}$,
$M \boxtimes_{\mathcal{C}} N \mapsto N^L \boxtimes_{\mathcal{C}} M^L \mapsto M^L \boxtimes_{\mathcal{C}} N^L$.
因此 $[-,\mathbf{1}]$ 是等价.

根据命题 [\[prop:4.3.5\]](#prop:4.3.5){reference-type="ref"
reference="prop:4.3.5"}, 当 $Y$ 形如 $M \boxtimes_{\mathcal{C}} N$ 时,
典范态射 $Y \otimes [X,\mathbf{1}] \to [X,Y]$ 是同构. 又
$- \otimes [X,\mathbf{1}]$ 和 $[X,-]$ 都是正合函子,
因此该典范态射对于一般的 $Y$ 亦是同构.

设 $\mathcal{C}$ 是对称多重融合范畴, $\mathcal{M}$ 和 $\mathcal{N}$ 是
$\mathcal{C}$ 上的辫多重融合范畴. 则
$\mathcal{M} \boxtimes_{\mathcal{C}} \mathcal{N}$ 是辫多重融合范畴.

模的对偶
========

设 $\mathcal{C}$ 和 $\mathcal{D}$ 是多重融合范畴, $\mathcal{M}$
是一个半单 $\mathcal{C}$-$\mathcal{D}$ 双模, $\mathcal{N}$ 是一个半单
$\mathcal{D}$-$\mathcal{C}$ 双模. 称 $\mathcal{M}$ 是 $\mathcal{N}$
的左对偶, $\mathcal{N}$ 是 $\mathcal{M}$ 的右对偶, 若存在
$\mathcal{D}$-$\mathcal{D}$ 双模函子
$u: \mathcal{D} \to \mathcal{N} \boxtimes_{\mathcal{C}} \mathcal{M}$ 和
$\mathcal{C}$-$\mathcal{C}$ 双模函子
$v: \mathcal{M} \boxtimes_{\mathcal{D}} \mathcal{N} \to \mathcal{C}$,
使得下列复合双模函子都与恒同函子同构:
$$\mathcal{M} \simeq \mathcal{M} \boxtimes_{\mathcal{D}} \mathcal{D} \xrightarrow{\mathrm{Id}_{\mathcal{M}} \boxtimes_{\mathcal{D}} u} \mathcal{M} \boxtimes_{\mathcal{D}} \mathcal{N} \boxtimes_{\mathcal{C}} \mathcal{M} \xrightarrow{v \boxtimes_{\mathcal{C}} \mathrm{Id}_{\mathcal{M}}} \mathcal{C} \boxtimes_{\mathcal{C}} \mathcal{M} \simeq \mathcal{M},$$
$$\mathcal{N} \simeq \mathcal{D} \boxtimes_{\mathcal{D}} \mathcal{N} \xrightarrow{u \boxtimes_{\mathcal{D}} \mathrm{Id}_{\mathcal{N}}} \mathcal{N} \boxtimes_{\mathcal{C}} \mathcal{M} \boxtimes_{\mathcal{D}} \mathcal{N} \xrightarrow{\mathrm{Id}_{\mathcal{N}} \boxtimes_{\mathcal{C}} v} \mathcal{N} \boxtimes_{\mathcal{C}} \mathcal{C} \simeq \mathcal{N}.$$

一个半单双模的左(右)对偶在典范等价下唯一.

设 $\mathcal{C}$ 和 $\mathcal{D}$ 是多重融合范畴, $\mathcal{M}$
是一个半单 $\mathcal{C}$-$\mathcal{D}$ 双模. 则
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{C})$ 是 $\mathcal{M}$
的右对偶,
$\mathrm{Fun}_{\mathcal{D}^{\mathrm{rev}}}(\mathcal{M}, \mathcal{D})$ 是
$\mathcal{M}$ 的左对偶.

有双模范畴等价
$\mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{C}) \simeq \mathcal{M}^{L|\mathrm{op}|L}$
和
$\mathrm{Fun}_{\mathcal{D}^{\mathrm{rev}}}(\mathcal{M}, \mathcal{D}) \simeq \mathcal{M}^{R|\mathrm{op}|R}$.

设 $\mathcal{C}$ 和 $\mathcal{D}$ 是多重融合范畴, 称一个半单
$\mathcal{C}$-$\mathcal{D}$ 双模 $\mathcal{M}$ 是可逆的, 若存在一个半单
$\mathcal{D}$-$\mathcal{C}$ 双模 $\mathcal{N}$, 及
$\mathcal{C}$-$\mathcal{C}$ 双模等价
$\mathcal{M} \boxtimes_{\mathcal{D}} \mathcal{N} \simeq \mathcal{C}$ 和
$\mathcal{D}$-$\mathcal{D}$ 双模等价
$\mathcal{N} \boxtimes_{\mathcal{C}} \mathcal{N} \simeq \mathcal{D}$.
此时称 $\mathcal{C}$ 和 $\mathcal{D}$ 为 Morita 等价.

设 $\mathcal{C}$ 和 $\mathcal{D}$ 是多重融合范畴, $\mathcal{M}$
是一个可逆半单 $\mathcal{C}$-$\mathcal{D}$ 双模.

1.  典范幺半函子
    $\mathcal{C} \to \mathrm{Fun}_{\mathcal{D}^{\mathrm{rev}}}(\mathcal{M}, \mathcal{M})$
    和
    $\mathcal{D}^{\mathrm{rev}} \to \mathrm{Fun}_{\mathcal{C}}(\mathcal{M}, \mathcal{M})$
    是等价.

2.  典范幺半函子
    $\mathfrak{Z}(\mathcal{C}) \to \mathrm{Fun}_{\mathcal{C}|\mathcal{D}}(\mathcal{M}, \mathcal{M}) \leftarrow \mathfrak{Z}(\mathcal{D})$
    是等价.

3.  诱导的幺半等价
    $\mathfrak{Z}(\mathcal{C}) \simeq \mathfrak{Z}(\mathcal{D})$
    是辫幺半等价.

设半单 $\mathcal{D}$-$\mathcal{C}$ 双模 $\mathcal{N}$ 是 $\mathcal{M}$
的逆. 则幺半函子
$- \boxtimes_{\mathcal{C}} \mathcal{M}: \mathrm{Fun}_{\mathcal{C}^{\mathrm{rev}}}(\mathcal{C}, \mathcal{C}) \to \mathrm{Fun}_{\mathcal{D}^{\mathrm{rev}}}(\mathcal{C} \boxtimes_{\mathcal{C}} \mathcal{M}, \mathcal{C} \boxtimes_{\mathcal{C}} \mathcal{M}) \simeq \mathrm{Fun}_{\mathcal{D}^{\mathrm{rev}}}(\mathcal{M}, \mathcal{M})$
与
$- \boxtimes_{\mathcal{D}} \mathcal{N}: \mathrm{Fun}_{\mathcal{D}^{\mathrm{rev}}}(\mathcal{M}, \mathcal{M}) \to \mathrm{Fun}_{\mathcal{C}^{\mathrm{rev}}}(\mathcal{M} \boxtimes_{\mathcal{D}} \mathcal{N}, \mathcal{M} \boxtimes_{\mathcal{D}} \mathcal{N}) \simeq \mathrm{Fun}_{\mathcal{C}^{\mathrm{rev}}}(\mathcal{C}, \mathcal{C})$
互逆. 类似地, 幺半函子
$\mathrm{Fun}_{\mathcal{C}|\mathcal{C}}(\mathcal{C}, \mathcal{C}) \to \mathrm{Fun}_{\mathcal{C}|\mathcal{D}}(\mathcal{M}, \mathcal{M})$
是等价.

假设 $\mathfrak{Z}(\mathcal{C}) \simeq \mathfrak{Z}(\mathcal{D})$ 将
$X, X'$ 映为 $Y, Y'$. 则有交换图表: $$\begin{tikzcd}
X \otimes X' \otimes M \arrow[r, "\sim"] \arrow[d, "\beta_{X,X'} \otimes \mathrm{Id}_M"'] & X \otimes M \otimes Y' \arrow[r, "\sim"] \arrow[dr, "\sim"] & M \otimes Y' \otimes Y \arrow[r, "\mathrm{Id}_M \otimes \beta^{-1}_{Y,Y'}"] \arrow[d, "\mathrm{Id}_M \otimes \beta_{Y',Y}"] & M \otimes Y \otimes Y' \arrow[d, "\mathrm{Id}_M \otimes \beta_{Y,Y'}"] \
X' \otimes X \otimes M \arrow[r, "\sim"] & X' \otimes M \otimes Y \arrow[r, "\sim"] & M \otimes Y \otimes Y' \arrow[r, "\mathrm{Id}_M \otimes \beta^{-1}_{Y',Y}"] & M \otimes Y' \otimes Y.
\end{tikzcd}$$ 外层方块意味着
$\mathfrak{Z}(\mathcal{C}) \simeq \mathfrak{Z}(\mathcal{D})$ 保持辫结构.
这证明了 (3).

多重融合范畴的结构
==================

称一个非零多重融合范畴是不可分解的, 若它不是两个非零多重融合范畴的直和.

融合范畴是不可分解的, 因为单位对象是单的.

设 $\mathcal{C}$ 是一个不可分解的多重融合范畴,
$\mathbf{1} = e_1 \oplus \cdots \oplus e_n$ 是单对象分解. 令
$\mathcal{C}_{ij} = e_i \otimes \mathcal{C} \otimes e_j$.

1.  $e_i \otimes e_i \cong e_i \cong e_i^R$. 当 $i \ne j$ 时
    $e_i \otimes e_j = 0$. 从而
    $\mathcal{C} \simeq \bigoplus_{ij} \mathcal{C}_{ij}$.

2.  若 $X \in \mathcal{C}_{ij}$ 和 $Y \in \mathcal{C}_{jl}$ 非零, 则
    $X \otimes Y$ 非零.

3.  $\mathcal{C}_{ij} \ne 0$.

4.  $\mathcal{C}$ 的张量积诱导 $\mathcal{C}_{ii}$-$\mathcal{C}_{ll}$
    双模等价
    $\mathcal{C}_{ij} \boxtimes_{\mathcal{C}_{jj}} \mathcal{C}_{jl} \simeq \mathcal{C}_{il} \simeq \mathrm{Fun}_{\mathcal{C}_{jj}}(\mathcal{C}_{ji}, \mathcal{C}_{jl})$.

5.  $\mathcal{C}_{ij}$ 是可逆的 $\mathcal{C}_{ii}$-$\mathcal{C}_{jj}$
    双模.

6.  $\mathcal{C}_{ii}$-$\mathcal{C}$ 双模 $\bigoplus_j \mathcal{C}_{ij}$
    与 $\mathcal{C}$-$\mathcal{C}_{ii}$ 双模
    $\bigoplus_j \mathcal{C}_{ji}$ 互逆.

7.  $\mathfrak{Z}(\mathcal{C}) \simeq \mathfrak{Z}(\mathcal{C}_{ii})$.

<!-- -->

1.  对偶态射 $\mathbf{1} \to e_i^R \otimes e_i$ 非零, 因此
    $e_i^R \otimes e_i$ 非零. 因此
    $e_i^R \otimes e_i \hookrightarrow \mathbf{1} \otimes e_i \cong e_i$
    和
    $e_i^R \otimes e_i \hookrightarrow e_i^R \otimes \mathbf{1} \cong e_i^R$
    都是同构. 所以 $e_i \otimes e_i \cong e_i \cong e_i^R$. 因为
    $e_i \otimes \mathbf{1} \cong e_i$ 单, 所以当 $i \ne j$ 时
    $e_i \otimes e_j = 0$.

2.  $\mathrm{Hom}_{\mathcal{C}}(X \otimes Y, X \otimes Y) \cong \mathrm{Hom}_{\mathcal{C}}(X \otimes Y, X \otimes Y)$
    包含 $\mathrm{Hom}_{\mathcal{C}}(X, X) \otimes \mathrm{Hom}_{\mathcal{C}}(Y, Y)$
    的像. 所以若 $X \in \mathcal{C}_{ij}$ 和 $Y \in \mathcal{C}_{jl}$ 非零,
    则 $X \otimes Y$ 非零.

3.  若 $\mathcal{C}_{ij} = 0$, 则 $e_i \otimes \mathcal{C} \otimes e_j = 0$.
    所以 $e_i \otimes e_k \otimes \mathcal{C} \otimes e_l \otimes e_j = 0$
    对所有 $k,l$ 成立. 所以 $e_i \otimes \mathcal{C} \otimes e_j = 0$.
    这与 $\mathcal{C}$ 不可分解矛盾.

4.  由 (2) 得 $\mathcal{C}_{ij} \boxtimes_{\mathcal{C}_{jj}} \mathcal{C}_{jl} \ne 0$.
    又因为 $\mathcal{C}_{ij} \boxtimes_{\mathcal{C}_{jj}} \mathcal{C}_{jl} \subset \mathcal{C}_{il}$,
    所以 $\mathcal{C}_{ij} \boxtimes_{\mathcal{C}_{jj}} \mathcal{C}_{jl} = \mathcal{C}_{il}$.
    由 Morita 等价得 $\mathcal{C}_{ij}$ 是可逆双模.

5.  由 (4) 立得.

6.  由 (4) 立得.

7.  由 [Theorem 4.5.1]{reference-type="ref" reference="thm:4.5.1"} 立得.