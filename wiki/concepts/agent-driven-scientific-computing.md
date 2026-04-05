---
title: "Agent-driven scientific computing"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [scientific-computing, agentic-coding, research-methodology, hpc, cross-domain]
status: active
---

# Agent-driven scientific computing

The application of [long-running-agentic-coding](long-running-agentic-coding.md) to scientific-computing tasks: reimplementing numerical solvers, porting legacy scientific software, building differentiable versions of existing models, debugging large research codebases against reference implementations. The thesis — advanced in the April 2026 Anthropic post by [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md) — is that this class of task **fits the autonomous-agent posture unusually well** because it tends to satisfy all three of the enabling conditions simultaneously: well-scoped deliverables, quantifiable success criteria, and tolerance for occasional rather than continuous human oversight (Source: [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)).

## Why scientific code fits

Three structural features of scientific codebases make them unusually well-suited to long-running agent work:

1. **Reference implementations often exist.** Most mature scientific domains have a canonical codebase (or two) that the community already trusts. These are natural [test-oracle-for-agents](test-oracle-for-agents.md): [class-boltzmann-solver](../entities/class-boltzmann-solver.md) for CMB cosmology, LAMMPS for molecular dynamics, CASTEP or VASP for DFT electronic structure, NCBI BLAST for sequence alignment. An agent building a reimplementation in a new substrate has an immediate ground truth.
2. **Success is quantifiable.** Numerical agreement against a reference at some tolerance, passing a known benchmark suite, reproducing published results — these are unambiguous filters. There is no judgment call about whether the output is "good enough," which eliminates the main reason humans need to stay in the loop.
3. **The tasks are often tedious but tractable.** Porting, debugging, and reimplementing are exactly the kind of work where human researchers would spend weeks or months on what amounts to careful, sustained mechanical effort against a reference. Agent time is much cheaper than researcher time for this specific shape of work.

## The striking claim: non-experts can drive it

The CLAX experiment in the Mishra-Sharma post is structured specifically to test this. He is explicit that cosmological Boltzmann solvers are **not in his core domain** — he has high-level familiarity but not the depth to implement one solo in any reasonable timeframe. The experiment asks: can an agent, with correct scaffolding, take a non-expert further than domain experts have gone solo, in a fraction of the time?

The answer from CLAX: partial yes. The agent reached sub-percent accuracy against CLASS across the main CMB outputs in a few days, where domain-expert groups building differentiable JAX Boltzmann solvers have typically invested months to years. It's not production-grade (it doesn't match CLASS in every regime), but as a demonstration it compresses a multi-year research effort into a few days of compute.

This has a potentially large implication: **the bottleneck on cross-disciplinary scientific software shifts from "enough domain expertise to write the code" to "enough domain literacy to set up the scaffolding."** The first is rare. The second is much more common. If the shift holds, it means scientific fields can cross-pollinate implementations much faster than before — differentiable versions of codes, GPU-ports of legacy Fortran, Python wrappers around C libraries, and so on, all become feasible for researchers adjacent to rather than inside the originating community.

## What agent development actually looks like in practice

Mishra-Sharma is refreshingly candid about the trajectory, which is not smooth:

- **Test coverage was initially too narrow.** Claude was running tests only at a single fiducial parameter point for a while. This is a rookie mistake that a reviewer would catch — and a cautionary tale about how much a narrow oracle can let an agent coast on false confidence.
- **Elementary domain mistakes happen.** Gauge-convention slips, hours chasing bugs a cosmologist would spot instantly. The agent does not have the domain priors a human PhD would.
- **Progress is clunky but sustained.** Despite the above, the accuracy trajectory is monotonic toward the target. The combination of persistent memory ([agent-persistent-memory](agent-persistent-memory.md)), the test oracle, and occasional human steering keeps the project moving even when individual steps are inefficient.
- **The resulting artifact is a research demo, not a production replacement.** CLAX does not match CLASS everywhere. This is a real limitation of current agent-built scientific code.

## The unplanned pedagogical dividend

Mishra-Sharma flags a **second-order benefit** that may matter as much as the speedup itself: following the agent's git commit history was an effective way to **learn the science**. The commits, with their dependence graph of experiments and fixes, "read like lab notes from a fast, hyper-literal postdoc." He learned a surprising amount about Boltzmann solvers and the physics they model this way.

This suggests agent-driven scientific computing has a use case beyond "build the code faster": **it can serve as a self-paced curriculum for a researcher trying to enter an adjacent field.** The code + commits + CHANGELOG.md are a readable record of what matters in the domain, in the order it matters, with the dead ends visible. That's a better introduction than any textbook.

## Limits and open questions

- **Open-ended discovery is still out of scope.** Mishra-Sharma is explicit: long-running autonomous scientific work today depends on the agent having a way to know whether it's making progress. Tasks without a clean oracle — genuine exploration, novel theory, contested design decisions — are not yet well served by this methodology. This is the boundary between "re-implementation" and "research."
- **Production quality is not yet here.** CLAX is a demo. Replacing production scientific infrastructure (CLASS in survey pipelines, LAMMPS in materials labs) requires a level of robustness current agents do not reliably deliver.
- **Domain priors still matter for efficiency.** A domain expert steering the same agent would catch gauge-convention errors sooner and specify better tests earlier. Non-expert-driven agents waste compute on things an expert would preempt. This is improvable but not eliminable at current capability.
- **The parallelism frontier is uneven.** Some scientific codebases decompose cleanly (parsers, utility libraries, per-test parallelization); others — like deeply coupled numerical pipelines — do not. The [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md) succeeded with a swarm of ~2,000 parallel sessions; CLAX succeeded with a single sequential agent. **The shape of the codebase determines the topology of the agent deployment.** See [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md) for the contrast.

## Relationship to other wiki themes

- **Extension of [long-running-agentic-coding](long-running-agentic-coding.md) into a specific domain.** This page is the domain-specific case; the general pattern lives at [long-running-agentic-coding](long-running-agentic-coding.md).
- **Reinforces [own-your-substrate](../analyses/own-your-substrate.md).** The researcher owns the codebase, the HPC allocation, the git repo, and the accumulated domain understanding. Nothing about the workflow rents compounding infrastructure.
- **Adjacent to but distinct from [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md).** AlphaEvolve generates and evolves new algorithms; agent-driven scientific computing typically reimplements existing ones. Both use LLMs as producers of code with an evaluation loop, but the novelty target differs — AlphaEvolve searches for beats-state-of-the-art; CLAX searches for matches-state-of-the-art-in-a-new-substrate. The latter is a much easier problem structurally.

## Related

- [long-running-agentic-coding](long-running-agentic-coding.md)
- [test-oracle-for-agents](test-oracle-for-agents.md)
- [agent-persistent-memory](agent-persistent-memory.md)
- [ralph-loop](ralph-loop.md)
- [llm-driven-algorithm-discovery](llm-driven-algorithm-discovery.md)
- [clax-project](../entities/clax-project.md)
- [class-boltzmann-solver](../entities/class-boltzmann-solver.md)
- [siddharth-mishra-sharma](../entities/siddharth-mishra-sharma.md)
- [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md)
- [own-your-substrate](../analyses/own-your-substrate.md)
- [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
