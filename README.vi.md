# Antigravity Superpowers

Framework [Superpowers](https://github.com/obra/superpowers) tùy chỉnh cho Google Antigravity với cấu hình toàn cục và các luật bắt buộc.

🌐 [English](README.md) · [Bắt Đầu Nhanh](#-bắt-đầu-nhanh) · [Tính Năng](#-bao-gồm-gì) · [Báo Lỗi](https://github.com/zasuozz-oss/antigravity-superpowers/issues)

---

## 📋 Yêu Cầu

- [Google Antigravity](https://antigravity.google) (macOS / Windows / Linux)
- Git
- Bash (macOS/Linux) hoặc PowerShell (Windows)

---

## 🎯 Giới Thiệu

Fork từ framework [Superpowers](https://github.com/obra/superpowers), tùy chỉnh cho **Google Antigravity**. Bao gồm 14 skills + 4 rules cài đặt toàn cục tại `~/.gemini/antigravity/`.

**Khác biệt so với bản gốc:**
- ✅ Cài đặt tại đường dẫn native của Antigravity (`~/.gemini/antigravity/`)
- ✅ Tự động tạo `~/.gemini/GEMINI.md` với global rules
- ✅ 3 Luật Sắt + quy ước ngôn ngữ
- ✅ Tự đồng bộ fork repo khi cập nhật từ upstream

---

## ⚡ Bắt Đầu Nhanh

### 1. Cài Đặt Toàn Cục (Chạy 1 lần)

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

### 2. Setup Cho Project Mới

```bash
cd /path/to/project
bash ~/.gemini/antigravity/scripts/setup-antigravity-project.sh
```

### 3. Bắt Đầu Sử Dụng

Mở Antigravity trong thư mục project. Skills tự động load qua `GEMINI.md`.

---

## 📚 Bao Gồm Gì

### Skills (14)

| Loại | Skills |
|------|--------|
| **Cốt lõi** | brainstorming, test-driven-development, systematic-debugging |
| **Cộng tác** | writing-plans, executing-plans, subagent-driven-development, dispatching-parallel-agents |
| **Review** | requesting-code-review, receiving-code-review |
| **Git** | using-git-worktrees, finishing-a-development-branch |
| **Meta** | using-superpowers, writing-skills, verification-before-completion |

### Rules (4)

| File | Mục đích |
|------|----------|
| `00-mandatory-skills.md` | Yêu cầu gọi skill bắt buộc |
| `01-iron-laws.md` | 3 Luật Sắt |
| `02-workflow-enforcement.md` | Quy trình phát triển chuẩn |
| `03-language-convention.md` | Quy ước ngôn ngữ (EN code / VI docs) |

### Workflows (3)

| Script | Mục đích |
|--------|----------|
| `setup-antigravity-project.sh` | Khởi tạo project Antigravity mới |
| `setup-project.sh` | Khởi tạo project chung |
| `update-superpowers.sh` | Cập nhật skills từ upstream + sync fork |

---

## 🔑 3 Luật Sắt

1. **Brainstorming trước khi code** — Không code khi chưa có thiết kế
2. **Test-driven development** — Không code khi chưa có test
3. **Tìm root cause trước khi fix** — Không fix khi chưa điều tra

---

## 📁 Cấu Trúc

```
antigravity-superpowers/
├── setup-global.sh              # Script cài đặt (macOS/Linux)
├── setup-global.ps1             # Script cài đặt (Windows)
├── GEMINI.md                    # Cấu hình project mẫu
├── gemini-extension.json        # Metadata extension
├── scripts/                     # 3 scripts setup/update
└── global-config/
    ├── skills/                  # 14 Superpowers skills
    ├── rules/                   # 4 enforcement rules
    └── workflows/               # 3 Antigravity workflows
```

**Sau khi cài đặt:**
```
~/.gemini/
├── GEMINI.md                    # Global rules (tự tạo)
└── antigravity/
    ├── skills/                  # 14 skills
    ├── rules/                   # 4 rules
    ├── scripts/                 # 3 scripts
    └── workflows/               # 3 workflows
```

---

## 🔄 Cập Nhật

```bash
bash ~/.gemini/antigravity/scripts/update-superpowers.sh
```

Tự động pull skills từ upstream, cập nhật bản cài đặt, và đồng bộ ngược vào fork repo.

---

## 🔗 Liên Kết

- **Bản gốc:** [obra/superpowers](https://github.com/obra/superpowers)
- **Google Antigravity:** [antigravity.google](https://antigravity.google)

---

## 📝 Giấy Phép

MIT — Xem [LICENSE-SUPERPOWERS](LICENSE-SUPERPOWERS) để biết chi tiết.
