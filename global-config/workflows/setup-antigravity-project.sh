#!/bin/bash
# Auto-setup script for new Antigravity projects
# Creates GEMINI.md with reference to global Superpowers skills
# Usage: bash ~/.claude/global-config/workflows/setup-antigravity-project.sh

set -e

PROJECT_DIR=$(pwd)
GEMINI_MD="$PROJECT_DIR/GEMINI.md"

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
@~/.claude/global-config/skills/using-superpowers/SKILL.md
@~/.claude/global-config/skills/using-superpowers/references/gemini-tools.md

# CRITICAL RULES - MUST FOLLOW

## Skill Usage Rules (MANDATORY)

### Rule 1: Check Skills BEFORE Any Response

**BEFORE responding to ANY user message, you MUST:**

1. **Analyze the request** - What is the user asking for?
2. **Check if ANY skill applies** - Even 1% chance means invoke
3. **Invoke the skill FIRST** - Use view_file on ~/.claude/global-config/skills/<skill-name>/SKILL.md
4. **Follow skill exactly** - No shortcuts, no adaptations
5. **THEN respond** - After following skill instructions

**This applies to:**
- ✅ Feature requests ("Add X")
- ✅ Bug reports ("Fix Y")
- ✅ Questions ("How do I Z?")
- ✅ Modifications ("Change A to B")
- ✅ ANY request that involves action

### Rule 2: Skill Priority Map (MANDATORY)

**You MUST invoke these skills for these situations:**

| User Request Type | MUST Invoke Skill | No Exceptions |
|-------------------|-------------------|---------------|
| "Add feature X" | `brainstorming` | ✅ REQUIRED |
| "Build Y" | `brainstorming` | ✅ REQUIRED |
| "Create Z" | `brainstorming` | ✅ REQUIRED |
| "Implement A" | `brainstorming` → `test-driven-development` | ✅ REQUIRED |
| "Fix bug B" | `systematic-debugging` | ✅ REQUIRED |
| "Tests failing" | `systematic-debugging` | ✅ REQUIRED |
| "Error in C" | `systematic-debugging` | ✅ REQUIRED |
| About to claim "done" | `verification-before-completion` | ✅ REQUIRED |
| About to commit | `verification-before-completion` | ✅ REQUIRED |
| Starting feature work | `using-git-worktrees` | ✅ REQUIRED |

### Rule 3: Red Flags - STOP and Invoke Skill

**If you think ANY of these, STOP and invoke skill:**

❌ "This is just a simple question"
❌ "I need more context first"
❌ "Let me explore the codebase first"
❌ "I'll just do this one thing first"
❌ "This doesn't need a formal skill"
❌ "I remember this skill"
❌ "This is too simple for a skill"
❌ "I can check git/files quickly"

**Reality:** These are rationalizations. Invoke the skill.

### Rule 4: The Iron Law

```
NO RESPONSE WITHOUT SKILL CHECK
NO ACTION WITHOUT SKILL INVOCATION
NO EXCEPTIONS
```

**Enforcement:**
- If you respond without checking skills → VIOLATION
- If you skip skill when one applies → VIOLATION
- If you rationalize not using skill → VIOLATION

### Rule 5: Skill Invocation Format

**Correct way to invoke skills in Antigravity:**

```python
# Use view_file to activate skill
view_file("~/.claude/global-config/skills/brainstorming/SKILL.md")
view_file("~/.claude/global-config/skills/test-driven-development/SKILL.md")
view_file("~/.claude/global-config/skills/systematic-debugging/SKILL.md")
```

**After invoking:**
1. Read the skill content completely
2. Follow instructions exactly
3. Do NOT adapt or skip steps
4. Do NOT rationalize shortcuts

---

## 3 Iron Laws (NEVER VIOLATE)

### Law 1: Brainstorming Before Implementation
```
❌ NEVER: Start coding without approved design
✅ ALWAYS: Invoke brainstorming → Design → Approval → Code
```

### Law 2: Test-Driven Development
```
❌ NEVER: Write production code without failing test first
✅ ALWAYS: Test (fail) → Code → Test (pass)
```

### Law 3: Root Cause Before Fixes
```
❌ NEVER: Fix bugs without root cause investigation
✅ ALWAYS: Bug → Investigate → Root Cause → Fix
```

---

**This is not optional. This is mandatory. No exceptions.**
EOF

echo "   ✓ GEMINI.md created"
echo ""

# Verify
echo "✅ Verification..."
if [ -f "$GEMINI_MD" ]; then
    echo "   ✓ GEMINI.md exists"
    echo "   Content preview:"
    head -10 "$GEMINI_MD" | sed 's/^/     /'
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
echo "📝 What's configured:"
echo "   - 14 Superpowers skills (global)"
echo "   - 3 Iron Laws enforcement"
echo "   - Mandatory workflows"
echo ""
echo "🚀 Next steps:"
echo "   1. Start Antigravity in this directory"
echo "   2. Skills will auto-load via GEMINI.md"
echo "   3. Begin working - brainstorming will trigger automatically"
echo ""
echo "✅ Done!"
