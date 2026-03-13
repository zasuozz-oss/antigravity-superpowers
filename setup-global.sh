#!/bin/bash
# Global setup script for Superpowers in Antigravity
# Installs skills, rules, and workflows to ~/.gemini/antigravity/
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
echo "║     Install skills, rules, and workflows globally          ║"
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
if [ -d "$GLOBAL_DIR/skills" ] || [ -d "$GLOBAL_DIR/rules" ] || [ -d "$GLOBAL_DIR/scripts" ]; then
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
echo ""

# Step 4: Install rules
echo "📋 Step 4: Installing rules..."
rm -rf "$GLOBAL_DIR/rules"
cp -r "$SCRIPT_DIR/global-config/rules" "$GLOBAL_DIR/rules"
RULE_COUNT=$(ls -1 "$GLOBAL_DIR/rules" | wc -l | tr -d ' ')
echo "   ✓ $RULE_COUNT rules installed"
echo ""

# Step 5: Install scripts
echo "⚙️  Step 5: Installing scripts..."
rm -rf "$GLOBAL_DIR/scripts"
cp -r "$SCRIPT_DIR/scripts" "$GLOBAL_DIR/scripts"
chmod +x "$GLOBAL_DIR/scripts"/*.sh
SCRIPT_COUNT=$(ls -1 "$GLOBAL_DIR/scripts" | wc -l | tr -d ' ')
echo "   ✓ $SCRIPT_COUNT scripts installed"
echo ""

# Step 6: Install workflows
echo "📝 Step 6: Installing workflows..."
rm -rf "$GLOBAL_DIR/global_workflows"
cp -r "$SCRIPT_DIR/global-config/workflows" "$GLOBAL_DIR/global_workflows"
WORKFLOW_COUNT=$(ls -1 "$GLOBAL_DIR/global_workflows" | wc -l | tr -d ' ')
echo "   ✓ $WORKFLOW_COUNT workflows installed"
echo ""

# Step 7: Language selection
echo "🌐 Step 7: Select default language"
echo ""
echo "   1.  English (default)"
echo "   2.  Tiếng Việt (Vietnamese)"
echo "   3.  日本語 (Japanese)"
echo "   4.  中文 (Chinese)"
echo "   5.  한국어 (Korean)"
echo "   6.  Español (Spanish)"
echo "   7.  Français (French)"
echo "   8.  Deutsch (German)"
echo "   9.  Português (Portuguese)"
echo "   10. Русский (Russian)"
echo "   11. हिन्दी (Hindi)"
echo "   12. العربية (Arabic)"
echo "   13. Bahasa Indonesia"
echo "   14. ภาษาไทย (Thai)"
echo "   15. Türkçe (Turkish)"
echo "   16. Italiano (Italian)"
echo "   17. Polski (Polish)"
echo "   18. Nederlands (Dutch)"
echo "   19. Українська (Ukrainian)"
echo "   20. Filipino/Tagalog"
echo ""
read -p "Choose (1-20) [1]: " lang_choice
lang_choice=${lang_choice:-1}

case $lang_choice in
    2)  DOC_LANG="Vietnamese" ;;
    3)  DOC_LANG="Japanese" ;;
    4)  DOC_LANG="Chinese" ;;
    5)  DOC_LANG="Korean" ;;
    6)  DOC_LANG="Spanish" ;;
    7)  DOC_LANG="French" ;;
    8)  DOC_LANG="German" ;;
    9)  DOC_LANG="Portuguese" ;;
    10) DOC_LANG="Russian" ;;
    11) DOC_LANG="Hindi" ;;
    12) DOC_LANG="Arabic" ;;
    13) DOC_LANG="Indonesian" ;;
    14) DOC_LANG="Thai" ;;
    15) DOC_LANG="Turkish" ;;
    16) DOC_LANG="Italian" ;;
    17) DOC_LANG="Polish" ;;
    18) DOC_LANG="Dutch" ;;
    19) DOC_LANG="Ukrainian" ;;
    20) DOC_LANG="Filipino" ;;
    *)  DOC_LANG="English" ;;
esac

# Generate language convention rule
cat > "$GLOBAL_DIR/rules/03-language-convention.md" << LANGEOF
# LANGUAGE CONVENTION

## Default Language: $DOC_LANG

All output should follow these language rules:

| Content Type | Language |
|-------------|----------|
| Code, variables, functions, classes | English (always) |
| Comments, logs, error messages | English |
| Commit messages, PR descriptions | English |
| Documentation, README, guides | $DOC_LANG |
| User-facing explanations, responses | $DOC_LANG |

## Override Rules

- If the user writes in a specific language, respond in that same language.
- If the user explicitly requests another language, follow the user's request.
- Code identifiers (variables, functions, classes) must ALWAYS be in English regardless of conversation language.
LANGEOF

echo "   ✓ Language: $DOC_LANG"
echo ""

# Step 8: Update GEMINI.md (block-based, non-destructive)
echo "📝 Step 8: Updating global GEMINI.md..."

SUPERPOWERS_BLOCK="$BLOCK_START
@~/.gemini/antigravity/rules/00-mandatory-skills.md
@~/.gemini/antigravity/rules/01-iron-laws.md
@~/.gemini/antigravity/rules/02-workflow-enforcement.md
@~/.gemini/antigravity/rules/03-language-convention.md
$BLOCK_END"

if [ -f "$GEMINI_MD" ]; then
    if grep -q "$BLOCK_START" "$GEMINI_MD" 2>/dev/null; then
        # Replace existing block
        # Use awk to replace content between markers
        awk -v start="$BLOCK_START" -v end="$BLOCK_END" -v block="$SUPERPOWERS_BLOCK" '
            $0 == start { print block; skip=1; next }
            $0 == end { skip=0; next }
            !skip { print }
        ' "$GEMINI_MD" > "$GEMINI_MD.tmp"
        mv "$GEMINI_MD.tmp" "$GEMINI_MD"
        echo "   ✓ Updated existing block in: $GEMINI_MD"
    else
        # Append block to existing file
        echo "" >> "$GEMINI_MD"
        echo "$SUPERPOWERS_BLOCK" >> "$GEMINI_MD"
        echo "   ✓ Appended block to: $GEMINI_MD"
    fi
else
    # Create new file with block
    echo "$SUPERPOWERS_BLOCK" > "$GEMINI_MD"
    echo "   ✓ Created: $GEMINI_MD"
fi
echo ""

# Step 9: Verify
echo "✅ Step 9: Verification..."
echo "   Skills:    $(ls -1 "$GLOBAL_DIR/skills" | wc -l | tr -d ' ')"
echo "   Rules:     $(ls -1 "$GLOBAL_DIR/rules" | wc -l | tr -d ' ')"
echo "   Scripts:   $(ls -1 "$GLOBAL_DIR/scripts" | wc -l | tr -d ' ')"
echo "   Workflows: $(ls -1 "$GLOBAL_DIR/global_workflows" | wc -l | tr -d ' ')"
echo "   Language:  $DOC_LANG"
echo "   GEMINI.md: ✓"
echo ""

# Summary
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Installation Complete                                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "🚀 Next steps:"
echo "   1. cd /path/to/project"
echo "   2. bash ~/.gemini/antigravity/scripts/setup-antigravity-project.sh"
echo "   3. Open Antigravity — skills auto-load"
echo ""
echo "✅ Done!"
