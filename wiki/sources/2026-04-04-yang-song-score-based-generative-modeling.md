---
title: "Yang Song — Generative Modeling by Estimating Gradients of the Data Distribution"
type: source
created: 2026-04-04
updated: 2026-04-04
sources: ["raw/2026-04-04-yang-song.net-Generative Modeling by Estimating Gradients of the Data Distribution.md"]
source_url: "https://yang-song.net/blog/2021/score/"
author: "Yang Song"
tags: [generative-models, diffusion, score-matching, sde, ml-theory, foundational]
status: active
---

# Yang Song — Generative Modeling by Estimating Gradients of the Data Distribution

A ~7,500-word technical tutorial by [yang-song](../entities/yang-song.md) (Stanford, advised by Stefano Ermon) compiling several years of work on score-based generative modeling. The post is both a pedagogical introduction and a chronological account of how a line of research that started as an attempt to scale score matching for energy-based models converged with the independently developed diffusion probabilistic models to form what is now the dominant paradigm in image, audio, and shape generation.

First source in this wiki on **foundational generative modeling theory** — distinct from the wiki's prior sources on applied agentic work, knowledge management, and creative AI.

## The core argument

Likelihood-based models (autoregressive, normalizing flows, VAEs, EBMs) need tractable normalizing constants or surrogate objectives. Implicit models (GANs) require adversarial training and suffer mode collapse. Both families have structural limitations.

Song's alternative: parameterize the **score function** ∇ₓ log p(x) instead of the density itself. The normalizing constant vanishes under the gradient of the log, so the score-based model has no architectural constraints. Training is done by [score-matching](../concepts/score-matching.md), which minimizes Fisher divergence without requiring the (unknown) true data score. Sampling uses [langevin-dynamics](../concepts/langevin-dynamics.md), which accesses the distribution only through its score.

The naive version fails in high dimensions because estimated scores are inaccurate in low-density regions (Fisher divergence is weighted by p(x)), and Langevin chains initialized in those regions never recover. The fix is to **perturb the data with multiple scales of Gaussian noise**, train a noise-conditional score network (NCSN) over all scales jointly, and sample via **annealed Langevin dynamics** (descending from the largest to smallest noise scale). This is the 2019 NeurIPS paper that first matched GAN sample quality without adversarial training.

Generalizing the number of noise scales to infinity gives a continuous-time [SDE formulation](../concepts/score-based-generative-models.md): data is perturbed forward with a fixed SDE, and samples are produced by solving the corresponding **reverse SDE**, which requires only the time-dependent score ∇ₓ log pₜ(x). Under likelihood weighting λ(t) = g(t)², the score matching loss bounds the KL divergence to the data distribution — so the same objective delivers sample quality and (with likelihood weighting) competitive log-likelihoods.

The SDE framework yields three additional capabilities:
- **Predictor-corrector samplers** that combine a numerical SDE solver (predictor) with Langevin-type MCMC (corrector) at each step.
- **Probability flow ODE**: every SDE has a corresponding deterministic ODE with identical marginals, which, when the score is replaced by its neural estimate, becomes a neural ODE / continuous normalizing flow. This gives exact log-likelihood computation via the instantaneous change-of-variables formula. Song reports SoTA bits/dim on CIFAR-10 even without maximum-likelihood training.
- **Inverse problems** (inpainting, colorization, class-conditional generation, compressed-sensing MRI/CT) solved by plugging the learned unconditional score into Bayes' rule for scores: ∇ₓ log p(x|y) = ∇ₓ log p(x) + ∇ₓ log p(y|x). No retraining is required; the same unconditional model handles arbitrary forward processes at test time.

## Connection to diffusion probabilistic models

Song is explicit about the history. Score-based generative modeling and diffusion probabilistic models ([diffusion-models](../concepts/diffusion-models.md)) were developed independently — the latter by Sohl-Dickstein et al. in 2015 as hierarchical latent-variable models trained by ELBO. For several years the connection looked superficial. The 2020 DDPM paper by Ho, Jain, and Abbeel showed that the ELBO for diffusion models reduces to a weighted sum of score matching losses, with the decoder parameterized as a sequence of score predictors under a U-Net. Song's 2021 ICLR SDE paper then proved both frameworks are discretizations of the same class of stochastic differential equations.

