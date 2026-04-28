#!/bin/bash
# Update Superpowers skills from upstream repository
# Pulls latest skills from obra/superpowers, updates installed skills,
# and syncs changes back to fork repo's global-config/skills/
# Usage: bash ~/.gemini/antigravity/setup/update-superpowers.sh

set -e

UPSTREAM_REPO="https://github.com/obra/superpowers.git"
UPSTREAM_BRANCH="main"
GLOBAL_SKILLS_DIR="$HOME/.gemini/antigravity/skills"
# Auto-detect fork repo location
FORK_REPO_DIR=""
SCRIPT_REAL_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
POTENTIAL_FORK="$(cd "$SCRIPT_REAL_PATH/.." && pwd)"
GLOBAL_DIR="$HOME/.gemini/antigravity"

if [ "$POTENTIAL_FORK" != "$GLOBAL_DIR" ] && [ -d "$POTENTIAL_FORK/skills" ]; then
    FORK_REPO_DIR="$POTENTIAL_FORK"
elif [ "$(pwd)" != "$GLOBAL_DIR" ] && [ -d "$(pwd)/skills" ]; then
    FORK_REPO_DIR="$(pwd)"
fi

UPSTREAM_DIR="$FORK_REPO_DIR/superpowers"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Superpowers Update Workflow                           ║"
echo "║     Pull upstream → Update installed → Sync fork repo     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Fetch upstream
echo "🔄 Step 1: Fetching upstream (obra/superpowers)..."
CACHE_DIR="$HOME/.gemini/antigravity/.superpowers-cache"
echo "   Cloning upstream..."
rm -rf "$CACHE_DIR"
git clone --quiet --depth 1 "$UPSTREAM_REPO" "$CACHE_DIR"
echo "   ✓ Cloned"

if [ -n "$FORK_REPO_DIR" ]; then
    # Backup to superpowers directory (so user can commit it) without .git files
    if command -v rsync >/dev/null 2>&1; then
        rsync -a --delete --exclude '.git/' --exclude '.gitignore' --exclude '.gitattributes' "$CACHE_DIR/" "$UPSTREAM_DIR/"
    else
        rm -rf "$UPSTREAM_DIR"
        cp -R "$CACHE_DIR" "$UPSTREAM_DIR"
        rm -rf "$UPSTREAM_DIR/.git"
        rm -f "$UPSTREAM_DIR/.gitignore" "$UPSTREAM_DIR/.gitattributes"
    fi
    echo "   ✓ Backed up to fork repo (plain files)"
fi

# Set the source directory for the rest of the script
UPSTREAM_DIR="$CACHE_DIR"
echo ""

# Step 2: Check for changes
echo "🔍 Step 2: Checking for updates..."
DIFF_FILE="/tmp/superpowers-diff-$(date +%Y%m%d-%H%M%S).txt"

# Build diff exclude arguments dynamically from ignore-skills.txt
DIFF_OPTS=""
while read -r line; do
    # Skip empty lines
    if [ -n "$line" ]; then
        # Remove trailing slash for diff -x
        CLEAN_NAME="${line%/}"
        DIFF_OPTS="$DIFF_OPTS -x '$CLEAN_NAME'"
    fi
done < "$SCRIPT_REAL_PATH/ignore-skills.txt"

# Also exclude custom local skills (skills in GLOBAL but not in UPSTREAM)
if [ -d "$UPSTREAM_DIR/skills/" ]; then
    for local_skill in "$GLOBAL_SKILLS_DIR"/*; do
        skill_name=$(basename "$local_skill")
        if [ ! -e "$UPSTREAM_DIR/skills/$skill_name" ]; then
            DIFF_OPTS="$DIFF_OPTS -x '$skill_name'"
        fi
    done
fi

# Run diff using the dynamically built arguments
eval "diff -r $DIFF_OPTS \"$GLOBAL_SKILLS_DIR/\" \"$UPSTREAM_DIR/skills/\" > \"$DIFF_FILE\" 2>&1 || true"


if [ -s "$DIFF_FILE" ]; then
    CHANGED=$(grep -cE "^(Only in|diff)" "$DIFF_FILE" 2>/dev/null || echo "0")
    echo "   ✓ $CHANGED changes found"
    echo ""
else
    echo "   ✓ Already up to date!"
    rm -f "$DIFF_FILE"
    exit 0
fi

# Step 3: Automatically apply updates
echo "📝 Step 3: Applying updates automatically..."

        # Update installed skills
        echo ""
        echo "📚 Updating installed skills..."
        if command -v rsync >/dev/null 2>&1; then
            rsync -av --exclude-from="$SCRIPT_REAL_PATH/ignore-skills.txt" "$UPSTREAM_DIR/skills/" "$GLOBAL_SKILLS_DIR/"
        else
            mkdir -p "$GLOBAL_SKILLS_DIR"
            for skill_path in "$UPSTREAM_DIR/skills"/*; do
                [ -e "$skill_path" ] || continue
                skill_name=$(basename "$skill_path")
                if ! grep -qE "^${skill_name}/?(\r)?$" "$SCRIPT_REAL_PATH/ignore-skills.txt" 2>/dev/null; then
                    cp -R "$skill_path" "$GLOBAL_SKILLS_DIR/"
                fi
            done
        fi
        SKILL_COUNT=$(ls -1 "$GLOBAL_SKILLS_DIR/" | wc -l | tr -d ' ')
        echo "   ✓ Updated $SKILL_COUNT skills at $GLOBAL_SKILLS_DIR/"
        echo ""

        # Sync back to fork repo
        if [ -n "$FORK_REPO_DIR" ] && [ -d "$FORK_REPO_DIR/skills" ]; then
            echo "🔄 Syncing to fork repo..."
            if command -v rsync >/dev/null 2>&1; then
                rsync -av --exclude '.git/' "$GLOBAL_SKILLS_DIR/" "$FORK_REPO_DIR/skills/"
            else
                mkdir -p "$FORK_REPO_DIR/skills"
                for skill_path in "$GLOBAL_SKILLS_DIR"/*; do
                    [ -e "$skill_path" ] || continue
                    skill_name=$(basename "$skill_path")
                    if [ "$skill_name" != ".git" ]; then
                        cp -R "$skill_path" "$FORK_REPO_DIR/skills/"
                    fi
                done
            fi
            echo "   ✓ Synced to $FORK_REPO_DIR/skills/"
            echo ""
            echo "   📌 Remember to commit changes in the fork repo:"
            echo "   cd $FORK_REPO_DIR"
            echo "   git add -A && git commit -m 'chore: update skills from upstream'"
        else
            echo "⚠️  Fork repo not found. Only installed skills were updated."
            echo "   To sync manually, copy skills to your fork's skills/"
        fi

# Summary
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Update Complete                                       ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Summary:"
echo "   - Installed skills: ✓ Updated ($SKILL_COUNT)"
if [ -n "$FORK_REPO_DIR" ] && [ -d "$FORK_REPO_DIR/skills" ]; then
echo "   - Fork repo: ✓ Synced"
fi
echo "   - Custom rules: ✓ Untouched"
echo ""
echo "✅ Done!"
