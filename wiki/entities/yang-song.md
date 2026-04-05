---
title: "Yang Song"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-yang-song-score-based-generative-modeling.md"]
tags: [researcher, generative-models, score-matching, diffusion, stanford]
status: active
---

# Yang Song

ML researcher, Stanford PhD student advised by [stefano-ermon](stefano-ermon.md), and the originator of **score-based generative modeling** as a standalone framework. His 2019–2021 paper sequence — starting with sliced score matching, through the noise-conditional score network (NCSN) and its improved version, culminating in the ICLR 2021 Outstanding Paper on score-based modeling via SDEs — established one of the two equivalent formulations of the generative-model family that now dominates image, audio, shape, and video synthesis. The other formulation, [denoising diffusion probabilistic models](../concepts/diffusion-models.md), was developed independently and later unified with Song's work in the 2021 SDE paper he co-authored.

## Research arc (per the yang-song.net blog post)

Song started in 2019 working on scalable score matching for deep energy-based models. His first attempt was **sliced score matching** (UAI 2019 Oral), which projects the score matching objective onto random directions to avoid computing the full trace of the Hessian. The method scaled, but Langevin sampling from the trained EBMs failed to produce reasonable samples even on MNIST — a surprising negative result.

Investigating the failure led to three crucial observations: (1) perturb data with multiple scales of noise and train score models for each scale; (2) use a U-Net-style architecture (they initially used RefineNet); (3) chain Langevin MCMC across noise scales. These became the [Noise Conditional Score Network](../concepts/score-based-generative-models.md) and its training recipe — the 2019 NeurIPS paper "Generative Modeling by Estimating Gradients of the Data Distribution," which achieved state-of-the-art Inception score on CIFAR-10 at the time, ahead of the best GANs.

The 2020 NeurIPS follow-up ("Improved Techniques for Training Score-Based Generative Models") tightened the practical recipe — geometric-progression noise schedule, EMA weights at test time, configuration guidelines for L hundreds-to-thousands noise scales — and scaled to 256×256.

The 2021 ICLR paper with Sohl-Dickstein, Kingma, Kumar, Ermon, and Poole ("Score-Based Generative Modeling through Stochastic Differential Equations") took the number of noise scales to infinity, arriving at a continuous-time SDE formulation that subsumed both score-based generative modeling and diffusion probabilistic models as discretizations of the same continuous process. It introduced **predictor-corrector samplers** (outperforming StyleGAN2+ADA on CIFAR-10), the **probability flow ODE** (a deterministic sampler enabling exact log-likelihoods), and a clean recipe for **inverse problem solving via Bayes' rule for scores**. It won an ICLR 2021 Outstanding Paper Award.

Subsequent work applied the framework to maximum likelihood training (NeurIPS 2021 Spotlight) and to medical imaging inverse problems — accelerated MRI and sparse-view CT — achieving comparable or better performance than supervised unrolled networks with better test-time robustness.

## Position in this wiki's map

Yang Song is the **theoretical substrate** beneath most applied visual-AI stories ingested so far. The diffusion models powering AI filmmaking in India ([ai-filmmaking-india](../concepts/ai-filmmaking-india.md), [hindu-mythology-ai-genre](../concepts/hindu-mythology-ai-genre.md), [ai-dubbing](../concepts/ai-dubbing.md)) and the image/audio generative systems implicit in the creative-writing and dubbing workflows are direct descendants of the score-SDE framework Song's group established. The wiki otherwise focuses on applied operators who rent this substrate; Song is the person who built the rentable layer.

No direct overlap with the wiki's agentic-work cluster — score-based generative modeling is classical ML research (gradient descent on Fisher divergence), not LLM-driven algorithm discovery or long-running agentic coding.

## Canonical citations

- Y. Song, S. Ermon. *Generative Modeling by Estimating Gradients of the Data Distribution*. NeurIPS 2019 (Oral). — the NCSN paper.
- Y. Song, S. Ermon. *Improved Techniques for Training Score-Based Generative Models*. NeurIPS 2020. — NCSNv2; practical recipe.
- Y. Song, J. Sohl-Dickstein, D.P. Kingma, A. Kumar, S. Ermon, B. Poole. *Score-Based Generative Modeling through Stochastic Differential Equations*. ICLR 2021 (Outstanding Paper). — the SDE framework.
- Y. Song, C. Durkan, I. Murray, S. Ermon. *Maximum Likelihood Training of Score-Based Diffusion Models*. NeurIPS 2021 (Spotlight).
- Y. Song, L. Shen, L. Xing, S. Ermon. *Solving Inverse Problems in Medical Imaging with Score-Based Generative Models*. ICLR 2022.

## Blog as reference

The yang-song.net/blog/2021/score/ post is the most widely cited single-document introduction to the score-based / diffusion family, and is the source of this wiki's understanding of the framework ([2026-04-04-yang-song-score-based-generative-modeling](../sources/2026-04-04-yang-song-score-based-generative-modeling.md)).
