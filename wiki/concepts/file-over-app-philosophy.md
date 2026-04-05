---
title: "File-Over-App Philosophy"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [obsidian, markdown, data-sovereignty, saas, local-first]
status: active
---

# File-Over-App Philosophy

The idea, popularized by [[entities/steph-ango]] (co-creator of [[entities/obsidian]]), that knowledge should be stored in open, portable files that outlive any specific application — rather than inside a proprietary SaaS database where the vendor owns the substrate (Source: [[sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases]]).

In the Karpathy pattern, this philosophy is load-bearing, not decorative.

## The three choices that make the pattern work

- **Markdown (.md)** as the source of truth. An open standard. Readable by any text editor. Future-proof: if a given note-taking app disappears, the files remain.
- **[[entities/obsidian]]** (or equivalent) as the viewing/editing layer. Local-first. The app "visits" the files rather than owning them. You can switch apps without migrating your data.
- **"Vibe-coded" scripts** — custom, likely Python-based tools that bridge the LLM and the local file system. Not a platform. Not a SaaS tenant. Just scripts the user can read and modify.

## Why it matters for LLM knowledge bases

The [[concepts/llm-knowledge-bases]] pattern collapses if the data lives in a SaaS silo, because:

1. **The LLM can't freely read and write the corpus.** SaaS APIs are rate-limited, opaque, and frequently lag behind what local file access makes trivial.
2. **Auditability requires human-readable files.** When every claim in the compiled wiki traces back to a specific source file, users need to be able to open and read that file with any tool they have.
3. **Portability is the insurance policy.** If a user invests months of LLM compute into building a wiki, they need certainty that the output will survive the vendor going out of business, changing pricing, or changing terms.
4. **Data sovereignty.** Research, code context, and internal knowledge are often sensitive. Local files by default means the user's choices — not the SaaS provider's — determine what leaves the disk.

## The direct challenge to SaaS

The VentureBeat writeup frames the Karpathy pattern as an explicit challenge to Notion, Google Docs, and similar SaaS-heavy knowledge stores. In the Karpathy model:

- The user owns the data (on disk).
- The LLM is "merely a highly sophisticated editor that visits the files to perform work."
- Any app — Obsidian, VS Code, a plain text editor — can read the same corpus.

SaaS knowledge platforms are, in this framing, optimizing the wrong layer. They optimize the *editor experience* at the cost of data sovereignty and LLM accessibility.

## Related

- [[concepts/llm-knowledge-bases]]
- [[entities/obsidian]]
- [[entities/steph-ango]]
- [[concepts/contamination-mitigation]]
