---
title: "Overview"
type: overview
created: 2026-04-04
updated: 2026-04-05
sources:
  - "wiki/sources/2026-04-03-anthropic-acquires-coefficient-bio.md"
  - "wiki/sources/2026-04-04-reuters-ai-indian-films.md"
  - "wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md"
  - "wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"
  - "wiki/sources/2026-04-04-newyorker-is-it-wrong-to-write-with-ai.md"
  - "wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"
  - "wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"
  - "wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"
  - "wiki/sources/2026-04-05-theverge-human-made-labels.md"
tags: [enterprise-ai, life-sciences, india-film, llm-knowledge-bases, automated-research, creative-writing, agentic-coding, scientific-computing, generative-models, ml-theory, autoresearch, ratchet-loop, provenance, authenticity, meta]
status: active
---

# Overview

> **High-level synthesis of everything in the wiki.** Nine sources across vertical-AI adoption, LLM knowledge management, automated research, creative writing, long-horizon agentic coding, foundational generative-model theory, and content provenance. Two cross-cutting analysis pages so far: [own-your-substrate](analyses/own-your-substrate.md) and [producer-filter-pattern](analyses/producer-filter-pattern.md).

## Sources at a glance

| # | Cluster | Source | Hub concept |
|---|---|---|---|
| 1 | Life sciences | [anthropic](entities/anthropic.md) acquires [coefficient-bio](entities/coefficient-bio.md) (~$400M, all-stock) | [ai-drug-discovery](concepts/ai-drug-discovery.md) |
| 2 | India film | Reuters: AI rewiring Indian cinema — Galleri5, Eros, JioStar, Abundantia, NeuralGarage | [ai-filmmaking-india](concepts/ai-filmmaking-india.md) |
| 3 | Knowledge mgmt (meta) | VentureBeat on [andrej-karpathy](entities/andrej-karpathy.md)'s LLM Knowledge Bases — the pattern this wiki implements | [llm-knowledge-bases](concepts/llm-knowledge-bases.md) |
| 4 | Automated algorithm discovery | MarkTechPost on [alphaevolve](entities/alphaevolve.md) discovering VAD-CFR (10/11 games) and SHOR-PSRO (8/11) | [llm-driven-algorithm-discovery](concepts/llm-driven-algorithm-discovery.md) |
| 5 | Creative writing | New Yorker essay anchored on [shy-girl-ai-novel](entities/shy-girl-ai-novel.md) and [coral-hart](entities/coral-hart.md) | [ai-in-creative-writing](concepts/ai-in-creative-writing.md) |
| 6 | Long-horizon agentic coding | Anthropic / [siddharth-mishra-sharma](entities/siddharth-mishra-sharma.md) on [clax-project](entities/clax-project.md) | [long-running-agentic-coding](concepts/long-running-agentic-coding.md) |
| 7 | Foundational ML theory | [yang-song](entities/yang-song.md) on score-based / diffusion unification | [score-based-generative-models](concepts/score-based-generative-models.md) |
| 8 | Automated ML research | DataCamp on Karpathy's [autoresearch](entities/autoresearch.md) — single-GPU overnight ratchet | [ratchet-loop](concepts/ratchet-loop.md) |
| 9 | Provenance & labelling | The Verge on human-made content labelling — 12+ schemes, [c2pa](entities/c2pa.md) deemed ineffectual | [human-made-content-labelling](concepts/human-made-content-labelling.md) |

## Key themes

### LLM as active producer of structured artifacts, not just query-answerer

Five clean instances across sources: Karpathy's lint-filtered wiki, AlphaEvolve's exploitability-filtered algorithms, Coral Hart's revision-filtered novels, CLAX's accuracy-filtered JAX code, AutoResearch's `val_bpb`-filtered training loops. Plus a sixth plausible instance in Coefficient Bio's implied drug-discovery pipeline. **Promoted to its own analysis:** [producer-filter-pattern](analyses/producer-filter-pattern.md). AutoResearch is the first instance with a **literally uncircumventable** filter and a **strictly monotone** admissibility rule ([ratchet-loop](concepts/ratchet-loop.md)).

### Own your substrate

Anthropic buying domain talent, Indian studios building in-house AI labs, Karpathy keeping knowledge in local Markdown files. Three surface-different stories, one logic: **the parts of the stack that compound are the parts you can't rent.** See [own-your-substrate](analyses/own-your-substrate.md). The wiki itself is an instance.

### Ratchet loops trade exploration for audit trails

[ratchet-loop](concepts/ratchet-loop.md) = strict sub-variant of producer–filter where every change is either committed or reverted. Lets AutoResearch run overnight on a single GPU — but cannot traverse a metric valley, which is the root of the [llm-research-creativity-ceiling](concepts/llm-research-creativity-ceiling.md). Contrast: population-based filters like [alphaevolve](entities/alphaevolve.md) find genuinely novel structures but need DeepMind-scale compute. The design space is **how tight is scaffolding, how expensive is one evaluation, how often can you close the loop** — not "evolution yes/no."

### Task shape → agent topology

Same methodology plays out in two topologically opposite ways depending on the task. [anthropic-c-compiler-project](entities/anthropic-c-compiler-project.md) parallelized across ~2,000 mostly independent sessions; [clax-project](entities/clax-project.md) used a **single sequential agent** because a deeply coupled numerical pipeline requires causal tracing. The swarm-vs-solo choice depends on whether the artifact decomposes naturally or is internally coupled.

### `CLAUDE.md` + `CHANGELOG.md` as a generalizable "agent context pair"

