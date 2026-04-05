---
title: "Diffusion Models"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [generative-models, diffusion, ddpm, score-matching, ml-theory]
status: active
---

# Diffusion Models

A class of generative models that learn to reverse a gradual noising process — data is slowly corrupted by Gaussian noise over many steps, and a neural network is trained to invert the corruption step by step to generate samples from noise. First proposed by Sohl-Dickstein et al. in 2015 ("Deep unsupervised learning using nonequilibrium thermodynamics") as hierarchical latent-variable models trained by the variational evidence lower bound. Dramatically improved by Ho, Jain, and Abbeel in the 2020 DDPM paper ("Denoising Diffusion Probabilistic Models"). Now unified with [score-based-generative-models](score-based-generative-models.md) under a single stochastic-differential-equation framework.

This page covers the diffusion-probabilistic-model perspective specifically; see [score-based-generative-models](score-based-generative-models.md) for the score-function perspective and the continuous-time SDE unification.

## The basic idea

Define a **forward process** that slowly destroys the data by adding Gaussian noise over T time steps, so that at the end the sample is pure noise from a tractable prior (typically standard Gaussian). Train a **reverse process** — a neural network that takes a noisy sample at step t and predicts a slightly less noisy sample at step t−1. At inference, start from a pure-noise sample and apply the reverse process T times to produce a clean sample.

The 2015 formulation trains the reverse process by maximizing a variational lower bound on the data log-likelihood, with the forward process parameters fixed. This was the elegant idea that sat mostly unused for five years because the resulting sample quality was poor.

## The 2020 DDPM breakthrough

Ho, Jain, and Abbeel's DDPM paper did two things. First, they parameterized the reverse process as a **sequence of score predictors with a U-Net backbone**, training each step to predict the noise that was added during the forward step (equivalent, up to a known scaling, to predicting the score of the time-marginal distribution). Second, they showed that the ELBO for diffusion models simplifies — when the parameterization is chosen carefully — to a **weighted combination of score matching losses**, the exact same objective used to train score-based generative models.

This equivalence was the first deep connection between diffusion models and Yang Song's independently developed [score-based-generative-models](score-based-generative-models.md) line of work, which had also been training U-Net score networks with weighted Fisher divergences since 2019. It turned two apparently unrelated frameworks into two parameterizations of the same training objective, and DDPM achieved sample quality comparable or superior to GANs on standard image benchmarks.

## The 2021 SDE unification

Song's ICLR 2021 paper (joint with Sohl-Dickstein and others) closed the loop. By taking the number of diffusion steps to infinity, both diffusion probabilistic models and score-based generative models become discretizations of the same continuous-time stochastic differential equation. The forward process is dx = f(x,t) dt + g(t) dw; the reverse process is a reverse SDE whose only unknown is the time-dependent score ∇ₓ log pₜ(x). Training reduces, in both frameworks, to estimating this score via a weighted Fisher divergence. Sampling reduces, in both frameworks, to numerically solving the reverse SDE (or the associated [probability flow ODE](probability-flow-ode.md)).

Yang Song's analogy (verbatim paraphrase): both perspectives are like **wave mechanics and matrix mechanics** — equivalent formulations of the same underlying model family, each with different natural affordances. The score / SDE perspective gives you exact log-likelihoods, straightforward inverse-problem solving, and clean connections to energy-based models and optimal transport. The diffusion / variational perspective gives you the connection to VAEs, lossy compression, and variational probabilistic inference. Most modern work draws on both.

## Naming

There is no universally accepted umbrella term for the combined family. "Diffusion models" is the most common colloquial usage in 2024–2026 (encompassing DDPM, DDIM, latent diffusion, and score-SDE descendants). Researchers at DeepMind have proposed "Generative Diffusion Processes"; Song's blog notes this as a candidate without endorsing it. Practitioners often just say "diffusion" and let context disambiguate.

## What diffusion / score-based models are good at

- **Image generation** at state-of-the-art quality, beating GANs on CIFAR-10 FID/IS and scaling cleanly to 1024×1024 (Dhariwal-Nichol 2021, Song et al. 2021).
- **Audio synthesis** (WaveGrad, DiffWave, Grad-TTS).
- **Shape generation** (Cai et al. 2020).
- **Music generation** (Mittal et al. 2021).
- **Inverse problems without retraining** — inpainting, colorization, compressed-sensing MRI, sparse-view CT — by plugging the unconditional score into Bayes' rule for scores. A single model handles arbitrary measurement operators at test time.

## Known limitations

- **Slow sampling.** Tens to thousands of sequential network evaluations per sample. Partial mitigations: DDIM (Denoising Diffusion Implicit Models, Song-Meng-Ermon 2021) uses deterministic non-Markovian samplers with fewer steps; probability flow ODE with adaptive solvers; distillation to few-step students.
- **Discrete data.** Scores are only defined on continuous distributions. Discrete variants (D3PM, discrete flow matching) exist but are newer and less mature.

## Why this matters for this wiki

Diffusion models are the underlying model family for practically every text-to-image, text-to-video, voice-cloning, and image-to-image system that the applied sources in this wiki describe. The AI filmmaking stack in India ([ai-filmmaking-india](ai-filmmaking-india.md), [hindu-mythology-ai-genre](hindu-mythology-ai-genre.md), [ai-dubbing](ai-dubbing.md)), the visual and audio layers implicit in [ai-novel-factory](ai-novel-factory.md) marketing, and the catalog-scale image pipelines behind [ai-film-re-editing](ai-film-re-editing.md) are all downstream of this model family. The [own-your-substrate](../analyses/own-your-substrate.md) analysis argues these operators correctly rent this layer rather than reimplementing it; this concept page is the wiki's handle on the rented layer itself.

Source: [2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md).
