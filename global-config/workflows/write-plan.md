---
description: Write a structured implementation plan from an approved design. Use after brainstorming to create an actionable roadmap.
---

# Write Plan Workflow

Turn an approved design into a detailed, step-by-step implementation plan.

## When to Use

- After brainstorming has been completed and design approved
- When you have requirements but need to organize the work
- Before writing any implementation code

## Prerequisites

- An approved design from the `/brainstorm` workflow
- Clear understanding of scope and constraints

## Steps

1. **Review the approved design**
   - Re-read the brainstorm output and user approval
   - Identify all components that need to be built or modified
   - Note any constraints or preferences mentioned

2. **Break into tasks**
   - Split the work into ordered, concrete tasks
   - Each task should modify specific files
   - Keep tasks small enough to verify independently
   - Group by component (e.g., backend, frontend, tests)

3. **Identify dependencies**
   - Note which tasks must be completed first
   - Order tasks so dependencies are built before dependents
   - Mark tasks that can be parallelized

4. **Estimate complexity**
   - Mark each task as: `S` (small), `M` (medium), `L` (large)
   - Small: single file, < 50 lines
   - Medium: 2-3 files, 50-200 lines
   - Large: multiple files, > 200 lines or complex logic

5. **Write the plan**
   - Create `implementation_plan.md` artifact with:
     - **Goal**: Brief description of what the change accomplishes
     - **Proposed changes**: Grouped by component, with file paths
     - **Verification plan**: How to verify each change works

6. **Include verification steps**
   - Automated tests to run
   - Manual verification steps
   - Expected outcomes for each check

7. **Request review**
   - Present the plan to the user
   - Wait for approval before proceeding to implementation

## Output Format

```markdown
# [Goal Description]

## Proposed Changes

### [Component Name]
#### [MODIFY/NEW/DELETE] filename.ext
- What changes and why

## Verification Plan
### Automated Tests
- Commands to run
### Manual Verification
- Steps to verify
```

## Next Step

After approval, transition to the `/execute-plan` workflow.
