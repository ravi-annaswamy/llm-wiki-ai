# LLM Wiki — Schema & Conventions

> This file defines how Claude maintains this wiki. It is the operating manual.
> Co-evolve this document over time as you discover what works for your domain.

## Project Structure

```
.
├── CLAUDE.md          # This file — wiki schema & conventions
├── raw/               # Immutable source documents (never modify)
│   └── assets/        # Downloaded images, PDFs, data files
├── wiki/              # LLM-maintained knowledge base
│   ├── index.md       # Content catalog (always keep updated)
│   ├── log.md         # Chronological activity log (append-only)
│   ├── overview.md    # High-level synthesis of everything
│   ├── sources/       # One summary page per ingested source
│   ├── entities/      # Pages for people, orgs, products, projects
│   ├── concepts/      # Pages for ideas, techniques, frameworks
│   └── analyses/      # Comparisons, deep-dives, filed query results
└── tools/             # Optional helper scripts
```

## Page Conventions

### Frontmatter

Every wiki page starts with YAML frontmatter:

```yaml
---
title: "Page Title"
type: source | entity | concept | analysis | overview
created: 2026-04-04
updated: 2026-04-04
sources: ["raw/article-name.md"]  # which raw sources inform this page
tags: [tag1, tag2]
status: draft | active | stale
---
```

### Cross-Linking

- Use `[[wikilinks]]` for internal links between wiki pages
- Use `[[folder/page-name]]` when linking across subdirectories
- Every page should have at least 2 inbound links (no orphans)
- When creating a new page, always check what existing pages should link to it

### Page Naming

- Use lowercase kebab-case: `reinforcement-learning.md`, `openai.md`
- Source summaries: `sources/YYYY-MM-DD-short-title.md`
- Be specific: `transformer-attention` not `attention`

### Writing Style

- Write in clear, direct prose — not bullet-point dumps
- Lead with the most important information
- Include specific claims with source attribution: `(Source: [[sources/2026-04-02-karpathy-post]])`
- Flag uncertainty: "According to X, though Y disputes this..."
- Flag contradictions explicitly: "> ⚠️ CONTRADICTION: Page A claims X, but Source B says Y"

### Concept & Entity Granularity

**When to create a page:**
- Create a **concept page** when a topic is discussed substantively (3+ paragraphs or a key argument built on it) in a single source, OR when it appears across 2+ sources.
- Create an **entity page** when a person, organization, product, or project is mentioned with enough context to say something meaningful (not just a passing name-drop).
- Prefer **specific** concepts over broad ones: "retrieval-augmented generation" over "AI techniques", "flood-fill transformation" over "image processing". A broad page can exist as a hub that links to specific sub-pages.

**When NOT to create a page:**
- A concept is mentioned in passing with no elaboration — just add a mention on the source summary page.
- An entity is referenced only as background context (e.g., "Google" in a sentence about search). Only create entity pages for things that are substantively discussed.

**Splitting and merging:**
- If a concept page grows beyond ~300 lines, consider splitting into sub-concepts with a hub page.
- If two concept pages overlap significantly, merge them and redirect the old name.
- During lint, flag concepts that are mentioned on 3+ pages but lack their own page.

### Expected Yield by Source Type

Use these as rough calibration — not hard limits:

| Source type | Concepts | Entities | Total pages touched |
|---|---|---|---|
| News article (1-2k words) | 3–8 | 2–5 | 5–12 |
| Blog post / essay (2-4k words) | 5–12 | 3–7 | 8–18 |
| Research paper (5k+ words) | 10–20 | 5–10 | 15–30 |
| Book chapter | 8–15 | 5–12 | 12–25 |
| Transcript / interview | 5–10 | 3–8 | 8–15 |

If you're consistently above or below these ranges, adjust — the wiki should match the density of your domain.

---

## Workflows

### 1. INGEST — Adding a new source

When I say "ingest [source]" or drop a file into `raw/`:

**For standard sources (< 3,000 words) — single pass:**

