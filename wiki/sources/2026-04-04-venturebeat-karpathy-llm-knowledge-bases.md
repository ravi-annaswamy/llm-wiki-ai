---
title: "Karpathy's LLM Knowledge Bases — VentureBeat writeup"
type: source
created: 2026-04-04
updated: 2026-04-04
sources: ["raw/karpathy-llm-wiki-idea.md"]
tags: [karpathy, llm-knowledge-bases, rag, markdown, obsidian, file-over-app, meta]
status: active
---

# Karpathy's LLM Knowledge Bases — VentureBeat writeup

**Original:** VentureBeat feature covering [andrej-karpathy](../entities/andrej-karpathy.md)'s X post describing an "LLM Knowledge Bases" approach to managing research and project context, plus community reactions and extensions.

> **Meta note:** This source describes the exact pattern that this wiki itself implements. `CLAUDE.md` in this project is a direct operationalization of the "Karpathy Pattern": raw/ directory as immutable source, wiki/ as compiled structured knowledge, LLM as the librarian maintaining it. Consider this source the reference document for the project's own methodology.

## The core idea

[andrej-karpathy](../entities/andrej-karpathy.md) — former Director of AI at Tesla, OpenAI co-founder, now running an independent AI project — posted on X describing a system he uses to solve the "stateless" AI development problem: losing project context at every session boundary or usage limit. Instead of the usual enterprise answer (vector DB + RAG pipeline), he proposes having the LLM itself act as a "full-time research librarian" — actively compiling, linting, and interlinking Markdown files. See [llm-knowledge-bases](../concepts/llm-knowledge-bases.md).

## Three-stage architecture

As visualized by community member @himanshu in response to Karpathy's post:

1. **Data ingest.** Raw materials (research papers, repos, datasets, web articles) dumped into a `raw/` directory. Karpathy uses the **Obsidian Web Clipper** to convert web content to Markdown, keeping images local so the LLM can reference them via vision.
2. **Compilation step.** The LLM reads raw data and *writes* a structured wiki: summaries, concept articles, entity pages, and backlinks between related ideas. Not indexing — authoring.
3. **Active maintenance (linting).** The LLM runs periodic health checks across the wiki for inconsistencies, missing data, and new connections. See [wiki-linting](../concepts/wiki-linting.md). Community member Charly Wargnier called it "a living AI knowledge base that actually heals itself."

Every claim is traceable back to a specific `.md` file — no vector-embedding black box. See [llm-knowledge-bases](../concepts/llm-knowledge-bases.md) and [rag-vs-wiki-comparison](../concepts/rag-vs-wiki-comparison.md).

## The RAG contrast

Karpathy's pattern rejects RAG's complexity for mid-sized datasets, arguing that modern LLMs can reason over structured text directly. The VentureBeat piece summarizes the tradeoff as a table:

| Feature | Vector DB / RAG | Karpathy's Markdown Wiki |
|---|---|---|
| Data format | Opaque vectors (math) | Human-readable Markdown |
| Logic | Semantic similarity (nearest neighbor) | Explicit connections (backlinks/indices) |
| Auditability | Low (black box) | High (direct traceability) |
| Compounding | Static (requires re-indexing) | Active (self-healing through linting) |
| Ideal scale | Millions of documents | 100–10,000 high-signal documents |

The framing: Vector DB is a massive unorganized warehouse with a fast forklift driver. The Karpathy wiki is a curated library with a head librarian constantly writing new books to explain the old ones. See [rag-vs-wiki-comparison](../concepts/rag-vs-wiki-comparison.md).

## Scale claim

Karpathy says that at ~100 articles and ~400,000 words, the LLM can navigate via summaries and index files well enough that "fancy RAG" introduces more latency and retrieval noise than it solves. The claim is explicitly about personal research and departmental scale, not millions of documents.

## File-over-app philosophy

The methodology rests on three technology choices (see [file-over-app-philosophy](../concepts/file-over-app-philosophy.md)):

- **Markdown (.md)** as the source of truth — an open standard, future-proof, readable by any text editor.
- **[obsidian](../entities/obsidian.md)** as the viewing/editing layer — proprietary-but-local-first, with an EULA that allows free personal use.
- **Vibe-coded tools** — custom (likely Python) scripts bridging the LLM and the local file system.

