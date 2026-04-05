---
title: "Long-running Claude for scientific computing (Mishra-Sharma, Anthropic)"
type: source
created: 2026-04-04
updated: 2026-04-04
sources: ["raw/long-running-claude-for-scientific-computing.md"]
tags: [anthropic, claude-code, agentic-coding, long-horizon-tasks, scientific-computing, hpc, cosmology, methodology]
status: active
---

# Long-running Claude for scientific computing

Anthropic post by [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md), a researcher on Anthropic's Discovery team. The post describes how to apply multi-day, autonomous agentic coding workflows — the same family of patterns that produced Anthropic's [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md) — to scientific computing tasks, even outside one's domain of expertise. The concrete walkthrough is [clax-project](../entities/clax-project.md): a differentiable JAX reimplementation of a cosmological Boltzmann solver, built by Claude Opus 4.6 against the [class-boltzmann-solver](../entities/class-boltzmann-solver.md) C reference. (Source: raw/long-running-claude-for-scientific-computing.md)

## The shift being described

Most scientists currently use AI agents on a tight leash — one step at a time in a conversational loop. Mishra-Sharma argues that as model time-horizons have extended (he cites METR's time-horizon benchmarks), a different posture becomes viable: specify a high-level objective, install the right scaffolding, and let a team of agents run autonomously for hours or days. Tasks that fit this model share three traits:

1. The work is **well-scoped**.
2. Success criteria are **clearly quantifiable**.
3. Human oversight can be **occasional rather than continuous**.

Examples he gives: reimplementing a numerical solver, porting legacy Fortran to a modern language, debugging a large codebase against a reference implementation. See [long-running-agentic-coding](../concepts/long-running-agentic-coding.md) for the generalized pattern and [agent-driven-scientific-computing](../concepts/agent-driven-scientific-computing.md) for the domain-specific instance.

## The scientific task

The running example is a reimplementation of a cosmological Boltzmann solver in JAX. Boltzmann solvers (canonically [class-boltzmann-solver](../entities/class-boltzmann-solver.md) and CAMB) predict the statistical properties of the Cosmic Microwave Background by evolving coupled equations for photons, baryons, neutrinos, and dark matter through the early universe. They are core infrastructure in cosmology, used to fit models against data from surveys like *Planck* and the *Simons Observatory*.

A **differentiable** version matters because gradient-based inference methods are dramatically faster than gradient-free ones. JAX gives automatic differentiation and GPU compatibility essentially for free.

Mishra-Sharma is explicit that the task is **outside his core scientific domain**: "I have a high-level familiarity with the tools and the science, but don't have the expertise to complete it myself in any reasonable time frame." Domain-expert groups who have built differentiable JAX Boltzmann solvers with a subset of CLASS's features report that those efforts took months to years. The experiment was whether an agent could go further with minimal steering from a non-expert.

He also notes a structural contrast with the C compiler project: the compiler work **parallelized** across ~2,000 mostly independent sessions. A Boltzmann solver is a **deeply coupled pipeline** where a small numerical error early (e.g., in recombination modeling) subtly shifts everything downstream. It needs a single sequential agent that can trace causally through the chain, spawning subagents as needed, and bisect against the reference implementation. Different task shapes call for different agent topologies.

## The scaffolding (the core of the post)

Five pieces, each of which maps to a concept page:

1. **`CLAUDE.md` as the portable plan.** The user (in consultation with Claude) drafts a file containing project goals, design decisions, accuracy targets, and rules of engagement. Claude treats this file specially, keeps it in context, and is permitted to **edit it as work progresses**. The CLAX project's [early CLAUDE.md](https://github.com/smsharma/clax/blob/6a6b2330cf25edded1bb31ec57a0091aa794a5d3/CLAUDE.md) is linked as a concrete example. Mishra-Sharma's explicit target was 0.1% accuracy against CLASS on the main science deliverables — matching the typical CLASS↔CAMB agreement level. See [long-running-agentic-coding](../concepts/long-running-agentic-coding.md).

2. **`CHANGELOG.md` as portable long-term memory.** A progress file that tracks current status, completed tasks, **failed approaches and why they didn't work**, accuracy tables at key checkpoints, and known limitations. The failed approaches are load-bearing: without them, successive sessions re-attempt the same dead ends. The example entry: *"Tried using Tsit5 for the perturbation ODE, system is too stiff. Switched to Kvaerno5."* See [agent-persistent-memory](../concepts/agent-persistent-memory.md).

3. **The test oracle.** The single most important enabling condition. For scientific code this can be a reference implementation, a quantifiable objective, or an existing test suite. In CLAX's case it was CLASS's C source — Claude was instructed to construct unit tests against the reference and run them continuously. See [test-oracle-for-agents](../concepts/test-oracle-for-agents.md).

4. **Git as hands-off coordination.** The agent commits and pushes after every meaningful unit of work. This provides recoverable history, visible progress (Mishra-Sharma checked on the GitHub commit feed from his phone in line for coffee), and loss protection if compute allocations expire mid-session. Enforced via a CLAUDE.md rule: commit/push after each unit, run `pytest tests/ -x -q` before every commit, never commit code that breaks passing tests.

5. **The execution loop on HPC.** SLURM job → GPU node → tmux session → Claude Code inside. A typical SLURM script (48h wall, one H100) launches a detached tmux session, and the user attaches with `srun --jobid=... --overlap --pty tmux attach -t claude`, gives Claude a direction ("Read CHANGELOG.md and pick up the next task"), and detaches. A local Claude Code instance can SSH into the cluster to re-prompt as a more ergonomic alternative.

## The Ralph loop

A named orchestration pattern to combat [agentic-laziness](../concepts/agentic-laziness.md) — the failure mode where current models, asked to complete a complex multi-part task, find an excuse to stop early ("It's getting late, let's pick back up again tomorrow?"). The [ralph-loop](../concepts/ralph-loop.md) is essentially a `for` loop that kicks the agent back into context when it claims completion and asks if it's *really* done. Analogous patterns cited: GSD ("get-shit-done"), physics-specific GSD variants, and the native `/loop` command in Claude Code.

A typical invocation in Claude Code:

```
/ralph-loop:ralph-loop "Please keep working on the task until the success criterion
of 0.1% accuracy across the entire parameter range is achieved."
--max-iterations 20 --completion-promise "DONE"
```

The loop runs up to 20 times until the agent guarantees completion with the "DONE" incantation.

## The result

Claude worked on CLAX from scratch over a few days, reaching **sub-percent agreement with CLASS across the main CMB angular power spectra**. Mishra-Sharma asked Claude to reconstruct the accuracy trajectory over the course of development (with milestone labels) and produced a plot showing the path to sub-percent accuracy.

Candid observations about the trajectory:

- **Test coverage was initially too narrow.** For a while Claude was only testing at a single fiducial parameter point, drastically reducing bug-catching surface area. A seasoned developer (or a reviewer) would have caught this earlier.
- **Elementary domain mistakes happened.** Tripping over gauge conventions, spending hours chasing bugs "a cosmologist would spot instantly."
- **Progress was sustained anyway.** Despite the clunkiness, the accuracy trajectory monotonically improved toward the stated target.
- **Not production-grade.** The resulting solver does not match CLASS in every regime; it is a demonstration rather than a deliverable for replacing CLASS/CAMB in a survey pipeline.

## The side effect Mishra-Sharma flags as important

> A side effect of the project was that I learned a surprising amount about Boltzmann solvers and the physics they model by watching the git commit history.

The commit log "reads like lab notes from a fast, hyper-literal postdoc." Following the agent's incremental progress and looking up unfamiliar terms turned out to be an effective **onboarding mechanism** into an adjacent scientific domain. The knowledge artifact the agent leaves behind (code + commits + CHANGELOG.md) doubles as a self-paced curriculum for a non-expert. This is a second-order benefit that isn't the same as the speed-up but may matter more for cross-disciplinary work.

## The closing frame

> These days, not running agents feels like it has a cost as well. If you have the compute and projects with well-defined success criteria, every night you *don't* have agents working for you is potential progress left on the table.

He draws the analogy to the universal AI-research experience of launching an experiment overnight. Idle researcher-time during off-hours now carries the same opportunity cost, provided the task shape fits.

## Why this matters for the wiki

Several cross-cutting connections are worth making explicit:

- **Fourth instance of the "LLM as active producer of structured artifacts with a filter loop" theme.** Earlier instances: [llm-knowledge-bases](../concepts/llm-knowledge-bases.md) (wiki pages, linting as filter), [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md) (AlphaEvolve, exploitability as filter), [ai-novel-factory](../concepts/ai-novel-factory.md) (novel drafts, author revision + Amazon reviews as filter). CLAX is a fourth: JAX code, numerical accuracy against CLASS as filter. In every case the LLM writes a durable artifact and a quantifiable evaluation loop decides what survives. The [test-oracle-for-agents](../concepts/test-oracle-for-agents.md) concept page frames this generically.
- **Another instance of [file-over-app-philosophy](../concepts/file-over-app-philosophy.md).** `CLAUDE.md`, `CHANGELOG.md`, git-tracked source, SLURM scripts — the entire orchestration lives as plain files on disk. No SaaS knowledge base, no hosted agent service, no vendor coupling. The pattern is legible and portable because everything is a file.
- **A direct methodological sibling to [llm-knowledge-bases](../concepts/llm-knowledge-bases.md).** Karpathy's pattern is "LLM as librarian over a Markdown corpus." Mishra-Sharma's pattern is "LLM as postdoc over a scientific codebase." Both are long-horizon, both use structured on-disk artifacts as context, both depend critically on a filter loop. They are two application domains of the same underlying architecture.
- **Reinforces the [own-your-substrate](../analyses/own-your-substrate.md) pattern.** The CLAX experiment runs on the researcher's own HPC allocation, the agent's memory lives in files the researcher owns, and the knowledge accumulates in a git history the researcher controls. The compounding layer (accumulated domain understanding + working codebase) stays local.

## Related

- [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md)
- [clax-project](../entities/clax-project.md)
- [class-boltzmann-solver](../entities/class-boltzmann-solver.md)
- [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md)
- [anthropic](../entities/anthropic.md)
- [long-running-agentic-coding](../concepts/long-running-agentic-coding.md)
- [test-oracle-for-agents](../concepts/test-oracle-for-agents.md)
- [agent-persistent-memory](../concepts/agent-persistent-memory.md)
- [ralph-loop](../concepts/ralph-loop.md)
- [agentic-laziness](../concepts/agentic-laziness.md)
- [agent-driven-scientific-computing](../concepts/agent-driven-scientific-computing.md)
- [file-over-app-philosophy](../concepts/file-over-app-philosophy.md)
- [own-your-substrate](../analyses/own-your-substrate.md)

## Prompt that produced this page

> ingest raw/long-running-claude-for-scientific-computing
