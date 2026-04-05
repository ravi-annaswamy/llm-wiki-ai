---
title: "MARL in Imperfect-Information Games"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"]
tags: [marl, game-theory, poker, nash-equilibrium, reinforcement-learning]
status: active
---

# MARL in Imperfect-Information Games

Multi-Agent Reinforcement Learning (MARL) in **imperfect-information** games is the subfield concerned with training agents to play games where players act sequentially and cannot see each other's private information — the canonical example being poker. It is the domain where [[concepts/counterfactual-regret-minimization]] and [[concepts/policy-space-response-oracles]] developed, and the test bed for the algorithm-discovery work in [[sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory]].

## Why it's harder than perfect-information games

Games like chess and Go are **perfect-information**: every player can see the full state. Minimax and its descendants (including AlphaZero-style self-play with value functions) work because the relevant decision is a function of a fully observable position.

Imperfect-information games break that assumption. In poker:

- A player's optimal action depends on beliefs about hidden cards and hidden strategies.
- A single observable state (the public board) corresponds to many possible underlying situations — an **information set**.
- Bluffing, mixed strategies, and equilibrium reasoning become first-class.

As a result, the solution concept shifts from "best move in this position" to "strategy that is a best response to the opponent's strategy, and vice versa" — i.e., a **Nash Equilibrium (NE)** in the extensive-form game.

## Canonical algorithmic paradigms

Two families have dominated the academic literature, and both are the targets of the AlphaEvolve paper:

- **[[concepts/counterfactual-regret-minimization]]** (CFR) — iterative regret minimization decomposed across information sets. Time-averaged strategy converges to Nash Equilibrium. Core variants: CFR+, DCFR, PCFR+, DPCFR+, etc.
- **[[concepts/policy-space-response-oracles]]** (PSRO) — maintains a population of policies per player, computes a meta-game payoff tensor, and uses a meta-strategy solver to decide how to mix over the population. Best responses to the current mixture are added to the population iteratively.

CFR operates at the level of information sets; PSRO operates at the level of entire policies. They're complementary abstractions and are often benchmarked against each other.

## Standard benchmark games

The DeepMind paper uses a familiar suite of small imperfect-information games:

- **Kuhn Poker** (3-player and 4-player variants) — a simplified poker with a 3-card deck; the classic toy domain for CFR research.
- **Leduc Poker** (2-player and 3-player variants) — slightly larger, with two rounds of betting and a public card.
- **Goofspiel** (4-card and 5-card variants) — a bidding card game.
- **Liars Dice** (4-, 5-, 6-sided variants) — a dice-bidding game where players hide information from each other.

The training/test split is on **game size**: train on smaller variants, evaluate on larger ones with no retuning. This is how generalization is measured in the paper.

## Evaluation metric

**Exploitability** is the standard measure: how much a best-responding opponent could gain against the given strategy relative to playing a Nash equilibrium. Lower is better. Zero exploitability means the strategy is an exact Nash equilibrium.

All experiments in the DeepMind paper use the **OpenSpiel** framework with an **exact** best-response oracle (computed via value iteration) and exact payoff entries — removing Monte Carlo sampling noise from the results. This is important because it isolates algorithmic improvements from variance in the evaluation.

## Why the domain is interesting for AlphaEvolve

The field has:

1. **A clean, well-defined fitness signal** (negative exploitability).
2. **Mature baselines** (decades of CFR and PSRO variants to beat).
3. **A structured algorithmic substrate** where new variants can be expressed as modifications of a small number of Python classes.
4. **Fast, exact evaluation** on small games, which makes high-throughput evolutionary search tractable.

All four conditions are exactly what an LLM-driven algorithm search needs, which is why imperfect-information game theory was a natural first venue for [[concepts/llm-driven-algorithm-discovery]] applied to [[entities/alphaevolve]].

## Related

- [[concepts/counterfactual-regret-minimization]]
- [[concepts/policy-space-response-oracles]]
- [[concepts/llm-driven-algorithm-discovery]]
- [[entities/alphaevolve]]
- [[entities/google-deepmind]]
