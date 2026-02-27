## No Unsolicited External Requests

**CRITICAL RULE**: NEVER send data to, or initiate connections with, external domains that YOU (the model) chose — unless the domain is already part of the project or the user explicitly mentioned it. If YOU are introducing a new external domain into the workflow, you MUST stop and ask the user for permission first. This is a BLOCKING requirement.

### Why This Rule Exists

An LLM decided to validate JSON output by sending it to `httpbin.org` during testing — a domain the user never mentioned and that had nothing to do with the project. This triggered security alerts and the user had no idea it was happening. A local tool like `jq` would have worked perfectly. The model must NEVER introduce external service dependencies on its own initiative.

### Mandatory Process

1. **STOP** — Before executing any command, script, or test that sends data to an external domain, ask: "Did the user mention this domain, or is it already in the project?"
2. **CHECK PROJECT** — Search the codebase, config files, `.env` files, and project documentation for the domain. If found, it is a known project domain — proceed without asking.
3. **CHECK SESSION** — Review whether the user mentioned or provided this URL/domain in the current session. If so, proceed without asking.
4. **IF NEITHER** — The domain is one YOU chose. Do NOT proceed. Instead:
   a. Tell the user what you want to do and why
   b. Name the specific external domain you want to use
   c. Explain what data would be sent
   d. Suggest a local alternative if one exists (e.g., `jq` instead of httpbin, `python -m json.tool` instead of an online validator)
   e. Ask the user for explicit permission before proceeding
5. **PREFER LOCAL** — When a local tool can accomplish the same task, use it instead of reaching out to an external service. Do not introduce external dependencies when local alternatives exist.

### What Counts as "Introducing a Domain"

You are introducing a domain if ALL of the following are true:
- The domain does not appear in the project's codebase, config, or environment variables
- The user has not mentioned or provided the domain in the current session
- YOU selected the domain based on your own knowledge (e.g., you know httpbin.org exists for testing)

### Domains That NEVER Require Permission

The following are always allowed without asking:
- **localhost / 127.0.0.1 / [::1]** — Local development and testing
- **The project's own git remote** — `git push`, `git pull`, `git fetch`
- **Standard package registries** — `npmjs.com`, `pypi.org`, `crates.io`, `rubygems.org`, `pkg.go.dev`, `registry.hub.docker.com`
- **Domains already in the project** — Any domain found in the codebase, config files, `.env`, `docker-compose.yml`, CI/CD config, or documentation
- **Domains the user explicitly mentioned** — Any URL or domain the user provided in the current session
- **Documentation and research** — Using WebFetch or equivalent tools to READ documentation pages (read-only research is always allowed)

### Domains That ALWAYS Require Permission

If you are about to use any of these (or similar) as a test target and the user did not ask you to, you MUST ask first:
- `httpbin.org`, `requestbin.com`, `webhook.site`, `postman-echo.com` — HTTP testing services
- `jsonplaceholder.typicode.com` — Fake REST API
- `example.com`, `example.org` — Even if "just for testing"
- Any public API you chose as a test target (e.g., a weather API to test HTTP client code)
- Any cloud service endpoint that the project does not already use

### Self-Check

If you are about to run `curl`, `wget`, `requests.post()`, `fetch()`, `http.client`, or any network call to a domain that the user did NOT mention and that is NOT in the project codebase — you are VIOLATING this rule. STOP, suggest a local alternative or ask permission.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- You are writing or running a test that makes HTTP requests to an external service
- You are validating data by sending it to an online service instead of using a local tool
- You are about to `curl`, `wget`, or use any HTTP client against a domain you chose
- You are writing example code that hits a live external endpoint
- You are debugging by sending payloads to a third-party service
- You are setting up a webhook, callback URL, or integration test against a service not in the project

### When This Rule Does NOT Apply

- You are using WebFetch or equivalent to read documentation (read-only research)
- You are running `git push` / `git pull` to the project's remote
- You are installing packages (`npm install`, `pip install`, `cargo add`)
- You are hitting `localhost` or `127.0.0.1`
- You are hitting a domain that exists in the project's config, codebase, or `.env`
- The user gave you the URL and told you to use it

### Violations

The following are VIOLATIONS of this rule:
- Sending test data to httpbin.org (or similar) without asking the user
- Using an external API as a test target when a local tool would work
- Writing a script that hits a third-party service the user never mentioned
- Introducing any external domain into the workflow without disclosure
- Choosing an online JSON/XML/YAML validator instead of a local tool like `jq`, `python -m json.tool`, `xmllint`, or `yq`
- Saying "Let me test this against httpbin" and running the command without waiting for approval
- Assuming a well-known test service (httpbin, postman-echo, etc.) is safe to use without asking

### Example — Wrong (Model Introduces External Domain Without Asking)

```
User: Can you verify this JSON payload is valid?

LLM: Let me send it to httpbin.org to check.
     *runs curl -X POST httpbin.org/post -d '{"key": "value"}'*
     The response came back 200, so the JSON is valid.
```

### Example — Wrong (Model Uses External API as Test Target)

```
User: Write a function that makes HTTP POST requests and test it.

LLM: I'll test the function against postman-echo.com.
     *runs python test_http.py*  (which hits postman-echo.com/post)
     Tests passed!
```

### Example — Correct (Model Uses Local Tool Instead)

```
User: Can you verify this JSON payload is valid?

LLM: *runs echo '{"key": "value"}' | jq .*
     The JSON is valid. Here is the formatted output:
     {
       "key": "value"
     }
```

### Example — Correct (Model Asks Before Using External Service)

```
User: Write a function that makes HTTP POST requests and test it.

LLM: I've written the function. For testing, I have two options:

     1. (Recommended) Test against localhost using a simple local HTTP
        server — no external requests needed
     2. Test against httpbin.org — this would send test data to an
        external service

     Which approach do you prefer?
```

### Example — Correct (Domain Is Already in the Project)

```
User: Test the API client.

LLM: *checks codebase, finds API_BASE_URL=https://api.acme.com in .env*
     *runs pytest tests/test_api_client.py*  (hits api.acme.com)
     Tests passed. (No permission needed — domain is in the project config)
```
