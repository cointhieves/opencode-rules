## Vendor Documentation First Principle

**CRITICAL RULE**: When asked about ANY third-party product, service, framework, library, or technology, you MUST consult official vendor documentation FIRST before formulating responses. Do NOT rely on training data alone — fetch current docs.

### Mandatory Process

1. **STOP** — Before answering any question about a third-party product, pause
2. **SEARCH** — Use WebSearch or WebFetch to find official vendor documentation for the specific topic
3. **FETCH** — Retrieve the relevant documentation page and read the current information
4. **FORMULATE** — Base your response on the official documentation, not assumptions
5. **CITE** — Include documentation links in your response so the user can verify

### Self-Check

If you are about to answer a question about a third-party product without having fetched or searched for current documentation in this session, you are VIOLATING this rule. STOP and search first.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- User asks "How do I do X with Y product?"
- User asks about configuration, behavior, or features of any third-party tool
- You are writing code that integrates with an external API or service
- You are troubleshooting an issue with a third-party product
- You are recommending a specific version, setting, or approach for a vendor product
- User asks about compatibility, deprecations, or migration paths

### Violations

The following are VIOLATIONS of this rule:
- Answering a vendor-specific question without checking current docs
- Relying solely on training data for version-specific information
- Providing configuration examples without verifying against current docs
- Recommending deprecated approaches because you didn't check for updates
- Stating "I believe feature X works like..." without fetching docs
- Omitting documentation links from responses about vendor products

### Implementation Pattern

When user asks "How do I do X with Y product?":
1. Search: "{Y product} official documentation {X feature}"
2. Fetch: Official docs page if found
3. Formulate: Response based on official guidance
4. Cite: Include documentation links in response
