# Distributable Content Formatting — Reinforcement

This file exists to reinforce the Distributable Content Formatting rule from AGENTS.md.

## The Rule

When the user produces content intended for distribution (emails, Slack messages, TL;DR summaries, reports), you MUST generate BOTH a markdown file AND a styled HTML file, open the HTML in the browser, and instruct the user to Cmd+A / Cmd+C / Cmd+V.

## Key Prohibitions

- NEVER produce only markdown when the user said they want to send, share, email, or distribute content
- NEVER use external CSS or CDN links — they will NOT survive copy/paste
- NEVER forget the `tables` or `fenced_code` extensions when converting
- NEVER skip opening the HTML in the browser
- NEVER tell the user to install pandoc or wkhtmltopdf — Python `markdown` is sufficient
- ALWAYS include inline `<style>` in the HTML `<head>` — unstyled HTML is worse than plain text
- ALWAYS tell the user the Cmd+A / Cmd+C / Cmd+V workflow

## Mandatory Steps

1. **WRITE** — Create markdown file (canonical source)
2. **CONVERT** — `pip3 install markdown` if needed, use extensions `['tables', 'fenced_code']`
3. **STYLE** — Wrap in HTML with inline `<style>`: Arial font, 14px, tables with borders, code blocks with `#f4f4f4` background, `pre code { background: none; padding: 0; }`, max-width 900px
4. **SAVE** — Write `.html` alongside `.md` (same name)
5. **OPEN** — `open <file>.html` (macOS) or `xdg-open <file>.html` (Linux)
6. **INSTRUCT** — Tell user: "Cmd+A to select all, Cmd+C to copy, Cmd+V to paste into Gmail/Slack"

## If You Are About to Violate This Rule

STOP. If the user said "send", "email", "share", "copy/paste", "distribute", "forward", "write up", or "TL;DR" and you are about to deliver ONLY a markdown file without the HTML version, you are VIOLATING this rule. Generate the HTML NOW, open it in the browser, and tell the user how to copy/paste it.
