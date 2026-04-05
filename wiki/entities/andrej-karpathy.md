---
title: "Andrej Karpathy"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [person, ai-researcher, openai, tesla, karpathy-pattern]
status: active
---

# Andrej Karpathy

Former Director of AI at Tesla, co-founder of OpenAI, and coiner of the term "vibe coding." As of this source, he is running his own independent AI project (Source: [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)).

## Relevance to this wiki

Karpathy is the originator of the [llm-knowledge-bases](../concepts/llm-knowledge-bases.md) pattern — the approach that this wiki itself implements. His X post described a system in which the LLM acts as a full-time "research librarian," compiling raw sources into a structured Markdown wiki with backlinks, linting, and self-healing. He framed the LLM's role memorably:

> You rarely ever write or edit the wiki manually; it's the domain of the LLM.

Karpathy explicitly rejects the vector-DB / RAG orthodoxy for mid-sized corpora, arguing that modern LLMs can reason over structured text directly. He claims a personal research scale of ~100 articles and ~400,000 words is comfortably manageable without "fancy RAG" infrastructure. See [rag-vs-wiki-comparison](../concepts/rag-vs-wiki-comparison.md).

He also gestured at the endpoint: as the wiki grows and becomes "purer" through continuous linting, it becomes a training set — and the researcher can eventually fine-tune a smaller model directly on it.

## Other terms he's coined or popularized

- **Vibe coding** — his earlier coinage, referenced in the VentureBeat writeup.
- **LLM Knowledge Bases** — the concept ingested here.

## Related

- [llm-knowledge-bases](../concepts/llm-knowledge-bases.md)
- [file-over-app-philosophy](../concepts/file-over-app-philosophy.md)
- [wiki-linting](../concepts/wiki-linting.md)
