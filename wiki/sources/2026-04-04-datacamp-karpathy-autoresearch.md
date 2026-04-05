---
title: "DataCamp — A Guide to Andrej Karpathy's AutoResearch"
type: source
created: 2026-04-04
updated: 2026-04-04
sources: ["raw/2026-04-04-datacamp-A Guide to Andrej Karpathy’s AutoResearch Automating ML with AI Agents.md"]
tags: [karpathy, autoresearch, automated-research, agentic-engineering, ratchet-loop, producer-filter, ml-training, long-running-agentic-coding]
status: active
---

# DataCamp — A Guide to Andrej Karpathy's AutoResearch

**Original:** DataCamp tutorial by Bex Tuychiev (published 2026-03-22, clipped 2026-04-04) walking through [andrej-karpathy](../entities/andrej-karpathy.md)'s [autoresearch](../entities/autoresearch.md) project: an MIT-licensed open-source tool released 2026-03-07 that lets an AI coding agent run ML experiments overnight on a single GPU, keeping only changes that improve validation loss.

> **Meta note:** This source is the wiki's first clean instance of the producer–filter pattern applied to **ML research itself**. It also extends Karpathy's methodological arc (already represented here via [llm-knowledge-bases](../concepts/llm-knowledge-bases.md)) from knowledge management into automated experimentation. The two patterns share a common architecture: a durable artifact repository, an automatic filter, and an LLM whose role is to produce new artifacts the filter can judge.

## The core idea

AutoResearch is not hyperparameter tuning and not neural architecture search. Tools like Optuna, Ray Tune, and AutoML search a predefined parameter space with mathematical guarantees. AutoResearch instead gives an LLM coding agent freedom to modify arbitrary code inside a single file, and relies on the LLM's general knowledge to propose good experiments. The search space is "whatever the LLM can think of." The project reached 21,000+ GitHub stars and 8.6M views on Karpathy's announcement within days of release.

Comparison to adjacent systems:
- **AutoML / NAS** — precise but constrained to their predefined search space.
- **[alphaevolve](../entities/alphaevolve.md) (DeepMind)** — evolutionary approach with Gemini as mutation operator, but closed-source.
- **General coding agents (SWE-Agent, OpenHands, Aider)** — can write arbitrary code but aren't built for the experiment-evaluate-keep/revert loop.

AutoResearch bets on LLM general knowledge over search-space constraints. See [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md) for the broader family.

## The three-file architecture

A contract between three files with strict rules about who can touch each:

| File | Role | Mutable by |
|---|---|---|
| `prepare.py` | Data prep + evaluation. Builds the BPE tokenizer (8,192-vocab), processes the training corpus, defines `val_bpb` (validation bits-per-byte) — the yardstick. | **Immutable.** Neither human nor agent touches it. This guarantees every experiment is measured identically. |
| `train.py` | The agent's sandbox: 630 lines containing the GPT model, `Muon+AdamW` optimizer, and full training loop. | **Agent only.** Can rewrite anything — activations, attention, LR schedules, initialization — as long as the code still trains and emits a `val_bpb`. |
| `program.md` | Plain Markdown. Tells the agent what research directions to pursue, what to avoid, how to handle failures, baseline metrics to beat. | **Human only.** |

This is a clean separation of concerns: **the human sets research direction, the agent executes, and `prepare.py` is a neutral judge neither side can corrupt.** The immutability of the evaluator is the structural guarantee that experimental results are comparable across the entire run.

`program.md` hardcodes the baseline (`val_bpb`: 0.997900, peak VRAM: 45 GB), the failure-handling policy (fix typos and retry; skip ideas broken at the root; kill anything past 10 minutes), and two directives that shape everything else:

- **"NEVER STOP. Once the experiment loop has begun, do NOT pause to ask the human if you should continue."**
- **"All else being equal, simpler is better. A small improvement that adds ugly complexity is not worth it."**

The first is the scaffold against [agentic-laziness](../concepts/agentic-laziness.md); the second steers the agent away from over-engineered changes a human reviewer would reject.

## The ratchet loop

The experiment cycle runs without human input. Each iteration:

1. Agent reads `program.md` for priorities and constraints.
2. Examines current `train.py` and recent `results.tsv`.
3. Proposes a hypothesis (architecture change, optimizer tweak, training modification).
4. Modifies `train.py`.
5. Commits to a git branch.
6. Runs training for **exactly 5 minutes** (fixed wall-clock budget).
7. If it crashes, logs the failure, reverts, retries.
8. Evaluates `val_bpb`, records in `results.tsv`.
9. If `val_bpb` improved → commit stays. Otherwise → `git reset HEAD~1`.

