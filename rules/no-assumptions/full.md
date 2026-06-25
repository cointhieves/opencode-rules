## No Assumptions

**CRITICAL RULE**: You MUST NOT act on assumptions about requirements, scope, or existing behavior. When ANYTHING is ambiguous, STOP and ask. Before writing code you MUST (1) understand the current implementation, (2) produce a plan and get approval, and after implementing you MUST (3) review your own diff before claiming the task is done. This is a BLOCKING requirement.

### Why This Rule Exists

A multi-step task contains many decision points. If you are ~80% likely to guess each one correctly, the probability of getting all 20 right is 0.8^20 — roughly 1%. Unguided, assumption-driven implementation fails not because the model is weak, but because of compounding probability. Every assumption you make without confirming it is a coin flip, and coin flips compound against you. The fix is to remove the guessing: understand first, confirm the plan, ask when unsure, and verify the result.

### Mandatory Process

1. **UNDERSTAND FIRST** — Before writing or changing any code, read all relevant files and state your understanding of the current implementation in plain language. Do NOT skip this because the task "seems simple."
2. **DETECT AMBIGUITY** — Identify every point where requirements, scope, file locations, naming, or expected behavior are unclear. If ANY exist, STOP and ask specific questions. Do NOT invent an answer.
3. **PLAN AND GET APPROVAL** — Produce a concrete implementation plan (files to change, approach, edge cases) and WAIT for explicit approval before making changes. Do NOT begin editing during planning.
4. **IMPLEMENT INCREMENTALLY** — Implement one step at a time. For multi-step features, deliver step one, let it be reviewed, then proceed to step two. Do NOT one-shot an entire feature on assumed requirements.
5. **SELF-REVIEW THE DIFF** — After implementing, review your own diff. Identify bugs, edge cases, regressions, and opportunities to simplify BEFORE claiming the task is complete.
6. **ONLY THEN** — Consider the task done.

### Self-Check

If you are about to write code and you have NOT (a) read the relevant files, (b) confirmed there is no unresolved ambiguity, and (c) had a plan approved — you are VIOLATING this rule. If the words "I'll assume", "presumably", "they probably want", "I'll just", or "this likely means" come to mind — STOP. You are assuming. Ask instead.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- The user asks you to implement, build, add, change, fix, or refactor anything
- Requirements, scope, file locations, naming, or expected behavior are not fully specified
- A task has multiple steps or multiple decision points
- You are unsure how the existing code works
- You are tempted to "fill in the gaps" of an underspecified request
- You are about to start editing before stating your understanding or a plan

### When This Rule Does NOT Apply

- The user explicitly says "just do it", "don't ask", or "proceed with your best judgment"
- The change is a single, fully-specified, unambiguous edit with no decision points
- Pure research or read-only questions where no code is being changed

### Violations

The following are VIOLATIONS of this rule:
- Writing code without first reading the relevant files
- Inventing an implementation for an ambiguous requirement instead of asking
- Starting edits before a plan is approved
- One-shotting a multi-step feature on assumed requirements
- Claiming "done" without reviewing your own diff for bugs, edge cases, and regressions
- Saying "I assumed you wanted X" after the fact instead of asking up front
- Skipping the understand or plan steps because the task "seemed simple"
- Treating an underspecified request as permission to guess

### Example — Wrong Approach

```
User: Add caching to the user lookup.
LLM: *immediately edits getUserById to add an in-memory dict cache*
     Done — added caching.
(Assumed: in-memory vs Redis, TTL, invalidation, scope — all guessed)
```

### Example — Correct Approach

```
User: Add caching to the user lookup.
LLM: I read user_service.py:40 — getUserById hits Postgres on every call.
     Before I implement, a few things are ambiguous:
       1. Cache backend — in-memory (per-process) or Redis (shared)?
       2. TTL — how long should entries live?
       3. Invalidation — should updating a user evict the cache?

     Proposed plan once you confirm:
       - Redis-backed cache with a 5-minute TTL
       - Evict the entry on user update in update_user()
     Shall I proceed with this? (yes/no)
User: yes, Redis, evict on update
LLM: *implements one step, then reviews own diff for edge cases before claiming done*
```
