---
title: "Contamination Mitigation (Clean Vault / Messy Vault)"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [karpathy, multi-agent, quality, obsidian, workflow]
status: active
---

# Contamination Mitigation (Clean Vault / Messy Vault)

A practical refinement of the [[concepts/llm-knowledge-bases]] pattern, proposed by [[entities/steph-ango]] (co-creator of [[entities/obsidian]]) in response to Karpathy's original post (Source: [[sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases]]).

## The core idea

> Keep your personal "vault" clean. Let the agents play in a "messy vault." Only bring useful artifacts over once the agent-facing workflow has distilled them.

## Why it matters

The unconstrained version of the Karpathy pattern has a failure mode: LLM agents working directly in a user's primary knowledge base can **pollute** it with:

- Low-quality drafts that were meant to be revised later
- Speculative connections between unrelated topics
- Hallucinated claims presented as facts
- Redundant pages created because the agent didn't notice an existing one
- Over-eager refactors that damage structure the user carefully built

Once pollution enters a personal vault, it's hard to remove — especially if the user trusts the vault as "their knowledge." The more the user treats the vault as authoritative, the more damaging contamination becomes.

## The two-vault pattern

The fix is architectural, not behavioral:

- **Messy vault** — where agents work freely. Ingests, compilations, linting, experiments, multi-agent swarms. High throughput, lower quality bar. Treated as disposable.
- **Clean vault** — the user's primary knowledge base. High quality bar. Curated by a human (or a highly constrained single agent). Only receives artifacts the user has explicitly reviewed and promoted.

Promotion is the key step: a conscious human action, not an automatic sync.

## Implications for multi-agent setups

Contamination mitigation becomes nearly mandatory once more than one agent is writing to the wiki. Without the clean/messy separation:

- A hallucination from agent A becomes context for agent B, then compounds across the swarm (the same concern addressed by the [[concepts/swarm-knowledge-base]] "Quality Gate").
- Lint passes can't distinguish "the user wrote this" from "an agent wrote this last week," so human corrections can be silently reverted.

## How this wiki could apply it

This project currently has a single vault (`wiki/`). A future refinement could introduce a `wiki-staging/` or `wiki-scratch/` directory where LLM-generated analyses and lint suggestions land first, with a human "promote" step before they enter `wiki/`. Currently, the human review happens implicitly during the conversational ingest flow — which works at this scale but may not survive heavy multi-source ingest batches or multi-agent expansion.

## Related

- [[concepts/llm-knowledge-bases]]
- [[concepts/swarm-knowledge-base]]
- [[concepts/wiki-linting]]
- [[entities/steph-ango]]
- [[entities/obsidian]]
