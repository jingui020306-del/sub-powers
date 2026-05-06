# Sub-Powers Agent Workflow

This project uses a boundary-first workflow. Full Superpowers is reserved for 0-to-1 work. Existing-code work should use named workflow entrypoints that compose the relevant skills for the task.

Use the local `sub-powers-engineering` skill for Sub-Powers-specific execution details. This file stays focused on entrypoint routing, boundaries, and hard gates.

## Lane Selection

Use the full Superpowers workflow only for 0-to-1 work. A task is 0-to-1 if it creates a new product surface, new service, new major workflow, new architecture, new data contract family, or a new cross-module system that does not already have a stable local pattern.

Do not use the full Superpowers workflow for normal existing-code work. Small features, focused bug fixes, local refactors, single endpoint changes, script updates, page adjustments, quality checks, and workflow tests should use a named entrypoint instead.

Escalate from a narrow entrypoint to the full workflow only if the work reveals a new system boundary, unclear business ownership, multi-module contract changes, or architecture risk that cannot be handled locally.

## Full 0-to-1 Workflow

Use this only when the task creates a new product surface, service, major workflow, architecture boundary, data contract family, or cross-module system without a stable local pattern.

Do not use this for small existing-code edits, one bug, one endpoint, one UI tweak, local refactor, or routine test run. If the task is actually small after clarification, downgrade to the smallest existing-code entrypoint.

### 0-to-1 Goal

Turn an unclear idea into an approved implementation system:

1. clarify business boundary
2. formalize spec
3. isolate development
4. write implementation plan
5. execute in controlled steps
6. review
7. verify
8. close branch/spec lifecycle

### 0-to-1 Startup Trigger

Start Full 0-to-1 Workflow only when at least one condition is true:

- New user-facing product surface.
- New backend service or major API family.
- New data model or contract family.
- New algorithm pipeline or retrieval/indexing system.
- New cross-module workflow.
- Existing request exposes unclear ownership, architecture, or business boundary.
- User explicitly asks to start from scratch or build a new system.

If none are true, do not start Full 0-to-1.

### 0-to-1 Fixed Gates

1. Gate: boundary is new or unclear -> `superpowers:brainstorming`
   - Input: user's raw business goal.
   - Work: clarify user, goal, scope, non-goals, inputs, outputs, data sources, states, risks, and validation.
   - Output: approved design summary.
   - Stop condition: user has not approved the design.
   - Downgrade condition: the task is just a small existing-code change.

   Brainstorming framework:

   - Clarify: actor, problem, smallest useful version, in scope, out of scope, deferred work, and existing reuse.
   - Model: core entities, fields, relationships, states, data ownership, and untrusted inputs.
   - Flow: entry action, happy path, alternate paths, failure states, fallback/retry, user result, and required logs/artifacts.
   - Contract: UI/API/CLI/job/module surface, input/output/error contract, permissions, and compatibility.
   - Risk: missing or malformed data, unsafe input, failure mode, defensive checks, graceful degradation, and first tests.
   - Efficiency: expected data size, frequency, latency, memory/I/O risk, algorithm/index/cache/retrieval concerns.
   - Acceptance: success examples, failure examples, verification method, and definition of done.

   Required output before OpenSpec:

   - Problem, scope, non-goals, entities/contracts, workflow states, reuse plan, risks, tests, verification, and open questions.

   Continue only if:

   - The user approves or says to proceed.
   - Scope and non-goals are clear.
   - At least one verification method is known.

   Stop and ask if:

   - Actor, input, output, success signal, ownership, permission, or multi-module boundary is unclear.

   Downgrade if:

   - It is one local behavior change that fits an existing module and does not need a new contract, workflow, product surface, or architecture boundary.

