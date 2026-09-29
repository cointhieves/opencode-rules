## Durable Artifacts

**CRITICAL RULE**: You MUST NOT write a file to temporary space if anyone — including a future session of yourself — will need to read it again after the current turn ends. Durable artifacts go to `~/Documents/code/artifacts/<YYYY-MM-DD>-<slug>/`. This is a BLOCKING requirement.

### Why This Rule Exists

The agent's system prompt pre-approves a temp directory for *"temporary work outside the workspace."* That grant is scoped by the word **temporary**. An Elastic vendor support write-up — a document intended to be pasted into a support case and referenced across sessions — was written to that temp directory purely because it was the pre-approved path and the alternative (an unrelated Terraform repo) was obviously wrong. The correct destination did not exist, so the ephemeral one won by default.

### The Classification Test

Before choosing a path, answer one question:

> Will anyone — including a future session of me — need to read this file again after this turn ends?

- **Yes** -> it is an **artifact** -> `~/Documents/code/artifacts/<YYYY-MM-DD>-<slug>/`
- **No, it is consumed and discarded within this same turn** -> temp is acceptable

### Mandatory Process

1. **STOP** — Before writing any file, apply the classification test. Do not pick a path first and rationalise it after.
2. **IF ARTIFACT** — Write to `~/Documents/code/artifacts/<YYYY-MM-DD>-<slug>/`. This sits inside the already-allowed `~/Documents/code/**` glob, so no permission change is needed.
3. **IF REPO WORK** — If the file genuinely belongs to a specific codebase, it goes in that repo instead. Do NOT put unrelated documents in a repo just because the repo is writable.
4. **IF SCRATCH** — Temp is acceptable only for intermediates consumed and discarded within the same turn.
5. **TELL THE USER** the path you chose, in the response, so a wrong choice is visible immediately rather than discovered later.

### Always Artifacts, Never Temp

Vendor support write-ups; incident reports; analysis handed to a human; plan files; generated HTML or markdown for distribution; exported data referenced later; diagrams; ticket or meeting drafts.

### Ticket-Bound Artifacts

Where an artifact belongs to a tracked work item, also attach it upstream. Note that Jira attachment upload via MCP is broken — the MCP server runs in its own filesystem context and rejects absolute host paths. Confluence upload works and is the reliable durable upstream surface.

### Self-Check

If you are about to write to `/tmp`, `/private/tmp`, or `/var/folders/.../T/opencode`, and the file is something you will reference later in this session or hand to the user — you are VIOLATING this rule. STOP and write it to the artifacts directory instead.

If you catch yourself about to say *"say the word if you want it somewhere durable"* — you have already violated this rule. Put it in the right place the first time.

### When This Rule Applies

- You are about to use the Write tool for any document, report, draft, or export
- You are generating markdown or HTML for distribution
- You are saving a plan file
- You are exporting query results, diagrams, or data you will reference again
- You are writing something you intend to hand to the user, a vendor, or a ticket

### Violations

- Writing a report, draft, or analysis to temp space
- Putting a durable artifact in temp because the temp path was pre-approved
- Reading "outside the workspace" as permission to store durable files in temp
- Cluttering an unrelated code repo with a document that does not belong to it
- Writing a file without telling the user where it went
- Offering to move a file somewhere durable instead of writing it there initially

### Example — Wrong Approach

```
User: Draft a support ticket I can submit.
LLM: *writes /var/folders/.../T/opencode/support-ticket.md*
     Draft written. Say the word if you want it somewhere durable.
```

### Example — Correct Approach

```
User: Draft a support ticket I can submit.
LLM: *writes ~/Documents/code/artifacts/2026-08-30-elastic-geoip-upgrade/
      elastic-geoip-upgrade-full.md*
     Draft written to
     ~/Documents/code/artifacts/2026-08-30-elastic-geoip-upgrade/.
```
