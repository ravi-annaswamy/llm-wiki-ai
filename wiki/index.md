---
title: "Wiki Index"
type: overview
created: 2026-04-04
updated: 2026-04-04
---

# Wiki Index

Last updated: 2026-04-04 | Total pages: 67 | Total sources: 7

## Sources

| Date | Title | Tags |
|------|-------|------|
| 2026-04-03 | [[sources/2026-04-03-anthropic-acquires-coefficient-bio]] | anthropic, acquisition, biotech, drug-discovery |
| 2026-04-04 | [[sources/2026-04-04-reuters-ai-indian-films]] | india, film, bollywood, ai-filmmaking, dubbing |
| 2026-04-04 | [[sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases]] | karpathy, llm-knowledge-bases, rag, markdown, meta |
| 2026-04-04 | [[sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory]] | deepmind, alphaevolve, marl, cfr, psro, game-theory |
| 2026-04-04 | [[sources/2026-04-04-newyorker-is-it-wrong-to-write-with-ai]] | creative-writing, fiction, authorship, disclosure, drum-machine-analogy |
| 2026-04-04 | [[sources/2026-04-04-anthropic-long-running-claude-scientific-computing]] | anthropic, claude-code, agentic-coding, long-horizon-tasks, scientific-computing, hpc, cosmology |
| 2026-04-04 | [[sources/2026-04-04-yang-song-score-based-generative-modeling]] | generative-models, diffusion, score-matching, sde, ml-theory, foundational |

## Entities

### AI labs & companies
- [[entities/anthropic]] — AI lab; building a vertical life-sciences capability via product + acqui-hires.
- [[entities/google-deepmind]] — Google's flagship AI lab; authors of the AlphaEvolve game-theory paper.
- [[entities/coefficient-bio]] — Stealth biotech AI startup acquired by Anthropic in April 2026 for ~$400M.
- [[entities/prescient-design]] — Genentech's computational drug discovery group; talent origin for AI bio startups.
- [[entities/claude-for-life-sciences]] — Anthropic product (Oct 2025) for scientific researchers.
- [[entities/alphaevolve]] — DeepMind's LLM-powered evolutionary coding agent; mutates source code, not parameters.
- [[entities/obsidian]] — Local-first Markdown note-taking app; typical viewing layer for the Karpathy pattern.
- [[entities/pangram]] — AI-detection firm whose 78% finding got the Shy Girl novel cancelled.

### Anthropic projects & demos
- [[entities/anthropic-c-compiler-project]] — ~2,000-session Claude build of a Linux-kernel-capable C compiler; parallel-swarm topology.
- [[entities/clax-project]] — Differentiable JAX Boltzmann solver built by Claude over days, sub-percent vs CLASS.

### Scientific infrastructure
- [[entities/class-boltzmann-solver]] — Canonical C Boltzmann solver used as test oracle in the CLAX experiment.

### India film industry
- [[entities/collective-artists-network]] — Bollywood talent agency; runs Galleri5 AI studio in Bengaluru.
- [[entities/eros-media-world]] — Indian studio pioneering AI re-editing of catalog titles.
- [[entities/jiostar]] — Reliance/Disney streaming JV; distribution home of AI-generated Mahabharat series.
- [[entities/abundantia-entertainment]] — Bollywood production house; $11M AI studio, aims at 1/3 revenue from AI in 3 yrs.
- [[entities/neuralgarage]] — Bengaluru AI dubbing startup serving Yash Raj and other major studios.

### Publishing & AI fiction
- [[entities/shy-girl-ai-novel]] — Hachette horror novel, 78% AI per Pangram, cancelled; 4/5 Amazon rating.
- [[entities/coral-hart]] — Pseudonymous romance novelist; industrial AI novel factory, six figures.

### People
- [[entities/andrej-karpathy]] — Originator of the "LLM Knowledge Bases" pattern this wiki implements.
- [[entities/steph-ango]] — Obsidian co-creator (Kepano); source of contamination-mitigation pattern.
- [[entities/samuel-stanton]] — Co-founder of Coefficient Bio; ex-Prescient Design.
- [[entities/nathan-c-frey]] — Co-founder of Coefficient Bio; ex-Prescient Design.
- [[entities/rahul-regulapati]] — Head of Galleri5; source of the "1/5 cost, 1/4 time" figures.
- [[entities/pradeep-dwivedi]] — Group CEO of Eros Media World; leads 3,000-title AI catalog review.
- [[entities/siddharth-mishra-sharma]] — Anthropic Discovery team researcher; author of the long-running-Claude-for-science post and the CLAX experiment.
- [[entities/yang-song]] — Stanford researcher; originator of score-based generative modeling and co-architect of the score-SDE / diffusion unification.
- [[entities/stefano-ermon]] — Stanford professor; Yang Song's advisor and co-author on the entire score-based / SDE paper sequence.

