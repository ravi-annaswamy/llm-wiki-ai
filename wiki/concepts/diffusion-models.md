---
title: "Diffusion Models"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [generative-models, diffusion, ddpm, score-matching, ml-theory]
status: active
---

# Diffusion Models

> **Generative models that learn to reverse a gradual noising process: data is corrupted by Gaussian noise over many steps; a neural network is trained to invert the corruption step by step to generate samples from noise.** Now unified with [score-based-generative-models](score-based-generative-models.md) under a single SDE framework — the two are different parameterizations of the same objective.

This page covers the diffusion-probabilistic-model perspective; see [score-based-generative-models](score-based-generative-models.md) for the score-function view and the continuous-time SDE unification.

## Historical line

| Year | Paper | Contribution |
|---|---|---|
| 2015 | Sohl-Dickstein et al., "Deep unsupervised learning using nonequilibrium thermodynamics" | First formulation as hierarchical latent-variable model trained by ELBO. Elegant but poor sample quality — sat mostly unused |
| 2020 | Ho–Jain–Abbeel, DDPM | U-Net score predictor; showed the ELBO simplifies to **weighted score matching**. Matched/beat GAN sample quality |
| 2021 | Song et al., ICLR Outstanding Paper | Continuous-time SDE: both DDPMs and score-based models are discretizations of the same SDE. Training = score estimation; sampling = reverse SDE or [probability-flow-ode](probability-flow-ode.md) |

Yang Song's analogy: the two perspectives are like **wave mechanics and matrix mechanics** — equivalent formulations with different natural affordances. The score/SDE view gives exact log-likelihoods, inverse-problem solving, and connections to EBMs and optimal transport. The diffusion/variational view gives connections to VAEs, compression, and probabilistic inference. Modern work draws on both.

## What they're good at

- **Image generation** at SoTA quality (beats GANs on CIFAR-10 FID/IS; scales cleanly to 1024×1024)
- **Audio synthesis** (WaveGrad, DiffWave, Grad-TTS)
- **Shape and music generation**
- **Inverse problems without retraining** — inpainting, colorization, MRI, sparse-view CT — by plugging the unconditional score into Bayes' rule. A single model handles arbitrary measurement operators at test time

## Known limitations

- **Slow sampling.** Tens to thousands of sequential network evaluations per sample. Mitigations: DDIM, probability-flow ODE with adaptive solvers, distillation to few-step students.
- **Discrete data.** Scores are only defined on continuous distributions. Discrete variants (D3PM, discrete flow matching) exist but are newer.

## Naming

No universally accepted umbrella term. "Diffusion models" is the common 2024–2026 colloquial usage (covers DDPM, DDIM, latent diffusion, and score-SDE descendants). DeepMind has proposed "Generative Diffusion Processes." Practitioners usually just say "diffusion" and let context disambiguate.

## Why this matters for this wiki

Diffusion models are the substrate for practically every text-to-image, text-to-video, voice-cloning, and image-to-image system in the applied sources here — [ai-filmmaking-india](ai-filmmaking-india.md), [hindu-mythology-ai-genre](hindu-mythology-ai-genre.md), [ai-dubbing](ai-dubbing.md), [ai-film-re-editing](ai-film-re-editing.md), and the visual/audio layers behind [ai-novel-factory](ai-novel-factory.md). The [own-your-substrate](../analyses/own-your-substrate.md) analysis argues these operators correctly *rent* this layer rather than reimplement it.

## Related

- **Sibling:** [score-based-generative-models](score-based-generative-models.md) (unified formulation)
- **Components:** [score-matching](score-matching.md) · [langevin-dynamics](langevin-dynamics.md) · [probability-flow-ode](probability-flow-ode.md)
- **Originator:** [yang-song](../entities/yang-song.md)
- **Downstream applied:** [ai-filmmaking-india](ai-filmmaking-india.md) · [ai-dubbing](ai-dubbing.md) · [hindu-mythology-ai-genre](hindu-mythology-ai-genre.md)
- **Analysis:** [own-your-substrate](../analyses/own-your-substrate.md)
- **Source:** [2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md)
