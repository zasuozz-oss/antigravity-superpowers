---
description: "Generate concise commit messages covering all changes. Use when user asks to write commit text, generate commit message, or summarize changes for git."
---

# Generate Commit Message

## Purpose
Generate a single-line commit message that is **concise but covers all key changes**.

## Steps

### 1. Collect changed files
// turbo
```bash
git diff --name-only HEAD
```

If no staged changes, also check:
// turbo
```bash
git diff --cached --name-only
```

### 2. Analyze changes
// turbo
```bash
git diff --stat HEAD
```

Read the diff to understand what changed. Group changes by purpose, not by file.

### 3. Determine commit type
Use conventional commit type:

| Type | When |
|------|------|
| `fix` | Bug fix, error handling |
| `feat` | New feature, new UI element |
| `ref` | Refactor, rename, restructure |
| `perf` | Performance improvement |
| `chore` | Cleanup, remove dead code, debug logs |
| `style` | Formatting only |

If changes span multiple types, use the **most significant** type.

### 4. Generate commit message

**Format:**
```
<type>: <concise summary covering all changes, comma-separated>
```

**Rules:**
- Single line, max 100 characters
- Imperative mood: "fix" not "fixed"
- Comma-separate distinct changes
- No period at the end
- Each distinct change = one short phrase (3-6 words)
- Skip trivial changes (whitespace, formatting) unless that's the only change
- English only

**Good examples:**
```
fix: feed pagination rollback on failure, prevent repeated featured loads, hide actions for non-owner looks
```
```
feat: add expert review button, restrict to own looks
```
```
chore: clean up debug logs, remove unused imports
```

**Bad examples:**
```
fix: improve feed pagination, restrict look details visibility  ← too vague
```
```
fix: move PageIndex++ inside success callback in UpdateDataAndRefresh to prevent page skipping when API fails  ← too detailed
```

### 5. Output
Present the commit message in a code block ready to copy:

```
<final commit message>
```

Do NOT auto-run `git commit`. Wait for user to approve and commit manually.
