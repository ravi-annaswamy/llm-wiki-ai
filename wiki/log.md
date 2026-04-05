---
title: "Activity Log"
type: overview
created: 2026-04-04
updated: 2026-04-04
---

# Activity Log

## [2026-04-04] init | Wiki initialized
Wiki scaffold created. Ready for first source ingest.
Files touched: index.md, log.md, overview.md

## [2026-04-04 20:15] ingest | Anthropic acquires Coefficient Bio in $400M deal
Ingested TechCrunch article (Dominic-Madori Davis, 2026-04-03) on Anthropic's acquisition of stealth biotech AI startup Coefficient Bio. Single-pass ingest (short source, ~250 words). Created source summary, 6 entity pages, 1 concept page; updated index and overview.
Files touched:
- wiki/sources/2026-04-03-anthropic-acquires-coefficient-bio.md (new)
- wiki/entities/anthropic.md (new)
- wiki/entities/coefficient-bio.md (new)
- wiki/entities/samuel-stanton.md (new)
- wiki/entities/nathan-c-frey.md (new)
- wiki/entities/prescient-design.md (new)
- wiki/entities/claude-for-life-sciences.md (new)
- wiki/concepts/ai-drug-discovery.md (new)
- wiki/index.md (updated)
- wiki/overview.md (updated)

## [2026-04-04 20:35] ingest | Reuters — AI is rewiring the world's most prolific film industry
Ingested Reuters feature (Munsif Vengattil et al., 2026-04-04) on Indian studios' unprecedented-scale deployment of AI in filmmaking. Dense source (~2k words, many named players) but under the 3k threshold, so single-pass ingest with a generous yield. Three distinct concept threads identified: AI-generated mythology, AI dubbing, and AI re-editing of catalog titles. Also added a genre-specific concept page on Hindu mythology as the AI beachhead.
Files touched:
- wiki/sources/2026-04-04-reuters-ai-indian-films.md (new)
- wiki/entities/collective-artists-network.md (new)
- wiki/entities/rahul-regulapati.md (new)
- wiki/entities/jiostar.md (new)
- wiki/entities/eros-media-world.md (new)
- wiki/entities/pradeep-dwivedi.md (new)
- wiki/entities/abundantia-entertainment.md (new)
- wiki/entities/neuralgarage.md (new)
- wiki/concepts/ai-filmmaking-india.md (new)
- wiki/concepts/ai-dubbing.md (new)
- wiki/concepts/ai-film-re-editing.md (new)
- wiki/concepts/hindu-mythology-ai-genre.md (new)
- wiki/index.md (updated)
- wiki/overview.md (updated)

## [2026-04-04 20:55] ingest | VentureBeat — Karpathy's LLM Knowledge Bases
Ingested VentureBeat feature on Andrej Karpathy's "LLM Knowledge Bases" pattern — highly meta because this wiki itself is an implementation of the exact pattern described. Single-pass ingest (~2k words of primary article; ignored the unrelated "More" recommended-article section at the bottom). Generous yield: produced a methodology cluster of 7 concept pages plus 3 entity pages. Notable: this source is the reference document for the project's own architecture and should be linked from CLAUDE.md in a future refactor. Added "LLM Knowledge Bases methodology" as a distinct category in index.md. Overview.md now explicitly frames the wiki as both subject-matter research and a live implementation of the Karpathy pattern.
Files touched:
- wiki/sources/2026-04-04-venturebeat-karpathy-llm-knowledge-bases.md (new)
- wiki/entities/andrej-karpathy.md (new)
- wiki/entities/obsidian.md (new)
- wiki/entities/steph-ango.md (new)
- wiki/concepts/llm-knowledge-bases.md (new)
- wiki/concepts/rag-vs-wiki-comparison.md (new)
- wiki/concepts/file-over-app-philosophy.md (new)
- wiki/concepts/wiki-linting.md (new)
- wiki/concepts/contamination-mitigation.md (new)
- wiki/concepts/swarm-knowledge-base.md (new)
- wiki/concepts/ephemeral-wiki.md (new)
- wiki/index.md (updated; added methodology category)
- wiki/overview.md (updated; added meta dimension)

## [2026-04-04 21:10] update | First analysis page — "Own Your Substrate"
Created first analysis page synthesizing the cross-cutting "own your substrate" theme visible across all three ingested sources: Anthropic's Coefficient Bio acqui-hire, Indian studios' in-house AI labs, and Karpathy's file-over-app LLM Knowledge Bases pattern. Argues that operators refuse to rent the layers of the AI stack that compound (domain talent, production pipelines, structured knowledge) while freely renting commodity layers below (frontier APIs, compute). Page also notes the meta-circular observation that this wiki is itself an instance of the pattern it describes.
Files touched:
- wiki/analyses/own-your-substrate.md (new)
- wiki/index.md (updated; added first analyses entry, page count 30 → 31)

