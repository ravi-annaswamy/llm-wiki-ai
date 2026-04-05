---
title: "CLASS (Boltzmann solver)"
type: entity
created: 2026-04-04
updated: 2026-04-04
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [software, cosmology, c, reference-implementation, scientific-infrastructure]
status: active
---

# CLASS

The **C**osmic **L**inear **A**nisotropy **S**olving **S**ystem — one of the two canonical Boltzmann solvers used in cosmology, alongside CAMB. Open source, written in C, hosted at [class-code.net](http://class-code.net/) and [github.com/lesgourg/class_public](https://github.com/lesgourg/class_public) (Source: [[sources/2026-04-04-anthropic-long-running-claude-scientific-computing]]).

CLASS evolves the coupled equations for photons, baryons, neutrinos, and dark matter through the early universe to predict statistical properties of the Cosmic Microwave Background. It is **core scientific infrastructure** in cosmology — surveys like *Planck* and the *Simons Observatory* constrain their cosmological models using outputs from CLASS (and CAMB).

## Why the wiki cares

CLASS shows up in this wiki as the **reference implementation that a test oracle was built around**. In the CLAX project ([[entities/clax-project]]), Claude was instructed to use the CLASS C source as the ground truth against which its own differentiable JAX reimplementation would be continuously tested. The accuracy target — 0.1% against CLASS on the main science deliverables — was chosen because 0.1% is the typical level of agreement between CLASS and CAMB themselves, i.e. the floor of what the field considers "correct" for this class of code.

This makes CLASS the canonical concrete example for the [[concepts/test-oracle-for-agents]] concept page: a pre-existing, battle-tested, domain-authoritative implementation whose outputs can be used as gold labels by an agent building a fresh implementation in a new substrate.

## Related

- [[entities/clax-project]]
- [[concepts/test-oracle-for-agents]]
- [[concepts/agent-driven-scientific-computing]]
- [[sources/2026-04-04-anthropic-long-running-claude-scientific-computing]]
