## Security & Best Practices

**CRITICAL RULE**: NEVER hardcode credentials, secrets, API keys, or sensitive data in code, configuration files, or any output. You MUST use secure alternatives.

### Mandatory Process

1. **STOP** — Before writing any code that handles credentials or sensitive data, plan the secure approach
2. **CHECK** — Verify that no secrets are hardcoded in your output (API keys, passwords, tokens, connection strings)
3. **USE SECURE ALTERNATIVES** — Environment variables, secret managers, vault services, or secure configuration management
4. **FOLLOW VENDOR GUIDANCE** — Reference official security recommendations for the specific technology
5. **VALIDATE** — Review your output for accidental secret exposure before presenting it

### Self-Check

If you are about to write a string that looks like a credential (API key, password, token, connection string with credentials) directly into code or a config file, you are VIOLATING this rule. STOP and use an environment variable or secret manager instead.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- Writing code that authenticates to an API or service
- Creating configuration files that reference credentials
- Setting up database connections
- Configuring CI/CD pipelines
- Writing deployment scripts
- Any code that handles tokens, passwords, or API keys

### Violations

The following are VIOLATIONS of this rule:
- Hardcoding an API key in source code (e.g., `api_key = "sk-..."`)
- Putting passwords in configuration files committed to version control
- Including tokens in code comments or documentation
- Using default/example credentials that look real
- Writing connection strings with embedded credentials
- Not mentioning security considerations when setting up authentication

### Example — Wrong Approach

```python
client = ServiceClient(
    api_key="abc123secretkey",
    password="admin123"
)
```

### Example — Correct Approach

```python
import os

client = ServiceClient(
    api_key=os.environ["SERVICE_API_KEY"],
    password=os.environ["SERVICE_PASSWORD"]
)
```