The user owns the data. The LLM "visits" the files to perform work rather than owning them in a database or SaaS tenant. This is a direct challenge to Notion, Google Docs, and other SaaS-heavy models.

## Community extensions

### Contamination mitigation ([steph-ango](../entities/steph-ango.md))

Steph Ango (@Kepano), co-creator of [obsidian](../entities/obsidian.md), suggested keeping the user's personal "vault" clean and letting agents play in a separate "messy vault," only promoting distilled artifacts back to the personal one once the agent workflow has produced something useful. See [contamination-mitigation](../concepts/contamination-mitigation.md). This is arguably the most important practical insight for anyone actually running the pattern.

### Swarm knowledge bases (@jumperz, Secondmate)

A multi-agent extension: 10+ agents producing raw outputs into a shared wiki, managed via OpenClaw. Central challenge: one agent's hallucination can "infect" the collective memory. Solution proposed: a **Quality Gate** using the Hermes model (from Nous Research, trained for structured evaluation) as an independent supervisor that scores and validates every draft article before promotion to the "live" wiki. The full loop: agents dump raw → compiler organizes → Hermes validates → verified briefings fed back at session start, so the swarm never "wakes up blank." See [swarm-knowledge-base](../concepts/swarm-knowledge-base.md).

### Ephemeral wikis (Lex Fridman)

Lex Fridman described a variant where he has the system generate "a temporary focused mini-knowledge-base" for a specific task, plus dynamic HTML/JS visualizations he can tinker with. The ephemeral wiki dissolves once the report is written — closer to "spawn a team of agents to build a custom research environment" than a persistent second brain. See [ephemeral-wiki](../concepts/ephemeral-wiki.md).

### Fine-tuning from the wiki

Karpathy flagged the ultimate destination: as the wiki grows and becomes more "pure" through continuous LLM linting, it becomes training data. Fine-tune a smaller model on the wiki itself and it "knows" the researcher's knowledge base in its weights — a custom, private intelligence. The wiki is both short-term context substrate and long-term training-data factory.

## Community and enterprise reactions

Enterprise framing came from multiple X voices:

- Vamshi Reddy (@tammireddy): "Every business has a raw/ directory. Nobody's ever compiled it. That's the product." Karpathy agreed this represents "an incredible new product" category.
- Ole Lehmann: Whoever packages this for normal people — syncing with bookmarks, read-later apps, podcasts, saved threads — "is sitting on something massive."
- Eugen Alpeza (CEO, Edra): Acknowledged the jump from personal research wiki to enterprise operations is "brutal" — thousands of employees, millions of records, contradictory tribal knowledge across teams. Says his startup is building exactly this.
- Jason Paul Michaels (@SpaceWelder314), a welder using Claude: "No vector database. No embeddings… Just markdown, FTS5, and grep… Every bug fix gets indexed. The knowledge compounds." — an illustration that the pattern generalizes beyond researchers.

## Why it matters

The wider bet: the industry has over-indexed on vector DBs for problems that are fundamentally about **structure**, not just **similarity**. For mid-sized, high-signal corpora — personal research, departmental wikis, a single team's institutional memory — the Karpathy pattern may be strictly better on auditability, compounding, and cost. At true enterprise scale (millions of records), it's still an open question.

Karpathy's own summary, quoted by VentureBeat: "You rarely ever write or edit the wiki manually; it's the domain of the LLM."

## Open questions

- At what scale does the Karpathy pattern break? Karpathy claims 100 articles / 400k words is fine — but how does it degrade as the corpus grows to 10k or 100k articles?
- Is the linting step reliable enough to trust unsupervised? What are the failure modes of self-healing wikis?
- Does the [contamination-mitigation](../concepts/contamination-mitigation.md) "clean vault vs. messy vault" pattern become mandatory for multi-agent setups, or is it specific to certain workflows?
- Can the fine-tuning endpoint be reached with mid-sized wikis (100–1,000 articles), or does it require something much larger?
- How does this pattern interact with multi-user editing and merge conflicts? The source is silent on collaboration.

## Prompts (user input for this ingest)

> ingest /raw/ai-indian-films.md
> ingest karpathy-llm-wiki-idea

(Noted per user's global instruction to include prompts in reports for context.)
