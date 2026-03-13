# Antigravity Superpowers

**[English](#-what-is-this) · [Tiếng Việt](#-giới-thiệu)**

---

## 📋 Requirements

- [Google Antigravity](https://antigravity.google) (macOS / Windows / Linux)
- Git
- Bash shell

---

## 🎯 What Is This?

A fork of the [Superpowers](https://github.com/obra/superpowers) agentic skills framework, customized for **Google Antigravity**. Ships 14 skills + 4 enforcement rules that install globally to `~/.gemini/antigravity/`.

**Key differences from upstream:**
- ✅ Installs to Antigravity's native path (`~/.gemini/antigravity/`)
- ✅ Auto-generates `~/.gemini/GEMINI.md` with global rules
- ✅ 3 Iron Laws + language convention enforcement rules
- ✅ Setup scripts for quick project bootstrapping
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

**What gets installed:**

| Item | Path | Count |
|------|------|-------|
| Skills | `~/.gemini/antigravity/skills/` | 14 |
| Rules | `~/.gemini/antigravity/rules/` | 4 |
| Workflows | `~/.gemini/antigravity/workflows/` | 3 |
| Global rules | `~/.gemini/GEMINI.md` | auto-generated |

### 2. Setup New Project

```bash
cd /path/to/your/project
bash ~/.gemini/antigravity/workflows/setup-antigravity-project.sh
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
└── global-config/
    ├── skills/                  # 14 Superpowers skills
    ├── rules/                   # 4 enforcement rules
    └── workflows/               # 3 setup/update scripts
```

**After installation:**
```
~/.gemini/
├── GEMINI.md                    # Global rules (auto-generated)
└── antigravity/
    ├── skills/                  # 14 skills
    ├── rules/                   # 4 rules
    └── workflows/               # 3 scripts
```

---

## 🔄 Updating

```bash
bash ~/.gemini/antigravity/workflows/update-superpowers.sh
```

Updates installed skills from upstream and auto-syncs back to fork repo.

---

## 🔗 Links

- **Upstream:** [obra/superpowers](https://github.com/obra/superpowers)
- **Google Antigravity:** [antigravity.google](https://antigravity.google)

---

## 📝 License

MIT — See [LICENSE-SUPERPOWERS](LICENSE-SUPERPOWERS) for details.

---

---

# 🇻🇳 Giới Thiệu

Fork từ framework [Superpowers](https://github.com/obra/superpowers), tùy chỉnh cho **Google Antigravity**. Bao gồm 14 skills + 4 rules cài đặt toàn cục tại `~/.gemini/antigravity/`.

## Yêu Cầu

- [Google Antigravity](https://antigravity.google) (macOS / Windows / Linux)
- Git
- Bash shell

## Cài Đặt

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

**Setup cho project mới:**
```bash
cd /path/to/project
bash ~/.gemini/antigravity/workflows/setup-antigravity-project.sh
```

## Cập Nhật Skills

```bash
bash ~/.gemini/antigravity/workflows/update-superpowers.sh
```

Tự động pull từ upstream, cập nhật skills đã cài, và sync ngược vào fork repo.

## 3 Luật Sắt

1. **Brainstorming trước khi code** — Không code khi chưa có thiết kế
2. **Test-driven development** — Không code khi chưa có test
3. **Tìm root cause trước khi fix** — Không fix khi chưa điều tra

---

**Version:** 2.1.0 · **Platform:** Google Antigravity · **Last Updated:** 2026-03-13
