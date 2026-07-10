---
layout: post
title: "第六章：策略梯度方法 —— 从 REINFORCE 到 PPO"
permalink: /posts/ai/reinforcement-learning/policy-gradient/
tags: reinforcement-learning
use_math: true
---

第五章的 DQN 及其变体只能处理离散动作。对于连续动作空间（机器人关节力矩、自动驾驶方向盘转角），$\arg\max_a Q(s, a)$ 不可行。策略梯度方法**直接参数化并优化策略 $\pi_\theta(a \mid s)$**，天然支持连续动作和随机策略。本章从最基本的 REINFORCE 出发，逐步引入 Actor-Critic、GAE、TRPO，最终到达现代 RL 的事实标准——PPO。

---

## 6.1 为什么需要策略梯度？

### 基于价值的方法的三大局限

1. **离散动作限制**：$\arg\max_a Q(s,a)$ 在连续动作空间中不可行——你不可能枚举所有的方向盘转角
2. **只能产生确定性策略**：$\pi(s) = \arg\max_a Q(s,a)$ 本质上不输出概率分布。在部分可观测环境或博弈中，随机性是必需的（不能让对手预测）
3. **微小的价值变化可能导致策略突变**：$Q(s,a)$ 稍微变化，$\arg\max$ 可能从一个动作跳到另一个——这种不连续性使训练不稳定

### 策略梯度方法的优势与劣势

| 优势 | 劣势 |
|------|------|
| 天然支持连续动作空间 | 通常收敛到局部最优而非全局最优 |
| 可以学习随机策略 | 策略评估通常高方差且低效 |
| 更好的收敛性质（平滑更新） | 梯度估计的噪声较大 |

---

## 6.2 策略的参数化

### 离散动作：Softmax 策略

$$\pi_\theta(a \mid s) = \frac{\exp(h(s, a; \theta))}{\sum_{a'} \exp(h(s, a'; \theta))}$$

其中 $h(s, a; \theta)$ 是偏好函数（可以是线性组合 $\sum_i \theta_i f_i(s, a)$ 或神经网络）。

### 连续动作：高斯策略

$$\pi_\theta(a \mid s) = \mathcal{N}(a; \mu_\theta(s), \Sigma_\theta(s))$$

- 网络输出均值 $\mu_\theta(s)$（如方向盘的最佳转角）
- 网络输出方差 $\Sigma_\theta(s)$（表示该状态下探索的"信心"）

---

## 6.3 策略梯度定理

### 目标函数

策略优化目标是最大化期望累积回报：

$$J(\theta) = \mathbb{E}_{\tau \sim \pi_\theta}[G_0] = \mathbb{E}_{s_0 \sim \rho_0}\left[ V^{\pi_\theta}(s_0) \right]$$

其中轨迹 $\tau = (s_0, a_0, r_0, s_1, a_1, r_1, \ldots)$ 是按 $\pi_\theta$ 与环境交互生成的。

---

#### 等价形式：平稳分布

上面的定义依赖对轨迹的采样，不方便直接分析。利用策略 $\pi_\theta$ 诱导的**折扣平稳状态分布 (Discounted Stationary State Distribution)**：

$$d^{\pi_\theta}(s) = (1 - \gamma) \sum_{t=0}^{\infty} \gamma^t \, P(s_t = s \mid \pi_\theta)$$

**含义**：$d^{\pi_\theta}(s)$ 是按 $\gamma$ 折扣加权后，智能体在状态 $s$ 上花费时间的"比例"。前置因子 $(1 - \gamma)$ 确保 $\sum_s d^{\pi_\theta}(s) = 1$，使其成为一个合法的概率分布。

**推导**：将 $J(\theta)$ 从轨迹期望展开为时序期望：

$$J(\theta) = \mathbb{E}_{\tau \sim \pi_\theta}\left[ \sum_{t=0}^{\infty} \gamma^t r_t \right] = \sum_{t=0}^{\infty} \gamma^t \, \mathbb{E}_{s_t \sim P(\cdot \mid \pi_\theta), a_t \sim \pi_\theta}\big[ r(s_t, a_t) \big]$$

引入 $d^{\pi_\theta}$ 的定义，将无穷级数压缩为单步期望：

$$\sum_{t=0}^{\infty} \gamma^t \, \mathbb{E}_{s_t}\big[ f(s_t) \big] = \frac{1}{1 - \gamma} \sum_s d^{\pi_\theta}(s) f(s) = \frac{1}{1 - \gamma} \, \mathbb{E}_{s \sim d^{\pi_\theta}}\big[ f(s) \big]$$

令 $f(s) = \mathbb{E}_{a \sim \pi_\theta(a \mid s)}[r(s, a)]$，即得 $J(\theta)$ 的**平稳分布形式**：

$$J(\theta) = \frac{1}{1 - \gamma} \, \mathbb{E}_{s \sim d^{\pi_\theta}, a \sim \pi_\theta(a \mid s)} \big[ r(s, a) \big]$$

> **直觉**：$\frac{1}{1-\gamma}$ 是无穷级数的归一化因子——若每步奖励恒为 1，则 $\sum_t \gamma^t = \frac{1}{1-\gamma}$。平稳分布形式的好处是：它把"对轨迹求期望"变成了"对单个状态-动作对求期望"，后续求梯度时更干净。

