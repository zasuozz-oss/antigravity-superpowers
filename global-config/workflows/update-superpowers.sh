#!/bin/bash
# Update Superpowers skills from upstream repository
# Usage: bash ~/.claude/global-config/workflows/update-superpowers.sh

set -e

UPSTREAM_REPO="https://github.com/cyanheads/superpowers.git"
UPSTREAM_BRANCH="main"
GLOBAL_SKILLS_DIR="$HOME/.claude/global-config/skills"
BACKUP_DIR="$HOME/.claude/global-config/skills-backup-$(date +%Y%m%d-%H%M%S)"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Superpowers Global Update Workflow                    ║"
echo "║     Update global skills from upstream repository         ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Backup current state
echo "📦 Step 1: Creating backup..."
cp -r "$GLOBAL_SKILLS_DIR" "$BACKUP_DIR"
echo "   ✓ Backup created: $BACKUP_DIR"
echo ""

# Step 2: Fetch upstream
echo "🔄 Step 2: Fetching upstream repository..."
UPSTREAM_DIR="$HOME/.claude/global-config/.superpowers-upstream"
if [ ! -d "$UPSTREAM_DIR" ]; then
    echo "   Cloning upstream repository..."
    git clone --depth 1 "$UPSTREAM_REPO" "$UPSTREAM_DIR"
    echo "   ✓ Repository cloned"
else
    echo "   Updating existing upstream repository..."
    cd "$UPSTREAM_DIR"
    git fetch origin "$UPSTREAM_BRANCH"
    git reset --hard "origin/$UPSTREAM_BRANCH"
    cd - > /dev/null
    echo "   ✓ Repository updated"
fi
echo ""

# Step 3: Compare versions
echo "🔍 Step 3: Checking for updates..."
DIFF_FILE="/tmp/superpowers-diff-$(date +%Y%m%d-%H%M%S).txt"
diff -r "$GLOBAL_SKILLS_DIR/" "$UPSTREAM_DIR/skills/" > "$DIFF_FILE" 2>&1 || true

if [ -s "$DIFF_FILE" ]; then
    echo "   ✓ Updates found!"
    echo "   Diff saved to: $DIFF_FILE"
    echo ""
    echo "   Summary of changes:"
    grep -E "^(Only in|diff)" "$DIFF_FILE" | head -20
    echo ""
else
    echo "   ✓ No updates available - you're up to date!"
    rm -f "$DIFF_FILE"
    exit 0
fi

# Step 4: Interactive update
echo "📝 Step 4: Update options:"
echo "   1. Update all skills (overwrite everything)"
echo "   2. Show full diff"
echo "   3. Update specific skills (manual)"
echo "   4. Cancel"
echo ""
read -p "Choose option (1-4): " option

case $option in
    1)
        echo ""
        echo "⚠️  WARNING: This will overwrite all global skills!"
        read -p "Are you sure? (yes/no): " confirm
        if [ "$confirm" = "yes" ]; then
            echo "   Updating all skills..."
            rsync -av --delete "$UPSTREAM_DIR/skills/" "$GLOBAL_SKILLS_DIR/"
            echo "   ✓ All skills updated"
        else
            echo "   Update cancelled"
            exit 0
        fi
        ;;
    2)
        echo ""
        echo "📄 Full diff:"
        cat "$DIFF_FILE"
        echo ""
        echo "Diff saved to: $DIFF_FILE"
        exit 0
        ;;
    3)
        echo ""
        echo "📋 Manual update instructions:"
        echo "   1. Review diff: cat $DIFF_FILE"
        echo "   2. Upstream location: $UPSTREAM_DIR/skills/"
        echo "   3. Your skills: $GLOBAL_SKILLS_DIR/"
        echo "   4. Copy specific skills manually"
        echo ""
        echo "Example:"
        echo "   cp -r $UPSTREAM_DIR/skills/brainstorming $GLOBAL_SKILLS_DIR/"
        exit 0
        ;;
    4)
        echo ""
        echo "❌ Update cancelled"
        exit 0
        ;;
    *)
        echo ""
        echo "❌ Invalid option"
        exit 1
        ;;
esac

# Step 5: Verify
echo ""
echo "✅ Step 5: Verification..."
SKILL_COUNT=$(ls -1 "$GLOBAL_SKILLS_DIR/" | wc -l | tr -d ' ')
echo "   Skills count: $SKILL_COUNT"
echo "   ✓ Verification complete"
echo ""

# Step 6: Summary
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Update Complete                                        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Summary:"
echo "   - Skills updated: ✓"
echo "   - Backup location: $BACKUP_DIR"
echo ""
echo "🔄 To rollback if needed:"
echo "   rm -rf $GLOBAL_SKILLS_DIR && cp -r $BACKUP_DIR $GLOBAL_SKILLS_DIR"
echo ""
echo "📝 Next steps:"
echo "   1. Test skills in Claude Code"
echo "   2. Verify CLAUDE.md still works"
echo "   3. Check enforcement rules"
echo ""
echo "✅ Done!"