1. **Read** the source completely
2. **Discuss** key takeaways with me (2-3 sentences, ask if I want to emphasize anything)
3. **Create** a source summary page in `wiki/sources/`
4. **Update** `wiki/index.md` — add the new source entry
5. **Update** related entity and concept pages across the wiki
   - If an entity/concept page doesn't exist yet, create it
   - If it exists, integrate the new information (don't just append — weave it in)
6. **Update** `wiki/overview.md` if the source changes the big picture
7. **Log** the ingest in `wiki/log.md`
8. **Report** what you changed: list every file touched with a one-line summary

**For dense sources (> 3,000 words or 10+ concepts detected) — two-pass ingest:**

*Pass 1 — Core extraction:*
1. Read the source completely
2. Discuss key takeaways with me
3. Create the source summary page
4. Create/update the **primary** concept and entity pages (the 3-5 most important ones)
5. Update `wiki/index.md`
6. Pause and report what was created

*Pass 2 — Cross-referencing:*
1. Re-read the source summary (not the raw source — work from compiled knowledge)
2. Create/update **secondary** concept and entity pages
3. Add cross-references between all affected pages (new and existing)
4. Update `wiki/overview.md`
5. Log the full ingest in `wiki/log.md`
6. Final report of all files touched

### 2. QUERY — Answering questions

When I ask a question:

1. **Read** `wiki/index.md` to find relevant pages
2. **Read** the relevant wiki pages (not raw sources — the wiki IS the compiled knowledge)
3. **Synthesize** an answer with citations to wiki pages
4. **Offer** to file the answer as a new analysis page if it's substantive
5. If the wiki can't answer it, say so and suggest what sources might help

### 3. LINT — Health check

When I say "lint" or "health check":

1. **Orphans**: Pages with no inbound links
2. **Stale pages**: Pages whose sources have been superseded by newer ingests
3. **Contradictions**: Claims that conflict across pages
4. **Missing pages**: Concepts or entities mentioned but lacking their own page
5. **Broken links**: `[[wikilinks]]` that point to non-existent pages
6. **Coverage gaps**: Important topics mentioned in sources but not developed
7. **Suggested questions**: What should I investigate next?

Report findings as a checklist, then ask which ones to fix.

### 4. REFACTOR — Restructuring

When I say "refactor":

1. Look for pages that have grown too large (>500 lines) → split them
2. Look for pages that are too thin (<50 words) → merge or expand
3. Look for better categorization of pages across folders
4. Suggest schema improvements to THIS file

---

## Index Format

`wiki/index.md` follows this structure:

```markdown
# Wiki Index

Last updated: YYYY-MM-DD | Total pages: N | Total sources: N

## Sources
| Date | Title | Tags |
|------|-------|------|
| 2026-04-04 | [[sources/page-name]] | tag1, tag2 |

## Entities
- [[entities/page-name]] — one-line description

## Concepts
- [[concepts/page-name]] — one-line description

## Analyses
- [[analyses/page-name]] — one-line description
```

## Log Format

`wiki/log.md` is append-only. Each entry:

```markdown
## [YYYY-MM-DD] action | Title
Brief description of what happened.
Files touched: list of files created or modified.
```

Actions: `ingest`, `query`, `lint`, `refactor`, `update`

---

## Domain Configuration

> Customize this section for your specific use case.
> Delete the examples and fill in your own domain focus.

**Domain**: Enterprise AI

**Key entity types**: Companies, People, Products, Papers

**Key concept types**: Architectures, Techniques, Frameworks, Tradeoffs, Algorithms

**Synthesis goals**: 
What are the opportunities?
What are the risks?
How does it work?
How does one apply in practice?
What should one watch out for?

**Output formats**: markdown pages, comparison tables

---

## Meta

This schema is itself a living document. After every few ingest cycles, review it:
- Are the workflows working?
- Are the page conventions producing useful pages?
- Should the folder structure change?
- Are there new conventions the LLM should follow?

Suggest improvements by saying "refactor schema".
