---
name: sub-powers-verification
description: Use before claiming work is done, fixed, safe, passing, ready, verified, or complete; requires fresh evidence and reports what was and was not verified.
metadata:
  short-description: Completion evidence gate
---

# Sub-Powers Verification

Completion requires evidence, not confidence.

## Start

- Before claiming work is done, fixed, safe, passing, ready, verified, or complete.

## Verify By Type

- Code: run the narrowest relevant test, typecheck, lint, or command.
- UI: run the local browser flow or screenshot when practical.
- Debug/build: rerun the original failing command or path.
- Performance: report before/after plus correctness verification; include CPU/GPU and memory/VRAM when relevant.
- Docs/artifacts: render or inspect the produced output.
- Config/deploy: run dry-run, status, validation, or health check when available.

## Required Output

- Original success signal.
- Command/workflow/artifact checked.
- Passed.
- Failed.
- Not verified.
- Confidence level.

## Rules

- Verify against the original success signal, not just the last edit.
- Do not claim full completion after partial verification.
- Do not claim fixed or passing when verification did not run or failed.
