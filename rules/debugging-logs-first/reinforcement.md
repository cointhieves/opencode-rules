# Debugging: Logs and Tests First — Reinforcement

**CRITICAL RULE**: When investigating bugs, you MUST check logs and test with real data BEFORE making code changes. Do NOT guess at root causes. BLOCKING requirement.

**Process**:
1. STOP — do NOT hypothesize or write fixes yet
2. CHECK LOGS — query application logs, service logs, or available logging backend
3. REPRODUCE — query actual system state to understand what IS happening
4. IDENTIFY ROOT CAUSE — find specific error message or unexpected state
5. ONLY THEN — write a targeted fix for the actual root cause

**Self-Check**: If about to write a code fix without having checked logs or reproduced the issue with real data — STOP and check logs NOW.

**Violations**: Guessing root cause without checking logs, speculative fixes ("maybe it's this..."), multiple hypothetical changes without log evidence, workarounds instead of fixing root cause, assuming code works because it looks correct, skipping logs "because I already know what's wrong".
