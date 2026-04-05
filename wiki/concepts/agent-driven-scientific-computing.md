---
title: "Agent-driven scientific computing"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [scientific-computing, agentic-coding, research-methodology, hpc, cross-domain]
status: active
---

# Agent-driven scientific computing

> **Applying [long-running-agentic-coding](long-running-agentic-coding.md) to scientific-computing tasks: reimplementing numerical solvers, porting legacy software, building differentiable versions of existing models, debugging against reference implementations.** [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md)'s April 2026 thesis: this class of task fits the autonomous-agent posture unusually well because it satisfies all three enabling conditions simultaneously — well-scoped deliverables, quantifiable success criteria, tolerance for occasional oversight.

## Why scientific code fits

| Feature | Why it helps |
|---|---|
| **Reference implementations exist** | Canonical codebases serve as natural [test-oracle-for-agents](test-oracle-for-agents.md): CLASS (CMB cosmology), LAMMPS (MD), CASTEP/VASP (DFT), NCBI BLAST (sequence alignment) |
| **Success is quantifiable** | Numerical agreement vs reference, known benchmark suites, reproducing published results — no judgment calls |
| **Tedious but tractable** | Porting, debugging, reimplementing: sustained mechanical work against a reference. Agent time cheaper than researcher time for this shape |

## The striking claim: non-experts can drive it

The CLAX experiment tests this directly. Mishra-Sharma is explicit that cosmological Boltzmann solvers are **not his core domain** — high-level familiarity but not depth to implement one solo. The question: can an agent with correct scaffolding take a non-expert further than domain experts have gone solo, in a fraction of the time?

**CLAX answer: partial yes.** Sub-percent accuracy against CLASS across main CMB outputs in a few days; domain-expert groups building differentiable JAX Boltzmann solvers have typically invested months-to-years. Not production-grade, but compresses a multi-year effort into a few days of compute.

**Potential implication:** the bottleneck on cross-disciplinary scientific software shifts from *"enough domain expertise to write the code"* to *"enough domain literacy to set up the scaffolding."* The first is rare; the second is common. If it holds, scientific fields cross-pollinate implementations much faster — differentiable versions, GPU ports, Python wrappers — all become feasible for *adjacent* researchers, not just insiders.

## What it actually looks like in practice

Mishra-Sharma is candid about the clunky trajectory:

- **Test coverage was initially too narrow** — only a single fiducial parameter point for a stretch. Rookie mistake that a reviewer would catch; cautionary tale about narrow oracles letting the agent coast on false confidence.
- **Elementary domain mistakes happen.** Gauge-convention slips, hours on bugs a cosmologist would spot instantly. No domain priors.
- **Progress is clunky but sustained.** Accuracy trajectory is monotonic toward target despite inefficient individual steps — persistent memory + oracle + occasional human steering hold it together.
- **Artifact is a demo, not a production replacement.** CLAX doesn't match CLASS everywhere.

## The unplanned pedagogical dividend

A **second-order benefit**: following the agent's git commit history was an effective way to **learn the science**. Commits "read like lab notes from a fast, hyper-literal postdoc." Mishra-Sharma learned a surprising amount of cosmology this way. Suggests agent-driven scientific computing doubles as **a self-paced curriculum for a researcher entering an adjacent field** — code + commits + `CHANGELOG.md` are a readable record of what matters, in the order it matters, with dead ends visible. Better than most textbooks.

## Limits

- **Open-ended discovery is still out of scope.** Without an oracle, the methodology doesn't hold.
- **Production quality is not yet here.** Replacing CLASS in survey pipelines or LAMMPS in materials labs needs robustness current agents don't reliably deliver.
- **Domain priors still matter for efficiency.** Expert-steered agents catch errors sooner; non-expert-driven agents waste compute.
- **Parallelism frontier is uneven.** Some codebases decompose cleanly (parsers, per-test), others are deeply coupled. [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md) used ~2,000 parallel sessions; CLAX used one sequential agent. **Shape of codebase determines topology of deployment.**

## Relationship to other wiki themes

- **Domain specialization** of [long-running-agentic-coding](long-running-agentic-coding.md).
- **Reinforces [own-your-substrate](../analyses/own-your-substrate.md)** — researcher owns codebase, HPC, git, accumulated understanding.
- **Adjacent to but distinct from [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md).** AlphaEvolve evolves new algorithms; agent-driven scientific computing typically reimplements existing ones. Beats-SoTA vs matches-SoTA-in-a-new-substrate. The latter is much easier structurally.

## Related

- **Hub:** [long-running-agentic-coding](long-running-agentic-coding.md)
- **Scaffolding:** [test-oracle-for-agents](test-oracle-for-agents.md) · [agent-persistent-memory](agent-persistent-memory.md) · [ralph-loop](ralph-loop.md)
- **Canonical case:** [clax-project](../entities/clax-project.md) · [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md) · [class-boltzmann-solver](../entities/class-boltzmann-solver.md)
- **Contrast topology:** [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md)
- **Adjacent:** [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md) · [own-your-substrate](../analyses/own-your-substrate.md)
- **Source:** [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
