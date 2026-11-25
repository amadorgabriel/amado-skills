#!/usr/bin/env bash
# Copies active skills from skills/ into Claude Code and Cursor user skills folders. Safe to re-run.
# Discovers promoted categories, in-progress/, and external/<author>/<skill>/. Skips _/ and deprecated/.
# usage:
#   scripts/install.sh [skill ...]
#   AGENTS=cursor scripts/install.sh lesson
set -euo pipefail

R="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_ROOT="$R/skills"
AGENTS_CSV="${AGENTS:-claude,cursor}"

declare -A SKILL_PATHS=()
declare -A SKILL_CATEGORIES=()

register_skill() {
  local name="$1"
  local category="$2"
  local dir="$3"
  if [ -n "${SKILL_PATHS[$name]:-}" ]; then
    echo "error: skill name collision for '$name': '${SKILL_PATHS[$name]}' conflicts with '$dir'" >&2
    exit 1
  fi
  SKILL_PATHS["$name"]="$dir"
  SKILL_CATEGORIES["$name"]="$category"
}

for category_dir in "$SKILLS_ROOT"/*; do
  [ -d "$category_dir" ] || continue
  category="$(basename "$category_dir")"
  case "$category" in _|deprecated) continue ;; esac
  if [ "$category" = "external" ]; then
    for author_dir in "$category_dir"/*; do
      [ -d "$author_dir" ] || continue
      author="$(basename "$author_dir")"
      [ "$author" = "_" ] && continue
      for skill_dir in "$author_dir"/*; do
        [ -d "$skill_dir" ] || continue
        name="$(basename "$skill_dir")"
        [ "$name" = "_" ] && continue
        [ -f "$skill_dir/SKILL.md" ] || continue
        register_skill "$name" "external/$author" "$skill_dir"
      done
    done
  else
    for skill_dir in "$category_dir"/*; do
      [ -d "$skill_dir" ] || continue
      name="$(basename "$skill_dir")"
      [ "$name" = "_" ] && continue
      [ -f "$skill_dir/SKILL.md" ] || continue
      register_skill "$name" "$category" "$skill_dir"
    done
  fi
done

if [ $# -eq 0 ]; then
  mapfile -t selected < <(printf '%s\n' "${!SKILL_PATHS[@]}" | sort)
else
  selected=()
  for arg in "$@"; do
    name="${arg##*/}"
    if [ -z "${SKILL_PATHS[$name]:-}" ]; then
      echo "no active skill named $arg" >&2
      exit 1
    fi
    selected+=("$name")
  done
fi

IFS=',' read -ra agent_list <<< "$AGENTS_CSV"
for agent in "${agent_list[@]}"; do
  case "$agent" in
    claude) dest_root="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}" ;;
    cursor) dest_root="${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}" ;;
    *) echo "unknown agent: $agent (expected claude or cursor)" >&2; exit 1 ;;
  esac
  mkdir -p "$dest_root"
  for s in "${selected[@]}"; do
    src="${SKILL_PATHS[$s]}"
    cat_label="${SKILL_CATEGORIES[$s]}"
    dst="$dest_root/$s"
    mkdir -p "$dst"
    if command -v rsync >/dev/null 2>&1; then
      rsync -a --exclude node_modules --exclude .venv --exclude __pycache__ --exclude _ --exclude output "$src/" "$dst/"
    else
      cp -R "$src/." "$dst/"
    fi
    echo "installed $s ($cat_label) -> $dst"
  done
done

echo "done: installed ${#selected[@]} skill(s) for $AGENTS_CSV"
