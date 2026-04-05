---
title: "Score-Based Generative Models"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [generative-models, score-matching, sde, diffusion, ml-theory, hub]
status: active
---

# Score-Based Generative Models

> **A family of generative models that parameterize the *score function* — the gradient of the log probability density, ∇ₓ log p(x) — instead of the density itself.** Introduced by [yang-song](../entities/yang-song.md) and Stefano Ermon (NeurIPS 2019), unified with diffusion probabilistic models under a stochastic-differential-equation framework (ICLR 2021), and now the dominant paradigm for image, audio, shape, and video generation.

This page is a **hub** for the score-based / diffusion family. Sub-pages: [score-matching](score-matching.md) · [langevin-dynamics](langevin-dynamics.md) · [diffusion-models](diffusion-models.md) · [probability-flow-ode](probability-flow-ode.md).

## Why the score instead of the density

Likelihood-based models must either constrain architecture to make Z_θ tractable (autoregressive masking, invertible flows) or approximate it (VAE ELBO, MCMC contrastive divergence). GANs sidestep Z_θ but pay with instability and mode collapse.

Modeling the score sidesteps Z_θ entirely: ∇ₓ log Z_θ = 0, so the model only needs to be a vector-valued function with matching input/output dimensionality — **no architectural constraints at all**. That is the central structural advantage.

## The pipeline

| Stage | Mechanism | Page |
|---|---|---|
| **Train** | Regression-like estimate of Fisher divergence ‖∇ₓ log p(x) − s_θ(x)‖² — no adversarial loss, no ELBO, no Z_θ | [score-matching](score-matching.md) |
| **Sample** | Iterative MCMC using only ∇ₓ log p — `x_{i+1} ← x_i + ε·s_θ(x_i) + √(2ε)·z_i` | [langevin-dynamics](langevin-dynamics.md) |

## Why the naive version fails — and the fix

Fisher divergence is weighted by p(x), so estimates are only accurate where data is dense. In high dimensions, Langevin chains started from an uninformative prior begin in a **low-density region** the model has never seen, producing wildly wrong gradients. Chain derailed.

**Fix: multi-scale noise perturbation.** Perturb with Gaussian noise at scales σ_1 < … < σ_L (geometric, σ_L ≈ max pairwise distance). Train a **Noise Conditional Score Network** s_θ(x, i) on every scale jointly with weighted Fisher divergence. Sample via **annealed Langevin dynamics**: large scale → small scale, each stage initializing the next. NCSNv2 (Song 2020) reached GAN-comparable quality on FFHQ, LSUN, CelebA.

## The SDE generalization

Taking L → ∞ yields a continuous-time SDE: `dx = f(x,t) dt + g(t) dw`. Three concrete SDEs work well: **VE** (Variance Exploding), **VP** (Variance Preserving), **sub-VP**. Every SDE has a corresponding **reverse SDE** (Anderson 1982) whose only unknown is the time-dependent score, learned by training s_θ(x, t) against a continuous weighted Fisher divergence. Under **likelihood weighting** λ(t) = g²(t), the loss is a KL bound — so minimizing it improves both sample quality and log-likelihood.

**Predictor-corrector samplers** combine an SDE step with Langevin correction, giving SoTA CIFAR-10: **FID 2.20, IS 9.89** (beating StyleGAN2+ADA 2.92 / 9.83).

## Probability flow ODE → exact likelihoods

Every SDE has a matching deterministic ODE with the same time marginals — the [probability-flow-ode](probability-flow-ode.md). Replacing the score with its neural estimate makes the sampler a continuous normalizing flow, enabling **exact log-likelihoods** via the change-of-variables formula. Reported: **2.99 bits/dim** on uniformly dequantized CIFAR-10 without MLE training; **2.83** with likelihood weighting + variational dequantization; **3.76** on ImageNet 32×32 — at or above the best autoregressive models.

## Controllable generation via Bayes

Inverse problems (inpainting, colorization, MRI, CT) decompose cleanly:

  ∇ₓ log p(x|y) = ∇ₓ log p(x) + ∇ₓ log p(y|x)

The unconditional score is learned once; the measurement-model term is known analytically. **One trained model handles arbitrary forward processes at test time without retraining** — a sharp contrast to supervised end-to-end reconstruction networks, which are brittle when the measurement process changes.

## Unification with diffusion models

Score-based modeling and denoising diffusion (DDPM) were developed independently. Ho, Jain & Abbeel (2020) first observed that the DDPM ELBO reduces to weighted score matching. Song's 2021 SDE paper then proved both are discretizations of the same continuous-time class. Song's analogy: **wave mechanics vs matrix mechanics** — equivalent formulations of the same theory, different affordances.

## Known limitations

- **Sampling speed.** Hundreds–thousands of score evaluations per sample vs single-pass GANs. Mitigations: probability-flow ODE with coarser solvers, DDIM, distillation.
- **Discrete data.** Scores only defined on continuous distributions; text and categorical graphs need workarounds.

## Why this matters outside ML theory

Diffusion / score-based models are the **commodity substrate** beneath the applied visual-AI work elsewhere in this wiki — [ai-filmmaking-india](ai-filmmaking-india.md), [ai-dubbing](ai-dubbing.md), [hindu-mythology-ai-genre](hindu-mythology-ai-genre.md), and the image/voice layer implicit in [ai-novel-factory](ai-novel-factory.md). [own-your-substrate](../analyses/own-your-substrate.md) argues operators should rent this layer and own what compounds above it; Song's work is the rentable layer.

## Related

- **Sub-concepts:** [score-matching](score-matching.md) · [langevin-dynamics](langevin-dynamics.md) · [diffusion-models](diffusion-models.md) · [probability-flow-ode](probability-flow-ode.md)
- **Canonical author:** [yang-song](../entities/yang-song.md)
- **Adjacent:** [ai-filmmaking-india](ai-filmmaking-india.md) · [own-your-substrate](../analyses/own-your-substrate.md)
- **Source:** [2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md)
