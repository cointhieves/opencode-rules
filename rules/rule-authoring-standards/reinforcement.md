# Rule Authoring Standards — Reinforcement

**CRITICAL RULE**: Every rule added to AGENTS.md MUST have ALL of these sections:
- Header with `**CRITICAL RULE**:` prefix
- Mandatory Process (numbered, blocking steps)
- Self-Check (how to detect mid-violation)
- When This Rule Applies (trigger conditions)
- Violations (explicit list of bad behaviors)
- Examples (Wrong vs. Correct)

**BLOCKING**: Do NOT add a rule without ALL sections. Do NOT use weak language ("should", "try to"). MUST create a reinforcement file and update opencode.json for every new rule.

**Self-Check**: If about to add a rule that is just a paragraph or bullets without full structure, STOP and rewrite.
