#!/bin/bash
# Update Spec-Kit templates from upstream repository
# Pulls latest templates from github/spec-kit, updates local references,
# and reports any changes to command templates (SKILL.md files)
# Usage: bash ~/.gemini/antigravity/setup/update-speckit.sh

set -e

UPSTREAM_REPO="https://github.com/github/spec-kit.git"
UPSTREAM_BRANCH="main"

# Auto-detect paths
SCRIPT_REAL_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
POTENTIAL_FORK="$(cd "$SCRIPT_REAL_PATH/.." && pwd)"
GLOBAL_DIR="$HOME/.gemini/antigravity"

FORK_REPO_DIR=""
if [ "$POTENTIAL_FORK" != "$GLOBAL_DIR" ] && [ -d "$POTENTIAL_FORK/skills" ]; then
    FORK_REPO_DIR="$POTENTIAL_FORK"
elif [ "$(pwd)" != "$GLOBAL_DIR" ] && [ -d "$(pwd)/skills" ]; then
    FORK_REPO_DIR="$(pwd)"
fi

GLOBAL_SKILLS_DIR="$GLOBAL_DIR/skills"
SPECKIT_UPSTREAM_DIR="$FORK_REPO_DIR/spec-kit-upstream"
CACHE_DIR="$HOME/.gemini/antigravity/.speckit-cache"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Spec-Kit Update Workflow                               ║"
echo "║     Pull upstream → Update templates → Report diffs        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Fetch upstream
echo "🔄 Step 1: Fetching upstream (github/spec-kit)..."
rm -rf "$CACHE_DIR"
git clone --quiet --depth 1 "$UPSTREAM_REPO" "$CACHE_DIR"
echo "   ✓ Cloned"
echo ""

# Step 2: Update spec-kit-upstream reference directory
echo "📦 Step 2: Updating spec-kit-upstream reference..."
if [ -n "$FORK_REPO_DIR" ]; then
    # Update templates
    mkdir -p "$SPECKIT_UPSTREAM_DIR/templates"
    mkdir -p "$SPECKIT_UPSTREAM_DIR/commands"

    TEMPLATE_COUNT=0
    for tpl in constitution-template tasks-template spec-template plan-template checklist-template; do
        SRC="$CACHE_DIR/templates/${tpl}.md"
        if [ -f "$SRC" ]; then
            cp "$SRC" "$SPECKIT_UPSTREAM_DIR/templates/${tpl}.md"
            TEMPLATE_COUNT=$((TEMPLATE_COUNT + 1))
        fi
    done
    echo "   ✓ $TEMPLATE_COUNT templates updated"

    # Update command references
    CMD_COUNT=0
    for cmd in analyze clarify constitution tasks; do
        SRC="$CACHE_DIR/templates/commands/${cmd}.md"
        if [ -f "$SRC" ]; then
            cp "$SRC" "$SPECKIT_UPSTREAM_DIR/commands/${cmd}.md"
            CMD_COUNT=$((CMD_COUNT + 1))
        fi
    done
    echo "   ✓ $CMD_COUNT command references updated"
else
    echo "   ⚠️  Fork repo not found. Skipping upstream reference update."
fi
echo ""

# Step 3: Update skill templates (overwrite directly)
echo "📚 Step 3: Updating skill templates..."
SKILL_TEMPLATE_UPDATED=0

# constitution-template → project-constitution skill
CONST_SRC="$CACHE_DIR/templates/constitution-template.md"
CONST_DST="$GLOBAL_SKILLS_DIR/project-constitution/templates/constitution-template.md"
if [ -f "$CONST_SRC" ] && [ -d "$GLOBAL_SKILLS_DIR/project-constitution/templates" ]; then
    cp "$CONST_SRC" "$CONST_DST"
    SKILL_TEMPLATE_UPDATED=$((SKILL_TEMPLATE_UPDATED + 1))
    echo "   ✓ constitution-template.md → project-constitution"
fi

# tasks-template → task-decomposition skill
TASKS_SRC="$CACHE_DIR/templates/tasks-template.md"
TASKS_DST="$GLOBAL_SKILLS_DIR/task-decomposition/templates/tasks-template.md"
if [ -f "$TASKS_SRC" ] && [ -d "$GLOBAL_SKILLS_DIR/task-decomposition/templates" ]; then
    cp "$TASKS_SRC" "$TASKS_DST"
    SKILL_TEMPLATE_UPDATED=$((SKILL_TEMPLATE_UPDATED + 1))
    echo "   ✓ tasks-template.md → task-decomposition"
fi

echo "   ✓ $SKILL_TEMPLATE_UPDATED skill templates updated"
echo ""

# Step 4: Diff command templates against SKILL.md (report only, NO overwrite)
echo "🔍 Step 4: Checking command template changes (report only)..."
echo ""

SKILL_MAP_CMD="analyze:spec-analyze clarify:spec-clarify constitution:project-constitution tasks:task-decomposition"
HAS_DIFFS=false

for mapping in $SKILL_MAP_CMD; do
    CMD_NAME="${mapping%%:*}"
    SKILL_NAME="${mapping##*:}"
    CMD_SRC="$CACHE_DIR/templates/commands/${CMD_NAME}.md"
    if [ -f "$CMD_SRC" ] && [ -d "$GLOBAL_SKILLS_DIR/$SKILL_NAME" ]; then
        # Compare against stored reference
        REF_FILE="$SPECKIT_UPSTREAM_DIR/commands/${CMD_NAME}.md"
        if [ -f "$REF_FILE" ]; then
            DIFF_OUTPUT=$(diff "$REF_FILE" "$CMD_SRC" 2>/dev/null || true)
            if [ -n "$DIFF_OUTPUT" ]; then
                HAS_DIFFS=true
                echo "   ⚠️  ${CMD_NAME}.md has upstream changes → affects skill: $SKILL_NAME"
                echo "      Review: diff $REF_FILE $CMD_SRC"
            fi
        fi
    fi
done

if [ "$HAS_DIFFS" = false ]; then
    echo "   ✓ No command template changes detected"
fi
echo ""

# Step 5: Sync to fork repo
if [ -n "$FORK_REPO_DIR" ] && [ -d "$FORK_REPO_DIR/skills" ]; then
    echo "🔄 Step 5: Syncing templates to fork repo..."
    
    # Sync skill templates to fork
    for skill_dir in project-constitution task-decomposition; do
        SRC="$GLOBAL_SKILLS_DIR/$skill_dir/templates"
        DST="$FORK_REPO_DIR/skills/$skill_dir/templates"
        if [ -d "$SRC" ] && [ -d "$DST" ]; then
            cp -R "$SRC"/* "$DST/" 2>/dev/null || true
        fi
    done
    
    echo "   ✓ Synced to $FORK_REPO_DIR"
    echo ""
    echo "   📌 Remember to commit changes in the fork repo:"
    echo "   cd $FORK_REPO_DIR"
    echo "   git add -A && git commit -m 'chore: update spec-kit templates from upstream'"
fi

# Cleanup
rm -rf "$CACHE_DIR"

# Summary
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Spec-Kit Update Complete                               ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📊 Summary:"
echo "   - Upstream templates: ✓ Updated ($TEMPLATE_COUNT)"
echo "   - Command references: ✓ Updated ($CMD_COUNT)"
echo "   - Skill templates: ✓ Updated ($SKILL_TEMPLATE_UPDATED)"
if [ "$HAS_DIFFS" = true ]; then
echo "   - Command diffs: ⚠️  Changes detected (review manually)"
else
echo "   - Command diffs: ✓ No changes"
fi
echo ""
echo "✅ Done!"
