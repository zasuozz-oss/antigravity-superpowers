# The 3 Iron Laws - Antigravity

These laws are absolute. No exceptions. No shortcuts.

## Law 1: Brainstorming Before Implementation

**NO CODE WITHOUT DESIGN**

```
❌ User request → Start coding
✅ User request → Brainstorm → Design → Approval → Code
```

**How to invoke in Antigravity:**
```python
view_file("~/.claude/global-config/skills/brainstorming/SKILL.md")
```

**Why:**
- Prevents wasted effort on wrong solutions
- Ensures user alignment before work begins
- Catches issues early when they're cheap to fix
- Produces better, more thoughtful solutions

**Applies to:**
- Every new feature
- Every architectural decision
- Every creative task
- Every non-trivial change

## Law 2: Test-Driven Development

**NO CODE WITHOUT TEST FIRST**

```
❌ Write code → Write tests
✅ Write test (fail) → Write code → Test passes
```

**How to invoke in Antigravity:**
```python
view_file("~/.claude/global-config/skills/test-driven-development/SKILL.md")
```

**Why:**
- Ensures code actually solves the problem
- Creates living documentation
- Prevents regressions
- Forces good design (testable = well-designed)

**Applies to:**
- Every function
- Every feature
- Every bug fix
- Every refactor

## Law 3: Root Cause Before Fixes

**NO FIX WITHOUT INVESTIGATION**

```
❌ See error → Apply fix
✅ See error → Investigate → Find root cause → Fix properly
```

**How to invoke in Antigravity:**
```python
view_file("~/.claude/global-config/skills/systematic-debugging/SKILL.md")
```

**Why:**
- Prevents treating symptoms instead of disease
- Stops bugs from recurring
- Builds understanding of the system
- Avoids creating new problems

**Applies to:**
- Every test failure
- Every bug report
- Every unexpected behavior
- Every error message

## Enforcement

These laws override convenience, speed, and intuition.

If you're tempted to skip a law "just this once," that's exactly when you need it most.

## Platform: Google Antigravity

This configuration is for Google Antigravity AI agents.
Use `view_file()` to activate skills.
