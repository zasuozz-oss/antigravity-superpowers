# Antigravity Superpowers

**Global configuration template for Superpowers skills in Google Antigravity**

---

## 🎯 What Is This?

This repository provides a template for setting up the [Superpowers framework](https://github.com/cyanheads/superpowers) as a **global configuration** for Google Antigravity AI agents.

**Features:**
- ✅ Global skills installation (~/.claude/global-config/skills/)
- ✅ Global rules enforcement (~/.claude/global-config/rules/)
- ✅ Auto-setup workflow for new projects
- ✅ Update workflow for upstream changes
- ✅ No per-project duplication

---

## ⚡ Quick Start

### 1. Install Global Configuration (One-time setup)

```bash
# Clone this repository
git clone https://github.com/[your-username]/antigravity-superpowers.git
cd antigravity-superpowers

# Run global setup (copies skills, rules, workflows to ~/.claude/global-config/)
bash setup-global.sh
```

This installs:
- 14 Superpowers skills → `~/.claude/global-config/skills/`
- 3 enforcement rules → `~/.claude/global-config/rules/`
- 2 workflow scripts → `~/.claude/global-config/workflows/`

### 2. Setup New Project (Per-project)

```bash
# Navigate to your project
cd /path/to/your/project

# Run project setup (creates GEMINI.md)
bash ~/.claude/global-config/workflows/setup-antigravity-project.sh
```

This creates a `GEMINI.md` that references global skills.

### 3. Start Using

Open Antigravity in your project directory. Skills auto-load via `GEMINI.md`.

---

---

## 🎯 What Gets Installed

### Global Skills (14)
**Location:** `~/.claude/global-config/skills/`

**Core Skills:**
- **brainstorming** - Design before code (MANDATORY)
- **test-driven-development** - TDD workflow
- **systematic-debugging** - Root cause analysis

**Collaboration Skills:**
- writing-plans, executing-plans
- subagent-driven-development
- dispatching-parallel-agents
- requesting-code-review, receiving-code-review
- using-git-worktrees
- finishing-a-development-branch

**Meta Skills:**
- using-superpowers (framework)
- writing-skills
- verification-before-completion

### Global Rules (3)
**Location:** `~/.claude/global-config/rules/`

- 00-mandatory-skills.md - Skill invocation requirements
- 01-iron-laws.md - The 3 Iron Laws
- 02-workflow-enforcement.md - Standard workflows

### Global Workflows (3)
**Location:** `~/.claude/global-config/workflows/`

- update-superpowers.sh - Update skills from upstream
- setup-project.sh - Setup new Claude Code project
- setup-antigravity-project.sh - Setup new Antigravity project

---

## 🎮 Unity Skills (Separate Repository)

Unity-specific skills have been moved to a separate repository for better organization.

**Repository:** [antigravity-unity-skills](https://github.com/[your-username]/antigravity-unity-skills)

**Includes:**
- 70 Unity-specific skills
- 9 categories (Architecture, Gameplay, Visuals, UI/UX, Performance, etc.)
- Complete documentation

**To use Unity skills:**
```bash
# Clone the Unity skills repository
git clone https://github.com/[your-username]/antigravity-unity-skills.git
```

---

## 🔑 3 Iron Laws

1. **Brainstorming before implementation** - No code without design
2. **Test-driven development** - No code without test first
3. **Root cause before fixes** - No fixes without investigation

---

## 🔄 Updating Superpowers

Keep skills up-to-date with upstream:

```bash
bash ~/.claude/global-config/workflows/update-superpowers.sh
```

---

## 📁 Repository Structure

```
antigravity-superpowers/
├── GEMINI.md                    # Example Antigravity configuration
├── README.md                    # This file
├── CHANGELOG.md                 # Version history
├── setup-global.sh              # Global installation script
└── global-config/               # Files to be installed globally
    ├── skills/                  # 14 Superpowers skills
    ├── rules/                   # 3 enforcement rules
    └── workflows/               # 3 workflow scripts
```

---

## 🚀 Usage in Antigravity

### Auto-Loading (Recommended)
Skills automatically load via `GEMINI.md`. Just start working.

### Manual Activation
```python
# Activate a specific skill
view_file("~/.claude/global-config/skills/brainstorming/SKILL.md")
```

---

## ✅ Verification

```bash
# Check global installation
ls -1 ~/.claude/global-config/skills/ | wc -l
# Should show: 14

ls -1 ~/.claude/global-config/rules/ | wc -l
# Should show: 3

ls -1 ~/.claude/global-config/workflows/ | wc -l
# Should show: 3

# Check project setup
cat GEMINI.md
# Should reference: @~/.claude/global-config/skills/using-superpowers/SKILL.md
```

---

## 🆘 Need Help?

1. **Setup issues:** Re-read Quick Start section above
2. **Update issues:** Run update script with option 2 to see diff
3. **Issues:** Check [GitHub Issues](https://github.com/[your-username]/antigravity-superpowers/issues)

---

## 📊 Status

```
Repository: antigravity-superpowers
Status: ✅ PRODUCTION-READY
Platform: Google Antigravity
Version: 2.0.0 (Global configuration)

✅ Global Skills: 14/14
✅ Global Rules: 3/3
✅ Global Workflows: 3/3
✅ Auto-setup: Available
✅ Update Workflow: Available
✅ Git: Ready for production
```

---

## 🔗 Links

- **Superpowers Framework:** https://github.com/cyanheads/superpowers
- **Google Antigravity:** https://antigravity.google
- **Unity Skills Repository:** [antigravity-unity-skills](https://github.com/[your-username]/antigravity-unity-skills)

---

## 📝 License

This repository follows the Superpowers framework license. See upstream repository for details.

---

**Last Updated:** 2026-03-13T05:33:13Z
**Version:** 2.0.0 (Global configuration)
**Status:** Production-ready