2. Gate: design is approved and needs durable standard -> OpenSpec
   - Input: approved design summary.
   - Work: create or update standard spec files.
   - Preferred commands: `opsx:new`, then `opsx:ff`.
   - Output: spec files that define behavior, boundaries, and acceptance criteria.
   - Stop condition: OpenSpec is unavailable or the spec boundary is still unclear.

   OpenSpec framework:

   - Start only after the brainstorming design summary is approved.
   - Use for durable product, API, data, workflow, algorithm, or architecture contracts.
   - Skip for tiny prototypes, one-file experiments, local bug fixes, or changes covered by an existing spec.
   - `opsx:new`: create the spec/change container from the approved design.
   - `opsx:ff`: fill the spec into implementation-ready requirements, contracts, edge cases, failure behavior, logs, verification, and migration notes.
   - Required spec quality: scope/non-goals, requirements, contracts, concrete success example, risky failure example, verification method, untrusted data, and compatibility risk.
   - Continue only if the spec matches the approved design and is concrete enough for `writing-plans` to name files, modules, tests, and commands.
   - Stop and ask if tooling is unavailable, files cannot be created, scope changed, acceptance is vague, or data/API/permission/user behavior is unresolved.
   - Downgrade if the work is only a local implementation detail, an existing spec covers it, or no durable contract is needed.

3. Gate: implementation may disturb current workspace -> `superpowers:using-git-worktrees`
   - Input: approved spec or design.
   - Work: create isolated branch/worktree for large or risky work.
   - Output: isolated development workspace.
   - Skip condition: tiny prototype or user explicitly wants current workspace.

   Worktree framework:

   - Start when the task is large, risky, multi-module, long-running, or may disturb the current workspace.
   - Start when executing an approved 0-to-1 spec that needs a dedicated development branch.
   - Branch name should be short and task-based, such as `feature/<topic>` or `spec/<topic>`.
   - Worktree path should make the task identity obvious.
   - Do not create a worktree for tiny prototypes, one-file spikes, read-only planning, or user-requested current-workspace edits.
   - Before creating one, check current git status and avoid overwriting unrelated user changes.
   - Output: branch name, worktree path, and the command/result used to create it.
   - Stop if git is unavailable, the repo is dirty in a way that blocks safe isolation, or the base branch is unclear.

4. Gate: spec/design is ready -> `superpowers:writing-plans`
   - Input: approved spec/design and existing code context.
   - Work: break implementation into ordered tasks.
   - Output must include exact files, modules, functions, data contracts, tests, commands, and dependencies.
   - Stop condition: plan cannot name concrete files or verification steps.

   Planning framework:

   - Start after approved spec/design and enough code context are available.
   - Inspect existing patterns before planning new modules.
   - Plan must name concrete files, modules, functions/classes, data contracts, tests, commands, and dependency order.
   - Each step should be small enough to implement and verify independently.
   - Mark steps as parallel only when they do not share files, state, or hidden dependencies.
   - Include where TDD should start, where logs/errors are needed, and how each step will be verified.
   - Stop and gather more context if files, ownership, APIs, data shape, or verification commands are unknown.
   - Downgrade to direct implementation if the plan would be shorter than the planning ceremony.

5. Gate: written plan is ready -> execution mode
   - Use `superpowers:subagent-driven-development` when tasks are independent, broad, or review-heavy.
   - Use `superpowers:executing-plans` when tasks are sequential and tightly coupled.
   - Output: implemented plan checkpoints.
   - Rule: after each checkpoint, keep code simple, single-purpose, reusable, defensive, and testable.

   Execution framework:

   - Use `subagent-driven-development` only when the plan has independent tasks with separate files, clear ownership, and useful review checkpoints.
   - Use `executing-plans` when steps are sequential, share context, touch the same files, or require tight design judgment.
   - Do not spawn agents for tiny tasks, unclear tasks, or work where the next step depends on the result of the current one.
   - Each execution checkpoint must state changed files, behavior changed, tests/logs added, and verification result.
   - If execution reveals a bug, route that slice through `systematic-debugging` before continuing.
   - If execution reveals unclear scope, pause and return to brainstorming or planning instead of expanding silently.
   - If multiple independent failures appear, use `dispatching-parallel-agents`; otherwise debug sequentially.

