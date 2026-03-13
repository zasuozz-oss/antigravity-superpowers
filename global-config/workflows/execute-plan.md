---
description: Execute an approved implementation plan step by step with TDD and progress tracking. Use after write-plan.
---

# Execute Plan Workflow

Implement an approved plan systematically with test-driven development.

## When to Use

- After a plan has been written and approved via `/write-plan`
- When you have a clear, ordered list of tasks to implement

## Prerequisites

- An approved `implementation_plan.md`
- User has reviewed and approved the plan

## Steps

1. **Load the plan**
   - Read the approved `implementation_plan.md`
   - Verify all tasks are clear and actionable
   - Confirm the execution order

2. **Create task checklist**
   - Create or update `task.md` with checklist items from the plan
   - Use format:
     ```
     - [ ] Task description
       - [ ] Sub-task 1
       - [ ] Sub-task 2
     ```

3. **Execute each task (TDD cycle)**
   For each task in order:
   - Mark as `[/]` in progress in `task.md`
   - **Write failing test first** — define expected behavior
   - **Verify it fails** — confirm the test actually catches the issue
   - **Write minimal code** — just enough to pass the test
   - **Verify it passes** — run the test, confirm green
   - Mark as `[x]` complete in `task.md`

4. **Verify after each component**
   - Run all related tests
   - Check for regressions in existing functionality
   - Verify the component integrates correctly

5. **Handle unexpected issues**
   - If a task reveals missing requirements → pause, ask the user
   - If complexity is much higher than estimated → flag it, propose alternatives
   - Do NOT silently change the plan

6. **Write walkthrough**
   - After all tasks complete, create `walkthrough.md` documenting:
     - What was implemented
     - What was tested
     - Any deviations from the plan and why

## Progress Tracking

Update `task.md` as you work:

| Marker | Meaning |
|--------|---------|
| `[ ]` | Not started |
| `[/]` | In progress |
| `[x]` | Complete |

## Hard Gate

> [!CAUTION]
> Never write production code without a failing test first. No exceptions.

## Next Step

After completion, use the `/code-review` workflow to validate the implementation.
