---
title: "The Ralph loop"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [agentic-coding, orchestration, methodology, prompt-engineering]
status: active
---

# The Ralph loop

An orchestration pattern, named after Geoffrey Huntley's [blog post introducing it](https://ghuntley.com/loop/), that wraps a `for` loop around a coding agent and **kicks the agent back into context when it claims completion**, asking whether it's *really* done. The goal is to counteract [agentic-laziness](agentic-laziness.md) — the failure mode where current models stop short on complex multi-part tasks with some excuse like "It's getting late, let's pick back up again tomorrow?" (Source: [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)).

## Mechanism

Conceptually the loop is trivial:

```
while not done:
    run_agent()
    if agent_said_DONE and tests_actually_pass:
        break
    else:
        re-prompt: "are you really done? acceptance criteria not yet met."
```

A real invocation from the CLAX project (using the Ralph plugin in Claude Code):

```
/ralph-loop:ralph-loop "Please keep working on the task until the success criterion
of 0.1% accuracy across the entire parameter range is achieved."
--max-iterations 20 --completion-promise "DONE"
```

Three knobs matter:

1. **The success criterion** — expressed as a precise, measurable condition tied to the [test-oracle-for-agents](test-oracle-for-agents.md). "0.1% accuracy across the entire parameter range" is the example; "all tests pass and coverage is above 90%" is another.
2. **Maximum iterations** — a budget cap. In the example, up to 20 passes.
3. **The completion promise** — a specific token (e.g., "DONE") the agent must emit to exit the loop. This forces the agent to make an explicit, distinguishable claim of completion, separable from partial progress reports.

## Why a named pattern and not just good prompting

Mishra-Sharma frames the Ralph loop as **capability uplift scaffolding** — something current models need because they are not yet robust enough to stop exactly when the task is done and not before. It's explicitly positioned as **temporary**: *"As models get more capable, they require less bespoke orchestration such as prompt engineering, RAG, or context stuffing. At a given point in time, however, it can be useful to provide some level of scaffolding."*

So the right mental model is: Ralph is a workaround for [agentic-laziness](agentic-laziness.md) at current capability, not a permanent architectural component. The loop will probably become unnecessary once models stop declaring completion prematurely.

## Related patterns in the same family

Mishra-Sharma mentions several sibling patterns:

- **GSD ("Get Shit Done")** — general-purpose "don't stop until done" harness. Repo: [github.com/gsd-build/get-shit-done](https://github.com/gsd-build/get-shit-done).
- **Domain-specific GSD variants** — e.g. a physics variant (arXiv:2603.20179, github.com/psi-oss/get-physics-done).
- **`/loop` command** — native to Claude Code, same idea built into the CLI.

All of these share the core mechanic: wrap the agent in a completion-verifying outer loop and only exit when the success criterion is met.

## Connection to other wiki concepts

- **Filter loop on the producer.** Ralph is a thin instance of the general pattern analysed in [test-oracle-for-agents](test-oracle-for-agents.md): the LLM produces artifacts, and a filter/oracle decides whether the producer is done. In Ralph's case, the filter is the success criterion check; in Karpathy's [llm-knowledge-bases](llm-knowledge-bases.md), it's the lint pass; in AlphaEvolve ([llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md)) it's the exploitability metric. Same architecture, different filter.
- **Dependency on [test-oracle-for-agents](test-oracle-for-agents.md).** Ralph only works if there's a trustworthy way to tell whether the success criterion has actually been met. Without a real oracle, Ralph just loops forever on an agent that keeps claiming "done" falsely. Ralph is the control mechanism *on top of* a valid oracle, not a substitute for one.

## Limitations

- **Only works with measurable criteria.** If success is judgment-based or contested, Ralph can't close the loop.
- **Max-iterations is a blunt failsafe.** If the agent genuinely cannot reach the criterion, Ralph will burn compute until the cap.
- **Can mask capability limits.** If the agent is looped enough times on a task outside its current capability, it may eventually stumble into a bad local optimum rather than admit infeasibility. Users should treat Ralph's "DONE" as a *claim requiring verification*, not a guarantee.

## Related

- [long-running-agentic-coding](long-running-agentic-coding.md)
- [agentic-laziness](agentic-laziness.md)
- [test-oracle-for-agents](test-oracle-for-agents.md)
- [agent-persistent-memory](agent-persistent-memory.md)
- [clax-project](../entities/clax-project.md)
- [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
