---
title: "Agent persistent memory (the CHANGELOG.md pattern)"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [agentic-coding, memory, methodology, long-horizon-tasks, file-over-app]
status: active
---

# Agent persistent memory

The mechanism by which a long-running coding agent **remembers progress, state, and — crucially — failed attempts** across sessions that can last days or weeks. [[entities/siddharth-mishra-sharma]] introduces this as the second pillar of the [[concepts/long-running-agentic-coding]] methodology, and names the conventional location `CHANGELOG.md` at the project root (Source: [[sources/2026-04-04-anthropic-long-running-claude-scientific-computing]]).

## What a progress file tracks

A well-designed `CHANGELOG.md` tracks at minimum:

- **Current status** — what's done, what's in progress, what's next.
- **Completed tasks** — with enough detail that the agent can recognize subsequent work that would duplicate them.
- **Failed approaches and the reasons they failed.** Load-bearing. Without these, successive sessions re-attempt the same dead ends. Example entry Mishra-Sharma gives: *"Tried using Tsit5 for the perturbation ODE, system is too stiff. Switched to Kvaerno5."* The failure reason (stiffness) is what prevents a future session from looping back to Tsit5.
- **Accuracy tables at key checkpoints.** A running log of how well the code is tracking the [[concepts/test-oracle-for-agents]], with timestamps or commit SHAs. Makes progress auditable and helps identify regressions.
- **Known limitations.** Explicit acknowledgment of what the code currently does not do. Prevents the agent from wasting time re-discovering known gaps.

## Why this is different from conventional changelogs

A human-oriented `CHANGELOG.md` is typically a release-notes artifact — a backward-facing document for users of the software. The agent-oriented `CHANGELOG.md` is a **forward-facing document for the agent itself**. It's closer in spirit to a lab notebook: "here's what I tried, here's what happened, here's what I think I should try next." The audience is the next session of the same agent, not the end user.

The framing Mishra-Sharma uses — "the agent's portable long-term memory, acting as a sort of lab notes" — makes the distinction clear. This is **memory-as-a-file**, an alternative to hidden embedding-based memory that lives in a vector store or agent state.

## Why put it in a file rather than model context or a vector DB

Several advantages stack:

- **Portable across sessions.** Context windows end; files persist. The next session reads `CHANGELOG.md` and catches up.
- **Portable across agents.** A human collaborator, a different model, or a debugging session can read the exact same file.
- **Legible to the user.** Mishra-Sharma checks CLAX progress from his phone by glancing at the repo; a vector-store memory would require a tool to inspect.
- **Auditable.** The failure log is itself a research artifact. It tells the user what the agent has ruled out and why.
- **Editable by humans.** If the agent records a wrong conclusion, the user can correct the `CHANGELOG.md` and the correction propagates to all future sessions automatically.

This is a textbook [[concepts/file-over-app-philosophy]] instance: the state that matters lives on disk as a plain file the user owns, not inside a vendor system.

## The connection to the Karpathy pattern

The `CHANGELOG.md` role in a long-running coding project is structurally identical to the role of `wiki/log.md` in [[concepts/llm-knowledge-bases]]: a chronological, append-mostly record of what the LLM has done, why, and what's still unfinished, used as context for subsequent sessions. Both are [[concepts/file-over-app-philosophy]] instances. Both are the "procedural memory" counterpart to the "declarative memory" of the main artifacts (wiki pages in Karpathy's case, source code in Mishra-Sharma's case).

This is another example of the same architectural instinct being independently rediscovered in different domains — see [[analyses/own-your-substrate]] for the broader analysis.

## Practical instructions the wiki's own setup could borrow

- Explicitly record **failed approaches** in this wiki's own log, not just successes. The existing `wiki/log.md` captures ingest events but not failed attempts at concept splits, merges, or lint fixes. Future lint passes could benefit from a "dead-ends" section.
- Keep progress files **editable by the user**, not write-only for the agent. A user correction should propagate by virtue of being the next thing the agent reads.

## Related

- [[concepts/long-running-agentic-coding]]
- [[concepts/test-oracle-for-agents]]
- [[concepts/ralph-loop]]
- [[concepts/file-over-app-philosophy]]
- [[concepts/llm-knowledge-bases]]
- [[entities/clax-project]]
- [[sources/2026-04-04-anthropic-long-running-claude-scientific-computing]]
