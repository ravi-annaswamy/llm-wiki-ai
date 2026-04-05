---
title: "CLASS (Boltzmann solver)"
type: entity
created: 2026-04-04
updated: 2026-04-05
sources: ["wiki/sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md"]
tags: [software, cosmology, c, reference-implementation, scientific-infrastructure]
status: active
---

# CLASS

> **Cosmic Linear Anisotropy Solving System — one of the two canonical Boltzmann solvers in cosmology (alongside CAMB).** Core scientific infrastructure for CMB surveys (*Planck*, *Simons Observatory*); the reference implementation around which the CLAX test oracle was built.

Open source C code at [class-code.net](http://class-code.net/) and [github.com/lesgourg/class_public](https://github.com/lesgourg/class_public). Evolves coupled equations for photons, baryons, neutrinos, and dark matter through the early universe to predict CMB statistical properties.

## Why the wiki cares

CLASS is the canonical concrete example for [test-oracle-for-agents](../concepts/test-oracle-for-agents.md): a pre-existing, battle-tested, domain-authoritative implementation whose outputs serve as gold labels. In [clax-project](clax-project.md), Claude was instructed to use CLASS as ground truth against which its differentiable JAX reimplementation was continuously tested. The 0.1% accuracy target matches the typical CLASS↔CAMB agreement level — the field's floor for "correct."

## Related

- **Used by:** [clax-project](clax-project.md)
- **Concept:** [test-oracle-for-agents](../concepts/test-oracle-for-agents.md)
- **Adjacent:** [agent-driven-scientific-computing](../concepts/agent-driven-scientific-computing.md)
- **Source:** [2026-04-04-anthropic-long-running-claude-scientific-computing](../sources/2026-04-04-anthropic-long-running-claude-scientific-computing.md)
