---
description: Brainstorm and explore ideas before implementing. Use when starting a new feature, solving a complex problem, or any creative work.
---

# Brainstorming Workflow

Collaborative design exploration before writing any code.

## When to Use

- Starting a new feature or component
- Solving a complex technical problem
- Modifying existing behavior
- Any creative work that requires design decisions

## Steps

1. **Understand the request**
   - Read the user's message carefully
   - Identify what they want to achieve (not just what they asked for)
   - If unclear, ask **one** clarifying question at a time

2. **Research the codebase**
   - Search for related files, patterns, and dependencies
   - Check existing implementations that might be affected
   - Review recent commits for context
   - Read relevant documentation

3. **Assess scope**
   - If the request involves multiple independent subsystems, flag it immediately
   - Help decompose large projects into sub-projects
   - Each sub-project gets its own design → plan → implementation cycle

4. **Propose approaches**
   - Present 2-3 different approaches with trade-offs
   - Lead with your recommended option and explain why
   - Consider: complexity, maintainability, performance, compatibility

5. **Present the design**
   - Scale detail to complexity (a few sentences for simple changes, detailed sections for complex ones)
   - Ask for approval after each section
   - Cover: architecture, components, data flow, error handling
   - Be ready to revise based on feedback

6. **Get approval**
   - Wait for explicit user approval before proceeding
   - Do NOT write any production code during brainstorming

## Hard Gate

> [!CAUTION]
> Do NOT write any code, scaffold any project, or take any implementation action until the design is presented and approved by the user.

## Next Step

After approval, transition to the `/write-plan` workflow to create a structured implementation plan.
