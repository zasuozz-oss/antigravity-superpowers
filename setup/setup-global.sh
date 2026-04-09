#!/bin/bash
# Global setup script for Superpowers in Antigravity
# Installs skills, workflows, and scripts to ~/.gemini/antigravity/
# Usage: bash setup-global.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_DIR="$HOME/.gemini/antigravity"
GEMINI_MD="$HOME/.gemini/GEMINI.md"


echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Superpowers Global Setup for Antigravity               ║"
echo "║     Install skills globally                                ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if source directories exist
if [ ! -d "$SCRIPT_DIR/../skills" ]; then
    echo "❌ Error: skills/ not found"
    echo "   Make sure you're running this from the repository root"
    exit 1
fi

# Step 1: Create directory
echo "📁 Step 1/5: Creating global config directory..."
mkdir -p "$GLOBAL_DIR"
echo "   ✓ Created: $GLOBAL_DIR"
echo ""

# Step 2: Check for duplicate skill names
echo "🔍 Step 2/5: Checking for duplicate skills..."
DUPLICATES=$(grep -rh '^name:' "$SCRIPT_DIR/../skills/"*/SKILL.md 2>/dev/null | sed 's/^name:[[:space:]]*//' | sort | uniq -d)
if [ -n "$DUPLICATES" ]; then
    echo "   ❌ Duplicate skill names found:"
    echo "$DUPLICATES" | while read -r dup; do
        echo "      - $dup"
        grep -rl "^name:[[:space:]]*$dup$" "$SCRIPT_DIR/../skills/"*/SKILL.md | while read -r f; do
            echo "        → $f"
        done
    done
    exit 1
fi
SKILL_SRC_COUNT=$(ls -1d "$SCRIPT_DIR/../skills/"*/ 2>/dev/null | wc -l | tr -d ' ')
echo "   ✓ $SKILL_SRC_COUNT skills checked, no duplicates"
echo ""

# Step 3: Install skills
echo "📚 Step 3/5: Installing skills..."
if command -v rsync >/dev/null 2>&1; then
    rsync -av --delete --exclude-from="$SCRIPT_DIR/ignore-skills.txt" "$SCRIPT_DIR/../skills/" "$GLOBAL_DIR/skills/"
else
    mkdir -p "$GLOBAL_DIR/skills"
    for skill_path in "$SCRIPT_DIR/../skills"/*; do
        [ -e "$skill_path" ] || continue
        skill_name=$(basename "$skill_path")
        if ! grep -qE "^${skill_name}/?(\r)?$" "$SCRIPT_DIR/ignore-skills.txt" 2>/dev/null; then
            cp -R "$skill_path" "$GLOBAL_DIR/skills/"
        fi
    done
fi

SKILL_COUNT=$(ls -1 "$GLOBAL_DIR/skills" | wc -l | tr -d ' ')
echo "   ✓ $SKILL_COUNT skills installed"

echo ""

# Step 4: Install scripts
echo "⚙️  Step 4/5: Installing setup scripts..."
if command -v rsync >/dev/null 2>&1; then
    rsync -av --delete "$SCRIPT_DIR/" "$GLOBAL_DIR/setup/" --exclude="setup-global.sh" --exclude="setup-global.ps1" --exclude="ignore-skills.txt"
else
    mkdir -p "$GLOBAL_DIR/setup"
    for file in "$SCRIPT_DIR"/*; do
        [ -e "$file" ] || continue
        fname=$(basename "$file")
        if [ "$fname" != "setup-global.sh" ] && [ "$fname" != "setup-global.ps1" ] && [ "$fname" != "ignore-skills.txt" ]; then
            cp -R "$file" "$GLOBAL_DIR/setup/"
        fi
    done
fi
chmod +x "$GLOBAL_DIR/setup"/*.sh
SCRIPT_COUNT=$(ls -1 "$GLOBAL_DIR/setup" | wc -l | tr -d ' ')
echo "   ✓ $SCRIPT_COUNT setup scripts installed"
echo ""

# Step 5: Update GEMINI.md
echo "📝 Step 5/5: Updating global GEMINI.md..."

RULE_FILE="$SCRIPT_DIR/gemini_rule.md"

mkdir -p "$(dirname "$GEMINI_MD")"

# Always overwrite — GEMINI.md is a generated file
{
    if [ -f "$RULE_FILE" ]; then
        cat "$RULE_FILE"
    fi
} > "$GEMINI_MD"
echo "   ✓ Written: $GEMINI_MD"
echo ""

# Cleanup old legacy directories if present
if [ -d "$GLOBAL_DIR/rules" ] || [ -d "$GLOBAL_DIR/global_workflows" ]; then
    echo "🧹 Cleaning up legacy directories..."
    rm -rf "$GLOBAL_DIR/rules" "$GLOBAL_DIR/global_workflows"
    echo "   ✓ Removed legacy directories"
    echo ""
fi

# Verify
echo "✅ Verification..."
echo "   Skills:    $(ls -1 "$GLOBAL_DIR/skills" | wc -l | tr -d ' ')"
echo "   Setup Scripts:   $(ls -1 "$GLOBAL_DIR/setup" | wc -l | tr -d ' ')"
echo "   GEMINI.md: ✓"
echo ""

# Summary
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Installation Complete                                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "🚀 Next steps:"
echo "   1. Open Antigravity in any project"
echo "   2. Skills auto-load via ~/.gemini/GEMINI.md"
echo ""
echo "✅ Done!"
