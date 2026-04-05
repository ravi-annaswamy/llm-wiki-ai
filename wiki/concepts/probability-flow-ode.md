---
title: "Probability Flow ODE"
type: concept
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [generative-models, sde, ode, normalizing-flows, exact-likelihood]
status: active
---

# Probability Flow ODE

> **A deterministic ODE with the same time-marginal distributions as an associated SDE at every time t.** Introduced in [yang-song](../entities/yang-song.md)'s ICLR 2021 paper on [score-based-generative-models](score-based-generative-models.md). Turns any score-based / diffusion model into a continuous normalizing flow — unlocking exact log-likelihood and deterministic sampling from a single trained network.

## Construction

Given a forward SDE `dx = f(x,t) dt + g(t) dw` with marginal density pₜ(x), the corresponding probability flow ODE is:

```
dx = [ f(x,t) − ½ g²(t) ∇ₓ log pₜ(x) ] dt
```

Marginals match at every t; trajectories differ (ODE smooth/deterministic; SDE noisy/Brownian). The only unknown is the time-dependent score, already estimated by the trained score network s_θ(x,t) — so once a score-based model is trained, the probability flow ODE is available **for free, no retraining**.

## What it unlocks

| Capability | Mechanism |
|---|---|
| **Exact log-likelihoods** | Substituting s_θ turns it into a neural ODE / continuous normalizing flow; instantaneous change-of-variables gives exact log p(x) by integrating Jacobian trace along the trajectory |
| **Deterministic sampling** | Solving the reverse ODE with a standard numerical solver — no stochastic noise; smoother trajectories allow coarser steps → **faster sampling** |
| **Invertibility** | Each data sample has a unique latent; latent-space interpolation, editing, inversion-based manipulation all become well-defined |

## Reported numbers

Song reported SoTA **2.99 bits/dim on CIFAR-10** via this route — beating RealNVP (3.49), iResNet (3.45), Glow (3.35), FFJORD (3.40), Flow++ (3.29) — **without any maximum-likelihood training**. With likelihood weighting λ(t) = g(t)² and variational dequantization: 2.83 bits/dim on CIFAR-10, 3.76 on ImageNet 32×32 — comparable to Sparse Transformer (2.80, 3.77).

## Relationship to the reverse SDE

Both the reverse SDE and the probability flow ODE are valid samplers from the same distribution. The reverse SDE is preferred for sample **quality** — the stochastic corrector helps escape failure modes of an imperfect score. The probability flow ODE is preferred for **determinism, exact likelihood, or speed**. Predictor–corrector samplers can mix either with Langevin correction.

## Why it matters

The probability flow ODE is what makes score-based / diffusion models simultaneously **sample-quality competitive with GANs** and **log-likelihood competitive with autoregressive models** from a single trained network. It is the main reason this family — rather than normalizing flows or VAEs — became the dominant generative paradigm for continuous data by 2026.

## Related

- **Hub:** [score-based-generative-models](score-based-generative-models.md)
- **Originator:** [yang-song](../entities/yang-song.md)
- **Adjacent:** [diffusion-models](diffusion-models.md) · [langevin-dynamics](langevin-dynamics.md) · [score-matching](score-matching.md)
- **Source:** [2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md)
