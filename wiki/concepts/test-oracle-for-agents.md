---
title: "Test oracle for agents"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [agentic-coding, evaluation, methodology, long-horizon-tasks, filter-loop]
status: active
---

# Test oracle for agents

> **The single most important enabling condition for long-running autonomous agentic work at current model capability: the agent must be able to tell whether it is making progress without a human.** [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md) identifies the oracle as the pivotal component of his [long-running-agentic-coding](long-running-agentic-coding.md) methodology.

An oracle is any mechanism that produces a reliable signal about whether the current code is closer to correct than the previous version.

## Three forms the oracle can take

| Form | Example |
|---|---|
| **Reference implementation** | CLASS C source as ground truth for [clax-project](../entities/clax-project.md); 0.1% accuracy target matches CLASS↔CAMB floor |
| **Quantifiable objective** | Compiler bootstraps a target; benchmark beaten; numerical integrator meets error tolerance |
| **Existing test suite** | For mature codebases — agent is instructed to *expand* the suite as it works, so eval surface grows with the codebase |

Mishra-Sharma explicitly recommends **expanding the test suite** continuously and running tests as a moving signal, not just a terminal pass/fail.

## Why it's load-bearing

Without an oracle, the agent is flying blind — producing code that compiles and looks plausible but is subtly wrong. At multi-day horizon these errors compound into unrecoverable states. The oracle converts "code that looks right" into "code that measurably tracks a known-good reference," which is the condition under which a [ralph-loop](ralph-loop.md) can push toward improvement rather than drift.

> ⚠️ **NARROW-ORACLE FAILURE.** For a stretch in the CLAX project Claude was only running tests at a single fiducial parameter point, drastically reducing bug-catching surface area. **Having an oracle isn't enough — the oracle has to cover the space in which the agent can make mistakes.** Narrow oracles produce overconfident agents.

## Generalization

The test oracle is one instance of the broader [producer-filter-pattern](../analyses/producer-filter-pattern.md): LLM as producer of structured artifacts, with a filter loop deciding what survives. See that page for the full cross-cutting analysis across instances (Karpathy's lint, AlphaEvolve's exploitability, Coral Hart's revisions, CLAX's accuracy diffs).

## When an oracle doesn't exist

Mishra-Sharma: *"long-running autonomous scientific work today crucially depends on the agent having a way to know whether it's making progress."* Tasks without a clean oracle — open-ended design, genuine exploratory research, creative work with contested criteria — are not yet well served by long-running agentic methods. **Practical heuristic: before handing a task to a long-running agent, ask "what plays the role of CLASS here?" If nothing does, construct an oracle first or reconsider.**

## Related

- **Hub:** [long-running-agentic-coding](long-running-agentic-coding.md)
- **Analysis:** [producer-filter-pattern](../analyses/producer-filter-pattern.md)
- **Siblings:** [agent-persistent-memory](agent-persistent-memory.md) · [ralph-loop](ralph-loop.md) · [agent-driven-scientific-computing](agent-driven-scientific-computing.md)
- **Canonical case:** [clax-project](../entities/clax-project.md) · [class-boltzmann-solver](../entities/class-boltzmann-solver.md)
- **Source:** [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
