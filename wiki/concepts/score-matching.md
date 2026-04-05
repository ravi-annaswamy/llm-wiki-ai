---
title: "Score Matching"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [training-objective, generative-models, score-matching, ml-theory]
status: active
---

# Score Matching

> **A family of training objectives for fitting a model of ∇ₓ log p(x) to a data distribution without evaluating the unknown data score and without a tractable normalizing constant.** Hyvärinen 2005 for non-normalized models; Vincent 2011 denoising variant; Song et al. 2019 sliced variant scaling to high dimensions. The training primitive that makes [score-based-generative-models](score-based-generative-models.md) work.

## The problem

The natural loss is the **Fisher divergence**:

```
E_{p(x)} [ ‖ ∇ₓ log p(x) − s_θ(x) ‖² ]
```

Infeasible directly because the true data score is unknown. Score matching rewrites this as an equivalent objective estimable from samples alone.

## Three practical variants

| Variant | Trick | Status |
|---|---|---|
| **Original (Hyvärinen 2005)** | Integration by parts eliminates the data score; objective uses model score + Hessian trace | Baseline. Rarely used in practice — Hessian trace scales poorly in high dims |
| **Denoising (Vincent 2011, "DSM")** | Perturb each sample with Gaussian noise σ²I; target is the closed-form score (x − x̃)/σ² of the known conditional p(x̃|x) | **Used in practice.** Simple MSE regression, no Hessian, couples naturally with multi-scale noise. Powers NCSN and diffusion models |
| **Sliced (Song et al. 2019, "SSM")** | Project Fisher divergence onto random 1D directions; Hessian trace → cheap Hessian-vector product | Song's entry point; used for deep EBMs on MNIST before the failure that led to NCSN |

## Why it's the right objective for generative modeling

1. **No normalizing constant.** The gradient of log Z_θ is zero, so score matching trains unnormalized models without ever computing, approximating, or bounding Z_θ. This is what lets score-based models use arbitrary neural architectures.
2. **No architectural constraint on s_θ.** Fisher divergence is just an L² comparison of vector fields — only input/output dimensionality has to match.
3. **Non-adversarial.** Single-objective, single-network. No discriminator, no two-player dynamics, no mode collapse. Structural reason score-based models matched GAN sample quality without GAN pathologies.

## Under multi-scale noise: weighted Fisher divergence

For an NCSN trained over L noise scales:

```
Σᵢ λ(i) · E_{p_{σ_i}(x)} [ ‖ ∇ₓ log p_{σ_i}(x) − s_θ(x, i) ‖² ]
```

Typically λ(i) = σ_i² to balance magnitudes. Each scale is a denoising score matching problem with closed-form target. In continuous time this becomes an integral over t ∈ [0, T] with weighting λ(t). Choosing **λ(t) = g(t)²** gives the *likelihood weighting* that makes the loss a KL-divergence bound — a direct link from score matching to maximum likelihood.

## Related

- **Hub:** [score-based-generative-models](score-based-generative-models.md)
- **Components:** [langevin-dynamics](langevin-dynamics.md) · [diffusion-models](diffusion-models.md) · [probability-flow-ode](probability-flow-ode.md)
- **Originator:** [yang-song](../entities/yang-song.md)
- **Source:** [2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md)
