---
title: "Probability Flow ODE"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [generative-models, sde, ode, normalizing-flows, exact-likelihood]
status: active
---

# Probability Flow ODE

A deterministic ordinary differential equation associated with a stochastic differential equation, constructed to share the **same time-marginal distributions** as the SDE at every time t. Introduced in Yang Song's ICLR 2021 SDE paper on [score-based-generative-models](score-based-generative-models.md). The probability flow ODE turns any score-based / diffusion generative model into a continuous normalizing flow, unlocking **exact log-likelihood computation** and deterministic sampling.

## The construction

Given a forward SDE dx = f(x,t) dt + g(t) dw with time-marginal density pₜ(x), the corresponding probability flow ODE is

  dx = [ f(x,t) − ½ g²(t) ∇ₓ log pₜ(x) ] dt

This ODE has the same marginals {pₜ(x)}_{t∈[0,T]} as the SDE — the trajectories are different (ODE trajectories are smooth and deterministic; SDE trajectories are noisy Brownian), but the one-time-slice distributions match at every t. Mapping data to the prior via the ODE and back is fully deterministic and fully invertible.

The only unknown in the ODE is the time-dependent score ∇ₓ log pₜ(x), which is already being estimated by the trained score network s_θ(x, t) used for SDE sampling. So once a [score-based-generative-models](score-based-generative-models.md) model is trained, the probability flow ODE is available for free — no retraining, no new objective.

## Why it matters

**Exact log-likelihoods.** Substituting s_θ(x, t) for the true score turns the probability flow ODE into an instance of a **neural ODE** (Chen et al. 2018) — specifically, a continuous normalizing flow (Grathwohl et al. 2019). Neural ODEs admit an instantaneous change-of-variables formula that computes exact log p(x) by integrating the trace of the Jacobian of the vector field along the ODE trajectory. So a model trained by score matching can be evaluated for exact log-likelihood at test time, without any likelihood-based training objective.

Song reported state-of-the-art 2.99 bits/dim on uniformly dequantized CIFAR-10 via this route, beating RealNVP (3.49), iResNet (3.45), Glow (3.35), FFJORD (3.40), and Flow++ (3.29) — **without any maximum-likelihood training**. With likelihood weighting λ(t) = g(t)² and variational dequantization, the same approach reaches 2.83 bits/dim on CIFAR-10 and 3.76 on ImageNet 32×32, comparable to the best autoregressive models (Sparse Transformer at 2.80 and 3.77 respectively).

**Deterministic sampling.** Solving the reverse probability flow ODE with a numerical ODE solver produces samples without the stochastic noise of SDE integration. Because ODE trajectories are smoother than SDE trajectories, lower-order solvers and coarser step sizes can work acceptably — one of the main levers for **faster sampling**, a major pain point for diffusion / score-based models. Denoising Diffusion Implicit Models (DDIM, J. Song et al. 2021) is a closely related deterministic sampler that predates and inspired this connection.

**Invertibility and latent-space operations.** Because the ODE is deterministic and bijective between the data distribution and the prior, it gives each data sample a unique latent. Latent-space interpolation, editing, and inversion-based manipulation become well-defined operations, much as in classical normalizing flows.

## Relationship to the SDE

Both the reverse SDE and the probability flow ODE can be used as samplers, and both yield (in expectation) samples from the same distribution. The reverse SDE is typically preferred when sample *quality* is the priority — the stochastic corrector effect helps samples escape failure modes of an imperfect score estimate. The probability flow ODE is preferred when *determinism*, *exact likelihood*, or *fast sampling* is the priority.

**Predictor-corrector samplers** can use either (reverse SDE step as predictor, Langevin as corrector; or ODE step as predictor, Langevin as corrector). The separation between the deterministic flow and the stochastic corrector is clean because both are parameterized by the same time-dependent score model.

## Summary

The probability flow ODE is what makes score-based / diffusion models simultaneously **sample-quality competitive with GANs** and **log-likelihood competitive with autoregressive models**, from a single trained network. It is the main reason this model family — rather than normalizing flows or VAEs — became the dominant generative paradigm for continuous data by 2026.

Source: [2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md).
