---
title: "Score-Based Generative Models"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [generative-models, score-matching, sde, diffusion, ml-theory, hub]
status: active
---

# Score-Based Generative Models

A family of generative models that parameterize the **score function** — the gradient of the log probability density, ∇ₓ log p(x) — instead of the density itself. Introduced by [[entities/yang-song]] and Stefano Ermon at NeurIPS 2019, unified with [[concepts/diffusion-models|diffusion probabilistic models]] under a stochastic-differential-equation framework at ICLR 2021, and now the dominant paradigm for image, audio, shape, and video generation.

This page is a **hub concept** for the score-based / diffusion family. Sub-pages: [[concepts/score-matching]], [[concepts/langevin-dynamics]], [[concepts/diffusion-models]], [[concepts/probability-flow-ode]].

## Why model the score instead of the density

Likelihood-based models must either constrain the architecture to make the normalizing constant Z_θ tractable (autoregressive causal masking, invertible normalizing flows) or approximate it (VAE variational bounds, MCMC contrastive divergence for energy-based models). Implicit models like GANs sidestep the normalizing constant altogether but pay with adversarial training instability and mode collapse.

Modeling the score sidesteps the normalizing constant entirely: the gradient of log Z_θ with respect to x is zero, so ∇ₓ log p_θ(x) = −∇ₓ f_θ(x) regardless of what Z_θ is. The score-based model s_θ(x) only needs to be a vector-valued function with matching input and output dimensionality — **no architectural constraints at all**. This is the central structural advantage of the framework.

## Training: score matching

The natural loss is the Fisher divergence ‖∇ₓ log p(x) − s_θ(x)‖², which cannot be evaluated directly because the data score is unknown. The family of [[concepts/score-matching]] methods (Hyvärinen 2005; denoising score matching, Vincent 2011; sliced score matching, Song et al. 2019) produces unbiased estimates of this divergence from finite samples alone, optimizable with standard stochastic gradient descent. No adversarial optimization, no ELBO, no tractable normalizing constant — just a regression-like objective on samples.

## Sampling: Langevin dynamics

Given a trained score-based model, samples are drawn via [[concepts/langevin-dynamics]], an MCMC procedure that only needs ∇ₓ log p(x) (and no density evaluations):

x_{i+1} ← x_i + ε · s_θ(x_i) + √(2ε) · z_i,  z_i ∼ N(0, I)

In the limit of small ε and many steps, x_K converges to a sample from p(x).

## The naive version fails in high dimensions

The 2019 Song-Ermon paper identified a fundamental problem: Fisher divergence is weighted by p(x), so score estimates are only accurate where data is dense. In high dimensions, Langevin chains initialized from an uninformative prior start in a **low-density region** where the score model has never seen data and produces wildly wrong gradients. The chain is derailed before it reaches the data manifold.

## The fix: multi-scale noise perturbation

Perturb the data with Gaussian noise at multiple increasing scales σ_1 < σ_2 < … < σ_L, typically a geometric progression with σ_L comparable to the maximum pairwise distance between training points and L in the hundreds-to-thousands. Train a **Noise Conditional Score Network (NCSN)** s_θ(x, i) to estimate the score of every noise-perturbed distribution p_{σ_i} simultaneously, with a weighted Fisher divergence loss (typically weighted by σ_i²). At large noise scales the perturbed distribution covers the whole space, so the score is well-estimated everywhere; at small scales the score captures fine structure.

Samples are produced by **annealed Langevin dynamics**: run Langevin at the largest noise scale first, then at progressively smaller ones, with the sample from each stage initializing the next. Each stage inherits a good initialization from the previous (which operated on a smoother distribution), so the chain never has to bootstrap from pure noise at a sharp data distribution.

Practical tuning from Song-Ermon 2020 (NCSNv2): geometric-progression schedule, U-Net skip connections, exponential moving average on weights at test time. With these, the method reached GAN-comparable sample quality on FFHQ, LSUN bedroom, LSUN tower, LSUN church_outdoor, and CelebA.

## The SDE generalization

Taking the number of noise scales to infinity yields a continuous-time stochastic process governed by an SDE:

  dx = f(x, t) dt + g(t) dw

