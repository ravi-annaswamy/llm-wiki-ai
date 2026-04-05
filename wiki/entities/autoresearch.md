---
title: "AutoResearch"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"]
tags: [karpathy, project, automated-research, agentic-engineering, open-source, ml-training]
status: active
---

# AutoResearch

An open-source Python project by [andrej-karpathy](andrej-karpathy.md) that lets an LLM coding agent run ML experiments overnight on a single GPU without human supervision, keeping only changes that improve validation loss. Released 2026-03-07 under MIT license; 21,000+ GitHub stars within days (Source: [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)).

Repo: https://github.com/karpathy/autoresearch

## What it is

A **three-file contract** between human, agent, and evaluator:

- **`prepare.py`** — immutable. Builds the BPE tokenizer (8,192-token vocab), processes the training corpus, defines the `val_bpb` (validation bits-per-byte) metric. Neither human nor agent is allowed to edit it, which guarantees that every experiment is measured on the same yardstick.
- **`train.py`** — the agent's sandbox. 630 lines of GPT model + `Muon+AdamW` optimizer + training loop. The agent can rewrite anything here as long as the code still trains and produces a `val_bpb` score.
- **`program.md`** — Markdown, human-authored. Sets research directions, baseline metrics, failure-handling policy. Includes the pivotal directive: *"NEVER STOP. Once the experiment loop has begun, do NOT pause to ask the human if you should continue."*

The agent reads `program.md`, modifies `train.py`, runs a 5-minute training experiment, evaluates against `val_bpb`, commits if better or `git reset HEAD~1` if worse, then loops. This is the [ratchet-loop](../concepts/ratchet-loop.md). See the source page for the 9-step iteration.

Notably, there is **no orchestration script**. No `run.py`, no framework. The README simply says *"spin up your Claude/Codex or whatever you want in this repo."* The LLM is the automation layer.

## Why it matters in this wiki

AutoResearch is a clean instance of several patterns this wiki already tracks:

- **[producer-filter-pattern](../analyses/producer-filter-pattern.md).** Producer: the agent authoring `train.py` diffs. Artifact: git commits. Filter: `val_bpb`, measured by the immutable `prepare.py`. It is the wiki's first example of a filter that is **literally uncircumventable** — the producer has no write access to the evaluator.
- **[llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md).** Extends the pattern from algorithm-class search ([alphaevolve](alphaevolve.md) over MARL solvers) to full training-loop search. Same family, looser search space, single lineage rather than population.
- **[long-running-agentic-coding](../concepts/long-running-agentic-coding.md).** A textbook instance: well-scoped deliverable, quantifiable success criterion, occasional human oversight. `program.md` plays the role of the portable `CLAUDE.md` plan; `results.tsv` + git history play the role of the `CHANGELOG.md` cross-session memory (see [agent-persistent-memory](../concepts/agent-persistent-memory.md)).

## Reported results

- Initial overnight run: 83 experiments, 15 kept, `val_bpb` 1.000 → 0.975.
- Extended 2-day run on depth-12 models: ~700 experiments, ~20 kept, all additive, gains transferred to depth-24.
- Production impact against Karpathy's `nanochat` framework: time-to-GPT-2 benchmark from 2.02h → 1.80h (11% faster).
- Community session: 126 experiments, `val_bpb` 0.9979 → 0.9697.
- Shopify (Tobi Lutke) adaptation for an internal query-expansion model: 19% validation improvement from 37 experiments on a 0.8B-param model, reported the day after he started.

Structural findings the agent made (not hyperparameter sweeps, actual code changes): a missing scaler multiplier on `QKnorm` for attention sharpening, regularization on Value Embeddings, banded attention tuning, `AdamW` beta adjustments, weight decay scheduling.

## Limits

Hits the [llm-research-creativity-ceiling](../concepts/llm-research-creativity-ceiling.md) — the ratchet rejects any temporarily-regressive step, so the agent cannot traverse a "worse before better" valley. Karpathy separately attributes the agent feeling "cagy and scared" on open-ended problems to RLHF training rewarding conservative outputs.

## Hardware and practical notes

Default config: NVIDIA GPU with 20+ GB VRAM, Python 3.10+, `uv`, and a coding agent (Claude Code, Cursor, or similar). For smaller hardware, Karpathy recommends TinyStories with vocabulary reduced to 256 and depth to 4. Karpathy's own production setup is an 8×H100 "bigger cousin" running against `nanochat`.

The community has already forked it for [macOS/Apple Silicon](https://github.com/miolini/autoresearch-macos).

## Related

- [andrej-karpathy](andrej-karpathy.md)
- [ratchet-loop](../concepts/ratchet-loop.md)
- [agentic-engineering](../concepts/agentic-engineering.md)
- [llm-research-creativity-ceiling](../concepts/llm-research-creativity-ceiling.md)
- [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md)
- [long-running-agentic-coding](../concepts/long-running-agentic-coding.md)
- [producer-filter-pattern](../analyses/producer-filter-pattern.md)
- [alphaevolve](alphaevolve.md)
