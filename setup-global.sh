#!/bin/bash
# Global setup script for Superpowers in Antigravity
# Installs skills and scripts to ~/.gemini/antigravity/
# Usage: bash setup-global.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_DIR="$HOME/.gemini/antigravity"
GEMINI_MD="$HOME/.gemini/GEMINI.md"

# Block markers for detect/replace
BLOCK_START="<!-- BEGIN antigravity-superpowers -->"
BLOCK_END="<!-- END antigravity-superpowers -->"

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
echo "📁 Step 1: Creating global config directory..."
mkdir -p "$GLOBAL_DIR"
echo "   ✓ Created: $GLOBAL_DIR"
echo ""

# Step 2: Backup
if [ -d "$GLOBAL_DIR/skills" ] || [ -d "$GLOBAL_DIR/scripts" ]; then
    BACKUP_DIR="$GLOBAL_DIR-backup-$(date +%Y%m%d-%H%M%S)"
    echo "📦 Step 2: Backing up existing config..."
    cp -r "$GLOBAL_DIR" "$BACKUP_DIR"
    echo "   ✓ Backup: $BACKUP_DIR"
    echo ""
fi

# Step 3: Install skills
echo "📚 Step 3: Installing skills..."
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

# Step 4: Install scripts
echo "⚙️  Step 4: Installing scripts..."
rm -rf "$GLOBAL_DIR/scripts"
cp -r "$SCRIPT_DIR/scripts" "$GLOBAL_DIR/scripts"
chmod +x "$GLOBAL_DIR/scripts"/*.sh
SCRIPT_COUNT=$(ls -1 "$GLOBAL_DIR/scripts" | wc -l | tr -d ' ')
echo "   ✓ $SCRIPT_COUNT scripts installed"
echo ""

# Step 5: Update GEMINI.md
echo "📝 Step 5: Updating global GEMINI.md..."

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

# Step 6: Cleanup old rules/workflows if present
if [ -d "$GLOBAL_DIR/rules" ] || [ -d "$GLOBAL_DIR/global_workflows" ]; then
    echo "🧹 Step 6: Cleaning up old rules/workflows..."
    rm -rf "$GLOBAL_DIR/rules"
    rm -rf "$GLOBAL_DIR/global_workflows"
    echo "   ✓ Removed legacy rules and workflows"
    echo ""
fi

# Step 7: Verify
echo "✅ Verification..."
echo "   Skills:    $(ls -1 "$GLOBAL_DIR/skills" | wc -l | tr -d ' ')"
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
