---
name: sub-powers-coding
description: Use for small existing-code features, normal implementation, code style discipline, defensive programming, reuse, and testable behavior changes inside an existing module.
metadata:
  short-description: Small feature and coding discipline
---

# Sub-Powers Coding

Use this skill for normal product/code increments inside existing modules.

## Start

- One endpoint, field, button, validation rule, local transformation, or small behavior adjustment.
- Do not use for new product surfaces, data contract families, architecture boundaries, or unclear ownership.

## Core Rules

- Keep code concise and readable.
- Each function should do one thing well.
- Use clear names; avoid unconscious abbreviations.
- Reduce unnecessary variables.
- Reduce nesting with early returns, guard clauses, and small helpers when clearer.
- Reuse existing helpers, components, schemas, tests, styles, and error patterns.
- If similar logic appears more than twice, extract an independent reusable function or module with clear responsibility.
- Validate external input, API responses, files, config, and runtime assumptions.
- Handle exceptions explicitly and avoid silent failures.

## Flow

- Confirm one-sentence goal, affected path, and success signal.
- Find the existing pattern before adding a new one.
- Use planning only for multi-step or multi-file work.
- Use TDD when behavior is testable.
- Add logs when code runs in a service, job, script, workflow, async pipeline, or long-running process.
- Request review only for shared/risky changes.
- Verify before claiming completion.
