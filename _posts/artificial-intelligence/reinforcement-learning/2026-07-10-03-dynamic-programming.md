---
layout: post
title: "第三章：动态规划 —— 模型已知时的精确求解"
permalink: /posts/ai/reinforcement-learning/dynamic-programming/
tags: reinforcement-learning
use_math: true
---

第二章定义了 MDP 这个数学框架——现在假设我们**完全知道**环境模型 $p(s', r \mid s, a)$，该如何精确求解最优策略？本章介绍的动态规划方法（价值迭代、策略迭代）虽然需要完整模型，在大型问题中不实用，但它们建立的**理论框架**——Bellman 方程、压缩映射、策略改进定理——是所有后续无模型方法的根基。

---

## 3.1 动态规划的核心思想

### 最优子结构

动态规划 (Dynamic Programming, DP) 依赖于一个关键观察：

> 在最优路径上，从其中任意一个中间状态出发，剩下的路径也必然是最优的。

> 最优路径:  S₀ → S₁ → S₂ → ··· → Sₙ → Goal
>                           ↑
>                     从这个状态出发，
>                     剩下的 Sₙ → ··· → Goal
>                     也必须是最短路

这被称为**最优性原理 (Principle of Optimality)**。

> **直观类比**：如果你要从北京开车到广州，已知最优路线经过武汉。那么"最优路线中武汉到广州的那一段"一定也是"从武汉开车到广州"的最优路线。如果存在更短的武汉→广州路线，你早该用它替换原路线了。

### DP 在 MDP 中的作用

MDP 天然满足最优子结构：
- 当前价值 = 即时奖励 + 折扣后的**最优**未来价值
- 这意味着：如果我们能正确估计所有状态的价值，就能做出最优决策

---

## 3.2 Bellman 期望方程

### 状态价值的递归展开

从 $V^{\pi}$ 的定义出发，将求和按第一个时间步展开：

$$
\begin{aligned}
V^{\pi}(s) &= \mathbb{E}_{\pi}\left[ R_{t+1} + \gamma R_{t+2} + \gamma^2 R_{t+3} + \cdots \mid S_t = s \right] \\
&= \mathbb{E}_{\pi}\left[ R_{t+1} + \gamma \underbrace{\left( R_{t+2} + \gamma R_{t+3} + \cdots \right)}_{= G_{t+1}} \mid S_t = s \right] \\
&= \mathbb{E}_{\pi}\left[ R_{t+1} + \gamma V^{\pi}(S_{t+1}) \mid S_t = s \right]
\end{aligned}
$$

展开策略和环境的期望，得到：

$$\boxed{V^{\pi}(s) = \sum_{a} \pi(a \mid s) \sum_{s', r} p(s', r \mid s, a) \left[ r + \gamma V^{\pi}(s') \right]}$$

这就是 **$V^{\pi}$ 的 Bellman 期望方程**。

类似地，$Q^{\pi}$ 的 Bellman 期望方程为：

$$\boxed{Q^{\pi}(s, a) = \sum_{s', r} p(s', r \mid s, a) \left[ r + \gamma \sum_{a'} \pi(a' \mid s') Q^{\pi}(s', a') \right]}$$

### 直观理解

$$V(s) = \underbrace{\sum_a \pi(a \mid s) \, r(s,a)}_{\text{当前能拿到的}} \;+\; \underbrace{\gamma \sum_a \pi(a \mid s) \sum_{s'} p(s' \mid s,a) \, V(s')}_{\text{未来能拿到的（折扣后）}}$$

> Bellman 方程的本质是**自洽性 (self-consistency)**：价值函数的值，必须等于"按照策略走一步的期望奖励 + 折扣后下一步的价值"。如果不等式成立，说明价值估计不一致，需要调整。

---

## 3.3 Bellman 方程的矩阵形式

对于有限 MDP，Bellman 期望方程可以写成简洁的线性方程组：

$$\boxed{V^{\pi} = \gamma P(\pi) V^{\pi} + b(\pi)}$$

其中：
- $V^{\pi} \in \mathbb{R}^{|S|}$ 是所有状态的价值向量
- $P(\pi) \in \mathbb{R}^{|S| \times |S|}$ 是策略诱导的转移矩阵：$[P(\pi)]_{ss'} = \sum_a \pi(a \mid s) \, p(s' \mid s, a)$
- $b(\pi) \in \mathbb{R}^{|S|}$ 是策略诱导的期望奖励向量：$b(\pi)_s = \sum_a \pi(a \mid s) \sum_{s', r} p(s', r \mid s, a) \, r$

### 解析解

直接求解线性方程组：

$$V^{\pi} = (I - \gamma P(\pi))^{-1} b(\pi)$$

解的存在唯一性由 $\gamma < 1$ 和 $\|P(\pi)\|_{\infty} = 1$ 保证 $(I - \gamma P(\pi))$ 可逆。

> **实际中几乎不这样做**：矩阵求逆是 $O(|S|^3)$ 的，当 $|S|$ 很大时（如 $10^6$），直接求解不现实。但解析解的存在性是重要的理论保证。

---

## 3.4 策略比较与最优策略

### 偏序关系

我们可以通过价值函数来比较策略的优劣：

$$\pi \geq \pi' \quad \iff \quad V^{\pi}(s) \geq V^{\pi'}(s), \quad \forall s \in S$$

这是一个**偏序 (partial order)**——有些策略对之间存在严格的优劣关系，有些则不具可比性。

**示例**：

| 策略 | $V(s_1)$ | $V(s_2)$ | $V(s_3)$ | 结论 |
|------|----------|----------|----------|------|
| $\pi_A$ | 2 | 4 | 6 | $\pi_A > \pi_B$（每个状态都更好） |
| $\pi_B$ | 1 | 3 | 6 | |
| $\pi_C$ | 2 | 4 | 6 | $\pi_C$ 与 $\pi_D$ 不可比较 |
| $\pi_D$ | 3 | 3 | 6 | （$s_2$ 上 $\pi_C$ 好，$s_1$ 上 $\pi_D$ 好） |

### 最优策略

**最优策略 $\pi_*$** 定义为优于或等于所有其他策略的策略：

$$\pi_* \geq \pi, \quad \forall \pi$$

两个关键问题：
1. **存在性**：最优策略一定存在吗？ → **是**（有限 MDP 中，策略空间有限，总存在至少一个最大值）
2. **唯一性**：最优策略唯一吗？ → **不一定**（可能有多个策略达到相同的最优价值，但它们的 $V^*$ 是唯一的）

---

## 3.5 策略改进定理

### 核心定理

这是 RL 中最重要的理论基础之一，它保证了"贪心改进"的有效性：

> **[策略改进定理]** 对于任意两个确定性策略 $\pi$ 和 $\pi'$，如果
>
> $$Q^{\pi}(s, \pi'(s)) \geq V^{\pi}(s), \quad \forall s$$
>
> 那么 $\pi'$ 严格优于 $\pi$（至少有一个状态的价值严格更大），或者两者相等且均为最优策略。

### 推论

从任意策略 $\pi$ 出发，构造**贪心策略** $\pi'$：

$$\pi'(s) = \arg\max_a Q^{\pi}(s, a)$$

那么 $\pi' \geq \pi$，且等号成立当且仅当 $\pi$ 已经是最优策略。

> **意义**：这个定理告诉我们——只要不断地对当前价值函数取贪心，策略就会单调改进，直到收敛到最优。这直接导出了策略迭代算法。

### 证明概要

对于确定性策略的情况，证明的核心思路（有限 MDP 版本）：

$$\begin{aligned}
Q^{\pi}(s, \pi'(s)) &= \sum_{s', r} p(s', r \mid s, \pi'(s)) \left[ r + \gamma \sum_{a'} \pi(a' \mid s') Q^{\pi}(s', a') \right] \\
&= [b(\pi') + \gamma P(\pi') V^{\pi}](s) \geq V^{\pi}(s)
\end{aligned}$$

这给出 $(I - \gamma P(\pi')) V^{\pi} \leq b(\pi')$。

而 Bellman 方程告诉我们 $(I - \gamma P(\pi')) V^{\pi'} = b(\pi')$。

因为 $(I - \gamma P(\pi'))^{-1}$ 的所有元素非负（正定性），可得 $V^{\pi} \leq V^{\pi'}$。若某状态 $s$ 上不等式严格，则对应价值也严格更大。

---

## 3.6 Bellman 最优方程

将策略改进定理推向极致——在最优策略 $\pi_*$ 下，贪心改进不再产生变化。

### 最优状态价值方程

$$\boxed{V^{*}(s) = \max_{a \in A} \sum_{s', r} p(s', r \mid s, a) \left[ r + \gamma V^{*}(s') \right]}$$

### 最优动作价值方程

$$\boxed{Q^{*}(s, a) = \sum_{s', r} p(s', r \mid s, a) \left[ r + \gamma \max_{a' \in A} Q^{*}(s', a') \right]}$$

### 从最优价值到最优策略

一旦知道了 $V^{*}$ 或 $Q^{*}$，最优策略只需"查表取最大化"：

$$\pi_*(s) = \arg\max_{a} \sum_{s', r} p(s', r \mid s, a) \left[ r + \gamma V^{*}(s') \right]$$

或更简洁地：$\pi_*(s) = \arg\max_a Q^{*}(s, a)$

> **最优方程与期望方程的关键区别**：Bellman 期望方程中有对策略 $\pi$ 的加权求和 ($\sum_a \pi(a \mid s)$)；Bellman 最优方程中变成了 $\max_a$——最优策略不讲"平均"，只讲"最优"。

---

## 3.7 价值迭代 (Value Iteration)

### Bellman 最优算子

定义 Bellman 最优算子 $\mathcal{F}: \mathbb{R}^{|S|} \to \mathbb{R}^{|S|}$：

$$\mathcal{F}(V)(s) = \max_{a} \sum_{s', r} p(s', r \mid s, a) \left[ r + \gamma V(s') \right]$$

或等价地用矩阵形式：$\mathcal{F}(V) = \max_{\pi} \left[ \gamma P(\pi) V + b(\pi) \right]$

Bellman 最优方程简化为不动点方程：

$$V^{*} = \mathcal{F}(V^{*})$$

### 压缩映射定理

> **[Banach 不动点定理 / 压缩映射定理]** 设 $\mathcal{V}$ 是一个完备赋范空间，$\mathcal{F}: \mathcal{V} \to \mathcal{V}$ 是一个收缩映射：
>
> $$\|\mathcal{F}(u) - \mathcal{F}(v)\| \leq \gamma \|u - v\|, \quad \forall u, v \in \mathcal{V}, \quad 0 \leq \gamma < 1$$
>
> 则存在唯一的 $v_* \in \mathcal{V}$ 满足 $v_* = \mathcal{F}(v_*)$，且对任意 $v_0$，序列 $v_{k+1} = \mathcal{F}(v_k)$ 收敛到 $v_*$。

**Bellman 最优算子 $\mathcal{F}$ 是 $\gamma$-收缩的**（在 $\|\cdot\|_{\infty}$ 下）。

> **证明**：记 $Q_V(s,a) = \sum_{s',r} p(s',r \mid s,a)[r + \gamma V(s')]$，则 $\mathcal{F}(V)(s) = \max_a Q_V(s,a)$。
>
> 对任意 $s$，取 $a_1^*$ 使 $\mathcal{F}(V_1)(s)=Q_{V_1}(s,a_1^*)$，有
> $$\mathcal{F}(V_1)(s)-\mathcal{F}(V_2)(s) \leq Q_{V_1}(s,a_1^*)-Q_{V_2}(s,a_1^*) = \gamma\sum_{s',r} p(s',r \mid s,a_1^*)[V_1(s')-V_2(s')]$$
> 其中 $r$ 相消，再由 $|\cdot| \leq \|V_1-V_2\|_{\infty}$ 及 $\sum p = 1$ 得上界 $\gamma\|V_1-V_2\|_{\infty}$。
> 对称地取 $a_2^*$ 得另一侧不等式，故 $|\mathcal{F}(V_1)(s)-\mathcal{F}(V_2)(s)| \leq \gamma\|V_1-V_2\|_{\infty}$ 对所有 $s$ 成立。取 supremum 即 $\|\mathcal{F}(V_1)-\mathcal{F}(V_2)\|_{\infty} \leq \gamma\|V_1-V_2\|_{\infty}$。∎
>
> **直观**：每次应用 $\mathcal{F}$，"收缩"了当前估计与真实最优值之间的距离——误差按 $\gamma$ 的倍数递减。因为 $\gamma < 1$，迭代保证收敛。

### 价值迭代算法

价值迭代直接对 Bellman 最优方程 $V^{*} = \mathcal{F}(V^{*})$ 做不动点迭代 $V_{k+1} = \mathcal{F}(V_k)$。

**输入**：MDP 转移概率 $p(s', r \mid s, a)$，折扣因子 $\gamma \in [0, 1)$，停止阈值 $\theta > 0$

**初始化**：$V(s) \leftarrow 0,\ \forall s \in S$

**迭代**（重复执行直到收敛）：

$$\begin{aligned}
\text{(1)}\quad &\Delta \leftarrow 0 \\[6pt]
\text{(2)}\quad &\forall s \in S: \\[6pt]
&\quad v \leftarrow V(s) \\[6pt]
&\quad V(s) \leftarrow \max_{a \in A} \sum_{s', r} p(s', r \mid s, a) \big[\, r + \gamma \, V(s') \,\big] \\[6pt]
&\quad \Delta \leftarrow \max(\Delta,\ |v - V(s)|) \\[6pt]
\text{(3)}\quad &\text{若 } \Delta < \theta \text{，终止迭代}
\end{aligned}$$

**输出**（从收敛后的 $V$ 提取贪心策略）：

$$\pi(s) = \arg\max_{a \in A} \sum_{s', r} p(s', r \mid s, a) \big[\, r + \gamma \, V(s') \,\big]$$

每次迭代只做**一步贪心 lookahead**——用当前 $V$ 去"看一步"，取最优动作对应的价值作为新的 $V(s)$。

---

## 3.8 策略迭代 (Policy Iteration)

策略迭代交替执行两个步骤，从任意初始策略 $\pi_0$ 开始：

**步骤一：策略评估 (Policy Evaluation)** — 求解当前策略 $\pi_k$ 的价值函数：

$$V^{\pi_k} = (I - \gamma P(\pi_k))^{-1} b(\pi_k)$$

（实践中用迭代法逼近，不需要矩阵求逆。）

**步骤二：策略改进 (Policy Improvement)** — 对每个状态构造贪心策略：

$$\pi_{k+1}(s) = \arg\max_{a} \sum_{s', r} p(s', r \mid s, a) \left[ r + \gamma V^{\pi_k}(s') \right]$$

**终止条件**：若 $\pi_{k+1} = \pi_k$，输出 $\pi^* = \pi_k$；否则 $k \leftarrow k+1$，回到步骤一。

### 有限终止性

> 在有限的 MDP 中，策略迭代**必然在有限步内终止**。

理由：确定性策略的总数有限（$|A|^{|S|}$），而每次迭代都严格改进策略（除非已经最优）。因此不会出现循环，必然在 $\leq |A|^{|S|}$ 次迭代内到达最优。

---

## 3.9 价值迭代 vs 策略迭代 —— 全面对比

| 维度 | 价值迭代 (VI) | 策略迭代 (PI) |
|------|---------------|---------------|
| **核心思想** | 迭代改进价值估计，直接逼近 $V^*$ | 迭代评估并改进策略 |
| **主要步骤** | 一步 Bellman 最优更新 | ① 完整策略评估 ② 策略改进 |
| **每次迭代做什么** | 所有状态同时做一步 lookahead 贪心更新 | 解一个线性方程组（或迭代至收敛），再贪心改进 |
| **中间价值是否有对应策略** | ❌ 不一定——$V_k$ 可能不等于任何策略的 $V^{\pi}$ | ✅ 总是对应当前策略的 $V^{\pi_k}$ |
| **单次迭代成本** | **低**（每个状态 $O(\|A\|\|S\|)$） | **高**（策略评估 $O(\|S\|^3)$ 或多次迭代） |
| **需要的迭代次数** | 多（每次改进小） | 少（每次改进大） |
| **收敛类型** | 渐近收敛到 $V^*$ | 有限步精确收敛（表格化 MDP） |
| **最佳适用场景** | 大状态空间、近似/在线设定 | 中小规模、策略评估可高效完成 |

### 形象类比

> 价值迭代 = 每次走一小步，频繁调整方向
>          → 每步便宜，但需要更多步
>
> 策略迭代 = 每一步都走彻底，想清楚了再调整方向
>          → 每步昂贵，但步子大、步数少

> 在实际中，两种算法往往结合使用：在策略评估时不迭代到完全收敛，只做几次更新（Modified Policy Iteration），平衡计算成本和收敛速度。

---

## 3.10 DP 方法的根本局限

虽然 DP 方法在理论上完美，但实际中面临两个根本限制：

1. **需要完整的环境模型**：必须知道 $p(s', r \mid s, a)$。这在绝大多数实际问题中不成立——你无法写出真实物理世界或股票市场的精确转移概率。
2. **计算复杂度随状态数增长**：每次迭代需遍历所有状态。当 $|S|$ 很大时（如图像的像素组合），完全不可行。

> 这两个局限直接推动了**无模型方法**（第四章）和**函数逼近**（第五章）的发展。但 DP 建立的 Bellman 方程、不动点迭代、策略改进等理论框架，仍是无模型方法的设计蓝图。

---

## 小结

- **Bellman 期望方程** 刻画了给定策略下价值的自洽关系，**Bellman 最优方程** 刻画了最优价值的递推关系。两者是一切 RL 算法的基础。
- **策略改进定理** 保证了"贪心改进"总能单调提升策略——只要你不是最优，贪心就能让你更好。
- **价值迭代** 直接迭代 Bellman 最优算子，利用压缩映射定理保证收敛。
- **策略迭代** 交替执行策略评估和策略改进，有限步内到达最优。
- DP 方法需要完整模型，这引出了下一章的**模型自由方法**——用采样（Monte Carlo / TD）替代对模型的依赖。

---

## 导航栏

**强化学习 系列文章**

- [第一章：什么是强化学习？](/posts/ai/reinforcement-learning/foundations/)
- [第二章：马尔可夫决策过程 (MDP)](/posts/ai/reinforcement-learning/mdp/)
- [第三章：动态规划 —— 模型已知时的精确求解](/posts/ai/reinforcement-learning/dynamic-programming/)
- [第四章：无模型方法 —— Monte Carlo 与时差学习](/posts/ai/reinforcement-learning/model-free/)
- [第五章：价值函数逼近与 Deep Q-Network](/posts/ai/reinforcement-learning/value-based-deep/)
- [第六章：策略梯度方法 —— 从 REINFORCE 到 PPO](/posts/ai/reinforcement-learning/policy-gradient/)
- [第七章：RL 前沿专题 —— LLM 对齐、推理涌现与扩散模型](/posts/ai/reinforcement-learning/llm-alignment-frontiers/)