6. Gate: behavior changes are testable -> `superpowers:test-driven-development`
   - Use inside execution before production code when a feature, bug fix, contract, or algorithm result has a stable expected behavior.
   - Output: failing test first, then implementation, then passing test.
   - Skip condition: pure scaffold, config, visual-only draft, or untestable exploratory spike.

   TDD framework:

   - Start when the change affects behavior, contracts, bug fixes, algorithms, validation, permissions, or data transformations.
   - Write the smallest failing test that proves the expected behavior or reproduced bug.
   - Prefer unit tests for pure logic and focused integration tests for API/database/workflow boundaries.
   - Do not test private implementation details when public behavior can be tested.
   - Do not write brittle tests that only mirror the current code structure.
   - After the test fails for the right reason, implement the smallest fix or feature slice.
   - Refactor only after the test passes.
   - Skip when the work is pure scaffold, config, copy/style-only, throwaway spike, or not meaningfully testable.
   - If no test path is obvious, record the reason and use `verification-before-completion` with the best available command or workflow.

7. Gate: meaningful implementation is complete -> `superpowers:requesting-code-review`
   - Review shared logic, API contracts, data handling, algorithm behavior, security, error handling, duplication, and missing tests.
   - If review feedback exists, use `superpowers:receiving-code-review` before patching.
   - Output: accepted fixes or explicit rejected findings with reason.

   Review framework:

   - Start when shared logic, public API, database behavior, algorithm output, security, permissions, error handling, or user-visible workflow changed.
   - Start when the user asks for review, risk check, or "is this safe".
   - Review for correctness, regression risk, missing tests, defensive programming, duplication, readability, performance, and maintainability.
   - Findings must point to concrete files or behavior, not vague style preferences.
   - Use `receiving-code-review` for feedback before patching.
   - Accept feedback only after verifying it against the spec, tests, code, or runtime behavior.
   - Reject or defer feedback explicitly when it is out of scope, incorrect, speculative, or would expand the task.
   - After accepted fixes, rerun the relevant tests or commands.

8. Gate: before saying complete -> `superpowers:verification-before-completion`
   - Input: original acceptance criteria.
   - Work: run the real command, test, script, UI flow, benchmark, or render.
   - Output: what passed, what failed, what was not verified.
   - Rule: never claim complete without this gate.

   Verification framework:

   - Start before saying complete, fixed, passing, safe, ready, or verified.
   - Verify against the original acceptance criteria, not just against the last edit.
   - Prefer the narrowest command that proves the changed behavior.
   - For UI work, verify the actual local browser flow when practical.
   - For algorithm or performance work, verify correctness first, then timing/profile/benchmark if relevant.
   - For document, slide, spreadsheet, PDF, or visual artifacts, render or inspect the artifact.
   - Report exact command, workflow, or artifact checked.
   - Report what passed, what failed, and what was not verified.
   - If verification cannot run, say why and provide the best available lower-confidence check.
   - Do not claim full completion when verification is partial.

9. Gate: verified branch/spec needs closing -> `superpowers:finishing-a-development-branch`
   - Work: decide merge, PR, keep branch, archive spec, or continue.
   - Output: final branch/spec status.

   Finish framework:

   - Start only after implementation is verified.
   - Check git status and avoid including unrelated user changes.
   - Confirm whether the result should be merged, opened as PR, kept as a branch, or continued later.
   - Update or archive OpenSpec artifacts when the spec lifecycle requires it.
   - Output final status: branch, changed files, verification summary, remaining risks, and next action.

## Existing-Code Entrypoints

For existing-code work, use the smallest named entrypoint that fits. Each entrypoint is a compact workflow that may compose multiple skills. Do not repeat a full design/spec/worktree flow when the task is a small slice.

