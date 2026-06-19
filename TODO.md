# TODO

## Phase 1 — 0.2.0 hardening

### Dispatcher reliability

- [ ] Add dedicated dispatcher tests: before/after execution order, both naming
  formats (`<hook>.before`/`before.<hook>`, `<hook>.after`/`after.<hook>`),
  no-suffix default-to-after behaviour, exit code propagation, anti-recursion
  guard
- [ ] Identify the failing local hook in error output (e.g.
  `local hook .git/hooks/commit-msg.before exited 1`) instead of a bare exit
  code

---

## Future / Postponed

- [ ] `install.sh` safeguard: detect when a repository's local hook
  (`.git/hooks/<hook>`) resolves to a dispatcher stub and warn about the
  silent anti-recursion short-circuit
- [ ] Diagnostic command (e.g. `bin/hooks-status`) listing, for the current
  repository: active `core.hooksPath`, detected local hooks, and their
  resolved execution order

## Deferred / Under Consideration

- [ ] Additional qa-tools handlers beyond `commit-msg` (e.g. `pre-commit`,
  `pre-push`) — no concrete use case identified yet
