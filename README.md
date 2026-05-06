# Sub-Powers

Sub-Powers is a lightweight engineering workflow for AI coding agents. It is designed for people who want the discipline of Superpowers without turning every change into a heavyweight process.

It works best for Python-first engineering, full-stack product work, debugging existing repositories, and algorithm/performance work where correctness, logs, tests, and resource measurements matter.

## What It Does

Sub-Powers separates two things that are often mixed together:

- **Routing and boundaries**: what kind of task is this, and how far may the agent go?
- **Execution discipline**: how should the agent code, debug, test, review, optimize, and verify?

The result is a smaller, sharper workflow:

- Full 0-to-1 workflow only when there is a real new product, architecture, data-contract, algorithm, or cross-module boundary.
- Existing-code work stays small: small feature, debug, build, E2E, code quality, performance, review, or verification.
- Debugging starts from evidence and root cause, not guesses.
- Performance work starts from measurement, CPU/GPU/resource use, and correctness protection.
- Review is risk checking, not rewriting.
- Completion requires fresh verification evidence.

## Why Not Just ECC Or Plain Superpowers?

ECC-style agent bundles can be powerful, but they often bring many agents, broad triggers, and overlapping responsibilities. That can be useful for large organizations, but it can also make everyday coding noisy.

Plain Superpowers gives strong process skills, but its default boundaries can be too broad for daily work in existing repositories.

Sub-Powers keeps the useful parts and tightens the edges:

| Area | ECC-style bundles | Plain Superpowers | Sub-Powers |
| --- | --- | --- | --- |
| Daily small changes | Can over-route into many agents | Can over-trigger design/planning | Small Feature path stays light |
| Debugging | Depends on agent choice | Strong root-cause skill | Root cause plus strict boundary discipline |
| Refactor | May become broad rewrite | Good if invoked carefully | Behavior-preserving Code Quality path |
| Performance | Often generic | Debug-oriented | Adds CPU/GPU, VRAM, I/O, batching, indexing, benchmark reproducibility |
| Completion | Varies | Strong verification skill | Verification mapped by task type |
| Token use | Can be high | Medium/high if every skill triggers | AGENTS is routing, details live in one local skill |
| Boundary control | Agent dependent | Skill dependent | Explicit no-silent-expansion rules |

## Repository Layout

```text
sub-powers/
├── skills/
│   └── sub-powers-engineering/
│       └── SKILL.md
├── templates/
│   ├── codex/
│   │   └── AGENTS.md
│   └── claude/
│       └── CLAUDE.md
├── docs/
│   └── tasks/
└── logs/
```

## Install For Codex

Quick install:

```bash
./install-codex.sh /path/to/your/repo
```

Manual install:

Copy the skill into your Codex skills directory:

```bash
mkdir -p ~/.codex/skills/sub-powers-engineering
cp skills/sub-powers-engineering/SKILL.md ~/.codex/skills/sub-powers-engineering/SKILL.md
```

Copy the Codex project rule file into a repository:

```bash
cp templates/codex/AGENTS.md /path/to/your/repo/AGENTS.md
```

Restart Codex so the new skill appears in the available skills list.

## Install For Claude Code

Copy the Claude template into a repository:

```bash
cp templates/claude/CLAUDE.md /path/to/your/repo/CLAUDE.md
```

Claude does not use Codex skills directly, so the Claude template includes the key Sub-Powers rules inline.

## Core Workflows

Sub-Powers routes work into one of these entrypoints:

- **Full 0-to-1**: new systems, product surfaces, architectures, data contracts, algorithm/retrieval/indexing systems.
- **Small Feature**: normal product/code increments inside existing modules.
- **Debug**: bugs, failures, tracebacks, broken scripts, suspicious behavior.
- **Build**: build/typecheck/install/dependency/migration/dev-server/service startup failures.
- **Workflow Test**: whole-flow, page/API flow, smoke, integration, E2E validation.
- **Code Quality**: cleanup, readability, duplication, defensive checks, local refactor.
- **Performance**: algorithm, indexing, I/O, database, memory/VRAM, CPU/GPU, latency, throughput, batch bottlenecks.
- **Review**: risk check, quality inspection, safety check, merge readiness.
- **Completion Verification**: proof before saying done, fixed, passing, ready, or safe.

## Core Engineering Rules

- Keep code concise and readable.
- Each function should do one thing well.
- Use clear names; avoid unconscious abbreviations.
- Reduce unnecessary variables.
- Reduce nesting with guard clauses, early returns, or small helpers when clearer.
- Reuse existing helpers and patterns.
- If similar logic appears more than twice, extract a reusable function or module with clear responsibility.
- Validate external input, API responses, files, config, and runtime assumptions.
- Handle exceptions explicitly and avoid silent failures.

## Debug Boundary

Debugging follows:

```text
read error -> reproduce -> narrow scope -> inspect logs/docs/task notes -> root cause -> minimal fix -> verify
```

The agent should not modify code outside the confirmed failure boundary unless evidence proves it is part of the root cause.

## Performance Boundary

Performance work starts with measurement:

```text
baseline -> suspected hot path -> resource utilization -> measurement method -> correctness risk
```

When relevant, inspect CPU/GPU utilization, memory/VRAM, I/O wait, throughput, latency, batch size, algorithm complexity, data loading, preprocessing, serialization, CPU-GPU transfer, batching, caching, indexing, concurrency, and benchmark reproducibility.

## Traceability

Use:

- `docs/design.md` for durable architecture, data, workflow, algorithm, retrieval, indexing, or cross-module design.
- `docs/tasks/YYYY-MM-DD-HHMM-<topic>.md` for meaningful behavior, bug, performance, API, data, algorithm, permission, or error-handling changes.
- `logs/` for local runtime logs when the application writes diagnostic files.

Tiny self-evident edits can skip task notes.

## Status

Sub-Powers is intentionally small. It is not trying to replace every specialized agent. It is a boundary and execution layer for people who want AI coding agents to be more disciplined, less noisy, and easier to debug later.
