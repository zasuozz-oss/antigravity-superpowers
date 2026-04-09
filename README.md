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

A fork of the [Superpowers](https://github.com/obra/superpowers) agentic skills framework, customized for **Google Antigravity**. Ships a complete set of skills that install globally to `~/.gemini/antigravity/`.

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
bash scripts/setup-global.sh
```

**Windows (PowerShell):**
```powershell
git clone https://github.com/zasuozz-oss/antigravity-superpowers.git
cd antigravity-superpowers
powershell -ExecutionPolicy Bypass -File scripts/setup-global.ps1
```

</details>

### 2. Start Using

Open Antigravity in any project. Skills auto-load via `~/.gemini/GEMINI.md`.

---

## 📚 What's Inside

### Core Skills

| Category | Skills |
|----------|--------|
| **Core** | brainstorming, test-driven-development, systematic-debugging |
| **Collaboration** | writing-plans, executing-plans |
| **Review** | requesting-code-review, receiving-code-review |
| **Git** | finishing-a-development-branch |
| **Meta** | using-superpowers, writing-skills, verification-before-completion |

---

## 📁 Structure

```
antigravity-superpowers/
├── bin/cli.mjs                  # npx installer
├── scripts/                     # Setup & Update scripts
│   ├── setup-global.sh
│   ├── setup-global.ps1
│   └── update-superpowers.sh
├── skills/                      # Superpowers + Gitnexus skills
└── workflows/                   # Pre-made workflows
```

**After installation:**
```
~/.gemini/
├── GEMINI.md                    # Global config (auto-generated)
└── antigravity/
    ├── skills/                  # Installed skills
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
