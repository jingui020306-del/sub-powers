# Sub-Powers

Sub-Powers is a boundary-first engineering workflow for AI coding agents.

It is built for people who want AI agents to be useful in real repositories without over-planning every small change or silently expanding scope during debugging, refactoring, performance work, and review.

## Core Idea

Sub-Powers separates routing from execution:

- `AGENTS.md` or `CLAUDE.md` chooses the entrypoint.
- `sub-powers-*` skills hold the execution discipline.
- Tools and MCP are optional implementation details, not the workflow itself.

This gives you multiple clear entrypoints instead of one giant agent.

## Skills

```text
skills/
├── sub-powers-boundary/       # 0-to-1 boundary and design clarification
├── sub-powers-planning/       # spec, worktree, planning, task decomposition
├── sub-powers-coding/         # small features and coding discipline
├── sub-powers-debugging/      # evidence-first root cause debugging
├── sub-powers-quality/        # behavior-preserving refactor and cleanup
├── sub-powers-performance/    # measurement-first optimization
├── sub-powers-review/         # risk-focused review
└── sub-powers-verification/   # completion evidence gate
```

## Why Not Just ECC Or Plain Superpowers?

ECC-style bundles can bring many agents and overlapping responsibilities. That can be powerful, but it can also make normal coding noisy.

Plain Superpowers has strong process skills, but its default triggers can be too broad for everyday existing-code work.

Sub-Powers keeps the useful discipline and tightens the boundaries:

| Area | ECC-style bundles | Plain Superpowers | Sub-Powers |
| --- | --- | --- | --- |
| Daily small changes | Can over-route | Can over-trigger design/planning | Uses `sub-powers-coding` |
| Debugging | Agent-dependent | Strong root-cause skill | Uses `sub-powers-debugging` with strict boundary control |
| Refactor | Can become rewrite | Good if scoped | Uses `sub-powers-quality` to preserve behavior |
| Performance | Often generic | Debug-oriented | Uses `sub-powers-performance` with CPU/GPU, VRAM, I/O, batching, reproducibility |
| Review | Varies | Strong if invoked | Uses `sub-powers-review` as risk check, not rewrite |
| Completion | Varies | Strong verification | Uses `sub-powers-verification` as evidence gate |
| Token use | Can be high | Can be broad | Router stays small; details load only by skill |

## Install For Codex

Quick install:

```bash
./install-codex.sh /path/to/your/repo
```

Manual install:

```bash
for skill in skills/sub-powers-*; do
  name="$(basename "$skill")"
  mkdir -p "$HOME/.codex/skills/$name"
  cp "$skill/SKILL.md" "$HOME/.codex/skills/$name/SKILL.md"
done

cp templates/codex/AGENTS.md /path/to/your/repo/AGENTS.md
```

Restart Codex so the skills appear in the available skills list.

## Install For Claude Code

Claude does not use Codex skills directly. Copy the Claude project memory:

```bash
cp templates/claude/CLAUDE.md /path/to/your/repo/CLAUDE.md
```

The Claude template mirrors the same entrypoint structure in one file.

## Entry Routing

- **Boundary / 0-to-1**: new product, service, workflow, architecture, data contract, algorithm/retrieval/indexing system.
- **Planning**: approved spec/design needs files, tasks, tests, commands, dependency order, worktree, or OpenSpec-style artifact.
- **Coding**: small features and normal code increments.
- **Debugging**: bugs, failures, tracebacks, broken scripts, build/startup failures.
- **Quality**: cleanup, readability, duplication, local refactor, defensive checks.
- **Performance**: CPU/GPU, memory/VRAM, I/O, database, indexing, throughput, latency, batch bottlenecks.
- **Review**: risk check, quality inspection, safety check, merge readiness.
- **Verification**: proof before saying done, fixed, passing, ready, or safe.

## Debug Boundary

```text
read error -> reproduce -> narrow scope -> inspect logs/docs/task notes -> root cause -> minimal fix -> verify
```

The agent should not modify code outside the confirmed failure boundary unless evidence proves it is part of the root cause.

## Performance Boundary

```text
baseline -> suspected hot path -> resource utilization -> measurement method -> correctness risk -> after result
```

When relevant, inspect CPU/GPU utilization, memory/VRAM, I/O wait, throughput, latency, batch size, algorithm complexity, data loading, preprocessing, serialization, CPU-GPU transfer, batching, caching, indexing, concurrency, and benchmark reproducibility.

## Traceability

- Use `docs/design.md` for durable architecture, data, workflow, algorithm, retrieval, indexing, or cross-module design.
- Use `docs/tasks/YYYY-MM-DD-HHMM-<topic>.md` for meaningful behavior, bug, performance, API, data, algorithm, permission, or error-handling changes.
- Use `logs/` for local runtime logs when the application writes diagnostic files.
- Tiny self-evident edits can skip task notes.

## MCP Status

Sub-Powers is not an MCP server today.

The current layer is:

```text
AGENTS.md / CLAUDE.md -> entrypoint routing
sub-powers-* skills -> execution discipline
tools/plugins/shell/tests/logs -> concrete actions
```

Future MCP tools can be added for deterministic actions such as creating task notes, collecting debug context, running benchmarks, or generating verification reports.

## Status

Sub-Powers is intentionally small and modular. It is not trying to replace every specialized agent. It is a workflow layer for making AI coding agents more disciplined, less noisy, and easier to debug later.
