---
layout: post
title: "极简定理验证器"
permalink: /posts/artificial-intelligence/minimized-theorem-verifier/
date: 2026-01-20 01:00:00 +0800
tags: artificial-intelligence, formal-proof
use_math: true
---

# 极简定理验证器项目

定理验证器是用于验证数学定理和逻辑推理正确性的工具。本文档介绍了一个极简定理验证器项目的基本概念和实现思路。

参考Metamath定理验证器的设计理念，我们将实现一个功能非常有限但结构清晰的定理验证器。

## 项目目标

在Metamath中每一个结论到需要取一个名字，我觉得这很烦。

定理的全部语义都包含在它的定理描述当中，和定理的证明过程无关，所以我觉得定理验证器不需要给定理取名字。

我们的极简定理验证器将在Metamath的基础上进行简化，去掉命名。
