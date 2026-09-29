# Durable Artifacts — Reinforcement

**CRITICAL RULE**: NEVER write a file to temp space if anyone will need to read it again after this turn. Artifacts go to `~/Documents/code/artifacts/<YYYY-MM-DD>-<slug>/`. BLOCKING.

**The classification test**: *Will anyone — including a future session of me — need to read this file again after this turn ends?*
- YES -> artifact -> `~/Documents/code/artifacts/<YYYY-MM-DD>-<slug>/`
- NO, consumed and discarded in the same turn -> temp is fine

**Before writing ANY file**:
1. STOP — apply the classification test before choosing a path
2. ARTIFACT? — use `~/Documents/code/artifacts/<YYYY-MM-DD>-<slug>/`, already inside the allowed `~/Documents/code/**` glob
3. REPO WORK? — if the file belongs to a specific codebase, it goes in that repo instead
4. SCRATCH ONLY? — temp is acceptable only for intermediates consumed and discarded within the same turn
5. TELL THE USER the path you chose, so a wrong choice is visible immediately

**Do not be misled by the system-prompt temp grant.** The pre-approved
`/var/folders/.../T/opencode` directory is scoped to *"temporary work outside the
workspace."* "Outside the workspace" is not permission to put durable artifacts
there — the operative word is *temporary*.

**Always artifacts, never temp**: vendor support write-ups, incident reports,
analysis handed to a human, plan files, generated HTML/markdown for
distribution, exported data referenced later, diagrams, meeting or ticket drafts.

**Ticket-bound artifacts**: also attach upstream where possible. Jira attachment
upload via MCP is broken (the MCP server runs in its own filesystem context and
rejects absolute host paths). Confluence upload works and is the reliable durable
upstream surface.

**Self-Check**: If you are about to write to `/tmp`, `/private/tmp`, or
`/var/folders/.../T/opencode`, and the file is something you will reference later
in this session or hand to the user — you are VIOLATING this rule. STOP and write
it to the artifacts directory.

**Violations**: Writing a report, draft, or analysis to temp; putting a durable
artifact in temp because the temp path was pre-approved; cluttering an unrelated
code repo with a document that does not belong to it; writing a file without
telling the user where it went; leaving an artifact in temp and saying "say the
word if you want it somewhere durable" instead of putting it in the right place
the first time.
