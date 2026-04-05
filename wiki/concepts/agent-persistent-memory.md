---
title: "Agent persistent memory (the CHANGELOG.md pattern)"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [agentic-coding, memory, methodology, long-horizon-tasks, file-over-app]
status: active
---

# Agent persistent memory

> **The mechanism by which a long-running coding agent remembers progress, state, and — crucially — failed attempts across sessions that span days or weeks.** [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md) names the conventional location: `CHANGELOG.md` at the project root. Memory-as-a-file, an alternative to hidden embedding-based memory.

## What the progress file tracks

| Field | Purpose |
|---|---|
| **Current status** | What's done, in progress, next |
| **Completed tasks** | Enough detail that the agent recognizes future work that would duplicate them |
| **Failed approaches + reasons** | Load-bearing. Without reasons, successive sessions re-attempt dead ends. Example: *"Tried Tsit5 for the perturbation ODE, system is too stiff. Switched to Kvaerno5."* |
| **Accuracy tables at checkpoints** | Running log of tracking vs [test-oracle-for-agents](test-oracle-for-agents.md) with commit SHAs — makes progress auditable, surfaces regressions |
| **Known limitations** | Prevents the agent wasting time re-discovering known gaps |

## Forward-facing, not backward-facing

A human-oriented `CHANGELOG.md` is release notes — backward-facing for users of the software. The **agent-oriented `CHANGELOG.md` is forward-facing, for the next session of the same agent.** Closer to a lab notebook: *"here's what I tried, here's what happened, here's what I think I should try next."* Mishra-Sharma's framing: *"the agent's portable long-term memory, acting as a sort of lab notes."*

## Why a file beats context or vector DB

- **Portable across sessions.** Context windows end; files persist.
- **Portable across agents.** A human, a different model, or a debugging session reads the exact same file.
- **Legible to the user.** Mishra-Sharma checks CLAX progress from his phone by glancing at the repo.
- **Auditable.** The failure log is itself a research artifact — it tells the user what's been ruled out and why.
- **Editable by humans.** A user correction propagates to all future sessions automatically by being the next thing the agent reads.

Textbook [file-over-app-philosophy](file-over-app-philosophy.md) instance.

## Structural parallel to Karpathy's wiki

`CHANGELOG.md` in a long-running coding project is structurally identical to `wiki/log.md` in [llm-knowledge-bases](llm-knowledge-bases.md): chronological append-mostly record of what the LLM did, why, and what's unfinished, used as context for subsequent sessions. Both are the **procedural memory** counterpart to the **declarative memory** of the main artifacts (wiki pages / source code). Same architectural instinct independently rediscovered — see [own-your-substrate](../analyses/own-your-substrate.md).

## Practical borrow for this wiki

- **Explicitly record failed approaches** in `wiki/log.md`, not just successes. This wiki's log currently captures ingest events but not failed concept splits, merges, or lint fixes.
- **Keep progress files editable by the user**, not write-only for the agent.

## Related

- **Hub:** [long-running-agentic-coding](long-running-agentic-coding.md)
- **Siblings:** [test-oracle-for-agents](test-oracle-for-agents.md) · [ralph-loop](ralph-loop.md)
- **Cross-domain parallel:** [llm-knowledge-bases](llm-knowledge-bases.md)
- **Philosophy:** [file-over-app-philosophy](file-over-app-philosophy.md)
- **Canonical case:** [clax-project](../entities/clax-project.md)
- **Source:** [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
