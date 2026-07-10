---
layout: post
title: "第七章：RL 前沿专题 —— LLM 对齐、推理涌现与扩散模型"
permalink: /posts/ai/reinforcement-learning/llm-alignment-frontiers/
tags: reinforcement-learning
use_math: true
---

前六章覆盖了 RL 的经典理论与算法。本章聚焦**2023-2026 年间 RL 最重要的前沿应用**——如何用 RL 让大型语言模型对齐人类偏好（RLHF → DPO → GRPO → RLVR），纯 RL 训练如何催生推理能力（DeepSeek R1），以及 RL 范式如何被移植到扩散模型（Flow GRPO）。这些内容代表了 RL 从"游戏和机器人"走向"语言智能和生成模型"的关键范式转移。

---

## 7.1 RLHF：人类反馈强化学习

### 为什么 LLM 需要对齐？

标准预训练的语言模型会生成不符合人类偏好的内容——有害言论、误导性信息、或完全无用的回答。**对齐 (Alignment)** 的目标是让模型的行为符合人类价值观和意图。

### RLHF 的三阶段管线

$$
\begin{array}{c}
\text{\Large Base LLM} \\
\text{(大规模预训练，会接续文本，但不懂指令)} \\
\Big\downarrow \\
\textbf{Stage 1: SFT (监督微调)} \\
\begin{aligned}
&\text{收集高质量 (指令, 回复) 对} \\
&\text{标准监督学习微调} \\
&\rightarrow \; \pi_{\text{SFT}} \text{：学会了遵循指令格式}
\end{aligned} \\
\Big\downarrow \\
\textbf{Stage 2: RM (奖励模型训练)} \\
\begin{aligned}
&\text{对同一 prompt 生成多个回复} \\
&\text{人类标注偏好：} A \succ B \\
&\text{训练 Bradley-Terry 偏好模型} \\
&\rightarrow \; r_\psi \text{：学会给"好回复"打高分}
\end{aligned} \\
\Big\downarrow \\
\textbf{Stage 3: PPO + KL 惩罚} \\
\begin{aligned}
&\text{用 PPO 优化 } \pi, \; r_\psi \text{ 提供奖励} \\
&\text{加入 KL 散度惩罚，防止偏离 } \pi_{\text{SFT}} \\
&\rightarrow \; \pi^* \text{：对齐后的最终模型}
\end{aligned}
\end{array}
$$

### Stage 1: 监督微调 (SFT)

- 数据：人工撰写的 (指令, 理想回复) 对
- 方法：标准交叉熵损失 $-\log \pi(y \mid x)$
- 产出：一个能基本遵循指令的模型 $\pi^{\text{SFT}}$
- **局限**：SFT 只学了"模仿"，不知道回复的"好坏"

### Stage 2: 奖励模型训练

**数据格式**：偏好对 $(x, y_w, y_l)$，其中 $y_w$ 是人类偏好的回复，$y_l$ 是被拒绝的回复。

**Bradley-Terry 偏好模型**：假设人类偏好概率由隐式奖励决定：

$$P(y_w \succ y_l \mid x) = \frac{\exp(r(x, y_w))}{\exp(r(x, y_w)) + \exp(r(x, y_l))} = \sigma(r(x, y_w) - r(x, y_l))$$

**训练损失**（二分类交叉熵）：

$$\mathcal{L}_{\text{RM}} = -\mathbb{E}_{(x, y_w, y_l) \sim D} \left[ \log \sigma \left( r_\psi(x, y_w) - r_\psi(x, y_l) \right) \right]$$

> **直觉**：RM 的学习目标是让好回复的得分显著高于差回复。$\sigma(z)$ 将得分差映射到 (0, 1) 的概率——得分差越大，$\sigma \to 1$，loss → 0。

**RM 架构**：通常在 SFT 模型最后加一个标量输出头，将最后一层 hidden state 映射到一个标量奖励。

### Stage 3: PPO + KL 惩罚

用 PPO（第六章）优化策略，奖励模型 $r_\psi$ 提供信号，同时加入 KL 散度惩罚：

**优化目标**：

