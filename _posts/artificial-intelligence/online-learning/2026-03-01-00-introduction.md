---
layout: post
title: "Online Learning 导论"
permalink: /posts/ai/online-learning/introduction/
tags: online-learning
use_math: true
---

这篇文章介绍了**在线学习**与**强化学习**的基本框架及其在动态决策中的应用。传统机器学习采用“先学后用”的静态模式，而在线学习则强调“边学边用”，模型在与环境交互中持续更新。文章通过**动态定价**和**定价与库存管理**两个示例，揭示了在线决策的核心挑战——**探索与利用的两难困境**：既要通过尝试新策略来收集信息（探索），又要基于已有知识最大化即时收益（利用）。其中，库存管理等场景因当前决策影响未来状态，自然引入了**强化学习**的范式。文章还提及了**上下文老虎机**等扩展模型，并列出从基础理论到高级应用的学习大纲，为理解数据驱动的序贯决策问题提供了系统性导引。

## 导论

##### 传统机器学习：“先学后用”
模型仅从历史数据中学习一次，随后执行决策而不进行更新

##### 在线学习：“边学边用”
模型在执行决策的同时持续学习与适应

新（且关键）挑战：“数据驱动的智能决策”：既要决策数据采集策略，又要实现收益最大化——探索与开发两难困境。

### 示例1：动态定价

模型：$$d = D(p) + \varepsilon,
\qquad \mathbb{E}[\varepsilon]=0$$ 其中$d$为实际需求，$p$为价格。

单笔销售收益（利润）：利润 $= d\cdot p$。预期利润：$D(p)\cdot p$。

##### 传统机器学习方法：

1.  给定数据集：$(p_1,d_1), (p_2,d_2),\dots,(p_n,d_n)$。

2.  学习需求函数 $\widehat{D}(\cdot)$（例如回归）。

3.  优化策略：$\hat p = \arg\max_p \widehat{D}(p)\cdot p$。

##### 在线学习

对于时间段 $t=1,2,\dots,T$（其中 $T$称为**决策时限**）：

1.  基于历史观测数据$(p_1,d_1),\dots$决定当前策略$p_t$；

2.  向顾客提供价格$p_t$；

3.  观测实际需求$d_t$并获得收益$p_t \cdot d_t$。

##### 共同目标：

最大化 $$\mathbb{E}\Big[\sum_{t=1}^T p_t d_t\Big]。$$

##### 观察：

-   在简单单臂老虎机场景中，各时间段的优化目标（近似）独立；时间 $t$ 的决策不影响后续时间的最优决策。

-   在其他场景（如库存控制）中，当前决策可能影响未来状态与收益。

### 示例2：定价与库存管理

需求模型：$$d_t = D(p_t) + \varepsilon_t,\quad \mathbb{E}[\varepsilon_t]=0.$$ 时间$t$初始库存水平：$x_t$。

时间 $t$ 的库存决策：补货至水平 $y_t$（即 $y_t \ge x_t$）。随后决定价格 $p_t$ 并产生实际需求 $d_t$。

新库存水平：$$x_{t+1} = y_t - d_t.$$

时间$t$的收益（典型公式之一）：$$r_t = p_t d_t \;-\; k\cdot \mathbf{1}\{y_t>x_t\} \;-\; c\cdot (y_t - x_t)
\;-\; h\cdot [y_t - d_t]_+ \;-\; b\cdot [d_t - y_t]_+,$$ 其中

-   $p_t d_t$：销售收入，

-   $k$：固定订货成本（若下单），

-   $c$：单位可变订货成本，
-   $h$：单位库存持有成本（针对未售库存），
-   $b$：单位积压/短缺成本。

##### 总体目标：

最大化 $\mathbb{E}\sum_{t=1}^T r_t$。

##### 观察：

-   时刻$t$的决策（即$(y_t,p_t)$）可能影响$x_{t+1}$，进而影响未来收益与最优决策。

-   此即强化学习（MDP）框架。

## 单臂老虎机与强化学习

##### 单臂老虎机

智能体选择动作并获取奖励，但无法观察或影响环境状态。其学习完全依赖试错反馈——常见于A/B测试或上下文信息有限的推荐系统等场景。

##### 强化学习

智能体通过与动态环境交互学习，其动作不仅影响奖励，更会改变未来状态。这使得长期规划与策略制定成为可能——对游戏、机器人或自主导航等任务至关重要。

-   定价与库存示例中，状态 = 库存水平。

-   在一般强化学习任务中，最优策略是状态的函数：$$a_t^\star = \pi^\star(s_t)$$

-   相比之下，多臂老虎机任务中最优动作可能是恒定的（不依赖状态）。

### 示例3：个性化定价（上下文多臂老虎机）

模型：$$d_t = D(p_t; x_t) + \varepsilon_t$$，其中$x_t$为描述顾客特征的向量（如性别、年龄、职业、信用记录等）。

##### 共同目标（上下文多臂老虎机）：

假设 $x_t\sim \mathcal{X}$（来自某个可能未知的独立同分布），最大化 $$\mathbb{E}\Big[\sum_{t=1}^T p_t d_t\Big]。$$

##### 观察要点：

-   “无状态强化学习”：环境生成 $x_t$，其状态不受 $p_t$ 或 $x_t$ 影响（即无状态动态）。

- 最优策略：$a_t^\star = \pi^\star(x_t)$（策略依赖于上下文）。

## 大纲

主题包括（部分列表）：

-   [集中不等式](/posts/ai/online-learning/concentration-inequalities/)

-   多臂老虎机：[基础](/posts/ai/online-learning/mab-basic/)、[改进的纯探索算法](/posts/ai/online-learning/mab-pure-exploration/)、[下界](/posts/ai/online-learning/mab-lower-bound/)

-   [MNL 老虎机](/posts/ai/online-learning/multinomial-logit-bandit/)

-   [对抗性老虎机](/posts/ai/online-learning/adversarial-bandits/)

-   [上下文老虎机](/posts/ai/online-learning/contextual-bandits/)

-   [线性老虎机](/posts/ai/online-learning/linear-bandits/)，[下界分析](/posts/ai/online-learning/linear-bandits-lower-bound/)

-   [批量老虎机](/posts/ai/online-learning/batched-bandits/)

-   [强化学习](/posts/ai/online-learning/model-based-reinforcement-learning/)

-   
