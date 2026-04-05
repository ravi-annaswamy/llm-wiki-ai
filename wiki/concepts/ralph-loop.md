---
title: "The Ralph loop"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [agentic-coding, orchestration, methodology, prompt-engineering]
status: active
---

# The Ralph loop

> **A `for`-loop wrapper around a coding agent that kicks it back into context when it claims completion — asking whether it's *really* done.** Named after Geoffrey Huntley's [blog post](https://ghuntley.com/loop/). Counteracts [agentic-laziness](agentic-laziness.md): current models stop short on complex tasks with excuses like *"It's getting late, let's pick back up again tomorrow?"*

## Mechanism

```
while not done:
    run_agent()
    if agent_said_DONE and tests_actually_pass:
        break
    else:
        re-prompt: "are you really done? acceptance criteria not yet met."
```

A real invocation from the CLAX project:

```
/ralph-loop:ralph-loop "Please keep working on the task until the success
criterion of 0.1% accuracy across the entire parameter range is achieved."
--max-iterations 20 --completion-promise "DONE"
```

## The three knobs

| Knob | Example | Purpose |
|---|---|---|
| **Success criterion** | *"0.1% accuracy across parameter range"* | Precise, measurable, tied to [test-oracle-for-agents](test-oracle-for-agents.md) |
| **Max iterations** | 20 | Budget cap; blunt failsafe |
| **Completion promise** | `DONE` | Specific token to force distinguishable claim, separable from partial progress reports |

## Why a named pattern and not just "good prompting"

Mishra-Sharma frames Ralph as **capability-uplift scaffolding** — something current models need because they aren't yet robust enough to stop exactly when done. Positioned as **temporary**: *"As models get more capable, they require less bespoke orchestration. At a given point in time, however, it can be useful to provide some level of scaffolding."* Ralph is a workaround for [agentic-laziness](agentic-laziness.md) at current capability, not a permanent architectural component.

## Sibling patterns

- **GSD ("Get Shit Done")** — general-purpose completion harness ([github.com/gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done)).
- **Domain-specific GSD variants** — e.g. a physics variant (arXiv:2603.20179, github.com/psi-oss/get-physics-done).
- **`/loop` command** native to Claude Code.

All share the core mechanic: wrap the agent in a completion-verifying outer loop, exit only when the success criterion is met.

## Relation to other wiki concepts

- **Filter on the producer.** Ralph is a thin instance of the general pattern in [producer-filter-pattern](../analyses/producer-filter-pattern.md). Its filter is the success-criterion check; Karpathy's wiki uses a lint pass; AlphaEvolve uses exploitability. Same architecture, different filter.
- **Dependency on [test-oracle-for-agents](test-oracle-for-agents.md).** Ralph only works with a trustworthy oracle; otherwise it loops forever on false "done" claims. Ralph is the control mechanism *on top of* a valid oracle, not a substitute.

## Limitations

- **Only works with measurable criteria.** Judgment-based success → Ralph can't close the loop.
- **Max-iterations is blunt.** If the agent genuinely cannot reach the criterion, Ralph burns compute until the cap.
- **Can mask capability limits.** Given enough loops, the agent may stumble into a bad local optimum rather than admit infeasibility. Treat Ralph's DONE as a *claim requiring verification*, not a guarantee.

## Related

- **Hub:** [long-running-agentic-coding](long-running-agentic-coding.md)
- **Fights:** [agentic-laziness](agentic-laziness.md)
- **Depends on:** [test-oracle-for-agents](test-oracle-for-agents.md) · [agent-persistent-memory](agent-persistent-memory.md)
- **Canonical use:** [clax-project](../entities/clax-project.md)
- **Source:** [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
