---
title: "LLM Knowledge Bases (the Karpathy Pattern)"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [karpathy, methodology, knowledge-management, markdown, architecture]
status: active
---

# LLM Knowledge Bases (the Karpathy Pattern)

The "LLM Knowledge Bases" pattern, originated by [andrej-karpathy](../entities/andrej-karpathy.md), treats an LLM as a full-time research librarian that actively compiles, lints, and interlinks a structured Markdown wiki from a pile of raw sources. It is an alternative to the vector-DB / RAG orthodoxy that has dominated enterprise AI knowledge management — see [rag-vs-wiki-comparison](rag-vs-wiki-comparison.md) for the head-to-head (Source: [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)).

> **This wiki is an implementation of this pattern.** `CLAUDE.md` in this project operationalizes the workflows described below. Every page you're reading was produced by the compilation step.

## Architecture

Three stages, in the order work flows:

1. **Raw ingest.** Source materials — papers, articles, transcripts, repos, screenshots — land in a `raw/` directory. They are immutable. Karpathy uses the Obsidian Web Clipper to convert web articles into Markdown, keeping referenced images local so the LLM can use its vision capabilities on them.
2. **Compilation.** This is the core innovation: the LLM *writes* structured wiki pages on top of the raw sources. Not chunk-and-embed. Not similarity search. The LLM reads raw materials and authors source summaries, entity pages, concept pages, and — critically — explicit `[[backlinks]]` between them. Every claim in a wiki page traces back to a specific source file.
3. **Active maintenance (linting).** The wiki is not static. The LLM periodically runs [wiki-linting](wiki-linting.md) passes: finding orphan pages, flagging contradictions, identifying missing cross-references, detecting stale pages whose sources have been superseded, and suggesting new concepts that have emerged across multiple sources but don't yet have their own page.

## Core principles

- **Files are the source of truth.** Markdown, on the local disk. No opaque vector embeddings. Every fact is auditable and human-editable. See [file-over-app-philosophy](file-over-app-philosophy.md).
- **The LLM writes, the human reviews.** Karpathy's line: "You rarely ever write or edit the wiki manually; it's the domain of the LLM." The human role shifts from author to editor-in-chief.
- **Structure beats similarity.** For mid-sized corpora (100–10,000 documents), explicit structure — indices, backlinks, categorized folders — outperforms semantic similarity on retrieval, auditability, and compounding.
- **Compounding through linting.** The wiki improves over time as the LLM reconciles new sources against existing pages, not just as more raw files are added.

## Scale claim and limits

Karpathy's explicit scale claim: ~100 articles and ~400,000 words is comfortably navigable by an LLM using summaries and index files — no "fancy RAG" needed. Above that, the picture is less clear. The pattern is framed for:

- Personal research projects
- Departmental wikis
- Single-team institutional memory
- Project-specific context for vibe coding sessions

It is **not** framed as a drop-in replacement for enterprise search across millions of documents. See [rag-vs-wiki-comparison](rag-vs-wiki-comparison.md) for the scale tradeoff in detail.

## Extensions emerging in the community

- **[contamination-mitigation](contamination-mitigation.md)** ([steph-ango](../entities/steph-ango.md)) — keep a clean personal vault and a separate messy agent vault, promote only distilled artifacts. Arguably mandatory for multi-agent setups.
- **[swarm-knowledge-base](swarm-knowledge-base.md)** (@jumperz / Secondmate) — scales the pattern to 10+ agents with a Hermes-powered Quality Gate that validates draft articles before they are promoted to the live wiki.
- **[ephemeral-wiki](ephemeral-wiki.md)** (Lex Fridman) — generate a temporary, task-specific mini-knowledge-base that dissolves once the task is done, rather than maintaining a persistent second brain.
- **Fine-tuning endpoint.** As the wiki matures, it becomes a high-quality training corpus. Karpathy flagged this: fine-tune a smaller model directly on the wiki and it "knows" the researcher's domain in its weights.

## Why it challenges SaaS

The Karpathy pattern is a direct challenge to Notion, Google Docs, and other SaaS-heavy knowledge stores. The data is owned by the user, sits on the local disk, and survives any specific application. The LLM "visits" the files as an agent, not a tenant. This alignment with the [file-over-app-philosophy](file-over-app-philosophy.md) is as much the point as the technical architecture.

## Open questions

- At what corpus size does the pattern begin to degrade?
- Is unsupervised linting reliable, or does it need a human editor in the loop to avoid drift?
- How does the pattern handle collaborative editing and merge conflicts across multiple humans + multiple agents?
- Does the fine-tuning endpoint require a corpus larger than personal-research scale to be useful?
- Is there a point where the LLM can bootstrap its own schema improvements (meta-linting)?

## Related

- [andrej-karpathy](../entities/andrej-karpathy.md) — originator
- [obsidian](../entities/obsidian.md) — typical viewing layer
- [rag-vs-wiki-comparison](rag-vs-wiki-comparison.md)
- [wiki-linting](wiki-linting.md)
- [file-over-app-philosophy](file-over-app-philosophy.md)
- [contamination-mitigation](contamination-mitigation.md)
- [swarm-knowledge-base](swarm-knowledge-base.md)
- [ephemeral-wiki](ephemeral-wiki.md)
