---
title: "CLAX (differentiable JAX Boltzmann solver)"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [software, cosmology, jax, differentiable-programming, agent-built, scientific-computing]
status: active
---

# CLAX

Open-source project at [github.com/smsharma/clax](https://github.com/smsharma/clax). A **differentiable** reimplementation in JAX of a cosmological Boltzmann solver, built from scratch over a few days by Claude Opus 4.6 working autonomously in a long-running agentic coding loop, with [[entities/siddharth-mishra-sharma]] as the human steering the project (Source: [[sources/2026-04-04-anthropic-long-running-claude-scientific-computing]]).

## What it does

CLAX evolves the coupled equations for photons, baryons, neutrinos, and dark matter through the early universe to predict statistical properties of the Cosmic Microwave Background — specifically, the various CMB angular power spectra that cosmology surveys fit their models against. The reference implementation it tracks is [[entities/class-boltzmann-solver]] (CLASS), one of the two canonical Boltzmann codes in cosmology (the other being CAMB).

The differentiability matters because **gradient-based inference methods are dramatically faster than gradient-free ones** for parameter estimation. Writing in JAX gives automatic differentiation and GPU compatibility essentially for free. Groups with deep domain expertise have previously built differentiable JAX Boltzmann solvers (e.g., arXiv:2311.03291 and arXiv:2602.15104), but those efforts implemented subsets of CLASS's features and typically took researcher-months to researcher-years.

## How it was built

The scaffolding is the core of the story, not the output. Mishra-Sharma set up:

- **`CLAUDE.md`** encoding the high-level plan: full feature-parity with CLASS, fully differentiable, **0.1% accuracy target** against CLASS on the main science deliverables (chosen because 0.1% is the typical CLASS↔CAMB agreement level). See [[concepts/long-running-agentic-coding]].
- **`CHANGELOG.md`** as the agent's long-term memory across sessions — tracking status, completed tasks, failed approaches with reasons, accuracy checkpoints, known limitations. See [[concepts/agent-persistent-memory]].
- **The CLASS C source as a test oracle** — Claude was instructed to build and continuously run unit tests against CLASS as the reference. See [[concepts/test-oracle-for-agents]].
- **Git commits** after every meaningful unit of work, with `pytest` gating every commit. See the [CLAX commit log](https://github.com/smsharma/clax/commits/main/) — which Mishra-Sharma describes as reading "like lab notes from a fast, hyper-literal postdoc."
- **tmux sessions on a SLURM-scheduled HPC node** (one H100 GPU, 48-hour wall time) running Claude Code, which the user attached to periodically.
- **The Ralph loop** for final-mile accuracy convergence. See [[concepts/ralph-loop]].

The task shape — a deeply coupled pipeline where small early errors propagate downstream — meant a **single sequential agent** spawning subagents as needed was the right topology. This is structurally unlike Anthropic's [[entities/anthropic-c-compiler-project]], which parallelized across ~2,000 sessions.

## Result

Claude reached **sub-percent agreement with CLASS across the main CMB angular power spectra**. Notes from the post:

- The resulting solver **is not production-grade**. It does not match CLASS in every regime, so it won't replace CLASS or CAMB in a survey pipeline.
- The development trajectory was **clunky**. For a stretch, tests covered only a single fiducial parameter point, drastically reducing bug-catching surface area. Claude made elementary domain mistakes — gauge-convention slips, hours chasing bugs a cosmologist would spot instantly.
- Progress was nonetheless **sustained and monotonic** toward the 0.1% target.
- **Side benefit**: Mishra-Sharma learned cosmology he didn't previously know by following the commit history — an unplanned pedagogical dividend of the agent-built artifact.

## Significance

CLAX is the wiki's first concrete instance of [[concepts/agent-driven-scientific-computing]] — a scientific codebase in an adjacent domain, built under autonomous agent control, reaching a meaningful accuracy target against a gold-standard reference. It also participates in the broader wiki theme of [[concepts/long-running-agentic-coding]] as an architectural pattern, and contributes a fourth data point to the "LLM as active producer of structured artifacts with a filter loop" pattern analysed in [[analyses/own-your-substrate]].

## Related

- [[entities/siddharth-mishra-sharma]]
- [[entities/class-boltzmann-solver]]
- [[entities/anthropic-c-compiler-project]]
- [[concepts/long-running-agentic-coding]]
- [[concepts/test-oracle-for-agents]]
- [[concepts/agent-persistent-memory]]
- [[concepts/ralph-loop]]
- [[concepts/agent-driven-scientific-computing]]
- [[sources/2026-04-04-anthropic-long-running-claude-scientific-computing]]
