# Sub-Powers Agent Workflow

Sub-Powers is a boundary-first workflow for AI coding agents. This file is the router. Detailed execution lives in the `sub-powers-*` skills.

## Entry Routing

- New product surface, service, architecture boundary, data contract family, algorithm/retrieval/indexing system, or cross-module workflow: use `sub-powers-boundary`, then `sub-powers-planning`.
- Existing small feature or normal code increment: use `sub-powers-coding`.
- Bug, failure, traceback, broken script, suspicious behavior, or build/startup failure: use `sub-powers-debugging`.
- Whole-flow, page/API flow, smoke, integration, or E2E validation: use `sub-powers-verification`; use browser tooling for UI, and `sub-powers-debugging` if it breaks.
- Cleanup, readability, duplication removal, local refactor, defensive checks, or maintainability: use `sub-powers-quality`.
- Algorithm, indexing, I/O, database, memory/VRAM, CPU/GPU, latency, throughput, batch, or runtime bottleneck: use `sub-powers-performance`.
- Review, risk check, quality inspection, safety check, or merge readiness: use `sub-powers-review`.
- Before claiming done, fixed, safe, passing, ready, or verified: use `sub-powers-verification`.

## Hard Gates

- Use the smallest entrypoint that fits.
- Full 0-to-1 flow is only for real new boundaries. Existing-code work should not start full design/spec/worktree flow unless it escalates.
- Boundary unclear at product, ownership, workflow, data, algorithm, or architecture level: stop and clarify with `sub-powers-boundary`.
- Failure, regression, build issue, or performance anomaly: root-cause debug with `sub-powers-debugging` before patching.
- Testable behavior change: use TDD when practical.
- Multi-file or sequenced work: plan before implementation.
- Shared/risky logic, API, data, algorithm, security, permissions, or error handling changed: use `sub-powers-review`.
- Completion claim requires fresh evidence from `sub-powers-verification`.

## Boundary Rules

- Do not expand scope silently.
- Do not mix bug fixes with unrelated cleanup, redesign, performance optimization, dependency upgrades, formatting, or style changes.
- Do not modify code outside the confirmed boundary unless evidence proves it is part of the root cause.
- Record broader issues as follow-ups instead of hidden extra changes.

## MCP And Tools

Sub-Powers is a workflow and skill layer, not an MCP server.

- Use browser tooling for UI journeys when available.
- Use GitHub tooling only for GitHub/PR state.
- Use shell/tests/logs/files for local debugging and verification.
- Add MCP tools later only for deterministic actions such as creating task notes, collecting logs, running benchmarks, or generating verification reports.
