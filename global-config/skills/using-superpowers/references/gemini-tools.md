# Antigravity Tool Mapping

Skills use Claude Code tool names. When you encounter these in a skill, use your Antigravity equivalent:

| Skill references | Antigravity equivalent |
|-----------------|----------------------|
| `Read` (file reading) | `view_file` |
| `Write` (file creation) | `write_to_file` |
| `Edit` (file editing) | `replace_file_content` / `multi_replace_file_content` |
| `Bash` (run commands) | `run_command` |
| `Grep` (search file content) | `grep_search` |
| `Glob` (search files by name) | `find_by_name` |
| `TodoWrite` (task tracking) | Write to `task.md` artifact in brain directory |
| `Skill` tool (invoke a skill) | `view_file` on the skill's `SKILL.md` file |
| `WebSearch` | `search_web` |
| `WebFetch` | `read_url_content` |
| `Task` tool (dispatch subagent) | No general coding subagent — use `browser_subagent` for web tasks only |

## Subagent Limitations

Antigravity does NOT have Claude Code's `Task` tool for dispatching coding subagents. Skills that rely on subagent dispatch (`subagent-driven-development`, `dispatching-parallel-agents`) will fall back to single-session execution via `executing-plans`.

`browser_subagent` is available but ONLY for browser interactions (click, scroll, type, read DOM, screenshot, record video). It cannot execute code tasks.

## Antigravity-Specific Tools

| Tool | Purpose |
|------|---------|
| `list_dir` | List files and subdirectories |
| `task_boundary` | Structured task progress UI with modes: PLANNING, EXECUTION, VERIFICATION |
| `notify_user` | Only way to communicate with user during active task mode |
| `generate_image` | Generate images from text prompts |
| `browser_subagent` | Specialized web browser automation model |
| `view_content_chunk` | Read URL content chunks (for SPA pages) |
| `read_terminal` | Read terminal output by process ID |
| `send_command_input` | Send stdin to running commands |

## Agent Modes

Antigravity operates in two main modes:
- **Planning Mode**: For complex tasks — uses Task Groups, generates Artifacts, deep research
- **Fast Mode**: For direct execution — simple tasks, quick responses

Use `task_boundary` with Mode = PLANNING/EXECUTION/VERIFICATION to signal current phase.

## Skill Storage Locations

Skills in Antigravity are stored in:
- **Workspace**: `<project-root>/.agents/skills/<skill-folder>/SKILL.md`
- **Global**: `~/.gemini/antigravity/skills/<skill-folder>/SKILL.md`

## Workflow Activation

Antigravity workflows are markdown files activated via `/workflow-name` syntax.
Store workflows in `.agents/workflows/` directory.

## Rules System

Antigravity supports rules at two levels:
- **Global rules**: Applied across all workspaces
- **Workspace rules**: Applied per-project
- Rules support `@filename` syntax to reference other files

## Task Management Mapping

Claude Code uses `TodoWrite` for task tracking. In Antigravity:
- Use `task_boundary` tool for task progress UI
- Write checklists to `task.md` artifact with `[ ]` / `[/]` / `[x]` syntax
- Use `notify_user` to communicate results and request reviews
