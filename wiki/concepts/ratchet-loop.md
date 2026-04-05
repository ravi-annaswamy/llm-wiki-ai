---
title: "Ratchet Loop"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"]
tags: [automated-research, filter-loop, git-workflow, evaluation, producer-filter, monotonic-search]
status: active
---

# Ratchet Loop

A filter-loop architecture for automated experimentation in which every candidate change is **either committed or reverted** based on whether it strictly improves a fixed scalar metric. The codebase can only move forward, never backward — the name comes from the physical ratchet, a mechanism that permits motion in only one direction (Source: [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)).

The concrete instance in this wiki is [autoresearch](../entities/autoresearch.md), where an LLM coding agent modifies a training file, runs a 5-minute experiment, and either keeps the commit (if `val_bpb` improved) or runs `git reset HEAD~1` (if not). But the pattern is substrate-agnostic and worth naming separately because it has distinctive structural properties — including distinctive failure modes.

## The minimal specification

A ratchet loop has five components:

1. **A fixed, immutable evaluator** that emits a scalar metric. In AutoResearch, `prepare.py` — neither human nor agent can touch it.
2. **A mutable artifact** that the producer (here an LLM) is allowed to modify freely. In AutoResearch, `train.py`.
3. **A fixed-budget evaluation step.** Every candidate gets the same compute / wall-clock (5 minutes for AutoResearch), so a change that trains faster and one that converges lower are compared on equal footing.
4. **A monotonicity rule.** Keep only if strictly better. Ties can be kept or rejected by policy; AutoResearch keeps the prior version on ties.
5. **Version control as memory.** Git commits form the entire history. `results.tsv` or equivalent records the full audit trail so the producer can condition future proposals on past successes and failures.

A single iteration of the loop is:

```
propose → modify → commit → evaluate → keep-or-revert → repeat
```

The producer reads the prior history before proposing. The filter does not.

## What ratcheting is good for

- **Monotonic improvement with a tight audit trail.** Every experiment is either a recorded success (committed) or a recorded failure (in the log but reverted). You can review the morning's work by reading git log.
- **Uncircumventable evaluation.** Because the evaluator is immutable and the producer has no write access to it, the producer cannot game the metric by modifying the measurement. This is the structural advantage that makes AutoResearch trustworthy to run overnight without supervision.
- **Parallel-comparable experiments.** The fixed budget makes results directly comparable, which in turn lets the producer learn what kinds of changes tend to help from the log alone.
- **Evolutionary structure without a population.** Unlike a typical evolutionary search, a ratchet maintains a **single lineage**. The LLM plays both the mutation operator and the selection pressure — it reads the history and decides what to try next. Much cheaper than a population-based search; much less exploration.

## The structural blindspot

A ratchet **cannot traverse a valley**. Any change that would make the metric temporarily worse to set up a larger later gain is rejected at the step that matters most: the first one. Human researchers routinely reason *"this will get worse before it gets better"* — refactoring to a new architecture, switching to a harder-to-tune optimizer, rebuilding a training pipeline from scratch. The ratchet has no room for that move.

This is the root cause of the [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md) observed on AutoResearch: the agent cycles through minor variations of whatever worked last, stuck in a local region of search space. The limit is not in the LLM's creativity — it is in the filter's admissibility rule.

Proposed remedies (still debated in the [autoresearch](../entities/autoresearch.md) community):
- **Periodic resets** — restart from an earlier checkpoint to escape local optima.
- **Diversity-aware filters** — reward novelty alongside improvement.
- **Multi-lineage ratchets** — maintain k parallel lineages with occasional cross-copying, recovering some of a population-based search's exploration.
- **Meta-prompt optimization** — a second agent rewrites the `program.md`-equivalent based on what's been tried.

None of these preserve the ratchet's clean audit trail as cheaply as the original. The tradeoff is real.

## Ratchet vs. population-based search

|  | Ratchet loop | Population-based (e.g. classical EA, [alphaevolve](../entities/alphaevolve.md)) |
|---|---|---|
| State | Single lineage | Population of k candidates |
| Mutation operator | LLM reading git history | LLM reading sampled parent |
| Selection | Strict monotone on metric | Tournament / truncation / proportional |
| Exploration | Low — stuck on local improvements | Higher — parents can be dominated but still reproduce |
| Compute per generation | 1 evaluation | k evaluations |
| Audit trail | Linear git log | Genealogy graph |

The ratchet is the cheaper and more legible of the two. The population is the one more likely to find a structurally new answer. AutoResearch deliberately picks the ratchet for overnight operation on a single GPU; AlphaEvolve picks the population for overnight operation on a DeepMind cluster.

## Where else the pattern fits

Any producer–filter instance where the filter is (a) cheap enough to run every iteration, (b) fully mechanical, and (c) sensitive enough to discriminate most candidate changes. The 5-minute training window in AutoResearch is a specific parameter choice; the general pattern would apply to:

- **Compiler optimization passes** — evaluator = benchmark suite wall-clock.
- **Search ranking weights / reranker code** — evaluator = offline NDCG on a held-out set.
- **Query expansion models** — evaluator = retrieval metric; already an instance (Shopify/Lutke).
- **Numerical solvers with a reference implementation** — evaluator = error against the reference, mirroring the [clax-project](../entities/clax-project.md) setup but with monotone keep/revert instead of continuous development.
- **Automated theorem proving over a fixed problem set** — evaluator = proofs verified per unit time.

In every case the load-bearing design choices are the **immutability of the evaluator** and the **fixed evaluation budget**. Without both, the producer can either corrupt the filter or cheat on the comparison.

## Relationship to the producer–filter pattern

A ratchet loop is a specific, strict implementation of the [producer-filter-pattern](../analyses/producer-filter-pattern.md). Most instances of the producer–filter pattern are **weaker**: a linter that flags issues but doesn't auto-revert, a test suite that must be green at commit time but tolerates intermediate red states on a branch, a human reviewer who accepts or rejects over a longer timescale. The ratchet is what you get when you push the filter as close to "every change, immediately, no negotiation" as possible.

The tradeoff: maximum discipline, minimum exploration. Worth it overnight on a GPU; probably not worth it for a large refactor where the first step is a structural rearrangement that temporarily breaks everything.

## Related

- [autoresearch](../entities/autoresearch.md)
- [producer-filter-pattern](../analyses/producer-filter-pattern.md)
- [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md)
- [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md)
- [long-running-agentic-coding](long-running-agentic-coding.md)
- [agent-persistent-memory](agent-persistent-memory.md)
- [test-oracle-for-agents](test-oracle-for-agents.md)
