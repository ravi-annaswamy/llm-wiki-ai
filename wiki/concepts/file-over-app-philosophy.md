---
title: "File-Over-App Philosophy"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [obsidian, markdown, data-sovereignty, saas, local-first]
status: active
---

# File-Over-App Philosophy

> **Knowledge should live in open, portable files that outlive any specific application — not in a proprietary SaaS database where the vendor owns the substrate.** Popularized by [steph-ango](../entities/steph-ango.md) (Obsidian co-creator). In the Karpathy pattern, this philosophy is load-bearing, not decorative.

## The three choices that make the pattern work

| Layer | Choice | Why |
|---|---|---|
| Source of truth | Markdown `.md` | Open standard, readable by any editor, future-proof |
| Editor | [obsidian](../entities/obsidian.md) or equivalent | Local-first; app *visits* files rather than owning them; switch apps without migration |
| Glue | "Vibe-coded" Python scripts | Not a platform. Not a SaaS tenant. User-readable, user-modifiable |

## Why it matters for LLM knowledge bases

The [llm-knowledge-bases](llm-knowledge-bases.md) pattern collapses if data lives in a SaaS silo:

1. **LLM can't freely read/write.** SaaS APIs are rate-limited, opaque, and lag local file access.
2. **Auditability.** Every compiled claim should trace back to a source file the user can open in any tool.
3. **Portability is the insurance policy.** Months of LLM compute must survive vendor failure, pricing changes, or terms changes.
4. **Data sovereignty.** Research and internal knowledge are sensitive — local files by default means the user controls what leaves disk.

## The challenge to SaaS

The VentureBeat writeup frames the Karpathy pattern as an explicit challenge to Notion, Google Docs, and similar SaaS knowledge stores. In this model the user owns the data, the LLM is *"merely a highly sophisticated editor that visits the files"*, and any app can read the same corpus. **SaaS platforms optimize the editor experience at the cost of data sovereignty and LLM accessibility** — the wrong layer.

## Related

- **Hub:** [llm-knowledge-bases](llm-knowledge-bases.md)
- **Canonical implementation:** [obsidian](../entities/obsidian.md) · [steph-ango](../entities/steph-ango.md)
- **Adjacent:** [contamination-mitigation](contamination-mitigation.md)
- **Source:** [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)
