---
title: "Agentic Engineering"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"]
tags: [karpathy, methodology, agentic-coding, vibe-coding, human-role]
status: active
---

# Agentic Engineering

A term coined by [andrej-karpathy](../entities/andrej-karpathy.md) in February 2026 to name the middle stage of a three-step progression in how humans work with AI coding systems. His own phrasing: *"You are not writing the code directly 99% of the time. You are orchestrating agents who do and acting as oversight."* (Source: [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)).

## The three-stage progression

| Stage | Human role | AI role | Example |
|---|---|---|---|
| **Vibe coding** | Prompts, reviews every diff | Writes code in response to prompts | Most current day-to-day AI-assisted development |
| **Agentic engineering** | Orchestrates multiple agents in real time, approves plans, acts as oversight | Writes code, runs tools, debugs, iterates | [long-running-agentic-coding](long-running-agentic-coding.md), Claude Code in auto mode |
| **Independent research** | Writes a Markdown spec describing what good research looks like, then walks away | Runs the full experiment loop unsupervised | [autoresearch](../entities/autoresearch.md) |

Each stage reduces the human's role: **writer → director → research advisor**. Karpathy's follow-up framing, posted after AutoResearch launched: *"The goal is not to emulate a single PhD student, it's to emulate a research community of them"* — with a gesture toward SETI@home-style distributed agent collaboration.

## Why it's a useful framing

The three stages are not just points on a slider of "autonomy." They correspond to genuinely different tooling requirements and different failure modes:

- **Vibe coding** fails when the human reviews superficially and merges broken diffs. The fix is better reviewing discipline.
- **Agentic engineering** fails when agents drift out of scope or get stuck in loops during work the human isn't watching. The fixes are the scaffolding pieces [long-running-agentic-coding](long-running-agentic-coding.md) names: a portable `CLAUDE.md` plan, a `CHANGELOG.md` cross-session memory, a [test-oracle-for-agents](test-oracle-for-agents.md), git discipline, a [ralph-loop](ralph-loop.md) to counter [agentic-laziness](agentic-laziness.md).
- **Independent research** fails when the Markdown spec is vague about success criteria or fails to rule out degenerate approaches. The fix is the quality of the human's `program.md`-equivalent document — which in turn depends on the human having done the work manually enough times to know what matters.

This last point is the source's closing warning: *"If the next generation of engineers skips that formative work because agents handle it now, the field will have plenty of compute and no one with the experience to point it in the right direction."* The progression does not free the human from expertise; it concentrates the human's expertise into a narrower, more upstream bottleneck.

## What the progression implies about tool design

- **Vibe coding tools** optimize for fast turn-taking — short feedback loops, inline suggestions, low-friction chat.
- **Agentic engineering tools** optimize for *situational awareness during delegation* — dashboards, tmux sessions, cross-session memory files, checkpoint-and-resume. The human still wants to look in occasionally.
- **Independent research tools** optimize for *mechanical filters the human will trust overnight*. This is why [autoresearch](../entities/autoresearch.md)'s immutable `prepare.py` matters so much structurally: without it, the human would have to supervise to catch filter corruption, and the whole point of the stage is that they don't.

In other words, as autonomy increases, **investment shifts from the interaction layer to the filter layer**. This is the same move the [producer-filter-pattern](../analyses/producer-filter-pattern.md) analysis identifies from a different angle: the compounding work is in the filter, not in the model or the chat UI.

## Connection to the wiki's other Karpathy content

Agentic engineering is a sibling to [llm-knowledge-bases](llm-knowledge-bases.md) in Karpathy's intellectual arc: both are attempts to define how a human should divide labor with an LLM that can produce durable artifacts (wiki pages in one case, training code in the other) inside an automated filter loop. The knowledge-base work is the *research librarian* half; the agentic-engineering work is the *research scientist* half. Together they sketch a picture where the human sets direction and reviews checkpoints, and the LLM does the sustained production work in between.

## Related

- [andrej-karpathy](../entities/andrej-karpathy.md)
- [autoresearch](../entities/autoresearch.md)
- [llm-knowledge-bases](llm-knowledge-bases.md)
- [long-running-agentic-coding](long-running-agentic-coding.md)
- [ralph-loop](ralph-loop.md)
- [agentic-laziness](agentic-laziness.md)
- [producer-filter-pattern](../analyses/producer-filter-pattern.md)
