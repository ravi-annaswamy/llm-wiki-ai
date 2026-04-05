---
title: "RAG vs. LLM-Maintained Wiki"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [rag, vector-db, architecture, tradeoffs, knowledge-management]
status: active
---

# RAG vs. LLM-Maintained Wiki

This page captures the explicit architectural comparison between the dominant **Retrieval-Augmented Generation (RAG)** pattern and the **[[concepts/llm-knowledge-bases]]** pattern proposed by [[entities/andrej-karpathy]] (Source: [[sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases]]).

## The short version

| Feature | Vector DB / RAG | Karpathy's Markdown Wiki |
|---|---|---|
| Data format | Opaque vectors (math) | Human-readable Markdown |
| Logic | Semantic similarity (nearest neighbor) | Explicit connections (backlinks, indices) |
| Auditability | Low (black box) | High (direct traceability) |
| Compounding | Static — requires re-indexing | Active — self-healing through linting |
| Ideal scale | Millions of documents | 100–10,000 high-signal documents |

## The mental model

From the VentureBeat writeup:

> The "Vector DB" approach is like a massive, unorganized warehouse with a very fast forklift driver. You can find anything, but you don't know why it's there or how it relates to the pallet next to it. Karpathy's "Markdown Wiki" is like a curated library with a head librarian who is constantly writing new books to explain the old ones.

## Where RAG wins

- **Scale.** Millions of documents, indexed for sub-second retrieval.
- **Semantic recall.** Finding passages that don't share keywords but share meaning.
- **Zero authoring cost at ingest.** Just chunk and embed.

## Where the Karpathy wiki wins

- **Auditability.** Every claim traces to a specific `.md` file a human can read, edit, or delete. Vector embeddings are a black box.
- **Compounding.** The wiki improves as sources are reconciled, contradictions surfaced, and connections drawn. RAG corpora are inert — more sources means more chunks, not more insight.
- **Structure over similarity.** For topics where *how things connect* matters more than *what's similar*, backlinks and explicit indices beat nearest-neighbor search.
- **Cost and latency for mid-sized corpora.** Karpathy argues that at ~100 articles / ~400k words, the "fancy RAG" infrastructure introduces more latency and retrieval noise than it solves.
- **Portability and vendor independence.** Markdown files survive any application or vendor. Vector stores are locked to a specific DB and embedding model.

## When to use which

The VentureBeat framing — and the honest answer — is that the two are not competitors at the extremes. RAG remains the right tool for true enterprise-scale corpora and for tasks that are fundamentally about similarity. The Karpathy pattern dominates for **mid-sized, high-signal** corpora where structure matters — personal research, single-team knowledge bases, project-specific context for coding agents.

There is also a hybrid case the source doesn't develop explicitly but is implied: **use the Karpathy wiki as the compiled, human-readable layer on top of a RAG store of raw materials.** The wiki is the distilled knowledge; the raw index is the long-tail fallback.

## Related

- [[concepts/llm-knowledge-bases]]
- [[concepts/file-over-app-philosophy]]
- [[entities/andrej-karpathy]]
