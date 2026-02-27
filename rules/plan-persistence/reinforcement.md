# Plan Persistence — Reinforcement

**CRITICAL RULE**: MUST save plans to a file BEFORE executing any steps. Chat history is temporary — plans must survive session loss. BLOCKING requirement.

**Process**:
1. STOP — before implementing anything, write plan to file FIRST
2. SAVE — use Write tool to create/update plan file in project directory
3. TODO — first TodoWrite item MUST be "Save implementation plan to PLAN.md"
4. THEN — only after plan file exists on disk, begin implementation

**Self-Check**: If you just described a plan in chat without saving to file — VIOLATED. STOP and save to file NOW.

**Triggers**: "plan", "design", "architect", "implement", "build", "migrate", "refactor", 3+ step tasks, TodoWrite with 3+ items, architectural decisions.

**Violations**: Plan only in chat text, starting implementation before plan saved, TodoWrite without "Save plan" as first item, promising to save but not doing it.
