---
title: "Google DeepMind"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md"]
tags: [ai-lab, google, research, alphaevolve, gemini, game-theory]
status: active
---

# Google DeepMind

Google's flagship AI research lab, and the team behind [alphaevolve](alphaevolve.md) — the LLM-powered evolutionary coding agent that the research in [2026-04-04-marktechpost-deepmind-alphaevolve-game-theory](../sources/2026-04-04-marktechpost-deepmind-alphaevolve-game-theory.md) applies to automated discovery of MARL algorithms in imperfect-information games.

## Relevance to this wiki

In the current wiki corpus, DeepMind is notable for pushing [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md) as a research methodology: using Gemini 2.5 Pro as the mutation operator in an evolutionary search over actual Python source code. The CFR and PSRO results (VAD-CFR matching state-of-the-art on 10/11 games; SHOR-PSRO on 8/11) are the specific payload, but the broader bet is that algorithm research itself becomes a search problem with a well-defined fitness signal.

DeepMind also owns the supporting stack used in this line of work:

- **Gemini 2.5 Pro** — the frontier LLM that serves as mutation operator inside AlphaEvolve.
- **OpenSpiel** — the open-source game theory framework used as the evaluation substrate.
- **AlphaEvolve** — the distributed evolutionary system itself.

That vertical ownership is itself relevant to the cross-cutting [own-your-substrate](../analyses/own-your-substrate.md) pattern: the compounding asset for DeepMind is not any single discovered algorithm — it's the discovery infrastructure.

## Related

- [alphaevolve](alphaevolve.md)
- [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md)
- [counterfactual-regret-minimization](../concepts/counterfactual-regret-minimization.md)
- [policy-space-response-oracles](../concepts/policy-space-response-oracles.md)
- [own-your-substrate](../analyses/own-your-substrate.md)
