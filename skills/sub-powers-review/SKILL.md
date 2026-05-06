---
name: sub-powers-review
description: Use for review, risk check, quality inspection, safety check, merge readiness, or handling review feedback without expanding scope.
metadata:
  short-description: Risk-focused review
---

# Sub-Powers Review

Review is risk checking, not rewriting.

## Start

- User asks for review, risk check, quality inspection, safety check, or merge readiness.
- Shared logic, public API, database behavior, algorithm output, security, permissions, error handling, or user-visible workflow changed.

## Required Output

- Review scope.
- High-risk areas.
- Findings by severity.
- Fixed/deferred/rejected findings.
- Verification.
- Residual risk.

## Rules

- Review only scoped diff/files unless evidence connects other files to the change.
- Prioritize correctness, regression risk, missing tests, defensive coding, duplication, maintainability, performance, API/data/algorithm/security/error-handling risk.
- Findings must be concrete and backed by code, tests, spec, logs, runtime behavior, or clear reasoning.
- Reject or defer speculative, stylistic, out-of-scope, or task-expanding feedback.
- Fix only the finding boundary; do not bundle unrelated cleanup.
