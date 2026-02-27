## Rule Authoring Standards

**CRITICAL RULE**: When the user asks you to add, create, or implement a new rule in this global AGENTS.md file, you MUST follow the full rule authoring process below. Do NOT write weak, vague, or aspirational rules. Every rule added to this file must be engineered to maximize LLM compliance.

### Mandatory Process for Adding a Global Rule

1. **STOP** — Do not just append a few bullet points. Plan the rule properly.
2. **Structure** — Every new rule MUST include ALL of the following sections:
   - **Header** with `**CRITICAL RULE**:` prefix and a one-sentence summary
   - **Mandatory Process** — Numbered, concrete, blocking steps the LLM must follow
   - **Self-Check** — A statement the LLM can use to detect if it is about to violate the rule
   - **When This Rule Applies** — Explicit trigger conditions (keywords, scenarios, patterns)
   - **Violations** — Explicit list of behaviors that constitute violations
   - **Examples** (when applicable) — Wrong vs. Correct approach, showing concrete before/after
3. **Reinforcement File** — Create a separate `~/.config/opencode/<rule-name>.md` file containing a condensed version of the rule for double-loading
4. **Double-Load** — Add the reinforcement file path to the `instructions` array in `~/.config/opencode/opencode.json`
5. **Verify** — Read back both the AGENTS.md edit and the opencode.json update to confirm they are correct

### Required Rule Language

- Use **CRITICAL RULE**, **NEVER**, **ALWAYS**, **MUST**, **STOP** — not "should", "try to", "ideally"
- Use **blocking** language: "Do NOT proceed until X" — not "remember to X"
- Include a **self-check** that catches the LLM mid-violation
- Include **violation examples** so the LLM recognizes its own bad patterns
- Make rules **procedurally blocking** (must do X before Y) rather than **aspirational** (always do X)

### Self-Check

If you are about to add a rule to AGENTS.md that is just a paragraph or a few bullet points without the full structure above, you are VIOLATING this rule. STOP and rewrite it properly.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- User says "add a rule", "add to global rules", "make a rule about", "add this to AGENTS.md"
- User says "I want a rule that...", "make sure it always...", "it should never..."
- User describes a recurring problem and asks you to prevent it via rules
- User asks you to "strengthen", "improve", or "fix" an existing rule

### Violations

The following are VIOLATIONS of this rule:
- Adding a rule that is just a sentence or short paragraph without structure
- Adding a rule without a Self-Check section
- Adding a rule without a Violations section
- Adding a rule without creating a reinforcement file
- Adding a rule without updating opencode.json instructions array
- Adding a rule with weak language ("should", "try to", "consider")
- Saying "I'll add the reinforcement file later" and not doing it

### Example — Wrong Approach

```
## My New Rule
Always do X when Y happens. This is important.
- Do X
- Don't forget X
```

### Example — Correct Approach

```
## My New Rule

**CRITICAL RULE**: You MUST do X before proceeding with Y. This is a BLOCKING requirement.

### Mandatory Process
1. **STOP** — Before doing Y, do X first
2. **VERIFY** — Confirm X is complete
3. **THEN** — Only after X is verified, proceed with Y

### Self-Check
If you are about to do Y without having done X, you are VIOLATING this rule. STOP and do X NOW.

### When This Rule Applies
- User asks for Y
- Task involves Y
- You are about to start Y

### Violations
- Doing Y without X
- Skipping X "because it's simple"
- Apologizing for skipping X but not immediately doing X
```
