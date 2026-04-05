---
title: "Long-running agentic coding"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources:
  - "wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"
  - "wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"
tags: [agentic-coding, long-horizon-tasks, claude-code, methodology, scientific-computing, hpc, autoresearch, karpathy]
status: active
---

# Long-running agentic coding

A methodology for handing an LLM coding agent a well-scoped, multi-day, high-stakes software task and letting it work **autonomously** — with occasional human oversight rather than continuous supervision. It is a distinct posture from the dominant "conversational loop, every step on a tight leash" mode most scientists and engineers currently use with AI agents. The shift is enabled by the steady extension of model time-horizons over 2024–2026.

The pattern is demonstrated across three instances currently in this wiki:

- The [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md) — Claude building a Linux-kernel-capable C compiler across ~2,000 sessions (parallel-swarm topology).
- The [clax-project](../entities/clax-project.md) — [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md)'s single-agent sequential JAX port of the [class-boltzmann-solver](../entities/class-boltzmann-solver.md), reaching sub-percent accuracy in days (Source: [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)).
- [autoresearch](../entities/autoresearch.md) — [andrej-karpathy](../entities/andrej-karpathy.md)'s overnight ML-experiment loop, using the [ratchet-loop](ratchet-loop.md) pattern with `program.md` + `train.py` + an immutable `prepare.py` evaluator (Source: [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)).

The three instances share the scaffolding pieces below but vary in topology (swarm vs. solo), filter strictness (test oracle vs. monotone ratchet), and session length (minutes to weeks).

## When it fits

Three conditions, which together make autonomous operation viable:

1. **The work is well-scoped.** A clear deliverable exists. "Build a differentiable JAX port of CLASS with feature parity" is scoped; "do cosmology research" is not.
2. **Success criteria are quantifiable.** Reaching them can be measured mechanically, not judged. 0.1% numerical agreement against a reference. Passing a test suite. Compiling a target codebase. See [test-oracle-for-agents](test-oracle-for-agents.md).
3. **Human oversight can be occasional.** The work doesn't need a human in the loop continuously because the evaluation loop catches most errors without one.

Mishra-Sharma gives three representative task types that fit: reimplementing a numerical solver, porting legacy Fortran to a modern language, and debugging a large codebase against a reference implementation. The common thread: a trustworthy oracle exists to tell the agent whether it's making progress. AutoResearch adds a fourth: **improving a training loop against a fixed validation metric** — the same "trustworthy oracle" criterion, with the oracle's immutability enforced at the filesystem level (an untouchable `prepare.py`).

## The scaffolding (five pieces)

Each piece corresponds to a separate concept or sub-mechanism. Together they define the pattern.

### 1. `CLAUDE.md` — the portable plan

The user (in consultation with Claude) drafts a file at the project root encoding:

- project goals and deliverables
- key design decisions
- accuracy or success targets
- rules of engagement (commit cadence, test gating, style choices)

Claude Code treats `CLAUDE.md` specially, keeping it in context for every session and referencing it for the overall plan. Crucially, **Claude is permitted to edit `CLAUDE.md` as it works** — codifying design decisions discovered during implementation, recording new constraints, correcting earlier assumptions. The file is a living spec, not a frozen requirements document.

Mishra-Sharma explicitly recommends **iterating on the plan locally first** — several passes with Claude until the plan looks reasonable — before ever launching the first long-running session. The upfront investment in a clean `CLAUDE.md` is where most of the user's effort goes in this new posture.

### 2. `CHANGELOG.md` — cross-session memory

A separate progress file serving as the agent's **long-term memory across sessions**. See [agent-persistent-memory](agent-persistent-memory.md) for the dedicated page. Tracks current status, completed tasks, **failed approaches with reasons**, accuracy checkpoints, and known limitations. Failed approaches are load-bearing: without them successive sessions re-attempt the same dead ends.

### 3. The test oracle

The single most important enabling condition. See [test-oracle-for-agents](test-oracle-for-agents.md) for the dedicated page. For scientific code this is a reference implementation, a clearly quantifiable objective, or an existing test suite. The agent is instructed to build and **continuously run** tests against the oracle, and to expand the test suite as it works.

### 4. Git as hands-off coordination

The agent commits and pushes after every meaningful unit of work. This gives:

- a **recoverable history** if something goes awry
- **visible progress** the user can watch from anywhere (Mishra-Sharma checked GitHub commit feeds on his phone in line for coffee)
- **loss protection** against compute-allocation expiration mid-session

Enforced via `CLAUDE.md` rules such as: *"Commit and push after every meaningful unit of work. Run `pytest tests/ -x -q` before every commit. Never commit code that breaks existing passing tests."* The git history of a well-run long-running agent project reads, in Mishra-Sharma's words, "like lab notes from a fast, hyper-literal postdoc."

### 5. The execution loop

On an HPC cluster: a SLURM job requests a compute node (e.g. one H100, 48-hour wall), the job script launches Claude Code inside a detached **tmux** session, the user attaches via `srun --overlap --pty tmux attach -t claude`, gives direction ("Read `CHANGELOG.md` and pick up the next task"), and detaches. A **local** Claude Code instance can also SSH into the cluster to re-prompt the remote agent, which Mishra-Sharma notes is typically more ergonomic than direct shell attachment.

