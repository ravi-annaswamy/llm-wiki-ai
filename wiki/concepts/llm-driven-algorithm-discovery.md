---
title: "LLM-Driven Algorithm Discovery"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources:
  - "wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"
  - "wiki/sources/2026-04-04-datacamp-karpathy-autoresearch.md"
tags: [automated-research, evolutionary, llm, meta-learning, deepmind, karpathy, ratchet-loop]
status: active
---

# LLM-Driven Algorithm Discovery

The idea that a large language model, rather than a human researcher, can serve as the mutation and variation operator in a search over algorithm design space — producing new algorithms (or variants of existing ones) automatically, with the LLM reading and rewriting actual source code at each step.

The wiki currently holds two concrete instances:

- **[alphaevolve](../entities/alphaevolve.md)** from [google-deepmind](../entities/google-deepmind.md), applied to [counterfactual-regret-minimization](counterfactual-regret-minimization.md) and [policy-space-response-oracles](policy-space-response-oracles.md) in [marl-imperfect-information-games](marl-imperfect-information-games.md) (Source: [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md)). Population-based evolutionary search, Gemini 2.5 Pro as mutation operator, exploitability as fitness signal, closed-source.
- **[autoresearch](../entities/autoresearch.md)** from [andrej-karpathy](../entities/andrej-karpathy.md) (Source: [2026-04-04-datacamp-karpathy-autoresearch](../sources/2026-04-04-datacamp-karpathy-autoresearch.md)). Single-lineage [ratchet-loop](ratchet-loop.md), any coding agent as mutation operator, validation bits-per-byte (`val_bpb`) as fitness signal, MIT-licensed and single-GPU-accessible. Searches over a full GPT training loop (`train.py`) rather than an algorithm class.

The two instances differ along almost every design axis (population vs. lineage; algorithm-class vs. training-loop; closed-source-cluster vs. open-source-single-GPU), which is the most informative thing about them: the family is broad, and the key design choice is **what kind of filter you can afford to run every iteration**. AlphaEvolve runs an exploitability sweep across 11 games; AutoResearch runs a 5-minute training slice. Both are cheap enough to close the loop. See the comparison tables in [ratchet-loop](ratchet-loop.md) and [producer-filter-pattern](../analyses/producer-filter-pattern.md).

## The key reframing

Classical algorithm research looks like this:

1. A human researcher develops intuition about a problem domain.
2. They propose a new update rule, weighting scheme, or equilibrium solver.
3. They implement it, benchmark it, and iterate manually.
4. After many rounds, a new algorithm variant is published.

LLM-driven algorithm discovery replaces steps 2–3 with a loop:

1. Define a structured search space — e.g., Python class interfaces expressive enough to represent known variants as special cases.
2. Seed a population with a standard implementation.
3. Each generation: sample a parent, pass its **source code** to an LLM with a mutation prompt, get a candidate implementation back, evaluate it on proxy problems, and add valid candidates to the population.
4. Define a fitness signal (e.g., negative exploitability after K iterations).
5. Run until converged or budget exhausted.

The human role shifts from "propose algorithm" to "design the search space, the fitness signal, and the evaluation protocol." The algorithms themselves are the output of the search, not the input.

## What's new about this

LLMs have been used as **code generators** for a while. What's new is using them as the **variation operator inside an evolutionary loop**, where the unit of mutation is a block of code rather than a numeric parameter.

Two things had to be true for this to work:

1. LLMs had to get good enough at reading existing algorithm implementations and producing semantically meaningful modifications — not random token edits, but coherent edits that respect the algorithm's invariants.
2. The search had to produce mutations that evaluate differently enough for the evolutionary signal to carry information. If 99% of LLM edits produce equivalent-performing code, there's no gradient.

The AlphaEvolve paper is evidence both conditions are now satisfied, at least in the game-theory domain.

## What it discovered in the game-theory case

The discovered algorithms contain specific, non-intuitive mechanisms that human researchers typically wouldn't arrive at:

- **A hard policy-averaging warm-start at exactly iteration 500** in VAD-CFR, chosen by the LLM without knowing the 1000-iteration evaluation horizon.
- **Asymmetric instantaneous-regret boosting by a factor of 1.1** in VAD-CFR — applied to the instantaneous update, not the accumulated history.
- **Asymmetric training-time vs. evaluation-time solver configurations** in SHOR-PSRO — the search itself discovered that the solver used during oracle training should differ from the solver used during exploitability evaluation, which is not a design choice a human researcher would typically make.

