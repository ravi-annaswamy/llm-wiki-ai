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

Certification schemes that mark text, images, audio, or video as produced by a human rather than (or alongside) AI. This is the inverse of AI labelling: instead of the machine marking its own output, the human claims authorship and a third party — or the blockchain, or a voluntary code of conduct — backs the claim. The approach is motivated by the observation that the producers of AI content are rarely motivated to label it honestly, while the producers of human content are strongly motivated to distinguish themselves (Source: [2026-04-05-theverge-human-made-labels](../sources/2026-04-05-theverge-human-made-labels.md)). For the structural principle behind the inversion, see [fingerprinting-real-vs-fake](fingerprinting-real-vs-fake.md).

## The current landscape

The Verge piece counts at least **12 competing schemes** as of April 2026, with no unification. The four structural approaches:

| Approach | Example | How it works | Failure mode |
|---|---|---|---|
| Trust-based | *Made by Human* | Badge is publicly downloadable, no verification | Anyone can claim it, including AI producers |
| AI-detection-based | *No-AI-Icon* | Visual review + third-party AI-detection services | [pangram](../entities/pangram.md)-style tools are "notoriously unreliable" and degrade adversarially |
| Manual audit | [proudly-human](../entities/proudly-human.md), Authors Guild | Human reviewer examines sketches, drafts, process | Labor-intensive; hard to scale; still the most reliable |
| Threshold + voluntary | [not-by-ai](../entities/not-by-ai.md) | ≥90% human claim, no verification | Depends on honesty of claimant |
| Blockchain attestation | [proof-i-did-it](../entities/proof-i-did-it.md) | Non-forgeable token tied to verified creator | Only relocates the verification problem to token-issuance time |

Schemes documented in the source (non-exhaustive): [proudly-human](../entities/proudly-human.md), [not-by-ai](../entities/not-by-ai.md), [proof-i-did-it](../entities/proof-i-did-it.md), Made by Human, No-AI-Icon, the Authors Guild Human Authored Certification.

## Why human-made labelling, not AI labelling

The dominant AI-labelling effort, [c2pa](../entities/c2pa.md), has broad industry commitment (Adobe, Microsoft, Google) but The Verge deems it "wholly ineffectual" in practice. The reason is a **motivational asymmetry**: the producers C2PA would expose are the same people who gain from concealment. AI influencers, synthetic-porn account operators, [coral-hart](../entities/coral-hart.md)-style novel factories, scam product sellers on Etsy, and political-mischief accounts all lose revenue or reach if their output is labelled as AI. C2PA depends on voluntary cooperation from actors whose business model is incompatible with cooperation.

Human-made labelling inverts the actor: creators whose livelihoods are threatened by AI are motivated to pay, verify, and defend a label that distinguishes their work. See [fingerprinting-real-vs-fake](fingerprinting-real-vs-fake.md) for the fuller argument.

## The definition problem

All current schemes struggle with what "human-made" actually means in a landscape where AI is embedded across creative tooling. Quoted in the source:

- **Jonathan Stray** (UC Berkeley Center for Human-Compatible AI): "Does chatting with an LLM about the idea before executing it manually count as using AI? And how could the creator prove no AI was involved?"
- **Nina Beguš** (UC Berkeley School of Information): "Any creative output today can be touched by AI in one way or another without us being able to prove it. Authorship is disintegrating into new directions, becoming more technologically enhanced and more collective."

*Not by AI*'s 90% threshold is one attempt to resolve this — it acknowledges that a purist definition is unworkable and sets an arbitrary line. It is not enforced, and the threshold is not independently auditable.

This is the same problem the [layered-authorship](layered-authorship.md) argument surfaces in fiction: AI intervenes at specific layers (premise, outline, prose, voice), and the interesting question is which combinations of layers still count as human. A usable label would likely have to specify *what* remained human, not just that "human effort" was involved. No current scheme does this.

## Structural problems with the whole approach

The source lays these out explicitly:

1. **Fragmentation prevents Schelling-point adoption.** Consumer labels like "Organic" and "Fair Trade" work because there is one of each; 12 competing human-made labels means consumers can't recognize any of them.
2. **No enforcement mechanism.** Proudly Human's CEO, Trevor Woods, concedes that fraudulent use of the label can only be pursued through post-hoc legal action. Prevention is impossible.
3. **No regulatory backing.** Organic and Fair Trade have government agencies behind them; human-made labels do not. Woods: "The rapid evolution of AI capabilities and AI-generated content will outpace government and regulator responses."
4. **AI-detection fallbacks inherit adversarial brittleness.** Schemes that run works through detectors are running on the same substrate as [pangram](../entities/pangram.md), with the same false-positive / evasion concerns documented in the [shy-girl-ai-novel](../entities/shy-girl-ai-novel.md) case.
5. **Stigma drives non-participation from the other side.** The [coral-hart](../entities/coral-hart.md) cameo in the source illustrates that even when labelling is *offered* to AI producers (Amazon's voluntary disclosure), they decline — because the label depresses sales. Any labelling regime that depends on coverage from AI producers is asking them to act against their own interests.

## Connection to other wiki threads

- **[ai-in-creative-writing](ai-in-creative-writing.md) / [shy-girl-ai-novel](../entities/shy-girl-ai-novel.md) / [coral-hart](../entities/coral-hart.md)** — labelling is the enforcement side of the disclosure regime the New Yorker essay asks for. The Verge source extends the publishing-specific problem to all media.
- **[own-your-substrate](../analyses/own-your-substrate.md)** — a verified creator identity (e.g., a [proof-i-did-it](../entities/proof-i-did-it.md) token) is a compounding asset the creator owns, independent of any single platform. Platforms' own trust signals (C2PA metadata stripped by any re-encoder) are not.
- **[layered-authorship](layered-authorship.md)** — the definition problem is a special case of the layered-authorship observation. A mature label would have to specify which layers remained human.
- **[pangram](../entities/pangram.md)** — detection-based labelling schemes rely on the same tools and inherit the same brittleness.

## Open questions

- Is there a minimum viable unification — a single interoperable metadata format under which competing certifiers could all attest — that would solve the Schelling-point problem without requiring one to win?
- Does any scheme attempt a *layer-specific* claim (e.g., "prose 100% human, outline partially AI-assisted") instead of a binary?
- If the equilibrium is "labels work for the human-made minority, unlabelled content is assumed AI-suspect," what is the economic effect on unlabelled-but-actually-human creators who can't afford certification?
- Does a platform-level mandate (Meta, YouTube, Etsy) leapfrog the regulator gap, or does it just reproduce the C2PA-style voluntary-cooperation failure one level up?

## Related

- [fingerprinting-real-vs-fake](fingerprinting-real-vs-fake.md)
- [c2pa](../entities/c2pa.md)
- [proudly-human](../entities/proudly-human.md)
- [not-by-ai](../entities/not-by-ai.md)
- [proof-i-did-it](../entities/proof-i-did-it.md)
- [coral-hart](../entities/coral-hart.md)
- [pangram](../entities/pangram.md)
- [ai-in-creative-writing](ai-in-creative-writing.md)
- [layered-authorship](layered-authorship.md)
- [2026-04-05-theverge-human-made-labels](../sources/2026-04-05-theverge-human-made-labels.md)