$$\max_\theta \; \mathbb{E}_{x \sim D, y \sim \pi_\theta(\cdot \mid x)} \left[ r_\psi(x, y) - \beta \, D_{\text{KL}}\left( \pi_\theta(\cdot \mid x) \parallel \pi^{\text{SFT}}(\cdot \mid x) \right) \right]$$

加上预训练梯度混合（PPO-ptx）：

$$\text{objective}(\theta) = \mathbb{E}_{(x,y) \sim D_{\pi_\theta}} \left[ r_\psi(x,y) - \beta \log \frac{\pi_\theta(y \mid x)}{\pi^{\text{SFT}}(y \mid x)} \right] + \gamma \, \mathbb{E}_{x \sim D_{\text{pretrain}}} \left[ \log \pi_\theta(x) \right]$$

| 项 | 作用 | 权重 |
|----|------|------|
| $r_\psi(x, y)$ | 质量信号（RM 奖励） | 1 |
| $-\beta \cdot \text{KL}$ | 防止 reward hacking（策略钻 RM 空子） | $\beta \approx 0.02 \sim 0.1$ |
| $\gamma \cdot \log \pi_\theta(x)$ | 保持预训练能力，防止"遗忘世界知识" | $\gamma$ 较小 |

### RLHF 大规模验证

ChatGPT、Claude、Gemini 等模型均使用了 RLHF（或其变体）。截至目前仍是对齐领域经过最多工程验证的方法。

| 优点 | 缺点 |
|------|------|
| 直接优化人类偏好 | 三阶段流程复杂，工程量大 |
| 效果经过大规模验证 | 人类标注成本极高 |
| RM 推理速度快 | Reward hacking 风险（模型学会写高分但无意义的内容） |

---

## 7.2 DPO：直接偏好优化

### 动机：能不能不训练 RM？

RLHF 最大的痛点是**复杂**：三个独立阶段 + 分别调参 + RM 和 Policy 两个大模型。DPO 从根本上改变了范式：**偏好数据中已经隐含了奖励信息**——不需要显式训练 RM。

### 核心推导

从 RLHF 的 KL 正则化目标出发：

$$\max_{\pi_\theta} \; \mathbb{E}_{x, y \sim \pi_\theta} [r(x, y)] - \beta D_{\text{KL}}(\pi_\theta \parallel \pi_{\text{ref}})$$

这个问题的**最优解有解析形式**：

$$\pi_r(y \mid x) = \frac{1}{Z(x)} \pi_{\text{ref}}(y \mid x) \exp\left( \frac{1}{\beta} r(x, y) \right)$$

反过来解出奖励：

$$r(x, y) = \beta \log \frac{\pi_r(y \mid x)}{\pi_{\text{ref}}(y \mid x)} + \beta \log Z(x)$$

将这个奖励表达式代入 Bradley-Terry 偏好模型。配分函数 $Z(x)$ 在偏好概率的分子分母中相互抵消：

$$P(y_w \succ y_l \mid x) = \frac{1}{1 + \exp\left( \beta \log \frac{\pi^*(y_l \mid x)}{\pi_{\text{ref}}(y_l \mid x)} - \beta \log \frac{\pi^*(y_w \mid x)}{\pi_{\text{ref}}(y_w \mid x)} \right)}$$

### DPO 损失函数

直接最大化偏好似然，得到 DPO loss：

$$\boxed{\mathcal{L}_{\text{DPO}}(\pi_\theta; \pi_{\text{ref}}) = -\mathbb{E}_{(x, y_w, y_l) \sim D} \left[ \log \sigma\left( \beta \log \frac{\pi_\theta(y_w \mid x)}{\pi_{\text{ref}}(y_w \mid x)} - \beta \log \frac{\pi_\theta(y_l \mid x)}{\pi_{\text{ref}}(y_l \mid x)} \right) \right]}$$

**直观含义**：
- 提高优选回复 $y_w$ 的**相对**对数概率
- 降低劣选回复 $y_l$ 的**相对**对数概率
- "相对"意味着与参考模型 $\pi_{\text{ref}}$ 比较——这提供了正则化，防止模型偏离太远

