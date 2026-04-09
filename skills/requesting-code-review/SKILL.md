---
name: requesting-code-review
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements
---

# Requesting Code Review

Perform a structured Self-Review to catch issues before they cascade. Since Antigravity uses a single-agent model without subagents, you must conduct this review yourself using a strict checklist approach. This keeps you focused on the final work product, preserving code quality.

**Core principle:** Review early, review often.

## When to Request Review

**Mandatory:**
- After each task in subagent-driven development
- After completing major feature
- Before merge to main

**Optional but valuable:**
- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing complex bug

## How to Request

**1. Get git SHAs:**
```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

**2. Perform the Self-Review Checklist:**

Go through your code changes systematically against these criteria:

- Structure/Architecture: Appropriate bounds, separations of concern, and solid interface boundaries.
- Code Quality: DRY, naming conventions, proper error handling, no magic numbers.
- Tests: Test coverage of added functionality, including edge cases.
- Security: No exposed secrets, data validation implemented.

**3. Act on findings:**
- Fix Critical issues immediately (e.g., compile errors, security flaws)
- Fix Important issues before proceeding
- Note Minor issues for later
- Document the review outcome in a brief summary for the user.

## Example

```
[Just completed Task 2: Add verification function]

You: Let me perform a code review before proceeding.

BASE_SHA=$(git log --oneline | grep "Task 1" | head -1 | awk '{print $1}')
HEAD_SHA=$(git rev-parse HEAD)

[Reviewing against Checklist]:
  - Architecture: Good, clean separation.
  - Code Quality: Found a magic number (100) for reporting interval.
  - Tests: Missing progress indicators.
  
I will fix the progress indicators and the magic number now.

[Fix issues]
[Continue to Task 3]
```

## Integration with Workflows

**Subagent-Driven Development:**
- Review after EACH task
- Catch issues before they compound
- Fix before moving to next task

**Executing Plans:**
- Review after each batch (3 tasks)
- Get feedback, apply, continue

**Ad-Hoc Development:**
- Review before merge
- Review when stuck

## Red Flags

**Never:**
- Skip review because "it's simple"
- Ignore Critical issues
- Proceed with unfixed Important issues
- Argue with valid technical feedback

**If reviewer wrong:**
- Push back with technical reasoning
- Show code/tests that prove it works
- Request clarification

See template at: requesting-code-review/code-reviewer.md
