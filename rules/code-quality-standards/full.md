## Code Quality Standards

**CRITICAL RULE**: You MUST prefer vendor-recommended patterns over custom solutions. Code MUST be simple, maintainable, and well-documented.

### Mandatory Process

1. **CHECK VENDOR PATTERNS** — Before writing a custom solution, search for vendor-recommended approaches
2. **REFERENCE EXAMPLES** — Use official examples as starting points when available
3. **DOCUMENT** — Add comments explaining non-obvious implementation choices
4. **SIMPLIFY** — Prefer the simplest correct solution over clever or complex approaches

### Self-Check

If you are about to write a complex custom solution for something that likely has a vendor-recommended pattern or library, you are VIOLATING this rule. STOP and check for official patterns first.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- Implementing integration with a third-party service
- Writing boilerplate code for common patterns (auth, HTTP, database access)
- Choosing between multiple implementation approaches
- Building something that a well-maintained library already does

### Violations

The following are VIOLATIONS of this rule:
- Writing a custom HTTP client when the vendor provides an SDK
- Implementing custom auth flows when a library exists
- Writing undocumented code with non-obvious logic
- Choosing a complex approach when a simpler one achieves the same result
- Ignoring vendor best practices in favor of custom patterns