### DPO vs RLHF 对比

| 维度 | RLHF | DPO |
|------|------|-----|
| 阶段数 | 3（SFT → RM → PPO） | **2（SFT → DPO）** |
| 需要训练 RM | 是 | **否** |
| 需要 RL (PPO) | 是 | **否**（纯监督学习！） |
| 训练稳定性 | 中（PPO 可能不稳定） | **高**（标准交叉熵） |
| 实现难度 | 复杂（需要四个模型协同） | **简单**（两个模型 + 一个 loss） |
| 效果 | 好（经过大量验证） | 持平或更好（尤其在中小规模） |
| $\beta$ 超参数 | KL 惩罚系数 | 偏好强度控制 |

> **DPO 的本质**：不需要显式学习奖励函数，而是直接从偏好对中学习——"谁说一定要先学评分再优化？偏好比较本身就告诉了你该怎么优化。"

### 实验结果

原始 DPO 论文在两个关键维度上展示了其优势：

1. **奖励-KL 前沿 (Reward-KL Frontier)**：对所有 KL 散度值（衡量策略偏离参考模型的程度），DPO 提供的期望奖励都高于或等于 PPO——即 DPO 在相同的"偏离预算"下获得了更好的对齐效果，证明其优化质量优于 PPO。

2. **TL;DR 摘要胜率**：以 GPT-4 作为评判器，DPO 生成的摘要 vs 人工撰写的摘要的胜率超过了 PPO 的最佳配置，同时 DPO 对采样温度 (temperature) 的变化更加鲁棒——PPO 在温度偏离最优值时性能急剧下降，而 DPO 保持稳定。

> DPO 的实证结果表明：简单的方法不仅更易实现，效果也可以更优。这推动了 DPO 及其变体（如 IPO、KTO）在 2023-2024 年间迅速成为 LLM 对齐的主流选择。

### 关键超参数 $\beta$

| $\beta$ | 效果 |
|---------|------|
| 0.05（低） | 弱偏好信号，策略变化小，训练稳定但慢 |
| **0.1 ~ 0.2**（推荐） | 平衡——实践中效果最好 |
| 0.5（高） | 强偏好信号，变化激进，可能不稳定 |

---

## 7.3 GRPO：群体相对策略优化

### 问题：PPO 的 V-Critic 在 LLM 中是累赘

PPO 为**连续控制**设计，其价值网络 $V_\phi$ 在 LLM 场景中很不自然：

- **额外开销**：大型 V-Critic 通常与 Policy 规模相近，训练和推理成本翻倍
- **价值估计不准**：长文本生成（数千 tokens）中，$V_\phi(s_t)$ 的估计误差大
- **稀疏奖励**：LLM 的奖励通常是**整个回复生成后才给出**（episode-level），中间步骤没有信号

### GRPO 的核心创新：组内标准化

对同一个 prompt $x$，**同时采样 $N$ 个完整的回复** $\{y_1, \ldots, y_N\}$，用 RM 对每个回复打分 $\{r_1, \ldots, r_N\}$。然后**组内标准化**：

$$\boxed{A_i = \frac{r_i - \text{mean}(\{r_1, \ldots, r_N\})}{\text{std}(\{r_1, \ldots, r_N\})}}$$

这个标准化后的 $A_i$ 就是 GRPO 的优势估计——**不需要 V-Critic**，组内相对比较即可。

### PPO vs GRPO 架构对比


**PPO（近端策略优化）**

流程：
1. **Actor π** 生成动作
2. **Critic V**（一个独立的价值网络）估计优势函数 $A_t$
3. 用 $A_t$ 更新 Actor $π$
4. Critic V 本身也需要训练（额外的大模型开销）


**GRPO（群体相对策略优化）**

流程：
1. **Actor π** 对同一个问题采样 **N 个回复**
2. 对这 N 个回复进行 **组内标准化**（减去均值，除以标准差）得到 $A_i$
3. 用 $A_i$ 更新 Actor $π$
4. **不需要额外的 Critic 模型**


### GRPO 算法