## Concepts

### Knowledge management methodology
- [[concepts/llm-knowledge-bases]] — The Karpathy pattern; the architecture this wiki implements.
- [[concepts/rag-vs-wiki-comparison]] — Head-to-head tradeoff between RAG and LLM-maintained wikis.
- [[concepts/file-over-app-philosophy]] — Local Markdown files as source of truth, outliving any app.
- [[concepts/wiki-linting]] — Self-healing maintenance pass that keeps the wiki coherent at scale.
- [[concepts/contamination-mitigation]] — Clean vault / messy vault separation for agent-written content.
- [[concepts/swarm-knowledge-base]] — Multi-agent extension with a Hermes-model Quality Gate.
- [[concepts/ephemeral-wiki]] — Task-scoped mini-knowledge-bases that dissolve after use.

### Long-running agentic coding
- [[concepts/long-running-agentic-coding]] — Multi-day autonomous Claude Code workflow: CLAUDE.md plan + CHANGELOG.md memory + test oracle + git + tmux/SLURM.
- [[concepts/test-oracle-for-agents]] — The pivotal enabling condition: reference impl, quantifiable objective, or test suite that tells the agent it's making progress.
- [[concepts/agent-persistent-memory]] — CHANGELOG.md as long-term memory across sessions, with failed approaches as load-bearing content.
- [[concepts/ralph-loop]] — For-loop wrapper that kicks the agent back into context on premature completion claims.
- [[concepts/agentic-laziness]] — Current-model failure mode where agents stop complex tasks early.
- [[concepts/agent-driven-scientific-computing]] — Application of the long-running pattern to numerical solvers, legacy ports, differentiable reimplementations.

### Automated research methodology
- [[concepts/llm-driven-algorithm-discovery]] — LLMs as the mutation operator in an evolutionary search over source code.

### Game theory & MARL
- [[concepts/marl-imperfect-information-games]] — Multi-agent RL in sequential games with hidden information (e.g., poker).
- [[concepts/counterfactual-regret-minimization]] — CFR family of iterative NE-convergent algorithms.
- [[concepts/policy-space-response-oracles]] — PSRO: iterative population growth via meta-strategy solvers.

### Generative model theory (foundational)
- [[concepts/score-based-generative-models]] — Hub concept. Parameterize ∇ₓ log p(x), train by score matching, sample by Langevin / reverse-SDE. Unified with diffusion models under the SDE framework.
- [[concepts/score-matching]] — Training objective for fitting a score network from samples alone; denoising score matching is the practical workhorse.
- [[concepts/langevin-dynamics]] — MCMC sampler that needs only the score; annealed variant chains multiple noise scales to fix high-dimensional failure.
- [[concepts/diffusion-models]] — Denoising diffusion perspective; equivalent to score-based modeling under the SDE unification (wave-vs-matrix-mechanics analogy).
- [[concepts/probability-flow-ode]] — Deterministic ODE with the same marginals as the SDE; unlocks exact log-likelihoods and deterministic sampling.

### AI applications
- [[concepts/ai-drug-discovery]] — Using ML to accelerate target selection, hit finding, and lead optimization.
- [[concepts/ai-filmmaking-india]] — India's unprecedented-scale deployment of AI across the film pipeline.
- [[concepts/ai-dubbing]] — Facial alteration + translation to cross India's 22-language market.
- [[concepts/ai-film-re-editing]] — Rewriting endings/scenes of older catalog titles for re-release.
- [[concepts/hindu-mythology-ai-genre]] — Mythology as the tip-of-the-spear genre for fully AI-generated content.

### AI in creative writing
- [[concepts/ai-in-creative-writing]] — Hub concept; the essay-level questions AI raises in fiction.
- [[concepts/layered-authorship]] — Fiction as separable layers (premise, plot, prose, voice), distributable across contributors.
- [[concepts/ai-novel-factory]] — Industrial-scale AI fiction pipelines; Coral Hart and Patterson as precedents.
- [[concepts/drum-machine-analogy-for-ai]] — 1983 objections to the TR-808 mapped onto 2026 objections to AI writing.

## Analyses

- [[analyses/own-your-substrate]] — Cross-cutting pattern: serious AI operators own the layers that compound, rent the commodity layers below.
- [[analyses/producer-filter-pattern]] — The architecture shared by Karpathy KB, AlphaEvolve, Coral Hart, and CLAX: LLM as durable-artifact producer inside a mechanical filter loop.
