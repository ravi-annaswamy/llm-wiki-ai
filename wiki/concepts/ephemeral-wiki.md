---
title: "Ephemeral Wiki"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [karpathy, lex-fridman, workflow, task-specific]
status: active
---

# Ephemeral Wiki

> **A variant of [llm-knowledge-bases](llm-knowledge-bases.md): generate a temporary, task-specific mini-knowledge-base, use it, discard it.** Described by Lex Fridman in response to Karpathy's original post — flips the time horizon of the pattern from years to hours.

Fridman's description:

> I often have it generate dynamic html (with js) that allows me to sort/filter data and to tinker with visualizations interactively. Another useful thing is I have the system generate a temporary focused mini-knowledge-base... that I then load into an LLM for voice-mode interaction on a long 7-10 mile run.

Two ideas: dynamically generated visualization layers over data, and the ephemeral, task-scoped mini-wiki itself.

## Persistent vs ephemeral

| Aspect | Persistent wiki | Ephemeral wiki |
|---|---|---|
| Lifespan | Months to years | Hours to days |
| Scope | Personal / departmental | A single task or report |
| Sources | Accumulated over time | Gathered for the task |
| Compounding | Core feature | Not relevant |
| Reuse | Central | None — dissolve after use |
| Cost of errors | High (pollutes memory) | Low (thrown away) |

## Why it's useful

- **Low commitment.** No need to pre-decide whether something is "worth" the permanent vault.
- **No contamination risk.** Discarded output can't pollute the personal vault — see [contamination-mitigation](contamination-mitigation.md).
- **Task-shaped context.** The wiki can be structured exactly for the task without worrying about general-purpose navigability.
- **Good fit for voice-mode / mobile consumption**, which wouldn't work with a sprawling permanent vault.

## What it implies

A future where users don't just "chat" with an AI — they **spawn a team of agents to build a custom research environment for a specific task**, which dissolves once the output is written. The unit of work becomes the mini-wiki, not the chat session. Natural pattern for experimentation: generate several ephemeral wikis in parallel for competing hypotheses, promote only findings from the winner.

## Related

- **Hub:** [llm-knowledge-bases](llm-knowledge-bases.md)
- **Adjacent:** [contamination-mitigation](contamination-mitigation.md) · [swarm-knowledge-base](swarm-knowledge-base.md)
- **Source:** [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)
