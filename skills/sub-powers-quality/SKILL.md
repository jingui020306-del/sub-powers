---
name: sub-powers-quality
description: Use for cleanup, readability, duplication removal, local refactor, defensive checks, maintainability, unclear responsibility, or fragile error handling while preserving behavior.
metadata:
  short-description: Behavior-preserving code quality
---

# Sub-Powers Quality

Use this skill for quality work that should preserve behavior.

## Start

- Cleanup, simplification, readability, duplication removal, local refactor, maintainability, unclear responsibility, or fragile error handling.

## Required Output

- Quality target.
- Affected files.
- Expected unchanged behavior.
- Verification.
- Deferred cleanup.

## Rules

- Preserve behavior unless the user explicitly approves a behavior change.
- If behavior changes, route to small feature or debug.
- Use tests or focused checks to protect existing behavior when practical.
- Prefer removing duplication and clarifying responsibility over adding abstraction.
- Extract reusable code only when it reduces real repetition or complexity.
- Do not rewrite a module for style preference.
- Do not mix quality work with features, performance, dependency work, or broad redesign.
- Request review when shared helpers, module boundaries, or public interfaces change.
