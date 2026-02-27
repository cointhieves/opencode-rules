## Plan Persistence

**CRITICAL RULE**: You MUST save plans to a file BEFORE executing any steps. Chat history is temporary and can be lost at any time — plans must survive session loss. This is a BLOCKING requirement, not a suggestion.

### Mandatory Process

1. **STOP** — Before implementing anything, write the plan to a file FIRST
2. **SAVE** — Use the Write tool to create/update a plan file in the project directory
3. **TODO** — When using TodoWrite for any multi-step task, the FIRST todo item MUST be: "Save implementation plan to PLAN.md" — this todo must be marked completed BEFORE any other todos begin
4. **THEN** — Only after the plan file exists on disk, begin implementation

### Self-Check

If you just described a plan, architecture, or multi-step breakdown in chat text without saving it to a file, you VIOLATED this rule. STOP what you are doing and save it to a file NOW before continuing.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- User says "plan", "design", "architect", "how should we", "let's figure out", "implement", "build", "migrate", "refactor"
- A task has 3+ steps
- You are about to use TodoWrite with 3+ items
- You are making architectural decisions or trade-off analyses
- You are creating a multi-step task breakdown of any kind

### File Naming

- Save plans as markdown files with descriptive names (e.g., `PLAN.md`, `MIGRATION_PLAN.md`, `REFACTOR_PLAN.md`)
- Update the plan file as decisions are made or steps are completed
- If a project already has a plan file, update it rather than creating a new one
- Plans MUST include enough context that a new session can pick up where the last one left off

### What Constitutes a Plan

ANY of the following count as a plan and MUST be saved to a file:
- Implementation steps for a feature or change
- Architectural decisions with rationale
- Migration strategies
- Multi-step debugging approaches
- Task breakdowns with dependencies
- Decision matrices or trade-off analyses

### Violations

The following are VIOLATIONS of this rule:
- Describing a plan only in chat text without writing a file
- Starting implementation before the plan file is saved
- Having TodoWrite items without "Save plan to file" as the first item
- Saying "I'll save the plan" but then proceeding without actually doing it
- Apologizing for not saving the plan but not immediately saving it
