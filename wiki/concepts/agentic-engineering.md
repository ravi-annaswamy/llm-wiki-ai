---
title: "Agentic Engineering"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"]
tags: [karpathy, methodology, agentic-coding, vibe-coding, human-role]
status: active
---

# Agentic Engineering

> **[andrej-karpathy](../entities/andrej-karpathy.md)'s February 2026 coinage for the middle stage of human–AI division of labor in coding.** His phrasing: *"You are not writing the code directly 99% of the time. You are orchestrating agents who do and acting as oversight."*

## The three-stage progression

| Stage | Human role | AI role | Example |
|---|---|---|---|
| **Vibe coding** | Prompts, reviews every diff | Writes code in response to prompts | Day-to-day AI-assisted dev |
| **Agentic engineering** | Orchestrates agents, approves plans, oversees | Writes, runs tools, debugs, iterates | [long-running-agentic-coding](long-running-agentic-coding.md), Claude Code auto mode |
| **Independent research** | Writes a Markdown spec, walks away | Runs the full experiment loop unsupervised | [autoresearch](../entities/autoresearch.md) |

Each stage reduces the human's role: **writer → director → research advisor.** Karpathy's follow-up after AutoResearch: *"The goal is not to emulate a single PhD student, it's to emulate a research community of them."*

## Why it's a useful framing

Each stage has genuinely different tooling requirements and failure modes:

| Stage | Failure mode | Fix |
|---|---|---|
| Vibe coding | Human reviews superficially, merges broken diffs | Reviewing discipline |
| Agentic engineering | Agents drift out of scope or stall while human isn't watching | Portable `CLAUDE.md`, `CHANGELOG.md`, [test-oracle-for-agents](test-oracle-for-agents.md), [ralph-loop](ralph-loop.md) against [agentic-laziness](agentic-laziness.md) |
| Independent research | Vague success criteria in the Markdown spec | Quality of `program.md` — depends on human having done the work manually enough to know what matters |

The source's closing warning: *"If the next generation of engineers skips that formative work because agents handle it now, the field will have plenty of compute and no one with the experience to point it in the right direction."* **The progression doesn't free the human from expertise; it concentrates expertise into a narrower, more upstream bottleneck.**

## Investment shifts from interaction to filter

As autonomy increases, tooling investment shifts from the interaction layer (chat, inline suggestions) to **the filter layer** (immutable evaluators, test oracles, ratchets). AutoResearch's immutable `prepare.py` is the clearest example — without it, the human would have to supervise to catch filter corruption, defeating the whole stage. This is the same move [producer-filter-pattern](../analyses/producer-filter-pattern.md) identifies from a different angle.

## Sibling in Karpathy's arc

Agentic engineering is the *research scientist* half of Karpathy's picture; [llm-knowledge-bases](llm-knowledge-bases.md) is the *research librarian* half. Both are attempts to define how a human should divide labor with an LLM that produces durable artifacts inside an automated filter loop.

## Related

- **Author:** [andrej-karpathy](../entities/andrej-karpathy.md)
- **Canonical case:** [autoresearch](../entities/autoresearch.md)
- **Sibling:** [llm-knowledge-bases](llm-knowledge-bases.md) · [long-running-agentic-coding](long-running-agentic-coding.md)
- **Analysis:** [producer-filter-pattern](../analyses/producer-filter-pattern.md)
- **Failure modes:** [agentic-laziness](agentic-laziness.md) · [ralph-loop](ralph-loop.md)
- **Source:** [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)
