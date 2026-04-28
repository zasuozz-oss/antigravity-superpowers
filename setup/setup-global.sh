#!/bin/bash
# Global setup script for Superpowers in Antigravity
# Installs skills and rules to ~/.gemini/antigravity/, ~/.claude/, ~/.codex/
# Usage: bash setup-global.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL_DIR="$HOME/.gemini/antigravity"
CODEX_DIR="$HOME/.codex"
GEMINI_MD="$HOME/.gemini/GEMINI.md"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
CODEX_MD="$HOME/.codex/AGENTS.md"

BEGIN_MARKER="<!-- AG-SUPERPOWERS:BEGIN -->"
END_MARKER="<!-- AG-SUPERPOWERS:END -->"

# ─── upsert_block: replace or append a marker-delimited block in a file ───
# Usage: upsert_block <target_file> <rule_source_file>
# Preserves all content outside the AG-SUPERPOWERS markers.
upsert_block() {
    local target_file="$1"
    local rule_file="$2"

    [ -f "$rule_file" ] || return 1

    mkdir -p "$(dirname "$target_file")"
    local block_content
    block_content=$(cat "$rule_file")

    if [ -f "$target_file" ] && grep -qF "$BEGIN_MARKER" "$target_file"; then
        # Replace existing block in-place
        python3 -c "
import sys
with open(sys.argv[1], 'r') as f:
    content = f.read()
begin = sys.argv[2]
end = sys.argv[3]
block = sys.argv[4]
start_idx = content.find(begin)
end_idx = content.find(end)
if start_idx != -1 and end_idx != -1:
    end_idx += len(end)
    content = content[:start_idx] + block + content[end_idx:]
with open(sys.argv[1], 'w') as f:
    f.write(content)
" "$target_file" "$BEGIN_MARKER" "$END_MARKER" "$block_content"
        echo "   ✓ Updated block in: $target_file (user content preserved)"
    elif [ -f "$target_file" ] && [ -s "$target_file" ]; then
        # File exists with content but no markers — append
        printf "\n%s\n" "$block_content" >> "$target_file"
        echo "   ✓ Appended block to: $target_file (existing content preserved)"
    else
        # No file or empty — write fresh
        echo "$block_content" > "$target_file"
        echo "   ✓ Created: $target_file"
    fi
}


echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Superpowers Global Setup                               ║"
echo "║     Install skills & rules globally                        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if source directories exist
if [ ! -d "$SCRIPT_DIR/../skills" ]; then
    echo "❌ Error: skills/ not found"
    echo "   Make sure you're running this from the repository root"
    exit 1
fi

# Step 1: Create directories & check permissions
echo "📁 Step 1/7: Creating config directories..."
mkdir -p "$GLOBAL_DIR" "$CODEX_DIR" "$(dirname "$GEMINI_MD")" "$(dirname "$CLAUDE_MD")"

PERM_ERRORS=""
for dir in "$GLOBAL_DIR" "$CODEX_DIR" "$(dirname "$GEMINI_MD")" "$(dirname "$CLAUDE_MD")"; do
    if [ ! -w "$dir" ]; then
        PERM_ERRORS="$PERM_ERRORS
      sudo chown -R $(whoami) $dir"
    fi
done

if [ -n "$PERM_ERRORS" ]; then
    echo "   ❌ Permission denied on some directories."
    echo "   Run these commands first, then re-run setup:"
    echo "$PERM_ERRORS"
    echo ""
    exit 1
fi
echo "   ✓ All directories ready"
echo ""

# Step 2: Check for duplicate skill names
echo "🔍 Step 2/7: Checking for duplicate skills..."
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
echo "📚 Step 3/7: Installing skills..."
if command -v rsync >/dev/null 2>&1; then
    rsync -av --exclude-from="$SCRIPT_DIR/ignore-skills.txt" "$SCRIPT_DIR/../skills/" "$GLOBAL_DIR/skills/"
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
echo "   ✓ $SKILL_COUNT skills installed to $GLOBAL_DIR/skills"

# Mirror skills into ~/.codex/skills/ so Codex can read them via its own path
mkdir -p "$CODEX_DIR/skills"
if command -v rsync >/dev/null 2>&1; then
    rsync -a --exclude-from="$SCRIPT_DIR/ignore-skills.txt" "$SCRIPT_DIR/../skills/" "$CODEX_DIR/skills/"
else
    for skill_path in "$SCRIPT_DIR/../skills"/*; do
        [ -e "$skill_path" ] || continue
        skill_name=$(basename "$skill_path")
        if ! grep -qE "^${skill_name}/?(\r)?$" "$SCRIPT_DIR/ignore-skills.txt" 2>/dev/null; then
            cp -R "$skill_path" "$CODEX_DIR/skills/"
        fi
    done
fi
CODEX_SKILL_COUNT=$(ls -1 "$CODEX_DIR/skills" | wc -l | tr -d ' ')
echo "   ✓ $CODEX_SKILL_COUNT skills mirrored to $CODEX_DIR/skills"

echo ""

# Step 4: Install scripts
echo "⚙️  Step 4/7: Installing setup scripts..."
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

# Step 5: Update GEMINI.md (Antigravity)
echo "📝 Step 5/7: Updating Antigravity rules (~/.gemini/GEMINI.md)..."
upsert_block "$GEMINI_MD" "$SCRIPT_DIR/gemini_rule.md"
echo ""

# Step 6: Update CLAUDE.md (Claude Desktop)
echo "📝 Step 6/7: Updating Claude Desktop rules (~/.claude/CLAUDE.md)..."
upsert_block "$CLAUDE_MD" "$SCRIPT_DIR/claude_rule.md"
echo ""

# Step 7: Update AGENTS.md (Codex)
echo "📝 Step 7/7: Updating Codex rules (~/.codex/AGENTS.md)..."
upsert_block "$CODEX_MD" "$SCRIPT_DIR/codex_rule.md"
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
echo "   Skills:        $(ls -1 "$GLOBAL_DIR/skills" | wc -l | tr -d ' ')"
echo "   Setup Scripts: $(ls -1 "$GLOBAL_DIR/setup" | wc -l | tr -d ' ')"
echo "   GEMINI.md:     $([ -f "$GEMINI_MD" ] && echo '✓' || echo '✗')"
echo "   CLAUDE.md:     $([ -f "$CLAUDE_MD" ] && echo '✓' || echo '✗')"
echo "   AGENTS.md:     $([ -f "$CODEX_MD" ] && echo '✓' || echo '✗')"
echo ""

# Summary
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Installation Complete                                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "🚀 Next steps:"
echo "   1. Restart Antigravity / Claude Desktop / Codex"
echo "   2. Rules auto-load from global instruction files"
echo ""
echo "✅ Done!"
