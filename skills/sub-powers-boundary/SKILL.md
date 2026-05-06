---
name: sub-powers-boundary
description: Use when a task may be 0-to-1, has unclear business scope, creates a new product surface, workflow, architecture, data contract, algorithm/retrieval/indexing system, or needs boundary clarification before implementation.
metadata:
  short-description: Boundary and 0-to-1 design gate
---

# Sub-Powers Boundary

Use this skill to decide whether work is truly 0-to-1 or should downgrade to a smaller existing-code entrypoint.

## Start

- New product surface, service, workflow, architecture, data contract family, algorithm/retrieval/indexing system, or cross-module ownership.
- Existing-code request exposes unclear user, scope, ownership, data contract, permission, or architecture boundary.

## Do

- Clarify actor, problem, smallest useful version, in scope, out of scope, deferred work, and existing reuse.
- Model entities, fields, relationships, states, data ownership, and untrusted inputs.
- Define workflow entry, happy path, alternate paths, failure states, fallback/retry, user result, and required logs/artifacts.
- Define UI/API/CLI/job/module surface, input/output/error contract, permissions, and compatibility.
- Identify risks, defensive checks, first tests, efficiency boundary, and acceptance criteria.

## Output

- Problem.
- Scope and non-goals.
- Entities and contracts.
- Workflow states.
- Reuse plan.
- Risks and defensive checks.
- Test and verification plan.
- Open questions.

## Gates

- Continue only when the user approves or says to proceed, scope/non-goals are clear, and at least one verification method is known.
- Stop and ask if actor, input, output, success signal, ownership, permission, or multi-module boundary is unclear.
- Downgrade if the task is one local behavior change that fits an existing module and does not need a new contract, workflow, product surface, or architecture boundary.
