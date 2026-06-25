# No Assumptions — Reinforcement

**CRITICAL RULE**: NEVER act on assumptions about requirements, scope, or existing behavior. When ANYTHING is ambiguous, STOP and ask. BLOCKING.

**The math**: A multi-step task has ~20 decision points. At 80% correct each, all-correct ≈ 0.8^20 ≈ 1%. Guessing compounds against you — remove the guessing.

**Before writing ANY code**:
1. UNDERSTAND — read all relevant files, state your understanding of the current implementation
2. ASK — identify every ambiguity in requirements/scope/behavior; STOP and ask specific questions instead of inventing answers
3. PLAN + APPROVAL — produce a concrete plan and WAIT for explicit approval before changing code
4. INCREMENTAL — implement one step at a time; do NOT one-shot a whole feature on assumed requirements
5. SELF-REVIEW — after implementing, review your own diff for bugs, edge cases, regressions, and simplifications before claiming done

**Self-Check**: If "I'll assume", "presumably", "they probably want", or "I'll just" comes to mind — STOP. You are assuming. Ask instead. If about to write code without having read the files, resolved ambiguity, and had a plan approved — you are VIOLATING this rule.

**Does NOT apply**: user says "just proceed"/"don't ask", a single fully-specified unambiguous edit, or read-only research.

**Violations**: Coding without reading files first, inventing implementations for ambiguous requirements, editing before plan approval, one-shotting multi-step features on assumptions, claiming "done" without reviewing your own diff, saying "I assumed X" after the fact.
