---
title: "Contamination Mitigation (Clean Vault / Messy Vault)"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [karpathy, multi-agent, quality, obsidian, workflow]
status: active
---

# Contamination Mitigation

> **A practical refinement of [llm-knowledge-bases](llm-knowledge-bases.md) proposed by [steph-ango](../entities/steph-ango.md) ([obsidian](../entities/obsidian.md) co-creator): keep your personal "vault" clean, let agents play in a "messy vault," promote only reviewed artifacts.**

## The failure mode it prevents

Unconstrained agents writing directly into a user's primary knowledge base can pollute it with:

| Failure | Effect |
|---|---|
| Low-quality drafts | Treated as authoritative because they live in the vault |
| Speculative cross-links | Corrupt the backlink graph with junk edges |
| Hallucinated claims | Become context for the next lint pass, compounding |
| Redundant pages | Agent didn't notice an existing one |
| Over-eager refactors | Damage structure the user carefully built |

Once pollution enters a personal vault it's hard to remove — especially if the user trusts the vault as "their knowledge."

## The two-vault pattern

Fix is **architectural, not behavioral**:

- **Messy vault** — where agents work freely. Ingests, compilations, linting, experiments, swarms. High throughput, lower quality bar, treated as disposable.
- **Clean vault** — user's primary knowledge base. High bar, curated by a human (or a tightly constrained single agent). Only receives artifacts the user has explicitly promoted.

**Promotion is the key step** — a conscious human action, not automatic sync.

## Why multi-agent setups need this

Once more than one agent writes to the wiki, contamination mitigation becomes nearly mandatory:

- Agent A's hallucination becomes agent B's context, compounding across the swarm (same concern as the [swarm-knowledge-base](swarm-knowledge-base.md) Quality Gate).
- Lint passes can't distinguish "human wrote this" from "agent wrote this last week" — human corrections can be silently reverted.

## How this wiki could apply it

This project currently has a single vault (`wiki/`). A future refinement could introduce `wiki-staging/` where agent outputs and lint suggestions land first, with an explicit human promote step. Currently the review happens implicitly during the conversational ingest flow — which works at this scale but may not survive heavy batch ingest or multi-agent expansion.

## Related

- **Hub:** [llm-knowledge-bases](llm-knowledge-bases.md)
- **Multi-agent version:** [swarm-knowledge-base](swarm-knowledge-base.md)
- **Adjacent:** [wiki-linting](wiki-linting.md)
- **Originator:** [steph-ango](../entities/steph-ango.md) · [obsidian](../entities/obsidian.md)
- **Source:** [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)
