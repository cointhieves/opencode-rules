## Performance & Concurrency

**CRITICAL RULE**: When a script or service processes many items sequentially and each item involves network I/O (API calls, file downloads, HTTP requests), you MUST suggest and use multithreading to parallelize the I/O-bound work. Sequential processing of network-bound tasks is a performance anti-pattern — ALWAYS look for opportunities to parallelize.

### Mandatory Process

1. **DETECT** — When writing or reviewing code that processes items in a loop with network I/O, flag it as a parallelization candidate
2. **ASSESS** — Determine if items are independent (no dependencies between iterations)
3. **IMPLEMENT** — Use `concurrent.futures.ThreadPoolExecutor` (Python) or equivalent for the target language
4. **CONFIGURE** — Add configurable `max_workers` (default 10), thread-safe shared resources, and timeouts on all network calls
5. **ORDER** — Collect results from threads and process in original order to maintain deterministic behavior

### Standard Pattern (Python)

Use `concurrent.futures.ThreadPoolExecutor` with the following conventions:

- Use a configurable `max_workers` setting (default 10) so operators can tune per environment
- Make shared resources (auth tokens, database connections) thread-safe using `threading.Lock` with double-checked locking
- Download/fetch in parallel, but keep downstream writes (database inserts, API posts, file writes) sequential to avoid overwhelming targets or creating race conditions
- Collect results from threads and process them in the original order to maintain deterministic behavior

```python
import threading
from concurrent.futures import ThreadPoolExecutor, as_completed

self._auth_lock = threading.Lock()
self.max_workers = self.config.get("max_workers", 10)

workers = min(self.max_workers, len(items))
with ThreadPoolExecutor(max_workers=workers) as executor:
    future_to_item = {executor.submit(self._process_item, item): item for item in items}
    result_map = {}
    for future in as_completed(future_to_item):
        item_id, result = future.result()
        result_map[item_id] = result

# Process results in original order
for item in items:
    result = result_map.get(item.id)
    self.send_results(result)  # sequential
```

### Self-Check

If you are about to write or approve a `for` loop that makes network calls (HTTP requests, API calls, database queries) inside the loop body without parallelization, you are VIOLATING this rule. STOP and refactor to use ThreadPoolExecutor or equivalent.

### When This Rule Applies

This rule is triggered when ANY of the following occur:
- Processing lists of API responses one at a time
- Downloading multiple files or reports sequentially
- Making independent HTTP requests in a loop
- Any batch operation where items don't depend on each other
- Writing a script that fetches data from multiple endpoints
- Implementing a data pipeline that processes items from a queue

### When NOT to Use Multithreading

- CPU-bound work (use multiprocessing instead)
- When items depend on previous results (sequential by nature)
- When the target system can't handle concurrent requests (rate-limited APIs without retry logic)

### Violations

The following are VIOLATIONS of this rule:
- Writing a sequential loop with network calls without mentioning parallelization
- Not adding `timeout` to `requests.get()`/`requests.post()` calls
- Using hardcoded worker counts instead of configurable `max_workers`
- Not making shared resources thread-safe
- Processing results out of order without good reason
- Ignoring parallelization opportunity "because the list is small" (lists grow)

### Timeout Requirements

ALWAYS add `timeout` to all network calls:
- Auth/API calls: 30 seconds
- Large downloads: 60 seconds
- Never omit timeout — this prevents indefinite hangs that block cron schedules or CI pipelines
