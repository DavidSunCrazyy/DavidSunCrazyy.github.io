---
note: true
layout: post
title: "第五章：价值函数逼近与 Deep Q-Network"
permalink: /posts/ai/reinforcement-learning/value-based-deep/
categories: reinforcement-learning
tags: [reinforcement-learning, deep-rl, dqn, function-approximation, experience-replay, target-network]
use_math: true
---

前四章的方法都是**表格化 (tabular)** 的——每个状态（或状态-动作对）在表中有一格。当状态空间是图像（Atari 游戏的像素）、连续值（机器人关节角度）、或组合爆炸（围棋棋盘）时，表格化方法彻底失效。本章介绍如何用**函数逼近**（特别是深度神经网络）来泛化价值估计，以及由此催生的 DQN 及其改进。

---

## 5.1 Q-Table 的天花板

对于表格化 Q-Learning 的 Q-Table, 当出现以下情况时，直接不可行：

| 挑战 | 例子 | 问题 |
|------|------|------|
| **状态太多** | Atari 游戏：$256^{84 \times 84 \times 3}$ 种像素组合 | 表放不下 |
| **状态连续** | 机器人关节角度 $\theta \in [-\pi, \pi]$ | 表无法离散化 |
| **需要泛化** | 两个看起来差不多的棋盘局面应该有相似的 Q 值 | 表格无法泛化 |

> **核心需求**：我们不是要记住每个 $(s, a)$ 的精确 Q 值，而是要学习一个**函数** $Q(s, a; \mathbf{w})$，能从相似的状态中提取共性。

---

## 5.2 价值函数逼近

### 状态表示

将状态表示为特征向量 $\mathbf{x}(s) = (x_1, x_2, \ldots, x_n)^T$：

- 简单环境：手工设计特征（如"到最近障碍物的距离"）
- 复杂环境：用神经网络从原始输入（如图像）自动提取特征

### 线性逼近

$$Q(s, a; \mathbf{w}) = \sum_i w_{a,i} \, x_i(s)$$

- 每个动作 $a$ 有自己的一组权重 $\mathbf{w}_a$
- 优点是凸优化（有全局最优）、计算快
- 缺点是表达能力有限——许多问题的真实 Q 函数是高度非线性的

### 非线性逼近（神经网络）

$$Q(s, a; \mathbf{w}) = \text{NeuralNet}(s, a; \mathbf{w})$$

或更常见地，输入状态 $s$，同时输出所有动作的 Q 值：

$$\mathbf{q}(s; \mathbf{w}) = [Q(s, a_1), Q(s, a_2), \ldots, Q(s, a_m)]^T$$

> 这就是 DQN 的参数化方式——一个网络同时预测所有可能动作的 Q 值，只需一次前向传播。

---

## 5.3 梯度 Q-Learning

### 监督学习的思路

训练目标：让 $Q_{\mathbf{w}}(s, a)$ 逼近最优 Q 函数 $Q^{*}(s, a)$。

由 Bellman 最优方程，目标值应为：

