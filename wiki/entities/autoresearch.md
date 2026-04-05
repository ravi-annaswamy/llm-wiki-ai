---
title: "AutoResearch"
type: entity
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"]
tags: [karpathy, project, automated-research, agentic-engineering, open-source, ml-training]
status: active
---

# AutoResearch

> **Karpathy's open-source project that lets an LLM coding agent run ML experiments overnight on a single GPU, keeping only changes that improve validation loss.** Released 2026-03-07, MIT, 21,000+ GitHub stars within days. The wiki's clean instance of an *uncircumventable* filter — the producer has no write access to the evaluator.

Repo: [github.com/karpathy/autoresearch](https://github.com/karpathy/autoresearch)

## The three-file contract

| File | Mutable by | Role |
|---|---|---|
| `prepare.py` | **No one** | Builds BPE tokenizer (8,192 vocab), processes corpus, defines `val_bpb`. Immutable so every experiment is measured on the same yardstick |
| `train.py` | Agent | 630 lines of GPT + `Muon+AdamW` + training loop. The sandbox |
| `program.md` | Human | Research directions, baselines, failure policy. Contains: *"NEVER STOP. Once the experiment loop has begun, do NOT pause to ask the human if you should continue."* |

The agent reads `program.md`, edits `train.py`, runs a 5-min experiment, evaluates against `val_bpb`, commits if better or `git reset HEAD~1` if worse, loops. This is the [ratchet-loop](../concepts/ratchet-loop.md).

**There is no orchestration script.** No `run.py`, no framework. The README simply says *"spin up your Claude/Codex or whatever you want in this repo."* The LLM is the automation layer.

## Reported results

| Run | Experiments | Kept | `val_bpb` |
|---|---|---|---|
| Karpathy initial overnight | 83 | 15 | 1.000 → 0.975 |
| Karpathy 2-day depth-12 | ~700 | ~20 | all additive, transferred to depth-24 |
| Community session | 126 | — | 0.9979 → 0.9697 |
| Karpathy `nanochat` (8×H100) | — | — | GPT-2 time 2.02h → 1.80h (11% faster) |
| Tobi Lutke / Shopify query-expansion | 37 | — | 19% val improvement, 0.8B params, day 1 |

**Structural findings** (actual code changes, not hyperparameter sweeps): missing scaler multiplier on `QKnorm`, regularization on Value Embeddings, banded attention tuning, `AdamW` beta adjustments, weight-decay scheduling.

## Why it matters in this wiki

- **[producer-filter-pattern](../analyses/producer-filter-pattern.md).** Producer = agent authoring `train.py` diffs; artifact = git commits; filter = `val_bpb` measured by immutable `prepare.py`. First wiki example of a **literally uncircumventable** filter.
- **[llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md).** Extends the pattern from algorithm-class search ([alphaevolve](alphaevolve.md) over MARL solvers) to full training-loop search. Same family, looser search space, single lineage vs population.
- **[long-running-agentic-coding](../concepts/long-running-agentic-coding.md).** `program.md` plays `CLAUDE.md`'s role; `results.tsv` + git play `CHANGELOG.md`'s role.

## Limits

Hits the [llm-research-creativity-ceiling](../concepts/llm-research-creativity-ceiling.md) — the ratchet rejects any temporarily-regressive step, so the agent can't cross a "worse before better" valley. Karpathy separately attributes the agent feeling "cagy and scared" on open-ended problems to RLHF rewarding conservative outputs.

## Hardware

Default: NVIDIA GPU 20+ GB VRAM, Python 3.10+, `uv`, a coding agent (Claude Code / Cursor / similar). For smaller hardware: TinyStories with vocab 256, depth 4. Community [macOS/Apple Silicon fork](https://github.com/miolini/autoresearch-macos) already exists.

## Related

- **Author:** [andrej-karpathy](andrej-karpathy.md)
- **Hub concepts:** [ratchet-loop](../concepts/ratchet-loop.md) · [agentic-engineering](../concepts/agentic-engineering.md) · [long-running-agentic-coding](../concepts/long-running-agentic-coding.md)
- **Analyses:** [producer-filter-pattern](../analyses/producer-filter-pattern.md) · [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md)
- **Contrast:** [alphaevolve](alphaevolve.md) (population search over algorithm class)
- **Limits:** [llm-research-creativity-ceiling](../concepts/llm-research-creativity-ceiling.md)
- **Source:** [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)
