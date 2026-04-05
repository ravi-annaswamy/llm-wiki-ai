---
title: "Really, you made this without AI? Prove it"
type: source
created: 2026-04-05
updated: 2026-04-05
sources: ["raw/2026-04-05-theverge-Really, you made this without AI Prove it.md"]
tags: [ai-labelling, provenance, c2pa, authenticity, disclosure, the-verge]
status: active
---

# Really, you made this without AI? Prove it

**Original:** The Verge, by Jess Weatherbed, published 2026-04-04. URL: theverge.com/tech/906453/human-made-ai-free-logo-creative-content.

## Summary

An opinion piece arguing that **human-made content labelling** is more likely to succeed than AI labelling as an authenticity regime on the open internet. The structural claim, borrowed from Instagram head Adam Mosseri, is that it is "more practical to fingerprint real media than fake media" — the producers of AI content are incentivized to hide its origin (clicks, chaos, cash), while human creators whose livelihoods are threatened are motivated to distinguish their work. The established AI-labelling standard, [c2pa](../entities/c2pa.md), has broad industry support (Adobe, Microsoft, Google) but has been "wholly ineffectual" in practice because the producers it would expose do not cooperate. See [fingerprinting-real-vs-fake](../concepts/fingerprinting-real-vs-fake.md) for the general principle.

The piece then surveys the fragmented landscape of [human-made-content-labelling](../concepts/human-made-content-labelling.md) schemes — Weatherbed counts at least 12 — and catalogues their verification approaches and failure modes:

- **Trust-based:** *Made by Human* offers downloadable badges with no provenance check.
- **AI-detection-based:** *No-AI-Icon* visually inspects works and runs them through "notoriously unreliable" AI detection services.
- **Manual audit:** Most schemes rely on human auditors reviewing sketches, drafts, and process — labor-intensive but currently the most reliable.
- **Voluntary + threshold:** [not-by-ai](../entities/not-by-ai.md) certifies work at least 90% human-made but does not verify the claim.
- **Blockchain attestation:** [proof-i-did-it](../entities/proof-i-did-it.md) issues on-chain "Made by Human" tokens to verified creators — framed by quoted academic Thomas Beyer as shifting the question from "does this look like AI?" to "can this account prove its human history?"
- **Industry-specific:** The Authors Guild offers a "human authored certification" for books; [proudly-human](../entities/proudly-human.md) (CEO Trevor Woods) targets all creative content.

## The definition problem

A core obstacle the piece surfaces is that "human-made" has no agreed meaning. Quoted experts:

- **Jonathan Stray (UC Berkeley Center for Human-Compatible AI):** "Does chatting with an LLM about the idea before executing it manually count as using AI? And how could the creator prove no AI was involved? Other consumer labels, such as 'Organic' have regulations and agencies that enforce them."
- **Nina Beguš (UC Berkeley School of Information):** "Any creative output today can be touched by AI in one way or another without us being able to prove it. Authorship is disintegrating into new directions, becoming more technologically enhanced and more collective. We need to revamp our creativity criteria that were made solely for humans."

This is the same problem [layered-authorship](../concepts/layered-authorship.md) surfaces in fiction — AI can touch premise, outline, prose, voice, or final revision, and the label has to decide which combinations still count as human. See [human-made-content-labelling](../concepts/human-made-content-labelling.md) for how the schemes in this piece try (and largely fail) to handle it.

## Coral Hart cameo and a cross-source discrepancy

Weatherbed cites [coral-hart](../entities/coral-hart.md) as a prominent example of why human-made labels face an uphill fight: an author making a six-figure sum from 200+ AI-generated romance novels who has chosen not to disclose because of "strong stigma" around the technology.

