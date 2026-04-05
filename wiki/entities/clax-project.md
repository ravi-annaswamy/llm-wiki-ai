---
title: "CLAX (differentiable JAX Boltzmann solver)"
type: entity
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [software, cosmology, jax, differentiable-programming, agent-built, scientific-computing]
status: active
---

# CLAX

> **A differentiable JAX reimplementation of a cosmological Boltzmann solver, built from scratch over a few days by Claude Opus 4.6 in autonomous agentic coding.** [siddharth-mishra-sharma](siddharth-mishra-sharma.md) steered; the agent reached sub-percent agreement with [class-boltzmann-solver](class-boltzmann-solver.md) on main CMB power spectra.

Repo: [github.com/smsharma/clax](https://github.com/smsharma/clax)

## What it does

CLAX evolves coupled equations for photons, baryons, neutrinos, and dark matter through the early universe to predict CMB angular power spectra. Reference: CLASS (one of the two canonical Boltzmann codes alongside CAMB).

**Why differentiable matters.** Gradient-based inference is dramatically faster than gradient-free for parameter estimation. JAX gives autodiff and GPU compatibility for free. Previous differentiable JAX Boltzmann solvers (arXiv:2311.03291, arXiv:2602.15104) took researcher-months to years and implemented subsets.

## Scaffolding (the core of the story)

| Piece | Role |
|---|---|
| `CLAUDE.md` | Portable plan: full feature-parity with CLASS, fully differentiable, **0.1% accuracy target** (typical CLASS↔CAMB agreement). See [long-running-agentic-coding](../concepts/long-running-agentic-coding.md) |
| `CHANGELOG.md` | Cross-session memory: status, completed tasks, failed approaches with reasons, accuracy checkpoints. See [agent-persistent-memory](../concepts/agent-persistent-memory.md) |
| CLASS C source | Test oracle — continuous unit tests against reference. See [test-oracle-for-agents](../concepts/test-oracle-for-agents.md) |
| Git + pytest | Commit after every unit of work, tests gate every commit. Mishra-Sharma: *"reads like lab notes from a fast, hyper-literal postdoc"* |
| tmux on SLURM | One H100, 48h wall time, user attaches periodically |
| [ralph-loop](../concepts/ralph-loop.md) | Final-mile accuracy convergence |

Task shape is a **deeply coupled pipeline** where small early errors propagate downstream — so a single sequential agent (spawning subagents as needed) was the right topology. Structurally unlike [anthropic-c-compiler-project](anthropic-c-compiler-project.md), which parallelized across ~2,000 sessions.

## Result

- **Sub-percent agreement** with CLASS on main CMB angular power spectra.
- **Not production-grade** — won't replace CLASS/CAMB in a survey pipeline.
- Trajectory was **clunky**: for a stretch, tests covered only a single fiducial point. Claude made elementary domain errors (gauge-convention slips, hours on bugs a cosmologist would spot instantly). Progress was nonetheless sustained and monotonic.
- **Pedagogical side-benefit.** Mishra-Sharma learned cosmology he didn't previously know by following the commit history.

## Significance

The wiki's first concrete instance of [agent-driven-scientific-computing](../concepts/agent-driven-scientific-computing.md): a scientific codebase in an adjacent domain, built autonomously, reaching a meaningful target against a gold-standard reference. Also a fourth data point in [producer-filter-pattern](../analyses/producer-filter-pattern.md) — producer = agent diffs, filter = the pytest-against-CLASS oracle.

## Related

- **Parent / sibling:** [siddharth-mishra-sharma](siddharth-mishra-sharma.md) · [anthropic](anthropic.md)
- **Contrast:** [anthropic-c-compiler-project](anthropic-c-compiler-project.md) (swarm topology)
- **Reference:** [class-boltzmann-solver](class-boltzmann-solver.md)
- **Hub concepts:** [long-running-agentic-coding](../concepts/long-running-agentic-coding.md) · [agent-driven-scientific-computing](../concepts/agent-driven-scientific-computing.md)
- **Scaffolding patterns:** [test-oracle-for-agents](../concepts/test-oracle-for-agents.md) · [agent-persistent-memory](../concepts/agent-persistent-memory.md) · [ralph-loop](../concepts/ralph-loop.md)
- **Source:** [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
