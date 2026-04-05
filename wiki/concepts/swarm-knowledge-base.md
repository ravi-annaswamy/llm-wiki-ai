---
title: "Swarm Knowledge Base"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"]
tags: [multi-agent, karpathy, quality-gate, hermes, nous-research]
status: active
---

# Swarm Knowledge Base

A multi-agent extension of the [[concepts/llm-knowledge-bases]] pattern, proposed by @jumperz, founder of Secondmate, in response to Karpathy's original post. It scales the single-researcher wiki workflow to a ~10-agent system managed via OpenClaw (Source: [[sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases]]).

## The core challenge

In a single-agent wiki, the worst failure is a bad page that a human eventually notices and edits. In a multi-agent swarm, the failure mode is much worse: **one agent's hallucination becomes the next agent's context**, and errors compound across the swarm. The shared memory that's supposed to make the swarm smarter can instead make it collectively more confused than any single agent would be.

Left uncontrolled, this collapses into a classic garbage-in-garbage-out loop, except inside a "knowledge base" that agents trust by default.

## The Quality Gate

The proposed solution: a dedicated validation model — the **Hermes model** from Nous Research, trained specifically for structured evaluation — acting as an independent supervisor. The rule:

> Every draft article is scored and validated by Hermes before being promoted from the "draft" area to the "live" wiki.

Hermes is not writing content. It's grading content written by the swarm. By keeping evaluation separate from generation (and using a model with a different training signature), the pattern avoids the failure mode where an agent grades its own output favorably.

## The "Compound Loop"

The full architecture, as described in the source:

1. **Agents dump raw outputs** — drafts, analyses, notes — into a staging area.
2. **The compiler organizes** the raw dumps into draft wiki pages.
3. **Hermes validates** every draft. Only pages that clear the quality gate are promoted.
4. **Verified briefings are fed back to agents** at the start of each session.

The payoff: the swarm never "wakes up blank." Each agent begins each task with a filtered, high-integrity briefing of everything the collective has learned — but never with contaminated memory, because the gate prevents bad drafts from being written back.

## Relationship to contamination mitigation

This pattern is the multi-agent version of [[concepts/contamination-mitigation]]. Where [[entities/steph-ango]]'s original "clean vault / messy vault" pattern uses a **human** as the promotion gate, the swarm pattern uses a **separate validation model** — because at multi-agent throughput, humans can't be the bottleneck.

Both patterns share the key insight: separate generation from validation, and make promotion to the canonical store an explicit step.

## Open questions

- Is Hermes specifically necessary, or would any sufficiently different model work as the gate?
- What's the failure mode if Hermes itself has a systematic bias? Does the pattern need a second-order gate?
- How expensive is this at real swarm scale — does the validation compute dominate the generation compute?
- Can the gate be partial (e.g., only high-confidence drafts get auto-promoted; low-confidence drafts route to a human)?

## Related

- [[concepts/llm-knowledge-bases]]
- [[concepts/contamination-mitigation]]
- [[concepts/wiki-linting]]
- [[concepts/ephemeral-wiki]]