### 核心定理

> **[策略梯度定理]**
>
> $$\boxed{\nabla_\theta J(\theta) = \frac{1}{1 - \gamma} \mathbb{E}_{s \sim d^{\pi_\theta}, a \sim \pi_\theta(a \mid s)} \left[ \nabla_\theta \log \pi_\theta(a \mid s) \cdot Q^{\pi_\theta}(s, a) \right]}$$

**直觉解读**：

- $\nabla_\theta \log \pi_\theta(a \mid s)$：**得分函数 (Score Function)**——指向提高动作 $a$ 概率的方向
- $Q^{\pi_\theta}(s, a)$：动作 $a$ 的"质量权重"
- 乘积含义：**好动作（$Q$ 大）增加概率，坏动作（$Q$ 小）减少概率**

> 这是整个策略优化范式的基石。后续所有方法（REINFORCE、Actor-Critic、TRPO、PPO）都只是这个定理的不同实现方式。

### 完整推导

下面给出策略梯度定理的逐步完整证明。

---

**Step 1 —— 将目标函数写成轨迹期望**

策略优化的目标是最大化期望累积回报：

$$J(\theta) = \mathbb{E}_{\tau \sim \pi_\theta}[R(\tau)] = \int p^{\pi_\theta}(\tau) \, R(\tau) \, d\tau$$

其中 $R(\tau) = \sum_{t=0}^{T-1} \gamma^t r_t$（有限 horizon）或 $R(\tau) = \sum_{t=0}^{\infty} \gamma^t r_t$（无限 horizon），$p^{\pi_\theta}(\tau)$ 是在策略 $\pi_\theta$ 下生成轨迹 $\tau$ 的概率密度。

---

**Step 2 —— 梯度穿过积分**

$\theta$ 仅出现在 $p^{\pi_\theta}(\tau)$ 中，$R(\tau)$ 不直接依赖 $\theta$（奖励由环境给出），因此可将梯度移入积分：

$$\nabla_\theta J(\theta) = \int \nabla_\theta p^{\pi_\theta}(\tau) \, R(\tau) \, d\tau$$

---

**Step 3 —— 似然比技巧 (Likelihood Ratio Trick)**

这是整个推导中最关键的一步。直接对 $p^{\pi_\theta}(\tau)$ 求梯度不方便，但注意到恒等式：

$$\nabla_\theta \log p^{\pi_\theta}(\tau) = \frac{\nabla_\theta p^{\pi_\theta}(\tau)}{p^{\pi_\theta}(\tau)}$$

移项即得：

$$\boxed{\nabla_\theta p^{\pi_\theta}(\tau) = p^{\pi_\theta}(\tau) \, \nabla_\theta \log p^{\pi_\theta}(\tau)}$$

代入 Step 2：

$$\nabla_\theta J(\theta) = \int p^{\pi_\theta}(\tau) \, \nabla_\theta \log p^{\pi_\theta}(\tau) \, R(\tau) \, d\tau = \mathbb{E}_{\tau \sim \pi_\theta}\Big[ \nabla_\theta \log p^{\pi_\theta}(\tau) \cdot R(\tau) \Big]$$

> **直觉**：我们无法对采样过程本身求导（轨迹是从环境中"滚出来"的），但可以对生成轨迹的**概率**求导，再按概率加权平均。这就是"似然比"名称的由来——$\frac{\nabla_\theta p}{p}$ 是概率"相对变化率"。

---

**Step 4 —— 展开轨迹的对数概率**

轨迹 $\tau = (s_0, a_0, r_0, s_1, a_1, r_1, \ldots, s_{T-1}, a_{T-1}, r_T)$ 的联合概率为初始状态分布、各步策略、各步环境转移的乘积：

$$p^{\pi_\theta}(\tau) = \rho_0(s_0) \prod_{t=0}^{T-1} \pi_\theta(a_t \mid s_t) \, P(s_{t+1} \mid s_t, a_t)$$

取对数后乘积化为求和：

$$\log p^{\pi_\theta}(\tau) = \underbrace{\log \rho_0(s_0)}_{\text{初始分布}} + \sum_{t=0}^{T-1} \Big[ \underbrace{\log \pi_\theta(a_t \mid s_t)}_{\text{策略项}} + \underbrace{\log P(s_{t+1} \mid s_t, a_t)}_{\text{环境转移项}} \Big]$$

---

**Step 5 —— 对 $\theta$ 求梯度：环境项消去**

$$\nabla_\theta \log p^{\pi_\theta}(\tau) = \nabla_\theta \log \rho_0(s_0) + \sum_{t=0}^{T-1} \Big[ \nabla_\theta \log \pi_\theta(a_t \mid s_t) + \nabla_\theta \log P(s_{t+1} \mid s_t, a_t) \Big]$$

- $\nabla_\theta \log \rho_0(s_0) = 0$（初始分布与策略参数无关）
- $\nabla_\theta \log P(s_{t+1} \mid s_t, a_t) = 0$（环境转移概率与策略参数无关）

只剩策略项：

$$\boxed{\nabla_\theta \log p^{\pi_\theta}(\tau) = \sum_{t=0}^{T-1} \nabla_\theta \log \pi_\theta(a_t \mid s_t)}$$

