#!/bin/bash
# Auto-setup script for new projects
# Creates CLAUDE.md with reference to global Superpowers skills
# Usage: bash ~/.claude/global-config/workflows/setup-project.sh

set -e

PROJECT_DIR=$(pwd)
CLAUDE_MD="$PROJECT_DIR/CLAUDE.md"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Superpowers Project Setup                              ║"
echo "║     Configure project to use global skills                 ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if CLAUDE.md already exists
if [ -f "$CLAUDE_MD" ]; then
    echo "⚠️  CLAUDE.md already exists in this project"
    echo ""
    read -p "Overwrite? (yes/no): " confirm
    if [ "$confirm" != "yes" ]; then
        echo "❌ Setup cancelled"
        exit 0
    fi
fi

# Create CLAUDE.md
echo "📝 Creating CLAUDE.md..."
cat > "$CLAUDE_MD" << 'EOF'
@~/.claude/global-config/skills/using-superpowers/SKILL.md
EOF

echo "   ✓ CLAUDE.md created"
echo ""

# Verify
echo "✅ Verification..."
if [ -f "$CLAUDE_MD" ]; then
    echo "   ✓ CLAUDE.md exists"
    echo "   Content:"
    cat "$CLAUDE_MD" | sed 's/^/     /'
else
    echo "   ❌ CLAUDE.md not found"
    exit 1
fi
echo ""

# Summary
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Setup Complete                                         ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Summary:"
echo "   - Project: $PROJECT_DIR"
echo "   - CLAUDE.md: ✓ Created"
echo "   - Global skills: ✓ Linked"
echo ""
echo "📝 What's configured:"
echo "   - 14 Superpowers skills (global)"
echo "   - 3 Iron Laws enforcement"
echo "   - Mandatory workflows"
echo ""
echo "🚀 Next steps:"
echo "   1. Start Claude Code in this directory"
echo "   2. Skills will auto-load via CLAUDE.md"
echo "   3. Begin working - brainstorming will trigger automatically"
echo ""
echo "✅ Done!"
