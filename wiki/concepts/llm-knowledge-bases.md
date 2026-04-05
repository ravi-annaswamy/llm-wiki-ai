---
title: "LLM Knowledge Bases (the Karpathy Pattern)"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [karpathy, methodology, knowledge-management, markdown, architecture]
status: active
---

# LLM Knowledge Bases (the Karpathy Pattern)

> **Treat an LLM as a full-time research librarian that actively compiles, lints, and interlinks a structured Markdown wiki from a pile of raw sources.** Originated by [andrej-karpathy](../entities/andrej-karpathy.md). An alternative to the vector-DB / RAG orthodoxy — see [rag-vs-wiki-comparison](rag-vs-wiki-comparison.md) for the head-to-head.

> ⚠️ **THIS WIKI IS AN IMPLEMENTATION OF THIS PATTERN.** `CLAUDE.md` in this project operationalizes the workflows below. Every page you're reading was produced by the compilation step.

## Architecture

| Stage | What happens |
|---|---|
| **1. Raw ingest** | Source materials (papers, articles, transcripts, screenshots) land in `raw/`, immutable. Karpathy uses Obsidian Web Clipper to keep images local for vision |
| **2. Compilation** | LLM *writes* structured wiki pages over the raw sources — source summaries, entities, concepts, explicit backlinks. Every claim traces to a specific source file |
| **3. Active maintenance ([wiki-linting](wiki-linting.md))** | Periodic passes find orphans, flag contradictions, detect stale pages, suggest new concepts that have emerged across multiple sources |

## Core principles

- **Files are the source of truth.** Markdown on local disk. Every fact auditable and human-editable. See [file-over-app-philosophy](file-over-app-philosophy.md).
- **The LLM writes, the human reviews.** Karpathy: *"You rarely ever write or edit the wiki manually; it's the domain of the LLM."* Human role shifts from author to editor-in-chief.
- **Structure beats similarity.** For mid-sized corpora (100–10,000 docs), explicit indices and backlinks outperform semantic similarity on retrieval, auditability, and compounding.
- **Compounding through linting.** The wiki improves as the LLM reconciles new sources against existing pages — not just as more raw files are added.

## Scale claim and limits

Karpathy's explicit scale: **~100 articles / ~400,000 words** is comfortably navigable via summaries + index files — no "fancy RAG" needed. Above that, the picture is less clear. Framed for:

- Personal research projects · Departmental wikis · Single-team institutional memory · Project-specific context for vibe coding

**Not** a drop-in replacement for enterprise search across millions of documents.

## Extensions emerging in the community

| Extension | Author | Contribution |
|---|---|---|
| [contamination-mitigation](contamination-mitigation.md) | [steph-ango](../entities/steph-ango.md) | Clean personal vault + separate messy agent vault; arguably mandatory for multi-agent |
| [swarm-knowledge-base](swarm-knowledge-base.md) | @jumperz / Secondmate | 10+ agents with Hermes Quality Gate validating drafts before promotion |
| [ephemeral-wiki](ephemeral-wiki.md) | Lex Fridman | Task-specific mini-KB that dissolves after use |
| Fine-tuning endpoint | Karpathy | Mature wiki is a high-quality training corpus; fine-tune a smaller model directly on it |

## Open questions

- At what corpus size does the pattern begin to degrade?
- Is unsupervised linting reliable, or does it need a human editor in the loop?
- How does it handle collaborative editing and merge conflicts across multiple humans + multiple agents?

## Related

- **Originator:** [andrej-karpathy](../entities/andrej-karpathy.md)
- **Typical viewer:** [obsidian](../entities/obsidian.md)
- **Architecture comparison:** [rag-vs-wiki-comparison](rag-vs-wiki-comparison.md)
- **Components:** [wiki-linting](wiki-linting.md) · [file-over-app-philosophy](file-over-app-philosophy.md)
- **Extensions:** [contamination-mitigation](contamination-mitigation.md) · [swarm-knowledge-base](swarm-knowledge-base.md) · [ephemeral-wiki](ephemeral-wiki.md)
- **Cross-domain parallel:** [agent-persistent-memory](agent-persistent-memory.md)
- **Source:** [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)
