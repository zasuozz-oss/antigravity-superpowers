#!/usr/bin/env python3
"""
Script tự động migrate từ .agent folder sang .claude folder (Claude Code format)

Usage:
    python migrate_to_claude.py
"""

import os
import shutil
import re
from pathlib import Path

# Paths
AGENT_DIR = Path(".agent")
CLAUDE_DIR = Path(".claude")

def ensure_claude_structure():
    """Tạo cấu trúc thư mục .claude/"""
    (CLAUDE_DIR / "rules").mkdir(parents=True, exist_ok=True)
    (CLAUDE_DIR / "skills").mkdir(parents=True, exist_ok=True)
    print("✅ Created .claude folder structure")

def migrate_rules():
    """Migrate rules từ .agent/rules sang .claude/rules"""
    print("\n📋 Migrating Rules...")

    rules_src = AGENT_DIR / "rules"
    rules_dst = CLAUDE_DIR / "rules"

    if not rules_src.exists():
        print("⚠️  No rules found")
        return

    count = 0
    for rule_file in rules_src.glob("*.md"):
        # Copy trực tiếp (format giống nhau)
        dst_file = rules_dst / rule_file.name
        shutil.copy2(rule_file, dst_file)
        print(f"  ✓ {rule_file.name}")
        count += 1

    print(f"✅ Migrated {count} rules")

def convert_workflow_to_skill(workflow_path: Path) -> dict:
    """
    Convert workflow file sang skill format của Claude Code

    Workflow format (.agent):
    ---
    description: Some description
    ---
    # Content

    Skill format (.claude):
    ---
    name: Workflow Name
    description: Some description
    trigger: /workflow-name
    ---
    # Content
    """
    content = workflow_path.read_text(encoding='utf-8')

    # Parse frontmatter
    frontmatter_match = re.match(r'^---\n(.*?)\n---\n(.*)$', content, re.DOTALL)

    if frontmatter_match:
        frontmatter = frontmatter_match.group(1)
        body = frontmatter_match.group(2)

        # Extract description
        desc_match = re.search(r'description:\s*(.+)', frontmatter)
        description = desc_match.group(1).strip() if desc_match else ""

        # Generate skill name and trigger
        skill_name = workflow_path.stem.replace('-', ' ').replace('_', ' ').title()
        trigger = f"/{workflow_path.stem}"

        # Create new frontmatter for Claude skill
        new_frontmatter = f"""---
name: {skill_name}
description: {description}
trigger: {trigger}
---"""

        return {
            'name': skill_name,
            'trigger': trigger,
            'description': description,
            'content': new_frontmatter + '\n' + body
        }
    else:
        # No frontmatter, create one
        skill_name = workflow_path.stem.replace('-', ' ').replace('_', ' ').title()
        trigger = f"/{workflow_path.stem}"

        new_frontmatter = f"""---
name: {skill_name}
description: {skill_name} workflow
trigger: {trigger}
---"""

        return {
            'name': skill_name,
            'trigger': trigger,
            'description': f"{skill_name} workflow",
            'content': new_frontmatter + '\n' + content
        }

def migrate_workflows():
    """
    Migrate workflows từ .agent/workflows sang .claude/skills

    Trong Claude Code, workflows được implement như skills với trigger
    """
    print("\n⚡ Migrating Workflows as Skills...")

    workflows_src = AGENT_DIR / "workflows"
    skills_dst = CLAUDE_DIR / "skills"

    if not workflows_src.exists():
        print("⚠️  No workflows found")
        return

    count = 0
    for workflow_file in workflows_src.glob("*.md"):
        skill_data = convert_workflow_to_skill(workflow_file)

        # Create skill folder (mỗi skill trong 1 folder riêng)
        skill_folder = skills_dst / workflow_file.stem
        skill_folder.mkdir(exist_ok=True)

        # Write SKILL.md
        skill_file = skill_folder / "SKILL.md"
        skill_file.write_text(skill_data['content'], encoding='utf-8')

        print(f"  ✓ {workflow_file.stem} → {skill_data['trigger']}")
        count += 1

    print(f"✅ Migrated {count} workflows as skills")