Entrypoints are the management layer. Skills are implementation aids inside an entrypoint. When multiple skills are useful, keep one primary entrypoint active and call supporting skills only to serve that entrypoint's goal.

Each entrypoint must produce one of these concrete outcomes:

- a confirmed business boundary
- a focused implementation
- a reproduced failure and diagnosis
- a verified workflow result
- a quality review with findings
- a performance finding with evidence
- a completion verdict

## Four Management Layers

Use these layers to explain why an entrypoint or skill starts.

### 1. Workflow Management

Controls scope, sequence, isolation, planning, execution, and completion.

- Entrypoints: Full 0-to-1, Small Feature, Workflow Test, Completion Verification.
- Skills: `brainstorming`, `writing-plans`, `executing-plans`, `subagent-driven-development`, `dispatching-parallel-agents`, `using-git-worktrees`, `finishing-a-development-branch`, `verification-before-completion`.

### 2. Code Design Management

Controls readability, responsibility, reuse, boundaries, and defensive design.

- Entrypoints: Small Feature, Code Quality, Review.
- Skills: `writing-plans`, `test-driven-development`, `requesting-code-review`, `receiving-code-review`.

### 3. Code Quality Management

Controls bugs, regression risk, tests, review, diagnostics, and completion evidence.

- Entrypoints: Debug, Build, Code Quality, Review, Completion Verification.
- Skills: `systematic-debugging`, `test-driven-development`, `requesting-code-review`, `receiving-code-review`, `verification-before-completion`.

### 4. Code Efficiency Management

Controls algorithm, index, database, memory, I/O, CPU/GPU, and runtime performance.

- Entrypoints: Performance, Debug, Review.
- Skills: `systematic-debugging`, `test-driven-development`, `requesting-code-review`, `verification-before-completion`.

## Superpowers Skill Bias Map

Use this as a compact skill index. Entrypoints below decide when each skill starts.

- `brainstorming`: early product/design boundary work -> new surface, workflow, architecture, data contract, or unclear business abstraction.
- `systematic-debugging`: root cause analysis -> bug, failure, unexpected behavior, build issue, performance anomaly, or unclear error.
- `test-driven-development`: behavior specification -> testable feature, bug fix, contract, algorithm, validation, permission, or data transformation.
- `writing-plans`: executable implementation plan -> multiple files, multiple steps, sequencing risk, or unclear implementation order.
- `executing-plans`: sequential execution -> written plan with tightly coupled ordered steps.
- `subagent-driven-development`: parallel/staged execution -> independent work packages with separate ownership and useful review checkpoints.
- `dispatching-parallel-agents`: parallel investigation -> independent failures, modules, files, or questions.
- `requesting-code-review`: risk review -> shared logic, API, data, algorithm, security, error handling, or user-requested review.
- `receiving-code-review`: feedback triage -> review findings need verification, acceptance, rejection, or patching.
- `verification-before-completion`: final evidence -> before claiming complete, fixed, passing, safe, ready, or verified.
- `using-git-worktrees`: isolated work -> 0-to-1, risky multi-module work, or plan needing a separate branch/worktree.
- `finishing-a-development-branch`: branch/spec closeout -> verified implementation needs merge, PR, archive, keep, or continue decision.
- `writing-skills`: skill maintenance -> user asks to create, rewrite, audit, or package a skill.

## Automatic Entry Routing

Use this routing table to decide which workflow starts automatically from the user's request. The entrypoint is the management layer. Skills start inside the entrypoint only when their fixed trigger appears.

- New 0-to-1 system: Full 0-to-1 Workflow.
- Existing small feature: Small Feature Entrypoint.
- Bug, error, failed run, unexpected behavior, or "debug": Debug Entrypoint.
- Build failed, type error, dependency error, or service will not start: Build Entrypoint.
- Whole page/API/process validation or E2E: Workflow Test Entrypoint.
- Cleanup, readability, duplication, local refactor: Code Quality Entrypoint.
- Slow code, indexing, memory, I/O, database, algorithm speed: Performance Entrypoint.
- Review, risk check, "is this safe": Review Entrypoint.
- "Is it done", "confirm fixed", "verify": Completion Verification Entrypoint.

