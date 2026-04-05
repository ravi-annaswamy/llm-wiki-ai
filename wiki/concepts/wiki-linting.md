---
title: "Wiki Linting (Active Maintenance)"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [karpathy, linting, maintenance, quality, self-healing]
status: active
---

# Wiki Linting

> **The ongoing maintenance step in [llm-knowledge-bases](llm-knowledge-bases.md) where the LLM scans the whole wiki for inconsistencies, orphans, contradictions, and coverage gaps — fixing what it can and surfacing what it can't.** Community member Charly Wargnier: *"It acts as a living AI knowledge base that actually heals itself."*

## What a lint pass checks

| Check | What it finds |
|---|---|
| **Orphans** | Pages with no inbound backlinks — knowledge siloed and undiscoverable |
| **Contradictions** | Claims on one page conflicting with claims on another. Flag explicitly, don't silently merge |
| **Stale pages** | Source material superseded by newer ingests |
| **Missing pages** | Concepts/entities mentioned across 3+ pages but lacking their own |
| **Broken links** | Wikilinks pointing to non-existent files |
| **Coverage gaps** | Important topics in raw sources not yet promoted |
| **Suggested questions** | What should the user investigate next? |

## Why it's the core innovation (not compilation)

At first glance, compilation — the LLM writing pages from raw sources — looks like the central move. But **linting is what makes the wiki compound rather than merely grow.** Without it, every new source adds pages without reconciling them with existing knowledge, contradictions pile up silently, concepts fragment across similar pages, and signal-to-noise degrades as the corpus grows. Linting is how the wiki stays coherent at scale — what distinguishes a "self-healing knowledge base" from an LLM-authored pile of files.

## Open questions

- Can unsupervised linting be trusted, or does it need a human editor in the loop?
- What are the failure modes — over-merging distinct concepts, or over-splitting similar ones?
- Does linting need a separate model from compilation to avoid confirmation bias?

## Related

- **Hub:** [llm-knowledge-bases](llm-knowledge-bases.md)
- **Adjacent:** [contamination-mitigation](contamination-mitigation.md) · [swarm-knowledge-base](swarm-knowledge-base.md) (uses a dedicated Hermes model as a lint/quality gate)
- **Source:** [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)
