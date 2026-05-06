# Sub-Powers Design

Sub-Powers is a boundary-first workflow layer for AI coding agents.

## Design Goals

- Keep 0-to-1 work structured without forcing heavyweight process on small existing-code changes.
- Make debugging evidence-based and boundary-limited.
- Make performance work measurement-first and correctness-preserving.
- Preserve future context through useful tests, task notes, and logs.
- Support Codex and Claude with the same workflow philosophy.

## Architecture

- `templates/codex/AGENTS.md` routes Codex work into entrypoints and hard gates.
- `skills/sub-powers-*` contains modular Codex execution skills for each workflow branch.
- `templates/claude/CLAUDE.md` carries the same practical rules for Claude-style project memory.
- `docs/tasks/` is reserved for meaningful change notes.
- `logs/` is reserved for local runtime logs when projects write diagnostic files.

## Non-Goals

- Sub-Powers is not a large agent marketplace.
- Sub-Powers is not a replacement for all specialized domain skills.
- Sub-Powers is not an MCP server yet.
- Sub-Powers does not force full planning, specs, or worktrees for small changes.

## Core Boundary

Use the smallest workflow that fits. Escalate only when the work reveals new product, architecture, data-contract, workflow, algorithm, or cross-module boundaries.
