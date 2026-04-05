---
title: "Andrej Karpathy"
type: entity
created: 2026-04-04
updated: 2026-04-05
sources:
  - "wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"
  - "wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"
tags: [person, ai-researcher, openai, tesla, karpathy-pattern, autoresearch, agentic-engineering]
status: active
---

# Andrej Karpathy

> **Former Director of AI at Tesla, OpenAI co-founder, originator of the LLM Knowledge Base pattern this wiki implements, and author of [autoresearch](autoresearch.md).** Across the wiki's sources he is producing a recognizable methodological arc: humans set direction in Markdown, LLMs do sustained production work inside mechanical filter loops.

## The methodological arc (2024 → 2026)

| Stage | Human role | AI role |
|---|---|---|
| **Vibe coding** (earlier coinage) | Prompts, reviews each diff | Writes code |
| **Agentic engineering** (Feb 2026) | Orchestrates, oversees | Writes ~99% of code |
| **Independent research** ([autoresearch](autoresearch.md), Mar 2026) | Writes `program.md`, walks away | Runs experiments, ratchets on `val_bpb` |

Follow-up framing after AutoResearch: *"The goal is not to emulate a single PhD student, it's to emulate a research community of them"* — with a gesture toward SETI@home-style distributed agent collaboration.

## The two Karpathy artifacts in the wiki

| Artifact | Source directive | Producer | Filter |
|---|---|---|---|
| [llm-knowledge-bases](../concepts/llm-knowledge-bases.md) | `CLAUDE.md` wiki schema | LLM editing wiki pages | Lint pass |
| [autoresearch](autoresearch.md) | `program.md` research plan | LLM editing `train.py` | Immutable `val_bpb` |

Both are instances of [producer-filter-pattern](../analyses/producer-filter-pattern.md). Together they stake out Karpathy's position: **the compounding work of an AI-enabled researcher lives in the artifact repository plus filter, not in the model weights or the chat UI.**

On knowledge bases specifically, Karpathy rejects vector-DB / RAG orthodoxy for mid-sized corpora (~100 articles, ~400k words), arguing modern LLMs reason over structured text directly. See [rag-vs-wiki-comparison](../concepts/rag-vs-wiki-comparison.md). His memorable framing:

> You rarely ever write or edit the wiki manually; it's the domain of the LLM.

On AutoResearch, he runs a "bigger cousin" on 8×H100s against his production `nanochat` — evidence the pattern scales beyond toy experiments. He also acknowledges its [llm-research-creativity-ceiling](../concepts/llm-research-creativity-ceiling.md).

## Terms coined or popularized

Vibe coding · Agentic engineering · LLM Knowledge Bases · AutoResearch (now a shorthand for the three-file ratchet architecture).

## Related

- **Projects:** [autoresearch](autoresearch.md)
- **Hub concepts:** [llm-knowledge-bases](../concepts/llm-knowledge-bases.md) · [agentic-engineering](../concepts/agentic-engineering.md) · [ratchet-loop](../concepts/ratchet-loop.md)
- **Analyses:** [producer-filter-pattern](../analyses/producer-filter-pattern.md)
- **Adjacent:** [llm-research-creativity-ceiling](../concepts/llm-research-creativity-ceiling.md) · [file-over-app-philosophy](../concepts/file-over-app-philosophy.md) · [wiki-linting](../concepts/wiki-linting.md)
- **Sources:** [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md) · [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)
