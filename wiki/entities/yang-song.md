---
title: "Yang Song"
type: entity
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [researcher, generative-models, score-matching, diffusion, stanford]
status: active
---

# Yang Song

> **Originator of score-based generative modeling as a standalone framework; Stanford PhD (advised by Stefano Ermon).** Built the 2019–2021 paper sequence that culminated in the ICLR 2021 SDE unification of score-based modeling with diffusion — one of the two canonical formulations of the generative-model family now dominating image, audio, and video synthesis.

## The paper sequence

| Year | Venue | Contribution |
|---|---|---|
| 2019 | UAI (Oral) | Sliced score matching — scalable objective via random projection |
| 2019 | NeurIPS (Oral) | Noise Conditional Score Network (NCSN); chained Langevin across multiple noise scales; SoTA CIFAR-10 Inception |
| 2020 | NeurIPS | NCSNv2 — geometric-progression noise schedule, EMA, 256×256 scaling |
| 2021 | ICLR (**Outstanding Paper**) | Score-based modeling via SDEs — unified score-based and diffusion models; predictor-corrector; probability flow ODE; Bayes-rule inverse problems |
| 2021 | NeurIPS (Spotlight) | Maximum-likelihood training of score-based diffusion models |
| 2022 | ICLR | Score-based solvers for medical imaging inverse problems (MRI, sparse-view CT) |

Key origin story: his first attempt (sliced score matching + Langevin on deep EBMs) failed to produce good samples even on MNIST. Investigating that failure yielded the three NCSN ingredients — multi-scale noise perturbation, U-Net architecture, chained Langevin — and scaled from there.

## Position in this wiki's map

Yang Song is the **theoretical substrate** beneath most applied visual-AI stories ingested so far. The diffusion systems powering [ai-filmmaking-india](../concepts/ai-filmmaking-india.md), [hindu-mythology-ai-genre](../concepts/hindu-mythology-ai-genre.md), and [ai-dubbing](../concepts/ai-dubbing.md) are direct descendants of the score-SDE framework. The wiki otherwise focuses on operators who rent this substrate; Song is the person who built the rentable layer.

No overlap with the wiki's agentic-work cluster — this is classical ML research, not LLM-driven discovery.

## Related

- **Advisor:** [stefano-ermon](stefano-ermon.md)
- **Hub concept:** [score-based-generative-models](../concepts/score-based-generative-models.md)
- **Adjacent:** [score-matching](../concepts/score-matching.md) · [langevin-dynamics](../concepts/langevin-dynamics.md) · [diffusion-models](../concepts/diffusion-models.md) · [probability-flow-ode](../concepts/probability-flow-ode.md)
- **Downstream applied:** [ai-filmmaking-india](../concepts/ai-filmmaking-india.md) · [ai-dubbing](../concepts/ai-dubbing.md) · [hindu-mythology-ai-genre](../concepts/hindu-mythology-ai-genre.md)
- **Source:** [2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md)
