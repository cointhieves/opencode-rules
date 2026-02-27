# Security & Best Practices — Reinforcement

**CRITICAL RULE**: NEVER hardcode credentials, secrets, API keys, or sensitive data in code or config files. MUST use secure alternatives.

**Process**:
1. STOP — before writing code that handles credentials
2. CHECK — verify no secrets are hardcoded
3. USE SECURE ALTERNATIVES — env vars, secret managers, vault services
4. FOLLOW VENDOR GUIDANCE — reference official security recommendations
5. VALIDATE — review output for accidental secret exposure

**Self-Check**: If about to write a string that looks like a credential directly into code or config — STOP and use env var or secret manager.

**Violations**: Hardcoding API keys, passwords in config files, tokens in comments, default credentials that look real, connection strings with embedded credentials.
