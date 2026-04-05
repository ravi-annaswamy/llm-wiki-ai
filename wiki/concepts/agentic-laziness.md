---
title: "Agentic laziness"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [agentic-coding, failure-mode, model-behavior, long-horizon-tasks]
status: active
---

# Agentic laziness

A failure mode of current LLM coding agents on complex, multi-part tasks: **the agent finds an excuse to stop before finishing the entire task**, even when it has the capability and context to continue. [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md) introduces the term in the context of [long-running-agentic-coding](long-running-agentic-coding.md), giving a characteristic example of the agent's rationalization: *"It's getting late, let's pick back up again tomorrow?"* (Source: [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)).

The laziness is not literal tiredness — the model has no circadian state. It is a **behavioral residue** of training on human text: human assistants commonly defer continuation, ask for confirmation before long tasks, or declare completion prematurely when the work is tedious. The model inherits these behaviors unless actively scaffolded against them.

## Why it matters for long-running workflows

Short-horizon conversational tasks rarely surface this failure mode — if the agent stops early, the human re-prompts immediately in the next turn. But in [long-running-agentic-coding](long-running-agentic-coding.md), **the human is not watching**. If the agent declares completion prematurely, the project sits idle until the user checks in hours later. The wall-clock cost of a false "done" is the full detach interval.

This is what makes agentic laziness a significant obstacle to the "run it overnight" posture, and why specific countermeasures are needed.

## Countermeasures

1. **The [ralph-loop](ralph-loop.md)** — a `for`-loop wrapper that catches "done" claims and checks them against the actual success criterion. If the criterion isn't met, re-prompt and keep going. This is the direct, mechanical fix.
2. **Explicit completion promises.** Require the agent to emit a specific token (e.g., "DONE") only when a measurable condition is met. Separates genuine completion claims from partial-progress mumbling.
3. **Success criteria tied to a [test-oracle-for-agents](test-oracle-for-agents.md).** If "done" is defined as "all tests against CLASS pass at 0.1% across the parameter space," the agent cannot wave it away — the oracle will contradict the laziness.
4. **CLAUDE.md rules of engagement.** Explicit instructions like "do not stop until the success criterion is met" directly in the plan file, which Claude Code keeps in context.

## Status

Mishra-Sharma treats this as a **current-capability artifact** rather than a permanent feature of LLMs. His framing: *"As models get more capable, they require less bespoke orchestration. At a given point in time, however, it can be useful to provide some level of scaffolding as a capability uplift."* Expect agentic laziness to diminish over model generations; expect the Ralph loop and similar scaffolds to become progressively less necessary.

Until then, treating it as a named failure mode — rather than a mysterious annoyance — makes it easier to engineer around systematically.

## Related

- [ralph-loop](ralph-loop.md)
- [long-running-agentic-coding](long-running-agentic-coding.md)
- [test-oracle-for-agents](test-oracle-for-agents.md)
- [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
