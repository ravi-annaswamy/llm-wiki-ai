---
title: "DataCamp — A Guide to Andrej Karpathy's AutoResearch"
type: source
created: 2026-04-04
updated: 2026-04-05
sources: ["raw/2026-04-04-datacamp-A Guide to Andrej Karpathy's AutoResearch Automating ML with AI Agents.md"]
tags: [karpathy, autoresearch, automated-research, agentic-engineering, ratchet-loop, producer-filter, ml-training, long-running-agentic-coding]
status: active
---

# DataCamp — A Guide to Andrej Karpathy's AutoResearch

> **A DataCamp walkthrough of [andrej-karpathy](../entities/andrej-karpathy.md)'s [autoresearch](../entities/autoresearch.md): an MIT-licensed tool (released 2026-03-07) that lets a coding agent run ML experiments overnight on a single GPU, keeping only changes that improve `val_bpb`.** The wiki's cleanest instance of the producer–filter pattern applied to ML research itself.

**Original:** DataCamp tutorial by Bex Tuychiev (2026-03-22). 21,000+ GitHub stars, 8.6M views on Karpathy's announcement within days.

## What it is (and isn't)

Not AutoML/NAS (constrained parameter search), not a general coding agent (no experiment-evaluate-keep/revert loop), not AlphaEvolve (closed-source, cluster-scale evolutionary). AutoResearch bets on **LLM general knowledge over search-space constraints** — the search space is "whatever the LLM can think of." See [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md).

## The three-file contract

| File | Role | Mutable by |
|---|---|---|
| `prepare.py` | Data prep + BPE tokenizer + `val_bpb` evaluation | **Immutable.** Guarantees identical measurement across experiments |
| `train.py` | 630-line GPT + `Muon+AdamW` + full training loop | **Agent only.** Rewrite anything as long as it still trains |
| `program.md` | Research directions, failure handling, `"NEVER STOP"` directive, baseline to beat | **Human only** |

Clean separation: human sets direction, agent executes, `prepare.py` is a neutral judge neither side can corrupt. Baseline: `val_bpb` 0.997900, peak VRAM 45 GB. Two load-bearing directives in `program.md`:

- *"NEVER STOP. Once the experiment loop has begun, do NOT pause to ask the human if you should continue."* — scaffold against [agentic-laziness](../concepts/agentic-laziness.md).
- *"All else being equal, simpler is better."* — steers away from over-engineered changes.

## The ratchet loop

Each iteration: read `program.md` → examine `train.py` + `results.tsv` → propose → modify → commit → train **exactly 5 minutes** → evaluate → **if improved, keep; else `git reset HEAD~1`**. ~12 experiments/hour, 80–100 per overnight run. The codebase can only move forward. See [ratchet-loop](../concepts/ratchet-loop.md).

The fixed 5-minute budget makes a faster-training change and a lower-converging change comparable — but also makes long-horizon improvements invisible.

## Memory: git + results.tsv

No vector store, no hidden memory. `results.tsv` tracks commit hash, `val_bpb`, VRAM, pass/fail, and description. The agent reads it at session start. **Single lineage, not a population** — the LLM is both mutation operator and selection pressure. Same move as `CHANGELOG.md`/`CLAUDE.md` in [agent-persistent-memory](../concepts/agent-persistent-memory.md): on-disk, legible, human-auditable.

## Results across runs

| Run | Experiments | Kept | Result |
|---|---|---|---|
| Initial overnight (single GPU) | 83 | 15 | `val_bpb` 1.000 → 0.975 |
| Extended 2-day run (depth-12) | ~700 | ~20 | All additive; transferred to depth-24 |
| Production (Karpathy's nanochat, 8×H100) | — | — | Time-to-GPT-2: 2.02h → 1.80h (**11% faster**) |
| Shopify / Tobi Lutke (0.8B query expansion) | 37 | — | **19% validation improvement, day 1** |

Specific mechanisms found: `QKnorm` missing a scaler, value-embedding regularization, banded attention tuning, `AdamW` beta adjustments, weight-decay scheduling.

## The creativity ceiling

The staircase is real but **each step is small**. Nobody reports AutoResearch inventing a novel attention mechanism. Two sources:

1. **Architectural — the ratchet cannot traverse a valley.** A change that would get worse before it gets better is rejected at the step that matters. [GitHub issue #22](https://github.com/karpathy/autoresearch/issues/22).
2. **Model-level — RLHF conservatism.** Karpathy on HN: the agent feels *"cagy and scared"* on open-ended problems.

Additional limits: 5-minute window (long-horizon invisible), overfitting risk (same eval set, 100+ runs), immutability of `prepare.py` (fairness guarantee = blind spot). See [llm-research-creativity-ceiling](../concepts/llm-research-creativity-ceiling.md).

## Methodological arc

Karpathy's progression: **vibe coding** → **agentic engineering** → **independent research**. Each step reduces the human role: writer → director → research advisor. *"The goal is not to emulate a single PhD student, it's to emulate a research community of them."* See [agentic-engineering](../concepts/agentic-engineering.md).

## When it fits

Any domain with an automatic scoring function: search ranking, product categorization, clinical NER, fraud scoring. Small models, fast training, transferable improvements. **When experiments run 100× faster than a human can manage, the eval pipeline becomes the constraint.** Static benchmarks saturate.

> *"If the next generation of engineers skips that formative work because agents handle it now, the field will have plenty of compute and no one with the experience to point it in the right direction."*

## Cross-wiki threads

- **[producer-filter-pattern](../analyses/producer-filter-pattern.md)** — the cleanest example so far of a filter that is literally uncircumventable by the producer.
- **[llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md)** — extends the family from algorithm-class search (AlphaEvolve) to full training-loop search, looser scaffolding, single-lineage.
- **[long-running-agentic-coding](../concepts/long-running-agentic-coding.md)** — `program.md` = `CLAUDE.md`, `results.tsv` + git = `CHANGELOG.md`. **Single sequential lineage**, like [clax-project](../entities/clax-project.md), unlike the [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md) swarm.
- **"NEVER STOP" = [ralph-loop](../concepts/ralph-loop.md)** for this scaffold.

## Prompt

> ingest raw/2026-04-04-datacamp-A Guide to Andrej Karpathy's AutoResearch
