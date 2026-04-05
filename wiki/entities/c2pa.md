---
title: "C2PA (Coalition for Content Provenance and Authenticity)"
type: entity
created: 2026-04-05
updated: 2026-04-05
sources: ["wiki/sources/2026-04-05-theverge-human-made-labels.md"]
tags: [provenance, authenticity, standard, ai-labelling, adobe, microsoft]
status: active
---

# C2PA

The Coalition for Content Provenance and Authenticity, and the **content credentials standard** of the same name. C2PA is the most industry-backed attempt to establish a machine-readable provenance metadata format for digital media. Its goal is to let AI-generated content (and edited content generally) carry a cryptographic trail of who made it, how, and with what tools (Source: [2026-04-05-theverge-human-made-labels](../sources/2026-04-05-theverge-human-made-labels.md)).

## Status

- **Committed members include:** Adobe, Microsoft, Google, Meta.
- **Deployment:** Already used by Meta's platforms.
- **Verdict from The Verge (April 2026):** "wholly ineffectual, despite having received broad industry support."

## Why it has failed in practice

C2PA is a voluntary-cooperation standard that asks the producers of AI content to mark their output. The commercial incentives run in the opposite direction: AI influencers, synthetic-porn accounts, [coral-hart](coral-hart.md)-style novel factories, Etsy scammers, and political-mischief accounts all lose revenue or reach if their content is labelled. Broad corporate commitment at the tool-vendor level does not translate into end-user participation when the end-user's business model is incompatible with disclosure.

Additionally, C2PA metadata is fragile to re-encoding: platforms that don't preserve the metadata (intentionally or as a side effect of image compression / transcoding) strip the provenance trail, giving producers plausible deniability even when their tools initially wrote the metadata.

This is the empirical motivation for [fingerprinting-real-vs-fake](../concepts/fingerprinting-real-vs-fake.md) — the argument that labelling works only when aligned with the producers' incentives.

## Relevance to this wiki

C2PA is the counterexample that makes the case for [human-made-content-labelling](../concepts/human-made-content-labelling.md) intelligible. It has everything human-made schemes lack — industry unification, vendor backing, platform deployment — and it still fails. The inference The Verge draws is that the problem is not technical or coordinational but motivational.

## Related

- [fingerprinting-real-vs-fake](../concepts/fingerprinting-real-vs-fake.md)
- [human-made-content-labelling](../concepts/human-made-content-labelling.md)
- [2026-04-05-theverge-human-made-labels](../sources/2026-04-05-theverge-human-made-labels.md)
