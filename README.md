# Antigravity Superpowers

Customized [Superpowers](https://github.com/obra/superpowers) framework for Google Antigravity with global configuration.

🌐 [Tiếng Việt](README.vi.md) · [Quick Start](#-quick-start) · [Features](#-whats-inside) · [Report Bug](https://github.com/zasuozz-oss/antigravity-superpowers/issues)

---

## 📋 Requirements

- [Google Antigravity](https://antigravity.google) (macOS / Windows / Linux)
- Git
- Bash (macOS/Linux) or PowerShell (Windows)

---

## 🎯 What Is This?

A fork of the [Superpowers](https://github.com/obra/superpowers) agentic skills framework, customized for **Google Antigravity**. Ships 14 skills that install globally to `~/.gemini/antigravity/`.

**Key differences from upstream:**
- ✅ Installs to Antigravity's native path (`~/.gemini/antigravity/`)
- ✅ Auto-generates `~/.gemini/GEMINI.md` with skill references
- ✅ Auto-sync fork repo when updating from upstream

---

## ⚡ Quick Start

### 1. Install Globally (One-time)

**Quick Install (recommended):**
```bash
npx @zasuo/ag-s
```

<details>
<summary>Alternative: Manual Install</summary>

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

</details>

### 2. Start Using

Open Antigravity in any project. Skills auto-load via `~/.gemini/GEMINI.md`.

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

---

## 📁 Structure

```
antigravity-superpowers/
├── setup-global.sh              # Install script (macOS/Linux)
├── setup-global.ps1             # Install script (Windows)
├── bin/cli.mjs                  # npx installer
├── global-config/
│   ├── GEMINI.md                # Template configuration
│   └── skills/                  # 14 Superpowers skills
└── scripts/                     # Update script
```

**After installation:**
```
~/.gemini/
├── GEMINI.md                    # Global config (auto-generated)
└── antigravity/
    ├── skills/                  # 14 skills
    └── scripts/                 # Setup scripts
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