## [2026-04-04 21:30] ingest | MarkTechPost — DeepMind's AlphaEvolve on CFR and PSRO
Ingested MarkTechPost writeup of a Google DeepMind paper applying AlphaEvolve (an LLM-powered evolutionary coding agent) to automated discovery of MARL algorithms in imperfect-information games. Technical research paper summary (~1.8k words). New domain for this wiki — first game theory / MARL content. Single-pass ingest with moderate yield given the technicality. Produced 1 source + 2 entity + 4 concept pages (7 new pages). Key cross-cutting observation captured in both the source page and overview: this source extends the wiki's "LLM as active producer of structured artifacts" theme — AlphaEvolve and the Karpathy pattern are two instances of the same architectural instinct (LLM generates durable outputs, evaluation loop filters them). Added a new "Automated research methodology" category and a "Game theory & MARL" category in index.md.
Files touched:
- wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md (new)
- wiki/entities/google-deepmind.md (new)
- wiki/entities/alphaevolve.md (new)
- wiki/concepts/llm-driven-algorithm-discovery.md (new)
- wiki/concepts/marl-imperfect-information-games.md (new)
- wiki/concepts/counterfactual-regret-minimization.md (new)
- wiki/concepts/policy-space-response-oracles.md (new)
- wiki/index.md (updated; page count 31 → 38, added two new concept categories)
- wiki/overview.md (updated; added fourth source, new theme, new figures, new open questions)

## [2026-04-04 22:30] ingest | New Yorker — Is It Wrong to Write a Book with AI?
Ingested the New Yorker essay on AI in fiction. Dense essay source (~3k words) covering the Shy Girl Hachette incident, Coral Hart's AI novel factory, the Roland TR-808 drum machine analogy, and a layered-authorship argument anchored in James Patterson / prestige-TV writers' rooms / screenwriting credits. Single-pass ingest at the upper edge of the yield envelope: 1 source + 3 entities + 4 concepts (8 new pages). Key cross-wiki observations captured in overview: (a) reception paradox now has a third instance (Shy Girl 4/5 Amazon rating alongside the AI Mahabharat 1.4/10 IMDb and Raanjhanaa backlash), meaningfully strengthening the decoupling thesis; (b) "LLM as active producer of structured artifacts" theme now has three instances (Karpathy KB, AlphaEvolve, Coral Hart novel factory), crossing the threshold for a dedicated analysis page in a future pass; (c) layered-authorship as a new cross-cutting lens that retroactively clarifies ai-film-re-editing and ai-dubbing (both are layer-specific modifications). Added a new "AI in creative writing" concept category and a "Publishing & AI fiction" entity category in index.md.
Files touched:
- wiki/sources/2026-04-04-newyorker-is-it-wrong-to-write-with-ai.md (new)
- wiki/entities/shy-girl-ai-novel.md (new)
- wiki/entities/coral-hart.md (new)
- wiki/entities/pangram.md (new)
- wiki/concepts/ai-in-creative-writing.md (new)
- wiki/concepts/layered-authorship.md (new)
- wiki/concepts/drum-machine-analogy-for-ai.md (new)
- wiki/concepts/ai-novel-factory.md (new)
- wiki/index.md (updated; page count 39 → 47, added two new categories)
- wiki/overview.md (updated; fifth source, creative-writing thread, strengthened reception-paradox and active-producer themes, new layered-authorship theme, new open questions)

## [2026-04-04 23:40] refactor | Applied schema improvements to CLAUDE.md
Applied the three schema proposals from the 2026-04-04 23:25 refactor pass:
1. Added an "analysis-page graduation" check to the REFACTOR workflow — cross-cutting themes with ≥3 clean instances across sources should be promoted to their own `analyses/` page, with the original location trimmed to a one-paragraph summary + outbound link. This codifies the move that had been happening informally for two refactor cycles.
2. Extended the Log Format spec to include an optional "Failed approaches / dead ends" line on log entries, explicitly modeled on the `CHANGELOG.md` pattern from [agent-persistent-memory](concepts/agent-persistent-memory.md). The wiki now practices the pattern it catalogues.
3. Added an "Ingest-time lenses for agentic-work / automated-research sources" subsection to the Domain Configuration, with three standing checks: is this a producer–filter instance, what's the task-shape-to-topology mapping, and which scaffolding pieces appear.
Files touched:
- CLAUDE.md (three sections updated)

