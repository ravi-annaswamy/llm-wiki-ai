---
title: "Anthropic C Compiler Project"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [anthropic, agentic-coding, long-horizon-tasks, reference-demo]
status: active
---

# Anthropic C Compiler Project

An Anthropic engineering demonstration in which Claude, working across roughly **2,000 sessions**, built a C compiler capable of compiling the Linux kernel (see anthropic.com/engineering/building-c-compiler, referenced in [[sources/2026-04-04-anthropic-long-running-claude-scientific-computing]]).

## Why it matters to the wiki

The C compiler project is the canonical precedent for **very long-horizon autonomous agentic coding** that the scientific-computing post by [[entities/siddharth-mishra-sharma]] explicitly builds on. It's the existence proof that Claude can sustain a multi-thousand-session build of a complex, correctness-sensitive system against a hard evaluation target (does it compile the Linux kernel?).

But Mishra-Sharma also draws a **structural contrast** between the compiler work and the CLAX Boltzmann-solver work ([[entities/clax-project]]):

- **C compiler → parallelizable.** The compiler task farms out to a large number of **parallel agents** working on largely independent subproblems. Each session can make progress without needing global context on what all other sessions are doing.
- **Boltzmann solver → sequential.** A numerical pipeline is **deeply coupled**: a small error or poor approximation early (e.g., in how the early universe recombines) subtly shifts everything downstream. Debugging requires tracing causally through the whole chain and drawing on domain knowledge. Better suited to a **single sequential agent** spawning subagents as needed, and using the reference implementation to bisect discrepancies.

This contrast is useful generally: it's not the case that "long-horizon agentic work" has one topology. The **shape of the task determines whether the right deployment is a swarm or a solo agent**. This observation generalizes beyond code — it probably applies to other domains where an artifact is either naturally decomposable or deeply coupled.

## Related

- [[entities/anthropic]]
- [[entities/clax-project]]
- [[concepts/long-running-agentic-coding]]
- [[sources/2026-04-04-anthropic-long-running-claude-scientific-computing]]