Goto 1.

The name comes from the git history: successful experiments add commits, failures are reverted. The codebase can only move forward. At ~12 experiments per hour, an overnight run produces roughly 80–100 experiments with 15–20 improvements kept.

The fixed 5-minute budget matters: a change that trains faster and a change that converges lower are evaluated on equal footing. It is also a constraint — changes that would only prove themselves over longer training remain invisible.

See [ratchet-loop](../concepts/ratchet-loop.md) for the general pattern and its structural limits.

## Git and results.tsv as agent memory

`results.tsv` tracks every experiment: commit hash, `val_bpb`, peak VRAM, pass/fail, and a description of what was tried. The agent reads it (and the git history) to build on whatever showed promise. This resembles an evolutionary algorithm in structure but keeps a **single lineage** rather than a population. The LLM serves as both the mutation operator (proposing changes) and the selection pressure (choosing what to try next based on past results).

This is the same structural move as the `CHANGELOG.md` / `CLAUDE.md` pair in [agent-persistent-memory](../concepts/agent-persistent-memory.md): an on-disk, legible, portable record the agent consults at session start. Git history plus a TSV is doing the work a hidden vector-store memory would do in a typical agent framework — and doing it in a form the human can audit in the morning.

## Getting started (operational specifics)

Requirements: NVIDIA GPU (default config assumes 20+ GB VRAM), Python 3.10+, `uv`, a coding agent (Claude Code, Cursor, or similar).

```bash
git clone https://github.com/karpathy/autoresearch.git
cd autoresearch
uv sync
uv run prepare.py
```

There is no orchestration script. No `run.py`, no framework. The README says: *"simply spin up your Claude/Codex or whatever you want in this repo."* You open a coding agent, prompt it to read `program.md`, and the loop runs. **The LLM is the automation layer.** Watch progress by tailing `results.tsv` or `git log`.

For smaller hardware, Karpathy recommends TinyStories with vocab=256 and depth=4.

## Results across runs

| Run | Experiments | Improvements kept | Result |
|---|---|---|---|
| Initial overnight (single GPU) | 83 | 15 | `val_bpb` 1.000 → 0.975 |
| Extended 2-day run (depth-12) | ~700 | ~20 | All additive; transferred to depth-24 |
| Production impact (nanochat) | — | — | Time-to-GPT-2 benchmark: 2.02h → 1.80h (11% faster) |
| Community session | 126 | — | `val_bpb` 0.9979 → 0.9697 |

Specific mechanisms the agent found (structural code changes, not hyperparameter sweeps):
- `QKnorm` missing a scaler multiplier for attention sharpening.
- Value Embeddings benefit from regularization.
- Banded attention tuning gains.
- `AdamW` beta parameter adjustments.
- Weight decay scheduling improvements.

Tobi Lutke (Shopify CEO) adapted AutoResearch for an internal query-expansion model: **19% validation improvement from 37 experiments on a 0.8B-parameter model, reported the day after he started.**

Karpathy himself runs a "bigger cousin" of AutoResearch on 8×H100 GPUs against his production `nanochat` framework — evidence the pattern scales beyond toy experiments.

## The creativity ceiling

The source is admirably direct about limits. The staircase of `val_bpb` improvements is real, but **each step is small**. Nobody has reported AutoResearch inventing a novel attention mechanism or architectural idea a human researcher wouldn't eventually arrive at.

