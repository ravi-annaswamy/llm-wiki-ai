---
title: "Counterfactual Regret Minimization (CFR)"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"]
tags: [cfr, game-theory, regret-minimization, nash-equilibrium, poker]
status: active
---

# Counterfactual Regret Minimization (CFR)

> **An iterative algorithm for finding Nash equilibria in [marl-imperfect-information-games](marl-imperfect-information-games.md).** Decomposes regret minimization across information sets and converges to NE on average. Backbone of professional-level poker AI for 15 years.

## The core loop

At each iteration t:

1. **Accumulate counterfactual regret** at every information set — how much the player would have gained by playing an action differently, weighted by the probability of reaching that info set under the opponents' current strategy.
2. **Derive a new policy** proportional to **positive** accumulated regret (regret matching).
3. **Accumulate the average policy** over iterations.

**Key subtlety:** the *time-averaged* strategy, not the latest one, is what converges to Nash. Policy averaging is as central as regret accumulation.

## Established variants (hand-designed)

| Variant | Contribution |
|---|---|
| CFR+ | Regret matching plus (clamps negative regrets to zero) + linear averaging. Major speedup |
| Linear CFR (LCFR) | Weights later iterations more heavily in averaging |
| DCFR (Discounted CFR) | Explicit discount factors α, β for cumulative regrets of different signs |
| PCFR+ / Predictive CFR+ | Predictive updates anticipating next iteration's regret |
| DPCFR+ | Combines discounting with predictive updates |
| HS-PCFR+(30) | Hot-start variant |

All developed through human trial-and-error, each targeting a specific failure mode of its predecessor.

## The AlphaEvolve search space

Three Python classes covering all known variants as special cases:

| Class | What it controls |
|---|---|
| `RegretAccumulator` | How per-iteration regrets combine into cumulative regrets (discount factors, sign-dependent scaling) |
| `PolicyFromRegretAccumulator` | How the current-iteration policy is derived (vanilla matching, predictive updates) |
| `PolicyAccumulator` | How the running average policy is accumulated (linear, uniform, weighted, warm-started) |

## Discovered variants

- **VAD-CFR** (Volatility-Adaptive Discounted CFR) — matches/exceeds SoTA on **10 of 11** benchmark games. EWMA-based volatility tracking of instantaneous regret, asymmetric positive-regret boost (1.1×), hard policy-averaging warm-start at iteration 500.
- **AOD-CFR** (Asymmetric Optimistic Discounted CFR) — secondary discovery with more conventional mechanisms.

## Why it's a natural target for automated discovery

Clean three-class interface; decades of hand-designed baselines; fast exact evaluation on OpenSpiel; exploitability is exactly computable; known gaps (fixed discount schedules) invite adaptive mechanisms.

## Related

- **Parent:** [marl-imperfect-information-games](marl-imperfect-information-games.md)
- **Sibling:** [policy-space-response-oracles](policy-space-response-oracles.md)
- **Discovery system:** [alphaevolve](../entities/alphaevolve.md) · [google-deepmind](../entities/google-deepmind.md)
- **Hub:** [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md)
- **Source:** [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md)
