---
title: "Ratchet Loop"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"]
tags: [automated-research, filter-loop, git-workflow, evaluation, producer-filter, monotonic-search]
status: active
---

# Ratchet Loop

> **A filter-loop architecture for automated experimentation in which every candidate change is either committed or reverted based on whether it strictly improves a fixed scalar metric.** The codebase can only move forward. The name comes from the physical ratchet — a mechanism that permits motion in one direction only.

The canonical instance is [autoresearch](../entities/autoresearch.md): an LLM coding agent modifies `train.py`, runs a 5-minute experiment, keeps the commit if `val_bpb` improved, otherwise `git reset HEAD~1`. The pattern is substrate-agnostic and worth naming separately because its structural properties — including failure modes — are distinctive.

## The five required pieces

| Component | Role | In AutoResearch |
|---|---|---|
| **Fixed, immutable evaluator** | Emits the scalar metric | `prepare.py` — neither human nor agent touches it |
| **Mutable artifact** | What the producer modifies | `train.py` |
| **Fixed-budget evaluation** | Equal compute per candidate | 5-minute wall-clock |
| **Monotonicity rule** | Keep only if strictly better | Ties keep the prior version |
| **Version control as memory** | Full audit trail | Git + `results.tsv` |

One iteration: `propose → modify → commit → evaluate → keep-or-revert → repeat`. The producer reads prior history before proposing; the filter does not.

## What ratcheting is good for

- **Monotone improvement with a tight audit trail.** Morning's work = `git log`.
- **Uncircumventable evaluation.** Producer has no write access to the evaluator, so it cannot game the metric. This is the structural advantage that makes AutoResearch trustworthy overnight.
- **Parallel-comparable experiments.** Fixed budget → directly comparable results → producer can learn what helps from the log alone.
- **Evolutionary structure without a population.** Single lineage; the LLM plays both mutation and selection. Much cheaper than a population-based search; much less exploration.

## The structural blind spot

A ratchet **cannot traverse a valley**. Any change that would make the metric temporarily worse to set up a larger later gain is rejected at the step that matters most: the first one. Human researchers routinely make such moves — refactoring to a new architecture, switching optimizers, rebuilding a pipeline. The ratchet has no room for it.

This is the root cause of the [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md) on AutoResearch: the agent cycles through minor variations of whatever worked last. **The limit is in the filter's admissibility rule, not the producer's creativity.**

Debated remedies: periodic resets, diversity-aware filters, multi-lineage ratchets, meta-prompt optimization. None preserve the clean audit trail as cheaply as the original.

## Ratchet vs population-based search

|  | Ratchet loop | Population ([alphaevolve](../entities/alphaevolve.md)) |
|---|---|---|
| State | Single lineage | k candidates |
| Mutation | LLM reading git history | LLM reading sampled parent |
| Selection | Strict monotone on metric | Tournament / truncation |
| Exploration | Low — stuck on local wins | Higher — dominated parents still reproduce |
| Compute per generation | 1 evaluation | k evaluations |
| Audit trail | Linear git log | Genealogy graph |

Ratchet is cheaper and more legible; population is more likely to find structurally new answers. AutoResearch picks the ratchet for single-GPU overnight; AlphaEvolve picks the population for DeepMind-cluster overnight.

## Where else the pattern fits

Any producer–filter instance where the filter is (a) cheap enough per iteration, (b) fully mechanical, (c) sensitive enough to discriminate candidates. Examples: compiler optimization passes, search-ranking rerankers, query expansion (Shopify already did it), numerical solvers with a reference implementation ([clax-project](../entities/clax-project.md)-style but with hard keep/revert), automated theorem proving on a fixed problem set.

The load-bearing design choices everywhere: **immutable evaluator + fixed budget**. Without both, the producer can corrupt the filter or cheat the comparison.

## Relationship to the producer–filter pattern

A ratchet is a specific, strict implementation of [producer-filter-pattern](../analyses/producer-filter-pattern.md). Most instances of producer–filter are weaker — a linter that flags but doesn't revert, a green-CI gate that tolerates red on branches, a human reviewer on a longer timescale. The ratchet pushes the filter as close to "every change, immediately, no negotiation" as possible. Tradeoff: maximum discipline, minimum exploration.

## Related

- **Canonical instance:** [autoresearch](../entities/autoresearch.md)
- **Parent pattern:** [producer-filter-pattern](../analyses/producer-filter-pattern.md)
- **Contrast:** [alphaevolve](../entities/alphaevolve.md) · [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md)
- **Consequence:** [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md)
- **Siblings:** [long-running-agentic-coding](long-running-agentic-coding.md) · [agent-persistent-memory](agent-persistent-memory.md) · [test-oracle-for-agents](test-oracle-for-agents.md)
- **Source:** [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)
