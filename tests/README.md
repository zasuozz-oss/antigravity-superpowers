# Tests

Manual test prompts for verifying Superpowers skills work correctly in Antigravity.

## Structure

```
tests/
├── skill-triggering/prompts/     # Prompts that should trigger skills implicitly
└── explicit-skill-requests/prompts/ # Prompts that explicitly request skills
```

## How to Test

These are **manual tests** — paste the prompt into Antigravity and verify the expected behavior.

### Skill Triggering Tests

Test if skills auto-activate based on context (without explicitly naming the skill).

| Prompt File | Should Trigger | Expected Behavior |
|-------------|---------------|-------------------|
| `systematic-debugging.txt` | systematic-debugging | Agent invokes debugging skill, investigates root cause before fixing |
| `test-driven-development.txt` | test-driven-development | Agent writes failing test first, then implements |
| `writing-plans.txt` | writing-plans | Agent creates structured implementation plan |
| `executing-plans.txt` | executing-plans | Agent follows plan step by step with task tracking |
| `requesting-code-review.txt` | requesting-code-review | Agent requests review with structured feedback |
| `dispatching-parallel-agents.txt` | dispatching-parallel-agents | Agent identifies parallelizable tasks |

### Explicit Skill Request Tests

Test if skills activate when the user explicitly names them.

| Prompt File | Should Trigger | Expected Behavior |
|-------------|---------------|-------------------|
| `please-use-brainstorming.txt` | brainstorming | Agent starts brainstorming workflow |
| `use-systematic-debugging.txt` | systematic-debugging | Agent starts debugging workflow |
| `subagent-driven-development-please.txt` | subagent-driven-development | Agent starts SDD workflow |
| `skip-formalities.txt` | brainstorming | Agent uses skill despite casual tone |
| `i-know-what-sdd-means.txt` | subagent-driven-development | Agent understands abbreviation |
| `action-oriented.txt` | brainstorming | Agent uses skill despite action-focused request |
| `after-planning-flow.txt` | executing-plans | Agent transitions to execution |
| `mid-conversation-execute-plan.txt` | executing-plans | Agent picks up plan mid-conversation |
| `claude-suggested-it.txt` | subagent-driven-development | Agent follows its own suggestion |

## Verification Checklist

After pasting a prompt, verify:
- [ ] Correct skill was activated (check `view_file` calls to SKILL.md)
- [ ] Agent followed the skill's workflow steps
- [ ] No premature code writing before design (for brainstorming tests)
- [ ] Root cause investigation before fix (for debugging tests)
