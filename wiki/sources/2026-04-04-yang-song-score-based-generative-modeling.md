---
title: "Yang Song — Generative Modeling by Estimating Gradients of the Data Distribution"
type: source
created: 2026-04-04
updated: 2026-04-05
sources: ["raw/2026-04-04-yang-song.net-Generative Modeling by Estimating Gradients of the Data Distribution.md"]
source_url: "https://yang-song.net/blog/2021/score/"
author: "Yang Song"
tags: [generative-models, diffusion, score-matching, sde, ml-theory, foundational]
status: active
---

# Yang Song — Generative Modeling by Estimating Gradients of the Data Distribution

> **A ~7,500-word technical tutorial by [yang-song](../entities/yang-song.md) (Stanford, advised by Stefano Ermon) compiling several years of work on score-based generative modeling.** Both a pedagogical introduction and a chronological account of how a line of research starting as an attempt to scale score matching for EBMs converged with independently developed diffusion probabilistic models to form what is now the dominant paradigm in image, audio, and shape generation.

The wiki's first source on **foundational generative modeling theory** — distinct from prior sources on applied agentic work, knowledge management, and creative AI.

## The core argument

Likelihood-based models (autoregressive, normalizing flows, VAEs, EBMs) need tractable normalizing constants or surrogate objectives. GANs sidestep them but pay with adversarial instability and mode collapse.

Song's alternative: parameterize the **score function** ∇ₓ log p(x) instead of the density. The normalizing constant vanishes under the log gradient, so the score-based model has **no architectural constraints at all**. Training uses [score-matching](../concepts/score-matching.md) (Fisher divergence, estimable without the true score). Sampling uses [langevin-dynamics](../concepts/langevin-dynamics.md) (accesses the distribution only through its score). See [score-based-generative-models](../concepts/score-based-generative-models.md) for the full concept hub.

## Why the naive version fails — and the fix

Fisher divergence is weighted by p(x), so score estimates are inaccurate in low-density regions. Langevin chains initialized there never recover.

**Fix:** perturb the data with **multiple scales of Gaussian noise**, train a Noise Conditional Score Network (NCSN) over all scales jointly, and sample via **annealed Langevin dynamics** (largest → smallest noise). This is the 2019 NeurIPS paper that first matched GAN sample quality without adversarial training.

## The SDE generalization

Taking noise scales to infinity yields a continuous-time SDE. Data is perturbed forward; samples are produced by solving the corresponding **reverse SDE**, which needs only the time-dependent score. Under **likelihood weighting** λ(t) = g(t)², the score-matching loss bounds KL — so the same objective delivers sample quality and competitive log-likelihoods.

Three additional capabilities unlocked by the SDE framework:

| Capability | Mechanism | Result |
|---|---|---|
| **Predictor-corrector samplers** | SDE step (predictor) + Langevin MCMC (corrector) | CIFAR-10 FID **2.20** vs StyleGAN2+ADA 2.92; IS **9.89** vs 9.83 |
| **Probability flow ODE** | Deterministic ODE with identical marginals; neural-ODE / continuous normalizing flow | CIFAR-10 **2.99 bits/dim** without MLE training; **2.83** with likelihood weighting |
| **Inverse problems** | Bayes' rule on scores: ∇ₓ log p(x\|y) = ∇ₓ log p(x) + ∇ₓ log p(y\|x) | One unconditional model handles arbitrary forward processes at test time, no retraining |

## Connection to diffusion models

Song is explicit about the history. Score-based and diffusion probabilistic models were developed independently (Sohl-Dickstein et al. 2015 via hierarchical latent-variable ELBO). Ho, Jain, Abbeel (DDPM 2020) showed the ELBO reduces to weighted score matching. Song's 2021 ICLR SDE paper proved both are discretizations of the same SDE class.

Song's analogy: **wave mechanics and matrix mechanics** — equivalent formulations of quantum mechanics, different affordances. Score matching gives exact likelihoods, inverse problems, EBM/optimal-transport ties; diffusion gives the natural connection to VAEs, lossy compression, and variational inference.

## Limitations flagged by the author

- **Sampling speed.** Iterative Langevin vs single-pass GANs. Mitigations: probability-flow ODE with coarser solvers, DDIM, distillation.
- **Discrete data.** Scores are only defined on continuous distributions — text, categorical graphs need workarounds.

## Why it matters for this wiki

Sits outside the wiki's main subject clusters but is the **foundational reference for the generative-model family** underlying most visual and audio content in the India-film and AI-fiction sources. [ai-filmmaking-india](../concepts/ai-filmmaking-india.md), [ai-dubbing](../concepts/ai-dubbing.md), and [hindu-mythology-ai-genre](../concepts/hindu-mythology-ai-genre.md) all depend on score-based / diffusion systems. Ingesting Song fills in the theoretical substrate — a "substrate layer" in the sense of [own-your-substrate](../analyses/own-your-substrate.md).

Tools from this line of work (score-SDE codebases, DDPM descendants, predictor-corrector samplers, likelihood-weighted training) are the **commodity AI layer** applied operators (Galleri5, Eros, Abundantia) rent rather than own.

## Ingest-time lens checks

- **Producer–filter pattern?** Not a match. Pure ML methodology — gradient descent on Fisher divergence, not an LLM producer + mechanical filter. [producer-filter-pattern](../analyses/producer-filter-pattern.md) instance table unchanged.
- **Task shape → agent topology?** N/A — no agent.
- **Scaffolding pieces?** N/A.

Non-match noted explicitly so it isn't silent.

## Prompt

> ingest raw/2026-04-04-yang-song.net-Generative Modeling by Estimating Gradients of the Data Distribution
