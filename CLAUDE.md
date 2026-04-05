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

- Use standard Markdown links with relative paths: `[display text](../concepts/page-name.md)`
- Always include the `.md` extension so GitHub's renderer resolves the link
- Compute the relative path from the containing file (e.g., from `entities/foo.md` to a concept page, use `../concepts/bar.md`; from `overview.md` to a concept, use `concepts/bar.md`)
- Obsidian handles standard Markdown links natively, so local editing still works — do NOT use `[[wikilinks]]` (they don't render on GitHub)
- Every page should have at least 2 inbound links (no orphans)
- When creating a new page, always check what existing pages should link to it

### Page Naming

- Use lowercase kebab-case: `reinforcement-learning.md`, `openai.md`
- Source summaries: `sources/YYYY-MM-DD-short-title.md`
- Be specific: `transformer-attention` not `attention`

### Writing Style

- Write in clear, direct prose — not bullet-point dumps
- Lead with the most important information
- Include specific claims with source attribution: `(Source: [karpathy-post](sources/2026-04-02-karpathy-post.md))`
- Flag uncertainty: "According to X, though Y disputes this..."

### Page Style Guide

A uniform style makes the wiki scannable at scale. Every page type has the same visible skeleton.

**1. TL;DR lede.** Every page starts with a single blockquote directly under the H1, 1–3 sentences, bold. It answers "what is this and why should I care?" for a reader who will not scroll. Keep it under ~250 characters.

```markdown
# Page Title

> **One-sentence hook.** Optional second sentence with the sharpest specific claim. This is the only thing some readers will read.
```

**2. Canonical section skeletons.** Pick the skeleton by page type and do not invent variants. Omit sections that don't apply; don't rename them.

- **Entity:** Lede → The workflow / Background (table preferred) → Why it matters → Related
- **Concept:** Lede → Core idea → Landscape / instances (table) → Structural points → Open questions → Related
- **Source:** Lede → Summary → Key facts (table or bullets) → Why it matters → Open questions → Prompt
- **Analysis:** Lede → The pattern → Instance table → Implications → Related

**3. Tables over bullet walls.** Any time you have ≥3 items with parallel structure (verification approaches, factory instances, comparison dimensions, figures), use a table. Bullets are for short, non-parallel lists.

**4. Kill duplicate framing.** If a cross-cutting idea already has its own page (`own-your-substrate`, `producer-filter-pattern`, reception paradox, etc.), do **not** re-explain it in prose. Give a one-line pointer: *"This is an instance of X — see [analyses/x.md]."* Re-explaining is the single biggest source of bloat.

**5. Typed "Related" section.** Replace flat bullet lists with grouped typed links. Use these labels (pick the ones that apply):

```markdown
## Related

- **Hub:** [hub-page](...)
- **Canonical case / Instances:** [page](...)
- **Contrast:** [page](...)
- **Analyses:** [page](...)
- **Adjacent:** [page](...)
- **Sources:** [source-page](...)
```

This both reduces visual clutter and surfaces the relationship type without extra prose. Drop the old "Connection to other wiki threads" section — typed Related replaces it.

**6. Callouts.** Use exactly one callout pattern for warnings:

```markdown
> ⚠️ **CONTRADICTION.** Page A claims X; Source B says Y.
> ⚠️ **CROSS-SOURCE DISCREPANCY.** Both sources cite the same primary but differ.
> ⚠️ **STALE.** This page's primary source was superseded by [newer-source].
```

No other emoji callouts. No HTML. One blockquote, bold label, period.

**7. Cap open questions at 3 unless there's a specific reason.** The first few are usually the interesting ones; the long tail dilutes them.

**8. Section titles should be short.** Prefer one- or two-word H2s. "Why it matters" is fine; "The question the essay is really asking" is not.

**9. Page length budgets.** Soft caps, enforced by lint:

| Page type | Target | Hard cap |
|---|---|---|
| Entity | 40–80 lines | 120 |
| Concept | 80–160 lines | 250 |
| Source | 40–80 lines | 120 |
| Analysis | no target | no cap |
| Overview / index | as needed | — |

If a source page wants to grow past the cap, the analysis belongs on a concept page, not the source. If a concept page wants to grow past the cap, split into sub-concepts with a hub.

**10. Frontmatter discipline.** Use YAML list form for `sources:` when there are multiple entries; inline only for single entries. Tag lists should be ≤6 tags. Do not invent new `type:` values.

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
7. **Style violations** (see Page Style Guide): missing TL;DR lede, non-canonical section skeleton, flat Related list that should be typed, "Connection to other wiki threads" duplicating a Related section, bullet wall where a table would fit, page over its length budget, re-explanation of a cross-cutting pattern that already has its own page.
8. **Suggested questions**: What should I investigate next?

Report findings as a checklist, then ask which ones to fix. For style violations, offer to batch-apply fixes rather than asking file-by-file — the style guide is uniform and batching preserves coherence.

### 4. REFACTOR — Restructuring

When I say "refactor":

1. Look for pages that have grown too large (>500 lines) → split them
2. Look for pages that are too thin (<50 words) → merge or expand
3. Look for better categorization of pages across folders
4. **Check for analysis-page graduation candidates.** Any cross-cutting theme that has **≥3 clean instances across sources** and is currently tracked only in `wiki/overview.md` paragraphs or inside a concept page's "generalization" section should be promoted to its own `analyses/` page. The threshold is deliberately low: the cost of a premature promotion is minor (a page that grows slowly); the cost of a belated promotion is that the insight gets buried inside a page about something narrower. When promoting, trim the now-redundant section in the original location down to a one-paragraph summary with an outbound link.
5. Suggest schema improvements to THIS file

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
## [YYYY-MM-DD HH:MM] action | Title
Brief description of what happened.
Failed approaches / dead ends (optional but encouraged): what was tried and abandoned, and why.
Files touched: list of files created or modified.
```

Actions: `ingest`, `query`, `lint`, `refactor`, `update`

**On failed approaches.** Borrowed from the `CHANGELOG.md` pattern catalogued at [[concepts/agent-persistent-memory]]: when a refactor, lint, or ingest pass tries a restructuring or categorization that is then abandoned, **record it in the log entry** along with the reason. Without this, successive sessions re-attempt the same dead ends (e.g., "I tried merging these two concept pages and it broke the cross-link graph, so I reverted"). Not every entry needs a failed-approaches section — use it when the path taken was non-obvious or when a plausible alternative was considered and rejected.

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

**Ingest-time lenses for agentic-work / automated-research sources**: When a source describes LLM agents, automated research, or agent-driven scientific work, actively check for these cross-cutting patterns and note where the source fits:

- **Producer–filter architecture** — is this another instance of [[analyses/producer-filter-pattern]]? Identify the producer (what the LLM is generating), the artifact (what's being persisted), and the filter (how quality is being decided). If yes, add it to the instance table on the analysis page.
- **Task shape → agent topology** — is the work **parallelizable** (swarm of independent sessions, like the [[entities/anthropic-c-compiler-project]]) or **deeply coupled** (single sequential agent tracing causally through a pipeline, like [[entities/clax-project]])? The same methodology plays out very differently depending on which. Note the topology on the source page and flag if a new task shape doesn't fit either.
- **Scaffolding pieces** — does the source describe a `CLAUDE.md`-equivalent portable plan, a `CHANGELOG.md`-equivalent cross-session memory, a test oracle, git-as-coordination, or a Ralph-loop-equivalent? These components recur across instances; mapping a new source against them makes integration faster.

---

## Meta

This schema is itself a living document. After every few ingest cycles, review it:
- Are the workflows working?
- Are the page conventions producing useful pages?
- Should the folder structure change?
- Are there new conventions the LLM should follow?

Suggest improvements by saying "refactor schema".