Do not treat a Superpowers skill invocation as permission to start the full Superpowers pipeline. Full Superpowers starts only from the 0-to-1 trigger or an explicit escalation.

## Fixed Gate Rules

These hard gates apply across all entrypoints.

- Boundary unclear at product, ownership, workflow, data, or architecture level -> `brainstorming`.
- Failure, regression, build issue, or performance anomaly -> `systematic-debugging` before patching.
- Testable behavior, bug, contract, algorithm, validation, permission, or data change -> `test-driven-development` when practical.
- Multiple ordered files/steps -> `writing-plans`; independent work packages -> `subagent-driven-development`; sequential work -> `executing-plans`.
- Risky shared logic, API, data, algorithm, security, permission, or error handling change -> `requesting-code-review`.
- Review feedback exists -> `receiving-code-review` before patching.
- Completion claim -> `verification-before-completion`.

## MCP and Tool Boundaries

Superpowers is a workflow plugin, not an MCP server. MCP/tools are called only when the chosen entrypoint needs an external capability.

- Browser or UI flow: use `browser-use` or available browser tooling.
- Current docs or API facts: use available docs/search tooling when the claim is version-sensitive.
- GitHub or PR checks: use GitHub tooling only when the task is explicitly about GitHub state.
- Local debugging and code changes: prefer local files, logs, tests, and shell commands first.
- OpenSpec: use only in the Full 0-to-1 Workflow unless an existing-code task escalates into a new spec boundary.

### Small Feature Entrypoint

Default path for normal product/code increments inside existing modules.

- Start: one endpoint, field, button, validation rule, local transformation, or small behavior adjustment.
- Do not start: new product surface, data contract family, architecture boundary, or unclear ownership; escalate to 0-to-1/`brainstorming`.
- Use: local boundary check -> existing pattern search -> `writing-plans` only for multi-step/multi-file work -> `test-driven-development` when behavior is testable -> `requesting-code-review` only for shared/risky changes -> `verification-before-completion`.
- Output: one-sentence goal, affected path, success signal, changed files, verification run.
- Boundary: reuse existing helpers/components/schemas/tests/styles/error patterns; do not create OpenSpec unless escalation is required.

### Debug Entrypoint

Use for bugs, failures, tracebacks, broken scripts, suspicious behavior, or unexpected failures during other workflows.

- Start with: `systematic-debugging`.
- Optional: `test-driven-development` for stable expected behavior; `dispatching-parallel-agents` only for independent failures; `verification-before-completion` before claiming fixed.
- Output: observed failure, expected behavior, affected path, root cause, minimal fix, verification, remaining risk.
- Boundary: error -> reproduce -> narrow scope -> logs/docs/task notes -> root cause -> precise fix -> verify. Do not modify outside the confirmed failure boundary or mix in cleanup/optimization.

### Build Entrypoint

Use for build, typecheck, install, dependency, migration, dev server, worker, job, test environment, or service startup failures.

- Start with: `systematic-debugging`.
- Use `test-driven-development` only if the fix changes runtime behavior.
- Output: failing command, category, affected package/module, fix, rerun result, remaining environment risk.
- Boundary: make the smallest build-focused fix; do not mix in refactor, formatting, broad upgrades, style changes, or runtime behavior changes unless evidence proves they are root cause.

### Workflow Test Entrypoint

Use for whole-flow, page/API flow, smoke, integration, or E2E validation.

- Use: `browser-use` for UI journeys; narrow real command/client for API/job/script journeys; `systematic-debugging` if the workflow breaks; `verification-before-completion` before claiming ready.
- Output: start point, steps, expected final state, evidence collected, passed/failed step, artifacts checked, unverified areas.
- Boundary: this entrypoint verifies and locates failing steps; do not patch from E2E symptoms or redesign unless Debug proves a design-boundary root cause.

