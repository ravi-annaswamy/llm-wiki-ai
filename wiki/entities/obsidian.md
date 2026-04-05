---
title: "Obsidian"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [product, markdown, note-taking, local-first, file-over-app]
status: active
---

# Obsidian

Proprietary-but-local-first note-taking and file-organization app built on Markdown files. In the context of this wiki, Obsidian is the canonical viewer/editor layer for the [[concepts/llm-knowledge-bases]] pattern — and the source of several conventions this project has adopted (wikilinks `[[like-this]]`, YAML frontmatter, flat folder structures) (Source: [[sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases]]).

## Why Karpathy picked it

- **Local-first.** Files live on the user's disk as plain `.md`, not in a vendor-hosted database. Data sovereignty is the default.
- **Open standard underneath.** Because the files are plain Markdown, the knowledge base survives Obsidian itself — any text editor can read it. This matches the [[concepts/file-over-app-philosophy]] directly.
- **Free for personal use.** Obsidian's EULA allows free personal use and requires a license only for commercial use, which aligns with the developer-facing audience Karpathy is writing for.
- **Obsidian Web Clipper.** Karpathy uses this to convert web articles into Markdown files in his `raw/` directory, keeping images local so an LLM with vision can reference them.

## Voices from the team

[[entities/steph-ango]] (Kepano), co-creator of Obsidian, is the source of the [[concepts/contamination-mitigation]] pattern — keep the personal vault clean, let agents work in a separate "messy vault," and only promote useful artifacts back. This is currently the most important practical guidance for running the Karpathy pattern in practice.

## Related

- [[concepts/llm-knowledge-bases]]
- [[concepts/file-over-app-philosophy]]
- [[concepts/contamination-mitigation]]
- [[entities/andrej-karpathy]]
- [[entities/steph-ango]]
