#!/bin/bash
# Auto-setup script for new Antigravity projects
# Creates GEMINI.md with reference to global Superpowers skills
# Usage: bash ~/.gemini/antigravity/scripts/setup-antigravity-project.sh

set -e

PROJECT_DIR=$(pwd)
GEMINI_MD="$PROJECT_DIR/GEMINI.md"

BLOCK_START="<!-- BEGIN antigravity-superpowers -->"
BLOCK_END="<!-- END antigravity-superpowers -->"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Superpowers Antigravity Project Setup                 ║"
echo "║     Configure project to use global skills                 ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if GEMINI.md already exists
if [ -f "$GEMINI_MD" ]; then
    echo "⚠️  GEMINI.md already exists in this project"
    echo ""
    read -p "Overwrite? (yes/no): " confirm
    if [ "$confirm" != "yes" ]; then
        echo "❌ Setup cancelled"
        exit 0
    fi
fi

# Create GEMINI.md
echo "📝 Creating GEMINI.md..."
cat > "$GEMINI_MD" << 'EOF'
@~/.gemini/antigravity/skills/using-superpowers/SKILL.md
@~/.gemini/antigravity/skills/using-superpowers/references/gemini-tools.md

<!-- BEGIN antigravity-superpowers -->
<!-- END antigravity-superpowers -->
EOF

echo "   ✓ GEMINI.md created"
echo ""

# Verify
echo "✅ Verification..."
if [ -f "$GEMINI_MD" ]; then
    echo "   ✓ GEMINI.md exists"
    echo "   Content preview:"
    head -5 "$GEMINI_MD" | sed 's/^/     /'
else
    echo "   ❌ GEMINI.md not found"
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
echo "   - GEMINI.md: ✓ Created"
echo "   - Global skills: ✓ Linked"
echo ""
echo "🚀 Next steps:"
echo "   1. Start Antigravity in this directory"
echo "   2. Skills will auto-load via GEMINI.md"
echo "   3. Begin working — skills trigger automatically"
echo ""
echo "✅ Done!"
