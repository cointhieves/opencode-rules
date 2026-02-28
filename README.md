# opencode-rules

A modular set of global behavior rules for LLM coding assistants. These rules define *how* the assistant works — not what technologies to use, but what standards to follow when writing code, debugging, planning, and communicating.

Pick the rules you want. Skip the ones you don't.

## Rules

| # | Rule | What It Does |
|---|------|-------------|
| 1 | rule-authoring-standards | How to write new rules that actually get followed |
| 2 | no-ai-attribution | Never include AI attribution in code, commits, or docs |
| 3 | data-deletion-protection | Never delete data without a separate confirmation step |
| 4 | research-before-assuming | Look it up before stating it as fact |
| 5 | vendor-docs-first | Check official docs before answering vendor questions |
| 6 | security-best-practices | Never hardcode credentials or secrets |
| 7 | code-quality-standards | Prefer vendor patterns, keep it simple, document it |
| 8 | plan-persistence | Save plans to files before executing — chat is temporary |
| 9 | performance-concurrency | Parallelize network-bound loops, always add timeouts |
| 10 | verification-requirements | Verify independently before claiming success |
| 11 | debugging-logs-first | Check logs before guessing at root causes |
| 12 | no-unsolicited-external-requests | Ask before sending data to domains the model chose |

## How It Works

Each rule has two files:

- **`full.md`** — Detailed version with process, self-checks, examples, and violation lists. These get assembled into a single `AGENTS.md` at install time.
- **`reinforcement.md`** — Condensed version loaded separately via `opencode.json` instructions array. The double-loading increases compliance.

## Installation

```bash
git clone git@github.com:cointhieves/opencode-rules.git
cd opencode-rules
./install.sh
```

The installer shows a menu:

```
Available rules:

   1) rule-authoring-standards      How to write rules that actually get followed
   2) no-ai-attribution             Never attribute output to AI in code or commits
   3) data-deletion-protection      Never delete data without separate confirmation step
   ...

Install which rules? (enter numbers separated by spaces, or 'all') [all]:
```

Enter numbers to pick specific rules, or press Enter for all.

### What the installer does

1. Backs up any existing `~/.config/opencode/AGENTS.md` and `opencode.json` (timestamped)
2. Assembles `AGENTS.md` from only your selected rules
3. Copies reinforcement files for selected rules to `~/.config/opencode/`
4. Merges instruction paths into your existing `opencode.json` (preserves your other settings)

### Requirements

- `bash`
- `python3` or `jq` (for merging opencode.json)

## Uninstallation

```bash
./uninstall.sh
```

Removes installed rule files and restores your most recent backups.

## Adding Your Own Rules

Each rule is a directory under `rules/` with two files:

```
rules/my-new-rule/
├── full.md            # Detailed version (assembled into AGENTS.md)
└── reinforcement.md   # Condensed version (loaded via opencode.json)
```

Follow the Rule Authoring Standards — every rule needs:
1. `**CRITICAL RULE**:` header
2. Numbered **Mandatory Process** (blocking steps)
3. **Self-Check** (how to detect mid-violation)
4. **When This Rule Applies** (trigger conditions)
5. **Violations** (explicit bad behaviors)
6. **Examples** (wrong vs. correct)

Then add your rule directory name to the arrays in `install.sh`.

## Project-Specific Rules

These global rules are about *how* to work. For project-specific rules (specific technologies, APIs, architectural decisions), use a project-level `.opencode/AGENTS.md` file instead.

## File Structure

```
opencode-rules/
├── README.md
├── install.sh
├── uninstall.sh
└── rules/
    ├── rule-authoring-standards/
    │   ├── full.md
    │   └── reinforcement.md
    ├── no-ai-attribution/
    │   ├── full.md
    │   └── reinforcement.md
    ├── data-deletion-protection/
    │   ├── full.md
    │   └── reinforcement.md
    ├── research-before-assuming/
    │   ├── full.md
    │   └── reinforcement.md
    ├── vendor-docs-first/
    │   ├── full.md
    │   └── reinforcement.md
    ├── security-best-practices/
    │   ├── full.md
    │   └── reinforcement.md
    ├── code-quality-standards/
    │   ├── full.md
    │   └── reinforcement.md
    ├── plan-persistence/
    │   ├── full.md
    │   └── reinforcement.md
    ├── performance-concurrency/
    │   ├── full.md
    │   └── reinforcement.md
    ├── verification-requirements/
    │   ├── full.md
    │   └── reinforcement.md
    ├── debugging-logs-first/
    │   ├── full.md
    │   └── reinforcement.md
    └── no-unsolicited-external-requests/
        ├── full.md
        └── reinforcement.md
```

## License

MIT