> **这是策略梯度简洁性的来源**：不需要知道环境模型（$P$ 和 $\rho_0$），梯度完全由策略的对数概率决定。这也意味着策略梯度天然是 **model-free** 的。

---

**Step 6 —— 代入得到轨迹形式的梯度**

$$\nabla_\theta J(\theta) = \mathbb{E}_{\tau \sim \pi_\theta}\left[ \left( \sum_{t=0}^{T-1} \nabla_\theta \log \pi_\theta(a_t \mid s_t) \right) \cdot R(\tau) \right]$$

写成期望下的逐项求和：

$$\nabla_\theta J(\theta) = \mathbb{E}_{\tau \sim \pi_\theta}\left[ \sum_{t=0}^{T-1} \nabla_\theta \log \pi_\theta(a_t \mid s_t) \cdot R(\tau) \right]$$

---

**Step 7 —— 因果性简化：用 $Q$ 替代 $R(\tau)$**

上面的公式中，$R(\tau)$ 是整个轨迹的总回报，但 $t$ 时刻的动作 $a_t$ 只影响 $t$ 及之后的奖励，不影响 $t$ 之前的奖励。利用这一因果性：

$$\mathbb{E}_{\tau \sim \pi_\theta}\Big[ \nabla_\theta \log \pi_\theta(a_t \mid s_t) \cdot r_{t'} \Big] = 0 \quad \text{对所有 } t' < t$$

因此可以用"从 $t$ 开始的期望回报"（即 $Q$ 函数）替代 $R(\tau)$，而不改变期望值：

$$\boxed{\nabla_\theta J(\theta) = \mathbb{E}_{\tau \sim \pi_\theta}\left[ \sum_{t=0}^{T-1} \nabla_\theta \log \pi_\theta(a_t \mid s_t) \cdot Q^{\pi_\theta}(s_t, a_t) \right]}$$

> 这一步将 **MC 回报 $R(\tau)$ 替换为条件期望 $Q(s,a)$**，在不引入偏差的前提下降低了梯度估计的方差。

---

**Step 8 —— 平稳分布形式（策略梯度定理的标准表述）**

将 Step 7 的结果代入前面"目标函数"一节定义的折扣平稳状态分布 $d^{\pi_\theta}(s)$ 及其性质 $\mathbb{E}_{\tau}[\sum_t \gamma^t f(s_t)] = \frac{1}{1-\gamma}\mathbb{E}_{s \sim d^{\pi_\theta}}[f(s)]$，令 $f(s) = \mathbb{E}_{a \sim \pi_\theta}[\nabla_\theta \log \pi_\theta(a|s) \cdot Q^{\pi_\theta}(s,a)]$，即得定理的标准形式：

$$\boxed{\nabla_\theta J(\theta) = \frac{1}{1 - \gamma} \, \mathbb{E}_{s \sim d^{\pi_\theta}, a \sim \pi_\theta(a \mid s)} \Big[ \nabla_\theta \log \pi_\theta(a \mid s) \cdot Q^{\pi_\theta}(s, a) \Big]}$$

---

**证明要点回顾**：

| 步骤 | 关键操作 | 核心洞察 |
|:----:|---------|---------|
| 1–3 | 似然比技巧 | 将对采样过程的求导转化为对概率密度的求导 |
| 4–5 | 展开 $\log p(\tau)$ 并求导 | 环境模型不依赖 $\theta$，梯度仅来自策略项 → model-free |
| 6–7 | 因果性简化 | $Q(s,a)$ 替代 $R(\tau)$，降方差不引入偏差 |
| 8 | 平稳分布重写 | 将时序期望压缩为标准形式 |

> 策略梯度定理是整个策略优化范式的基石。后续所有方法——REINFORCE、Actor-Critic、TRPO、PPO——本质上都是对这个定理中 $Q^{\pi_\theta}(s,a)$ 的不同估计方式和优化策略。

---

## 6.4 REINFORCE（Monte Carlo 策略梯度）

### 算法

最基本的实现——用 Monte Carlo 完整回报 $G_t$ 替代 $Q^{\pi_\theta}(s_t, a_t)$：

**更新规则**：

$$\theta \leftarrow \theta + \alpha \, \nabla_\theta \log \pi_\theta(a_t \mid s_t) \, G_t$$

其中 $G_t = \sum_{k=0}^{T-t} \gamma^k r_{t+k}$。

**REINFORCE 算法**：初始化策略参数 $\theta$。对每个 episode：

$$\begin{aligned}
\text{(1)}\quad & \text{用 } \pi_\theta \text{ 生成完整轨迹 } (s_0, a_0, r_1, \ldots, s_{T-1}, a_{T-1}, r_T) \\[4pt]
\text{(2)}\quad & \text{对 } t = 0, 1, \ldots, T-1: \\[4pt]
&\quad G_t \leftarrow \sum_{k=0}^{T-t} \gamma^k r_{t+k} \\[4pt]
&\quad \theta \leftarrow \theta + \alpha \, \nabla_\theta \log \pi_\theta(a_t \mid s_t) \, G_t
\end{aligned}$$

### 优缺点

| 优点 | 缺点 |
|------|------|
| 最简单的 PG 方法 | **方差极高**——$G_t$ 涉及整条轨迹的随机性 |
| 无偏梯度估计 | 样本效率极低 |
| 适用于任何可微策略 | 每 episode 只能更新一次 |

> REINFORCE 方差高的原因：假设某个动作确实是好动作，但轨迹中后续出现了不相关的坏运气（如对手碰巧打出了妙手），$G_t$ 会很小，模型反而降低这个好动作的概率。这就是**信用分配混杂**。

---

## 6.5 方差缩减 I：Baseline 减法

### 核心技巧

在梯度中减去一个**仅依赖状态 $s$ 的基线函数 $B(s)$**：

$$\nabla_\theta J(\theta) = \mathbb{E}_{\pi_\theta} \left[ \nabla_\theta \log \pi_\theta(a \mid s) \cdot \left( Q^{\pi_\theta}(s, a) - B(s) \right) \right]$$

### 为什么不引入偏差？

$$\mathbb{E}_{\pi_\theta} \left[ \nabla_\theta \log \pi_\theta(a \mid s) B(s) \right] = \mathbb{E}_{s \sim d^{\pi_\theta}} \left[ B(s) \nabla_\theta \sum_a \pi_\theta(a \mid s) \right] = \mathbb{E}_{s \sim d^{\pi_\theta}} \left[ B(s) \cdot 0 \right] = 0$$

> 因为 $\sum_a \pi_\theta(a \mid s) = 1$ 对任意 $\theta$ 成立，其梯度恒为零。减去 $B(s)$ 不改变期望——**无偏性不变，方差大幅降低**。

### 最优基线

最重要的选择：**$B(s) = V^{\pi_\theta}(s)$ 是最佳基线**。此时括号内恰为**优势函数 (Advantage Function)**：

$$A^{\pi_\theta}(s, a) = Q^{\pi_\theta}(s, a) - V^{\pi_\theta}(s)$$

- $A > 0$：动作比平均水平好 → 增加其概率
- $A < 0$：动作比平均水平差 → 减少其概率
- $A \approx 0$：动作普普通通 → 概率不变

> **直觉**：优势函数去除了"状态本身的好坏"——在好的状态下，大多数动作都会获得正回报；减去 $V(s)$ 后，我们关注的是"这个动作**相对于**该状态的典型表现如何"。

---

## 6.6 方差缩减 II：Actor-Critic 架构

### 核心思路

与其等到 episode 结束再算 MC 回报，不如训练一个 **Critic** 来估计价值函数，为 Actor 提供即时、低方差的梯度信号。

$$
\begin{aligned}
&\text{Actor:} \quad \pi_{\theta}(a \mid s) \quad \text{(策略网络，参数 } \theta \text{)} \\
&\text{Critic:} \quad V_{\phi}(s) \quad \text{或} \quad Q_{\phi}(s, a) \quad \text{(价值网络，参数 } \phi \text{)}
\end{aligned}
$$

### Advantage Actor-Critic (A2C)

用 Critic 的 $V_\phi(s)$ 来计算优势。TD 误差 $\delta_t$ 天然是优势函数的无偏估计：

$$\mathbb{E}_{\pi_\theta}[\delta_t \mid s, a] = \mathbb{E}[r + \gamma V^{\pi_\theta}(s') \mid s, a] - V^{\pi_\theta}(s) = Q^{\pi_\theta}(s, a) - V^{\pi_\theta}(s) = A^{\pi_\theta}(s, a)$$

**因此可以高效地一步计算优势估计**：

$$\hat{A}(s_t, a_t) = r_t + \gamma V_\phi(s_{t+1}) - V_\phi(s_t) = \delta_t$$

### A2C 完整算法

**初始化**：Actor $\pi_\theta$、Critic $V_\phi$、学习率 $\alpha_\theta, \alpha_\phi$

对每个 episode，初始化 $s_0$，每步执行：

$$
\begin{aligned}
& \text{(1)}\quad a_t \sim \pi_\theta(\cdot \mid s_t) \quad \text{—— 根据当前策略}\pi_\theta\text{采样动作}a_t \\[4pt]
& \text{(2)}\quad \text{执行 } a_t \text{，观测 } r_t,\ s_{t+1} \quad \text{—— 与环境交互，获取即时奖励和下一状态} \\[4pt]
& \text{(3)}\quad \delta_t = r_t + \gamma V_\phi(s_{t+1}) - V_\phi(s_t) \quad \text{—— 计算时序差分误差（TD误差）} \\[4pt]
& \text{(4)}\quad \phi \leftarrow \phi - \alpha_\phi \nabla_\phi (\delta_t^2) \quad \text{—— 更新价值网络（Critic），缩小TD误差} \\[4pt]
& \text{(5)}\quad \theta \leftarrow \theta + \alpha_\theta \nabla_\theta \log \pi_\theta(a_t \mid s_t) \cdot \delta_t \quad \text{—— 更新策略网络（Actor），用}\delta_t\text{作为优势引导} \\[4pt]
& \text{(6)}\quad s_t \leftarrow s_{t+1} \quad \text{—— 状态前移，继续下一轮迭代}
\end{aligned}
$$

---

## 6.7 策略梯度方法谱系

### QAC（Q Actor-Critic）算法

在介绍完整谱系之前，先看 QAC——直接用 Critic 的 Q 值估计替代 REINFORCE 中的 MC 回报：

**QAC 算法**：初始化策略参数 $\theta$、Q 函数参数 $\mathbf{w}$、学习率 $\alpha, \beta$。初始状态 $s$，采样动作 $a \sim \pi_\theta(\cdot \mid s)$。之后每步：

$$
\begin{aligned}
& \text{(1)}\quad \text{执行 } a \text{，观测 } r,\ s' \sim P(\cdot \mid s, a) \quad \text{—— 在当前状态 } s \text{ 执行动作 } a \text{，获得奖励 } r \text{ 和下一状态 } s' \\[4pt]
& \text{(2)}\quad a' \sim \pi_\theta(\cdot \mid s') \quad \text{—— 根据当前策略 } \pi_\theta \text{ 为 } s' \text{ 采样动作 } a' \\[4pt]
& \text{(3)}\quad \delta = r + \gamma Q_{\mathbf{w}}(s', a') - Q_{\mathbf{w}}(s, a) \quad \text{—— 计算时序差分误差（TD误差）} \\[4pt]
& \text{(4)}\quad \theta \leftarrow \theta + \alpha \, \nabla_\theta \log \pi_\theta(s, a) \cdot Q_{\mathbf{w}}(s, a) \quad \text{—— 更新策略网络（Actor），使用 } Q \text{ 值作为权重} \\[4pt]
& \text{(5)}\quad \mathbf{w} \leftarrow \mathbf{w} + \beta \, \delta \, \nabla_{\mathbf{w}} Q_{\mathbf{w}}(s, a) \quad \text{—— 更新价值网络（Critic），用 TD 误差进行梯度修正} \\[4pt]
& \text{(6)}\quad a \leftarrow a',\ s \leftarrow s' \quad \text{—— 将下一动作和状态赋给当前变量，继续下一轮}
\end{aligned}
$$

**线性 Q 函数特例**：若 $Q(s, a) = \phi(s, a)^T w$（特征向量的线性组合），则 Critic 更新简化为 $w \leftarrow w + \beta \delta \cdot \phi(s, a)$——标准 LMS 规则。线性版本有更强的收敛保证，但表达能力受限。

### 四种梯度估计器

纵观各种变体，差异仅在于**用什么来估计 $Q^{\pi_\theta}(s, a)$**：

$$\boxed{
\begin{aligned}
\nabla_\theta J(\theta) &=
\mathbb{E}_{\pi_\theta} \left[ \nabla_\theta \log \pi_\theta(s, a) \cdot {\color{blue}G_t} \right]
&& \text{REINFORCE} \\[4pt]
&= \mathbb{E}_{\pi_\theta} \left[ \nabla_\theta \log \pi_\theta(s, a) \cdot {\color{blue}Q_w(s, a)} \right]
&& \text{Q Actor-Critic} \\[4pt]
&= \mathbb{E}_{\pi_\theta} \left[ \nabla_\theta \log \pi_\theta(s, a) \cdot {\color{blue}A_w(s, a)} \right]
&& \text{Advantage Actor-Critic} \\[4pt]
&= \mathbb{E}_{\pi_\theta} \left[ \nabla_\theta \log \pi_\theta(s, a) \cdot {\color{blue}\delta_t} \right]
&& \text{TD Actor-Critic}
\end{aligned}
}$$

> 从左到右：方差逐渐降低，偏差逐渐引入。最后一行（TD Actor-Critic）是最实用的形式。

---

## 6.8 广义优势估计 (GAE)

### 问题

TD Actor-Critic 用一步 TD 误差 $\delta_t$ 估计优势——低方差但**高偏差**（因为 $V_\phi(s_{t+1})$ 本身可能不准确）。

### GAE 的定义

考虑 $n$ 步优势估计：

$$\hat{A}_t^{(n)} = \sum_{l=0}^{n-1} \gamma^l r_{t+l} + \gamma^n V(s_{t+n}) - V(s_t)$$

GAE 将所有 $n$ 步估计按指数加权组合：

$$\boxed{\hat{A}_t^{\text{GAE}(\gamma, \lambda)} = \sum_{l=0}^{\infty} (\gamma \lambda)^l \delta_{t+l}}$$

其中 $\delta_t = r_t + \gamma V(s_{t+1}) - V(s_t)$。

| $\lambda$ | 等价于 | 偏差 | 方差 |
|-----------|--------|------|------|
| 0 | 1 步 TD | 高 | 低 |
| 1 | MC | 无偏 | 高 |
| **0.95（推荐）** | 平滑折中 | 低 | 中 |

### 高效计算

从轨迹末端反向递推，一行循环算出全部：

$$\begin{aligned}
&\text{初始化 } \text{GAE} \leftarrow 0 \\[4pt]
&\text{对 } t = T-1, T-2, \ldots, 1, 0: \\[4pt]
&\qquad \delta_t = r_t + \gamma V(s_{t+1}) - V(s_t) \\[4pt]
&\qquad \text{GAE} \leftarrow \delta_t + \gamma \lambda \cdot \text{GAE} \\[4pt]
&\qquad \hat{A}_t \leftarrow \text{GAE}
\end{aligned}$$

时间复杂度 $O(T)$，空间复杂度 $O(1)$。几乎零额外开销。

---

## 6.9 TRPO：信任域策略优化

### 策略梯度的"致命一步"

普通策略梯度的一阶更新可能**一步走太远**——策略参数的微小变化可能导致策略行为剧烈改变，引发性能断崖式下跌（catastrophic collapse）。

### 预备：策略性能差引理 (Performance Difference Lemma)

TRPO 的理论起点是一个关键恒等式。令 $\eta(\pi)$ 表示策略 $\pi$ 的期望折扣回报：

$$\eta(\pi) = \mathbb{E}_{s_0, a_0, \ldots} \left[ \sum_{t=0}^{\infty} \gamma^t r(s_t) \right], \quad s_0 \sim \rho_0, \; a_t \sim \pi(\cdot \mid s_t), \; s_{t+1} \sim P(\cdot \mid s_t, a_t)$$

> **[性能差引理]** 对任意两个策略 $\pi, \tilde{\pi}$：
>
> $$\eta(\tilde{\pi}) = \eta(\pi) + \mathbb{E}_{\tau \sim \tilde{\pi}} \left[ \sum_{t=0}^{\infty} \gamma^t A_{\pi}(s_t, a_t) \right]$$
>
> 即：两个策略的性能差异恰好等于在新策略轨迹上旧策略优势函数的期望折扣和。

**证明概要**：利用 $A_{\pi}(s,a) = \mathbb{E}_{s' \sim P}[r(s) + \gamma V_{\pi}(s') - V_{\pi}(s)]$，展开期望和即为 telescoping sum，消去中间项后得到 $\eta(\tilde{\pi}) - \eta(\pi)$。

> 这一定理揭示了：如果新策略 $\tilde{\pi}$ 在每一步都能获得**非负的旧策略优势**，那么新策略的性能一定不亚于旧策略。

### 局部近似 $L_{\pi}$

直接优化上式需要从新策略 $\tilde{\pi}$ 中采样——但新策略正是我们要学习的。TRPO 的解决方案是用**旧策略的状态分布**来近似：

$$L_{\pi}(\tilde{\pi}) = \eta(\pi) + \mathbb{E}_{s \sim d^{\pi}, a \sim \tilde{\pi}} \left[ A_{\pi}(s, a) \right]$$

用重要性采样改写：$L_{\pi_{\text{old}}}(\theta) = \eta(\pi_{\text{old}}) + \mathbb{E}_{s,a \sim \pi_{\text{old}}} \left[ \frac{\pi_\theta(a \mid s)}{\pi_{\text{old}}(a \mid s)} A_{\pi_{\text{old}}}(s, a) \right]$

当 $\pi_\theta = \pi_{\text{old}}$ 时，$L$ 和 $\eta$ 一阶匹配：$L_{\pi_{\text{old}}}(\pi_{\text{old}}) = \eta(\pi_{\text{old}})$ 且 $\nabla_\theta L_{\pi_{\text{old}}}(\pi_\theta)|_{\theta=\theta_{\text{old}}} = \nabla_\theta \eta(\pi_\theta)|_{\theta=\theta_{\text{old}}}$。

> 这意味着一小步增加 $L_{\pi}$ 的更新也会增加 $\eta$——但并没有告诉我们"多大算小"。

### 定理 1：单调改进界

令 $D_{\text{TV}}^{\max}(\pi, \tilde{\pi}) = \max_s D_{\text{TV}}(\pi(\cdot \mid s) \parallel \tilde{\pi}(\cdot \mid s))$。设 $\alpha = D_{\text{TV}}^{\max}(\pi_{\text{old}}, \pi_{\text{new}})$。则：

> **[定理 1]** 
> $$\eta(\pi_{\text{new}}) \geq L_{\pi_{\text{old}}}(\pi_{\text{new}}) - \frac{4 \epsilon \gamma}{(1 - \gamma)^2} \alpha^2$$
>
> 其中 $\epsilon = \max_{s, a} |A_{\pi}(s, a)|$。

**含义**：只要策略更新幅度 $\alpha$ 足够小，$L_{\pi_{\text{old}}}$ 的提升就能**保证** $\eta$ 的提升。惩罚项 $\frac{4\epsilon\gamma}{(1-\gamma)^2} \alpha^2$ 为信赖域大小提供理论指导。

利用 $D_{\text{TV}}(p \parallel q)^2 \leq D_{\text{KL}}(p \parallel q)$，将 TV 距离替换为 KL 散度，得到更实用形式。

### 两种 KL 约束形式

TRPO 提出求解以下约束优化问题。实践中使用两种 KL 约束变体：

**① 最大 KL 约束（理论形式，较保守）**：

$$\begin{aligned}
\max_\theta \quad & L_{\theta_{\text{old}}}(\theta) \\
\text{s.t.} \quad & D_{\text{KL}}^{\max}(\theta_{\text{old}}, \theta) \leq \delta
\end{aligned}$$

其中 $D_{\text{KL}}^{\max}(\theta_{\text{old}}, \theta) = \max_s D_{\text{KL}}(\pi_{\theta_{\text{old}}}(\cdot \mid s) \parallel \pi_\theta(\cdot \mid s))$。

**② 平均 KL 约束（实用形式，TRPO 论文推荐）**：

$$\begin{aligned}
\max_\theta \quad & \mathbb{E}_{s,a \sim \pi_{\theta_{\text{old}}}} \left[ \frac{\pi_\theta(a \mid s)}{\pi_{\theta_{\text{old}}}(a \mid s)} \hat{A}^{\pi_{\theta_{\text{old}}}}(s, a) \right] \\
\text{s.t.} \quad & \mathbb{E}_{s \sim \pi_{\theta_{\text{old}}}} \left[ D_{\text{KL}}(\pi_{\theta_{\text{old}}}(\cdot \mid s) \parallel \pi_\theta(\cdot \mid s)) \right] \leq \delta
\end{aligned}$$

**三要素总结**：
1. **重要性采样比** $r_t(\theta) = \frac{\pi_\theta}{\pi_{\theta_{\text{old}}}}$：允许用旧策略的数据优化新策略
2. **Surrogate Objective $L_{\pi_{\text{old}}}(\theta)$**：局部近似真实目标，一阶匹配
3. **KL 散度约束**：新旧策略的差异不超过信任域半径 $\delta$，保证单调改进

### 理论保证

TRPO 确保每一步更新后，策略的真实性能 $\eta$ 不会下降——即**单调改进 (Monotonic Improvement)**。这在实际中意味着不会出现灾难性遗忘或策略崩溃。

### 实际不足

TRPO 效果好但实现复杂——需要用共轭梯度法近似求解 Fisher 信息矩阵的逆，每步更新涉及二阶优化。这也直接催生了 PPO。

---

## 6.10 PPO：近端策略优化

### 动机

**PPO 的目标**：用一阶方法（标准 SGD）达到 TRPO 级别的稳定性——只需要在 loss 函数上做裁剪。

### PPO-Clip 损失函数

$$L^{\text{CLIP}}(\theta) = \mathbb{E}_t \left[ \min\left( r_t(\theta) \hat{A}_t, \; \text{clip}(r_t(\theta), 1-\epsilon, 1+\epsilon) \hat{A}_t \right) \right]$$

其中 $r_t(\theta) = \frac{\pi_\theta(a_t \mid s_t)}{\pi_{\theta_{\text{old}}}(a_t \mid s_t)}$，$\epsilon$ 通常取 0.2。

### 裁剪行为详解

**情况一：$\hat{A}_t > 0$（好动作，想增加其概率）**

| $r_t(\theta)$ | 含义 | clip 的作用 |
|---------------|------|-------------|
| $r_t < 1$ | 概率降低了 | 不裁剪（min 取 $r_t \hat{A}_t$） |
| $r_t \in [1, 1+\epsilon]$ | 概率适度增加 | 不裁剪 |
| $r_t > 1+\epsilon$ | 概率增加太多 | **裁剪到 $1+\epsilon$**——不允许过度利用 |

**情况二：$\hat{A}_t < 0$（坏动作，想降低其概率）**

| $r_t(\theta)$ | 含义 | clip 的作用 |
|---------------|------|-------------|
| $r_t < 1-\epsilon$ | 概率降得太多 | **裁剪到 $1-\epsilon$**——不允许过度惩罚 |
| $r_t \in [1-\epsilon, 1]$ | 概率适度降低 | 不裁剪 |
| $r_t > 1$ | 概率反而增加了 | 不裁剪（min 取 $r_t \hat{A}_t$，仍是负数） |

> **核心直觉**：取 $\min$ 确保目标是**保守（pessimistic）**的——只信任在 $[1-\epsilon, 1+\epsilon]$ 范围内的策略变化。一旦变化太大，就不再相信重要性采样的估计。

### PPO-Penalty：自适应 KL 惩罚

除了裁剪，PPO 还提出了另一种变体——在目标中直接加入 KL 散度惩罚项，并**自适应调节惩罚系数 $\beta$**：

$$L^{\text{KLPEN}}(\theta) = \mathbb{E}_t \left[ \frac{\pi_\theta(a_t \mid s_t)}{\pi_{\theta_{\text{old}}}(a_t \mid s_t)} \hat{A}_t - \beta \, D_{\text{KL}}(\pi_{\theta_{\text{old}}}(\cdot \mid s_t) \parallel \pi_\theta(\cdot \mid s_t)) \right]$$

**自适应调节机制**：

每轮优化后，计算观测到的平均 KL 散度 $d = \hat{\mathbb{E}}_t \big[ D_{\text{KL}}(\pi_{\theta_{\text{old}}}(\cdot \mid s_t) \parallel \pi_\theta(\cdot \mid s_t)) \big]$，然后调整 $\beta$：

$$\beta \leftarrow \begin{cases}
\beta / 2, & \text{若 } d < d_{\text{targ}} / 1.5 \quad (\text{KL 太小，放宽约束}) \\[4pt]
\beta \times 2, & \text{若 } d > d_{\text{targ}} \times 1.5 \quad (\text{KL 太大，收紧约束}) \\[4pt]
\beta, & \text{否则}
\end{cases}$$

- $d_{\text{targ}}$ 是期望的 KL 散度目标值（如 0.01）
- $\beta$ 初始值通常设为 1.0

> PPO-Clip 和 PPO-Penalty 两者的目标相同（限制策略变化幅度），但实现路径截然不同：Clip 通过硬截断，Penalty 通过自适应惩罚。

### 实验验证

原始 PPO 论文在连续控制任务上对比了多种变体（以下为标准化平均得分）：

| 方法 | 平均标准化得分 | 说明 |
|------|:-----------:|------|
| No clipping or penalty | -0.39 | 无约束 → 策略崩溃 |
| **Clipping, $\epsilon = 0.2$** | **0.82** | **最佳结果** |
| Clipping, $\epsilon = 0.1$ | 0.76 | 略微保守 |
| Clipping, $\epsilon = 0.3$ | 0.70 | 过松 → 性能下降 |
| Adaptive KL, $d_{\text{targ}} = 0.01$ | 0.74 | KL 变体，略低于 Clip |
| Fixed KL, $\beta = 1$ | 0.71 | 固定惩罚不如自适应 |
| Fixed KL, $\beta = 3$ | 0.72 | 固定惩罚不如自适应 |

> **结论**：裁剪变体（$\epsilon = 0.2$）在实验中表现最佳。PPO-Clip 因其简洁、稳定和最佳实验效果，成为 PPO 的事实标准变体。

### PPO 完整算法

**初始化**：策略 $\pi_\theta$、价值函数 $V_\phi$。每次迭代执行：

**(1) 数据采集** —— 用旧策略 $\pi_{\theta_{\text{old}}}$ 采集一批轨迹 $\mathcal{D} = \{\tau_1, \tau_2, \ldots\}$，对每条轨迹用 GAE 计算优势估计 $\hat{A}_t$ 和回报 $\hat{G}_t$。

**(2) 多轮优化** —— 对 $K$ 个 epoch，遍历 $\mathcal{D}$ 的每个 mini-batch：

$$\begin{aligned}
r_t(\theta) &= \frac{\pi_\theta(a_t \mid s_t)}{\pi_{\theta_{\text{old}}}(a_t \mid s_t)} \\[4pt]
\mathcal{L}^{\text{CLIP}} &= \mathbb{E}_t \Big[ \min\big( r_t(\theta) \hat{A}_t,\ \text{clip}(r_t(\theta), 1-\varepsilon, 1+\varepsilon) \hat{A}_t \big) \Big] \\[4pt]
\mathcal{L}^{\text{VF}} &= \mathbb{E}_t \big[ (V_\phi(s_t) - \hat{G}_t)^2 \big] \\[4pt]
\mathcal{L}^{\text{total}} &= \mathcal{L}^{\text{CLIP}} - c_1 \mathcal{L}^{\text{VF}} + c_2 H(\pi_\theta) \\[4pt]
\theta &\leftarrow \theta + \alpha \, \nabla_\theta \mathcal{L}^{\text{total}} \\[4pt]
\phi &\leftarrow \phi - \alpha_\phi \, \nabla_\phi \mathcal{L}^{\text{VF}}
\end{aligned}$$

其中 $H(\pi_\theta) = -\sum_a \pi_\theta(a \mid s) \log \pi_\theta(a \mid s)$ 为熵正则化项，鼓励探索。

**(3) 同步** —— $\theta_{\text{old}} \leftarrow \theta$

### PPO 关键超参数

| 参数 | 典型值 | 作用 |
|------|--------|------|
| 裁剪 $\epsilon$ | 0.1 ~ 0.2 | 裁剪范围——越小越保守 |
| 优化轮数 $K$ | 3 ~ 10 | 每批数据的重复利用次数 |
| Mini-batch 大小 | 64 ~ 4096 | 取决于任务规模 |
| GAE $\lambda$ | 0.95 | 偏差-方差权衡（推荐不动） |
| 折扣 $\gamma$ | 0.99 | 长期/短期权重 |
| 学习率 $\alpha$ | $10^{-4} \sim 3 \times 10^{-4}$ | 常用 Adam 优化器 |
| 熵系数 $c_2$ | 0.01 | 鼓励探索的强度 |

---

## 6.11 GAE → TRPO → PPO 演进图

```
REINFORCE ──── 方差极高，不实用
    │
    ▼
Actor-Critic ──── 用 Critic 降方差，方差仍大
    │
    ▼
  GAE ──── 用 (γ,λ) 控制偏差-方差权衡
    │
    │ 方差降了，但策略更新仍可能过冲→性能崩溃
    ▼
 TRPO ──── KL 约束 + 二阶优化 → 单调改进，但实现复杂
    │
    │ 同样效果，更简单实现
    ▼
  PPO ──── 一阶裁剪 → TRPO 级稳定性 + SGD 级简洁
```

> **PPO + GAE** 是当前连续控制任务（机器人、游戏）和 LLM 对齐（RLHF 第三阶段）的标准组合。

---

## 小结

- **策略梯度定理**：$\nabla_\theta J(\theta) = \mathbb{E}[\nabla_\theta \log \pi_\theta(a \mid s) \cdot Q^{\pi_\theta}(s, a)]$——好动作增加概率，坏动作减少概率。
- **REINFORCE** 是最基础的实现，方差高得在实际中几乎不可用。
- **Actor-Critic + Baseline** 通过引入 Critic 和优势函数，将方差降低到可训练的水平。
- **GAE** 用 $\lambda$ 参数平滑控制偏差-方差权衡，计算高效。
- **TRPO** 用 KL 约束保证单调改进，理论完备但实现复杂。
- **PPO** 用简单的裁剪机制达到同等稳定性——已成为现代 RL 的事实标准算法。
