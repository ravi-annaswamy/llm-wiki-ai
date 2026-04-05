# llm-wiki-ai

A personal knowledge base maintained autonomously by Claude, implementing [Andrej Karpathy's "LLM Knowledge Bases"](https://gist.github.com/karpathy/1dd0294ef9567971c1e4348a90d69285) pattern end-to-end.

This repository is both the **subject** (a research workspace on enterprise AI, agentic work, generative models, and creative AI) and the **method** (a live example of how one person plus one LLM can maintain a structured, cross-linked Markdown wiki without manual page-writing). Everything under `wiki/` is authored and maintained by Claude, following the schema and workflows in [`CLAUDE.md`](CLAUDE.md).

## Current state

As of the initial public release:

- **7 sources ingested** — Anthropic/Coefficient Bio acquisition (enterprise AI + life sciences), Reuters on AI in Indian film, VentureBeat on Karpathy's LLM Knowledge Bases pattern, MarkTechPost on DeepMind's AlphaEvolve in game theory, the New Yorker's "Is It Wrong to Write a Book with AI?", Anthropic on long-running Claude for scientific computing, and Yang Song's foundational tutorial on score-based generative models.
- **67 wiki pages** — 27 entity pages, 31 concept pages, 7 source summaries, 2 cross-cutting analyses.
- **A lived-in schema.** `CLAUDE.md` has been iterated several times based on actual ingest experience — it now includes an "analysis-page graduation" rule, a "failed approaches" line in the log format, and domain-specific ingest-time lenses for agentic-work sources.

## Entry points

- [`wiki/overview.md`](wiki/overview.md) — high-level synthesis and cross-cutting themes. **Start here.**
- [`wiki/index.md`](wiki/index.md) — full catalog of sources, entities, concepts, and analyses.
- [`wiki/log.md`](wiki/log.md) — append-only activity log documenting every ingest, lint, and refactor pass. Good reading if you want to see the methodology in motion.
- [`CLAUDE.md`](CLAUDE.md) — the operating manual Claude follows: page conventions, INGEST/QUERY/LINT/REFACTOR workflows, and domain configuration.
- [`wiki/analyses/own-your-substrate.md`](wiki/analyses/own-your-substrate.md) and [`wiki/analyses/producer-filter-pattern.md`](wiki/analyses/producer-filter-pattern.md) — the two cross-cutting themes that have graduated from concept pages into standalone analyses.

## Quick start (to use the pattern yourself)

1. Clone this repo and open the directory in [Claude Code](https://docs.anthropic.com/claude/docs/claude-code): `claude` from this folder.
2. Drop a source document into `raw/` (a Markdown file, PDF, article clipping, etc.).
3. Say: **"ingest raw/my-document.md"**.
4. Claude will read the source, create a summary page, update affected entities and concepts, weave in cross-references, update `index.md` and `overview.md`, and log what happened.
5. Browse the wiki in Obsidian, any Markdown viewer, or the GitHub web UI.

Other slash-style commands Claude understands (defined in `CLAUDE.md`):

- **"query: [question]"** — Answer a question using the compiled wiki, not the raw sources.
- **"lint"** — Health-check: orphans, broken links, stale pages, coverage gaps.
- **"refactor"** — Restructure, merge, split, and promote cross-cutting themes into analysis pages.
- **"refactor schema"** — Improve the `CLAUDE.md` conventions themselves.

## Folder layout

```
.
├── CLAUDE.md           # Wiki schema and conventions (the operating manual)
├── README.md           # This file
├── project_log.md      # Top-level per-session narrative
├── raw/                # Your source documents (not in public repo; immutable when present)
└── wiki/
    ├── index.md        # Content catalog
    ├── log.md          # Activity log
    ├── overview.md     # High-level synthesis
    ├── sources/        # One summary page per ingested source
    ├── entities/       # People, organizations, products, projects
    ├── concepts/       # Ideas, techniques, frameworks
    └── analyses/       # Cross-cutting patterns and deep-dives
```

Raw third-party source material is excluded from this public repository for copyright reasons. Each page in `wiki/sources/` links out to the original URL, so readers who want the primary text can go read it directly.

## What makes this different from "just ask an LLM to summarize things"

- **File-over-app.** All knowledge lives as plain Markdown with YAML frontmatter. No app lock-in, no vector database, no proprietary format. Open the wiki in any editor, ship it as a folder, diff it in git.
- **Structure over similarity.** Cross-references are explicit `[[wikilinks]]`, not implicit embedding-space neighbors. Every page has at least two inbound links. Every source is traceable to the pages it informed.
- **Self-healing.** The lint workflow periodically checks for orphans, broken links, stale pages, and concepts mentioned on 3+ pages without their own entry. Findings are reported as a checklist; the user approves fixes.
- **Analysis-page graduation.** When a cross-cutting theme shows up cleanly in 3+ sources, it gets promoted from a paragraph in `overview.md` to its own page in `analyses/`. The threshold is deliberately low — belated promotion is more expensive than premature promotion.
- **Failed approaches logged.** When a refactor tries a restructuring and then abandons it, the reason is recorded in the log entry — so future sessions don't re-attempt the same dead ends. This is the `CHANGELOG.md` pattern from long-running agentic coding, applied to the wiki's own maintenance.

## Related

- Andrej Karpathy's original articulation of the pattern — the VentureBeat writeup is summarized at [`wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md`](wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md), and the concept page lives at [`wiki/concepts/llm-knowledge-bases.md`](wiki/concepts/llm-knowledge-bases.md).
- Steph Ango's [file over app](https://stephango.com/file-over-app) essay — see [`wiki/concepts/file-over-app-philosophy.md`](wiki/concepts/file-over-app-philosophy.md).
- Comparison to vector-DB retrieval: [`wiki/concepts/rag-vs-wiki-comparison.md`](wiki/concepts/rag-vs-wiki-comparison.md).

## License and attribution

The wiki content (everything under `wiki/`) is original synthesis authored by Claude under the direction of the repository owner, released for non-commercial reading, reference, and adaptation. The `CLAUDE.md` schema is free to copy and adapt for your own LLM-maintained wiki — that is one of its explicit design goals.

Claims in wiki pages are attributed to their sources. Verify against the primary sources before citing in other contexts.
