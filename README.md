# Antigravity Superpowers

**Customized [Superpowers](https://github.com/obra/superpowers) framework for Google Antigravity with global configuration and enforcement rules.**

---

## 🎯 What Is This?

A fork of the [Superpowers](https://github.com/obra/superpowers) agentic skills framework, customized for **Google Antigravity**. Ships 14 skills + 3 enforcement rules that install globally to `~/.gemini/antigravity/`.

**Key differences from upstream:**
- ✅ Installs to Antigravity's native path (`~/.gemini/antigravity/`)
- ✅ Auto-generates `~/.gemini/GEMINI.md` with global rules
- ✅ 3 Iron Laws enforcement rules (not in upstream)
- ✅ Setup scripts for quick project bootstrapping

---

## ⚡ Quick Start

### 1. Install Globally (One-time)

```bash
git clone https://github.com/zasuozz/antigravity-superpowers.git
cd antigravity-superpowers
bash setup-global.sh
```

**What gets installed:**
- 14 skills → `~/.gemini/antigravity/skills/`
- 3 rules → `~/.gemini/antigravity/rules/`
- 3 workflows → `~/.gemini/antigravity/workflows/`
- Global rules → `~/.gemini/GEMINI.md` (auto-generated)

### 2. Setup New Project

```bash
cd /path/to/your/project
bash ~/.gemini/antigravity/workflows/setup-antigravity-project.sh
```

Creates a `GEMINI.md` in your project that references global skills.

### 3. Start Using

Open Antigravity in your project. Skills auto-load via `GEMINI.md`.

---

## 📚 What's Inside

### Skills (14)

| Category | Skills |
|----------|--------|
| **Core** | brainstorming, test-driven-development, systematic-debugging |
| **Collaboration** | writing-plans, executing-plans, subagent-driven-development, dispatching-parallel-agents |
| **Review** | requesting-code-review, receiving-code-review |
| **Git** | using-git-worktrees, finishing-a-development-branch |
| **Meta** | using-superpowers, writing-skills, verification-before-completion |

### Rules (3)

| File | Purpose |
|------|---------|
| `00-mandatory-skills.md` | Skill invocation requirements |
| `01-iron-laws.md` | The 3 Iron Laws enforcement |
| `02-workflow-enforcement.md` | Standard development workflow |

### Workflows (3)

| Script | Purpose |
|--------|---------|
| `setup-antigravity-project.sh` | Bootstrap new Antigravity project |
| `setup-project.sh` | Bootstrap new project (generic) |
| `update-superpowers.sh` | Update skills from upstream |

---

## 🔑 3 Iron Laws

1. **Brainstorming before implementation** — No code without design
2. **Test-driven development** — No code without test first
3. **Root cause before fixes** — No fixes without investigation

---

## 📁 Structure

```
antigravity-superpowers/
├── setup-global.sh              # Global installation script
├── GEMINI.md                    # Example project configuration
├── gemini-extension.json        # Extension metadata
└── global-config/
    ├── skills/                  # 14 Superpowers skills
    ├── rules/                   # 3 enforcement rules
    └── workflows/               # 3 setup/update scripts
```

**After installation:**
```
~/.gemini/
├── GEMINI.md                    # Global rules (auto-generated)
└── antigravity/
    ├── skills/                  # 14 skills
    ├── rules/                   # 3 rules
    └── workflows/               # 3 scripts
```

---

## 🚀 Usage

### Auto-Loading (Recommended)
Skills automatically load via `GEMINI.md`. Just start working.

### Manual Activation
```python
view_file("~/.gemini/antigravity/skills/brainstorming/SKILL.md")
```

---

## 🔄 Updating

```bash
bash ~/.gemini/antigravity/workflows/update-superpowers.sh
```

---

## ✅ Verification

```bash
ls -1 ~/.gemini/antigravity/skills/ | wc -l   # → 14
ls -1 ~/.gemini/antigravity/rules/ | wc -l    # → 3
cat ~/.gemini/GEMINI.md                        # → @imports for rules
```

---

## 🔗 Links

- **Upstream:** [obra/superpowers](https://github.com/obra/superpowers)
- **Google Antigravity:** [antigravity.google](https://antigravity.google)

---

## 📝 License

MIT — See [upstream repository](https://github.com/obra/superpowers) for details.

---

**Version:** 2.1.0 · **Platform:** Google Antigravity · **Last Updated:** 2026-03-13