### Code Quality Entrypoint

Use for cleanup, readability, duplication, defensive checks, local refactor, maintainability, unclear responsibility, or fragile error handling.

- Use: `test-driven-development` when behavior is important and testable; `requesting-code-review` when shared helpers, boundaries, or public interfaces change; `verification-before-completion` always.
- Output: quality target, affected files, expected unchanged behavior, verification, deferred cleanup.
- Boundary: preserve behavior unless user approves change; do not mix with features, performance, dependency work, or stylistic rewrites.

### Performance Entrypoint

Use for algorithm, indexing, I/O, database, memory/VRAM, CPU/GPU, latency, throughput, batch, or runtime bottlenecks.

- Start with: `systematic-debugging`; use `test-driven-development` if optimization changes behavior/contracts; use `requesting-code-review` for risky performance-sensitive changes; finish with `verification-before-completion`.
- Output: baseline, suspected hot path, resource utilization, measurement method, correctness risk, after result, measurement limits, remaining bottlenecks.
- Boundary: correctness before speed; optimize only measured hot paths; do not mix with unrelated cleanup, redesign, dependency upgrades, or behavior changes.

### Review Entrypoint

Use for review, risk check, quality inspection, safety check, or risky merge readiness.

- Use: `requesting-code-review`, then `receiving-code-review` for feedback, then `verification-before-completion` for applied fixes.
- Output: review scope, high-risk areas, findings by severity, fixed/deferred/rejected findings, verification, residual risk.
- Boundary: review is risk checking, not rewriting; do not review unrelated files or fix outside the finding boundary.

### Completion Verification Entrypoint

Use before claiming work is done, fixed, safe, passing, ready, or verified.

- Use: `verification-before-completion`.
- Output: original success signal, command/workflow/artifact checked, passed, failed, not verified, confidence level.
- Boundary: completion requires evidence; partial verification cannot support full completion.

## Lightweight Workflow

For small tasks that do not fit a named entrypoint, use this default:

1. Clarify the task briefly.
2. Pick the narrowest relevant entrypoint, skill, or tool.
3. Implement directly.
4. Verify the change.

Small tasks must still follow the global engineering rules below.

## Global Engineering Rules

These rules apply to every task, large or small.

### 1. Code Design

- Keep code concise and readable.
- Each function should do one thing well.
- Prefer clear naming over cleverness.
- Avoid unconscious abbreviations; prefer clear variable, function, and module names.
- Prefer small modules with explicit responsibilities.
- Follow Single Responsibility Principle.
- Follow Open/Closed Principle when it genuinely improves maintainability.
- Prefer composition over inheritance.
- Reduce unnecessary variables; keep only names that improve clarity, reuse, or debugging.
- Reduce nesting with early returns, guard clauses, and small helper functions when they make flow clearer.
- Use consistent indentation, formatting, spacing, and line breaks.

### 2. Reuse and Duplication

- Do not repeat similar logic casually.
- If similar code appears more than twice, consider extracting a reusable function, helper, or module.
- Reuse should improve clarity, not create abstract indirection for its own sake.
- Extract repeated logic into an independent reusable function or module when the abstraction has a clear responsibility.

### 3. Defensive Programming

- Do not blindly trust input, API responses, files, config, or external systems.
- Validate assumptions at boundaries.
- Handle exceptions explicitly.
- Fail loudly enough for debugging, but present clean behavior to users where appropriate.
- Avoid silent failure paths.

### 4. Code Quality

- Code should be understandable without heroics.
- Prefer explicit control flow over hidden side effects.
- Keep interfaces narrow.
- Keep module boundaries obvious.
- Write code that is easy to review and easy to debug later.

### 5. Code Efficiency

