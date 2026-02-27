# Verification Requirements — Reinforcement

**CRITICAL RULE**: MUST verify work before claiming success. Do NOT trust script output without independent verification. BLOCKING — do NOT claim "done" or "fixed" without proof.

**Process**:
1. IMPLEMENT — make the change or run the script
2. STOP — do NOT trust the output yet
3. VERIFY INDEPENDENTLY — query actual system state (database, API, files)
4. SPOT-CHECK — manually check 2-3 random samples
5. SHOW PROOF — include verification output in response
6. ONLY THEN — claim task is complete

**Self-Check**: If about to say "done", "fixed", "completed", "working now", "no issues found" without having run a verification query and shown results — STOP and verify first.

**Violations**: Trusting script output without verification, declaring "fixed" without testing, claiming "restored" without checking content, saying "no issues" without spot-checking, implementing without running, claiming success when numbers don't match.
