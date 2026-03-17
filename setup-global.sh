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
if [ ! -d "$SCRIPT_DIR/global-config/skills" ]; then
    echo "❌ Error: global-config/skills/ not found"
    echo "   Make sure you're running this from the repository root"
    exit 1
fi

# Step 1: Create directory
echo "📁 Step 1/7: Creating global config directory..."
mkdir -p "$GLOBAL_DIR"
echo "   ✓ Created: $GLOBAL_DIR"
echo ""

# Step 2: Check for duplicate skill names
echo "🔍 Step 2/7: Checking for duplicate skills..."
DUPLICATES=$(grep -rh '^name:' "$SCRIPT_DIR/global-config/skills/"*/SKILL.md 2>/dev/null | sed 's/^name:[[:space:]]*//' | sort | uniq -d)
if [ -n "$DUPLICATES" ]; then
    echo "   ❌ Duplicate skill names found:"
    echo "$DUPLICATES" | while read -r dup; do
        echo "      - $dup"
        grep -rl "^name:[[:space:]]*$dup$" "$SCRIPT_DIR/global-config/skills/"*/SKILL.md | while read -r f; do
            echo "        → $f"
        done
    done
    exit 1
fi
SKILL_SRC_COUNT=$(ls -1d "$SCRIPT_DIR/global-config/skills/"*/ 2>/dev/null | wc -l | tr -d ' ')
echo "   ✓ $SKILL_SRC_COUNT skills checked, no duplicates"
echo ""

# Step 3: Install skills
echo "📚 Step 3/7: Installing skills..."
rm -rf "$GLOBAL_DIR/skills"
cp -r "$SCRIPT_DIR/global-config/skills" "$GLOBAL_DIR/skills"
SKILL_COUNT=$(ls -1 "$GLOBAL_DIR/skills" | wc -l | tr -d ' ')
echo "   ✓ $SKILL_COUNT skills installed"
# Also install gemini_rule.md to global dir
if [ -f "$SCRIPT_DIR/global-config/gemini_rule.md" ]; then
    cp "$SCRIPT_DIR/global-config/gemini_rule.md" "$GLOBAL_DIR/gemini_rule.md"
    echo "   ✓ gemini_rule.md installed"
fi
echo ""

# Step 4: Install workflows
echo "🔄 Step 4/7: Installing workflows..."
rm -rf "$GLOBAL_DIR/global_workflows"
WORKFLOW_COUNT=0
if [ -d "$SCRIPT_DIR/global-config/workflows" ]; then
    cp -r "$SCRIPT_DIR/global-config/workflows" "$GLOBAL_DIR/global_workflows"
    WORKFLOW_COUNT=$(ls -1 "$GLOBAL_DIR/global_workflows" | wc -l | tr -d ' ')
    echo "   ✓ $WORKFLOW_COUNT workflows installed"
else
    echo "   ⚠ No workflows found, skipping"
fi
echo ""

# Step 5: Install scripts
echo "⚙️  Step 5/7: Installing scripts..."
rm -rf "$GLOBAL_DIR/scripts"
cp -r "$SCRIPT_DIR/scripts" "$GLOBAL_DIR/scripts"
chmod +x "$GLOBAL_DIR/scripts"/*.sh
SCRIPT_COUNT=$(ls -1 "$GLOBAL_DIR/scripts" | wc -l | tr -d ' ')
echo "   ✓ $SCRIPT_COUNT scripts installed"
echo ""

# Step 5: Update GEMINI.md
echo "📝 Step 6/7: Updating global GEMINI.md..."

RULE_FILE="$SCRIPT_DIR/global-config/gemini_rule.md"

mkdir -p "$(dirname "$GEMINI_MD")"

# Always overwrite — GEMINI.md is a generated file
{
    if [ -f "$RULE_FILE" ]; then
        cat "$RULE_FILE"
    fi
} > "$GEMINI_MD"
echo "   ✓ Written: $GEMINI_MD"
echo ""

# Step 7: Cleanup old legacy directories if present
if [ -d "$GLOBAL_DIR/rules" ]; then
    echo "🧹 Step 7/7: Cleaning up legacy directories..."
    rm -rf "$GLOBAL_DIR/rules"
    echo "   ✓ Removed legacy rules"
    echo ""
fi

# Step 8: Verify
echo "✅ Verification..."
echo "   Skills:    $(ls -1 "$GLOBAL_DIR/skills" | wc -l | tr -d ' ')"
echo "   Workflows: $WORKFLOW_COUNT"
echo "   Scripts:   $(ls -1 "$GLOBAL_DIR/scripts" | wc -l | tr -d ' ')"
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
