---
title: "Anthropic C Compiler Project"
type: entity
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [anthropic, agentic-coding, long-horizon-tasks, reference-demo]
status: active
---

# Anthropic C Compiler Project

> **Claude built a Linux-kernel-capable C compiler across ~2,000 parallel sessions.** The canonical existence proof that multi-thousand-session autonomous agentic coding can clear a hard correctness bar.

Referenced via anthropic.com/engineering/building-c-compiler. The compiler project is the precedent the scientific-computing walkthrough by [siddharth-mishra-sharma](siddharth-mishra-sharma.md) explicitly builds on.

## Swarm topology vs solo topology

Mishra-Sharma draws a structural contrast between the compiler work and [clax-project](clax-project.md):

| | C compiler | CLAX (Boltzmann solver) |
|---|---|---|
| Task shape | Parallelizable subproblems | Deeply coupled pipeline |
| Topology | ~2,000 parallel sessions | Single sequential agent + subagents |
| Debug strategy | Local — sessions work independently | Causal trace through the whole chain |
| Domain knowledge | Mostly self-contained | Required for bisecting discrepancies |

Long-horizon agentic work is not one pattern — **the shape of the task determines whether the right deployment is a swarm or a solo agent.** This generalizes beyond code.

## Related

- **Parent:** [anthropic](anthropic.md)
- **Contrast:** [clax-project](clax-project.md)
- **Hub:** [long-running-agentic-coding](../concepts/long-running-agentic-coding.md)
- **Source:** [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
