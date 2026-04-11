---
name: project-constitution
description: Use when starting a new project or when a project lacks governing principles. Creates or updates a project constitution that defines immutable development principles, constraints, quality gates, and governance rules.
---

# Project Constitution

## Overview

Create and manage a "project constitution" — a set of immutable principles that govern all development decisions for a project.

**Announce at start:** "I'm using the project-constitution skill to establish governing principles for this project."

## When to Use

- Starting a **new project** that doesn't have a `.superpowers/constitution.md`
- **Onboarding a codebase** that needs established principles documented
- **Updating principles** — an existing constitution needs amendments

## The Process

### Step 1: Check Existing Constitution

1. Look for `.superpowers/constitution.md` in the project root
2. If exists: load it, show current principles, ask what to update
3. If not exists: proceed to creation workflow

### Step 2: Scan Project Context

Before asking questions, gather context from:
- `README.md` — project description, purpose, tech stack
- `package.json` / `Cargo.toml` / `pyproject.toml` — dependencies, tooling
- Existing docs — architecture decisions, coding standards
- Codebase structure — language patterns, test frameworks, project organization

Use this context to make informed suggestions for each principle.

### Step 3: Interactive Principle Definition

Ask the user **one question at a time** to define each principle. Maximum 7 principles.

For each principle:
1. **Suggest** a principle name and description based on project context
2. Present as: `**Recommended:** [Principle Name] — [Why this fits your project]`
3. Provide 2-3 alternative options in a table
4. User can accept recommendation, choose an option, or provide their own
5. Move to next principle only after current one is confirmed

**Common principle categories** (suggest based on project type):
- **Modularity** — How code is organized (library-first, microservices, monolithic)
- **Testing Philosophy** — TDD, test-after, coverage requirements
- **Simplicity** — YAGNI, avoid premature abstraction
- **Interface Design** — CLI-first, API-first, UI-first
- **Code Quality** — Review requirements, linting standards
- **Documentation** — What must be documented, where
- **Security** — Authentication patterns, data handling

### Step 4: Define Constraints & Quality Gates

After principles, ask about:
- **Technical Constraints**: Language versions, frameworks, deployment targets
- **Quality Gates**: Required reviews, test coverage thresholds, CI requirements
- **Compliance**: Any regulatory or organizational requirements

### Step 5: Generate Constitution

Create `.superpowers/constitution.md` with this structure:

```markdown
# [Project Name] Constitution

## Core Principles

### I. [Principle Name]
[Description — MUST/SHOULD directives, rationale, enforcement]

### II. [Principle Name]
[Description]

[... up to VII]

## Constraints

[Technical constraints, compliance requirements]

## Quality Gates

[Review process, test coverage, CI requirements]

## Governance

- Constitution supersedes all other practices
- Amendments require: documentation + team approval + migration plan
- Version follows semantic versioning (MAJOR.MINOR.PATCH)

**Version**: 1.0.0 | **Ratified**: [TODAY] | **Last Amended**: [TODAY]
```

### Step 6: Commit

Suggest commit message: `docs: establish project constitution v1.0.0`

## When Updating an Existing Constitution

1. Load current constitution
2. Show current version and principles
3. Ask what changes are needed
4. Apply semantic versioning:
   - **MAJOR**: Remove/redefine a principle (breaking change)
   - **MINOR**: Add new principle or section
   - **PATCH**: Clarify wording, fix typos
5. Update `Last Amended` date
6. Suggest commit message with version

## Output Location

- **Constitution file**: `.superpowers/constitution.md`
- **Must be committed** to version control (not gitignored)

## Integration with Other Skills

- **brainstorming** — Should check constitution before proposing designs
- **writing-plans** — Must validate plan against constitution principles
- **spec-analyze** — Uses constitution for alignment checks (CRITICAL violations)

## Remember

- Ask ONE question at a time
- Always suggest a recommendation with reasoning
- Keep principles declarative and testable (use MUST/SHOULD)
- No vague language ("robust", "scalable" without metrics)
- Constitution is the **source of truth** for project governance
- Never create a constitution without user input — this is collaborative
