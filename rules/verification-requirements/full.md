## Verification Requirements

**CRITICAL RULE**: You MUST verify your work before claiming success. Do NOT trust script output without independent verification. This is a BLOCKING requirement — do NOT claim "done" or "fixed" without proof.

### Mandatory Process

1. **IMPLEMENT** — Make the change or run the script
2. **STOP** — Do NOT trust the output yet
3. **VERIFY INDEPENDENTLY** — Query the actual system state (database, API, files) to confirm the change took effect
4. **SPOT-CHECK** — Manually check 2-3 random samples from the results
5. **SHOW PROOF** — Include verification output in your response
6. **ONLY THEN** — Claim the task is complete

### Self-Check

If you are about to say "done", "fixed", "completed", "working now", or "no issues found" without having run a verification query and shown the results, you are VIOLATING this rule. STOP and verify first.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- You just ran a script and are about to report the results
- You just made a code change and are about to claim it's fixed
- You just performed a data operation and are about to report success
- A script reports "0 errors" or "0 problems" — verify this is actually true
- Numbers don't add up (e.g., 45 total but only 41 processed) — investigate the gap
- You are about to say "everything looks good"

### Violations

The following are VIOLATIONS of this rule:
- Trusting script output without independent verification
- Declaring "fixed" without testing the actual scenario
- Claiming "restored" without checking the actual content
- Saying "no issues found" without spot-checking samples
- Implementing a solution without running it
- Showing script output as proof without querying the actual system
- Claiming success when verification shows different numbers than expected

### Common Failure Patterns to Avoid

- Trusting script output without verification
- Declaring "fixed" without testing the actual scenario
- Claiming "restored" without checking the actual content
- Saying "no issues found" without spot-checking samples
- Implementing solutions without running them
