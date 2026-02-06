# ai-gent

**ai-gent** is a centralized agent system designed to **standardize, control, and scale the use of AI inside Unity projects**.

This repository does **not** contain gameplay code or Unity assets.  
Instead, it acts as an **AI governance layer** that defines how AI is allowed to assist during development — ensuring consistency, safety, and predictable outcomes across all Unity projects.

---

## Why ai-gent exists

As AI becomes deeply integrated into Unity development (code assistance, architecture decisions, asset workflows, tooling, etc.), teams often face these problems:

- AI behaves differently across projects
- Each developer uses AI in their own way
- AI unintentionally changes logic, structure, or conventions
- Rules and guidelines become fragmented or outdated

**ai-gent solves this by acting as a single source of truth for AI behavior in Unity projects.**

---

## What ai-gent is used for

### 1. Standardizing AI behavior in Unity development
ai-gent defines:
- What AI **can** and **cannot** modify
- How AI should reason about Unity architecture
- Constraints around scripts, assets, folders, and naming
- How AI responds to refactor, optimization, and debugging requests

This prevents AI from making unsafe or inconsistent decisions.

---

### 2. Enforcing shared rules across all Unity projects
- Every Unity project uses the same agent rules
- Updates are applied once and propagated everywhere
- Older projects automatically benefit from improved rules

This eliminates rule drift between projects.

---

### 3. Protecting project structure and logic
ai-gent limits AI from:
- Changing gameplay logic without explicit permission
- Breaking folder structures
- Renaming scripts or assets incorrectly
- Modifying systems outside the defined scope

The agent **assists**, but never overrides developer intent.

---

### 4. Improving onboarding and team scalability
New developers or technical artists can:
- Join a project
- Read the agent rules
- Immediately work with AI in a safe, consistent way

No tribal knowledge or repeated explanations required.

---

## Repository structure

ai-gent/
├── .agent/ # Core AI rules for Unity projects
├── .gemini/ # Gemini-specific configurations (optional)
└── README.md

### `.agent`
- Mandatory
- Contains all core AI rules and constraints
- Applies to every Unity project using this system
- Managed via Git and updated regularly

### `.gemini`
- Optional
- AI-provider-specific prompts and configurations
- Designed to be extensible for future AI providers

---

## How ai-gent is used in Unity projects

- ai-gent is cloned or synced into each Unity project
- The project **consumes** the rules but does not own them
- Unity projects remain independent
- AI behavior remains centralized and consistent

This separation allows teams to scale projects without duplicating or diverging AI rules.

---

## Operational principles

- ai-gent is a **shared internal repository**
- Rule changes affect all projects
- Updates should be pulled daily before development
- Changes must be intentional and clearly documented

---

## When should ai-gent be updated?

- When Unity workflows change
- When AI repeatedly produces incorrect or risky output
- When new systems or pipelines are introduced
- When expanding AI usage to new areas (animation, tools, build systems)

---

## Design philosophy

> **ai-gent does not aim to make AI smarter.**  
> **It aims to make AI predictable, safe, and aligned with Unity production rules.**

The system ensures:
- AI understands project context
- Developers stay in control
- Pipelines remain stable as projects scale

---

## Intended audience

- Unity developers
- Game engineers
- Technical artists
- Tooling engineers
- Team leads and pipeline owners

---

## Important notes

- ai-gent is intended for **internal studio use**
- It is not a gameplay framework
- It is not tied to a single Unity project
- It exists to support long-term production scalability

---
