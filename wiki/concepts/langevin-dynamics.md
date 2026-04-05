---
title: "Langevin Dynamics (for generative sampling)"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [sampling, mcmc, generative-models, score-matching]
status: active
---

# Langevin Dynamics

> **An iterative MCMC procedure that samples from p(x) using only its score ∇ₓ log p(x) — no density evaluations, no accept/reject.** From statistical physics (Parisi 1981; Grenander–Miller 1994); the sampling primitive that turns a trained [score-matching](score-matching.md) network into samples in [score-based-generative-models](score-based-generative-models.md).

## The update rule

Initialize x₀ from an arbitrary prior π(x). Iterate:

```
x_{i+1} ← x_i + ε · ∇ₓ log p(x_i) + √(2ε) · z_i,   z_i ∼ N(0, I)
```

As ε → 0 and K → ∞, x_K converges to a sample from p(x). In practice small-but-finite ε and moderate K suffice. The gradient term pushes toward high density; the Gaussian noise prevents mode collapse. Discrete-time analogue of an Itô diffusion whose stationary distribution is p(x). For a trained s_θ(x), plug it in — the model only needs to approximate the gradient, not the density.

## Why naive Langevin fails in high dimensions

The Fisher divergence minimized by score matching is weighted by p(x), so the trained score is accurate only where data is dense. In high dimensions, an arbitrary prior places mass almost entirely in low-density regions where the score has never been trained. Chains initialized there follow near-random gradients and are derailed before reaching the data manifold. **This is the 2019 failure that motivated the multi-scale noise program.**

## Annealed Langevin dynamics

Train a Noise Conditional Score Network over scales σ₁ < σ₂ < … < σ_L, then run Langevin sequentially from largest scale to smallest:

1. Start x₀ from a Gaussian with variance σ_L².
2. Run K Langevin steps at scale σ_L.
3. Take the result, run K steps at σ_{L−1}.
4. Continue through σ₁.

Each stage is smoother than its successor, so the score is well-estimated at the top and each subsequent stage starts near the target's mode structure. "Annealed" as in simulated annealing — this is the sampler introduced in NCSN (2019) and tightened in NCSNv2 (2020).

## The continuous-time view

Generalizing annealed Langevin to infinite noise scales gives the continuous-time reverse-SDE formulation. The **Euler–Maruyama** solver for the reverse SDE is structurally identical to a Langevin step. **Predictor–corrector samplers** make this explicit: the corrector step at each time is a Langevin/HMC move using the time-dependent score. Langevin dynamics is both the historical origin of score-based sampling and the corrector step of its modern continuous-time version.

Because [diffusion-models](diffusion-models.md) and score-based models are equivalent under the SDE framework, Langevin-type moves are also valid samplers (or corrector steps) for DDPM-family models.

## Related

- **Hub:** [score-based-generative-models](score-based-generative-models.md)
- **Adjacent:** [score-matching](score-matching.md) · [diffusion-models](diffusion-models.md) · [probability-flow-ode](probability-flow-ode.md)
- **Originator:** [yang-song](../entities/yang-song.md)
- **Source:** [2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md)
