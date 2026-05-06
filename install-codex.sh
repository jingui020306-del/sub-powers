#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_repo="${1:-}"

for skill_dir in "${repo_root}"/skills/sub-powers-*; do
  skill_name="$(basename "${skill_dir}")"
  mkdir -p "${HOME}/.codex/skills/${skill_name}"
  cp "${skill_dir}/SKILL.md" "${HOME}/.codex/skills/${skill_name}/SKILL.md"
done

if [[ -n "${target_repo}" ]]; then
  cp "${repo_root}/templates/codex/AGENTS.md" "${target_repo}/AGENTS.md"
  mkdir -p "${target_repo}/docs/tasks" "${target_repo}/logs"
  touch "${target_repo}/docs/tasks/.gitkeep" "${target_repo}/logs/.gitkeep"
fi

echo "Installed Sub-Powers Codex skills."
if [[ -n "${target_repo}" ]]; then
  echo "Installed AGENTS.md, docs/tasks, and logs into ${target_repo}."
else
  echo "Pass a repo path to also install the AGENTS.md template, for example:"
  echo "  ./install-codex.sh /path/to/your/repo"
fi
