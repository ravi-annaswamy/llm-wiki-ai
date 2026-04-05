---
title: "RAG vs. LLM-Maintained Wiki"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [rag, vector-db, architecture, tradeoffs, knowledge-management]
status: active
---

# RAG vs. LLM-Maintained Wiki

> **The architectural comparison between the dominant Retrieval-Augmented Generation (RAG) pattern and the [llm-knowledge-bases](llm-knowledge-bases.md) pattern proposed by [andrej-karpathy](../entities/andrej-karpathy.md).** Not competitors at the extremes — complementary for different scales and different needs.

## The short version

| Feature | Vector DB / RAG | Karpathy's Markdown Wiki |
|---|---|---|
| Data format | Opaque vectors (math) | Human-readable Markdown |
| Logic | Semantic similarity (nearest neighbor) | Explicit connections (backlinks, indices) |
| Auditability | Low (black box) | High (direct traceability) |
| Compounding | Static — requires re-indexing | Active — self-healing via linting |
| Ideal scale | Millions of documents | 100–10,000 high-signal documents |

The VentureBeat analogy:

> The "Vector DB" approach is like a massive, unorganized warehouse with a very fast forklift driver. You can find anything, but you don't know why it's there or how it relates to the pallet next to it. Karpathy's "Markdown Wiki" is like a curated library with a head librarian who is constantly writing new books to explain the old ones.

## Where each wins

| Dimension | RAG wins | Wiki wins |
|---|---|---|
| Scale | Millions of docs, sub-second retrieval | 100-word~400k-word mid corpora |
| Semantic recall | Finds meaning-matched passages without shared keywords | — |
| Authoring cost | Zero — just chunk and embed | Requires compilation + linting |
| Auditability | — | Every claim traces to a `.md` file |
| Compounding | — | Improves as sources are reconciled and contradictions surfaced |
| Structure-over-similarity | — | Backlinks beat nearest-neighbor when *how things connect* matters more than *what's similar* |
| Portability | — | Markdown survives any app/vendor; vector stores lock to a DB+embedding model |

## When to use which

RAG remains the right tool for true enterprise-scale corpora and tasks that are fundamentally about similarity. The Karpathy pattern dominates for **mid-sized, high-signal** corpora where structure matters — personal research, single-team knowledge bases, coding-agent project context.

**Hybrid.** The source implies but doesn't develop: use the Karpathy wiki as the *compiled, human-readable layer* on top of a RAG store of raw materials. Wiki = distilled knowledge; raw index = long-tail fallback.

## Related

- **Hub:** [llm-knowledge-bases](llm-knowledge-bases.md)
- **Adjacent:** [file-over-app-philosophy](file-over-app-philosophy.md)
- **Author:** [andrej-karpathy](../entities/andrej-karpathy.md)
- **Source:** [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)
