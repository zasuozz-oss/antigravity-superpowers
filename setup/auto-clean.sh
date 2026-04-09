#!/bin/bash
set -e

GLOBAL_DIR="$HOME/.gemini/antigravity"
GEMINI_MD="$HOME/.gemini/GEMINI.md"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Superpowers Auto-Clean for Antigravity                 ║"
echo "║     Removes installed global skills and workflows          ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "⚠️  This will ONLY remove the contents of the installed skills folder."
read -p "Confirm? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "   Cancelled"
    exit 0
fi

echo ""
echo "🧹 Step 1/1: Removing installed skills..."
if [ -d "$GLOBAL_DIR/skills" ]; then
    rm -rf "$GLOBAL_DIR/skills/"*
    echo "   ✓ Skills removed"
else
    echo "   ✓ No skills folder found"
fi

echo ""
echo "✅ Cleanup Complete!"
