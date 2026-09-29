## Distributable Content Formatting

**CRITICAL RULE**: When the user produces content intended for distribution (emails, Slack messages, TL;DR summaries, reports, write-ups), you MUST generate BOTH a markdown file AND a browser-ready HTML file so the user can copy/paste with full formatting preserved. Do NOT produce only markdown when the content is meant to be shared.

### Mandatory Process

1. **WRITE** — Create the content as a markdown file first (this is the canonical source)
2. **CONVERT** — Use Python's `markdown` library to convert to HTML:
   - Install if needed: `pip3 install markdown`
   - Extensions: `['tables', 'fenced_code']` (ALWAYS include both)
3. **STYLE** — Wrap the HTML body in a full HTML document with an inline `<style>` block:
   - Font: `Arial, sans-serif`, 14px, `#222` color
   - Max-width: `900px`, centered with `margin: 20px auto`
   - Tables: `border-collapse`, `1px solid #ccc` borders, `#f5f5f5` header background
   - Code blocks: `#f4f4f4` background, `12px` monospace font, `12px` padding, `border-radius: 4px`
   - Pre/code: nested `code` inside `pre` MUST have `background: none` and `padding: 0`
   - No external stylesheets, no CDN links (they will NOT survive copy/paste)
4. **SAVE** — Write the HTML file alongside the markdown file (same name, `.html` extension)
5. **OPEN** — Open the HTML file in the default browser: `open <file>.html` (macOS) or `xdg-open <file>.html` (Linux)
6. **INSTRUCT** — Tell the user: "Cmd+A to select all, Cmd+C to copy, Cmd+V to paste into Gmail/Slack/etc."

### Self-Check

If the user has indicated content is for distribution and you are about to produce ONLY a markdown file without also generating the styled HTML version and opening it in the browser, you are VIOLATING this rule. STOP and produce both formats NOW.

### When This Rule Applies

- User says "send", "email", "share", "copy/paste", "distribute", or "forward"
- User says "write it up so I can send it" or "prepare this for email"
- User asks for a TL;DR, summary, or report to share with others
- User mentions Gmail, Slack, Confluence, Teams, or any distribution target
- User says "something I can copy/paste" or "with formatting"
- User asks for a "write-up" or "report" that is clearly meant for an audience

### When This Rule Does NOT Apply

- User is writing content for themselves (notes, plans, internal docs)
- Content is code, configuration, or technical files not meant for email
- User explicitly asks for markdown only

### Violations

- Producing only a markdown file when the user said they want to send/share/email it
- Using external CSS or stylesheets that will not survive copy/paste
- Forgetting the `tables` or `fenced_code` extensions (tables will render as raw text)
- Not opening the HTML in the browser automatically
- Telling the user to install a heavy tool (pandoc, wkhtmltopdf) when Python `markdown` works
- Generating HTML without inline `<style>` (unstyled HTML is worse than plain text)
- Forgetting to tell the user the Cmd+A / Cmd+C / Cmd+V workflow

### Example — Wrong Approach

```
User: Write this up so I can email it to the team
Assistant: *writes report.md*
Here's the report in markdown.
(User cannot paste this into Gmail with formatting)
```

### Example — Correct Approach

```
User: Write this up so I can email it to the team
Assistant: *writes report.md*
Assistant: *converts to report.html with styled tables and code blocks*
Assistant: *runs `open report.html`*
Opened in your browser. Cmd+A to select all, Cmd+C to copy,
Cmd+V to paste into Gmail. Formatting will be preserved.
```