- Care about runtime cost, I/O cost, memory usage, and query cost.
- For algorithmic or indexing work, prioritize correctness first, then measurable performance.
- Optimize the actual bottleneck, not imagined bottlenecks.

## Change Traceability

Every meaningful code change should leave enough context for future debugging, review, and optimization.

- Use `docs/design.md` for 0-to-1 work, new architecture, new data contracts, new algorithm/index/retrieval systems, or cross-module workflows.
- Use `docs/tasks/YYYY-MM-DD-HHMM-<topic>.md` for behavior changes, bug fixes, performance work, multi-file changes, or changes to data/API/algorithm/permission/error handling.
- Each task note should state:
  - what changed
  - what did not change
  - why the change was made
  - affected files or modules
  - tests or verification run
  - known risks or follow-ups
- Skip task notes for pure formatting, copy/style tweaks, tiny self-evident edits, or changes with no behavior impact.
- If the task note would be longer than the change itself, skip it and summarize in the final response.
- Unit tests should be structured so future agents can quickly identify which module or behavior failed.
- Runtime code should emit useful logs for later diagnosis when it runs in a service, job, script, workflow, async pipeline, or long-running process.
- Prefer a dedicated project log location such as `logs/` when the application writes local runtime logs.
- Logs must help trace phase, input identity, failure point, fallback, retry, and partial completion without exposing secrets.

## Logging and Runtime Diagnostics

When writing code that runs as part of a workflow, service, job, script, or pipeline, include useful logs.

Logging expectations:

- Log major phase transitions.
- Log enough context to identify which task, clip, batch, file, or request failed.
- Include stable identifiers where possible.
- Log exceptions with useful context, not just the raw exception string.
- Do not log secrets or sensitive data.
- Distinguish:
  - success
  - failure
  - fallback
  - retry
  - partial completion

Good logs should make later debugging faster.

## Debugging Rules

When something fails, use a systems-engineering approach.

### Core debugging principles

1. Systematic debugging
   - Do not guess first.
   - Start from the observable failure.

2. Simple first
   - Prefer the simplest explanation that fits the evidence.
   - Check environment, inputs, config, logs, and recent changes before redesigning code.

3. Precise modification
   - Change the smallest thing that can validate the hypothesis.
   - Avoid broad speculative rewrites during debugging.
   - Do not modify code outside the reported failure boundary unless evidence shows it is part of the root cause.
   - Do not combine bug fixes with unrelated cleanup, redesign, performance optimization, or style changes.
   - If a broader issue is discovered, record it as a follow-up instead of silently expanding scope.

4. Clarify the problem
   - Confirm what is actually wrong.
   - Separate:
     - expected behavior
     - actual behavior
     - repro steps
     - scope of impact

5. Start from evidence
   - Read error messages carefully.
   - Check logs first.
   - Check existing markdown notes, workflow docs, and prior implementation notes before inventing new explanations.

### Debugging workflow

1. Read the error and observable evidence.
2. Reproduce the issue.
3. Narrow the scope.
4. Use logs, existing docs, task notes, and targeted tracing.
5. Form a concrete root-cause hypothesis.
6. Make the smallest precise fix inside the confirmed boundary.
7. Re-run the failing path.
8. Verify no obvious regressions were introduced.
9. Record remaining unrelated issues as follow-ups, not as hidden extra changes.

## Testing Rules

- Use unit tests when they can lock down behavior cheaply.
- Prefer TDD for bug fixes and meaningful new behavior when practical.
- For bug fixes:
  - reproduce
  - write or update a failing test when reasonable
  - implement the fix
  - verify the fix

## Multi-Bug Situations

If multiple bugs appear after a change:

- Pause and organize context before continuing.
- Summarize what changed.
- Separate primary failure from secondary fallout.
- Use logs, notes, AI conversation context, and targeted debugging to rebuild the chain of causality.
- Avoid stacking random fixes without re-establishing the true failure sequence.
