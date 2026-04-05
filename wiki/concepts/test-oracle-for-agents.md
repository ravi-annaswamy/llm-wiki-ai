---
title: "Test oracle for agents"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [agentic-coding, evaluation, methodology, long-horizon-tasks, filter-loop]
status: active
---

# Test oracle for agents

The **single most important enabling condition** for long-running autonomous agentic work at current model capability: the agent must have a way to know whether it's making progress without needing a human to tell it. An "oracle" in this sense is any mechanism that produces a reliable signal about whether the current code is closer to correct than the previous version. [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md) identifies the oracle as the pivotal component in his [long-running-agentic-coding](long-running-agentic-coding.md) methodology (Source: [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)).

## Three forms the oracle can take

1. **A reference implementation.** Another codebase, typically pre-existing and battle-tested, whose outputs are treated as gold labels. In the [clax-project](../entities/clax-project.md) case, the [class-boltzmann-solver](../entities/class-boltzmann-solver.md) C source served this role — Claude was instructed to build and continuously run unit tests that compared its JAX implementation's outputs against CLASS across relevant parameter regimes. The accuracy target (0.1%) was set to match the typical CLASS↔CAMB agreement level, i.e. the floor of what the field accepts as "correct."
2. **A clearly quantifiable objective.** A metric the agent can compute locally: compiler bootstraps a target, a numerical integrator achieves some error tolerance, a benchmark is beaten.
3. **An existing test suite.** For mature codebases, the test suite can serve as the oracle. The agent is instructed to **expand the test suite** as it works, so the evaluation surface area grows with the codebase.

Mishra-Sharma explicitly recommends instructing the agent to expand the test suite and run tests continuously, not just at the end. This prevents regressions and gives the agent a moving signal rather than a single boolean pass/fail.

## Why this is load-bearing

Without an oracle, the agent is flying blind. It can produce code that compiles and looks plausible but is subtly wrong — and at the multi-day horizon those errors compound into unrecoverable states. The oracle converts "code that looks right" into "code that measurably tracks a known-good reference," which is the condition under which a [ralph-loop](ralph-loop.md)-style kicker can actually push toward improvement rather than drift.

The failure mode Mishra-Sharma flags explicitly in the CLAX post is an oracle whose **coverage** is too narrow: for a while Claude was only running tests at a single fiducial parameter point, drastically reducing its bug-catching surface area. Having an oracle isn't enough — the oracle has to cover the space in which the agent can make mistakes. Narrow oracles produce overconfident agents.

## The filter-loop generalization

The test oracle is one instance of a broader cross-cutting pattern: **LLM as producer of structured artifacts, with a filter loop deciding what survives.** The four clean instances visible in this wiki — Karpathy's lint-filtered knowledge base, AlphaEvolve's exploitability-filtered algorithms, Coral Hart's revision-filtered novels, CLAX's accuracy-filtered JAX code — share a common structure: the LLM writes a **durable** output, and an **automated** (or near-automated) loop decides which versions are kept, rejected, or rewritten. The shape of the filter varies wildly (static linters, game-theoretic metrics, reader reviews, numerical diffs), but the structural role is identical: **without the filter, the producer drifts; with it, the producer compounds toward the target.**

The test-oracle concept on this page is the same idea specialized to code-correctness scientific computing. For the full cross-cutting analysis — instances, features, predictions, and where the pattern doesn't apply — see **[producer-filter-pattern](../analyses/producer-filter-pattern.md)**.

## When an oracle doesn't exist

Mishra-Sharma is explicit that "more open-ended scientific discovery via agents is certainly on the horizon" but "long-running autonomous scientific work **today** crucially depends on the agent having a way to know whether it's making progress." Tasks without a clean oracle — genuine exploratory research, open-ended design, creative work with contested success criteria — are not yet well served by the long-running-agentic-coding methodology. They remain in the short-leash conversational regime where a human provides evaluation inline.

This also implies a practical heuristic: **if you're considering handing a task to a long-running agent, first ask "what plays the role of CLASS here?" If nothing does, either construct an oracle first or reconsider.**

## Related

- [long-running-agentic-coding](long-running-agentic-coding.md)
- [agent-persistent-memory](agent-persistent-memory.md)
- [ralph-loop](ralph-loop.md)
- [agent-driven-scientific-computing](agent-driven-scientific-computing.md)
- [llm-knowledge-bases](llm-knowledge-bases.md)
- [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md)
- [wiki-linting](wiki-linting.md)
- [clax-project](../entities/clax-project.md)
- [class-boltzmann-solver](../entities/class-boltzmann-solver.md)
- [producer-filter-pattern](../analyses/producer-filter-pattern.md)
- [own-your-substrate](../analyses/own-your-substrate.md)
- [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
