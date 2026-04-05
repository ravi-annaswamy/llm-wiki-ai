---
title: "Wiki Linting (Active Maintenance)"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [karpathy, linting, maintenance, quality, self-healing]
status: active
---

# Wiki Linting (Active Maintenance)

In the [llm-knowledge-bases](llm-knowledge-bases.md) pattern, **linting** is the ongoing maintenance step where the LLM periodically scans the whole wiki for inconsistencies, orphan pages, missing connections, contradictions, and coverage gaps — then fixes what it can and surfaces what it can't (Source: [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)).

Community member Charly Wargnier described the result: "It acts as a living AI knowledge base that actually heals itself."

## What a lint pass typically checks

Based on Karpathy's description and the community reactions:

- **Orphans.** Pages with no inbound `[[backlinks]]` — indicating the knowledge is siloed and undiscoverable from the rest of the wiki.
- **Contradictions.** Claims on one page that conflict with claims on another. Should be flagged explicitly rather than silently merged.
- **Stale pages.** Pages whose source material has been superseded by newer ingests.
- **Missing pages.** Concepts or entities mentioned multiple times across the wiki but lacking their own dedicated page.
- **Broken links.** Wikilinks that point to non-existent files.
- **Coverage gaps.** Important topics that appear in raw sources but weren't promoted into the wiki during compilation.
- **Suggested questions.** What should the user investigate next? Linting is both a cleanup pass and a research prompt.

## Why it's the core innovation (not compilation)

At first glance, compilation — the LLM writing wiki pages from raw sources — looks like the central move. But linting is what makes the wiki **compound** rather than merely grow. Without linting:

- Every new source adds pages but doesn't reconcile them with existing knowledge.
- Contradictions pile up silently.
- Concepts fragment across multiple similar pages.
- The signal-to-noise ratio degrades as the corpus grows.

Linting is how the wiki stays coherent at scale. It is what distinguishes a "self-healing knowledge base" from an LLM-authored pile of files.

## Open questions

- Can unsupervised linting be trusted, or does it need a human editor in the loop?
- What are the failure modes — e.g., does the LLM tend to over-merge distinct concepts, or over-split similar ones?
- Does linting need a separate model from compilation to avoid confirmation bias?
- Is there a lint-frequency threshold? Daily? After every ingest? On a size trigger?

## Related

- [llm-knowledge-bases](llm-knowledge-bases.md)
- [contamination-mitigation](contamination-mitigation.md)
- [swarm-knowledge-base](swarm-knowledge-base.md) (uses a dedicated Hermes model as a lint/quality gate)
