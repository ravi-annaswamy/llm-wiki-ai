---
title: "AlphaEvolve"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"]
tags: [deepmind, evolutionary, llm, gemini, automated-algorithm-discovery]
status: active
---

# AlphaEvolve

A distributed evolutionary coding system developed by [google-deepmind](google-deepmind.md) that uses a large language model as the mutation operator in a search over source code (Source: [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md)). Rather than mutating numeric hyperparameters, AlphaEvolve mutates **the actual Python implementation** of an algorithm, evolving a population of candidate implementations against a fitness signal.

It is the concrete instantiation of [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md) covered in the current wiki corpus.

## How it works

1. **Seed.** A population is initialized with a standard implementation of the target algorithm (CFR+ for CFR experiments; a Uniform meta-strategy solver for PSRO experiments).
2. **Select.** Each generation, a parent is sampled from the population based on fitness.
3. **Mutate.** The parent's source code is passed to **Gemini 2.5 Pro** with a prompt instructing it to produce a modified version. The LLM returns a candidate Python implementation.
4. **Evaluate.** The candidate is run on a set of proxy/training games. If valid, it enters the population.
5. **Repeat.** The loop continues across generations, with the LLM reading and transforming actual code rather than tweaking parameters.

**Multi-objective optimization** is supported: when multiple fitness metrics are defined, one is randomly selected per generation to drive parent sampling — giving the search access to several gradients without collapsing them into a single weighted score.

## Search space in the game-theory paper

AlphaEvolve operates on structured Python class interfaces that are expressive enough to represent all known variants of the target algorithm family as special cases:

- **For CFR** — three classes: `RegretAccumulator`, `PolicyFromRegretAccumulator`, `PolicyAccumulator`.
- **For PSRO** — two classes: `TrainMetaStrategySolver`, `EvalMetaStrategySolver` (the solvers used during oracle training and during exploitability evaluation, respectively).

The fitness signal is negative exploitability after K iterations on a training set of four imperfect-information games. Final evaluation uses a held-out test set of larger, unseen games.

## Discovered algorithms (from this paper)

- **VAD-CFR** — Volatility-Adaptive Discounted CFR. Matches or exceeds state-of-the-art in 10 of 11 benchmark games. Introduces volatility-adaptive discounting via an EWMA of instantaneous regret magnitude, asymmetric positive-regret boosting (factor 1.1), and a hard warm-start at iteration 500 for policy averaging. The 500-iteration threshold was generated without the LLM knowing the 1000-iteration evaluation horizon.
- **AOD-CFR** — Asymmetric Optimistic Discounted CFR. A secondary discovery using more conventional mechanisms (linear discount schedules, sign-dependent scaling, EMA-based policy optimism, polynomial policy averaging).
- **SHOR-PSRO** — Smoothed Hybrid Optimistic Regret PSRO. Matches or exceeds state-of-the-art in 8 of 11 games. Blends Optimistic Regret Matching with a Softmax best-pure-strategy component, annealing the blend factor, diversity bonus, and temperature over training. Critically, the discovered training-time and evaluation-time solver configurations are **asymmetric** — a design choice that was itself a product of the search, not a human decision.

## Why it's notable

The interesting unit of this work is not any individual discovered algorithm — it is the demonstration that the **mutation unit in an evolutionary search can be a block of code**, not a scalar. LLMs are now fluent enough at reading and writing code that they can act as the variation operator in a classical evolutionary loop, which turns algorithm research into a search problem with a fitness signal — see [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md).

## Related

- [google-deepmind](google-deepmind.md)
- [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md)
- [counterfactual-regret-minimization](../concepts/counterfactual-regret-minimization.md)
- [policy-space-response-oracles](../concepts/policy-space-response-oracles.md)
- [marl-imperfect-information-games](../concepts/marl-imperfect-information-games.md)
