---
title: "Score Matching"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [training-objective, generative-models, score-matching, ml-theory]
status: active
---

# Score Matching

A family of training objectives for fitting a model of the score function ∇ₓ log p(x) to a data distribution, without ever evaluating the unknown data score and without requiring a tractable normalizing constant. Introduced by Hyvärinen in 2005 for non-normalized statistical models, extended to denoising variants by Vincent in 2011, and scaled to high dimensions by Song et al. in 2019 with sliced score matching. Score matching is the training objective that makes [score-based-generative-models](score-based-generative-models.md) work.

## The problem score matching solves

The natural loss for fitting a score-based model s_θ(x) to a data distribution p(x) is the **Fisher divergence**:

  E_{p(x)} [ ‖ ∇ₓ log p(x) − s_θ(x) ‖² ]

This measures the squared L² distance between the model's score and the true data score, weighted by p(x). It is infeasible to evaluate directly because the true data score ∇ₓ log p(x) is unknown.

Score matching methods rewrite the Fisher divergence into an equivalent objective that can be estimated purely from samples. The original Hyvärinen result uses integration by parts to eliminate the data score, producing an objective in terms of the model score and its spatial derivatives — at the cost of a Hessian trace that scales poorly in high dimensions.

## Three practical variants

- **Denoising score matching (DSM; Vincent 2011).** Perturb each training sample with a small amount of noise σ²I, then train the model to predict the score of the noise-perturbed distribution. Because the conditional distribution p(x̃|x) is a known Gaussian, its score has a closed form (x − x̃)/σ², so the loss becomes a simple regression against a known target. No Hessian, no trace — just MSE against an analytic score. **This is the objective used in practice** for training [NCSN](score-based-generative-models.md) and [diffusion](diffusion-models.md) models, because it scales cleanly and couples naturally with the noise-perturbation machinery those methods rely on.

- **Sliced score matching (SSM; Song et al. 2019).** Project the score matching objective onto random one-dimensional directions, replacing the expensive Hessian trace with a cheap Hessian-vector product. This was Song's first contribution to the line of work and the method he used to scale score matching to deep energy-based models on MNIST before discovering that Langevin sampling from the trained EBMs failed — the failure that eventually led to the multi-scale noise fix.

- **Original Hyvärinen score matching.** The baseline, requiring the full Hessian trace. Rarely used in practice for high-dimensional models, but still the theoretical reference point.

## Why it is the right objective for generative modeling

Three properties:

1. **No normalizing constant.** The Fisher divergence compares gradients, and the gradient of log Z_θ is zero. Score matching trains an unnormalized model without ever computing, approximating, or bounding Z_θ. For energy-based models this is the central advantage; it is what lets [score-based models](score-based-generative-models.md) use arbitrary neural architectures.

2. **No architectural constraint on s_θ.** The Fisher divergence does not require s_θ(x) to be an actual score function of any normalized distribution — it is simply an L² comparison of two vector fields. The only requirement is matching input/output dimensionality, which is trivial.

3. **Non-adversarial.** Score matching is a single-objective, single-network training procedure. No discriminator, no two-player dynamics, no mode collapse. This is the structural reason score-based generative models were able to match GAN sample quality without GAN pathologies.

## Under multi-scale noise: the weighted Fisher divergence

For a [Noise Conditional Score Network](score-based-generative-models.md) trained jointly over L noise scales, the loss is

  Σᵢ λ(i) · E_{p_{σ_i}(x)} [ ‖ ∇ₓ log p_{σ_i}(x) − s_θ(x, i) ‖² ]

with λ(i) typically set to σ_i² to balance the magnitudes across scales. Each noise level is a denoising score matching problem with its own closed-form target.

For the continuous-time SDE formulation, this becomes an integral over t ∈ [0, T] with weighting λ(t). Choosing λ(t) = g(t)² gives the **likelihood weighting** that makes the loss a KL-divergence bound on the model distribution — a direct link from the score matching objective to maximum likelihood training.

## Summary

Score matching is the training primitive that makes it possible to fit an arbitrary neural network to ∇ₓ log p(x) from samples alone. Denoising score matching is the variant that scales, couples with noise perturbation, and powers practically every modern diffusion / score-based generative model.

Source: [2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md).
