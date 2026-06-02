\maketitle
Monoidal category
=================

A *monoidal category* $\mathcal{C}$ consists of the following data:

1.  A category $\mathcal{C}$;

2.  An object $\mathbf{1} \in \mathcal{C}$, called the *unit object*;

3.  A functor $\otimes : \mathcal{C} \times \mathcal{C} \to \mathcal{C}$
    called the *tensor product functor*;

4.  Natural isomorphisms $\lambda_X : \mathbf{1} \otimes X \to X$ and
    $\rho_X : X \otimes \mathbf{1} \to X$ for all $X \in \mathcal{C}$;

5.  A natural isomorphism
    $\alpha_{X,Y,Z} : (X \otimes Y) \otimes Z \to X \otimes (Y \otimes Z)$
    for all $X, Y, Z \in \mathcal{C}$, called the *associator*;

such that, for all $X, Y, Z, W \in \mathcal{C}$, the following diagrams
commute:

$$\begin{tikzcd}
(X \otimes \mathbf{1}) \otimes M \arrow[r, "\alpha_{X,\mathbf{1},M}"] \arrow[dr, "\rho_X \otimes \mathrm{id}_M"'] & X \otimes (\mathbf{1} \otimes M) \arrow[d, "\mathrm{id}_X \otimes \lambda_M"] \
& X \otimes M
\end{tikzcd}$$

$$\begin{tikzcd}
    && {(X \otimes Y) \otimes (Z \otimes M)} \
    {((X \otimes Y) \otimes Z) \otimes M} &&&& {X \otimes ((Y \otimes Z) \otimes M)} \
    \
    & {(X \otimes (Y \otimes Z)) \otimes M} && {X \otimes (Y \otimes (Z \otimes M))}
    \arrow["{\alpha_{X,Y,Z \otimes M}}", from=1-3, to=2-5]
    \arrow["{\alpha_{X \otimes Y, Z, M}}", from=2-1, to=1-3]
    \arrow["{\alpha_{X,Y,Z} \otimes \mathrm{id}_M}"', from=2-1, to=4-2]
    \arrow["{\alpha_{X,Y \otimes Z, M}}", from=4-2, to=4-4]
    \arrow["{\mathrm{id}_X \otimes \alpha_{Y,Z,M}}", from=4-4, to=2-5]
\end{tikzcd}$$

A monoidal category is called *strict* if the natural isomorphisms
$\lambda, \rho, \alpha$ are all identities.

Let $\mathcal{C}$ and $\mathcal{D}$ be two monoidal categories. A
*monoidal functor* $F: \mathcal{C} \to \mathcal{D}$ consists of the
following data:

-   A functor $F: \mathcal{C} \to \mathcal{D}$.

-   An isomorphism
    $\mu: F(\mathbf{1}_{\mathcal{C}}) \to \mathbf{1}_{\mathcal{D}}$.

-   Natural isomorphisms
    $\nu_{X,Y}: F(X \otimes Y) \to F(X) \otimes F(Y)$ for all
    $X, Y \in \mathcal{C}$.

such that for all $X, Y, Z \in \mathcal{C}$, the following diagrams
commute:

$$\begin{tikzcd}
    {F(X \otimes \mathbf{1}_{\mathcal{C}})} & {F(X) \otimes F(\mathbf{1}_{\mathcal{C}})} & {F(X) \otimes \mathbf{1}_{\mathcal{D}}} \
    {F(X)} && {F(X)}
    \arrow["{\nu_{X,\mathbf{1}_{\mathcal{C}}}}", from=1-1, to=1-2]
    \arrow["{F(\rho_X)}"', from=1-1, to=2-1]
    \arrow["{\mathrm{id}_{F(X)} \otimes \mu}", from=1-2, to=1-3]
    \arrow["{\rho_{F(X)}}", from=1-3, to=2-3]
    \arrow["{\mathrm{id}_{F(X)}}", from=2-1, to=2-3]
\end{tikzcd}$$

$$\begin{tikzcd}
F((X \otimes Y) \otimes Z) \arrow[r, "\nu_{X \otimes Y, Z}"] \arrow[d, "F(\alpha_{X,Y,Z})"'] & F(X \otimes Y) \otimes F(Z) \arrow[r, "\nu_{X,Y} \otimes \mathrm{id}_{F(Z)}"] \arrow[d, "\mathrm{id}_{F(X)}"] & (F(X) \otimes F(Y)) \otimes F(Z) \arrow[d, "\alpha_{F(X),F(Y),F(Z)}"] \
F(X \otimes (Y \otimes Z)) \arrow[r, "\nu_{X, Y \otimes Z}"] & F(X) \otimes F(Y \otimes Z) \arrow[r, "\mathrm{id}_{F(X)} \otimes \nu_{Y,Z}"] & F(X) \otimes (F(Y) \otimes F(Z))
\end{tikzcd}$$

Let $F, G: \mathcal{C} \to \mathcal{D}$ be two monoidal functors. A
*monoidal natural transformation* $\xi: F \to G$ is a natural
transformation such that for all $X, Y \in \mathcal{C}$, the following
diagrams commute:

$$\begin{tikzcd}[column sep=huge]
\mathbf{1}_{\mathcal{D}} & F(\mathbf{1}_{\mathcal{C}}) \arrow[l, "\mu"'] \arrow[d, "\xi_{\mathbf{1}_{\mathcal{C}}}"'] & G(\mathbf{1}_{\mathcal{C}}) \arrow[l, "\mu"] \
& F(X \otimes Y) \arrow[r, "\nu_{X,Y}"'] \arrow[ul, "\xi_{X \otimes Y}"'] & G(X \otimes Y) \arrow[dl, "\nu_{X,Y}"] \
& F(X) \otimes F(Y) \arrow[r, "\xi_X \otimes \xi_Y"] & G(X) \otimes G(Y)
\end{tikzcd}$$

Let $\mathcal{C}$ be a monoidal category. A *left $\mathcal{C}$-module*
$\mathcal{M}$ consists of the following data:

-   A category $\mathcal{M}$;

-   A functor
    $\otimes : \mathcal{C} \times \mathcal{M} \to \mathcal{M}$;

-   Natural isomorphisms $\lambda_M : \mathbf{1} \otimes M \to M$,
    $M \in \mathcal{M}$;

-   Natural isomorphisms
    $\alpha_{X,Y,M} : (X \otimes Y) \otimes M \to X \otimes (Y \otimes M)$,
    $X, Y \in \mathcal{C}$, $M \in \mathcal{M}$;

such that for all $X, Y, Z \in \mathcal{C}$, $M \in \mathcal{M}$, the
following diagrams commute:

$$\begin{tikzcd}
(X \otimes \mathbf{1}) \otimes M \arrow[r, "\alpha_{X,\mathbf{1},M}"] \arrow[dr, "\rho_X \otimes \mathrm{id}_M"'] & X \otimes (\mathbf{1} \otimes M) \arrow[d, "\mathrm{id}_X \otimes \lambda_M"] \
& X \otimes M
\end{tikzcd}$$

$$\begin{tikzcd}
((X \otimes Y) \otimes Z) \otimes M \arrow[r, "\alpha_{X \otimes Y, Z, M}"] \arrow[d, "\alpha_{X,Y,Z} \otimes \mathrm{id}_M"'] & (X \otimes Y) \otimes (Z \otimes M) \arrow[d, "\alpha_{X,Y,Z \otimes M}"] \
(X \otimes (Y \otimes Z)) \otimes M \arrow[r, "\alpha_{X, Y \otimes Z, M}"] & X \otimes (Y \otimes (Z \otimes M)) \arrow[r, "\mathrm{id}_X \otimes \alpha_{Y,Z,M}"] & X \otimes ((Y \otimes Z) \otimes M)
\end{tikzcd}$$

Let $\mathcal{D}$ be a monoidal category. A *right $\mathcal{D}$-module*
$\mathcal{M}$ is called a left $\mathcal{D}^{\mathrm{rev}}$-module, with
the tensor functor generally denoted as
$\otimes : \mathcal{M} \times \mathcal{D} \to \mathcal{M}$. A left
$\mathcal{C} \times \mathcal{D}^{\mathrm{rev}}$-module $\mathcal{M}$ is
called a *$\mathcal{C}$-$\mathcal{D}$ bimodule*, with the tensor functor
generally denoted as
$\otimes : \mathcal{C} \times \mathcal{M} \times \mathcal{D} \to \mathcal{M}$.

Let $\mathcal{M}$, $\mathcal{N}$ be two left modules over a monoidal
category $\mathcal{C}$. A *left $\mathcal{C}$-module functor*
$F : \mathcal{M} \to \mathcal{N}$ consists of the following data:

-   A functor $F : \mathcal{M} \to \mathcal{N}$.

-   Natural isomorphisms
    $\nu_{X,M} : F(X \otimes M) \to X \otimes F(M)$,
    $X \in \mathcal{C}$, $M \in \mathcal{M}$.

such that for all $X, Y \in \mathcal{C}$, $M \in \mathcal{M}$, the
following diagrams commute:

$$\begin{tikzcd}
F(\mathbf{1} \otimes M) \arrow[r, "\nu_{\mathbf{1},M}"] \arrow[dr, "F(\lambda_M)"'] & \mathbf{1} \otimes F(M) \arrow[d, "\lambda_{F(M)}"] \
& F(M)
\end{tikzcd}$$

$$\begin{tikzcd}
F(X \otimes Y \otimes M) \arrow[r, "\nu_{X, Y \otimes M}"] \arrow[drr, "\nu_{X \times Y, M}"'] & X \otimes F(Y \otimes M) \arrow[r, "\mathrm{id}_X \otimes \nu_{Y,M}"] & X \otimes Y \otimes F(M) \
& & X \otimes Y \otimes F(M)
\end{tikzcd}$$

Let $F, G : \mathcal{M} \to \mathcal{N}$ be two left
$\mathcal{C}$-module functors. A *left $\mathcal{C}$-module natural
transformation* $\xi : F \to G$ is a natural transformation such that
for all $X \in \mathcal{C}$, $M \in \mathcal{M}$, the following diagram
commutes:

$$\begin{tikzcd}
F(X \otimes M) \arrow[r, "\xi_{X \otimes M}"] \arrow[d, "\nu_{X,M}"'] & G(X \otimes M) \arrow[d, "\nu_{X,M}"] \
X \otimes F(M) \arrow[r, "\mathrm{id}_X \otimes \xi_M"] & X \otimes G(M)
\end{tikzcd}$$

If $\mathcal{M}$, $\mathcal{N}$ are two left modules (right
$\mathcal{D}$-modules, $\mathcal{C}$-$\mathcal{D}$ bimodules), then all
module functors $F : \mathcal{M} \to \mathcal{N}$ and module natural
transformations constitute a category, denoted as
$\Fun_{\mathcal{C}}(\mathcal{M}, \mathcal{N})$
($\Fun_{\mathcal{D}^{\mathrm{rev}}}(\mathcal{M}, \mathcal{N})$,
$\Fun_{\mathcal{C}|\mathcal{D}}(\mathcal{M}, \mathcal{N})$).

A *braiding* on a monoidal category $\mathcal{C}$ is a natural
isomorphism
$\beta_{X,Y} : X \otimes Y \to Y \otimes X, \quad X, Y \in \mathcal{C}$

such that for any $X, Y, Z \in \mathcal{C}$, the following diagrams
commute:

$$\begin{tikzcd}
X \otimes Y \otimes Z \arrow[r, "\beta_{X,Y} \otimes \mathrm{id}_Z"] \arrow[d, "\beta_{X, Y \otimes Z}"'] & Y \otimes X \otimes Z \arrow[d, "\mathrm{id}_Y \otimes \beta_{X,Z}"] \
Y \otimes Z \otimes X \arrow[r, "\beta_{Y,Z} \otimes \mathrm{id}_X"'] & Z \otimes Y \otimes X
\end{tikzcd}$$

$$\begin{tikzcd}
X \otimes Y \otimes Z \arrow[r, "\mathrm{id}_X \otimes \beta_{Y,Z}"] \arrow[d, "\beta_{X \otimes Y, Z}"'] & X \otimes Z \otimes Y \arrow[d, "\beta_{X,Z} \otimes \mathrm{id}_Y"] \
Z \otimes X \otimes Y \arrow[r, "\mathrm{id}_Z \otimes \beta_{X,Y}"'] & Z \otimes X \otimes Y
\end{tikzcd}$$

A braided structure on a monoidal category is called a *braided monoidal
category*.

Let $\mathcal{C}$, $\mathcal{D}$ be two braided monoidal categories. A
*braided monoidal functor* $F : \mathcal{C} \to \mathcal{D}$ is a
monoidal functor such that for all $X, Y \in \mathcal{C}$, the following
diagram commutes:

$$\begin{tikzcd}
F(X \otimes Y) \arrow[r, "F(\beta_{X,Y})"] \arrow[d, "\nu_{X,Y}"'] & F(Y \otimes X) \arrow[d, "\nu_{Y,X}"] \
F(X) \otimes F(Y) \arrow[r, "\beta_{F(X),F(Y)}"] & F(Y) \otimes F(X)
\end{tikzcd}$$

In a braided monoidal category $\mathcal{C}$, the following diagrams
commute:

$$\begin{tikzcd}
\mathbf{1} \otimes X \arrow[r, "\lambda_X"] \arrow[d, "\beta_{X,\mathbf{1}}"] & X \
X \otimes \mathbf{1} \arrow[ru, "\rho_X"'] &
\end{tikzcd}
\qquad
\begin{tikzcd}
\mathbf{1} \otimes X \arrow[r, "\lambda_X"] \arrow[d, "\beta_{\mathbf{1},X}"] & X \
X \otimes \mathbf{1} \arrow[ru, "\rho_X"'] &
\end{tikzcd}$$

Assume $\mathcal{C}$ is strict. By the commutative diagram:

$$\begin{tikzcd}
X \otimes \mathbf{1} \otimes \mathbf{1} \arrow[r, "\beta_{X,\mathbf{1}} \otimes \mathrm{id}_{\mathbf{1}}"] \arrow[d, "\mathrm{id}_{\mathbf{1}} \otimes \beta_{X,\mathbf{1}}"'] & \mathbf{1} \otimes X \otimes \mathbf{1} \arrow[d, "\mathrm{id}_{\mathbf{1}} \otimes \mathrm{id}_X"] \
\mathbf{1} \otimes \mathbf{1} \otimes X \arrow[r, "\mathrm{id}_{\mathbf{1}} \otimes \mathrm{id}_X"'] & \mathbf{1} \otimes X
\end{tikzcd}$$

we obtain $\beta_{X,\mathbf{1}} = \mathrm{id}_X$. Similarly,
$\beta_{\mathbf{1},X} = \mathrm{id}_X$.

A braided monoidal category $\mathcal{C}$ is called a *symmetric
monoidal category* if for all $X, Y \in \mathcal{C}$,
$\beta_{X,Y} = (\beta_{Y,X})^{-1}$. Let $\mathcal{C}$, $\mathcal{D}$ be
two symmetric monoidal categories. A *symmetric monoidal functor*
$F : \mathcal{C} \to \mathcal{D}$ is a braided monoidal functor.

Let $\mathcal{C}$ be a monoidal category. A *half-braiding* on an object
$X \in \mathcal{C}$ is a natural isomorphism
$b_{X,Y} : X \otimes Y \to Y \otimes X$, $Y \in \mathcal{C}$, such that
for any $Y, Z \in \mathcal{C}$ the following diagram commutes:

$$\begin{tikzcd}
Y \otimes X \otimes Z \arrow[r, "b_{X,Y} \otimes \mathrm{id}_Z"] \arrow[d, "b_{X,Y \otimes Z}"'] & X \otimes Y \otimes Z \arrow[d, "\mathrm{id}_Y \otimes b_{X,Z}"] \
Y \otimes Z \otimes X \arrow[r, "\mathrm{id}_Y \otimes \mathrm{id}_Z"'] & Y \otimes Z \otimes X
\end{tikzcd}$$

We construct a monoidal category $\mathfrak{Z}(\mathcal{C})$ as follows,
called the *Drinfeld center* of $\mathcal{C}$. An object of
$\mathfrak{Z}(\mathcal{C})$ is a pair $(X, b_{X,-})$, where $X$ is an
object in $\mathcal{C}$ and $b_{X,-}$ is a half-braiding on $X$. A
morphism $(X, b_{X,-}) \to (Y, b_{Y,-})$ is a morphism $f : X \to Y$ in
$\mathcal{C}$ such that for $Z \in \mathcal{C}$ the following diagram
commutes:

$$\begin{tikzcd}
X \otimes Z \arrow[r, "b_{X,Z}"] \arrow[d, "f \otimes \mathrm{id}_Z"] & Z \otimes X \arrow[d, "\mathrm{id}_Z \otimes f"] \
Y \otimes Z \arrow[r, "b_{Y,Z}"] & Z \otimes Y
\end{tikzcd}$$

The tensor product $(X, b_{X,-}) \otimes (Y, b_{Y,-})$ is defined as
$(X \otimes Y, b_{X \otimes Y,-})$, where $b_{X \otimes Y, Z}$ is the
composite
$X \otimes Y \otimes Z \xrightarrow{\mathrm{id}_X \otimes b_{Y,Z}} X \otimes Z \otimes Y \xrightarrow{b_{X,Z} \otimes \mathrm{id}_Y} Z \otimes X \otimes Y$.
The unit object is $(\mathbf{1}, \rho^{-1} \circ \lambda)$. The
associativity constraint is defined by
$\beta_{(X,b_{X,-}), (Y,b_{Y,-})} = b_{X,Y}$.

If $\mathcal{C}$ and $\mathcal{D}$ are monoidal categories, then
$\mathfrak{Z}(\mathcal{C} \times \mathcal{D}) = \mathfrak{Z}(\mathcal{C}) \times \mathfrak{Z}(\mathcal{D})$.

An object $X \in \mathcal{C}$ can have multiple different
half-braidings. Therefore $\mathfrak{Z}(\mathcal{C})$ is generally not a
subcategory of $\mathcal{C}$. On the other hand, if $X$ has a
half-braiding, then necessarily for all $Y \in \mathcal{C}$ we have
$X \otimes Y \simeq Y \otimes X$. So in general, $X$ has no
half-braiding.

Let $\mathcal{C}$ be a monoidal category. (1) The tensor product of
$\mathcal{C}$ induces a monoidal functor
$\otimes : \mathfrak{Z}(\mathcal{C}) \times \mathcal{C} \to \mathcal{C}$,
and the diagram of monoidal categories commutes up to isomorphism:

$$\begin{tikzcd}
\mathfrak{Z}(\mathcal{C}) \times \mathcal{C} \arrow[rr, "\otimes"] \arrow[dr, "\mathbf{1} \times \mathrm{id}_{\mathcal{C}}"'] & & \mathcal{C} \
& \mathcal{C} \arrow[ru, "\mathrm{id}_{\mathcal{C}}"] &
\end{tikzcd}$$

\(2) For any monoidal category $\mathcal{D}$ and monoidal functor
$\cdot : \mathcal{D} \times \mathcal{C} \to \mathcal{C}$, if the
following diagram of monoidal categories commutes up to isomorphism

$$\begin{tikzcd}
\mathcal{D} \times \mathcal{C} \arrow[rr, "\cdot"] \arrow[dr, "\mathbf{1}_{\mathcal{D}} \times \mathrm{id}_{\mathcal{C}}"'] & & \mathcal{C} \
& \mathcal{C} \arrow[ru, "\mathrm{id}_{\mathcal{C}}"] &
\end{tikzcd}$$

then there exists a monoidal functor
$G : \mathcal{D} \to \mathfrak{Z}(\mathcal{C})$ such that the following
diagram commutes up to isomorphism

$$\begin{tikzcd}
\mathcal{D} \times \mathcal{C} \arrow[rr, "\cdot"] \arrow[dr, "G \times \mathrm{id}_{\mathcal{C}}"'] & & \mathcal{C} \
& \mathfrak{Z}(\mathcal{C}) \times \mathcal{C} \arrow[ru, "\otimes"] &
\end{tikzcd}$$

and $G$ is unique up to isomorphism.

\(1) The natural isomorphism
$(Z \otimes Z') \otimes (X \otimes X') \xrightarrow{\mathrm{id}_Z \otimes b_{Z',X} \otimes \mathrm{id}_X} (Z \otimes X) \otimes (Z' \otimes X')$,
$Z, Z' \in \mathfrak{Z}(\mathcal{C})$, $X, X' \in \mathcal{C}$, lifts
the functor
$\otimes : \mathfrak{Z}(\mathcal{C}) \times \mathcal{C} \to \mathcal{C}$
to a monoidal functor.

\(2) We have a monoidal functor
$G : \mathcal{D} \to \mathfrak{Z}(\mathcal{C})$,
$Y \mapsto (Y \cdot \mathbf{1}, b_{Y \cdot \mathbf{1}, -})$, where
$b_{Y \cdot \mathbf{1}, X}$ is the composite isomorphism
$(Y \cdot \mathbf{1}) \otimes X \simeq (Y \cdot \mathbf{1}) \otimes (\mathbf{1} \cdot X) \simeq Y \cdot X \simeq (\mathbf{1} \cdot X) \times (Y \cdot \mathbf{1}) \simeq X \otimes (Y \cdot \mathbf{1})$.
There is also a monoidal natural isomorphism
$G(Y) \otimes X = (Y \cdot \mathbf{1}) \otimes X \simeq Y \cdot X$.
Suppose there is a monoidal functor
$G' : \mathcal{D} \to \mathfrak{Z}(\mathcal{C})$ and a monoidal natural
isomorphism $G'(Y) \otimes X \simeq Y \cdot X$. Then there is a monoidal
natural isomorphism
$G'(Y) \simeq G'(Y) \otimes \mathbf{1} \simeq Y \cdot \mathbf{1} \simeq G(Y)$.

Let $\mathcal{C}$ be a braided monoidal category. A *monoidal category
over* $\mathcal{C}$ is a monoidal category $\mathcal{D}$ and a braided
monoidal functor $\mathcal{C} \to \mathfrak{Z}(\mathcal{D})$.

Let $\mathcal{C}$ be a braided monoidal category. (1) The tensor product
of $\mathcal{C}$ induces a braided monoidal functor
$\otimes : \mathfrak{Z}_2(\mathcal{C}) \times \mathcal{C} \to \mathcal{C}$,
and the following diagram of braided monoidal categories commutes up to
isomorphism:

$$\begin{tikzcd}
\mathfrak{Z}_2(\mathcal{C}) \times \mathcal{C} \arrow[rr, "\otimes"] \arrow[dr, "\mathbf{1} \times \mathrm{id}_{\mathcal{C}}"'] & & \mathcal{C} \
& \mathcal{C} \arrow[ru, "\mathrm{id}_{\mathcal{C}}"] &
\end{tikzcd}$$

\(2) For any braided monoidal category $\mathcal{D}$ and braided monoidal
functor $\cdot : \mathcal{D} \times \mathcal{C} \to \mathcal{C}$, if the
following diagram of braided monoidal categories commutes up to
isomorphism

$$\begin{tikzcd}
\mathcal{D} \times \mathcal{C} \arrow[rr, "\cdot"] \arrow[dr, "\mathbf{1}_{\mathcal{D}} \times \mathrm{id}_{\mathcal{C}}"'] & & \mathcal{C} \
& \mathcal{C} \arrow[ru, "\mathrm{id}_{\mathcal{C}}"] &
\end{tikzcd}$$

then there exists a braided monoidal functor
$G : \mathcal{D} \to \mathfrak{Z}_2(\mathcal{C})$ such that the
following diagram commutes up to isomorphism

$$\begin{tikzcd}
\mathcal{D} \times \mathcal{C} \arrow[rr, "\cdot"] \arrow[dr, "G \times \mathrm{id}_{\mathcal{C}}"'] & & \mathcal{C} \
& \mathfrak{Z}_2(\mathcal{C}) \times \mathcal{C} \arrow[ru, "\otimes"] &
\end{tikzcd}$$

and $G$ is unique up to isomorphism.

\(1) Obvious. (2) We have a braided monoidal functor
$G : \mathcal{D} \to \mathcal{C}$, $Y \mapsto Y \cdot \mathbf{1}$. From
the commutative diagram

$$\begin{tikzcd}
    {(Y \otimes \mathbf{1}) \cdot (\mathbf{1} \otimes X)} & {(\mathbf{1} \otimes Y) \cdot (X \otimes \mathbf{1})} & {(Y \otimes \mathbf{1}) \cdot (\mathbf{1} \otimes X)} \
    {(Y \cdot \mathbf{1}) \otimes (\mathbf{1} \cdot X)} & {(\mathbf{1} \cdot X) \otimes (Y \cdot \mathbf{1})} & {(Y \cdot \mathbf{1}) \otimes (\mathbf{1} \cdot X)}
    \arrow["{\beta_{Y,\mathbf{1}} \cdot \beta_{\mathbf{1},X}}", from=1-1, to=1-2]
    \arrow["\sim", from=1-1, to=2-1]
    \arrow["{\beta_{\mathbf{1},Y} \cdot \beta_{X,\mathbf{1}}}", from=1-2, to=1-3]
    \arrow["\sim", from=1-2, to=2-2]
    \arrow["\sim", from=1-3, to=2-3]
    \arrow["{\beta_{Y \cdot \mathbf{1}, \mathbf{1} \cdot X}}", from=2-1, to=2-2]
    \arrow["{\beta_{\mathbf{1} \cdot X, Y \cdot \mathbf{1}}}", from=2-2, to=2-3]
\end{tikzcd}$$

we know that the image of $G$ lies in $\mathfrak{Z}_2(\mathcal{C})$.
There is also a monoidal natural isomorphism
$G(Y) \otimes X = (Y \cdot \mathbf{1}) \otimes X \simeq Y \cdot X$.

Suppose there is a braided monoidal functor
$G' : \mathcal{D} \to \mathfrak{Z}_2(\mathcal{C})$ and a monoidal
natural isomorphism $G'(Y) \otimes X \simeq Y \cdot X$. Then there is a
monoidal natural isomorphism
$G'(Y) \simeq G'(Y) \otimes \mathbf{1} \simeq Y \cdot \mathbf{1} \simeq G(Y)$.

Let $\mathcal{C}$ be a symmetric monoidal category. A *braided monoidal
category over* $\mathcal{C}$ is a braided monoidal category
$\mathcal{D}$ and a braided monoidal functor
$\mathcal{C} \to \mathfrak{Z}_2(\mathcal{D})$.

Let $\mathcal{C}$ be a monoidal category, and $X, Y \in \mathcal{C}$ be
two objects. We call $X$ a *left dual* of $Y$, and $Y$ a *right dual* of
$X$, if there exist morphisms $u : \mathbf{1} \to Y \otimes X$ and
$v : X \otimes Y \to \mathbf{1}$, such that the following composite
morphisms are identities:

$X \cong X \otimes \mathbf{1} \xrightarrow{\mathrm{id}_X \otimes u} X \otimes Y \otimes X \xrightarrow{v \otimes \mathrm{id}_X} \mathbf{1} \otimes X \cong X,$

$Y \cong \mathbf{1} \otimes Y \xrightarrow{u \otimes \mathrm{id}_Y} Y \otimes X \otimes Y \xrightarrow{\mathrm{id}_Y \otimes v} Y \otimes \mathbf{1} \cong Y.$

We denote $Y$ as $X^R$ and $X$ as $Y^L$. We call $\mathcal{C}$ *rigid*
if every object has both a left dual and a right dual.

Let $\mathcal{C}$ be a symmetric monoidal category. If $Y$ is a right
dual of $X$, then $Y$ is also a left dual of $X$.

Let $\mathcal{C}$ be a monoidal category. We call an object
$X \in \mathcal{C}$ *invertible* if there exists an object
$Y \in \mathcal{C}$ such that
$X \otimes Y \cong Y \otimes X \cong \mathbf{1}$. Then $X$ is invertible
if and only if $X$ has a left dual, such that
$u : \mathbf{1} \to X \otimes X^L$ and
$v : X^L \otimes X \to \mathbf{1}$ are both isomorphisms.

Let $F : \mathcal{C} \to \mathcal{D}$ be a monoidal functor. If
$X \in \mathcal{C}$ is a left dual of $Y \in \mathcal{C}$, then $F(X)$
is a left dual of $F(Y)$.

Immediate from the definition.

Let $\mathcal{C}$ be a monoidal category, and $\mathcal{M}$ be a left
$\mathcal{C}$-module. If $X$ has a left dual, then the functor
$X^L \otimes - : \mathcal{M} \to \mathcal{M}$ is a left adjoint of
$X \otimes -$.

Consider the monoidal functor
$\mathcal{C} \to \Fun(\mathcal{M}, \mathcal{M}), X \mapsto X \otimes -$.

Let $\mathcal{C}$ be a rigid monoidal category. Then the functor
$X \otimes - : \mathcal{M} \to \mathcal{M}$ has both a left adjoint and
a right adjoint, thus preserving all limits and colimits. In particular,
if $\mathcal{C}$ is an Abel category, then the tensor product
$\otimes : \mathcal{C} \times \mathcal{C} \to \mathcal{C}$ is right
exact in each variable.

Let $\mathcal{C}$ be a monoidal category. If $X$ has a left dual $X^L$,
then $X^L$ is unique up to canonical isomorphism. In particular,
$(X^L)^R$ is canonically isomorphic to $X$.

Let $\mathcal{C}$ be a rigid monoidal category, and
$F : \mathcal{M} \to \mathcal{N}$ be a left $\mathcal{C}$-module
functor. If functor $F$ has a right adjoint $G$, then $G$ is also a left
$\mathcal{C}$-module functor, and $u : \mathrm{id}_{\mathcal{M}} \to G \circ F$
and $v : F \circ G \to \mathrm{id}_{\mathcal{N}}$ are both left
$\mathcal{C}$-module natural transformations. In fact, $G(X \otimes -)$
and $X \otimes G(-)$ are the right adjoints of
$X^L \otimes F(-) \cong F(X^L \otimes -)$, hence isomorphic.

Let $\mathcal{C}$ be a rigid monoidal category. There is a functor
$\delta^L : \mathcal{C} \to \mathcal{C}^{\mathrm{op}}$, $X \mapsto X^L$.
Mapping a morphism $f : X \to Y$ to
$f^L : Y^L \to Y^L \otimes X \otimes X^L \xrightarrow{\mathrm{id}_{Y^L} \otimes f \otimes \mathrm{id}_{X^L}} Y^L \otimes Y \otimes X^L \xrightarrow{v \otimes \mathrm{id}_{X^L}} X^L$.
Similarly, there is a functor
$\delta^R : \mathcal{C} \to \mathcal{C}^{\mathrm{op}}$, $X \mapsto X^R$.

Let $\mathcal{C}$ be a rigid monoidal category. There are monoidal
isomorphisms
$\delta^L : \mathcal{C}^{\mathrm{rev}} \to \mathcal{C}^{\mathrm{op}}$,
$X \mapsto X^L$ and
$\delta^R : \mathcal{C}^{\mathrm{rev}} \to \mathcal{C}^{\mathrm{op}}$,
$X \mapsto X^R$.

First, the functors $\delta^L$ and $\delta^R$ are mutually inverse.
Furthermore, $(X \otimes Y)^L$ and $Y^L \otimes X^L$ are both left duals
of $X \otimes Y$, so the induced canonical isomorphism
$(X \otimes Y)^L \cong Y^L \otimes X^L$ lifts $\delta^L$ to a monoidal
functor.

Let $\mathcal{C}$ be a rigid braided monoidal category. Then
$\delta^L : \mathcal{C}^{\mathrm{rev}} \to \mathcal{C}^{\mathrm{op}}$
and
$\delta^R : \mathcal{C}^{\mathrm{rev}} \to \mathcal{C}^{\mathrm{op}}$
are braided monoidal isomorphisms.

There is a commutative diagram $\begin{tikzcd}
(X \otimes Y)^L \arrow[r, "\sim"] \arrow[d, "\beta^L_{Y,X} = (\beta^{\mathrm{rev}}_{X,Y})^L"] & Y^L \otimes X^L \arrow[d, "\beta_{Y^L,X^L} = \beta^{\mathrm{op}}_{X^L,Y^L}"] \\
(Y \otimes X)^L \arrow[r, "\sim"] & X^L \otimes Y^L
\end{tikzcd}$

Let $\mathcal{C}$ be a rigid monoidal category, where $\mathcal{C}$ is
an Abel category. Then for any object $X$ and any injective object $P$,
$X \otimes P$ is an injective object.

$\hom_{\mathcal{C}}(X \otimes P, -) \cong \hom_{\mathcal{C}}(P, X^R \otimes -)$
is exact.

Let $\mathcal{C}$ be a rigid monoidal category, where $\mathcal{C}$ is
an Abel category. The following are equivalent:

-   $\mathcal{C}$ is semisimple.

-   $\mathbf{1}$ is injective.

-   $\mathbf{1}$ is projective.