[GitHub issue #22](https://github.com/karpathy/autoresearch/issues/22) captures the structural problem: the agent cycles through minor variations of whatever worked last, stuck in a local search pattern. The **ratchet only accepts immediate improvements**, so the agent can never take a step backward to set up a larger gain — the "it'll get worse before it gets better" move that human researchers routinely make has no home in the filter.

Karpathy, on Hacker News, acknowledged a related issue: the agent feels **"cagy and scared"** on open-ended problems, which he attributes to [RLHF](https://www.datacamp.com/courses/reinforcement-learning-from-human-feedback-rlhf) training rewarding safe outputs. The agent is capable of proposing bold changes but built to play it safe.

Additional structural limits:
- **Fixed 5-minute window.** Long-horizon improvements are invisible to the filter.
- **Overfitting risk.** 100+ experiments against the same eval set can produce gains specific to that eval.
- **Immutability of `prepare.py`** — the system's fairness guarantee is also its blind spot.

Proposed remedies debated in the community: meta-prompt optimization (a second agent rewrites `program.md` based on results), diversity directives that reward novelty alongside improvement, periodic "reset" experiments from earlier checkpoints.

See [llm-research-creativity-ceiling](../concepts/llm-research-creativity-ceiling.md).

## The methodological arc

Karpathy frames AutoResearch as a step in a progression he's been building for years:

1. **Vibe coding** (his earlier coinage) — human prompts, AI writes code, human reviews.
2. **Agentic engineering** (coined February 2026) — *"You are not writing the code directly 99% of the time. You are orchestrating agents who do and acting as oversight."*
3. **Independent research** — the human doesn't even orchestrate. They describe what good research looks like in a Markdown file and walk away.

Each step reduces the human's role: writer → director → research advisor. His follow-up framing: *"The goal is not to emulate a single PhD student, it's to emulate a research community of them"* — with a gesture toward SETI@home-style distributed agent collaboration.

See [agentic-engineering](../concepts/agentic-engineering.md).

## When to use AutoResearch — and when not to

The three-file contract transfers beyond LLM training to any domain with an automatic scoring function: search ranking, product categorization, clinical NER, fraud scoring, intent classification. Small models that train fast, clear scoring, and improvements that transfer when you scale up — these share the right traits.

When experiments run 100× faster than a human can manage, **the eval pipeline becomes the constraint**. Static benchmarks saturate; teams need eval sets that evolve with production data.

For problems requiring genuine novelty, the creativity ceiling applies. AutoResearch automates the **methodical** part of ML research — running and evaluating hundreds of small experiments — and doesn't replace the creative part of formulating new directions, which is still a human job. The tutorial's closing sentence captures the tension: *"If the next generation of engineers skips that formative work because agents handle it now, the field will have plenty of compute and no one with the experience to point it in the right direction."*

## Cross-references into this wiki

- AutoResearch is an instance of the [producer-filter-pattern](../analyses/producer-filter-pattern.md). Producer: the LLM coding agent. Artifact: git commits to `train.py`. Filter: `val_bpb` measured by the immutable `prepare.py`. It is the wiki's cleanest example so far of a filter that is **literally uncircumventable** by the producer, because the producer has no write access to the evaluator.
- It extends [llm-driven-algorithm-discovery](../concepts/llm-driven-algorithm-discovery.md) from algorithm-class search (AlphaEvolve over MARL solvers) to full training-loop search (AutoResearch over GPT training code). Same family; looser search space; no evolutionary population (single lineage only).
- It is a textbook instance of [long-running-agentic-coding](../concepts/long-running-agentic-coding.md): well-scoped, quantifiable success criterion, occasional oversight. The `program.md` file is the AutoResearch-specific equivalent of the `CLAUDE.md` portable plan, and the `results.tsv` + git history are the equivalents of the `CHANGELOG.md` cross-session memory. See [agent-persistent-memory](../concepts/agent-persistent-memory.md).
- The "NEVER STOP" directive is a targeted countermeasure against [agentic-laziness](../concepts/agentic-laziness.md), playing the role the [ralph-loop](../concepts/ralph-loop.md) plays in other scaffolds.
- On the task-shape → topology axis: AutoResearch is a **single sequential lineage**, like [clax-project](../entities/clax-project.md) and unlike the [anthropic-c-compiler-project](../entities/anthropic-c-compiler-project.md) swarm. It would parallelize to a population-based search trivially, but Karpathy deliberately kept it single-lineage for a ratchet-style filter.

## Key figures to remember

- Released 2026-03-07; 21,000+ GitHub stars within days.
- 5-minute per-experiment budget → ~12 experiments/hour → 80–100 per overnight run.
- Initial run: 83 experiments, 15 improvements, `val_bpb` 1.000 → 0.975.
- Production impact: nanochat time-to-GPT-2 from 2.02h → 1.80h (11% faster).
- Shopify result: 19% validation improvement, 37 experiments, 0.8B-param query-expansion model, reported day 1.
- Karpathy's production setup: 8×H100 GPUs running a "bigger cousin" of AutoResearch against nanochat.

## Prompt that produced this page

> ingest raw/2026-04-04-datacamp-A Guide to Andrej Karpathy's AutoResearch Automating ML with AI Agents
