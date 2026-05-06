# Sub-Powers Claude Workflow

Use this file as the Claude project memory for repositories that should follow Sub-Powers.

## Purpose

Sub-Powers is a boundary-first engineering workflow. It keeps large 0-to-1 work structured while keeping everyday code changes small, testable, debuggable, and easy to review.

## Routing

- New product surface, service, architecture boundary, data contract family, algorithm/retrieval/indexing system, or cross-module workflow: use the Full 0-to-1 Workflow.
- Existing small feature: use Small Feature.
- Bug, failure, traceback, broken script, or unexpected behavior: use Debug.
- Build, typecheck, dependency, migration, dev-server, or service startup failure: use Build.
- Whole flow, page/API flow, smoke, integration, or E2E validation: use Workflow Test.
- Cleanup, readability, duplication removal, local refactor, or maintainability: use Code Quality.
- Algorithm, indexing, I/O, database, memory/VRAM, CPU/GPU, latency, throughput, or batch bottleneck: use Performance.
- Review, risk check, quality inspection, safety check, or merge readiness: use Review.
- Before claiming done, fixed, safe, passing, ready, or verified: use Completion Verification.

## Hard Gates

- Boundary unclear or new 0-to-1 surface: clarify design before implementation.
- Failure, regression, build issue, or performance anomaly: root-cause debug before patching.
- Testable behavior change: write a focused failing test before production code when practical.
- Multi-file or sequenced work: write an executable plan before implementation.
- Shared/risky logic, API, data, algorithm, security, permissions, or error handling changed: request review.
- Completion claim: verify with fresh evidence.

## Core Coding Rules

- Keep code concise and readable.
- Each function should do one thing well.
- Use clear names; avoid unconscious abbreviations.
- Reduce unnecessary variables.
- Reduce nesting with guard clauses, early returns, or small helpers when clearer.
- Reuse existing helpers, components, schemas, tests, styles, and error patterns.
- If similar logic appears more than twice, extract an independent reusable function or module when it has a clear responsibility.
- Validate external input, API responses, files, config, and runtime assumptions.
- Handle exceptions explicitly and avoid silent failures.

## Boundary Discipline

- Use the smallest workflow that fits.
- Do not expand scope silently.
- Do not mix bug fixes with unrelated cleanup, redesign, performance optimization, dependency upgrades, formatting, or style changes.
- Do not modify code outside the confirmed boundary unless evidence proves it is part of the root cause.
- Record broader issues as follow-ups instead of hidden extra changes.

## Debug

Sequence: read error -> reproduce -> narrow scope -> inspect logs/docs/task notes -> root cause -> minimal fix -> verify.

Required output: observed failure, expected behavior, affected path, root cause, minimal fix, verification, remaining risk.

## Performance

- Correctness comes before speed.
- Capture baseline, suspected hot path, resource utilization, measurement method, and correctness risk.
- Inspect CPU/GPU utilization, memory/VRAM, I/O wait, throughput, latency, batch size, algorithm complexity, data loading, preprocessing, serialization, CPU-GPU transfer, batching, caching, indexing, concurrency, and benchmark reproducibility when relevant.
- Optimize only measured hot paths.
- Report before/after result, correctness verification, measurement limits, and remaining bottlenecks.

## Traceability

- Use `docs/design.md` for 0-to-1 work, new architecture, new data contracts, new algorithm/index/retrieval systems, or cross-module workflows.
- Use `docs/tasks/YYYY-MM-DD-HHMM-<topic>.md` for behavior changes, bug fixes, performance work, multi-file changes, or changes to data/API/algorithm/permission/error handling.
- Skip task notes for formatting, copy/style tweaks, tiny self-evident edits, no-behavior changes, or when the note would be longer than the change.
- Runtime code in services, jobs, scripts, workflows, async pipelines, or long-running processes should log phase, input identity, failure point, fallback, retry, and partial completion without secrets.

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
