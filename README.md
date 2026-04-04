# LLM Wiki

A personal knowledge base maintained by LLMs.

Inspired by [Andrej Karpathy's llm-wiki pattern](https://gist.github.com/karpathy/1dd0294ef9567971c1e4348a90d69285).

## Quick Start

1. Open this directory in Claude Code: `claude` (from this folder)
2. Drop a source document into `raw/`
3. Say: "ingest raw/my-document.md"
4. Browse the wiki in Obsidian or any markdown viewer

## Structure

- `CLAUDE.md` — Schema & conventions (Claude reads this automatically)
- `raw/` — Your source documents (immutable)
- `wiki/` — LLM-maintained knowledge base
- `tools/` — Optional helper scripts

## Commands

- **"ingest [source]"** — Process a new source into the wiki
- **"query: [question]"** — Ask a question against the wiki
- **"lint"** — Health-check the wiki
- **"refactor"** — Restructure and improve
- **"refactor schema"** — Improve the CLAUDE.md conventions
