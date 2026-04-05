---
title: "Agentic laziness"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [agentic-coding, failure-mode, model-behavior, long-horizon-tasks]
status: active
---

# Agentic laziness

> **A failure mode of current LLM coding agents on long multi-part tasks: the agent finds an excuse to stop before finishing, even when capable of continuing.** [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md) coined the term, citing the rationalization *"It's getting late, let's pick back up again tomorrow?"*

The laziness is not literal tiredness — the model has no circadian state. It is a **behavioral residue** of training on human text: human assistants defer continuation, ask confirmation before long tasks, or declare completion prematurely. The model inherits these behaviors unless actively scaffolded against them.

## Why it matters for long-running workflows

Short-horizon tasks rarely surface it — if the agent stops early, the human re-prompts immediately. But in [long-running-agentic-coding](long-running-agentic-coding.md), **the human is not watching**. A false "done" leaves the project idle for the entire detach interval. This is the primary obstacle to the "run it overnight" posture.

## Countermeasures

| Mechanism | How it fights laziness |
|---|---|
| [ralph-loop](ralph-loop.md) | `for`-loop wrapper catches "done" claims and re-checks against the success criterion |
| Explicit completion tokens | Agent must emit a specific token (e.g. `DONE`) only when a measurable condition is met |
| [test-oracle-for-agents](test-oracle-for-agents.md) | Define "done" as oracle pass; agent cannot wave it away |
| `CLAUDE.md` rules of engagement | *"Do not stop until the success criterion is met"* directly in the portable plan |

## Status

Mishra-Sharma treats this as a **current-capability artifact**, not a permanent LLM feature: *"As models get more capable, they require less bespoke orchestration. At a given point in time, however, it can be useful to provide some level of scaffolding as a capability uplift."* Expect laziness to diminish; expect Ralph-style scaffolds to become progressively less necessary.

## Related

- **Counter-patterns:** [ralph-loop](ralph-loop.md) · [test-oracle-for-agents](test-oracle-for-agents.md)
- **Hub:** [long-running-agentic-coding](long-running-agentic-coding.md)
- **Source:** [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