## [2026-04-04 23:25] refactor | Promoted producer–filter pattern to a standalone analysis page
Ran a refactor pass per the CLAUDE.md schema. Findings:
- No pages over 500 lines (largest is log.md at 119); no splits needed.
- A handful of thin entity stubs (samuel-stanton, nathan-c-frey, prescient-design, claude-for-life-sciences, pradeep-dwivedi, abundantia-entertainment, rahul-regulapati) below ~100 words; flagged but not touched — they're legitimate one-source anchor references and can be expanded opportunistically on a later ingest.
- One substantive refactor executed: the "LLM as active producer with filter loop" cross-cutting theme has had four clean instances across the wiki's sources (Karpathy KB, AlphaEvolve, Coral Hart novel factory, CLAX) and one implied fifth (Coefficient Bio drug discovery). Both the most recent ingest and the overview flagged it as "overdue for its own analysis page." Promoted the unified analysis out of concepts/test-oracle-for-agents.md into a new cross-cutting analysis at analyses/producer-filter-pattern.md, parallel to analyses/own-your-substrate.md.
- Trimmed the "filter-loop generalization" section in test-oracle-for-agents.md down to a brief summary that links to the new analysis.
- Updated overview.md to mark the theme as graduated (removed the "overdue" note), updated the corresponding open question as resolved with a new follow-on.
- Added cross-link from own-your-substrate to producer-filter-pattern; the two are positioned as sibling analyses (where-to-own vs. how-to-make-the-owned-layer-compound).
- Schema improvement suggestions prepared for user review but not applied to CLAUDE.md yet — see the refactor report in the conversation.
Files touched:
- wiki/analyses/producer-filter-pattern.md (new)
- wiki/concepts/test-oracle-for-agents.md (trimmed; added link)
- wiki/analyses/own-your-substrate.md (added sibling cross-link)
- wiki/overview.md (theme marked graduated; open question updated)
- wiki/index.md (page count 58 → 59; added new analysis entry)

## [2026-04-04 23:05] ingest | Anthropic — Long-running Claude for scientific computing
Ingested the Anthropic post by Siddharth Mishra-Sharma (Discovery team) on applying multi-day autonomous agentic coding workflows to scientific computing, with CLAX (differentiable JAX Boltzmann solver vs CLASS reference) as the worked example. Source is ~1.7k words — single-pass ingest. Introduced a sixth topical thread ("Long-running agentic coding") with its own concept cluster. Yield: 1 source + 4 entities + 6 concepts = 11 new pages. Key cross-wiki observations captured in overview: (a) fourth clean instance of the "LLM as active producer with filter loop" theme (joining Karpathy KB, AlphaEvolve, Coral Hart) — now overdue for a standalone analysis page; (b) new generalizable observation that *task shape determines agent topology* (compiler project = swarm of 2,000 parallel sessions; CLAX = single sequential agent tracing through coupled pipeline); (c) CLAUDE.md + CHANGELOG.md as a generalizable file-over-app "agent context pair" that structurally mirrors this wiki's own CLAUDE.md + wiki/log.md split. Added a new "Long-running agentic coding" concept category and an "Anthropic projects & demos" / "Scientific infrastructure" entity subgrouping in index.md.
Files touched:
- wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md (new)
- wiki/entities/siddharth-mishra-sharma.md (new)
- wiki/entities/clax-project.md (new)
- wiki/entities/class-boltzmann-solver.md (new)
- wiki/entities/anthropic-c-compiler-project.md (new)
- wiki/concepts/long-running-agentic-coding.md (new)
- wiki/concepts/test-oracle-for-agents.md (new)
- wiki/concepts/agent-persistent-memory.md (new)
- wiki/concepts/ralph-loop.md (new)
- wiki/concepts/agentic-laziness.md (new)
- wiki/concepts/agent-driven-scientific-computing.md (new)
- wiki/entities/anthropic.md (updated; added Discovery team + long-running-agentic-coding thread)
- wiki/index.md (updated; page count 47 → 58, added new category and subgroupings)
- wiki/overview.md (updated; sixth source, new themes, new open questions, new key figures)

## [2026-04-04 23:55] ingest | Yang Song — Generative Modeling by Estimating Gradients of the Data Distribution
Ingested Yang Song's widely cited tutorial blog post (~7,500 words) compiling his 2019–2022 paper sequence on score-based generative modeling. First foundational ML theory source in the wiki and a new content cluster distinct from the applied / agentic / creative-AI clusters that dominate prior sources. Dense source, so followed the two-pass protocol per CLAUDE.md.

