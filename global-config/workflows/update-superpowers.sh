#!/bin/bash
# Update Superpowers skills from upstream repository
# Pulls latest skills from obra/superpowers, updates installed skills,
# and syncs changes back to fork repo's global-config/skills/
# Usage: bash ~/.gemini/antigravity/workflows/update-superpowers.sh

set -e

UPSTREAM_REPO="https://github.com/obra/superpowers.git"
UPSTREAM_BRANCH="main"
GLOBAL_SKILLS_DIR="$HOME/.gemini/antigravity/skills"
BACKUP_DIR="$HOME/.gemini/antigravity/skills-backup-$(date +%Y%m%d-%H%M%S)"
UPSTREAM_DIR="$HOME/.gemini/antigravity/.superpowers-upstream"

# Auto-detect fork repo location
FORK_REPO_DIR=""
SCRIPT_REAL_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_REAL_PATH/../../setup-global.sh" ]; then
    FORK_REPO_DIR="$(cd "$SCRIPT_REAL_PATH/../.." && pwd)"
elif [ -d "$HOME/AI-Tool/antigravity-superpowers/global-config" ]; then
    FORK_REPO_DIR="$HOME/AI-Tool/antigravity-superpowers"
fi

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Superpowers Update Workflow                           ║"
echo "║     Pull upstream → Update installed → Sync fork repo     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Backup
echo "📦 Step 1: Creating backup..."
cp -r "$GLOBAL_SKILLS_DIR" "$BACKUP_DIR"
echo "   ✓ Backup: $BACKUP_DIR"
echo ""

# Step 2: Fetch upstream
echo "🔄 Step 2: Fetching upstream (obra/superpowers)..."
if [ ! -d "$UPSTREAM_DIR" ]; then
    echo "   Cloning upstream..."
    git clone --depth 1 "$UPSTREAM_REPO" "$UPSTREAM_DIR"
    echo "   ✓ Cloned"
else
    echo "   Updating existing clone..."
    cd "$UPSTREAM_DIR"
    git fetch origin "$UPSTREAM_BRANCH"
    git reset --hard "origin/$UPSTREAM_BRANCH"
    cd - > /dev/null
    echo "   ✓ Updated"
fi
echo ""

# Step 3: Check for changes
echo "🔍 Step 3: Checking for updates..."
DIFF_FILE="/tmp/superpowers-diff-$(date +%Y%m%d-%H%M%S).txt"
diff -r "$GLOBAL_SKILLS_DIR/" "$UPSTREAM_DIR/skills/" > "$DIFF_FILE" 2>&1 || true

if [ -s "$DIFF_FILE" ]; then
    CHANGED=$(grep -cE "^(Only in|diff)" "$DIFF_FILE" 2>/dev/null || echo "0")
    echo "   ✓ $CHANGED changes found"
    echo ""
else
    echo "   ✓ Already up to date!"
    rm -f "$DIFF_FILE"
    exit 0
fi

# Step 4: Choose action
echo "📝 Step 4: What to do?"
echo "   1. Update all skills (overwrite)"
echo "   2. Show diff only"
echo "   3. Cancel"
echo ""
read -p "Choose (1-3): " option

case $option in
    1)
        echo ""
        echo "⚠️  This will overwrite all installed skills!"
        read -p "Confirm? (yes/no): " confirm
        if [ "$confirm" != "yes" ]; then
            echo "   Cancelled"
            exit 0
        fi

        # Update installed skills
        echo ""
        echo "📚 Updating installed skills..."
        rsync -av --delete "$UPSTREAM_DIR/skills/" "$GLOBAL_SKILLS_DIR/"
        SKILL_COUNT=$(ls -1 "$GLOBAL_SKILLS_DIR/" | wc -l | tr -d ' ')
        echo "   ✓ Updated $SKILL_COUNT skills at $GLOBAL_SKILLS_DIR/"
        echo ""

        # Sync back to fork repo
        if [ -n "$FORK_REPO_DIR" ] && [ -d "$FORK_REPO_DIR/global-config/skills" ]; then
            echo "🔄 Syncing to fork repo..."
            rsync -av --delete "$GLOBAL_SKILLS_DIR/" "$FORK_REPO_DIR/global-config/skills/"
            echo "   ✓ Synced to $FORK_REPO_DIR/global-config/skills/"
            echo ""
            echo "   📌 Remember to commit changes in the fork repo:"
            echo "   cd $FORK_REPO_DIR"
            echo "   git add -A && git commit -m 'chore: update skills from upstream'"
        else
            echo "⚠️  Fork repo not found. Only installed skills were updated."
            echo "   To sync manually, copy skills to your fork's global-config/skills/"
        fi
        ;;
    2)
        echo ""
        cat "$DIFF_FILE"
        echo ""
        echo "Diff saved: $DIFF_FILE"
        exit 0
        ;;
    3)
        echo "   Cancelled"
        exit 0
        ;;
    *)
        echo "   Invalid option"
        exit 1
        ;;
esac

# Summary
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Update Complete                                       ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Summary:"
echo "   - Installed skills: ✓ Updated ($SKILL_COUNT)"
if [ -n "$FORK_REPO_DIR" ] && [ -d "$FORK_REPO_DIR/global-config/skills" ]; then
echo "   - Fork repo: ✓ Synced"
fi
echo "   - Backup: $BACKUP_DIR"
echo "   - Custom rules: ✓ Untouched"
echo ""
echo "🔄 Rollback if needed:"
echo "   rm -rf $GLOBAL_SKILLS_DIR && cp -r $BACKUP_DIR $GLOBAL_SKILLS_DIR"
echo ""
echo "✅ Done!"
