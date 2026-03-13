---
description: Review completed code against the original plan and coding standards. Use after execute-plan or when a major step is complete.
---

# Code Review Workflow

Structured review of completed implementation against plan and quality standards.

## When to Use

- After completing implementation via `/execute-plan`
- When a major project step has been completed
- Before committing or creating pull requests
- When the user asks for a review of their work

## Steps

1. **Load context**
   - Read the original plan (`implementation_plan.md`)
   - Read the completed implementation files
   - Review `task.md` to confirm all tasks marked complete

2. **Plan alignment check**
   - Compare implementation against planned approach
   - Verify all planned functionality is implemented
   - Identify any deviations:
     - **Justified** — improvement over the plan (document why)
     - **Unjustified** — missing or different without reason (flag as issue)

3. **Code quality assessment**
   - **Error handling**: proper try/catch, edge cases covered
   - **Type safety**: correct types, no implicit any
   - **Naming**: clear, descriptive, consistent conventions
   - **Organization**: files focused, functions small, responsibilities clear
   - **DRY**: no unnecessary duplication

4. **Test coverage check**
   - All public APIs have tests
   - Edge cases and error paths tested
   - Tests are meaningful (not just coverage padding)
   - Tests actually run and pass

5. **Architecture review**
   - SOLID principles followed
   - Separation of concerns maintained
   - Clean interfaces between components
   - No tight coupling introduced
   - Scalability considered

6. **Security check**
   - No hardcoded credentials or secrets
   - Input validation present
   - No SQL injection, XSS, or similar vulnerabilities
   - Proper authentication/authorization where needed

7. **Report findings**
   Categorize each issue:

   | Level | Meaning | Action |
   |-------|---------|--------|
   | 🔴 **Critical** | Must fix before merge | Blocks completion |
   | 🟡 **Important** | Should fix | Fix before next PR |
   | 🟢 **Suggestion** | Nice to have | Optional improvement |

8. **Acknowledge good work**
   - Always mention what was done well before highlighting issues
   - Note well-structured code, good test coverage, clean APIs
   - Recognize improvements over the original plan

## Output Format

```markdown
## Code Review: [Feature Name]

### ✅ What's Good
- [Positive observations]

### 🔴 Critical Issues
- [Issue]: [Description] → [Recommended fix]

### 🟡 Important Issues
- [Issue]: [Description] → [Recommended fix]

### 🟢 Suggestions
- [Suggestion]: [Description]

### Plan Alignment
- [x] All planned features implemented
- [x] No unjustified deviations

### Summary
[Overall assessment and recommendation: approve / revise / rewrite]
```
