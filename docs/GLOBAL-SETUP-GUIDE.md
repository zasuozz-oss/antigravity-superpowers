# Global Setup Guide - Antigravity Superpowers

Complete guide for installing and using Superpowers as a global configuration for Google Antigravity.

---

## 🎯 Overview

This guide covers:
1. One-time global installation
2. Per-project setup
3. Usage in Antigravity
4. Updating skills
5. Troubleshooting

---

## 📦 One-Time Global Installation

### Step 1: Clone Repository

```bash
cd ~/AI-Tool  # or your preferred location
git clone https://github.com/[your-username]/antigravity-superpowers.git
cd antigravity-superpowers
```

### Step 2: Run Global Setup

```bash
bash setup-global.sh
```

This installs to `~/.claude/global-config/`:
- **skills/** - 14 Superpowers skills
- **rules/** - 3 enforcement rules
- **workflows/** - 3 workflow scripts

### Step 3: Verify Installation

```bash
# Check skills
ls -1 ~/.claude/global-config/skills/ | wc -l
# Should show: 14

# Check rules
ls -1 ~/.claude/global-config/rules/ | wc -l
# Should show: 3

# Check workflows
ls -1 ~/.claude/global-config/workflows/ | wc -l
# Should show: 3
```

---

## 🚀 Per-Project Setup

For each new project where you want to use Superpowers:

### Step 1: Navigate to Project

```bash
cd /path/to/your/project
```

### Step 2: Run Project Setup

```bash
bash ~/.claude/global-config/workflows/setup-antigravity-project.sh
```

This creates a `GEMINI.md` file that references global skills.

### Step 3: Verify

```bash
cat GEMINI.md
# Should show: @~/.claude/global-config/skills/using-superpowers/SKILL.md
```

---

## 🎮 Usage in Antigravity

### Auto-Loading (Recommended)

Skills automatically load when you start Antigravity in a project with `GEMINI.md`.

**Example workflow:**
```
User: "Add authentication feature"

Agent automatically:
1. Loads using-superpowers skill (via GEMINI.md)
2. Invokes brainstorming skill
3. Asks clarifying questions
4. Presents design options
5. Gets approval
6. Implements with TDD
7. Verifies completion
```

### Manual Skill Activation

```python
# Activate specific skill
view_file("~/.claude/global-config/skills/brainstorming/SKILL.md")
view_file("~/.claude/global-config/skills/test-driven-development/SKILL.md")
view_file("~/.claude/global-config/skills/systematic-debugging/SKILL.md")
```

---

## 🔄 Updating Skills

Keep your global skills up-to-date with upstream:

```bash
bash ~/.claude/global-config/workflows/update-superpowers.sh
```

**Options:**
1. Update all skills (overwrite everything)
2. Show full diff
3. Update specific skills manually
4. Cancel

See [UPDATE-WORKFLOW.md](UPDATE-WORKFLOW.md) for details.

---

## 🎯 Available Skills

### Core Skills (3)
1. **brainstorming** - Design before code (MANDATORY)
2. **test-driven-development** - TDD workflow (MANDATORY)
3. **systematic-debugging** - Root cause analysis (MANDATORY)

### Collaboration Skills (9)
4. writing-plans
5. executing-plans
6. subagent-driven-development
7. dispatching-parallel-agents
8. requesting-code-review
9. receiving-code-review
10. using-git-worktrees
11. finishing-a-development-branch

### Meta Skills (2)
12. using-superpowers (framework)
13. writing-skills
14. verification-before-completion

---

## 🔑 The 3 Iron Laws

### Law 1: Brainstorming Before Implementation
```
❌ NEVER: Start coding without approved design
✅ ALWAYS: Brainstorm → Design → Approval → Code
```

### Law 2: Test-Driven Development
```
❌ NEVER: Write production code without failing test first
✅ ALWAYS: Test (fail) → Code → Test (pass)
```

### Law 3: Root Cause Before Fixes
```
❌ NEVER: Fix bugs without root cause investigation
✅ ALWAYS: Bug → Investigate → Root Cause → Fix
```

---

## 🛠️ Troubleshooting

### Skills Not Loading

**Problem:** Agent doesn't follow skills

**Solution:**
1. Check GEMINI.md exists in project root
2. Verify path: `@~/.claude/global-config/skills/using-superpowers/SKILL.md`
3. Restart Antigravity

### Skills Not Found

**Problem:** `view_file` returns "file not found"

**Solution:**
1. Verify global installation: `ls ~/.claude/global-config/skills/`
2. Re-run global setup: `bash setup-global.sh`

### Update Script Fails

**Problem:** Update script errors

**Solution:**
1. Check internet connection
2. Verify git is installed: `git --version`
3. Check permissions: `ls -la ~/.claude/global-config/`

---

## 📁 Directory Structure

```
~/.claude/global-config/
├── skills/                      # 14 Superpowers skills
│   ├── brainstorming/
│   ├── test-driven-development/
│   ├── systematic-debugging/
│   └── ... (11 more)
│
├── rules/                       # 3 enforcement rules
│   ├── 00-mandatory-skills.md
│   ├── 01-iron-laws.md
│   └── 02-workflow-enforcement.md
│
└── workflows/                   # 3 workflow scripts
    ├── update-superpowers.sh
    ├── setup-project.sh
    └── setup-antigravity-project.sh
```

---

## 🎓 Learning Path

### Day 1 (30 minutes)
1. Run global setup
2. Setup one project
3. Try simple task
4. Observe workflow

### Week 1 (3-4 hours)
1. Practice brainstorming skill
2. Practice TDD skill
3. Practice debugging skill
4. Complete small feature

### Month 1 (10-15 hours)
1. Master all 14 skills
2. Create custom skill
3. Integrate into daily workflow

---

## 🆘 Need Help?

1. **Setup issues:** Re-read this guide
2. **Update issues:** Check [UPDATE-WORKFLOW.md](UPDATE-WORKFLOW.md)
3. **Bug reports:** [GitHub Issues](https://github.com/[your-username]/antigravity-superpowers/issues)

---

## ✅ Quick Reference

```bash
# Global setup (one-time)
bash setup-global.sh

# Project setup (per-project)
bash ~/.claude/global-config/workflows/setup-antigravity-project.sh

# Update skills
bash ~/.claude/global-config/workflows/update-superpowers.sh

# Verify installation
ls ~/.claude/global-config/skills/
ls ~/.claude/global-config/rules/
ls ~/.claude/global-config/workflows/
```

---

**Last Updated:** 2026-03-13T05:24:55Z
**Version:** 2.0.0
**Status:** Production-ready