**Pass 1 (core extraction):** created the source summary, entity page for Yang Song, and the four primary concept pages — score-based-generative-models (hub), score-matching, langevin-dynamics, diffusion-models. The hub concept carries the full narrative: why modeling the score sidesteps the normalizing constant, why the naive version fails in high dimensions, the multi-scale noise + annealed Langevin fix, the SDE generalization, and the diffusion-model unification. Sub-concept pages go deeper on the respective primitives.

**Pass 2 (cross-referencing):** created probability-flow-ode and stefano-ermon as secondary pages. Cross-linked the new generative-model cluster into the existing applied visual-AI pages — ai-filmmaking-india (added "Underlying model family" note), ai-dubbing (added linking sentence), hindu-mythology-ai-genre (added linking sentence). These three applied pages had been silently depending on the diffusion-model substrate without naming it; the cross-refs now make the "own your substrate" split concrete. Added a new "Generative model theory (foundational)" concept category in index.md. Updated overview.md with the seventh source summary and a new key theme explicitly tying applied visual-AI to the now-catalogued model-family substrate.

Ingest-time lens checks per CLAUDE.md: this source does **not** match the producer-filter pattern (training is gradient descent on Fisher divergence, not LLM producer + filter), does not trigger the task-shape / agent-topology lens (no agent involved), and does not involve scaffolding pieces. These non-matches are documented explicitly on the source page so the lens check isn't silently skipped. The lenses are agentic-work-specific by design; foundational-theory sources will typically not trigger them.

Yield: 1 source + 2 entities + 5 concepts = 8 new pages, plus edits to 3 existing concept pages, index.md, and overview.md. Above the "blog post / essay" yield envelope (5-12 concepts, 8-18 total) because the source is closer to a short review article; within expected bounds when treated as a research-paper-tier source (10-20 concepts, 15-30 total pages would be the full range — kept below that by deliberately not splitting score-matching into separate Hyvärinen/denoising/sliced pages, and by folding multi-scale noise perturbation into the score-based-generative-models hub rather than a standalone page).

Failed approaches / dead ends: considered a separate concept page for "multi-scale noise perturbation" and another for "predictor-corrector samplers," but both are inseparable from the score-based-generative-models hub and would have been thin stubs. Also considered promoting "inverse problem solving via score-based priors" to its own page but decided it's better as a subsection of the hub until a second source on the topic appears.

Files touched:
- wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md (new)
- wiki/entities/yang-song.md (new)
- wiki/entities/stefano-ermon.md (new)
- wiki/concepts/score-based-generative-models.md (new)
- wiki/concepts/score-matching.md (new)
- wiki/concepts/langevin-dynamics.md (new)
- wiki/concepts/diffusion-models.md (new)
- wiki/concepts/probability-flow-ode.md (new)
- wiki/concepts/ai-filmmaking-india.md (added "Underlying model family" subsection)
- wiki/concepts/ai-dubbing.md (added cross-link sentence)
- wiki/concepts/hindu-mythology-ai-genre.md (added cross-link sentence)
- wiki/index.md (page count 59 → 67, added new "Generative model theory" category, added two new entities and seventh source)
- wiki/overview.md (seventh source summary, new "substrate beneath applied visual-AI" theme)

## [2026-04-04 21:55] lint | Full health check, low-friction fixes applied
Ran a full lint pass across all 42 files. Results: no orphans, no low-inbound pages, no genuine broken links (3 flagged items were prose examples like `[[backlinks]]`), no contradictions. Flagged: (1) page-count drift in index.md (38 → 39), (2) stale frontmatter path in the Anthropic source referencing the obsolete `raw/assets/` subdirectory, (3) missing prompt-sections on two older source pages per the user's global instruction, (4) 10+ candidate new pages for concepts/entities mentioned on 3+ pages (Galleri5 at 10 pages, SAG-AFTRA at 6, VAD-CFR/SHOR-PSRO at 6, Mahabharat/Raanjhanaa/Gemini 2.5 Pro/OpenSpiel/Yash Raj at 5 each). User opted to apply only the low-friction fixes; the new-page batch was deferred.
Files touched:
- wiki/index.md (page count 38 → 39)
- wiki/sources/2026-04-03-anthropic-acquires-coefficient-bio.md (frontmatter path fix; retroactive prompt section)
- wiki/sources/2026-04-04-reuters-ai-indian-films.md (retroactive prompt section)
