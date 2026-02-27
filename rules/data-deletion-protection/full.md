## Data Deletion Protection

**CRITICAL RULE**: NEVER perform any action that deletes, removes, or destroys data without a **separate, explicit confirmation step**. The user's original request is NEVER the approval — even if they say "delete X", you MUST still summarize the impact and ask for a yes/no confirmation before executing. This is a BLOCKING requirement.

### Mandatory Process

1. **STOP** — Before ANY destructive operation, halt execution. Do NOT execute inline.
2. **SUMMARIZE** — State exactly what will be deleted, removed, or destroyed. Be specific: file paths, table names, record identifiers, resource names.
3. **SHOW IMPACT** — Display ALL of the following that apply:
   - Number of records, files, or resources affected
   - Size of data being removed (bytes, rows, documents)
   - Time range of affected data
   - Whether the operation is reversible or permanent
   - What depends on the data being deleted (foreign keys, references, downstream systems)
4. **ASK** — End with an explicit yes/no question: "Should I proceed? (yes/no)". Do NOT proceed until the user responds with an affirmative answer **in a separate message**.
5. **EXECUTE** — Only after receiving explicit confirmation, perform the deletion.
6. **VERIFY** — After deletion, confirm the operation completed as expected and show results.

### Critical Distinction: Request vs. Approval

The user saying "delete the file", "remove that table", "clean up old data" is a **request**, NOT approval. The approval is their response to your confirmation prompt. These are TWO separate steps — never collapse them into one.

- "Delete the temp files" — This is a request. You must still summarize and ask.
- "Yes" or "Proceed" — This is approval. Now you may execute.

### Actions Requiring Confirmation

1. **Deleting Files or Directories**
   - ALWAYS list the specific files/directories that will be removed
   - Show file sizes and modification dates when relevant
   - Ask even if it seems like temporary or test data

2. **Dropping Tables/Databases/Schemas**
   - ALWAYS show row counts and schema details
   - Verify backups exist before any destructive operations

3. **Deleting Records (DELETE, TRUNCATE)**
   - ALWAYS show how many records will be affected
   - Show the WHERE clause or filter criteria so the user can verify scope
   - Treat any data removal as potentially permanent

4. **Removing Cloud Resources**
   - ALWAYS show resource identifiers, ages, and dependencies
   - Verify nothing depends on the resource before proposing deletion

5. **Overwriting Data**
   - If an operation will overwrite existing data with no way to recover the original, treat it as a deletion and follow this process

### Self-Check

If you are about to run a command that contains `DELETE`, `DROP`, `TRUNCATE`, `rm`, `rm -rf`, `rm -r`, `del`, `remove`, `purge`, `destroy`, `unlink`, or any equivalent destructive operation — and you have NOT shown a summary, impact assessment, and received a "yes" in a **separate user message** — you are VIOLATING this rule. STOP immediately.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- You are about to run a command containing destructive keywords (DELETE, DROP, rm, etc.)
- A script you wrote includes data deletion logic
- You are cleaning up resources (files, tables, indices, containers)
- You are performing a migration that involves removing old data
- You are "fixing" something by deleting and recreating it
- The user asks you to "clean up", "remove old", "clear out", "reset", or "delete"
- You are about to overwrite data that cannot be recovered

### Violations

The following are VIOLATIONS of this rule:
- Executing a deletion because the user said "delete X" without a separate confirmation step
- Treating the user's request as implicit approval
- Deleting without showing a summary of what will be affected
- Showing a summary but not waiting for a response before executing
- Running `rm -rf` on any directory without confirmation
- Dropping database tables as part of a migration without confirmation
- Truncating tables "to start fresh" without confirmation
- Saying "I'll delete the old data" and doing it without waiting for a "yes"
- Deleting something "small" or "temporary" without asking because it seems harmless

### Example — Wrong (Executing Without Confirmation)

```
User: Delete the temp files in /data/staging
LLM: *runs rm -rf /data/staging/*
     Done, temp files deleted.
```

### Example — Wrong (Treating Request as Approval)

```
User: Remove the old migration table
LLM: Removing the migration table now...
     *runs DROP TABLE old_migration;*
```

### Example — Correct (Summarize, Show Impact, Ask, Wait)

```
User: Delete the temp files in /data/staging

LLM: Before I delete anything, here is what will be affected:

     Directory: /data/staging/
     Files: 47 files
     Total size: 2.3 GB
     Oldest file: 2024-11-15
     Newest file: 2025-02-26

     This operation is PERMANENT and cannot be undone.

     Should I proceed with deleting these 47 files? (yes/no)

User: yes

LLM: *runs rm /data/staging/*
     Deleted 47 files (2.3 GB freed). Directory /data/staging/ is now empty.
```
