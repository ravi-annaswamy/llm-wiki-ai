---
title: "Human-Made Content Labelling"
type: concept
created: 2026-04-05
updated: 2026-04-05
sources: ["wiki/sources/2026-04-05-theverge-human-made-labels.md"]
tags: [provenance, authenticity, disclosure, certification, labelling]
status: active
---

# Human-Made Content Labelling

> **Certify the human, not the machine.** 12+ competing schemes have emerged to mark text, images, audio, or video as human-made. The motivational logic ([fingerprinting-real-vs-fake](fingerprinting-real-vs-fake.md)) is sound, but the category faces structural ceilings that no current entrant clears.

The inverse of AI labelling: instead of the machine marking its output, the human claims authorship and a third party backs the claim. Motivated by the observation that AI producers rarely label honestly while human creators are strongly motivated to distinguish their work (Source: [2026-04-05-theverge-human-made-labels](../sources/2026-04-05-theverge-human-made-labels.md)).

## The four verification approaches

| Approach | Example | How it works | Failure mode |
|---|---|---|---|
| Trust-based | *Made by Human* | Downloadable badge, no provenance check | Anyone can claim it |
| AI-detection | *No-AI-Icon* | Visual review + third-party detectors | Detectors are "notoriously unreliable"; degrade adversarially ([pangram](../entities/pangram.md)) |
| Manual audit | [proudly-human](../entities/proudly-human.md), Authors Guild | Human reviewer examines sketches, drafts, process | Labor-intensive; hard to scale |
| Threshold + voluntary | [not-by-ai](../entities/not-by-ai.md) | Self-attest ≥90% human | Unverified claim |
| Blockchain attestation | [proof-i-did-it](../entities/proof-i-did-it.md) | Non-forgeable on-chain token tied to verified creator | Only relocates the verification problem |

## The definition problem

"Human-made" has no agreed meaning when AI is embedded across creative tooling. Two experts quoted by The Verge:

- **Jonathan Stray** (UC Berkeley CHAI): "Does chatting with an LLM about the idea before executing it manually count as using AI? And how could the creator prove no AI was involved?"
- **Nina Beguš** (UC Berkeley School of Information): "Authorship is disintegrating into new directions, becoming more technologically enhanced and more collective."

*Not by AI*'s 90% threshold is one attempt to resolve this — it accepts that purity is unworkable and sets an arbitrary line. The harder version would specify *which layers* remained human (premise, outline, prose, voice) — a layered claim matching the [layered-authorship](layered-authorship.md) view. No current scheme does this.

## Structural ceilings

1. **Fragmentation blocks Schelling-point adoption.** "Organic" and "Fair Trade" work because there is one of each. 12 competing marks means consumers can't recognize any.
2. **No enforcement.** Proudly Human's CEO Trevor Woods concedes fraud prevention is impossible; only post-hoc legal action.
3. **No regulator.** Organic/Fair Trade have agencies behind them. Human-made labels don't. Woods: "The rapid evolution of AI capabilities and AI-generated content will outpace government and regulator responses."
4. **Detection fallbacks are adversarial.** Schemes routing through AI detectors inherit all the reliability problems documented in the [shy-girl-ai-novel](../entities/shy-girl-ai-novel.md) case.
5. **Producer-side non-participation is economically rational.** [coral-hart](../entities/coral-hart.md) declines Amazon's voluntary disclosure because she believes the label itself depresses sales — and the Shy Girl cancellation suggests she's right.

## Open questions

- Is there a minimum viable unification — an interoperable metadata format under which competing certifiers all attest — that sidesteps the Schelling-point problem?
- Does any scheme attempt *layer-specific* claims (prose human, outline AI-assisted) rather than binary?
- If the equilibrium becomes "labels work for the minority, unlabelled ≈ AI-suspect," what happens to actually-human creators who can't afford certification?

## Related

- **Principle:** [fingerprinting-real-vs-fake](fingerprinting-real-vs-fake.md)
- **Schemes:** [c2pa](../entities/c2pa.md) (the counterexample) · [proudly-human](../entities/proudly-human.md) · [not-by-ai](../entities/not-by-ai.md) · [proof-i-did-it](../entities/proof-i-did-it.md)
- **Cases:** [coral-hart](../entities/coral-hart.md) · [shy-girl-ai-novel](../entities/shy-girl-ai-novel.md) · [pangram](../entities/pangram.md)
- **Adjacent:** [ai-in-creative-writing](ai-in-creative-writing.md) · [layered-authorship](layered-authorship.md) · [own-your-substrate](../analyses/own-your-substrate.md)
- **Source:** [2026-04-05-theverge-human-made-labels](../sources/2026-04-05-theverge-human-made-labels.md)
