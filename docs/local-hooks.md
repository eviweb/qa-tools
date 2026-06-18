# Local Hooks

qa-tools installs a global dispatcher for every git hook via `core.hooksPath`.
The dispatcher makes it possible to run per-repository hooks alongside the
global qa-tools hooks, with explicit control over execution order.

---

## How it works

For each git hook, the dispatcher runs:

```
[local before hook]   ← optional, per-repository
        ↓
[qa-tools global hook]  ← always (if a handler exists for this hook)
        ↓
[local after hook]    ← optional, per-repository
```

Local hooks live in the standard `.git/hooks/` directory of each repository.
The dispatcher reads them explicitly — git itself ignores `.git/hooks/` when
`core.hooksPath` is set.

---

## Naming convention

Two formats are accepted for each hook name. They are equivalent:

| Format | Example | Order |
|---|---|---|
| `<hook>.<position>` | `commit-msg.before` | before qa-tools |
| `<position>.<hook>` | `before.commit-msg` | before qa-tools |
| `<hook>.<position>` | `commit-msg.after` | after qa-tools |
| `<position>.<hook>` | `after.commit-msg` | after qa-tools |
| `<hook>` (no suffix) | `commit-msg` | **after** by default |

The `<hook>` form with no suffix groups naturally with the standard git hook
name. The `<position>.<hook>` form is useful when you want to gather all
before- or after-hooks together in a directory listing.

**Default when no suffix**: **after** — the qa-tools global hook validates first
(e.g. `commit-msg` runs `cog verify`), then the local hook extends or augments.

Both formats may coexist if needed:

```
.git/hooks/
├── commit-msg.before    runs first
├── commit-msg           runs after qa-tools (= after)
└── commit-msg.after     runs last
```

---

## Execution order (full chain)

```
commit-msg.before  / before.commit-msg   (1st)
        ↓
qa-tools commit-msg  (cog verify + insert-icon)
        ↓
commit-msg.after   / after.commit-msg    (2nd)
        ↓
commit-msg                               (3rd — no-suffix = after)
```

---

## Exit code propagation

Any hook that returns a non-zero exit code **stops the chain immediately**.
Subsequent hooks (including the qa-tools global hook) are not called.

This means a `before` hook can act as a guard: return non-zero to prevent the
global hook and all after hooks from running.

---

## Creating a local hook

1. Write the hook script in `.git/hooks/`:

   ```bash
   # .git/hooks/commit-msg.after
   #!/usr/bin/env bash
   set -euo pipefail

   msg_file="$1"
   # project-specific validation…
   ```

2. Make it executable:

   ```bash
   chmod +x .git/hooks/commit-msg.after
   ```

That is all. No registration or configuration needed — the dispatcher picks it
up automatically.

---

## Examples

### Run a project-specific linter before qa-tools validates the message

```bash
# .git/hooks/commit-msg.before
#!/usr/bin/env bash
set -euo pipefail
./scripts/lint-commit-msg.sh "$1"
```

### Notify a local webhook after a successful commit

```bash
# .git/hooks/post-commit
#!/usr/bin/env bash
curl -s -X POST http://localhost:9000/hooks/post-commit
```

### Enforce a branch naming convention before pushing

```bash
# .git/hooks/pre-push.before
#!/usr/bin/env bash
set -euo pipefail
branch="$(git symbolic-ref --short HEAD)"
if ! echo "${branch}" | grep -qE '^(feat|fix|chore|docs|test|release|hotfix)/'; then
    echo "Error: branch name '${branch}' does not follow the naming convention" >&2
    exit 1
fi
```

---

## Which hooks support local overrides

All 28 git hooks are handled by the dispatcher. Local before/after hooks can be
added for any of them. See [git-hooks-lifecycle.md](git-hooks-lifecycle.md) for
the full list and execution context of each hook.
