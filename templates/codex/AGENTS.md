# Sub-Powers Agent Workflow

Sub-Powers is a boundary-first workflow for AI coding agents. This file is the router. Detailed execution lives in the `sub-powers-*` skills.

## Plan Mode Gate

Use Plan Mode before any implementation when either:

- any hard trigger is true
- two or more soft triggers are true

Hard triggers:

- multi-repo work
- boundary is unclear at product, ownership, data, workflow, or architecture level
- verification path is unknown
- task requires coordinated changes across independent subsystems

Soft triggers:

- many files are likely to change
- task is unusually complex
- repo context is unfamiliar
- implementation order is unclear
- multiple plausible entrypoints could fit

Plan Mode rules:

- Do not modify files.
- Do not implement, patch, scaffold, or refactor.
- Only identify task type, choose the entrypoint/skill, define the modification boundary, and define the verification plan.
- If clarification is needed, ask one Socratic batch of questions in a single message instead of many scattered questions.
- Leave Plan Mode only after scope, repo boundary, file boundary, and verification path are clear enough to proceed safely.

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
- Add MCP tools later only for deterministic actions such as collecting context, running verification, measuring performance, or creating task notes.
- MCP/tools are lazy and gate-scoped; do not trigger every tool just because an entrypoint starts.
- MCP/tools should return structured output by default and write files only when explicitly requested or when the selected action is task-note creation.

## Documentation Discipline

- Default: do not create files for intermediate reasoning, debug context, performance snapshots, review notes, verification reports, or tool outputs.
- Allowed persistent files: `README.md`, `docs/design.md`, and `docs/tasks/YYYY-MM-DD-HHMM-<topic>.md`.
- Write `docs/design.md` only for durable design: 0-to-1, architecture, data contracts, algorithm/index/retrieval systems, or cross-module workflows.
- Write `docs/tasks/*` only after meaningful final code changes.
- Skip task notes for formatting, copy/style tweaks, tiny self-evident edits, no-behavior changes, or when the note would be longer than the change.
- Show debug context and performance snapshots in chat or via commands; do not save them by default.
