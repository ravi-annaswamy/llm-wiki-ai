---
title: "AI Filmmaking in India"
type: concept
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-reuters-ai-indian-films.md"]
tags: [india, film, ai-applications, bollywood]
status: active
---

# AI Filmmaking in India

India is the first large market where AI is being deployed aggressively across the full filmmaking stack — not just as a visual-effects aid, but as a substitute for substantial portions of the production pipeline. It is the clearest natural experiment in AI-native commercial filmmaking, both because India produces more films than any other country and because Hollywood-style union constraints are absent.

## Economic case

The widely cited numbers come from [[entities/rahul-regulapati]] of Galleri5 ([[entities/collective-artists-network]]): AI cuts production costs to **one-fifth** and timelines to **one-quarter** of traditional filmmaking in the mythology and fantasy genres. Consulting firm EY projects AI could lift Indian media and entertainment revenue by ~10% and reduce costs by ~15% over the medium term (Source: [[sources/2026-04-04-reuters-ai-indian-films]]).

The backdrop is industry stress. Moviegoer counts fell from 1.03 billion in 2019 to 832 million in 2025 (Ormax Media), and box-office revenue has been concentrated in a handful of hits since the pandemic. Studios see AI as the efficiency lever that keeps production viable.

## The three plays

Studios are pursuing AI through three distinct strategies — all documented in Reuters' April 2026 report:

1. **Fully AI-generated content** — especially in the [[concepts/hindu-mythology-ai-genre]]. [[entities/collective-artists-network]]'s Galleri5 is producing an eight-title slate on Hindu deities, and its Mahabharat series airs on [[entities/jiostar]].
2. **[[concepts/ai-dubbing]]** — crossing India's 22-language market barrier. [[entities/neuralgarage]] provides the technology to studios including Yash Raj Films.
3. **[[concepts/ai-film-re-editing]]** — rewriting endings or scenes in older catalog titles for re-release. [[entities/eros-media-world]] pioneered this with the "Raanjhanaa" re-release and is now reviewing its full 3,000-title catalog.

## The Hollywood divergence

The Indian approach diverges sharply from Hollywood's. US studios are constrained by the SAG-AFTRA contract (no digital alteration or replica of a performer without informed consent) and the Directors Guild contract (AI cannot do members' creative work without consultation). Indian studios face no equivalent constraints. Dominic Lees, a film and AI researcher at the University of Reading, told Reuters: "If they can deliver, then the shift in AI filmmaking will be to India."

## Production pipeline

Galleri5's approach is instructive as a template: rather than rely on pure text-to-video, it uses a hybrid pipeline where actors wear motion-capture suits to record body movement as 3D data and smartphones capture facial expressions. The captured data drives AI-generated characters downstream — a bridge between classic mocap and emerging text-to-video tools.

## Underlying model family

The text-to-video, image-to-image, and voice systems powering this work are all descendants of [[concepts/diffusion-models]] / [[concepts/score-based-generative-models]] — the generative model family established by [[entities/yang-song]] and collaborators between 2019 and 2021. Indian studios are net renters of this substrate: they consume models from Google (Veo), Microsoft, Nvidia, and open-source diffusion checkpoints, and own the production pipelines, IP, and distribution wrapped around them. This is a textbook instance of the split argued in [[analyses/own-your-substrate]].

## Capital and tech partnerships

- [[entities/abundantia-entertainment]] has committed $11M to a new in-house AI studio and expects AI content to reach one-third of revenue within three years.
- **Google** partnered with Bollywood director Shakun Batra on a five-part cinematic series using Veo 3 and Flow.
- **Microsoft** provides AI compute to Collective Artists Network.
- **Nvidia** shared the stage with AI filmmakers at India's AI film fest in February 2026.

## The reception paradox

The strongest unresolved question is audience acceptance. The Galleri5/JioStar Mahabharat series illustrates the paradox cleanly: 26.5 million+ views since its October release, but a 1.4/10 IMDb rating, with reviewers citing lip-sync issues and unnatural styling. For the earlier "Raanjhanaa" AI re-release, 35% of available tickets sold in its release month (12 points above the 2025 average) despite public backlash from the film's lead actor. Commercial signals and critical signals are pointing opposite directions.

Bollywood director Anurag Kashyap captured the studio incentive bluntly: "In India, cinema isn't about art. It's purely business, so studios are going to use it to make mythologicals. Our audience is a sucker for it."

## Open questions

- Is audience tolerance for AI output specific to mythology/fantasy, where stylized visuals mask limitations, or will it transfer to contemporary drama?
- Does the 1/5 cost claim hold outside mythology?
- Will Hollywood union constraints erode as Indian economics are demonstrated, or will the two industries permanently diverge?
- What's the long-run impact on working actors, VFX artists, and below-the-line crew in India?