Song's analogy in the post: score-based generative modeling and diffusion probabilistic modeling are equivalent formulations of the same model family, much as **wave mechanics and matrix mechanics are equivalent formulations of quantum mechanics**. Each perspective offers different affordances — score matching gives exact likelihoods, inverse problem solving, and ties to energy-based models / optimal transport; diffusion gives the natural connection to VAEs, lossy compression, and variational inference.

## Limitations flagged by the author

- **Sampling speed.** Langevin-type iterative sampling is slow compared to single-pass GANs. The probability flow ODE with a coarser solver is one mitigation; DDIM and later distillation methods are others.
- **Discrete data.** Scores are only defined on continuous distributions, so discrete modalities (text, categorical graphs) need workarounds.

## Why this matters for this wiki

This source sits outside the wiki's main subject clusters (enterprise AI, creative AI, agentic work). But it is the **foundational reference for the generative-model family** that underlies most of the visual and audio content discussed in the India-film and AI-fiction sources. In particular: [ai-filmmaking-india](../concepts/ai-filmmaking-india.md), [ai-dubbing](../concepts/ai-dubbing.md), and [hindu-mythology-ai-genre](../concepts/hindu-mythology-ai-genre.md) all depend on image-to-image and text-to-video models that are themselves score-based / diffusion systems. Ingesting Song fills in the theoretical substrate beneath those applied stories — a "substrate layer" in the sense of [own-your-substrate](../analyses/own-your-substrate.md).

Tools produced from this line of work (the JAX and PyTorch score-SDE codebases, DDPM and its descendants, Predictor-Corrector samplers, likelihood-weighted training) are the commodity AI layer that applied operators — Galleri5, Eros, Abundantia — rent rather than own. The wiki's "own your substrate" analysis argues exactly this split: frontier APIs and the generative model family below them are rentable; the domain talent, pipelines, and catalog wrapped around them are the layer worth owning.

## Key claims for downstream citation

- Score function ∇ₓ log p(x) can be learned without touching the normalizing constant Z_θ.
- Naive score matching + Langevin fails in high dimensions because of low-density-region score error.
- Multi-scale Gaussian noise perturbation + annealed Langevin fixes this and matched SoTA on CIFAR-10 (Inception score) in 2019.
- The SDE formulation generalizes finite noise scales to infinity and yields exact likelihoods via the probability flow ODE.
- Predictor-corrector samplers beat StyleGAN2+ADA on CIFAR-10 FID (2.20 vs 2.92) and Inception score (9.89 vs 9.83).
- Likelihood weighting λ(t) = g(t)² makes the Fisher-divergence training loss a KL-divergence bound.
- The 2021 ICLR SDE paper proved score-based and diffusion models are two discretizations of the same continuous-time model family.
- Score-based inverse problem solving decomposes via Bayes' rule for scores — a single unconditional score model handles arbitrary measurement operators at test time.

## Ingest-time lens checks (per CLAUDE.md Domain Configuration)

- **Producer–filter pattern?** Not a match. This is a pure-ML methodology source, not an agentic-work source. The training loop is gradient descent on Fisher divergence, not an LLM producer + mechanical filter. Keep the [producer-filter-pattern](../analyses/producer-filter-pattern.md) instance table unchanged.
- **Task shape → agent topology?** Not applicable — no agent involved.
- **Scaffolding pieces?** Not applicable.

The ingest-time lenses defined in CLAUDE.md are specifically for agentic-work / automated-research sources. This one is foundational ML theory and doesn't trigger any of them. Noted here so the non-match is explicit rather than silent.

## User prompts

> ingest raw/2026-04-04-yang-song.net-Generative Modeling by Estimating Gradients of the Data Distribution
