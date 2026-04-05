---
title: "Counterfactual Regret Minimization (CFR)"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"]
tags: [cfr, game-theory, regret-minimization, nash-equilibrium, poker]
status: active
---

# Counterfactual Regret Minimization (CFR)

An iterative algorithm for finding Nash equilibria in [marl-imperfect-information-games](marl-imperfect-information-games.md). CFR decomposes regret minimization across **information sets** — the situations a player can find themselves in given what they can observe — and, over many iterations, converges to a Nash equilibrium on average (Source: [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md)).

CFR and its variants have been the backbone of professional-level poker AI for a decade and a half.

## The core loop

At each iteration t:

1. **Accumulate counterfactual regret** at every information set. Counterfactual regret is, intuitively, how much a player would have gained by playing some action differently, weighted by the probability of reaching that information set under the opponents' current strategy.
2. **Derive a new policy** at each information set proportional to **positive** accumulated regret (regret matching). Actions with higher accumulated positive regret are played more often.
3. **Accumulate the average policy** over iterations — this is the quantity that converges, not the current policy.

The time-averaged strategy, not the latest one, converges to Nash equilibrium. That's a key subtlety: policy averaging is as central to CFR as regret accumulation.

## Established variants

The CFR family has grown through manual design over many years:

- **CFR+** — replaces regret matching with regret matching plus (clamps negative regrets to zero faster) and uses linear averaging. Much faster convergence in practice.
- **Linear CFR (LCFR)** — weights later iterations more heavily during averaging.
- **DCFR (Discounted CFR)** — introduces explicit discount factors α and β applied to cumulative regrets of different signs.
- **PCFR+ / Predictive CFR+** — uses predictive updates to anticipate the next iteration's regret.
- **DPCFR+** — combines discounting with predictive updates.
- **HS-PCFR+(30)** — a hot-start variant.

All of these were developed through human trial-and-error, each targeting a specific failure mode of its predecessor.

## The AlphaEvolve search space for CFR

The DeepMind paper expresses the CFR design space as three Python classes that together cover all known variants as special cases:

- **`RegretAccumulator`** — how per-iteration regrets are combined into cumulative regrets (this is where discount factors and sign-dependent scaling live).
- **`PolicyFromRegretAccumulator`** — how the current-iteration policy is derived from cumulative regrets (vanilla regret matching, predictive updates, etc.).
- **`PolicyAccumulator`** — how the running average policy is accumulated across iterations (linear, uniform, weighted, warm-started, etc.).

Mutating these three classes via [alphaevolve](../entities/alphaevolve.md) is the full variation space the evolutionary search operates over.

## Discovered variants

- **VAD-CFR** (Volatility-Adaptive Discounted CFR) — matches or exceeds state-of-the-art in **10 of 11** benchmark games. Introduces EWMA-based volatility tracking of instantaneous regret magnitude, asymmetric positive-regret boosting (factor 1.1), and a hard policy-averaging warm-start at iteration 500.
- **AOD-CFR** (Asymmetric Optimistic Discounted CFR) — a secondary discovery using more conventional mechanisms. Competitive performance through linear discount schedules, sign-dependent scaling, EMA-based policy optimism, and polynomial policy averaging.

See [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md) for the full mechanism descriptions and benchmark tables.

## Why CFR is a natural target for automated discovery

- **Clean structural interface** — the three-class decomposition captures the full design space.
- **Decades of hand-designed variants** — a rich baseline set to benchmark against.
- **Fast, exact evaluation** on small games using the OpenSpiel framework.
- **Well-defined fitness signal** — exploitability is computable exactly.
- **Known gaps** — human-designed variants like DCFR rely on fixed discount schedules, which is an obvious place for adaptive mechanisms to help.

See [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md) for the broader framework.

## Related

- [marl-imperfect-information-games](marl-imperfect-information-games.md)
- [policy-space-response-oracles](policy-space-response-oracles.md)
- [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md)
- [alphaevolve](../entities/alphaevolve.md)
- [google-deepmind](../entities/google-deepmind.md)
