# Antigravity Superpowers

Framework [Superpowers](https://github.com/obra/superpowers) tùy chỉnh cho Google Antigravity với cấu hình toàn cục.

🌐 [English](README.md) · [Bắt Đầu Nhanh](#-bắt-đầu-nhanh) · [Tính Năng](#-bao-gồm-gì) · [Báo Lỗi](https://github.com/zasuozz-oss/antigravity-superpowers/issues)

---

## 📋 Yêu Cầu

- [Google Antigravity](https://antigravity.google) (macOS / Windows / Linux)
- Git
- Bash (macOS/Linux) hoặc PowerShell (Windows)

---

## 🎯 Giới Thiệu

Fork từ framework [Superpowers](https://github.com/obra/superpowers), tùy chỉnh cho **Google Antigravity**. Bao gồm bộ skills cốt lõi cài đặt toàn cục tại `~/.gemini/antigravity/`.

**Khác biệt so với bản gốc:**
- ✅ Cài đặt tại đường dẫn native của Antigravity (`~/.gemini/antigravity/`)
- ✅ Tự động tạo `~/.gemini/GEMINI.md` với skill references
- ✅ Tự đồng bộ fork repo khi cập nhật từ upstream

---

## ⚡ Bắt Đầu Nhanh

### 1. Cài Đặt Toàn Cục (Chạy 1 lần)

**Cài nhanh (khuyến nghị):**
```bash
npx @zasuo/ag-s
```

<details>
<summary>Cách khác: Cài thủ công</summary>

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

### 2. Bắt Đầu Sử Dụng

Mở Antigravity trong bất kỳ project nào. Skills tự động load qua `~/.gemini/GEMINI.md`.

---

## 📚 Bao Gồm Gì

### Tổng quan bộ Skills

| Loại | Skills |
|------|--------|
| **Cốt lõi** | brainstorming, test-driven-development, systematic-debugging |
| **Cộng tác** | writing-plans, executing-plans |
| **Review** | requesting-code-review, receiving-code-review |
| **Git** | finishing-a-development-branch |
| **Meta** | using-superpowers, writing-skills, verification-before-completion |

---

## 📁 Cấu Trúc

```
antigravity-superpowers/
├── bin/cli.mjs                  # npx installer
├── scripts/                     # Script cài đặt & cập nhật
│   ├── setup-global.sh
│   ├── setup-global.ps1
│   └── update-superpowers.sh
├── skills/                      # Các skill từ Superpowers & Gitnexus
└── workflows/                   # Pre-made workflows
```

**Sau khi cài đặt:**
```
~/.gemini/
├── GEMINI.md                    # Global config (tự tạo)
└── antigravity/
    ├── skills/                  # Các skills đã cài đặt
    └── scripts/                 # Setup scripts
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
