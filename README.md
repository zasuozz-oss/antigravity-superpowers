# Antigravity Superpowers

Customized [Superpowers](https://github.com/obra/superpowers) framework for Google Antigravity with global configuration and enforcement rules.

🌐 [Tiếng Việt](README.vi.md) · [Quick Start](#-quick-start) · [Features](#-whats-inside) · [Report Bug](https://github.com/zasuozz-oss/antigravity-superpowers/issues)

---

## 📋 Requirements

- [Google Antigravity](https://antigravity.google) (macOS / Windows / Linux)
- Git
- Bash (macOS/Linux) or PowerShell (Windows)

---

## 🎯 What Is This?

A fork of the [Superpowers](https://github.com/obra/superpowers) agentic skills framework, customized for **Google Antigravity**. Ships 14 skills + 4 enforcement rules that install globally to `~/.gemini/antigravity/`.

**Key differences from upstream:**
- ✅ Installs to Antigravity's native path (`~/.gemini/antigravity/`)
- ✅ Auto-generates `~/.gemini/GEMINI.md` with global rules
- ✅ 3 Iron Laws + language convention enforcement rules
- ✅ Auto-sync fork repo when updating from upstream

---

## ⚡ Quick Start

### 1. Install Globally (One-time)

**macOS / Linux:**
```bash
git clone https://github.com/zasuozz-oss/antigravity-superpowers.git
cd antigravity-superpowers
bash setup-global.sh
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/zasuozz-oss/antigravity-superpowers.git
cd antigravity-superpowers
powershell -ExecutionPolicy Bypass -File setup-global.ps1
```

### 2. Setup New Project

```bash
cd /path/to/your/project
bash ~/.gemini/antigravity/scripts/setup-antigravity-project.sh
```

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

### Rules (4)

| File | Purpose |
|------|---------|
| `00-mandatory-skills.md` | Skill invocation requirements |
| `01-iron-laws.md` | The 3 Iron Laws enforcement |
| `02-workflow-enforcement.md` | Standard development workflow |
| `03-language-convention.md` | Language convention (EN code / VI docs) |

### Workflows (3)

| Script | Purpose |
|--------|---------|
| `setup-antigravity-project.sh` | Bootstrap new Antigravity project |
| `setup-project.sh` | Bootstrap new project (generic) |
| `update-superpowers.sh` | Update skills from upstream + sync fork |

---

## 🔑 3 Iron Laws

1. **Brainstorming before implementation** — No code without design
2. **Test-driven development** — No code without test first
3. **Root cause before fixes** — No fixes without investigation

---

## 📁 Structure

```
antigravity-superpowers/
├── setup-global.sh              # Install script (macOS/Linux)
├── setup-global.ps1             # Install script (Windows)
├── GEMINI.md                    # Example project configuration
├── gemini-extension.json        # Extension metadata
├── scripts/                     # 3 setup/update scripts
└── global-config/
    ├── skills/                  # 14 Superpowers skills
    ├── rules/                   # 4 enforcement rules
    └── workflows/               # 3 Antigravity workflows
```

**After installation:**
```
~/.gemini/
├── GEMINI.md                    # Global rules (auto-generated)
└── antigravity/
    ├── skills/                  # 14 skills
    ├── rules/                   # 4 rules
    ├── scripts/                 # 3 scripts
    └── global_workflows/            # 4 workflows
```

---

## 🔄 Updating

```bash
bash ~/.gemini/antigravity/scripts/update-superpowers.sh
```

Updates installed skills from upstream and auto-syncs back to fork repo.

---

## 🔗 Links

- **Upstream:** [obra/superpowers](https://github.com/obra/superpowers)
- **Google Antigravity:** [antigravity.google](https://antigravity.google)

---

## 📝 License

MIT — See [LICENSE-SUPERPOWERS](LICENSE-SUPERPOWERS) for details.
