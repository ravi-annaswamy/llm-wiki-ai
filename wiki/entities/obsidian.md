---
title: "Obsidian"
type: entity
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [product, markdown, note-taking, local-first, file-over-app]
status: active
---

# Obsidian

> **Proprietary-but-local-first Markdown note-taking app; the canonical viewer/editor for LLM Knowledge Bases.** Source of several conventions this wiki inherits — wikilinks, YAML frontmatter, flat folders.

## Why Karpathy picked it

- **Local-first.** Plain `.md` on the user's disk, not a vendor-hosted database. Data sovereignty is the default.
- **Open standard underneath.** The vault survives Obsidian itself — any text editor reads it. Matches [file-over-app-philosophy](../concepts/file-over-app-philosophy.md).
- **Free for personal use.** Commercial license only when needed, which aligns with Karpathy's developer audience.
- **Web Clipper.** Converts web articles into local `.md` files in `raw/`, keeping images local for vision-capable LLMs.

[steph-ango](steph-ango.md) (Kepano), co-creator of Obsidian, contributed the [contamination-mitigation](../concepts/contamination-mitigation.md) pattern — currently the most important practical refinement of running Karpathy's approach.

## Related

- **Hub concept:** [llm-knowledge-bases](../concepts/llm-knowledge-bases.md)
- **Adjacent:** [file-over-app-philosophy](../concepts/file-over-app-philosophy.md) · [contamination-mitigation](../concepts/contamination-mitigation.md)
- **People:** [andrej-karpathy](andrej-karpathy.md) · [steph-ango](steph-ango.md)
- **Source:** [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)