Three concrete SDEs from the ICLR 2021 paper work well for images: Variance Exploding (VE), Variance Preserving (VP), and sub-VP. The time-marginal pₜ(x) interpolates between the data distribution at t=0 and a tractable prior π(x) at t=T. Every SDE has a corresponding **reverse SDE** (Anderson 1982):

  dx = [f(x,t) − g²(t) ∇ₓ log pₜ(x)] dt + g(t) dw

Solving the reverse SDE backward in time — starting from x(T) ∼ π and integrating to x(0) — produces a data sample. The only unknown is the time-dependent score ∇ₓ log pₜ(x), which is estimated by training a **time-dependent score-based model** s_θ(x, t) against a continuous weighted combination of Fisher divergences. Under the **likelihood weighting** λ(t) = g(t)², this training loss is a KL-divergence bound on the model distribution, so minimizing it simultaneously improves sample quality and log-likelihood.

Numerical solvers for the reverse SDE include Euler-Maruyama, reverse-diffusion solvers tailored to the problem, and adaptive-step-size methods. **Predictor-corrector samplers** combine an SDE solver step (predictor) with a Langevin / Hamiltonian Monte Carlo correction (corrector) at each time step, yielding state-of-the-art CIFAR-10 FID (2.20) and Inception score (9.89) — beating StyleGAN2+ADA (2.92 / 9.83).

## The probability flow ODE and exact likelihoods

Every SDE has a corresponding deterministic ODE — the [[concepts/probability-flow-ode]] — with the same time marginals. Solving this ODE yields a sampler that, when the score is replaced by its neural estimate, becomes an instance of a neural ODE (continuous normalizing flow). That makes **exact log-likelihood computation** available via the instantaneous change-of-variables formula. Song's group reported SoTA 2.99 bits/dim on uniformly dequantized CIFAR-10, even without maximum likelihood training; with likelihood weighting and variational dequantization, 2.83 bits/dim on CIFAR-10 and 3.76 on ImageNet 32×32 — comparable or better than the best autoregressive models.

## Controllable generation: inverse problems

Score-based models handle inverse problems (inpainting, colorization, compressed-sensing MRI, CT reconstruction) via Bayes' rule for scores:

  ∇ₓ log p(x|y) = ∇ₓ log p(x) + ∇ₓ log p(y|x)

The unconditional score is learned once; the measurement-model score ∇ₓ log p(y|x) is known analytically for the forward process. The same trained model handles **arbitrary forward processes at test time without retraining** — a sharp contrast to supervised end-to-end reconstruction networks, which are brittle when the measurement process changes.

## Unification with diffusion models

Score-based generative modeling and [[concepts/diffusion-models|denoising diffusion probabilistic models]] were developed independently. The 2020 DDPM paper (Ho, Jain, Abbeel) first observed that the diffusion ELBO reduces to a weighted combination of score matching losses. The 2021 SDE paper then proved both are discretizations of the same continuous-time class. Song's analogy: **wave mechanics and matrix mechanics as equivalent formulations of quantum mechanics**. Same model family, two perspectives with different affordances.

## Known limitations

- **Sampling speed.** Hundreds to thousands of iterative score evaluations per sample, compared to single-pass GANs. Partial mitigations: probability flow ODE with coarser solvers, DDIM, distillation.
- **Discrete data.** Scores are only defined on continuous distributions; text, categorical graphs, and other discrete modalities need workarounds (e.g., continuous embeddings, discrete diffusion variants).

## Why this matters outside ML theory

Diffusion / score-based models are the **commodity substrate** underlying the applied visual-AI work cataloged elsewhere in this wiki — [[concepts/ai-filmmaking-india]], [[concepts/ai-dubbing]], [[concepts/hindu-mythology-ai-genre]], and the image/voice generation implicit in [[concepts/ai-novel-factory]]. The [[analyses/own-your-substrate]] analysis argues operators should rent this layer and own the layers that compound above it; Song's line of work is the rentable layer.

Source: [[sources/2026-04-04-yang-song-score-based-generative-modeling]].
