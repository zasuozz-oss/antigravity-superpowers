# Changelog

All notable changes to this project will be documented in this file.

---

## [2.1.0] - 2026-03-13

### Changed — Antigravity Native Paths
- **Migrated all paths** from `~/.claude/global-config/` → `~/.gemini/antigravity/`
- `setup-global.sh` now installs to `~/.gemini/antigravity/` and auto-generates `~/.gemini/GEMINI.md`
- All rule files updated with native Antigravity skill paths
- Updated `GEMINI.md` `@` references to use `~/.gemini/antigravity/skills/`
- All 3 workflow scripts updated with new paths
- Verified against upstream [obra/superpowers](https://github.com/obra/superpowers) — 14/14 skills match

### Fixed
- Upstream repo URL: `cyanheads/superpowers` → `obra/superpowers`
- Removed `[your-username]` placeholders from all documentation
- Cleaned up duplicate `[1.3.0]` sections in CHANGELOG
- Removed references to non-existent `docs/` directory files

---

## [2.0.0] - 2026-03-13

### Changed — BREAKING: Global Configuration
- **Major refactor:** Changed from local to global configuration model
- Skills now installed globally at `~/.gemini/antigravity/skills/`
- Rules now installed globally at `~/.gemini/antigravity/rules/`
- Workflows now installed globally at `~/.gemini/antigravity/scripts/`
- Projects reference global skills via GEMINI.md: `@~/.gemini/antigravity/skills/using-superpowers/SKILL.md`

### Added
- `setup-global.sh` — One-time global installation script
- `global-config/` directory structure for distribution
- `setup-antigravity-project.sh` — *(removed in v5.0.3)*
- Global rules: `00-mandatory-skills.md`, `01-iron-laws.md`, `02-workflow-enforcement.md`

### Removed
- `.agents/` directory (local workspace config)
- `skills/` directory from repository root (now in `global-config/`)
- Per-project skill duplication

### Migration Guide
1. Run `bash setup-global.sh` to install globally
2. Update `GEMINI.md` in projects to reference `~/.gemini/antigravity/skills/`
3. Remove local `.agents/` directories from projects

---

## [1.3.0] - 2026-03-13

### Changed
- **Unity Skills Separated** — Moved to separate repository
- Update workflow added (`update-superpowers.sh`)
- Consolidated documentation structure
- Refactored for Antigravity-only (removed Claude Code references)

### Removed
- `CLAUDE.md`, redundant documentation files
- Unity skills (moved to `antigravity-unity-skills` repo)

---

## [1.1.0] - 2026-03-13

### Added
- Unity Skills Integration (70 skills in `.agents/skills-unity/`)

---

## [1.0.0] - 2026-03-13

### Added
- **Initial Release** — 14 Superpowers skills configured for Antigravity
- `GEMINI.md` configuration with auto-loading
- Enforcement rules (3 Iron Laws)
- Complete documentation

---

## Links

- **Repository:** [zasuozz/antigravity-superpowers](https://github.com/zasuozz/antigravity-superpowers)
- **Upstream:** [obra/superpowers](https://github.com/obra/superpowers)
- **Google Antigravity:** [antigravity.google](https://antigravity.google)
