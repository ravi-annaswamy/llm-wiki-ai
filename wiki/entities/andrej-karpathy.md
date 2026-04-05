---
title: "Andrej Karpathy"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources:
  - "wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"
  - "wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"
tags: [person, ai-researcher, openai, tesla, karpathy-pattern, autoresearch, agentic-engineering]
status: active
---

# Andrej Karpathy

Former Director of AI at Tesla, co-founder of OpenAI, coiner of "vibe coding" and "agentic engineering," and the author of [autoresearch](autoresearch.md) (released 2026-03-07). Across the wiki's sources he is running his own independent AI project and producing a recognizable methodological arc: humans setting direction, LLMs doing sustained production work inside mechanical filter loops.

## The methodological arc

Karpathy's work across 2024–2026 traces a progression in the human-AI division of labor:

1. **[Vibe coding](agentic-engineering.md)** (his earlier coinage) — human prompts, AI writes code, human reviews each diff.
2. **Agentic engineering** (coined February 2026) — *"You are not writing the code directly 99% of the time. You are orchestrating agents who do and acting as oversight."* See [agentic-engineering](../concepts/agentic-engineering.md).
3. **Independent research** — the human describes what good research looks like in a Markdown file and walks away. [autoresearch](autoresearch.md) is the concrete instance.

His follow-up framing (posted after AutoResearch launched): *"The goal is not to emulate a single PhD student, it's to emulate a research community of them"* — with a gesture toward SETI@home-style distributed agent collaboration.

## LLM Knowledge Bases

Karpathy is also the originator of the [llm-knowledge-bases](../concepts/llm-knowledge-bases.md) pattern — the approach that this wiki itself implements (Source: [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)). His X post described a system in which the LLM acts as a full-time "research librarian," compiling raw sources into a structured Markdown wiki with backlinks, linting, and self-healing. He framed the LLM's role memorably:

> You rarely ever write or edit the wiki manually; it's the domain of the LLM.

Karpathy explicitly rejects the vector-DB / RAG orthodoxy for mid-sized corpora, arguing that modern LLMs can reason over structured text directly. He claims a personal research scale of ~100 articles and ~400,000 words is comfortably manageable without "fancy RAG" infrastructure. See [rag-vs-wiki-comparison](../concepts/rag-vs-wiki-comparison.md).

## AutoResearch

Karpathy's March 2026 release (Source: [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)) is an open-source Python project that lets an LLM coding agent run ML experiments overnight on a single GPU, keeping only changes that improve `val_bpb`. Three files: an immutable `prepare.py` (evaluator), an agent-owned `train.py` (sandbox), and a human-authored `program.md` (directives). See [autoresearch](autoresearch.md) for the full architecture, [ratchet-loop](../concepts/ratchet-loop.md) for the filter pattern, and [llm-research-creativity-ceiling](../concepts/llm-research-creativity-ceiling.md) for Karpathy's own acknowledged limits.

Karpathy runs a "bigger cousin" of AutoResearch on 8×H100 GPUs against his production `nanochat` framework — evidence that the pattern scales beyond toy experiments.

## Observation across the two sources

The two Karpathy pieces the wiki holds are two expressions of the same bet: **human sets direction through Markdown, LLM produces durable artifacts, a mechanical filter decides what survives.** In the knowledge-base case the artifacts are wiki pages and the filter is a lint pass. In the AutoResearch case the artifacts are git commits to `train.py` and the filter is `val_bpb`. Both are instances of the [producer-filter-pattern](../analyses/producer-filter-pattern.md). Taken together they stake out Karpathy's position: the compounding work of an AI-enabled researcher lives in the **artifact repository plus filter**, not in the model weights or the chat UI.

## Terms he's coined or popularized

- **Vibe coding** — earlier coinage.
- **Agentic engineering** — February 2026; the middle stage of the progression.
- **LLM Knowledge Bases** — the wiki methodology.
- **AutoResearch** — the project name, now also a shorthand for the three-file ratchet architecture.

## Related

- [autoresearch](autoresearch.md)
- [llm-knowledge-bases](../concepts/llm-knowledge-bases.md)
- [agentic-engineering](../concepts/agentic-engineering.md)
- [ratchet-loop](../concepts/ratchet-loop.md)
- [llm-research-creativity-ceiling](../concepts/llm-research-creativity-ceiling.md)
- [file-over-app-philosophy](../concepts/file-over-app-philosophy.md)
- [wiki-linting](../concepts/wiki-linting.md)
- [producer-filter-pattern](../analyses/producer-filter-pattern.md)
