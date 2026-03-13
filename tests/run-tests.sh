#!/bin/bash
# Automated test runner for Antigravity Superpowers setup
# Usage: bash tests/run-tests.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PASS=0
FAIL=0
TOTAL=0

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

assert() {
    TOTAL=$((TOTAL + 1))
    local desc="$1"
    local cmd="$2"
    if eval "$cmd" > /dev/null 2>&1; then
        echo -e "  ${GREEN}✓${NC} $desc"
        PASS=$((PASS + 1))
    else
        echo -e "  ${RED}✗${NC} $desc"
        FAIL=$((FAIL + 1))
    fi
}

# Use a temp HOME to avoid messing with real config
export TEST_HOME=$(mktemp -d)
export REAL_HOME="$HOME"
export HOME="$TEST_HOME"

cleanup() {
    export HOME="$REAL_HOME"
    rm -rf "$TEST_HOME"
}
trap cleanup EXIT

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     Antigravity Superpowers — Test Suite                   ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# ─── TC-01: Fresh Install ───────────────────────────────────
echo -e "${YELLOW}TC-01: Fresh Install${NC}"
bash "$SCRIPT_DIR/setup-global.sh" > /dev/null 2>&1

assert "Skills directory exists" "[ -d '$HOME/.gemini/antigravity/skills' ]"
assert "Scripts directory exists" "[ -d '$HOME/.gemini/antigravity/scripts' ]"
assert "gemini_rule.md installed" "[ -f '$HOME/.gemini/antigravity/gemini_rule.md' ]"
assert "GEMINI.md exists" "[ -f '$HOME/.gemini/GEMINI.md' ]"
SKILL_COUNT=$(ls -1 "$HOME/.gemini/antigravity/skills" | wc -l | tr -d ' ')
assert "14 skills installed ($SKILL_COUNT found)" "[ $SKILL_COUNT -eq 14 ]"
SCRIPT_COUNT=$(ls -1 "$HOME/.gemini/antigravity/scripts" | wc -l | tr -d ' ')
assert "Scripts installed ($SCRIPT_COUNT found)" "[ $SCRIPT_COUNT -ge 1 ]"
echo ""

# ─── TC-02: Idempotent (No Duplication) ─────────────────────
echo -e "${YELLOW}TC-02: Idempotent — No Duplication${NC}"
LINES_BEFORE=$(wc -l < "$HOME/.gemini/GEMINI.md")
MD5_BEFORE=$(md5 -q "$HOME/.gemini/GEMINI.md")

bash "$SCRIPT_DIR/setup-global.sh" > /dev/null 2>&1

LINES_AFTER=$(wc -l < "$HOME/.gemini/GEMINI.md")
MD5_AFTER=$(md5 -q "$HOME/.gemini/GEMINI.md")

assert "Line count unchanged ($LINES_BEFORE → $LINES_AFTER)" "[ '$LINES_BEFORE' = '$LINES_AFTER' ]"
assert "MD5 unchanged" "[ '$MD5_BEFORE' = '$MD5_AFTER' ]"

# Third run
bash "$SCRIPT_DIR/setup-global.sh" > /dev/null 2>&1
MD5_THIRD=$(md5 -q "$HOME/.gemini/GEMINI.md")
assert "MD5 unchanged after 3rd run" "[ '$MD5_BEFORE' = '$MD5_THIRD' ]"
echo ""

# ─── TC-03: Backup Created ──────────────────────────────────
echo -e "${YELLOW}TC-03: Backup Created${NC}"
BACKUP_COUNT=$(ls -1d "$HOME/.gemini/antigravity-backup-"* 2>/dev/null | wc -l | tr -d ' ')
assert "Backup directories exist ($BACKUP_COUNT)" "[ $BACKUP_COUNT -ge 1 ]"
assert "Backup contains skills/" "ls '$HOME/.gemini/antigravity-backup-'*/skills/ > /dev/null 2>&1"
echo ""

# ─── TC-04: GEMINI.md Content ────────────────────────────────
echo -e "${YELLOW}TC-04: GEMINI.md Content Correctness${NC}"
GEMINI_FILE="$HOME/.gemini/GEMINI.md"

assert "Contains 'Mandatory Skills Usage'" "grep -q 'Mandatory Skills Usage' '$GEMINI_FILE'"
assert "Contains 'FIRST ACTION IN EVERY CONVERSATION'" "grep -q 'FIRST ACTION IN EVERY CONVERSATION' '$GEMINI_FILE'"
assert "Contains view_file instructions" "grep -q 'view_file' '$GEMINI_FILE'"
assert "Contains 'Critical Rule'" "grep -q 'Critical Rule' '$GEMINI_FILE'"
assert "Contains 'Iron Laws'" "grep -q 'Iron Laws' '$GEMINI_FILE'"
assert "Contains skill trigger table" "grep -q 'brainstorming' '$GEMINI_FILE'"
assert "No @skill references" "! grep -q '@~/.gemini/antigravity/skills/' '$GEMINI_FILE'"
echo ""

# ─── TC-05: Legacy Cleanup ──────────────────────────────────
echo -e "${YELLOW}TC-05: Legacy Cleanup${NC}"
mkdir -p "$HOME/.gemini/antigravity/rules"
mkdir -p "$HOME/.gemini/antigravity/global_workflows"
echo "old" > "$HOME/.gemini/antigravity/rules/test.md"
echo "old" > "$HOME/.gemini/antigravity/global_workflows/test.md"

bash "$SCRIPT_DIR/setup-global.sh" > /dev/null 2>&1

assert "rules/ deleted" "[ ! -d '$HOME/.gemini/antigravity/rules' ]"
assert "global_workflows/ deleted" "[ ! -d '$HOME/.gemini/antigravity/global_workflows' ]"
echo ""

# ─── TC-06: All Skills Have SKILL.md ─────────────────────────
echo -e "${YELLOW}TC-06: All Skills Have SKILL.md${NC}"
MISSING=0
for d in "$HOME/.gemini/antigravity/skills"/*/; do
    SKILL_NAME=$(basename "$d")
    if [ -f "$d/SKILL.md" ]; then
        assert "$SKILL_NAME has SKILL.md" "true"
    else
        assert "$SKILL_NAME has SKILL.md" "false"
        MISSING=$((MISSING + 1))
    fi
done
echo ""

# ─── TC-07: No Project Setup Scripts ─────────────────────────
echo -e "${YELLOW}TC-07: No Project Setup Scripts${NC}"
assert "No setup-antigravity-project.sh in scripts/" "[ ! -f '$HOME/.gemini/antigravity/scripts/setup-antigravity-project.sh' ]"
assert "No setup-project.sh in scripts/" "[ ! -f '$HOME/.gemini/antigravity/scripts/setup-project.sh' ]"
assert "No setup-antigravity-project.sh in repo" "[ ! -f '$SCRIPT_DIR/scripts/setup-antigravity-project.sh' ]"
echo ""

# ─── Summary ─────────────────────────────────────────────────
echo "╔════════════════════════════════════════════════════════════╗"
if [ $FAIL -eq 0 ]; then
    echo -e "║  ${GREEN}All $TOTAL tests passed${NC}                                      ║"
else
    echo -e "║  ${RED}$FAIL/$TOTAL tests failed${NC}                                       ║"
fi
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "  Passed: $PASS / $TOTAL"
echo "  Failed: $FAIL / $TOTAL"
echo ""

[ $FAIL -eq 0 ] && exit 0 || exit 1
