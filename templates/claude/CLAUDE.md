# Sub-Powers Claude Workflow

Sub-Powers is a boundary-first workflow for AI coding agents. Claude does not load Codex skills directly, so this file keeps the same entrypoints inline.

## Entry Routing

- New product surface, service, workflow, architecture, data contract family, algorithm/retrieval/indexing system, or cross-module ownership: Boundary / 0-to-1.
- Approved boundary with multiple files, ordered tasks, spec, or worktree need: Planning.
- Small existing-code feature: Coding.
- Bug, failure, traceback, broken script, build/startup failure, or unexpected behavior: Debugging.
- Cleanup, readability, duplication removal, local refactor, defensive checks, maintainability: Quality.
- Algorithm, indexing, I/O, database, memory/VRAM, CPU/GPU, latency, throughput, batch bottleneck: Performance.
- Review, risk check, quality inspection, safety check, merge readiness: Review.
- Before claiming done, fixed, safe, passing, ready, or verified: Verification.

## Boundary / 0-to-1

- Use only for real new boundaries.
- Clarify actor, problem, smallest useful version, scope, non-goals, deferred work, reuse, entities/contracts, workflow states, risks, tests, verification, and open questions.
- Downgrade if it is one local behavior change that fits an existing module.

## Planning

- Start only after approved design/spec and enough code context.
- Name concrete files, modules, functions/classes, data contracts, tests, commands, and dependency order.
- Mark work parallel only when tasks do not share files, state, or hidden dependencies.
- Downgrade to direct implementation if the plan would be heavier than the change.

## Coding

- Keep code concise and readable.
- Each function should do one thing well.
- Use clear names; avoid unconscious abbreviations.
- Reduce unnecessary variables and nesting.
- Reuse existing helpers, components, schemas, tests, styles, and error patterns.
- Extract repeated logic only when similar logic appears more than twice and the abstraction has clear responsibility.
- Validate external input, API responses, files, config, and runtime assumptions.
- Handle exceptions explicitly and avoid silent failures.

## Debugging

```text
read error -> reproduce -> narrow scope -> inspect logs/docs/task notes -> root cause -> minimal fix -> verify
```

- Do not modify code outside the confirmed failure boundary unless evidence proves it is part of the root cause.
- Do not mix bug fixes with unrelated cleanup, redesign, performance optimization, dependency upgrades, formatting, or style changes.
- Required output: observed failure, expected behavior, affected path, root cause, minimal fix, verification, remaining risk.

## Quality

- Preserve behavior unless the user explicitly approves behavior change.
- Output quality target, affected files, expected unchanged behavior, verification, deferred cleanup.
- Do not mix quality work with features, performance, dependency work, or stylistic rewrites.

## Performance

- Correctness comes before speed.
- Output baseline, suspected hot path, resource utilization, measurement method, correctness risk, after result, measurement limits, remaining bottlenecks.
- Inspect CPU/GPU utilization, memory/VRAM, I/O wait, throughput, latency, batch size, algorithm complexity, data loading, preprocessing, serialization, CPU-GPU transfer, batching, caching, indexing, concurrency, and benchmark reproducibility when relevant.
- Optimize only measured hot paths.
- Do not mix optimization with unrelated cleanup, redesign, dependency upgrades, or behavior changes.

## Review

- Review is risk checking, not rewriting.
- Review only scoped diff/files unless evidence connects other files.
- Findings must be concrete and backed by code, tests, spec, logs, runtime behavior, or clear reasoning.
- Reject or defer speculative, stylistic, out-of-scope, or task-expanding feedback.
- Fix only the finding boundary.

## Verification

- Verify against the original success signal.
- Code: run the narrowest relevant test, typecheck, lint, or command.
- UI: run local browser flow or screenshot when practical.
- Debug/build: rerun original failing command or path.
- Performance: report before/after plus correctness verification; include CPU/GPU and memory/VRAM when relevant.
- Docs/artifacts: render or inspect produced output.
- Config/deploy: run dry-run, status, validation, or health check when available.
- Report command/workflow/artifact checked, passed, failed, not verified, and confidence level.
- Do not claim full completion after partial verification.

## Documentation Discipline

- Default: do not create files for intermediate reasoning, debug context, performance snapshots, review notes, verification reports, or tool outputs.
- Allowed persistent files: `README.md`, `docs/design.md`, and `docs/tasks/YYYY-MM-DD-HHMM-<topic>.md`.
- Write `docs/design.md` only for durable design: 0-to-1, architecture, data contracts, algorithm/index/retrieval systems, or cross-module workflows.
- Write `docs/tasks/*` only after meaningful final code changes.
- Skip task notes for formatting, copy/style tweaks, tiny self-evident edits, no-behavior changes, or when the note would be longer than the change.
- Show debug context and performance snapshots in chat or via commands; do not save them by default.
