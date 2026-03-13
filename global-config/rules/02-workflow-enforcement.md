# Workflow Enforcement - Antigravity

## Standard Development Workflow

Every task follows this workflow. No shortcuts.

```
1. Brainstorming
   ↓
2. Git Worktree (for isolation)
   ↓
3. Writing Plans
   ↓
4. Executing Plans (with TDD)
   ↓
5. Verification
   ↓
6. Finishing Branch
```

## Workflow Rules

### Rule 1: Always Start with Brainstorming
- **Before** any code
- **Before** any planning
- **Before** any exploration

**How to invoke in Antigravity:**
```python
view_file("~/.gemini/antigravity/skills/brainstorming/SKILL.md")
```

### Rule 2: Use Git Worktrees for Features
- Isolates work from main branch
- Allows safe experimentation
- Prevents contamination of working code

**How to invoke in Antigravity:**
```python
view_file("~/.gemini/antigravity/skills/using-git-worktrees/SKILL.md")
```

### Rule 3: Write Plans Before Execution
- Break work into concrete tasks
- Specify files, code, commands
- Get user approval on approach

**How to invoke in Antigravity:**
```python
view_file("~/.gemini/antigravity/skills/writing-plans/SKILL.md")
```

### Rule 4: Execute with TDD
- Test first, always
- Red → Green → Refactor
- No production code without tests

**How to invoke in Antigravity:**
```python
view_file("~/.gemini/antigravity/skills/test-driven-development/SKILL.md")
```

### Rule 5: Verify Before Claiming Done
- All tests pass
- All requirements met
- No regressions introduced

**How to invoke in Antigravity:**
```python
view_file("~/.gemini/antigravity/skills/verification-before-completion/SKILL.md")
```

### Rule 6: Clean Finish
- Merge properly
- Clean up worktree
- Document changes

**How to invoke in Antigravity:**
```python
view_file("~/.gemini/antigravity/skills/finishing-a-development-branch/SKILL.md")
```

## Red Flags

These thoughts mean you're about to skip the workflow:

- "This is just a quick fix"
- "I don't need a plan for this"
- "Tests can come later"
- "Let me just try something"
- "This is too simple for the full workflow"

**When you think these thoughts, that's exactly when you need the workflow most.**

## Enforcement

The workflow exists because undisciplined work creates technical debt.

Follow it even when it feels slow. Especially when it feels slow.

## Platform: Google Antigravity

This configuration is for Google Antigravity AI agents.
Use `view_file()` to activate skills.
