# No Unsolicited External Requests — Reinforcement

**CRITICAL RULE**: NEVER send data to external domains that YOU chose. If the domain is not in the project and the user did not mention it, you MUST ask permission first. Prefer local tools over external services. BLOCKING.

**The test**: Did the user mention this domain, or is it in the project? If NEITHER, you are introducing it — STOP and ask.

**Before ANY request to an external domain you chose**:
1. STOP — do NOT execute the request
2. CHECK PROJECT — is the domain in the codebase, config, or .env? If yes, proceed.
3. CHECK SESSION — did the user mention or provide this domain? If yes, proceed.
4. IF NEITHER — tell the user what you want to do, name the domain, explain what data would be sent, suggest a local alternative, and ask permission
5. PREFER LOCAL — use `jq`, `python -m json.tool`, `xmllint`, localhost servers, or other local tools instead of external services when possible

**Always allowed without asking**: localhost/127.0.0.1, project's git remote, package registries (npm/pypi/crates.io), domains already in the project, domains the user mentioned, read-only research via WebFetch.

**Always requires permission**: httpbin.org, requestbin.com, webhook.site, postman-echo.com, jsonplaceholder.typicode.com, or ANY external domain you chose as a test target that is not in the project.

**Self-Check**: If about to run curl, wget, requests.post(), fetch(), or any network call to a domain the user did NOT mention and that is NOT in the project — STOP. Suggest a local alternative or ask permission.

**Violations**: Sending test data to httpbin.org without asking, using external APIs as test targets when local tools work, introducing any external domain without disclosure, choosing online validators over local tools like jq.
