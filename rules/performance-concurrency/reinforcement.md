# Performance & Concurrency — Reinforcement

**CRITICAL RULE**: When processing many items with network I/O sequentially, you MUST use multithreading to parallelize. Sequential network-bound processing is a performance anti-pattern.

**Process**:
1. DETECT — flag loops with network I/O as parallelization candidates
2. ASSESS — determine if items are independent
3. IMPLEMENT — use ThreadPoolExecutor or equivalent
4. CONFIGURE — configurable max_workers (default 10), thread-safe shared resources, timeouts on ALL network calls
5. ORDER — collect results and process in original order

**Self-Check**: If about to write a for loop with network calls inside without parallelization — STOP and refactor to use ThreadPoolExecutor.

**Timeouts**: Auth/API calls: 30s. Large downloads: 60s. NEVER omit timeout.

**Violations**: Sequential loops with network calls, no timeouts on requests, hardcoded worker counts, non-thread-safe shared resources, ignoring parallelization "because list is small".