**输入**：一批 prompts $\{x_1, x_2, \ldots\}$，组大小 $N$

对每次迭代，每个 prompt $x$：

$$\begin{aligned}
\text{(1)}\quad & \text{生成 } N \text{ 个回复 } \{y_1, y_2, \ldots, y_N\} \sim \pi_\theta(\cdot \mid x) \\[4pt]
\text{(2)}\quad & \text{用 RM 打分: } \{r_1, r_2, \ldots, r_N\} \\[4pt]
\text{(3)}\quad & A_i = \frac{r_i - \text{mean}(\{r_1, \ldots, r_N\})}{\text{std}(\{r_1, \ldots, r_N\}) + \varepsilon}, \quad i = 1, \ldots, N \\[4pt]
\text{(4)}\quad & \mathcal{L} = -\frac{1}{N} \sum_{i=1}^{N} A_i \cdot \log \pi_\theta(y_i \mid x) \\[4pt]
\text{(5)}\quad & \theta \leftarrow \theta + \alpha \, \nabla_\theta \mathcal{L}
\end{aligned}$$

> **GRPO 去掉了整个价值网络**——对于 LLM 这意味着节省近一半的 GPU 内存，使更大规模的训练成为可能。

### 组大小建议

| N | 方差 | 计算成本 | 推荐度 |
|----|------|----------|--------|
| 2 | 高 | 低 | 不推荐 |
| **4** | 中 | 适中 | **推荐默认** |
| 8 | 低 | 较高 | 预算充足时使用 |
| 16 | 很低 | 高 | 通常过度 |

---

## 7.4 RLVR：可验证奖励的强化学习

### 从人类偏好到客观验证

RLHF / RLAIF 依赖人类或 AI 的**主观判断**。RLVR 则完全不同——奖励由**客观、外部的任务特定验证器**自动给出：

$$r(y, x) = \begin{cases} 1, & \text{答案通过验证器} \\ 0, & \text{否则} \end{cases}$$

### 常见可验证任务

| 任务类型 | 验证方式 | 为什么是"可验证的" |
|----------|----------|-------------------|
| **数学题** | 最终答案是否与标准答案一致 | 答案有确定的对错 |
| **编程** | 代码是否通过单元测试 | 测试用例的通过是客观的 |
| **定理证明** | 证明是否被证明检查器接受 | 形式验证系统给出二进制判定 |
| **结构化 QA** | 是否满足确定性约束 | 约束可机器验证 |

### RLVR vs 人类偏好奖励

| 维度 | 人类偏好奖励 | 可验证奖励 |
|------|-------------|-----------|
| 成本 | 高（需要人类标注） | **低**（自动验证） |
| 模糊性 | 有（偏好是主观的） | **无**（对错分明） |
| 可复现性 | 取决于标注者 | **完全可复现** |
| Reward Model Drift | 有风险 | **不存在** |

### RLVR vs 监督 CoT 数据

| 维度 | 监督 CoT | RLVR |
|------|----------|------|
| 是否需要人工推理轨迹 | 是 | **否** |
| 是否允许探索新策略 | 否（只能模仿标注者） | **是**（只要答案正确） |
| 奖励信号 | 逐 token 的交叉熵 | 最终答案的可验证奖励 |
| 可能发现的推理风格 | 限于人类标注者 | **可能超越人类**（见 7.5 节） |

### RLVR 的核心挑战：稀疏延迟奖励

> 一条长达数千 token 的思维链 (Chain-of-Thought)，只有**最后几个 token 的答案**是直接被验证的。如何让这稀疏的最终奖励反向传播，改善整个推理过程？

这正是 DeepSeek R1 要回答的问题（7.5 节）。

### 形式化 RLVR 过程

给定 prompt $x$，策略模型从中采样回复：

$$y \sim \pi_\theta(\cdot \mid x)$$

验证器对完整回复给出标量奖励：

$$r(x, y) \in \{0, 1\} \quad \text{或} \quad r(x, y) \in \mathbb{R}$$

