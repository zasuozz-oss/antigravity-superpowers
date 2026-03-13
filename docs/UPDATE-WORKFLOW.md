# Update Workflow - Superpowers Global Configuration

Guide for keeping your global Superpowers skills up-to-date with upstream changes.

---

## 🎯 Overview

The update workflow allows you to:
- Fetch latest skills from upstream repository
- Compare your version with upstream
- Update all or specific skills
- Rollback if needed

---

## 🔄 Quick Update

### Update All Skills

```bash
bash ~/.claude/global-config/workflows/update-superpowers.sh
```

Follow the interactive prompts:
1. **Option 1:** Update all skills (recommended for most users)
2. **Option 2:** Show full diff (review changes first)
3. **Option 3:** Update specific skills manually
4. **Option 4:** Cancel

---

## 📋 Detailed Workflow

### Step 1: Run Update Script

```bash
bash ~/.claude/global-config/workflows/update-superpowers.sh
```

### Step 2: Review Changes

The script will:
1. Create backup of current skills
2. Fetch upstream repository
3. Compare versions
4. Show summary of changes

**Example output:**
```
🔍 Step 3: Checking for updates...
   ✓ Updates found!
   Diff saved to: /tmp/superpowers-diff-20260313-052525.txt

   Summary of changes:
   diff -r skills/brainstorming/SKILL.md .superpowers-upstream/skills/brainstorming/SKILL.md
   Only in .superpowers-upstream/skills: new-skill
```

### Step 3: Choose Update Option

**Option 1: Update All (Recommended)**
```
Choose option (1-4): 1
⚠️  WARNING: This will overwrite all global skills!
Are you sure? (yes/no): yes
   Updating all skills...
   ✓ All skills updated
```

**Option 2: Show Full Diff**
```
Choose option (1-4): 2
📄 Full diff:
[Shows complete diff output]
Diff saved to: /tmp/superpowers-diff-20260313-052525.txt
```

**Option 3: Manual Update**
```
Choose option (1-4): 3
📋 Manual update instructions:
   1. Review diff: cat /tmp/superpowers-diff-20260313-052525.txt
   2. Upstream location: ~/.claude/global-config/.superpowers-upstream/skills/
   3. Your skills: ~/.claude/global-config/skills/
   4. Copy specific skills manually

Example:
   cp -r ~/.claude/global-config/.superpowers-upstream/skills/brainstorming ~/.claude/global-config/skills/
```

### Step 4: Verify Update

```bash
# Check skill count
ls -1 ~/.claude/global-config/skills/ | wc -l
# Should show: 14

# Test in Antigravity
# Open a project and verify skills load correctly
```

---

## 🔙 Rollback

If update causes issues, rollback to backup:

```bash
# Find backup directory
ls -d ~/.claude/global-config-backup-*

# Rollback
rm -rf ~/.claude/global-config/skills
cp -r ~/.claude/global-config-backup-YYYYMMDD-HHMMSS/skills ~/.claude/global-config/skills
```

---

## 🎯 Update Frequency

**Recommended:**
- Check for updates: Monthly
- Apply updates: When new features needed or bugs fixed

**How to check:**
```bash
# Run update script and choose option 2 (show diff)
bash ~/.claude/global-config/workflows/update-superpowers.sh
# Choose: 2
```

---

## 🛠️ Manual Update Process

If you prefer manual control:

### Step 1: Clone Upstream

```bash
cd ~/.claude/global-config
git clone https://github.com/cyanheads/superpowers.git .superpowers-upstream
```

### Step 2: Compare Versions

```bash
diff -r skills/ .superpowers-upstream/skills/ > /tmp/superpowers-diff.txt
cat /tmp/superpowers-diff.txt
```

### Step 3: Update Specific Skills

```bash
# Update single skill
cp -r .superpowers-upstream/skills/brainstorming skills/

# Update multiple skills
cp -r .superpowers-upstream/skills/{brainstorming,test-driven-development} skills/
```

### Step 4: Update Upstream Repository

```bash
cd ~/.claude/global-config/.superpowers-upstream
git pull origin main
```

---

## 🔍 What Gets Updated

### Skills Directory
- All 14 Superpowers skills
- Skill documentation (SKILL.md)
- References and templates
- Scripts and tools

### NOT Updated
- Rules (manually managed)
- Workflows (manually managed)
- Project GEMINI.md files

---

## ⚠️ Important Notes

### Backup Before Update
The script automatically creates backups, but you can also:
```bash
cp -r ~/.claude/global-config/skills ~/.claude/global-config/skills-backup-manual
```

### Custom Modifications
If you've customized skills:
1. Use Option 3 (manual update)
2. Review diff carefully
3. Merge changes manually
4. Keep notes of customizations

### Breaking Changes
Check upstream changelog before updating:
- https://github.com/cyanheads/superpowers/releases

---

## 🐛 Troubleshooting

### Update Script Fails

**Problem:** Script exits with error

**Solutions:**
1. Check internet connection
2. Verify git installed: `git --version`
3. Check permissions: `ls -la ~/.claude/global-config/`
4. Try manual update process

### Skills Not Working After Update

**Problem:** Agent doesn't follow updated skills

**Solutions:**
1. Restart Antigravity
2. Verify GEMINI.md still correct
3. Check skill paths: `ls ~/.claude/global-config/skills/`
4. Rollback to backup if needed

### Upstream Repository Issues

**Problem:** Can't fetch upstream

**Solutions:**
1. Check GitHub status: https://www.githubstatus.com/
2. Try again later
3. Use manual update with git clone

---

## 📊 Update History

Track your updates:

```bash
# Create update log
echo "$(date): Updated to upstream $(cd ~/.claude/global-config/.superpowers-upstream && git rev-parse --short HEAD)" >> ~/.claude/global-config/update-history.txt

# View history
cat ~/.claude/global-config/update-history.txt
```

---

## ✅ Post-Update Checklist

After updating:

- [ ] Verify skill count: `ls -1 ~/.claude/global-config/skills/ | wc -l`
- [ ] Test in Antigravity project
- [ ] Check brainstorming skill works
- [ ] Check TDD skill works
- [ ] Check debugging skill works
- [ ] Verify GEMINI.md still loads skills
- [ ] Document any issues

---

## 🆘 Need Help?

1. **Update issues:** Re-read this guide
2. **Skill issues:** Check [GLOBAL-SETUP-GUIDE.md](GLOBAL-SETUP-GUIDE.md)
3. **Bug reports:** [GitHub Issues](https://github.com/[your-username]/antigravity-superpowers/issues)

---

## 📝 Quick Reference

```bash
# Update all skills
bash ~/.claude/global-config/workflows/update-superpowers.sh

# Show diff only
bash ~/.claude/global-config/workflows/update-superpowers.sh
# Choose option: 2

# Rollback
rm -rf ~/.claude/global-config/skills
cp -r ~/.claude/global-config-backup-YYYYMMDD-HHMMSS/skills ~/.claude/global-config/skills

# Verify
ls -1 ~/.claude/global-config/skills/ | wc -l
```

---

**Last Updated:** 2026-03-13T05:25:25Z
**Version:** 2.0.0
**Status:** Production-ready
