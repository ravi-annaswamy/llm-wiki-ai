---
title: "MARL in Imperfect-Information Games"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"]
tags: [marl, game-theory, poker, nash-equilibrium, reinforcement-learning]
status: active
---

# MARL in Imperfect-Information Games

> **Multi-Agent RL on games where players act sequentially and cannot see each other's private information — poker is the canonical example.** The domain where [counterfactual-regret-minimization](counterfactual-regret-minimization.md) and [policy-space-response-oracles](policy-space-response-oracles.md) developed, and the test bed for the [alphaevolve](../entities/alphaevolve.md) algorithm-discovery work.

## Why it's harder than perfect-information games

Chess and Go are perfect-information: minimax + AlphaZero-style self-play work because the decision depends only on a fully observable position. Poker breaks that:

| Change | Consequence |
|---|---|
| Private hidden cards | Optimal action depends on *beliefs* about opponent |
| Many underlying situations → one observable | Reasoning lives at the level of an **information set**, not a position |
| First-class bluffing, mixed strategies | Solution concept shifts to **Nash Equilibrium** in the extensive-form game |

## Canonical algorithmic paradigms

| Paradigm | Abstraction | Canonical variants |
|---|---|---|
| **CFR** — iterative regret minimization per information set; time-averaged strategy converges to NE | Information set level | CFR+, DCFR, PCFR+, DPCFR+ |
| **PSRO** — maintain a population of policies per player, build meta-game payoff tensor, mix via meta-strategy solver | Whole-policy level | PSRO, PSRO-RN, Joint-PSRO |

Complementary abstractions, routinely benchmarked against each other.

## Benchmark suite (DeepMind paper)

| Game | Variants | Size range |
|---|---|---|
| Kuhn Poker | 3-player, 4-player | Smallest classic CFR toy |
| Leduc Poker | 2-player, 3-player | Two betting rounds, public card |
| Goofspiel | 4-card, 5-card | Bidding card game |
| Liar's Dice | 4-, 5-, 6-sided | Dice bidding with hidden info |

Train/test split by **game size**: train on smaller variants, evaluate on larger ones without retuning.

## Evaluation: exploitability

Exploitability = how much a best-responding opponent could gain vs playing NE. Lower is better; zero = exact NE. The DeepMind paper uses **OpenSpiel** with an **exact** best-response oracle (value iteration) and exact payoff entries — no Monte Carlo noise. This isolates algorithmic improvement from evaluation variance.

## Why this domain fits AlphaEvolve

| Condition | How the domain supplies it |
|---|---|
| Clean fitness signal | Negative exploitability |
| Mature baselines | Decades of CFR and PSRO variants |
| Structured algorithmic substrate | New variants expressible as modifications of a few Python classes |
| Fast exact evaluation on small games | High-throughput evolutionary search tractable |

All four are exactly what [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md) needs — which is why imperfect-information game theory was a natural first venue for [alphaevolve](../entities/alphaevolve.md).

## Related

- **Algorithms:** [counterfactual-regret-minimization](counterfactual-regret-minimization.md) · [policy-space-response-oracles](policy-space-response-oracles.md)
- **Discovery system:** [alphaevolve](../entities/alphaevolve.md) · [google-deepmind](../entities/google-deepmind.md)
- **Hub:** [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md)
- **Source:** [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md)
