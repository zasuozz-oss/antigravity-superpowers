# Unity Mobile Game Development

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
