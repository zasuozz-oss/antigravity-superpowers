---
description: "Task list template for feature implementation"
---

**Input**: Implementation plan from `docs/superpowers/plans/<feature>/plan.md`
**Prerequisites**: plan.md (required), spec/design document (optional for user stories)

**Organization**: Tasks are grouped by user story to enable independent implementation and testing.

## Format: `[ID] [P?] [Story] Description — file/path`
- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2)
- Include exact file paths in descriptions

---

## Phase 1: Setup (Shared Infrastructure)
**Purpose**: Project initialization and basic structure

- [ ] T001 Create project structure per implementation plan
- [ ] T002 Initialize project with dependencies
- [ ] T003 [P] Configure linting and formatting tools

---

## Phase 2: Foundational (Blocking Prerequisites)
**Purpose**: Core infrastructure that MUST be complete before ANY user story

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T004 [FILL: Foundational task based on plan]
- [ ] T005 [P] [FILL: Parallelizable foundational task]

**Checkpoint**: Foundation ready — user story implementation can begin

---

## Phase 3: User Story 1 — [Title] (Priority: P1) 🎯 MVP
**Goal**: [Brief description from spec]
**Independent Test**: [How to verify this story works alone]

- [ ] T010 [P] [US1] [FILL: Entity/model task] — src/models/[name]
- [ ] T011 [P] [US1] [FILL: Second model task] — src/models/[name]
- [ ] T012 [US1] [FILL: Service task] — src/services/[name] (depends on T010, T011)
- [ ] T013 [US1] [FILL: Endpoint/feature task] — src/[location]/[name]

**Checkpoint**: User Story 1 fully functional and testable independently

---

## Phase 4: User Story 2 — [Title] (Priority: P2)
**Goal**: [Brief description from spec]
**Independent Test**: [How to verify this story works alone]

- [ ] T020 [P] [US2] [FILL: Tasks for story 2]

**Checkpoint**: User Stories 1 AND 2 both work independently

---

[Add more story phases as needed]

---

## Final Phase: Polish & Cross-Cutting

- [ ] TXXX [P] Documentation updates
- [ ] TXXX Code cleanup and refactoring
- [ ] TXXX Performance optimization

---

## Dependencies

- **Setup (Phase 1)**: No dependencies
- **Foundation (Phase 2)**: Depends on Setup — BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundation; can run in parallel
- **Polish (Final)**: Depends on all stories complete

## Parallel Opportunities

```
# Setup tasks that can run simultaneously:
T002, T003

# After Foundation, these story phases can run in parallel:
Phase 3: User Story 1 (Developer A)
Phase 4: User Story 2 (Developer B)
```

## Implementation Strategy

### MVP First (Recommended)
1. Complete Setup + Foundation
2. Complete User Story 1 → **VALIDATE** → Deploy/Demo
3. Add Story 2 → Validate → Deploy
4. Repeat for each story

### Quick Reference
- `[P]` = different files, no dependencies
- `[US#]` = maps task to user story for traceability
- Each story = independently testable
- Commit after each task or logical group
