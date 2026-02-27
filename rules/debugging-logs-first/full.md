## Debugging: Logs and Tests First, Not Guessing

**CRITICAL RULE**: When investigating bugs or unexpected behavior in deployed services, you MUST check logs and test with real data BEFORE making any code changes. Do NOT guess at root causes. This is a BLOCKING requirement.

### Mandatory Process

1. **STOP** — Do NOT hypothesize or write fixes yet
2. **CHECK LOGS** — Query application logs, service logs, or whatever logging backend is available. The answer is almost always in the logs
3. **REPRODUCE** — Query the actual database/API/system state to understand what is happening, not what you think is happening
4. **IDENTIFY ROOT CAUSE** — Find the specific error message or unexpected state
5. **ONLY THEN** — Write a targeted fix for the actual root cause

### Self-Check

If you are about to write a code fix and you have NOT checked the logs or reproduced the issue with real data first, you are VIOLATING this rule. STOP and check logs NOW.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- User reports a bug in a deployed service
- User says something "isn't working", "is broken", "stopped working"
- You encounter unexpected behavior during testing
- A deployment didn't produce the expected results
- A scheduled job or cron task isn't running correctly
- Data is missing, duplicated, or incorrect

### Violations

The following are VIOLATIONS of this rule:
- Guessing at the root cause without checking logs
- Writing speculative fixes ("maybe it's this...")
- Making multiple rounds of hypothetical changes without log evidence
- Adding workarounds instead of fixing the actual root cause
- Assuming a code path works just because it looks correct — verify with logs
- Skipping log checks "because I already know what's wrong"

### Example — Wrong Approach

```
User: The background job isn't processing items
Assistant: *guesses it might be the database query syntax*
Assistant: *guesses it might be a race condition*
Assistant: *rewrites the processing logic from scratch*
(3 deploys later, still broken)
```

### Example — Correct Approach

```
User: The background job isn't processing items
Assistant: Let me check the application logs for the job runner.
Assistant: Found it — "Failed to serialize record:
           Float types are not supported. Use Decimal types instead."
           Every write is failing silently, so the queue never drains.
           The fix is to convert floats to Decimal before writing.
(1 deploy, actually fixed)
```
