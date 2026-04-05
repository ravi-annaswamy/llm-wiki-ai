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

> **An opinion piece arguing that human-made content labelling is more likely to succeed than AI labelling as an authenticity regime on the open internet.** Structural claim (borrowed from Instagram's Adam Mosseri): *"more practical to fingerprint real media than fake media"* — AI producers are incentivized to hide origin; human creators whose livelihoods are threatened are motivated to prove theirs. See [fingerprinting-real-vs-fake](../concepts/fingerprinting-real-vs-fake.md).

**Original:** The Verge, by Jess Weatherbed, 2026-04-04. URL: theverge.com/tech/906453/human-made-ai-free-logo-creative-content.

The established AI-labelling standard [c2pa](../entities/c2pa.md) has broad industry support (Adobe, Microsoft, Google) but has been *"wholly ineffectual"* in practice — the producers it would expose don't cooperate. Weatherbed catalogues **at least 12** competing human-made labelling schemes. See [human-made-content-labelling](../concepts/human-made-content-labelling.md).

## The labelling landscape

| Scheme | Verification approach | Weakness |
|---|---|---|
| **Made by Human** | Trust-based — downloadable badges | No provenance check |
| **No-AI-Icon** | AI-detection services | *"Notoriously unreliable"* |
| Most schemes | Manual audit of sketches, drafts, process | Labor-intensive; currently the most reliable |
| **[not-by-ai](../entities/not-by-ai.md)** | Voluntary ≥90% human threshold | Claim not verified |
| **[proof-i-did-it](../entities/proof-i-did-it.md)** | On-chain "Made by Human" tokens to verified creators | Relocates the verification problem to the token issuer |
| **Authors Guild** | Human-authored book certification | Industry-specific |
| **[proudly-human](../entities/proudly-human.md)** (CEO Trevor Woods) | Post-hoc legal enforcement | No fraud prevention |

## The definition problem

"Human-made" has no agreed meaning.

- **Jonathan Stray (UC Berkeley CHAI):** *"Does chatting with an LLM about the idea before executing it manually count as using AI? How could the creator prove no AI was involved? 'Organic' has regulations and agencies that enforce them."*
- **Nina Beguš (UC Berkeley):** *"Any creative output today can be touched by AI in one way or another without us being able to prove it. Authorship is disintegrating… We need to revamp our creativity criteria."*

Same problem [layered-authorship](../concepts/layered-authorship.md) surfaces in fiction: AI can touch premise, outline, prose, voice, or final revision, and the label has to decide which combinations still count.

## Coral Hart cameo and a cross-source discrepancy

The Verge cites [coral-hart](../entities/coral-hart.md) as a prominent example of why human-made labels face an uphill fight: six figures from 200+ AI novels, no disclosure because of *"strong stigma"* around the technology.

> ⚠️ **CROSS-SOURCE DISCREPANCY.** The Verge (citing NYT) says Hart *"doesn't have a label on any of her books that discloses they were written using AI tools."* The wiki's [coral-hart](../entities/coral-hart.md) page (sourced from the 2026-04-04 New Yorker essay, which also cites Alexandra Alter's NYT reporting) says she *"sometimes does and sometimes doesn't."* Both secondary sources attribute to the same primary. Without the original NYT article in `raw/`, the wiki can't resolve it. The stronger-stated Verge version is the conservative choice. Flagged on the Hart page.

The Verge's framing sharpens the **non-disclosure-is-economically-rational** half of the reception paradox in [ai-in-creative-writing](../concepts/ai-in-creative-writing.md): Hart isn't hiding because readers wouldn't buy — she's hiding because the label itself would depress sales. The Shy Girl cancellation is evidence she's probably right.

## Why human-made labelling may still fail

Weatherbed is an advocate but honest about the structural problems:

1. **Fragmentation** — 12+ competing standards, no unification.
2. **No enforcement** — Proudly Human CEO concedes only post-hoc legal action is possible.
3. **Regulator gap** — "Organic" / "Fair Trade" need government backing; AI authenticity has none.
4. **Rapid evolution** (Woods): *"AI capabilities will outpace government and regulator responses."*
5. **Adversarial detection loop** — schemes falling back on AI detection inherit all [pangram](../entities/pangram.md)-style unreliability, degrading as models improve.

## Why it matters for this wiki

First source focused on **provenance and authenticity** as a distinct axis from quality, economics, or capability. Intersections:

- Disclosure-regime stress test from [shy-girl-ai-novel](../entities/shy-girl-ai-novel.md) and [coral-hart](../entities/coral-hart.md) now extended to all creative media.
- **[own-your-substrate](../analyses/own-your-substrate.md) applied to trust infrastructure.** Creators who own a verified human-history token own a compounding layer; creators who depend on platform-provided signals (C2PA) do not.
- New economic actor — **certification-mark vendors** — mirror the "pick-and-shovel" pattern of AI-detection firms like Pangram, but on the opposite side of the trust boundary.

## Open questions

- Does any of the 12 schemes have a path to dominance, or does fragmentation persist?
- Is the blockchain-token approach materially more robust, or does it just relocate the verification problem?
- Manual-audit at scale — minimum viable automation AI can't yet fake?
- If the Verge version of Hart's disclosure practice is correct (zero labels, ever), does that reframe her role in [ai-in-creative-writing](../concepts/ai-in-creative-writing.md)?
- What event would force regulators to adopt a unified standard?

## Prompt

> ingest raw/2026-04-05-theverge-Really, you made this without AI Prove it
