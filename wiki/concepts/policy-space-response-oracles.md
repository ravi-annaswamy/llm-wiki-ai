---
title: "Policy Space Response Oracles (PSRO)"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"]
tags: [psro, game-theory, meta-strategy, nash-equilibrium, marl]
status: active
---

# Policy Space Response Oracles (PSRO)

PSRO is a higher-level algorithmic paradigm for solving [marl-imperfect-information-games](marl-imperfect-information-games.md) than [counterfactual-regret-minimization](counterfactual-regret-minimization.md). Instead of reasoning directly about regrets at every information set, PSRO maintains a **population of policies per player** and iteratively grows that population by adding best responses to carefully chosen mixtures over the existing population (Source: [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md)).

## The core loop

1. **Maintain a population** of policies for each player.
2. **Build a payoff tensor** — the "meta-game" — by computing expected utilities for every combination of population policies.
3. **Apply a meta-strategy solver** to produce a probability distribution over the population (a mixture). This is the central design choice.
4. **Train a best response** against the resulting mixture.
5. **Add the new best response to the population.**
6. Repeat.

Over iterations, the population grows and the meta-strategy approaches a Nash equilibrium of the full extensive-form game. PSRO generalizes several classical approaches (self-play, fictitious play) as special cases of the meta-strategy solver choice.

## The design question PSRO turns on

The meta-strategy solver is the knob that matters. Different choices produce qualitatively different behaviors:

- **Uniform** — just average over the population. Simple, stable, slow.
- **Nash** — solve the meta-game exactly (via LP for 2-player games). Rigorous, but expensive and ill-defined for n ≥ 3.
- **AlphaRank** — a Markov-chain-based solver that ranks policies.
- **Projected Replicator Dynamics (PRD)** — evolutionary dynamics on the meta-game.
- **Regret Matching (RM)** — apply regret minimization to the meta-game directly.

Each of these was developed by hand. The DeepMind paper treats the meta-strategy solver as the variation surface — the thing to automatically search over — rather than the thing to propose from intuition.

## Training vs. evaluation solvers

A nuance the paper makes explicit: PSRO uses a meta-strategy solver at **two** distinct points — during best-response oracle training (to decide what mixture the new policy should best-respond to) and during exploitability evaluation (to decide what mixture to measure against). Traditionally these are the same solver. The AlphaEvolve search discovered they should be **different**. See SHOR-PSRO below.

## The AlphaEvolve search space for PSRO

The DeepMind paper exposes two classes as the evolvable interface:

- **`TrainMetaStrategySolver`** — the solver used during oracle training.
- **`EvalMetaStrategySolver`** — the solver used during exploitability evaluation.

Mutating these two classes via [alphaevolve](../entities/alphaevolve.md) is the full variation space.

## The discovered variant: SHOR-PSRO

**Smoothed Hybrid Optimistic Regret PSRO** matches or exceeds state-of-the-art in **8 of 11** benchmark games. It introduces a hybrid meta-solver that linearly blends two components at every internal iteration:

- **σ_ORM** — Optimistic Regret Matching, providing stability.
- **σ_Softmax** — a Boltzmann distribution over pure strategies biased toward high-payoff modes, providing exploitation.

The blend is **σ_hybrid = (1 − λ) · σ_ORM + λ · σ_Softmax**.

**Training-time solver:** dynamically anneals λ from 0.3 → 0.05, diversity bonus from 0.05 → 0.001, softmax temperature from 0.5 → 0.01 over outer PSRO iterations. Returns time-averaged strategy.

**Evaluation-time solver:** fixed parameters (λ = 0.01, diversity bonus = 0.0, temperature = 0.001), more internal iterations, returns **last-iterate** strategy for a reactive, low-noise exploitability estimate.

The asymmetry between training-time and evaluation-time solver configurations was **itself a product of the search**, not a human design choice. This is arguably the most striking single finding of the paper — a non-obvious separation that a human researcher would be unlikely to propose.

See [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md) for the full benchmark tables.

## Why PSRO is a natural target for automated discovery

- **Clean abstraction boundary** — the meta-strategy solver is a single, well-defined component.
- **Well-studied baselines** — Uniform, Nash, AlphaRank, PRD, RM provide a dense comparison set.
- **Clear fitness signal** — exploitability, computable exactly on small games.
- **Known open question** — how to balance population diversity (early) against equilibrium refinement (late) has been an active research topic for years. Automated annealing schedules are exactly the kind of thing a search is good at finding.

See [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md) for the framework.

## Related

- [marl-imperfect-information-games](marl-imperfect-information-games.md)
- [counterfactual-regret-minimization](counterfactual-regret-minimization.md)
- [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md)
- [alphaevolve](../entities/alphaevolve.md)
- [google-deepmind](../entities/google-deepmind.md)
