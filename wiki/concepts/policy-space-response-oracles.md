---
title: "Policy Space Response Oracles (PSRO)"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"]
tags: [psro, game-theory, meta-strategy, nash-equilibrium, marl]
status: active
---

# Policy Space Response Oracles (PSRO)

> **A higher-level algorithmic paradigm for [marl-imperfect-information-games](marl-imperfect-information-games.md): instead of reasoning about regrets per information set, maintain a population of policies per player and grow it iteratively by adding best responses to mixtures over the existing population.**

## The core loop

1. Maintain a **population** of policies per player.
2. Build a **payoff tensor** (the "meta-game") over combinations of population policies.
3. Apply a **meta-strategy solver** to produce a mixture over the population — *the central design choice*.
4. Train a **best response** against the mixture.
5. Add it to the population. Repeat.

PSRO generalizes self-play and fictitious play as special cases of the meta-strategy solver choice.

## The meta-strategy solver is the knob

| Solver | Mechanism |
|---|---|
| **Uniform** | Average over the population. Simple, stable, slow |
| **Nash** | Solve the meta-game exactly (LP for 2-player). Rigorous but expensive; ill-defined for n ≥ 3 |
| **AlphaRank** | Markov-chain-based solver that ranks policies |
| **Projected Replicator Dynamics (PRD)** | Evolutionary dynamics on the meta-game |
| **Regret Matching (RM)** | Apply regret minimization to the meta-game directly |

Each developed by hand. DeepMind's paper treats this as the variation surface — the thing to *automatically search over* rather than propose from intuition.

## Training vs evaluation solvers (nuance)

PSRO uses a meta-strategy solver at **two** distinct points — during best-response oracle training, and during exploitability evaluation. Traditionally they're the same. **The AlphaEvolve search discovered they should be different.**

AlphaEvolve search space:

| Class | Role |
|---|---|
| `TrainMetaStrategySolver` | Used during oracle training |
| `EvalMetaStrategySolver` | Used during exploitability evaluation |

## Discovered: SHOR-PSRO

**Smoothed Hybrid Optimistic Regret PSRO** — matches/exceeds SoTA on **8 of 11** benchmark games. Linear blend per inner iteration:

```
σ_hybrid = (1 − λ) · σ_ORM + λ · σ_Softmax
```

σ_ORM = Optimistic Regret Matching (stability). σ_Softmax = Boltzmann over pure strategies, biased toward high-payoff modes (exploitation).

| Configuration | λ | Diversity bonus | Temperature | Strategy returned |
|---|---|---|---|---|
| **Training-time** | 0.3 → 0.05 (anneal) | 0.05 → 0.001 | 0.5 → 0.01 | Time-averaged |
| **Evaluation-time** | 0.01 (fixed) | 0.0 | 0.001 | Last-iterate (reactive, low-noise) |

**The asymmetry between training-time and eval-time solver configurations was itself a product of the search, not a human choice** — arguably the most striking single finding of the paper, a non-obvious separation a human researcher would be unlikely to propose.

## Why it fits automated discovery

Clean abstraction boundary (one well-defined component); dense baseline set (Uniform, Nash, AlphaRank, PRD, RM); exact exploitability on small games; known open question (balancing population diversity early vs equilibrium refinement late) that automated annealing schedules are exactly good at solving.

## Related

- **Parent:** [marl-imperfect-information-games](marl-imperfect-information-games.md)
- **Sibling:** [counterfactual-regret-minimization](counterfactual-regret-minimization.md)
- **Discovery system:** [alphaevolve](../entities/alphaevolve.md) · [google-deepmind](../entities/google-deepmind.md)
- **Hub:** [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md)
- **Source:** [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md)
