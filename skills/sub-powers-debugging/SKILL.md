---
name: sub-powers-debugging
description: Use for bugs, failures, tracebacks, broken scripts, build/startup failures, unexpected behavior, or performance anomalies that require evidence-first root cause analysis.
metadata:
  short-description: Evidence-first debugging
---

# Sub-Powers Debugging

Debugging starts from evidence, not guesses.

## Sequence

```text
read error -> reproduce -> narrow scope -> inspect logs/docs/task notes -> root cause -> minimal fix -> verify
```

## Start

- Bug, failure, traceback, broken script, suspicious behavior, failing test, build issue, dependency issue, startup failure, or performance anomaly.

## Required Output

- Observed failure.
- Expected behavior.
- Affected path.
- Root cause.
- Minimal fix.
- Verification.
- Remaining risk.

## Boundary

- Do not modify outside the confirmed failure boundary unless evidence proves it is part of the root cause.
- Do not mix bug fixes with unrelated cleanup, redesign, performance optimization, dependency upgrades, formatting, or style changes.
- If a broader issue is discovered, record it as a follow-up instead of silently expanding scope.
- Add targeted logs or debug points only where they reduce uncertainty.
- If multiple failures are independent, they may be investigated in parallel; otherwise debug from the primary failure.
