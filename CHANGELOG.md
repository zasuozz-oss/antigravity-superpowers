# Changelog

All notable changes to this project will be documented in this file.

---

## [2.0.0] - 2026-03-13

### Changed - BREAKING: Global Configuration
- **Major refactor:** Changed from local to global configuration model
- Skills now installed globally at `~/.claude/global-config/skills/`
- Rules now installed globally at `~/.claude/global-config/rules/`
- Workflows now installed globally at `~/.claude/global-config/workflows/`
- Projects reference global skills via GEMINI.md: `@~/.claude/global-config/skills/using-superpowers/SKILL.md`

### Added
- `setup-global.sh` - One-time global installation script
- `global-config/` directory structure for distribution
- `setup-antigravity-project.sh` - Per-project setup workflow
- `setup-project.sh` - Claude Code project setup workflow
- Global rules: 00-mandatory-skills.md, 01-iron-laws.md, 02-workflow-enforcement.md
- docs/GLOBAL-SETUP-GUIDE.md - Complete setup documentation
- docs/UPDATE-WORKFLOW.md - Update instructions (rewritten for global config)

### Removed
- `.agents/` directory (local workspace config)
- `skills/` directory from repository root (now in global-config/)
- START-HERE.md (replaced by GLOBAL-SETUP-GUIDE.md)
- QUICK-REFERENCE.md (consolidated into README.md)
- Local rules and workflows from `.agents/`

### Migration Guide
**For existing users:**
1. Run `bash setup-global.sh` to install globally
2. Update GEMINI.md in projects to reference `~/.claude/global-config/skills/`
3. Remove local `.agents/` directories from projects

---

## [1.3.0] - 2026-03-13

### Added
- **Update Workflow** - Automated script to update Superpowers from upstream
  - `.agents/workflows/update-superpowers.sh` - Interactive update script
  - `docs/UPDATE-WORKFLOW.md` - Complete documentation
  - Backup and rollback support
  - Version comparison and diff viewing

- **Consolidated Documentation**
  - `docs/ANTIGRAVITY-GUIDE.md` - Complete Antigravity guide
  - `docs/UNITY-SKILLS-GUIDE.md` - Unity skills guide
  - `docs/README.md` - Documentation index
  - Better organization and navigation

- **Unity Skills Integration** (70 skills)
  - `.agents/skills-unity/` - Unity-specific skills
  - Organized by 9 categories
  - Complete README and INDEX
  - No conflicts with Superpowers skills

### Changed
- **Refactored for Antigravity-only**
  - Removed all Claude Code references
  - Updated platform references to "Google Antigravity"
  - Simplified tool mapping documentation
  - Focused all documentation on Antigravity usage

- **Documentation Cleanup**
  - Consolidated 13+ root files to 6 essential files
  - Moved detailed docs to `docs/` directory
  - Removed redundant documentation files
  - Improved documentation structure

- **Updated Files**
  - `README.md` - Antigravity-focused overview
  - `START-HERE.md` - Simplified quick start
  - `QUICK-REFERENCE.md` - Antigravity-only reference

### Removed
- `CLAUDE.md` - Claude Code specific configuration
- Redundant documentation files:
  - `FINAL-STATUS.md`
  - `FINAL-REPORT.md`
  - `INTEGRATION-SUMMARY.md`
  - `PROJECT-COMPLETE.md`
  - `HOAN-THANH-CUOI-CUNG.md`
  - `ENFORCEMENT-COMPLETE.md`
  - `RELEASE-NOTES.md`
  - `SUMMARY.md`

---

## [1.1.0] - 2026-03-13

### Added
- **Unity Skills Integration**
  - 70 Unity-specific skills in `.agents/skills-unity/`
  - Organized by categories (architecture, gameplay, visuals, etc.)
  - Complete documentation and catalog
  - No conflicts with Superpowers skills

- **Documentation**
  - `docs/UNITY-SKILLS-INTEGRATION-COMPLETE.md`
  - `.agents/skills-unity/README.md`
  - `.agents/skills-unity/INDEX.md`

### Changed
- Updated `START-HERE.md` with Unity skills section
- Updated `QUICK-REFERENCE.md` with Unity skills reference

---

## [1.0.0] - 2026-03-13

### Added
- **Initial Release**
  - 14 Superpowers skills configured for Antigravity
  - `.agents/` directory structure
  - Symlink: `.agents/skills/` → `../skills`
  - `GEMINI.md` configuration with auto-loading
  - Enforcement rules in `.agents/rules/`
  - Complete documentation (English + Vietnamese)

- **Skills**
  - brainstorming (mandatory)
  - test-driven-development
  - systematic-debugging
  - writing-plans
  - executing-plans
  - subagent-driven-development
  - dispatching-parallel-agents
  - requesting-code-review
  - receiving-code-review
  - using-git-worktrees
  - finishing-a-development-branch
  - verification-before-completion
  - using-superpowers
  - writing-skills

- **Documentation**
  - `START-HERE.md` - Quick start guide
  - `QUICK-REFERENCE.md` - Quick reference
  - `docs/antigravity-usage-guide.md` - Complete guide
  - `docs/NGHIEN-CUU-ANTIGRAVITY.md` - Vietnamese guide
  - Multiple supporting documents

- **Enforcement**
  - 3 Iron Laws enforcement
  - Mandatory skill usage rules
  - Skill trigger mapping
  - Red flags and examples

---

## Version History

- **1.2.0** (2026-03-13) - Antigravity-only refactor + Update workflow
- **1.1.0** (2026-03-13) - Unity skills integration
- **1.0.0** (2026-03-13) - Initial release

---

## Upgrade Guide

### From 1.1.0 to 1.2.0

**No breaking changes.** Simply pull latest changes.

**New features:**
- Update workflow available: `bash .agents/workflows/update-superpowers.sh`
- New consolidated guides in `docs/`
- Cleaner root directory

**Removed:**
- `CLAUDE.md` (use `GEMINI.md` instead)
- Redundant documentation files (consolidated in `docs/`)

### From 1.0.0 to 1.1.0

**No breaking changes.** Unity skills added separately.

**New features:**
- 70 Unity skills in `.agents/skills-unity/`
- Unity documentation

---

## Links

- **Repository:** https://github.com/[your-username]/antigravity-superpowers
- **Superpowers Framework:** https://github.com/cyanheads/superpowers
- **Google Antigravity:** https://antigravity.google

---

**Last Updated:** 2026-03-13T04:54:35Z

---

## [1.3.0] - 2026-03-13

### Changed
- **Unity Skills Separated** - Moved to separate repository
  - Removed `.agents/skills-unity/` (70 skills)
  - Unity skills now in: `antigravity-unity-skills` repository
  - Keeps Superpowers repository focused and clean

### Removed
- `docs/UNITY-SKILLS-GUIDE.md` - Moved to Unity skills repo
- `.agents/skills-unity/` directory (1.7 MB)

### Updated
- README.md - Removed Unity skills references
- START-HERE.md - Added link to Unity skills repo
- QUICK-REFERENCE.md - Updated status
- Documentation references

---
