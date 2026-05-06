#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_repo="${1:-}"

mkdir -p "${HOME}/.codex/skills/sub-powers-engineering"
cp "${repo_root}/skills/sub-powers-engineering/SKILL.md" "${HOME}/.codex/skills/sub-powers-engineering/SKILL.md"

if [[ -n "${target_repo}" ]]; then
  cp "${repo_root}/templates/codex/AGENTS.md" "${target_repo}/AGENTS.md"
  mkdir -p "${target_repo}/docs/tasks" "${target_repo}/logs"
  touch "${target_repo}/docs/tasks/.gitkeep" "${target_repo}/logs/.gitkeep"
fi

echo "Installed sub-powers-engineering Codex skill."
if [[ -n "${target_repo}" ]]; then
  echo "Installed AGENTS.md, docs/tasks, and logs into ${target_repo}."
else
  echo "Pass a repo path to also install the AGENTS.md template, for example:"
  echo "  ./install-codex.sh /path/to/your/repo"
fi
