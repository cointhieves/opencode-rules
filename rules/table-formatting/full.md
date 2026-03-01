## Table Formatting

**CRITICAL RULE**: ALL tabular data MUST be rendered inside a triple-backtick code fence using pipe-delimited, column-aligned formatting. NEVER use bare markdown table syntax outside a code fence. Markdown tables do not render reliably in CLI/terminal environments and produce unreadable output.

### Mandatory Process

1. **STOP** — Before outputting any tabular data (rows and columns), do NOT write a bare markdown table
2. **CODE FENCE** — Open a triple-backtick code fence block
3. **HEADER ROW** — Write column headers separated by ` | ` with leading and trailing pipes, padded to align columns
4. **SEPARATOR ROW** — Write a row of `---` dashes separated by `|`, matching each column width
5. **DATA ROWS** — Write each data row with ` | ` separators, padded to align with the header columns
6. **CLOSE FENCE** — Close the triple-backtick code fence

### Required Format

Every table MUST follow this exact structure:

````
```
| Column A | Column B       | Column C |
|----------|----------------|----------|
| value 1  | longer value   | val      |
| value 2  | short          | val      |
```
````

### Self-Check

If you are about to write a table using bare markdown syntax (pipes and dashes NOT inside a code fence), you are VIOLATING this rule. STOP, wrap the table in a code fence, and ensure columns are padded to align.

### When This Rule Applies

- Displaying ANY data in rows and columns
- Showing configuration summaries, route tables, destination lists, index listings
- Presenting comparison data, status reports, or any structured output
- ANY time you would naturally reach for a markdown table
- Responding with lists of items that have multiple attributes

### When This Rule Does NOT Apply

- Single key-value pairs (use `key: value` format instead)
- Inline references to a single row of data in a sentence
- Content inside markdown files being written to disk for non-CLI consumption (e.g., GitHub READMEs, Confluence pages)

### Violations

The following are VIOLATIONS of this rule:

- Writing a markdown table outside a code fence (the most common violation)
- Writing `| Header | Header |` followed by `|---|---|` as bare markdown in the response
- Forgetting to pad columns so pipes do not align vertically
- Using a different table format (ASCII art, tab-separated, etc.) instead of pipe-delimited
- Mixing bare markdown tables and code-fenced tables in the same response

### Example — Wrong Approach

The following is bare markdown that breaks in the terminal:

```
| Name | Status | Health |
|---|---|---|
| ec_prod | Red | Unhealthy |
```

This renders as a jumbled mess of pipes and dashes in most CLI environments.

### Example — Correct Approach

````
```
| Name    | Status | Health    |
|---------|--------|-----------|
| ec_prod | Red    | Unhealthy |
```
````

This renders as a clean, aligned, readable table in every terminal.
