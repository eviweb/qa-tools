#!/usr/bin/env bash
# Sourced by every hook stub. Sets up QA_TOOLS_BIN and provides dispatch().

_QA_DISPATCHER_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
_QA_TOOLS_HANDLERS_DIR="${_QA_DISPATCHER_DIR}/handlers"
# lib/ → hooks/ → git/ → src/ → qa-tools root
_QA_TOOLS_ROOT="$(dirname "$(dirname "$(dirname "$(dirname "${_QA_DISPATCHER_DIR}")")")")"
export QA_TOOLS_BIN="${_QA_TOOLS_ROOT}/bin"

# Run a local hook if it exists and is executable.
# Returns 0 if the hook is absent; propagates the hook's exit code otherwise.
_qa_run_local() {
    local h="${1}/${2}"
    shift 2
    if [[ -x "${h}" ]]; then
        "${h}" "$@"
    fi
}

# Orchestrate: local before → global handler → local after.
# $1 = hook name, remaining args forwarded to every hook.
dispatch() {
    local hook="$1"; shift

    local _git_dir
    _git_dir="$(git rev-parse --git-dir 2>/dev/null)" || _git_dir=""
    local _local_dir="${_git_dir:+${_git_dir}/hooks}"
    local _global_handler="${_QA_TOOLS_HANDLERS_DIR}/${hook}"

    if [[ -n "${_local_dir}" ]]; then
        _qa_run_local "${_local_dir}" "${hook}.before" "$@" || return $?
        _qa_run_local "${_local_dir}" "before.${hook}" "$@" || return $?
    fi

    if [[ -x "${_global_handler}" ]]; then
        "${_global_handler}" "$@" || return $?
    fi

    if [[ -n "${_local_dir}" ]]; then
        _qa_run_local "${_local_dir}" "${hook}.after" "$@" || return $?
        _qa_run_local "${_local_dir}" "after.${hook}" "$@" || return $?
        _qa_run_local "${_local_dir}" "${hook}" "$@"       || return $?
    fi
}
