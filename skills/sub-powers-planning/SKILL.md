---
name: sub-powers-planning
description: Use after approved requirements or design when implementation has multiple files, ordered steps, OpenSpec/spec work, worktree isolation, or needs an executable plan before coding.
metadata:
  short-description: Spec, worktree, and implementation planning
---

# Sub-Powers Planning

Use this skill to turn an approved boundary/spec into concrete implementation steps.

## Start

- Approved 0-to-1 design needs OpenSpec/spec files.
- Work is multi-file, multi-step, risky, long-running, or needs sequencing.
- A dedicated branch/worktree would protect the current workspace.

## OpenSpec Or Spec Gate

- Use only after design approval.
- Use for durable product, API, data, workflow, algorithm, or architecture contracts.
- Skip for tiny prototypes, one-file experiments, local bug fixes, or changes covered by an existing spec.
- Required spec quality: scope/non-goals, requirements, contracts, concrete success example, risky failure example, verification method, untrusted data, compatibility risk.

## Worktree Gate

- Use for large, risky, multi-module, long-running, or workspace-disturbing work.
- Skip for tiny prototypes, one-file spikes, read-only planning, or current-workspace edits requested by the user.
- Output branch name, worktree path, and creation result.

## Plan

- Inspect existing patterns before planning new modules.
- Name concrete files, modules, functions/classes, data contracts, tests, commands, and dependency order.
- Mark work parallel only when tasks do not share files, state, or hidden dependencies.
- Include where TDD starts, where logs/errors are needed, and how each step is verified.
- Stop and gather context if files, ownership, APIs, data shape, or verification commands are unknown.
- Downgrade to direct implementation if the plan would be heavier than the change.
