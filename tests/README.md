# Test Cases — Antigravity Superpowers

## 📦 Setup & Installation Tests

Run these tests in a clean environment or use `/tmp/test-ag` as a sandbox.

---

### TC-01: Global Setup — Fresh Install

**Command:**
```bash
rm -rf ~/.gemini/antigravity ~/.gemini/GEMINI.md
bash setup-global.sh
```

**Expected:**
- [ ] Exit code 0
- [ ] `~/.gemini/antigravity/skills/` exists with 13 skill directories
- [ ] `~/.gemini/antigravity/scripts/` exists with `update-superpowers.sh`
- [ ] `~/.gemini/antigravity/gemini_rule.md` exists
- [ ] `~/.gemini/GEMINI.md` exists and contains rules from `gemini_rule.md`
- [ ] No `@~/.gemini/antigravity/skills/` references in GEMINI.md
- [ ] Output shows "Installation Complete"

---

### TC-02: Global Setup — Idempotent (No Duplication)

**Command:**
```bash
bash setup-global.sh
bash setup-global.sh
bash setup-global.sh
```

**Expected:**
- [ ] `~/.gemini/GEMINI.md` content is identical after each run
- [ ] No duplicated rules
- [ ] Backup directories are created for each re-run
- [ ] Skill count remains 13

**Verify:**
```bash
md5 ~/.gemini/GEMINI.md  # Should be the same after each run
wc -l ~/.gemini/GEMINI.md  # Should be constant (no growth)
```

---

### TC-03: Global Setup — Backup Created

**Command:**
```bash
bash setup-global.sh  # First run
bash setup-global.sh  # Second run
ls ~/.gemini/antigravity-backup-*
```

**Expected:**
- [ ] At least one backup directory exists
- [ ] Backup contains `skills/` and `scripts/` from previous install
- [ ] Backup naming follows pattern: `antigravity-backup-YYYYMMDD-HHMMSS`

---

### TC-04: NPX CLI Install

**Command:**
```bash
rm -rf ~/.gemini/antigravity ~/.gemini/GEMINI.md
npx @zasuo/ag-s
```

**Expected:**
- [ ] Same results as TC-01
- [ ] `~/.gemini/antigravity/skills/` exists with 13 skills
- [ ] `~/.gemini/GEMINI.md` contains rules (not empty)
- [ ] Output shows "Installation Complete"

---

### TC-05: GEMINI.md Content Correctness

**Command:**
```bash
bash setup-global.sh
cat ~/.gemini/GEMINI.md
```

**Expected:**
- [ ] Contains "Mandatory Skills Usage - Antigravity"
- [ ] Contains "FIRST ACTION IN EVERY CONVERSATION"
- [ ] Contains `view_file` instructions for SKILL.md and gemini-tools.md
- [ ] Contains "Critical Rule"
- [ ] Does NOT contain `@~/.gemini/antigravity/skills/`
- [ ] Does NOT contain `<!-- BEGIN antigravity-superpowers -->` (markers removed from gemini_rule.md content)

---

### TC-06: Legacy Cleanup

**Command:**
```bash
mkdir -p ~/.gemini/antigravity/rules
mkdir -p ~/.gemini/antigravity/global_workflows
echo "old" > ~/.gemini/antigravity/rules/test.md
bash setup-global.sh
```

**Expected:**
- [ ] `~/.gemini/antigravity/rules/` is deleted
- [ ] `~/.gemini/antigravity/global_workflows/` is deleted
- [ ] Output shows "Removed legacy rules and workflows"

---

### TC-07: Skills Count and Structure

**Command:**
```bash
bash setup-global.sh
ls ~/.gemini/antigravity/skills/
```

**Expected 13 skills:**
- [ ] brainstorming
- [ ] dispatching-parallel-agents
- [ ] executing-plans
- [ ] finishing-a-development-branch
- [ ] receiving-code-review
- [ ] requesting-code-review
- [ ] subagent-driven-development
- [ ] systematic-debugging
- [ ] test-driven-development

- [ ] using-superpowers
- [ ] verification-before-completion
- [ ] writing-plans
- [ ] writing-skills

Each skill directory must contain a `SKILL.md` file:
```bash
for d in ~/.gemini/antigravity/skills/*/; do
  [ -f "$d/SKILL.md" ] && echo "✓ $(basename $d)" || echo "✗ $(basename $d) — MISSING SKILL.md"
done
```

---

## 🔵 Skill Triggering Tests

Paste each prompt into Antigravity on any project, then verify the expected behavior.

---

### TC-08: Systematic Debugging (Implicit)

**Prompt:**
```
I'm getting an error when running the app. It was working yesterday but now it crashes on startup.
Can you figure out what's going wrong and fix it?
```

**Expected:**
- [ ] Activates `systematic-debugging` skill
- [ ] Calls `view_file` on SKILL.md before taking action
- [ ] Investigates root cause first
- [ ] Does NOT fix immediately without finding the cause

---

### TC-09: Test-Driven Development (Implicit)

**Prompt:**
```
I need to add a new feature to validate email addresses. It should:
- Check that there's an @ symbol
- Check that there's at least one character before the @
- Check that there's a dot in the domain part
- Return true/false

Can you implement this?
```

**Expected:**
- [ ] Activates `brainstorming` skill (design before code)
- [ ] Does NOT write code immediately
- [ ] Proposes design first, asks for approval
- [ ] When implementing: writes test first, then code

---

### TC-10: Code Review (Implicit)

**Prompt:**
```
I just finished a big refactor. All the code is committed.
Can you review my changes and check if anything looks wrong before I push?
```

**Expected:**
- [ ] Activates `requesting-code-review` skill
- [ ] Checks code quality, architecture, tests
- [ ] Categorizes issues (Critical / Important / Suggestion)

---

### TC-11: Explicit Brainstorming

**Prompt:**
```
please use the brainstorming skill to help me think through this feature
```

**Expected:**
- [ ] Activates `brainstorming` immediately
- [ ] Calls `view_file` on SKILL.md first
- [ ] Asks clarifying questions one at a time

---

### TC-12: No Code Without Design

**Prompt:**
```
Add a dark mode toggle to the app. Just code it up quickly.
```

**Expected:**
- [ ] Does NOT write code immediately despite user saying "quickly"
- [ ] Starts brainstorming / design first
- [ ] Asks about requirements before coding

---

### TC-13: No Fix Without Root Cause

**Prompt:**
```
The app crashes when users submit empty forms. Just add an if-check for empty input.
```

**Expected:**
- [ ] Does NOT add if-check immediately
- [ ] Investigates root cause first (why does it crash?)
- [ ] Proposes fix only after finding the cause

---

## ✅ Automated Test Script

Run all setup tests at once:

```bash
bash tests/run-tests.sh
```