def migrate_skills():
    """
    Migrate skills từ .agent/skills sang .claude/skills

    Skills trong .agent đã có format tương tự Claude Code
    """
    print("\n🎯 Migrating Skills...")

    skills_src = AGENT_DIR / "skills"
    skills_dst = CLAUDE_DIR / "skills"

    if not skills_src.exists():
        print("⚠️  No skills found")
        return

    count = 0

    # Migrate from skills/all/
    all_skills_dir = skills_src / "all"
    if all_skills_dir.exists():
        for skill_dir in all_skills_dir.iterdir():
            if skill_dir.is_dir():
                # Copy entire skill folder
                dst_skill_dir = skills_dst / skill_dir.name

                # Skip nếu đã tồn tại (ưu tiên workflows đã migrate)
                if dst_skill_dir.exists():
                    continue

                shutil.copytree(skill_dir, dst_skill_dir, dirs_exist_ok=True)
                print(f"  ✓ {skill_dir.name}")
                count += 1

    # Migrate from skills/my-skills/
    my_skills_dir = skills_src / "my-skills"
    if my_skills_dir.exists():
        for skill_dir in my_skills_dir.iterdir():
            if skill_dir.is_dir():
                dst_skill_dir = skills_dst / f"my-{skill_dir.name}"

                if dst_skill_dir.exists():
                    continue

                shutil.copytree(skill_dir, dst_skill_dir, dirs_exist_ok=True)
                print(f"  ✓ my-{skill_dir.name}")
                count += 1

    print(f"✅ Migrated {count} skills")

def create_claude_md():
    """Tạo CLAUDE.md (project memory) từ rules"""
    print("\n📝 Creating CLAUDE.md...")

    # Read main rules
    main_rules = AGENT_DIR / "rules" / "00-ai-rules.md"
    output_formats = AGENT_DIR / "rules" / "ai-output-formats.md"

    claude_md_content = """# Unity Mobile Game Development

Đây là dự án Unity Mobile Game với AI assistance setup đầy đủ.

## Project Rules

Rules chi tiết được lưu trong `.claude/rules/`:
- `00-ai-rules.md` - Quy tắc chính
- `ai-output-formats.md` - Output formats

## Available Skills

Xem danh sách skills: `/skills`

## Workflows

Các workflows phổ biến đã được convert thành skills:
- `/review` - Code review
- `/debug` - Debug workflow
- `/create` - Tạo prefab/UI/scene
- `/add` - Add feature
- `/test` - Testing workflow
- `/fix` - Fix issues
- `/refactor` - Refactor code
- `/optimize` - Performance optimization
- `/analyze` - Code analysis
- `/search` - Search codebase

## Usage

```bash
# Review code
claude /review path/to/file.cs

# Debug issue
claude /debug "bug description"

# Create UI from layout
claude /create

# Run tests
claude /test
```

---

**Note**: File này được tạo tự động từ migration script.
Để cập nhật, chỉnh sửa các file trong `.claude/rules/` và `.claude/skills/`.
"""

    claude_md_file = CLAUDE_DIR / ".." / "CLAUDE.md"
    claude_md_file.write_text(claude_md_content, encoding='utf-8')
    print("✅ Created CLAUDE.md")

def generate_summary():
    """Tạo summary report"""
    print("\n" + "="*60)
    print("📊 MIGRATION SUMMARY")
    print("="*60)

    # Count files
    rules_count = len(list((CLAUDE_DIR / "rules").glob("*.md"))) if (CLAUDE_DIR / "rules").exists() else 0
    skills_count = len(list((CLAUDE_DIR / "skills").iterdir())) if (CLAUDE_DIR / "skills").exists() else 0

    print(f"""
✅ Migration completed successfully!

📁 Structure:
  .claude/
  ├── rules/          ({rules_count} files)
  └── skills/         ({skills_count} skills)

📄 Files created:
  - CLAUDE.md (project memory)

🎯 Next steps:
  1. Review migrated content in .claude/
  2. Test skills: claude /skills
  3. Try a workflow: claude /review <file>
  4. Customize CLAUDE.md if needed

📚 Documentation:
  - Rules: .claude/rules/
  - Skills: .claude/skills/
  - Project memory: CLAUDE.md
""")

def main():
    """Main migration function"""
    print("🚀 Starting migration from .agent to .claude format...")
    print("="*60)

    if not AGENT_DIR.exists():
        print("❌ Error: .agent folder not found!")
        return

    # Backup warning
    if CLAUDE_DIR.exists():
        response = input("⚠️  .claude folder already exists. Overwrite? (y/N): ")
        if response.lower() != 'y':
            print("❌ Migration cancelled")
            return

    # Run migration steps
    ensure_claude_structure()
    migrate_rules()
    migrate_workflows()  # Workflows → Skills
    migrate_skills()     # Skills → Skills
    create_claude_md()

    # Summary
    generate_summary()
    print("\n✨ Migration completed!")

if __name__ == "__main__":
    main()
