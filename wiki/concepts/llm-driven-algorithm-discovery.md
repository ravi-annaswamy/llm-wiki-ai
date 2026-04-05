---
title: "LLM-Driven Algorithm Discovery"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources:
  - "wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"
  - "wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"
tags: [automated-research, evolutionary, llm, meta-learning, deepmind, karpathy, ratchet-loop]
status: active
---

# LLM-Driven Algorithm Discovery

> **Using an LLM, rather than a human researcher, as the mutation and variation operator in a search over algorithm design space — producing new algorithms (or variants of existing ones) by reading and rewriting actual source code at each step.**

## Two instances, opposite design axes

| Axis | [alphaevolve](../entities/alphaevolve.md) (DeepMind) | [autoresearch](../entities/autoresearch.md) (Karpathy) |
|---|---|---|
| **Search scaffolding** | Tight — Python class hierarchies that represent known variants as special cases | Loose — a single 630-line `train.py`, no class scaffolding |
| **Search topology** | Population-based evolutionary search | Single-lineage [ratchet-loop](ratchet-loop.md) |
| **Mutation operator** | Gemini 2.5 Pro | Any coding agent (Claude Code, Cursor, Codex) |
| **Fitness signal** | Exploitability across 11 games | `val_bpb` after 5-minute training slice |
| **Hardware** | DeepMind cluster | Single GPU |
| **License** | Closed-source | MIT |
| **Domain** | CFR / PSRO in [marl-imperfect-information-games](marl-imperfect-information-games.md) | Full GPT training loop |

The two instances differ along almost every axis — and that's the most informative thing about them. The family is broad; the key question is **what kind of filter you can afford to run every iteration**. AlphaEvolve runs an exploitability sweep; AutoResearch runs a 5-minute training slice. Both are cheap enough to close the loop.

## The reframing

| Classical | LLM-driven |
|---|---|
| Human develops intuition | Human designs search space + fitness signal |
| Human proposes update rule | LLM generates code variants |
| Human benchmarks and iterates | Evaluation loop benchmarks and iterates |
| Publish variant | Variant is the **output** of the search, not the input |

The human role shifts from "propose algorithm" to "design the search space, the fitness signal, and the evaluation protocol."

## What had to be true

LLMs have been code generators for a while. What's new is using them as the **variation operator inside an evolutionary loop**, where the unit of mutation is a block of code rather than a numeric parameter. Two conditions:

1. LLMs had to get good at reading existing algorithm implementations and producing **semantically meaningful** modifications — coherent edits that respect invariants, not random token edits.
2. The search had to produce mutations that evaluate differently enough for the evolutionary signal to carry information. If 99% of edits are performance-equivalent, there's no gradient.

AlphaEvolve in game theory is evidence both are satisfied, at least in a structured domain.

## What it discovered (game-theory case)

Non-intuitive mechanisms a human would typically not arrive at:

- **A hard policy-averaging warm-start at iteration 500** in VAD-CFR — chosen by the LLM without knowing the 1000-iteration evaluation horizon.
- **Asymmetric instantaneous-regret boosting by ×1.1** — applied to the instantaneous update, not the accumulated history.
- **Asymmetric training-time vs evaluation-time solver configurations** in SHOR-PSRO — the search itself discovered that these should differ. Not a design move a human researcher would typically make.

These are the paper's argument for why automated algorithm search is worth doing: the mechanisms found are not translations of things in the literature.

## What AutoResearch adds to the story

AutoResearch demonstrates the approach works with a **much looser search space**. AlphaEvolve used tight Python class hierarchies; AutoResearch lets the agent rewrite activations, attention heads, LR schedules, initialization, optimizer internals in a single flat file. Same family, much less structure.

**What it loses:** the kind of genuine novelty AlphaEvolve found. The ratchet filter's strict-improve rule rules out valley-traversing moves. See [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md).

**What it gains:** radical accessibility. Single GPU, any off-the-shelf coding agent, overnight API budget. Shopify's Tobi Lutke adapted it to a production query-expansion model and reported **19% validation improvement from 37 experiments** on day 1.

Together, the two instances suggest the design space is not "evolution or not" but **how tight is your scaffolding, how expensive is one evaluation, how often can you close the loop**. Tight + expensive = population, cluster-scale. Loose + cheap = ratchet, single-GPU.

## Generalization

Anywhere you can (a) express the algorithm as structured code with a clean interface, (b) define a discriminating fitness signal, (c) run enough evaluations per generation for a useful gradient. Likely next targets: optimizers, attention variants, RL algorithms, compiler passes, graph algorithms, simulator subroutines.

## Connection to other wiki threads

The broader pattern is **LLM as active producer of structured artifacts inside an evaluation loop** — instances in [llm-knowledge-bases](llm-knowledge-bases.md) (LLM authors a wiki from raw sources; lint loop as filter), here (LLM authors algorithm code; exploitability/val_bpb as filter), and [coral-hart](../entities/coral-hart.md) (LLM authors fiction; human + market as filter). In each case the LLM is **generating durable output that becomes part of the substrate**, not answering a query. See [producer-filter-pattern](../analyses/producer-filter-pattern.md).

It also weakly touches [own-your-substrate](../analyses/own-your-substrate.md): DeepMind controls Gemini 2.5 Pro, AlphaEvolve, and OpenSpiel. The compounding asset isn't the discovered algorithms — it's the discovery infrastructure.

## Open questions

- How structured does the search space have to be for LLM mutation to converge?
- What fraction of "discoveries" are genuine novelty vs LLM retrieving tricks from training data?
- Does the approach scale to longer files and more complex interfaces?
- Mutation cost vs evaluation cost — which dominates at scale?

## Related

- **Hub:** [producer-filter-pattern](../analyses/producer-filter-pattern.md)
- **Instances:** [alphaevolve](../entities/alphaevolve.md) · [autoresearch](../entities/autoresearch.md)
- **Mechanism:** [ratchet-loop](ratchet-loop.md) · [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md)
- **Authors:** [google-deepmind](../entities/google-deepmind.md) · [andrej-karpathy](../entities/andrej-karpathy.md)
- **Domain:** [counterfactual-regret-minimization](counterfactual-regret-minimization.md) · [policy-space-response-oracles](policy-space-response-oracles.md) · [marl-imperfect-information-games](marl-imperfect-information-games.md)
- **Sibling pattern:** [llm-knowledge-bases](llm-knowledge-bases.md)
- **Sources:** [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md) · [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)
