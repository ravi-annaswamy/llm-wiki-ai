---
title: "AlphaEvolve"
type: entity
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"]
tags: [deepmind, evolutionary, llm, gemini, automated-algorithm-discovery]
status: active
---

# AlphaEvolve

> **DeepMind's distributed evolutionary coding system that uses Gemini 2.5 Pro as the mutation operator over source code.** Rather than tweaking numeric hyperparameters, it mutates **the actual Python implementation** — turning algorithm research into a search problem with a fitness signal.

The canonical wiki instance of [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md).

## The loop

| Step | What happens |
|---|---|
| 1. Seed | Population initialized with a standard implementation (CFR+ for CFR; Uniform meta-solver for PSRO) |
| 2. Select | Parent sampled from population by fitness |
| 3. Mutate | Parent source code → **Gemini 2.5 Pro** with a modification prompt → candidate Python |
| 4. Evaluate | Run candidate on proxy/training games; if valid, add to population |
| 5. Repeat | LLM transforms actual code, not parameters, across generations |

**Multi-objective optimization.** When several fitness metrics are defined, one is randomly selected per generation to drive parent sampling — giving the search access to multiple gradients without collapsing them into a weighted score.

## The search space (game-theory paper)

Structured Python class interfaces expressive enough to represent all known variants as special cases:

| Target | Classes mutated |
|---|---|
| CFR | `RegretAccumulator`, `PolicyFromRegretAccumulator`, `PolicyAccumulator` |
| PSRO | `TrainMetaStrategySolver`, `EvalMetaStrategySolver` |

Fitness: negative exploitability after K iterations on 4 imperfect-information training games. Final evaluation on a held-out test set of larger games.

## Discovered algorithms

- **VAD-CFR** (Volatility-Adaptive Discounted CFR) — matches/exceeds SoTA on **10 of 11** benchmark games. Volatility-adaptive discounting via EWMA of instantaneous regret, asymmetric positive-regret boost (1.1×), hard warm-start at iter 500 for policy averaging. The 500 threshold was generated without the LLM knowing the 1000-iter evaluation horizon.
- **AOD-CFR** — secondary discovery, more conventional mechanisms.
- **SHOR-PSRO** — matches/exceeds SoTA on **8 of 11**. Blends Optimistic Regret Matching with a Softmax best-pure-strategy component; training-time and eval-time solver configs are **asymmetric** — itself a product of the search, not a human decision.

## Why it matters

The interesting unit is not any individual discovered algorithm — it is the demonstration that **the mutation unit in an evolutionary search can be a block of code**, not a scalar. See [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md) for the broader pattern.

## Related

- **Parent:** [google-deepmind](google-deepmind.md)
- **Hub concept:** [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md)
- **Domain:** [counterfactual-regret-minimization](../concepts/counterfactual-regret-minimization.md) · [policy-space-response-oracles](../concepts/policy-space-response-oracles.md) · [marl-imperfect-information-games](../concepts/marl-imperfect-information-games.md)
- **Source:** [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md)
