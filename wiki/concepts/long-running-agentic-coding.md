---
title: "Long-running agentic coding"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources:
  - "wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"
  - "wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"
tags: [agentic-coding, long-horizon-tasks, claude-code, methodology, scientific-computing, hpc, autoresearch, karpathy]
status: active
---

# Long-running agentic coding

> **A methodology for handing an LLM coding agent a well-scoped, multi-day, high-stakes software task and letting it work *autonomously* — with occasional human oversight rather than continuous supervision.** A distinct posture from the dominant "conversational loop, every step on a tight leash" mode, enabled by the steady extension of model time-horizons over 2024–2026.

## Three instances in the wiki

| Project | Topology | Filter | Session length |
|---|---|---|---|
| [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md) | Parallel swarm (~2,000 sessions) | Test suite + compilation | Weeks |
| [clax-project](../entities/clax-project.md) | Single sequential agent | Numerical accuracy vs reference | Days |
| [autoresearch](../entities/autoresearch.md) | Single sequential agent ([ratchet-loop](ratchet-loop.md)) | Monotone `val_bpb` | Minutes per experiment, overnight runs |

## When it fits

1. **Well-scoped.** Clear deliverable. "Build a differentiable JAX port of CLASS with feature parity" is scoped; "do cosmology research" is not.
2. **Mechanically quantifiable success.** 0.1% numerical agreement. Passing test suite. Compiling a target codebase. See [test-oracle-for-agents](test-oracle-for-agents.md).
3. **Occasional oversight viable.** The evaluation loop catches most errors without a human in the loop.

Mishra-Sharma's representative task types: reimplementing a numerical solver, porting legacy Fortran, debugging a large codebase against a reference. AutoResearch adds a fourth: **improving a training loop against a fixed validation metric**, with the oracle's immutability enforced at the filesystem level (untouchable `prepare.py`).

## The five scaffolding pieces

| Piece | Purpose | Dedicated page |
|---|---|---|
| **`CLAUDE.md`** — portable plan | Goals, design decisions, success targets, rules of engagement. Always in context. **Agent-editable** as a living spec | — |
| **`CHANGELOG.md`** — cross-session memory | Status, completed tasks, **failed approaches with reasons**, accuracy checkpoints | [agent-persistent-memory](agent-persistent-memory.md) |
| **Test oracle** | Single most important enabling condition. Reference implementation or quantifiable objective | [test-oracle-for-agents](test-oracle-for-agents.md) |
| **Git as hands-off coordination** | Recoverable history, visible progress from phone, loss protection across allocations | — |
| **Execution loop** | tmux on a SLURM allocation, attached from anywhere — or a local Claude Code SSHing into the cluster | — |

Mishra-Sharma explicitly recommends **iterating on the plan locally first** — several passes until `CLAUDE.md` looks reasonable — before launching any long-running session. The upfront investment in a clean plan is where most of the user's effort goes in this posture.

The git history of a well-run project reads, in his words, "like lab notes from a fast, hyper-literal postdoc."

## AutoResearch maps onto the same scaffolding

| Piece | CLAX / compiler | AutoResearch |
|---|---|---|
| Portable plan | `CLAUDE.md` (agent-editable) | `program.md` (**human-only**) |
| Cross-session memory | `CHANGELOG.md` with failed approaches | `results.tsv` + git history |
| Test oracle | Reference implementation (CLASS, test suites) | Immutable `prepare.py` emitting `val_bpb` |
| Git coordination | Commit after every meaningful unit | Commit per 5-min experiment; revert on regression |
| Execution loop | tmux on SLURM | Coding agent in project directory |
| Anti-laziness scaffold | [ralph-loop](ralph-loop.md) | `"NEVER STOP"` directive |

Two notable tightenings in AutoResearch:

1. **`program.md` is human-only.** Karpathy wants research direction to be a fixed point rather than something the agent can drift. Cost: the human must get it right upfront.
2. **Filter is stricter.** CLAX tolerates intermediate failing states as long as tests eventually pass; AutoResearch runs a strict monotone ratchet. That's what lets Karpathy run it overnight unsupervised — and what creates the [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md).

## Ralph loop as optional capability uplift

The [ralph-loop](ralph-loop.md) is a `for`-loop scaffold that kicks the agent back into context when it claims completion, counteracting [agentic-laziness](agentic-laziness.md). Mishra-Sharma treats it as capability scaffolding that will become unnecessary as models improve, but useful at current capability.

## Why this matters

In the old posture, the scaling bottleneck was human attention — every step needed a reviewer. In this posture, the bottleneck shifts to **how well you front-load the plan, memory, and oracle**. If those three are set up properly, agent work runs overnight, over weekends, over multi-day compute allocations, at the same marginal human cost as kicking off a training run.

Mishra-Sharma: *"These days, not running agents feels like it has a cost as well. Every night you don't have agents working for you is potential progress left on the table."* The opportunity cost of idle compute has extended to idle agentic capacity.

## Relationship to other wiki patterns

- **Sibling to [llm-knowledge-bases](llm-knowledge-bases.md).** Same architecture in a different domain: LLM as long-running producer of structured, on-disk artifacts with an evaluation loop. Karpathy's wiki artifacts are Markdown pages evaluated by lint passes; Mishra-Sharma's artifacts are code + tests + commits evaluated by numerical accuracy. Both are [file-over-app-philosophy](file-over-app-philosophy.md) instances.
- **Adjacent to [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md).** AlphaEvolve evolves a population in parallel; long-running agentic coding is typically a single sequential agent tracing causally through a coupled pipeline. Different topologies, shared core idea.
- **Contributes to [own-your-substrate](../analyses/own-your-substrate.md).** The `CLAUDE.md` + `CHANGELOG.md` + git artifacts stay on the researcher's disk. Accumulated understanding + working code is the compounding asset.

## Open questions

- How far does this generalize outside code? The scaffolding looks applicable to writing, research notes, analysis pipelines — but only the code case is validated.
- When does Ralph become obsolete? How much model progress until agentic laziness disappears?
- What breaks at multi-week or multi-month sequential horizons?

## Related

- **Scaffolding pieces:** [agent-persistent-memory](agent-persistent-memory.md) · [test-oracle-for-agents](test-oracle-for-agents.md) · [ralph-loop](ralph-loop.md)
- **Failure modes:** [agentic-laziness](agentic-laziness.md) · [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md)
- **Canonical instances:** [clax-project](../entities/clax-project.md) · [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md) · [autoresearch](../entities/autoresearch.md)
- **Siblings:** [agent-driven-scientific-computing](agent-driven-scientific-computing.md) · [llm-knowledge-bases](llm-knowledge-bases.md) · [file-over-app-philosophy](file-over-app-philosophy.md)
- **Author:** [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md)
- **Sources:** [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md) · [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)