A portable plan the agent can edit + a progress/failure log the agent reads at session start. Together these do the work of a hidden vector-store memory, in a form that is legible, portable, and editable. [file-over-app-philosophy](concepts/file-over-app-philosophy.md) instance; structural cousin of this wiki's `CLAUDE.md` + `wiki/log.md` split. Likely applicable beyond code.

### Commercial success and critical reception are decoupling (3 instances)

| Case | Signal | Source |
|---|---|---|
| AI Mahabharat (Galleri5/JioStar) | 26.5M views, **1.4/10 IMDb** | India film |
| Raanjhanaa AI re-release (Eros) | Lead actor backlash, **35% ticket sales** (+12pp vs 2025 avg) | India film |
| Shy Girl AI novel (Hachette) | 78% AI detected, **4/5 Amazon** (pre-disclosure) → cancelled | Creative writing |

Same pattern across two media and two cultural contexts. The Hachette cancellation hints the industry believes ratings wouldn't survive mandatory disclosure; the Mahabharat numbers suggest disclosure doesn't matter when genre tolerance is high enough.

### The substrate beneath the applied visual-AI stories is explicit now

Text-to-video, image-to-image, voice-cloning, and facial-alteration systems in [ai-filmmaking-india](concepts/ai-filmmaking-india.md), [ai-dubbing](concepts/ai-dubbing.md), [hindu-mythology-ai-genre](concepts/hindu-mythology-ai-genre.md) are all descendants of the score-based / diffusion family established by Yang Song and collaborators 2019–2021. This makes the own-your-substrate split concrete: Indian studios rent the diffusion layer (Veo, SDXL, voice models) and own the pipelines, catalogs, and distribution wrapped around it.

### Provenance as an incentive-alignment problem, not a technical one

[c2pa](entities/c2pa.md) has corporate commitment but is "wholly ineffectual" because its cooperative party is the wrong one. AI producers lose revenue when labelled; they don't participate. Human creators are motivated to distinguish their work, which is why 12+ human-made labelling schemes exist. See [fingerprinting-real-vs-fake](concepts/fingerprinting-real-vs-fake.md). Sibling to [own-your-substrate](analyses/own-your-substrate.md) at the trust-infrastructure level.

### Authorship as layered, not unitary

Creative works have separable layers (premise, plot, prose, voice for fiction; performance, voice, face, ending for film). AI interventions are always at **specific layers**. Controversy tracks which layer is touched — prose and voice in fiction, voice identity in film. See [layered-authorship](concepts/layered-authorship.md).

### Regulatory environment shapes where the frontier lives

India/Hollywood divergence is explicit: SAG-AFTRA and DGA contracts constrain US studios from practices Indian studios deploy freely. Frontiers move to where friction is lowest.

## Key figures to remember

| Figure | Source |
|---|---|
| **1/5 cost, 1/4 time** for mythology/fantasy (Galleri5) | India film |
| **$11M** Abundantia AI studio build, 1/3 of revenue from AI in 3 years | India film |
| Eros reviewing **3,000-title catalog** for AI re-editing | India film |
| **~100 articles / ~400k words** — Karpathy's scale claim for Markdown over "fancy RAG" | LLM KB |
| VAD-CFR matches SoTA in **10/11 games**, SHOR-PSRO in **8/11** | AlphaEvolve |
| CLAX: **sub-percent accuracy** vs CLASS in days on one H100, vs months-to-years for expert teams | CLAX |
| Anthropic C compiler: **~2,000 sessions** | Compiler project |
| AutoResearch overnight: **83 experiments, 15 kept**, `val_bpb` 1.000 → 0.975 | AutoResearch |
| Karpathy nanochat: time-to-GPT-2 **2.02h → 1.80h** (11% faster) | AutoResearch |
| Shopify/Lutke: **19% validation improvement** from 37 experiments on 0.8B query expansion, day 1 | AutoResearch |
| EY projection: Indian media revenue **+10%**, costs **−15%** medium-term | India film |

## Open questions

- **Vertical acquisitions.** Is the Anthropic/Coefficient deal a template? Do OpenAI and Google DeepMind follow in materials, climate, law?
- **Reception paradox.** Is it conditional on non-disclosure, or robust to it? Hachette thinks non-disclosure; Mahabharat numbers suggest otherwise when genre tolerance is high.
- **LLM-driven algorithm discovery transfer.** Does it need tight class hierarchies, or does it work over looser interfaces? Optimizers, attention variants, compiler passes are plausible targets.
- **Genuine novelty vs training-data recombination** in AlphaEvolve discoveries.
- **Ratchet loop outside ML training.** Compilers, search ranking, numerical solvers satisfy the structural requirements; only Shopify query-expansion has a reported instance so far.
- **Ceiling source.** Is the [llm-research-creativity-ceiling](concepts/llm-research-creativity-ceiling.md) primarily in the filter or the producer? A non-RLHF producer running an identical ratchet would be informative.
- **Long-horizon failures.** CLAX is days; the compiler is longer but parallel. What breaks at multi-week sequential horizons?
- **Does `contamination-mitigation` become mandatory** for this wiki before multi-source batch ingest becomes safe?
- **Scale of the Karpathy pattern.** At what corpus size does unsupervised linting break?
- **Layered disclosure.** In a disclosure regime, would readers want to know *which layers* were AI-assisted, or just whether AI was involved at all?
- **Provenance regulation.** What event forces a unified standard — scandal, court ruling, platform mandate?
