---
name: sub-powers-engineering
description: Use when applying the Sub-Powers workflow in any code project for coding, debugging, build failures, refactoring, performance optimization, review, or completion verification. Provides execution rules that keep project memory lightweight while preserving boundary discipline, traceability, testability, logging, and performance diagnostics.
metadata:
  short-description: Sub-Powers engineering workflow overlays
---

# Sub-Powers Engineering

Use this skill as the execution overlay for projects that adopt Sub-Powers. `AGENTS.md` chooses the entrypoint; this skill carries the execution details.

## Core Coding Rules

- Keep code concise and readable.
- Each function should do one thing well.
- Avoid unconscious abbreviations; prefer clear variable, function, and module names.
- Reduce unnecessary variables.
- Reduce nesting with early returns, guard clauses, and small helpers when clearer.
- Reuse existing helpers, components, schemas, tests, styles, and error patterns.
- If similar logic appears more than twice, extract an independent reusable function or module when the abstraction has a clear responsibility.
- Validate external input, API responses, files, config, and runtime assumptions.
- Handle exceptions explicitly and avoid silent failures.

## Boundary Discipline

- Use the smallest entrypoint that fits.
- Do not expand a task silently.
- Do not mix bug fixes with unrelated cleanup, redesign, performance optimization, dependency upgrades, formatting, or style changes.
- Do not modify code outside the confirmed boundary unless evidence proves it is part of the root cause.
- Record broader issues as follow-ups instead of hidden extra changes.

## 0-to-1 and Design

- Full brainstorming is reserved for new product surfaces, services, major workflows, architecture boundaries, data contract families, algorithm/retrieval/indexing systems, or unclear cross-module ownership.
- Existing-code work starts with a short local boundary check. If it is one small behavior change that fits an existing module and stable pattern, downgrade to the small-feature flow.
- A 0-to-1 design summary must cover problem, scope, non-goals, entities/contracts, workflow states, reuse plan, risks, tests, verification, and open questions.

## Planning

- Start planning only after approved spec/design and enough code context.
- Inspect existing patterns before planning new modules.
- Plans must name concrete files, modules, functions/classes, data contracts, tests, commands, and dependency order.
- Mark work parallel only when tasks do not share files, state, or hidden dependencies.
- Include where TDD starts, where logs/errors are needed, and how each step is verified.
- Downgrade to direct implementation if the plan would be heavier than the change.

## Debugging

- Sequence: read error -> reproduce -> narrow scope -> inspect logs/docs/task notes -> root cause -> minimal fix -> verify.
- Required output: observed failure, expected behavior, affected path, root cause, minimal fix, verification, remaining risk.
- Use `docs/design.md`, `docs/tasks/`, and `logs/` before inventing a new explanation.
- Add targeted logs or debug points only where they reduce uncertainty.
- If multiple failures are independent, they may be investigated in parallel; otherwise debug from the primary failure.

## TDD and Tests

- Use TDD for testable behavior changes: features, bug fixes, contracts, algorithms, validation, permissions, and data transformations.
- Prefer unit tests for pure logic and focused integration tests for API/database/workflow boundaries.
- Structure tests so future agents can quickly identify the failed module or behavior.
- Do not test private implementation details when public behavior can be tested.
- Do not write brittle tests that only mirror current code structure.
- If no meaningful test path exists, record the reason and verify another way.

## Logging and Traceability

- Use `docs/design.md` for 0-to-1 work, new architecture, new data contracts, new algorithm/index/retrieval systems, or cross-module workflows.
- Use `docs/tasks/YYYY-MM-DD-HHMM-<topic>.md` for behavior changes, bug fixes, performance work, multi-file changes, or changes to data/API/algorithm/permission/error handling.
- Task notes should state what changed, what did not change, why, affected files/modules, verification run, and risks/follow-ups.
- Skip task notes for formatting, copy/style tweaks, tiny self-evident edits, no-behavior changes, or when the note would be longer than the change.
- Runtime code in services, jobs, scripts, workflows, async pipelines, or long-running processes should log phase, input identity, failure point, fallback, retry, and partial completion without secrets.
- Prefer `logs/` for local runtime logs when the app writes files.

## Performance

- Correctness comes before speed.
- Start with baseline, suspected hot path, resource utilization, measurement method, and correctness risk.
- Inspect CPU/GPU utilization, memory/VRAM, I/O wait, throughput, latency, batch size, algorithm complexity, data loading, preprocessing, serialization, CPU-GPU transfer, batching, caching, indexing, concurrency, and benchmark reproducibility when relevant.
- Optimize only measured hot paths.
- Do not mix optimization with unrelated cleanup, redesign, dependency upgrades, or behavior changes.
- Report before/after result, correctness verification, measurement limits, and remaining bottlenecks.

## Review

- Treat review as risk checking, not rewriting.
- Review only scoped diff/files unless evidence connects other files.
- Prioritize correctness, regression risk, missing tests, defensive coding, duplication, maintainability, performance, API/data/algorithm/security/error-handling risk.
- Findings must be concrete and backed by code, tests, spec, logs, runtime behavior, or clear reasoning.
- Reject or defer speculative, stylistic, out-of-scope, or task-expanding feedback.
- Fix only the finding boundary.

## Verification

- Verify against the original success signal.
- Code: run the narrowest relevant test, typecheck, lint, or command.
- UI: run the local browser flow or screenshot when practical.
- Debug/build: rerun the original failing command or path.
- Performance: report before/after plus correctness verification; include CPU/GPU and memory/VRAM when relevant.
- Docs/artifacts: render or inspect the produced output.
- Config/deploy: run dry-run, status, validation, or health check when available.
- Report command/workflow/artifact checked, passed, failed, not verified, and confidence level.
- Do not claim full completion after partial verification.
