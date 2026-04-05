---
title: "Proof I Did It"
type: entity
created: 2026-04-05
updated: 2026-04-05
sources: ["wiki/sources/2026-04-05-theverge-human-made-labels.md"]
tags: [labelling, blockchain, web3, authenticity, human-made, tokens]
status: active
---

# Proof I Did It

A blockchain-based human-made labelling service that issues on-chain "Made by Human" tokens to verified creators. One of the 12+ schemes surveyed in The Verge's April 2026 overview of the [human-made-content-labelling](../concepts/human-made-content-labelling.md) landscape (Source: [2026-04-05-theverge-human-made-labels](../sources/2026-04-05-theverge-human-made-labels.md)).

## Approach

Creators are verified, then issued an unforgeable digital certificate stored on a public blockchain. The certificate can be referenced by anyone, and because of the blockchain substrate, it cannot be silently revoked, backdated, or stripped by a re-encoder the way [c2pa](c2pa.md) metadata can be.

The framing, offered to The Verge by **Thomas Beyer** (executive director at UC Rady School of Management), is that Web3 enables a **reframing of the verification question**:

> "By issuing 'Made by Human' tokens to verified creators, the market creates a 'premium tier' of art where authenticity is mathematically guaranteed... shifting the question from 'does this look like AI?' to 'can this account prove its human history?'"

Beyer and other quoted experts (notably Nina Beguš at UC Berkeley) predict that as synthetic media floods the open internet, **human and biological creativity** will gain premium market value, and blockchain-verified creator identity is one way to capture that premium.

## Strengths vs weaknesses

**Strength:** Unlike C2PA, the attestation is anchored to a creator's persistent identity, not to metadata embedded in a file. A creator who accumulates a long on-chain history of verified works has a compounding identity asset that travels across platforms — an [own-your-substrate](../analyses/own-your-substrate.md) instance at the individual creator level.

**Weakness:** Blockchain does not solve the hard problem; it only relocates it. The token is non-forgeable *after* issuance, but *at issuance time* the service still has to verify that a human made the work. That verification step has the same failure modes as every other scheme on [human-made-content-labelling](../concepts/human-made-content-labelling.md) — manual audit, AI detection, or trust. Blockchain guarantees the record, not the premise.

## Relevance

Proof I Did It is the scheme most clearly gesturing at a *long-term* solution rather than a snapshot label. A creator's on-chain history over years is harder to fake than any single file's metadata, even if any individual attestation can be compromised. This is the closest the current landscape comes to treating human-made status as a reputation stream rather than a badge.

## Related

- [human-made-content-labelling](../concepts/human-made-content-labelling.md)
- [fingerprinting-real-vs-fake](../concepts/fingerprinting-real-vs-fake.md)
- [c2pa](c2pa.md)
- [own-your-substrate](../analyses/own-your-substrate.md)
- [2026-04-05-theverge-human-made-labels](../sources/2026-04-05-theverge-human-made-labels.md)