The HPC/SLURM specifics are not load-bearing — the same pattern applies on any environment where a detached process can run for hours. But tmux on an allocated GPU node is a clean instantiation that researchers already know how to reason about.

## How AutoResearch maps onto the scaffolding

AutoResearch is a minimal instance of the pattern — deliberately stripped down for single-GPU overnight operation — but every piece of the scaffolding has a direct analog:

| Piece | In CLAX / the compiler project | In AutoResearch |
|---|---|---|
| Portable plan | `CLAUDE.md` (agent-editable) | `program.md` (human-only) |
| Cross-session memory | `CHANGELOG.md` with failed approaches | `results.tsv` + git history |
| Test oracle | Reference implementation (CLASS, test suites) | Immutable `prepare.py` emitting `val_bpb` |
| Git as coordination | Commit after every meaningful unit of work | Commit after every 5-minute experiment; revert on regression |
| Execution loop | tmux-on-SLURM detached session | Coding agent in the project directory |
| Anti-laziness scaffold | [ralph-loop](ralph-loop.md) | `"NEVER STOP"` directive in `program.md` |

Two things are notable about the AutoResearch mapping:

1. **`program.md` is human-only**, unlike the CLAX `CLAUDE.md` which the agent is allowed to edit. This is a deliberate tightening: Karpathy wants the research direction to be a fixed point of the loop rather than something the agent can drift. The tradeoff: the human must write a better `program.md` upfront, since the agent cannot correct it mid-run.
2. **The filter is stricter.** CLAX tolerates any intermediate state as long as tests eventually pass; AutoResearch runs a strict monotone [ratchet-loop](ratchet-loop.md) where each experiment is either committed or reverted. This is what lets Karpathy run it overnight without a supervisor — the filter leaves no room for the agent to accumulate regressions — but it also creates the [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md).

## The Ralph loop (optional capability uplift)

See [ralph-loop](ralph-loop.md). A `for`-loop scaffold that kicks the agent back into context whenever it claims completion, counteracting [agentic-laziness](agentic-laziness.md) — the failure mode where current models stop early on complex multi-part tasks. Mishra-Sharma treats it as capability scaffolding that will become unnecessary as models improve, but useful at current model capability.

## Why this matters

In the old posture, the scaling bottleneck was human attention — every agent step needed a human reviewer. In this posture, the bottleneck shifts to **how well you front-load the plan, memory, and oracle**. If those three are set up properly, agent work can run overnight, over weekends, or over multi-day compute allocations with the same marginal human effort as kicking off a long training run.

Mishra-Sharma's closing claim follows from this: *"These days, not running agents feels like it has a cost as well. Every night you don't have agents working for you is potential progress left on the table."* The analogy is to the universal ML-research experience of launching training runs overnight. The opportunity cost of idle compute has extended to idle agentic capacity.

## Relationship to other patterns in the wiki

- **Sibling to [llm-knowledge-bases](llm-knowledge-bases.md).** The Karpathy pattern is the same underlying architecture in a different domain: LLM as long-running producer of structured, on-disk artifacts, with a filter/evaluation loop deciding what survives. Karpathy's artifacts are Markdown wiki pages, evaluated by lint passes. Mishra-Sharma's artifacts are code + tests + commits, evaluated by numerical accuracy against a reference. Both are [file-over-app-philosophy](file-over-app-philosophy.md) instances.
- **Related to [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md).** AlphaEvolve is the adjacent pattern of LLMs producing code artifacts with an evaluation loop — but AlphaEvolve evolves a population in parallel, while long-running agentic coding is typically a single sequential agent tracing causally through a coupled pipeline. Different topologies, shared core idea.
- **Contributing instance to [own-your-substrate](../analyses/own-your-substrate.md).** The `CLAUDE.md` + `CHANGELOG.md` + git artifacts live on the researcher's disk / forge. The compounding asset (accumulated understanding + working code) stays local.

## Open questions

- How far does this generalize outside code? `CLAUDE.md`-like plan files, `CHANGELOG.md`-like memory files, and filter-loop oracles seem applicable to non-code tasks (writing, research notes, analysis pipelines), but the scientific-computing post only validates the code case.
- At what point does the Ralph loop become obsolete? Mishra-Sharma treats it as a capability-uplift scaffold; how much model progress is needed before agentic laziness disappears on its own?
- What breaks at the multi-week or multi-month horizon? CLAX is a few days of wall time. The compiler project is longer but parallelized. There may be failure modes that only appear at longer sequential horizons.

## Related

- [agent-persistent-memory](agent-persistent-memory.md)
- [test-oracle-for-agents](test-oracle-for-agents.md)
- [ralph-loop](ralph-loop.md)
- [agentic-laziness](agentic-laziness.md)
- [agent-driven-scientific-computing](agent-driven-scientific-computing.md)
- [llm-knowledge-bases](llm-knowledge-bases.md)
- [file-over-app-philosophy](file-over-app-philosophy.md)
- [clax-project](../entities/clax-project.md)
- [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md)
- [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md)
- [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
