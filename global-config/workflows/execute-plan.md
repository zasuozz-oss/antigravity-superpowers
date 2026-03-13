---
description: Execute an approved implementation plan step by step.
---

## Steps

1. **Load the plan** — Read the approved `implementation_plan.md`.
2. **Update task.md** — Create or update `task.md` with checklist items from the plan.
3. **Execute in order** — Work through each task:
   - Mark task as `[/]` in progress
   - Write failing test first (TDD)
   - Implement the change
   - Verify test passes
   - Mark task as `[x]` complete
4. **Verify after each component** — Run tests, check for regressions.
5. **Write walkthrough** — After completion, create `walkthrough.md` documenting what was done and verified.