$$y = r + \gamma \max_{a'} Q_{\bar{\mathbf{w}}}(s', a')$$

其中 $\bar{\mathbf{w}}$ 表示**旧参数**（目标中用旧参数的原因见 5.5 节）。

### 损失函数

定义 TD 误差 $\delta = Q_{\mathbf{w}}(s, a) - \left(r + \gamma \max_{a'} Q_{\bar{\mathbf{w}}}(s', a')\right)$

**均方误差 (MSE / $\ell_2$ Loss)**：

$$L(\mathbf{w}) = \frac{1}{|B|} \sum_{(s, a, s', r) \in B} \frac{1}{2} \delta^2$$

（实践中也常用 Huber Loss——结合 MSE 在小误差时的平滑和 MAE 在大误差时的鲁棒性。）

### 梯度下降更新

$$\mathbf{w} \leftarrow \mathbf{w} - \alpha \cdot \delta \cdot \frac{\partial Q_{\mathbf{w}}(s, a)}{\partial \mathbf{w}}$$

> 这就是 **Gradient Q-Learning** 的核心形式：TD 误差 $\delta$ 作为缩放因子，梯度 $\frac{\partial Q_{\mathbf{w}}}{\partial \mathbf{w}}$ 决定调整方向。

---

## 5.4 第一个致命问题：样本相关性

### 为什么不能直接做 SGD？

监督学习中，SGD 假设 mini-batch 中的样本是 i.i.d. 的。但在 RL 中：
- 相邻时间步的样本 $(s_t, a_t, s_{t+1}, r_t)$ 和 $(s_{t+1}, a_{t+1}, s_{t+2}, r_{t+1})$ 高度相关
- 如果用这些高度相关的样本做 SGD，梯度估计的方向会严重偏向当前轨迹，导致训练极端不稳定

### 解决方案：经验回放 (Experience Replay)

将每次交互的转移存入一个**回放缓冲区 (Replay Buffer)** $\mathcal{D}$：

$$\mathcal{D} = \{(s_1, a_1, r_1, s_2), (s_2, a_2, r_2, s_3), \ldots\}$$

训练时，从 $\mathcal{D}$ 中**均匀随机采样** mini-batch。

$$
\begin{aligned}
&\textbf{循环}\quad t = 1, 2, \dots, T: \\
&\qquad a_t \leftarrow \pi(s_t) \quad \text{(选择动作并执行)} \\
&\qquad r_t \leftarrow \mathcal{R}(s_t, a_t) \quad \text{(接收即时奖励)} \\
&\qquad s_{t+1} \leftarrow \mathcal{T}(s_t, a_t) \quad \text{(观测新状态)} \\
&\qquad \mathcal{D} \leftarrow \mathcal{D} \cup \{(s_t, a_t, s_{t+1}, r_t)\} \quad \text{(加入回放缓冲区)} \\
&\qquad \mathcal{B} \sim \text{Uniform}(\mathcal{D}) \quad \text{(从缓冲区随机采样 mini-batch)} \\
&\qquad \theta \leftarrow \theta - \alpha \nabla_\theta \mathcal{L}(\mathcal{B}; \theta) \quad \text{(对 mini-batch 做梯度下降)} \\
&\qquad s_t \leftarrow s_{t+1} \quad \text{(更新状态)}
\end{aligned}
$$

**经验回放的三重好处**：

| 好处 | 原理 |
|------|------|
| **打破时序相关性** | 随机采样 → 样本近似独立 |
| **提高数据效率** | 每条经验可被多次学习 |
| **减小更新方差** | mini-batch 平均平滑了噪声 |

---

## 5.5 第二个致命问题：移动的目标

### Bootstrapping 造成的非平稳性

Q-Learning 的目标 $r + \gamma \max_{a'} Q(s', a'; \mathbf{w})$ 中包含了**正在被优化的网络参数 $\mathbf{w}$**。

这就像在追赶一个**不断移动的目标**——每次 $\mathbf{w}$ 更新后，目标也变了。这种非平稳性是训练发散的首要原因。

### 解决方案：目标网络 (Target Network)

引入一个**独立的目标网络** $Q(s, a; \bar{\mathbf{w}})$：
- 架构与在线网络完全相同
- 参数 $\bar{\mathbf{w}}$ **不参与梯度更新**
- 每隔 $C$ 步，将在线网络权重复制给目标网络：$\bar{\mathbf{w}} \leftarrow \mathbf{w}$

修正后的损失函数：

$$L(\mathbf{w}) = \mathbb{E}_{(s,a,r,s') \sim \mathcal{D}} \left[ \left( r + \gamma \max_{a'} Q(s', a'; \bar{\mathbf{w}}) - Q(s, a; \mathbf{w}) \right)^2 \right]$$

目标网络 $\bar{\mathbf{w}}$ 在 $C$ 步内保持固定 → 目标暂时稳定 → 训练可以收敛。

---

## 5.6 DQN 完整算法

> DQN = **Q-Learning + 神经网络 + 经验回放 + 目标网络**

**初始化**：回放缓冲区 $\mathcal{D}$（容量 $N$），在线网络 $Q(s, a; \mathbf{w})$（随机初始化），目标网络 $Q(s, a; \bar{\mathbf{w}})$ 且 $\bar{\mathbf{w}} \leftarrow \mathbf{w}$

对每个 episode，初始化 $s_1$，然后对每步 $t = 1, 2, \ldots$ 执行：

$$\begin{aligned}
\text{(1) 动作选择}\quad & a_t = \begin{cases}
\text{随机动作}, & \text{以概率 } \varepsilon \\
\arg\max_a Q(s_t, a; \mathbf{w}), & \text{以概率 } 1 - \varepsilon
\end{cases} \\[8pt]
\text{(2) 交互}\quad & \text{执行 } a_t \text{，观测 } r_t,\ s_{t+1} \\[4pt]
\text{(3) 存储}\quad & \text{将 } (s_t, a_t, r_t, s_{t+1}) \text{ 存入 } \mathcal{D} \\[4pt]
\text{(4) 采样}\quad & \text{从 } \mathcal{D} \text{ 随机采样 mini-batch } \{(s_j, a_j, r_j, s_{j+1})\}_{j=1}^{|B|} \\[4pt]
\text{(5) 构造目标}\quad & y_j = \begin{cases}
r_j, & \text{若 } s_{j+1} \text{ 终止} \\
r_j + \gamma \max_{a'} Q(s_{j+1}, a'; \bar{\mathbf{w}}), & \text{否则}
\end{cases} \\[8pt]
\text{(6) 梯度下降}\quad & \mathbf{w} \leftarrow \mathbf{w} - \alpha \nabla_{\mathbf{w}} \frac{1}{|B|} \sum_j \big( y_j - Q(s_j, a_j; \mathbf{w}) \big)^2 \\[4pt]
\text{(7) 目标更新}\quad & \text{每 } C \text{ 步}: \bar{\mathbf{w}} \leftarrow \mathbf{w} \\[4pt]
\text{(8) 推进}\quad & s_t \leftarrow s_{t+1}
\end{aligned}$$

> **DQN 是第一个成功将深度神经网络与 RL 结合的算法**，2015 年在 49 款 Atari 游戏上达到或超越人类水平，标志着深度强化学习时代的开启。

---

## 5.7 DQN 改进（选读）

### Double DQN —— 解决过高估计

**问题**：DQN 中的 $\max$ 操作会系统地高估 Q 值——因为我们对同一批噪声取最大值。

**解决方案**：将**动作选择**和**动作评估**解耦：

$$y = r + \gamma \, Q(s', \arg\max_{a'} Q(s', a'; \mathbf{w}); \bar{\mathbf{w}})$$

- 用**在线网络 $\mathbf{w}$** 选择最优动作（哪个动作最好？）
- 用**目标网络 $\bar{\mathbf{w}}$** 评估该动作（这个动作值多少？）

> 改动仅一行代码，显著减少过高估计偏差。近乎零成本的提升。

### Dueling DQN —— 分离价值与优势

**观察**：在很多状态中，具体选哪个动作对结果影响很小（如空旷路上向左还是向右走）。

**创新**：将 Q 网络拆为两个分支：

$$Q(s, a) = V(s) + A(s, a) - \frac{1}{|A|} \sum_{a'} A(s, a')$$

| 分支 | 含义 | 回答的问题 |
|------|------|-----------|
| $V(s)$ | 状态本身的价值 | "当前局面有多好？" |
| $A(s, a)$ | 动作的优势 | "这个动作比平均好多少？" |

> 在动作不重要的状态中，Dueling 结构使学习更高效——它不需要为每个动作单独学习相近的 Q 值，而是先学会"这个局面的整体价值"。

### 优先经验回放 (Prioritized Experience Replay)

**问题**：均匀采样对所有经验一视同仁，但有些经验（TD 误差大的）更需要学习。

**改进**：按 TD 误差的绝对值分配采样概率：

$$p_i = |\delta_i| + \epsilon, \quad P(i) = \frac{p_i^{\alpha}}{\sum_k p_k^{\alpha}}$$

- $\alpha = 0$：退化为均匀采样
- $\alpha = 1$：完全按优先级采样
- 实践推荐：$\alpha \approx 0.6$

---

## 5.8 关键超参数速查

| 参数 | 典型值 | 作用 |
|------|--------|------|
| 学习率 $\alpha$ | $10^{-4} \sim 5 \times 10^{-4}$ | 每次梯度更新的步长 |
| 折扣因子 $\gamma$ | 0.99 | 长期奖励的权重 |
| $\varepsilon$ 初始 / 最终 | 1.0 / 0.01（线性衰减） | 探索→利用的过渡 |
| 回放缓冲区容量 | $10^4 \sim 10^6$ | 历史经验的存储量 |
| Mini-batch 大小 | 32 ~ 64 | 每次梯度更新使用的样本数 |
| 目标网络更新间隔 $C$ | $10^3 \sim 10^4$ 步 | 目标稳定性的持续时间 |
| Huber Loss $\delta$ 阈值 | 1.0 | 从 MSE 切换到 MAE 的边界 |

---

## 小结

- **价值函数逼近** 使 Q-Learning 能够处理大规模/连续状态空间——用神经网络从状态中提取特征并泛化到未见过的状态。
- **经验回放** 打破样本间的时间相关性，提高数据效率和训练稳定性。
- **目标网络** 固定学习目标，解决 bootstrapping 中的非平稳性问题，是防止训练发散的关键。
- **DQN = 神经网络 + 经验回放 + 目标网络 + Q-Learning**——是深度 RL 的里程碑。
- 基于价值的方法**只适用于离散动作空间**（$\arg\max$ 操作）。对于连续动作（机器人控制、自动驾驶），我们需要**策略梯度方法**——第六章的主题。

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
