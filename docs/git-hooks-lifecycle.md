# Git Hooks — Lifecycle Reference

Complete reference of all git hooks and their execution order within each git operation.

---

## Hook index

| Hook | Side | Aborts on failure |
|---|---|---|
| `applypatch-msg` | client | yes |
| `pre-applypatch` | client | yes |
| `post-applypatch` | client | no |
| `pre-commit` | client | yes |
| `pre-merge-commit` | client | yes |
| `prepare-commit-msg` | client | yes |
| `commit-msg` | client | yes |
| `post-commit` | client | no |
| `pre-rebase` | client | yes |
| `post-checkout` | client | no |
| `post-merge` | client | no |
| `pre-push` | client | yes |
| `pre-receive` | server | yes |
| `update` | server | yes (per ref) |
| `proc-receive` | server | yes (per ref) |
| `post-receive` | server | no |
| `post-update` | server | no |
| `reference-transaction` | client/server | no |
| `push-to-checkout` | server | yes |
| `pre-auto-gc` | client | yes |
| `post-rewrite` | client | no |
| `sendemail-validate` | client | yes |
| `fsmonitor-watchman` | client | — |
| `p4-changelist` | client (P4) | yes |
| `p4-prepare-changelist` | client (P4) | yes |
| `p4-post-changelist` | client (P4) | no |
| `p4-pre-submit` | client (P4) | yes |
| `post-index-change` | client | no |

---

## Execution order by operation

### `git commit`

```
pre-commit
    ↓
prepare-commit-msg
    ↓
commit-msg
    ↓
post-commit
```

`pre-commit`: validates the working tree before the message is written (linting,
tests, etc.). Skipped with `--no-verify`.

`prepare-commit-msg`: receives the message file path, the message source
(`message`, `template`, `merge`, `squash`, `commit`), and optionally the commit
SHA. Runs before the editor opens.

`commit-msg`: receives the path to the temporary message file. Validates or
rewrites the final message.

`post-commit`: notification only. No arguments.

---

### `git commit --amend`

Same chain as `git commit`, then:

```
post-rewrite  (argument: amend)
```

---

### `git merge` (with merge commit)

```
pre-commit
    ↓
pre-merge-commit
    ↓
prepare-commit-msg  (source: merge)
    ↓
commit-msg
    ↓
post-merge          (argument: 0 = no squash)
```

`pre-merge-commit`: runs only when a merge commit is created (not fast-forward).
Skipped with `--no-verify`.

`post-merge`: also runs after `git pull` when a merge commit is created.
Receives `1` if squash merge, `0` otherwise.

---

### `git checkout` / `git switch`

```
post-checkout  (prev HEAD, new HEAD, branch flag)
```

Receives three arguments: previous HEAD ref, new HEAD ref, and `1` if switching
branches / `0` if restoring files.

Also triggered by `git clone` and during `git rebase`.

---

### `git rebase`

```
pre-rebase
    ↓
post-checkout     (when switching to the rebase working branch)
    ↓
[for each replayed commit]
    pre-commit
    prepare-commit-msg
    commit-msg
    post-commit
    ↓
post-checkout     (when switching back to the rebased branch)
    ↓
post-rewrite      (argument: rebase)
```

`pre-rebase`: receives the upstream and the rebased branch (empty if current).
Return non-zero to abort.

`post-rewrite`: called once after all commits have been rewritten. Receives the
command that triggered the rewrite (`rebase` or `amend`) and on stdin the list
of old→new SHA pairs.

---

### `git am` (apply mailbox patches)

Runs for each patch in the mailbox:

```
applypatch-msg   (path to proposed commit message file)
    ↓
pre-applypatch
    ↓
[patch applied]
    ↓
post-applypatch
```

---

### `git push` (client side)

```
pre-push  (remote name, remote URL)
```

Receives on stdin the list of refs being pushed (`local_ref local_sha remote_ref
remote_sha`). Return non-zero to abort the push.

---

### `git push` (server side — receive)

```
pre-receive                    (stdin: old new refname per ref)
    ↓
[for each updated ref]
    update       (refname, old SHA, new SHA)
    proc-receive (refname, old SHA, new SHA)  ← custom ref processing
    ↓
post-receive                   (stdin: old new refname per ref)
    ↓
[for each updated ref]
    post-update  (refname …)
    ↓
push-to-checkout               (new SHA)  ← if pushing to checked-out branch
```

`pre-receive`: runs once before any ref is updated. Non-zero aborts all updates.

`update`: runs once per ref. Non-zero rejects only that ref.

`proc-receive`: optional custom handler for refs outside `refs/heads/` and
`refs/tags/` (e.g. `refs/for/`). Used by Gerrit-style workflows.

`push-to-checkout`: replaces the default behaviour of `git checkout` when a push
arrives on the currently checked-out branch of a non-bare repository.

---

### `git gc --auto`

```
pre-auto-gc
```

Return non-zero to cancel automatic garbage collection.

---

### `git send-email`

```
sendemail-validate  (path to email file)
```

Runs once per email before sending. Return non-zero to abort.

---

### Reference transactions

```
reference-transaction  (state: prepared | committed | aborted)
```

Runs at each state change of a reference transaction. Receives on stdin the list
of affected refs (`old new refname`). Informational; non-zero exit is ignored
after `committed`.

---

### Index changes

```
post-index-change
```

Runs after the index is written. Receives two arguments: `1` if the working
directory was also updated, `1` if a skip-worktree bit change triggered the
call.

---

### Filesystem monitoring

```
fsmonitor-watchman
```

Called by git to query the filesystem monitor for changed files since a given
time. Not a user hook in the usual sense — configured via `core.fsmonitor`.

---

### Perforce integration (p4)

```
p4-pre-submit
    ↓
p4-prepare-changelist  (changelist number, source)
    ↓
p4-changelist          (changelist number)
    ↓
[submitted]
    ↓
p4-post-changelist
```

`p4-pre-submit`: runs before `git p4 submit`. No arguments.

`p4-prepare-changelist`: runs after the default changelist message is prepared.
Receives the changelist number and the source (`message`, `template`, `import`,
`branch`, `merge`).

`p4-changelist`: runs after the changelist message is edited. Receives the
changelist number. Return non-zero to abort.

`p4-post-changelist`: notification after the changelist is submitted. No
arguments.

---

## Reference

- [githooks(5)](https://git-scm.com/docs/githooks) — official git documentation
