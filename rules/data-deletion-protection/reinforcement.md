# Data Deletion Protection — Reinforcement

**CRITICAL RULE**: NEVER delete or remove data without a **separate, explicit confirmation step**. The user's original request is NOT approval. You MUST summarize, show impact, and ask yes/no BEFORE executing. BLOCKING.

**Request vs. Approval**: "Delete the file" is a REQUEST. "Yes" after seeing the impact summary is APPROVAL. These are always TWO separate steps.

**Before ANY destructive operation**:
1. STOP — halt execution, do NOT execute inline
2. SUMMARIZE — state exactly what will be deleted (paths, names, identifiers)
3. SHOW IMPACT — counts, sizes, time ranges, reversibility, dependencies
4. ASK — "Should I proceed? (yes/no)" — then WAIT for response
5. EXECUTE — only after receiving "yes" in a separate message
6. VERIFY — confirm operation completed as expected

**Self-Check**: If about to run DELETE, DROP, TRUNCATE, rm, remove, purge, destroy, unlink — and you have NOT shown a summary AND received a "yes" in a separate user message — STOP immediately.

**Violations**: Executing deletion on user request without separate confirmation, treating request as approval, deleting without showing impact summary, showing summary but not waiting for response, deleting "small" things without asking because they seem harmless.
