---
title: "Langevin Dynamics (for generative sampling)"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [sampling, mcmc, generative-models, score-matching]
status: active
---

# Langevin Dynamics (for generative sampling)

An iterative MCMC procedure that samples from a probability distribution p(x) using **only its score function** ∇ₓ log p(x) — no density evaluations, no acceptance-rejection step. Originally from statistical physics (Parisi 1981; Grenander-Miller 1994), Langevin dynamics is the sampling primitive that makes [score-based-generative-models](score-based-generative-models.md) practical: once the score network is trained by [score-matching](score-matching.md), Langevin dynamics turns that score estimate into samples.

## The update rule

Initialize x_0 from an arbitrary prior π(x). Iterate:

  x_{i+1} ← x_i + ε · ∇ₓ log p(x_i) + √(2ε) · z_i,  with z_i ∼ N(0, I)

As ε → 0 and the number of steps K → ∞, x_K converges to a sample from p(x) under mild regularity conditions. In practice, small-but-finite ε and moderately large K are enough.

The update has two terms. The gradient term pushes x toward higher density (up the score). The Gaussian noise term prevents collapse to modes and keeps the chain exploring. Together, they implement the discrete-time analogue of an Itô diffusion whose stationary distribution is p(x).

For a score-based model s_θ(x) ≈ ∇ₓ log p(x), simply plug s_θ in for the true score. The model only needs to approximate the gradient, not the density.

## Why naive Langevin + score matching fails in high dimensions

The Fisher divergence that [score-matching](score-matching.md) minimizes is weighted by p(x), so the trained score is only accurate where data is dense. In high dimensions, an arbitrary prior π(x) places its mass almost entirely in low-density regions of p(x), where the score model has essentially never been trained. Langevin chains initialized there follow gradients that are close to random, and the chain is derailed before it ever reaches the data manifold.

This is the failure mode Song encountered in 2019 when sampling from deep energy-based models trained by sliced score matching — the experiments that motivated the whole multi-scale noise program.

## Annealed Langevin dynamics

The fix is to train a [Noise Conditional Score Network](score-based-generative-models.md) that estimates the score at every level of a sequence of noise scales σ_1 < σ_2 < … < σ_L, and to sample by running Langevin dynamics sequentially from the largest scale to the smallest:

1. Start x_0 from a simple prior (e.g., Gaussian with variance σ_L²).
2. Run Langevin at scale σ_L for K steps.
3. Take the result, run Langevin at scale σ_{L−1} for K steps.
4. Continue until scale σ_1.

Each stage operates on a distribution that is smoother than its successor, so the score is well-estimated everywhere at the top and the initialization for each subsequent stage is already close to the mode structure of the target. The noise scale σ_i is "annealed" — decreased gradually — much as in simulated annealing, which is where the name comes from. Annealed Langevin dynamics is the sampling procedure introduced in the original 2019 NCSN paper and tightened in the 2020 NCSNv2 paper.

## The continuous-time view

Generalizing annealed Langevin to an infinite number of noise scales gives the continuous-time reverse-SDE formulation of [score-based-generative-models](score-based-generative-models.md). The **Euler-Maruyama method** for solving the reverse SDE is structurally identical to a Langevin step — it updates x by the score plus Gaussian noise, with time-dependent coefficients f(x,t) and g(t). **Predictor-corrector samplers** make this explicit: the corrector step at each time in the reverse SDE solver is a Langevin / Hamiltonian Monte Carlo move using the time-dependent score. In other words, Langevin dynamics is both the historical origin of score-based sampling and the corrector step of its modern continuous-time version.

## As a diffusion-model sampler

Because [diffusion-models](diffusion-models.md) and score-based generative models are equivalent under the SDE framework, Langevin-type moves are also valid samplers (or corrector steps) for DDPM-family models — even though DDPMs are usually presented with a learned variational decoder rather than Langevin chains. The equivalence is the whole point of the unification.

Source: [2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md).