> 注意奖励的**终端性 (terminal)**：$r(x, y)$ 只在生成的最后一个 token 之后才被计算。这意味着在生成长度为 $L$ 的回复时，前 $L-1$ 步的奖励均为 0，只有第 $L$ 步获得非零信号——这正是 RLVR 面临的核心困难。

### KL 正则化形式

与 RLHF 类似，RLVR 通常也加入 KL 惩罚防止策略偏离太远：

$$\max_\theta \; \mathbb{E}_{x, y \sim \pi_\theta} [r(x, y)] - \beta D_{\text{KL}}(\pi_\theta(\cdot \mid x) \parallel \pi_{\text{ref}}(\cdot \mid x))$$

---

## 7.5 DeepSeek R1：纯 RL 催生的推理涌现

### 核心发现

DeepSeek R1 展示了 RL 在 LLM 中一个令人震惊的现象：**仅用可验证奖励做 RL 训练（不依赖人工推理示范），模型会自行发展出复杂推理能力**。这些能力不是被"教"出来的，而是被"逼"出来的——RL 的压力使模型在探索中自发发现了有效的思维策略。

### 涌现的三种推理行为

#### ① 自我反思 (Self-Reflection)

模型在生成过程中**暂停、质疑自己之前的步骤、发现不一致、并修正解法**。

**典型表现**：
- "等等，这个假设可能是错的。"
- 重新计算某个代数步骤
- 发现矛盾后回到之前的推理分支

#### ② 内部验证 (Internal Verification)

模型**检查推导出的答案是否满足原始约束**——不需要外部验证器。

**常见形式**：
- 把解代回方程验证
- 测试边界情况
- 对代码做"脑内单元测试"
- 检查量纲或奇偶约束
- 确认最终答案格式匹配验证器要求

#### ③ 动态策略适应 (Dynamic Strategy Adaptation)

当前推理路径看起来前景不好时，模型**在生成过程中主动切换策略**。

**典型表现**：
- 从暴力枚举切换到不变性推理
- 用几何解释替换代数操作
- 用一个小例子推断模式
- 发现矛盾后放弃当前分支
- 对更难的 prompt 分配更多 token

### 意义

> DeepSeek R1 证明了：**即使只有 sparse terminal reward，纯 RL 也能催生出复杂、类人的推理行为**。这些行为不是设计出来的，而是在奖励压力下涌现的——这印证了 RL 作为"一般性智能优化框架"的深层潜力。

---

## 7.6 RL for Diffusion Models：扩散模型强化学习

### 将扩散过程映射为 MDP

经典 RL 和扩散模型的去噪过程之间存在精确的结构对应：

| 经典 RL | 扩散模型去噪采样器 |
|---------|-------------------|
| 状态 $s_t$ | $s_k = (c, t_k, \mathbf{x}_k)$——条件、时间步、当前噪声图像 |
| 动作 $a_t$ | $a_k = \mathbf{x}_{k-1}$——去噪一步后的图像 |
| 策略 $\pi_\theta(a_t \mid s_t)$ | $p_{\theta,k}(\mathbf{x}_{k-1} \mid \mathbf{x}_k, c)$——去噪转移核 |
| 奖励 $r_t$ | $r(\mathbf{x}_0, c)$——**只在最终图像上给出**（terminal reward） |
| 轨迹 | $\mathbf{x}_T \to \mathbf{x}_{T-1} \to \cdots \to \mathbf{x}_0$——纯噪声到清晰图像 |

> 一旦将扩散反过程离散化，它就成为一个标准的 MDP——每个去噪步是一个决策，最终图像质量为奖励。这为将 RL 方法引入扩散模型训练打开了大门。

### Flow GRPO

GRPO（7.3 节）的思想被扩展到扩散模型训练中：

**算法流程**：