These are the paper's core argument for why automated search over algorithm space is worth doing: the mechanisms it finds are not translations of things in the literature. They're genuinely new structure.

## What AutoResearch adds

AutoResearch demonstrates that the mutation-operator-as-LLM approach works with a **much looser search space** than AlphaEvolve used. AlphaEvolve operated over tight Python class hierarchies expressive enough to represent known CFR/PSRO variants as special cases. AutoResearch operates over a single 630-line training file with no class scaffolding at all — the agent is allowed to rewrite activations, attention heads, LR schedules, initialization, optimizer internals. Same family, much less structure.

What AutoResearch loses by dropping the scaffolding: genuine novelty of the kind AlphaEvolve found (hard warm-starts at iteration 500, asymmetric train/eval solver configs). The ratchet filter has an admissibility rule — strictly improve `val_bpb` — that rules out the valley-traversing moves the evolutionary filter tolerates. See [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md).

What it gains: **radical accessibility.** AutoResearch runs on a single GPU with any off-the-shelf coding agent (Claude Code, Cursor, Codex) as the mutation operator. The barrier to running the loop is a GitHub clone and an overnight API budget. Shopify's Tobi Lutke adapted it to a production query-expansion model and reported a 19% validation improvement from 37 experiments the day after he started.

The two instances together suggest the design space is **not** "do you use evolution or not" but rather "how tight is your search scaffolding, how expensive is one evaluation, and how often can you close the loop." Tight scaffolding + expensive filter = population-based, DeepMind-scale. Loose scaffolding + cheap filter = ratchet, single-GPU.

## Generalization

The game-theory result is narrow, but the framework is not domain-specific. Anywhere you can:

- Express the algorithm as structured code with a clean interface,
- Define a fitness signal that cleanly discriminates candidates,
- Run enough evaluations per generation to have a useful gradient,

the same approach should apply. Likely next targets: optimizers, attention variants, RL algorithms, compiler passes, graph algorithms, simulator subroutines.

## Connection to other threads in this wiki

This concept connects to the wiki's broader "LLM as active producer of structured artifacts" pattern:

- In [llm-knowledge-bases](llm-knowledge-bases.md), the LLM authors a structured wiki from raw sources, with a linting loop as the evaluation signal.
- Here, the LLM authors new algorithm implementations from existing ones, with exploitability as the evaluation signal.

In both cases the LLM is **generating new artifacts that subsequent work depends on**, inside an evaluation loop that decides which artifacts survive. The LLM isn't answering a query — it's producing a durable output that becomes part of the substrate.

It also weakly touches [own-your-substrate](../analyses/own-your-substrate.md): DeepMind controls Gemini 2.5 Pro (the mutation operator), AlphaEvolve (the evolutionary framework), and OpenSpiel (the evaluation substrate). The compounding asset is not the discovered algorithms — it's the discovery infrastructure.

## Open questions

- How structured does the search space have to be for LLM-driven mutation to converge? Can it work over looser interfaces, or does it need the tight class hierarchies used here?
- What fraction of "discoveries" are genuine novelty vs. the LLM retrieving and recombining tricks from its training data?
- Does the approach scale to longer algorithm files and more complex interfaces, or does the mutation operator degrade with code length?
- How expensive is a full run in wall-clock and compute? If it's dominated by evaluation rather than mutation, the bottleneck is the same as classical neural architecture search — but if mutation is expensive, LLM serving becomes the limit.
- Can the same framework rediscover known algorithms from a minimal seed as a sanity check, or only improve on already-good ones?

## Related

- [alphaevolve](../entities/alphaevolve.md)
- [autoresearch](../entities/autoresearch.md)
- [ratchet-loop](ratchet-loop.md)
- [llm-research-creativity-ceiling](llm-research-creativity-ceiling.md)
- [google-deepmind](../entities/google-deepmind.md)
- [andrej-karpathy](../entities/andrej-karpathy.md)
- [counterfactual-regret-minimization](counterfactual-regret-minimization.md)
- [policy-space-response-oracles](policy-space-response-oracles.md)
- [marl-imperfect-information-games](marl-imperfect-information-games.md)
- [llm-knowledge-bases](llm-knowledge-bases.md)
- [producer-filter-pattern](../analyses/producer-filter-pattern.md)
- [own-your-substrate](../analyses/own-your-substrate.md)
