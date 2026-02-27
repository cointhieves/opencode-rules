# Code Quality Standards — Reinforcement

**CRITICAL RULE**: MUST prefer vendor-recommended patterns over custom solutions. Code MUST be simple, maintainable, and documented.

**Process**:
1. CHECK VENDOR PATTERNS — search for vendor-recommended approaches before writing custom code
2. REFERENCE EXAMPLES — use official examples as starting points
3. DOCUMENT — add comments for non-obvious implementation choices
4. SIMPLIFY — prefer simplest correct solution over clever approaches

**Self-Check**: If about to write a complex custom solution for something that likely has a vendor pattern or library — STOP and check for official patterns first.

**Violations**: Custom HTTP client when SDK exists, custom auth when library exists, undocumented non-obvious logic, complex approach when simpler one works, ignoring vendor best practices.
