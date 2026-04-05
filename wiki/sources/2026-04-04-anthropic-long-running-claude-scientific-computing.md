---
title: "Long-running Claude for scientific computing (Mishra-Sharma, Anthropic)"
type: source
created: 2026-04-04
updated: 2026-04-05
sources: ["raw/long-running-claude-for-scientific-computing.md"]
tags: [anthropic, claude-code, agentic-coding, long-horizon-tasks, scientific-computing, hpc, cosmology, methodology]
status: active
---

# Long-running Claude for scientific computing

> **An Anthropic post by [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md) arguing that extended model time-horizons have made *occasional-oversight* agentic coding viable for scientific computing — demonstrated on [clax-project](../entities/clax-project.md), a differentiable JAX reimplementation of [class-boltzmann-solver](../entities/class-boltzmann-solver.md) built by Claude Opus 4.6 against the C reference.**

## The shift being described

Most scientists currently use AI agents on a tight leash — one step at a time. Mishra-Sharma argues a different posture is viable when three conditions hold:

1. Work is **well-scoped** (clear deliverable).
2. Success criteria are **clearly quantifiable**.
3. Human oversight can be **occasional rather than continuous**.

Fitting task types: reimplementing numerical solvers, porting legacy Fortran, debugging a large codebase against a reference. See [long-running-agentic-coding](../concepts/long-running-agentic-coding.md) and [agent-driven-scientific-computing](../concepts/agent-driven-scientific-computing.md).

## The scientific task

A differentiable JAX Boltzmann solver. Boltzmann solvers (CLASS, CAMB) predict CMB statistics by evolving coupled equations for photons, baryons, neutrinos, and dark matter. Differentiability enables gradient-based inference, dramatically faster than gradient-free methods.

Mishra-Sharma is explicit the task is **outside his core domain**. Domain-expert groups who have built comparable differentiable JAX solvers report months-to-years efforts. The experiment was whether an agent could go further with minimal steering from a non-expert.

**Topology contrast with the C compiler project:** the compiler work parallelized across ~2,000 mostly independent sessions. A Boltzmann solver is a **deeply coupled pipeline** — a small numerical error early (e.g., recombination) shifts everything downstream. It needs a single sequential agent that can bisect causally against the reference.

## The scaffolding (five pieces)

| Piece | Role | Concept page |
|---|---|---|
| **`CLAUDE.md`** — portable plan | Goals, design decisions, 0.1% accuracy target, rules of engagement. Agent-editable living spec | [long-running-agentic-coding](../concepts/long-running-agentic-coding.md) |
| **`CHANGELOG.md`** — persistent memory | Status, completed tasks, **failed approaches with reasons**, accuracy checkpoints | [agent-persistent-memory](../concepts/agent-persistent-memory.md) |
| **Test oracle** | Reference implementation (CLASS C source) with unit tests run continuously | [test-oracle-for-agents](../concepts/test-oracle-for-agents.md) |
| **Git as coordination** | Recoverable history, phone-visible progress, crash-resistant across allocations | — |
| **Execution loop** | SLURM → GPU node → tmux → Claude Code, attached via `srun --overlap --pty` | — |

## The Ralph loop

A named pattern countering [agentic-laziness](../concepts/agentic-laziness.md) — a `for`-loop that kicks the agent back into context when it claims completion. See [ralph-loop](../concepts/ralph-loop.md). Typical invocation:

```
/ralph-loop:ralph-loop "Work until 0.1% accuracy across the entire parameter range"
--max-iterations 20 --completion-promise "DONE"
```

## Result and candid limits

Claude reached **sub-percent agreement with CLASS across the main CMB angular power spectra** over a few days. Candid observations: initially too-narrow test coverage (single fiducial point), elementary domain mistakes ("a cosmologist would spot instantly"), monotone trajectory anyway, but **not production-grade** — a demonstration, not a CLASS/CAMB replacement.

## The side effect

> *"A side effect of the project was that I learned a surprising amount about Boltzmann solvers and the physics they model by watching the git commit history."*

The commit log reads "like lab notes from a fast, hyper-literal postdoc." The artifact the agent leaves behind doubles as a self-paced curriculum for a non-expert — a second-order benefit that may matter more than the raw speedup for cross-disciplinary work.

## Closing frame

> *"These days, not running agents feels like it has a cost as well. Every night you don't have agents working for you is potential progress left on the table."*

The universal ML experience of launching a training run overnight, now extended to agentic capacity.

## Cross-wiki threads

- **Fourth instance of the LLM-as-active-producer-with-filter-loop theme.** Alongside [llm-knowledge-bases](../concepts/llm-knowledge-bases.md) (wiki pages, lint filter), [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md) (AlphaEvolve, exploitability filter), [ai-novel-factory](../concepts/ai-novel-factory.md) (novel drafts, Amazon-review filter). See [producer-filter-pattern](../analyses/producer-filter-pattern.md).
- **[file-over-app-philosophy](../concepts/file-over-app-philosophy.md) instance.** The entire orchestration lives as plain files on disk — no SaaS coupling.
- **Reinforces [own-your-substrate](../analyses/own-your-substrate.md).** The compounding layer (domain understanding + working code) stays local.

## Related

- **Author / project:** [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md) · [clax-project](../entities/clax-project.md) · [class-boltzmann-solver](../entities/class-boltzmann-solver.md)
- **Sibling project:** [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md)
- **Concepts:** [long-running-agentic-coding](../concepts/long-running-agentic-coding.md) · [test-oracle-for-agents](../concepts/test-oracle-for-agents.md) · [agent-persistent-memory](../concepts/agent-persistent-memory.md) · [ralph-loop](../concepts/ralph-loop.md) · [agentic-laziness](../concepts/agentic-laziness.md)

## Prompt

> ingest raw/long-running-claude-for-scientific-computing