$$\begin{aligned}
\text{①}\quad & \text{对每个 prompt } c \text{，采样 } N \text{ 条去噪轨迹:} \\[4pt]
&\quad \mathbf{x}_T \to \mathbf{x}_{T-1} \to \cdots \to \mathbf{x}_0^{(i)}, \quad i = 1, \ldots, N \\[8pt]
\text{②}\quad & \text{将终端图像 } \mathbf{x}_0^{(i)} \text{ 解码} \\[4pt]
\text{③}\quad & r_i = R(\mathbf{x}_0^{(i)}, c) \quad \text{(奖励模型或验证器)} \\[4pt]
\text{④}\quad & \hat{A}_i = \frac{r_i - \text{mean}(\{r_1, \ldots, r_N\})}{\text{std}(\{r_1, \ldots, r_N\}) + \varepsilon} \quad \text{(组内标准化，与 GRPO 一致)} \\[4pt]
\text{⑤}\quad & \text{对轨迹 } i \text{ 中所有去噪步骤施加同一优势 } \hat{A}_i
\end{aligned}$$

**结构局限**：Flow GRPO 提供了 RL 的训练机制，但**信用分配信号在时间维度上是扁平的**——整条去噪轨迹使用同一个优势值 $\hat{A}^i$，无法区分哪些去噪步更关键。

> 这是当前活跃的研究前沿：如何为扩散模型的去噪链设计更精细的时间信用分配机制。

---

## 7.7 全景对比：对齐方法一览

| 方法 | RL 类型 | 需要 RM？ | 需要 Critic？ | 流程复杂度 | LLM 适配度 | 核心创新 |
|------|---------|----------|--------------|-----------|-----------|----------|
| **RLHF** | PPO + KL | ✅ 显式 RM | ✅ V-Critic | 高（三阶段） | 中 | 开创性对齐框架 |
| **RLAIF** | PPO + KL | ✅（AI 训练） | ✅ V-Critic | 高 | 中 | AI 替代人类标注 |
| **DPO** | 监督学习 | ❌ | ❌ | **低** | **高** | 消除 RM，直接优化偏好 |
| **GRPO** | 策略梯度 | ✅ 外部 RM | ❌ | 中 | **高** | 消除 Critic，组内标准化 |
| **RLVR** | 任意 PG | ❌（用验证器） | 取决于方法 | 低 | **高** | 客观可验证奖励 |

---

## 7.8 前沿方向与开放问题

### ① 稀疏奖励的信用分配

RLVR 和 Flow GRPO 的核心瓶颈相同：**稀疏的终端奖励如何有效地反向传播到每一步决策？** 这要求模型发展出内部信用分配机制，DeepSeek R1 展示了这种可能性但尚未被完全理解。

### ② 奖励设计的自动化

从 RLHF（人类设计 RM）→ DPO（隐式奖励）→ RLVR（验证器 = 奖励），趋势是**奖励函数越来越客观和自动化**。下一步可能是模型自主定义和分解复杂目标。

### ③ 跨模态 RL

扩散 RL（7.6 节）将 RL 从语言扩展到图像/视频/3D 生成，但当前的方法还很初步——如何设计更有效的 per-step 信用分配仍是开放问题。

### ④ RL 与推理的深层关系

DeepSeek R1 提出的核心问题：**为什么 RL 压力会导致推理能力的涌现，而监督学习不会？** 这可能与 RL 的探索机制和奖励信号的"稀疏压力"密切相关——一个可能的方向是"信息论 + RL"的交叉分析。

---

## 小结

- **RLHF** 奠定了 LLM 对齐的方法论基础：SFT → 偏好建模 → PPO 优化。ChatGPT、Claude 均基于此架构。
- **DPO** 证明了奖励模型不是必需的——偏好数据直接优化策略即可，大幅简化流程。
- **GRPO** 去掉了价值网络 —— 组内标准化替代 Critic 的优势估计，专为 LLM 设计。
- **RLVR** 用客观验证器替代主观偏好 —— 数学、代码、定理证明等任务成本更低、可复现性更强。
- **DeepSeek R1** 展示了 RL 的深层力量：纯 RL + 可验证奖励可以催生自我反思、内部验证、动态策略切换等类人推理行为。
- **扩散模型 RL** 将 RL 范式扩展到图像生成领域，但时间信用分配问题仍是活跃研究前沿。

> RL 正在从"游戏和机器人"的工具发展为"通用智能优化"的框架——语言、推理、视觉生成，所有序列决策问题都是潜在的 RL 应用场景。
