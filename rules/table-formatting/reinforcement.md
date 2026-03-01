# Table Formatting — Reinforcement

**CRITICAL RULE**: ALL tabular data MUST be rendered inside a triple-backtick code fence using pipe-delimited, column-aligned formatting. NEVER use bare markdown table syntax.

**Before outputting ANY table**: Wrap it in a code fence. Use `|` pipe delimiters. Pad columns to align. Include a `---` separator row between headers and data.

**Applies to**: ANY data displayed in rows and columns — configuration summaries, route tables, destination lists, index listings, status reports, comparison data.

**Does NOT apply to**: Single key-value pairs, inline references, or markdown files written to disk for non-CLI consumption (GitHub READMEs, Confluence pages).

**Violations**: Writing bare markdown tables outside code fences, unaligned columns, using ASCII art or tab-separated formats instead of pipe-delimited.

**Self-Check**: If about to write `| Header | Header |` followed by `|---|---|` as bare markdown (not inside a code fence) — STOP and wrap it in a code fence NOW.