> ⚠️ CROSS-SOURCE DISCREPANCY: The Verge (citing The New York Times) says Hart "doesn't have a label on any of her books that discloses they were written using AI tools." The wiki's existing [coral-hart](../entities/coral-hart.md) page (sourced from the 2026-04-04 New Yorker essay, which also cites Alexandra Alter's NYT reporting) says she "sometimes does and sometimes doesn't." Both secondary sources attribute the claim to the same primary (Alter/NYT), but characterize her compliance differently. Without the original NYT article in `raw/`, the wiki cannot resolve which is correct. The stronger-stated Verge version is the one to prefer conservatively (harder to reach by paraphrase error), but both are flagged on the Hart page.

The Verge's framing also sharpens the **non-disclosure-is-economically-rational** half of the reception paradox documented on [ai-in-creative-writing](../concepts/ai-in-creative-writing.md): Hart isn't hiding her method because readers wouldn't buy, she's hiding it because she believes the label itself would depress sales. The Shy Girl cancellation is evidence that she is probably right.

## Why human-made labelling may still fail

Weatherbed is an advocate for the approach but catalogs the structural problems honestly:

1. **Fragmentation.** 12+ competing standards, no unification, no Fair Trade-scale agreed authority.
2. **No enforcement.** The Proudly Human CEO concedes that fraudulent use of the mark can only be pursued via legal action after the fact; prevention is not possible.
3. **Regulator gap.** Comparable labels ("Organic", "Fair Trade") require government/regulator backing that does not exist for AI authenticity.
4. **The rapid-evolution problem.** Per Woods: "The rapid evolution of AI capabilities and AI-generated content will outpace government and regulator responses."
5. **The detection adversarial loop.** Schemes that fall back on AI detection (No-AI-Icon) inherit all the reliability problems of [pangram](../entities/pangram.md)-style tools and will degrade as models improve.

## Why it matters

This is the wiki's first source focused on **provenance and authenticity** as a distinct axis from quality, economics, or capability. It sits at the intersection of several existing threads:

- The disclosure-regime stress test introduced by [shy-girl-ai-novel](../entities/shy-girl-ai-novel.md) and [coral-hart](../entities/coral-hart.md), now extended beyond publishing to all creative media.
- The [own-your-substrate](../analyses/own-your-substrate.md) logic applied to trust infrastructure: creators who own a verified human-history token (Proof I Did It) own a layer that compounds; creators who depend on platform-provided trust signals (C2PA) do not.
- A new economic actor — certification-mark vendors — that mirrors the "pick-and-shovel" pattern of AI-detection firms like [pangram](../entities/pangram.md), but on the opposite side of the trust boundary.

## Key facts

- **At least 12 competing human-made labelling schemes** currently exist (Weatherbed's count).
- **C2PA** is the established AI-labelling standard, with Adobe, Microsoft, and Google committed; deemed "wholly ineffectual" in practice.
- **Not by AI** threshold: work must be ≥90% human.
- **Proof I Did It** stores verification on blockchain, issuing non-forgeable "Made by Human" tokens.
- **Proudly Human** operates on post-hoc legal enforcement; no fraud prevention.
- **Coral Hart:** 200+ AI-generated novels, six figures, (per Verge) no disclosure on any book, citing stigma.

## Open questions

- Does any of the 12 schemes have a realistic path to becoming the dominant standard, or does fragmentation persist indefinitely?
- Is the blockchain-token approach (Proof I Did It) materially more robust than trust-based alternatives, or does it just relocate the verification problem (how does the token issuer verify humanity in the first place)?
- What does the "manual audit with sketches and drafts" approach look like at scale? Is there a minimum viable automated version that AI cannot yet trivially fake?
- If the Verge-reported version of Coral Hart's disclosure practice is correct (zero labels, ever), does that change how [ai-in-creative-writing](../concepts/ai-in-creative-writing.md) should frame her as a "disclosure-regime stress test"?
- Regulators show no current appetite for a unified standard. What event would force one — a scandal, a court ruling, a platform mandate?

## Prompt that produced this source page

> ingest raw/2026-04-05-theverge-Really, you made this without AI Prove it
