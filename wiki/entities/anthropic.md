---
title: "Anthropic"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources:
  - "wiki/sources/2026-04-03-anthropic-acquires-coefficient-bio.md"
  - "wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"
tags: [company, ai-lab, life-sciences, agentic-coding, scientific-computing]
status: active
---

# Anthropic

AI safety company and maker of the Claude family of models. Relevant to this wiki across two distinct threads: its **vertical life-sciences strategy** (via product and acqui-hire) and its **long-horizon agentic-coding methodology** (via the C compiler project, the Discovery team, and the CLAX scientific-computing walkthrough).

## Life sciences strategy

Anthropic has been building a dedicated life-sciences capability on two fronts:

1. **Product.** In October 2025 it announced [claude-for-life-sciences](claude-for-life-sciences.md), a product aimed at helping scientific researchers accelerate discoveries (Source: [2026-04-03-anthropic-acquires-coefficient-bio](../sources/2026-04-03-anthropic-acquires-coefficient-bio.md)).
2. **Talent and IP.** In April 2026 it acquired [coefficient-bio](coefficient-bio.md) in a reported $400M stock deal, bringing in founders [samuel-stanton](samuel-stanton.md) and [nathan-c-frey](nathan-c-frey.md) and a ~10-person team with computational drug-discovery backgrounds from [prescient-design](prescient-design.md). The team joins Anthropic's health & life sciences group (Source: [2026-04-03-anthropic-acquires-coefficient-bio](../sources/2026-04-03-anthropic-acquires-coefficient-bio.md)).

The combination suggests Anthropic wants first-party domain expertise — not just generic model access — shaping its vertical offerings in biology and medicine.

## Long-horizon agentic coding

A separate Anthropic thread is developing work patterns for **multi-day, autonomous** Claude Code usage — see [long-running-agentic-coding](../concepts/long-running-agentic-coding.md) for the general pattern. Two public demonstrations anchor the methodology:

1. **The [anthropic-c-compiler-project](anthropic-c-compiler-project.md)** — Claude working across ~2,000 sessions to build a C compiler capable of compiling the Linux kernel. A parallel-swarm topology.
2. **The CLAX experiment** — an April 2026 post by [siddharth-mishra-sharma](siddharth-mishra-sharma.md) on Anthropic's **Discovery team** walking through how to apply the same methodology to scientific computing. Concrete artifact: [clax-project](clax-project.md), a differentiable JAX Boltzmann solver reaching sub-percent accuracy against the [class-boltzmann-solver](class-boltzmann-solver.md) C reference, built in days by Claude Opus 4.6 (Source: [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)). A single-sequential-agent topology, chosen because the scientific codebase is deeply coupled rather than decomposable.

The two topologies together make the point that long-horizon autonomous agentic work is not one pattern — the shape of the task determines whether the right deployment is a swarm or a solo agent.

The **Discovery team** appears to be Anthropic's internal group thinking about AI-assisted scientific research and long-horizon autonomous work.

## Open questions

- How large is the health & life sciences org today, and how does Coefficient Bio fit into it?
- Does Anthropic plan similar vertical acqui-hires in other scientific domains?
- What is the relationship between the Discovery team and the health & life sciences group? Are they the same organization under different framings, or separate initiatives with overlapping intent?
- How central is long-horizon agentic coding becoming to Anthropic's overall product story? The C compiler + CLAX demonstrations are visible; the internal bet size is not yet.
