#!/bin/bash
# Global setup script for Superpowers in Antigravity
# Installs skills, rules, and workflows to ~/.claude/global-config/
# Usage: bash setup-global.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_DIR="$HOME/.claude/global-config"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Superpowers Global Setup for Antigravity               ║"
echo "║     Install skills, rules, and workflows globally          ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if source directories exist
if [ ! -d "$SCRIPT_DIR/global-config/skills" ]; then
    echo "❌ Error: global-config/skills/ not found"
    echo "   Make sure you're running this from the repository root"
    exit 1
fi

# Create global config directory
echo "📁 Step 1: Creating global config directory..."
mkdir -p "$GLOBAL_DIR"
echo "   ✓ Created: $GLOBAL_DIR"
echo ""

# Backup existing config if present
if [ -d "$GLOBAL_DIR/skills" ] || [ -d "$GLOBAL_DIR/rules" ] || [ -d "$GLOBAL_DIR/workflows" ]; then
    BACKUP_DIR="$GLOBAL_DIR-backup-$(date +%Y%m%d-%H%M%S)"
    echo "📦 Step 2: Backing up existing config..."
    cp -r "$GLOBAL_DIR" "$BACKUP_DIR"
    echo "   ✓ Backup created: $BACKUP_DIR"
    echo ""
fi

# Install skills
echo "📚 Step 3: Installing skills..."
rm -rf "$GLOBAL_DIR/skills"
cp -r "$SCRIPT_DIR/global-config/skills" "$GLOBAL_DIR/skills"
SKILL_COUNT=$(ls -1 "$GLOBAL_DIR/skills" | wc -l | tr -d ' ')
echo "   ✓ Installed $SKILL_COUNT skills to $GLOBAL_DIR/skills/"
echo ""

# Install rules
echo "📋 Step 4: Installing rules..."
rm -rf "$GLOBAL_DIR/rules"
cp -r "$SCRIPT_DIR/global-config/rules" "$GLOBAL_DIR/rules"
RULE_COUNT=$(ls -1 "$GLOBAL_DIR/rules" | wc -l | tr -d ' ')
echo "   ✓ Installed $RULE_COUNT rules to $GLOBAL_DIR/rules/"
echo ""

# Install workflows
echo "⚙️  Step 5: Installing workflows..."
rm -rf "$GLOBAL_DIR/workflows"
cp -r "$SCRIPT_DIR/global-config/workflows" "$GLOBAL_DIR/workflows"
chmod +x "$GLOBAL_DIR/workflows"/*.sh
WORKFLOW_COUNT=$(ls -1 "$GLOBAL_DIR/workflows" | wc -l | tr -d ' ')
echo "   ✓ Installed $WORKFLOW_COUNT workflows to $GLOBAL_DIR/workflows/"
echo ""

# Verify installation
echo "✅ Step 6: Verification..."
echo "   Skills: $(ls -1 "$GLOBAL_DIR/skills" | wc -l | tr -d ' ')"
echo "   Rules: $(ls -1 "$GLOBAL_DIR/rules" | wc -l | tr -d ' ')"
echo "   Workflows: $(ls -1 "$GLOBAL_DIR/workflows" | wc -l | tr -d ' ')"
echo ""

# Summary
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Installation Complete                                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Summary:"
echo "   - Global config: $GLOBAL_DIR"
echo "   - Skills: ✓ Installed ($SKILL_COUNT)"
echo "   - Rules: ✓ Installed ($RULE_COUNT)"
echo "   - Workflows: ✓ Installed ($WORKFLOW_COUNT)"
echo ""
echo "📝 What's installed:"
echo "   - 14 Superpowers skills (brainstorming, TDD, debugging, etc.)"
echo "   - 3 Iron Laws enforcement rules"
echo "   - 3 workflow scripts (update, setup-project, setup-antigravity)"
echo ""
echo "🚀 Next steps:"
echo "   1. Navigate to your project directory"
echo "   2. Run: bash ~/.claude/global-config/workflows/setup-antigravity-project.sh"
echo "   3. Start Antigravity - skills will auto-load"
echo ""
echo "📚 Available workflows:"
echo "   - Update skills: bash ~/.claude/global-config/workflows/update-superpowers.sh"
echo "   - Setup Claude Code project: bash ~/.claude/global-config/workflows/setup-project.sh"
echo "   - Setup Antigravity project: bash ~/.claude/global-config/workflows/setup-antigravity-project.sh"
echo ""
echo "✅ Done!"
