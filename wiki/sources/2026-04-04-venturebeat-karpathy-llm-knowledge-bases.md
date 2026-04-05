---
title: "Karpathy's LLM Knowledge Bases — VentureBeat writeup"
type: source
created: 2026-04-04
updated: 2026-04-05
sources: ["raw/karpathy-llm-wiki-idea.md"]
tags: [karpathy, llm-knowledge-bases, rag, markdown, obsidian, file-over-app, meta]
status: active
---

# Karpathy's LLM Knowledge Bases — VentureBeat writeup

> **VentureBeat feature covering [andrej-karpathy](../entities/andrej-karpathy.md)'s X post proposing "LLM Knowledge Bases" — having the LLM act as a full-time research librarian that actively compiles, lints, and interlinks Markdown files instead of the usual vector-DB + RAG pipeline.**

> **META NOTE:** This source describes the exact pattern this wiki itself implements. `CLAUDE.md` in this project is a direct operationalization of the Karpathy Pattern: `raw/` as immutable source, `wiki/` as compiled structured knowledge, LLM as the librarian. Consider this the reference document for the project's own methodology.

## Three-stage architecture

| Stage | Mechanism |
|---|---|
| **1. Ingest** | Raw materials (papers, repos, articles) dumped into `raw/`. Karpathy uses the **Obsidian Web Clipper** to convert web content to Markdown, keeping images local for vision |
| **2. Compile** | LLM reads raw and **writes** a structured wiki: summaries, concept articles, entity pages, backlinks. Not indexing — authoring |
| **3. Maintain (lint)** | Periodic health checks across the wiki for inconsistencies, gaps, new connections — see [wiki-linting](../concepts/wiki-linting.md). Charly Wargnier: *"a living AI knowledge base that actually heals itself"* |

Every claim is traceable back to a specific `.md` file — no vector-embedding black box. See [llm-knowledge-bases](../concepts/llm-knowledge-bases.md).

## The RAG contrast

| Feature | Vector DB / RAG | Karpathy's Markdown Wiki |
|---|---|---|
| Data format | Opaque vectors | Human-readable Markdown |
| Logic | Semantic similarity (nearest neighbor) | Explicit backlinks / indices |
| Auditability | Low (black box) | High (direct traceability) |
| Compounding | Static (requires re-indexing) | Active (self-healing via linting) |
| Ideal scale | Millions of documents | **100–10,000 high-signal documents** |

Framing: vector DB = massive warehouse with a fast forklift driver; Karpathy wiki = curated library with a head librarian constantly writing new books to explain the old ones. See [rag-vs-wiki-comparison](../concepts/rag-vs-wiki-comparison.md).

**Scale claim:** at ~100 articles / ~400k words, the LLM can navigate via summaries and index files well enough that "fancy RAG" introduces more latency and noise than it solves.

## File-over-app philosophy

Three technology choices (see [file-over-app-philosophy](../concepts/file-over-app-philosophy.md)):

- **Markdown (.md)** as source of truth — open, future-proof, readable anywhere.
- **[obsidian](../entities/obsidian.md)** as viewing layer — proprietary-but-local-first.
- **Vibe-coded tools** — custom scripts bridging LLM and filesystem.

The user owns the data. The LLM "visits" files to perform work rather than owning them in a database or SaaS tenant. Direct challenge to Notion, Google Docs, and SaaS-heavy models.

## Community extensions

| Extension | Author | Concept |
|---|---|---|
| **Contamination mitigation** — clean vault for user, messy vault for agents; promote distilled artifacts back | [steph-ango](../entities/steph-ango.md) (Obsidian co-creator) | [contamination-mitigation](../concepts/contamination-mitigation.md) |
| **Swarm knowledge bases** — 10+ agents writing to shared wiki, with a Hermes-based Quality Gate to prevent hallucination contagion | @jumperz / Secondmate | [swarm-knowledge-base](../concepts/swarm-knowledge-base.md) |
| **Ephemeral wikis** — spawn a temporary focused mini-knowledge-base + dynamic HTML/JS viz for a single task, then dissolve | Lex Fridman | [ephemeral-wiki](../concepts/ephemeral-wiki.md) |
| **Fine-tune from the wiki** — as the corpus grows and gets lint-purified, it becomes training data for a small custom model | Karpathy | — |

## Enterprise reactions

- **Vamshi Reddy:** *"Every business has a raw/ directory. Nobody's ever compiled it. That's the product."* Karpathy agreed — *"an incredible new product"* category.
- **Ole Lehmann:** whoever packages this for normal people (bookmarks, read-later, podcasts, saved threads) *"is sitting on something massive."*
- **Eugen Alpeza (CEO, Edra):** concedes the jump to enterprise (thousands of employees, contradictory tribal knowledge) is "brutal" — says his startup is building it.
- **Jason Paul Michaels (welder):** *"No vector database. No embeddings… Just markdown, FTS5, and grep… Every bug fix gets indexed. The knowledge compounds."*

## Why it matters

The wider bet: the industry has over-indexed on vector DBs for problems fundamentally about **structure**, not just similarity. For mid-sized, high-signal corpora — personal research, departmental wikis, a single team's institutional memory — the Karpathy pattern may be strictly better on auditability, compounding, and cost. At true enterprise scale (millions of records), still open.

Karpathy's summary: *"You rarely ever write or edit the wiki manually; it's the domain of the LLM."*

## Open questions

- At what scale does the pattern break? 10k articles? 100k?
- Is linting reliable enough to trust unsupervised? Failure modes of self-healing?
- Does the contamination-mitigation clean/messy split become mandatory for multi-agent setups?
- Can fine-tuning be reached with mid-sized wikis, or does it need orders of magnitude more?
- How does this interact with multi-user editing and merge conflicts? The source is silent.

## Prompts

> ingest /raw/ai-indian-films.md
> ingest karpathy-llm-wiki-idea
