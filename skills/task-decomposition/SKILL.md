---
name: task-decomposition
description: Use after writing an implementation plan to decompose it into a structured task list with parallel markers, user story grouping, dependency tracking, and phased delivery strategy.
---

# Task Decomposition

## Overview

Decompose an implementation plan into an actionable, dependency-ordered task list organized by user story with parallel execution opportunities and phased delivery.

**Announce at start:** "I'm using the task-decomposition skill to generate a structured task list from this plan."

## When to Use

- After **writing-plans** — to break a plan into executable tasks
- Before **executing-plans** — to prepare a task list for execution
- When a plan has **>10 tasks** that benefit from structured organization
- When you want **parallel execution** opportunities identified

## The Process

### Step 1: Load Inputs

1. **Required**: Implementation plan (`docs/superpowers/plans/<feature>/plan.md` or equivalent)
2. **Optional**: Spec/design document (for user story priorities)
3. **Optional**: Constitution (`.superpowers/constitution.md` for quality gate tasks)

### Step 2: Extract Key Information

From the **plan**:
- Tech stack, libraries, frameworks
- Project structure (directories, module layout)
- Phases and milestones
- Dependencies between components

From the **spec** (if available):
- User stories with priorities (P1, P2, P3...)
- Acceptance criteria per story
- Edge cases

### Step 3: Generate Task List

Create tasks following the **strict format**:

```
- [ ] T001 [P] [US1] Description — path/to/file.ext
```

**Format components (all required where applicable):**

| Component | Required | Description |
|-----------|----------|-------------|
| `- [ ]` | Always | Markdown checkbox |
| `T###` | Always | Sequential ID in execution order |
| `[P]` | If parallel | Task can run in parallel (different files, no dependencies) |
| `[US#]` | Story phases | Maps to user story from spec (US1, US2...) |
| Description | Always | Clear action with exact file path |

**Examples:**
```
✅ - [ ] T001 Create project structure per implementation plan
✅ - [ ] T005 [P] Implement auth middleware in src/middleware/auth.py
✅ - [ ] T012 [P] [US1] Create User model in src/models/user.py
✅ - [ ] T014 [US1] Implement UserService in src/services/user_service.py
❌ - [ ] Create User model  (missing ID, checkbox)
❌ T001 [US1] Create model  (missing checkbox)
```

### Step 4: Organize by Phases

#### Phase 1: Setup (Shared Infrastructure)
- Project initialization, dependency installation
- No `[US#]` labels — shared across all stories
- Most tasks here are `[P]` (parallel)

#### Phase 2: Foundation (Blocking Prerequisites)
- Core infrastructure MUST complete before ANY user story
- **⚠️ CRITICAL**: Mark clearly that this phase blocks all story phases
- Database setup, auth framework, base models, error handling

**Checkpoint**: Foundation ready — user story work can begin

#### Phase 3+: User Stories (One phase per story, priority order)
- Each story gets its own phase
- Tasks within a story follow: Models → Services → Endpoints → Integration
- Each story phase should be **independently testable**
- Include story goal and independent test criteria

**Checkpoint after each story**: Story N should be functional independently

#### Final Phase: Polish & Cross-Cutting
- Documentation, cleanup, performance optimization
- Security hardening, additional tests

### Step 5: Generate Supporting Sections

**Dependency Graph:**
```
Phase 1 (Setup) → Phase 2 (Foundation) → [Phase 3+ stories can run in parallel]
Within stories: Models → Services → Endpoints → Integration
```

**Parallel Execution Examples:**
```
# These tasks can run simultaneously:
T003 [P] Configure linting
T004 [P] Setup CI pipeline

# These story phases can run in parallel (after Foundation):
Phase 3: User Story 1 (Developer A)
Phase 4: User Story 2 (Developer B)
```

**Implementation Strategy:**
1. **MVP First**: Complete Setup + Foundation + Story 1 only
2. **Validate**: Test Story 1 independently, deploy/demo if ready
3. **Incremental**: Add Story 2 → test → deploy, then Story 3, etc.

### Step 6: Write Output

Save task list to: `docs/superpowers/plans/<feature>/tasks.md`

Use the template from `templates/tasks-template.md` as structure.

### Step 7: Report

Output summary:
- **Total tasks**: N
- **Per-story count**: US1: N tasks, US2: N tasks...
- **Parallel opportunities**: N tasks can run in parallel
- **MVP scope**: Story 1 = N tasks
- **Format validation**: Confirm ALL tasks follow the strict format

## Task Organization Rules

### From User Stories (PRIMARY)
- Each story gets its own phase
- Map models, services, endpoints to their story
- Mark cross-story dependencies explicitly

### From Data Model
- If entity serves multiple stories → put in Foundation phase
- Single-story entity → in that story's phase

### From Infrastructure
- Shared infra → Setup phase
- Blocking prerequisites → Foundation phase
- Story-specific setup → within that story's phase

## Output Location

`docs/superpowers/plans/<feature>/tasks.md` — same directory as the plan

## Integration

- **Predecessor:** `writing-plans` — produces the plan this skill decomposes
- **Successor:** `executing-plans` — consumes the task list
- **Optional predecessor:** `spec-clarify` — cleaner spec = better tasks
- **Optional successor:** `spec-analyze` — validates tasks against spec/plan

## Remember

- Every task MUST have checkbox, ID, description, and file path
- `[P]` means truly parallel — different files, no dependency on incomplete tasks
- Each user story phase should be independently testable
- Always include MVP strategy with checkpoint after Story 1
- Keep tasks atomic — one clear action per task
- Include exact file paths, not vague descriptions
