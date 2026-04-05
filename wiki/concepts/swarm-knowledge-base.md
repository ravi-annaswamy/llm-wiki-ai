---
title: "Swarm Knowledge Base"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [multi-agent, karpathy, quality-gate, hermes, nous-research]
status: active
---

# Swarm Knowledge Base

> **A multi-agent extension of [llm-knowledge-bases](llm-knowledge-bases.md) proposed by @jumperz (Secondmate).** ~10 agents managed via OpenClaw, with a dedicated validation model — the Hermes model from Nous Research — acting as an independent Quality Gate before anything enters the live wiki.

## The challenge it solves

In a single-agent wiki the worst failure is a bad page that a human eventually edits. In a multi-agent swarm, the failure mode is much worse: **one agent's hallucination becomes the next agent's context, and errors compound across the swarm.** Shared memory meant to make the swarm smarter can make it collectively more confused than any single agent.

## The Quality Gate

A separate validation model — **Hermes** — scores and validates every draft article before promotion from the draft area to the live wiki. Hermes doesn't write content; it grades content written by the swarm. Keeping evaluation separate from generation (with a different training signature) avoids the failure mode where an agent grades its own output favorably.

## The Compound Loop

| Step | What happens |
|---|---|
| 1. Raw dumps | Agents dump drafts, analyses, notes into a staging area |
| 2. Compile | Compiler organizes raw dumps into draft wiki pages |
| 3. **Gate** | Hermes validates every draft. Only passing pages are promoted |
| 4. Briefing | Verified pages feed back to agents at the start of each session |

**The payoff:** the swarm never "wakes up blank." Each agent starts each task with a filtered, high-integrity briefing — but never with contaminated memory, because the gate prevents bad drafts from being written back.

## Relationship to contamination mitigation

The multi-agent version of [contamination-mitigation](contamination-mitigation.md). Where Steph Ango's original "clean/messy vault" uses a **human** as the promotion gate, the swarm pattern uses a **separate validation model** — because at swarm throughput, humans can't be the bottleneck. Both share the insight: **separate generation from validation, make promotion an explicit step.**

## Open questions

- Is Hermes specifically necessary, or would any sufficiently different model work?
- What if Hermes itself has a systematic bias — does the pattern need a second-order gate?
- How expensive is validation at real swarm scale relative to generation?

## Related

- **Hub:** [llm-knowledge-bases](llm-knowledge-bases.md)
- **Single-agent version:** [contamination-mitigation](contamination-mitigation.md)
- **Adjacent:** [wiki-linting](wiki-linting.md) · [ephemeral-wiki](ephemeral-wiki.md)
- **Source:** [2026-04-04-venturebeat-karpathy-llm-knowledge-bases](../sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md)
