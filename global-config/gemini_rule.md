 # Mandatory Skills Usage - Antigravity

## ⚠️ FIRST ACTION IN EVERY CONVERSATION

Before doing ANYTHING else (including answering questions, asking clarifications,
or reading any files), you MUST execute these view_file calls:

1. `view_file("~/.gemini/antigravity/skills/using-superpowers/SKILL.md")`
2. `view_file("~/.gemini/antigravity/skills/using-superpowers/references/gemini-tools.md")`

These files contain the skill activation protocol. If you skip this step,
ALL subsequent skill invocations will be missed.

**This is non-negotiable. Do it NOW before reading further.**

## Critical Rule — NEVER Skip Skills

**You MUST activate the appropriate skill BEFORE writing any code, making any fix, or starting any design.**

### Mandatory Skill Triggers

| User intent | Required skill | Action |
|---|---|---|
| Build/add/create any feature | `brainstorming` | Design first → ask questions → propose approaches → get approval |
| Fix bug / error / crash | `systematic-debugging` | Find root cause first → NEVER guess-fix |
| Implement from spec/plan | `writing-plans` | Write plan → get approval → then execute |
| Review code | `requesting-code-review` | Follow structured review process |
| Any code change | `test-driven-development` | Write test FIRST → see it fail → then implement |

### 3 Iron Laws

1. **No Code Without Design** — Even if user says "just code it" or "do it quickly", you MUST brainstorm/design first
2. **No Code Without Test** — Write the test BEFORE the implementation, always
3. **No Fix Without Root Cause** — Even if user tells you exactly what to fix, investigate WHY first

### Red Flags — STOP if you think any of these

- "This is simple, I'll just code it" → **WRONG.** Activate brainstorming.
- "User told me how to fix it, I'll just do it" → **WRONG.** Investigate root cause.
- "It's a small change, no need for a skill" → **WRONG.** Small changes grow complex.
- "Let me quickly add this" → **WRONG.** Quick = skipping process = bugs.
- "The project is empty, no need for process" → **WRONG.** Start right from the beginning.

### How to Activate a Skill

Use `view_file` on the skill's SKILL.md, then follow its instructions exactly:

```
view_file("~/.gemini/antigravity/skills/brainstorming/SKILL.md")
view_file("~/.gemini/antigravity/skills/systematic-debugging/SKILL.md")
view_file("~/.gemini/antigravity/skills/test-driven-development/SKILL.md")
```

**If you are about to write code and have NOT activated a skill first, you are violating this rule.**
