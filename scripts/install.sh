#!/usr/bin/env bash
# Installs this repo's plugins and loose skills for Claude Code and Cursor. Safe to re-run.
# Plugins (plugins/<plugin>/) go to ~/.cursor/plugins/local/<plugin> for Cursor; Claude Code installs them
# from the marketplace (/plugin marketplace add amadorgabriel/amado-skills), so only a hint is printed.
# Loose skills (skills/in-progress/<skill>, skills/external/<author>/<skill>) are flattened into
# ~/.claude/skills and ~/.cursor/skills. Skips _/ and deprecated/. Fails on skill name collisions.
# usage:
#   scripts/install.sh [plugin-or-skill ...]
#   AGENTS=cursor scripts/install.sh job
set -euo pipefail

R="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_ROOT="$R/skills"
PLUGINS_ROOT="$R/plugins"
AGENTS_CSV="${AGENTS:-claude,cursor}"

declare -A SKILL_PATHS=()
declare -A SKILL_LABELS=()
declare -A PLUGIN_PATHS=()
declare -A PLUGIN_SKILLS=()

register_skill() {
  local name="$1" label="$2" dir="$3"
  if [ -n "${SKILL_PATHS[$name]:-}" ] || [ -n "${PLUGIN_SKILLS[$name]:-}" ]; then
    echo "error: skill name collision for '$name': '${SKILL_PATHS[$name]:-plugin ${PLUGIN_SKILLS[$name]:-}}' conflicts with '$dir'" >&2
    exit 1
  fi
  SKILL_PATHS["$name"]="$dir"
  SKILL_LABELS["$name"]="$label"
}

for plugin_dir in "$PLUGINS_ROOT"/*; do
  [ -f "$plugin_dir/.cursor-plugin/plugin.json" ] || continue
  plugin="$(basename "$plugin_dir")"
  PLUGIN_PATHS["$plugin"]="$plugin_dir"
  for skill_dir in "$plugin_dir"/skills/*; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    name="$(basename "$skill_dir")"
    if [ -n "${PLUGIN_SKILLS[$name]:-}" ]; then
      echo "error: skill name collision for '$name': plugins '${PLUGIN_SKILLS[$name]}' and '$plugin' both ship it" >&2
      exit 1
    fi
    PLUGIN_SKILLS["$name"]="$plugin"
  done
done

for bucket_dir in "$SKILLS_ROOT"/*; do
  [ -d "$bucket_dir" ] || continue
  bucket="$(basename "$bucket_dir")"
  case "$bucket" in _|deprecated) continue ;; esac
  if [ "$bucket" = "external" ]; then
    for author_dir in "$bucket_dir"/*; do
      [ -d "$author_dir" ] || continue
      author="$(basename "$author_dir")"
      [ "$author" = "_" ] && continue
      for skill_dir in "$author_dir"/*; do
        [ -f "$skill_dir/SKILL.md" ] || continue
        name="$(basename "$skill_dir")"
        [ "$name" = "_" ] && continue
        register_skill "$name" "external/$author" "$skill_dir"
      done
    done
  else
    for skill_dir in "$bucket_dir"/*; do
      [ -f "$skill_dir/SKILL.md" ] || continue
      name="$(basename "$skill_dir")"
      [ "$name" = "_" ] && continue
      register_skill "$name" "$bucket" "$skill_dir"
    done
  fi
done

selected_plugins=()
selected_skills=()
if [ $# -eq 0 ]; then
  mapfile -t selected_plugins < <(printf '%s\n' "${!PLUGIN_PATHS[@]}" | sort)
  mapfile -t selected_skills < <(printf '%s\n' "${!SKILL_PATHS[@]}" | sort)
else
  for arg in "$@"; do
    name="${arg##*/}"
    if [ -n "${PLUGIN_PATHS[$name]:-}" ]; then
      selected_plugins+=("$name")
    elif [ -n "${SKILL_PATHS[$name]:-}" ]; then
      selected_skills+=("$name")
    elif [ -n "${PLUGIN_SKILLS[$name]:-}" ]; then
      echo "'$name' ships inside plugin '${PLUGIN_SKILLS[$name]}'. Install the plugin instead: scripts/install.sh ${PLUGIN_SKILLS[$name]}" >&2
      exit 1
    else
      echo "no plugin or skill named $arg" >&2
      exit 1
    fi
  done
fi

copy_tree() {
  local src="$1" dst="$2" mirror="${3:-}"
  mkdir -p "$dst"
  if command -v rsync >/dev/null 2>&1; then
    rsync -a ${mirror:+--delete} --exclude node_modules --exclude .venv --exclude __pycache__ --exclude _ --exclude output "$src/" "$dst/"
  else
    [ -n "$mirror" ] && rm -rf "$dst" && mkdir -p "$dst"
    cp -R "$src/." "$dst/"
  fi
}

cursor_plugins_dir="${CURSOR_PLUGINS_DIR:-$HOME/.cursor/plugins/local}"
IFS=',' read -ra agent_list <<< "$AGENTS_CSV"
for agent in "${agent_list[@]}"; do
  case "$agent" in
    claude) dest_root="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}" ;;
    cursor) dest_root="${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}" ;;
    *) echo "unknown agent: $agent (expected claude or cursor)" >&2; exit 1 ;;
  esac

  if [ "$agent" = "cursor" ]; then
    for p in "${selected_plugins[@]}"; do
      copy_tree "${PLUGIN_PATHS[$p]}" "$cursor_plugins_dir/$p" mirror
      echo "installed plugin $p -> $cursor_plugins_dir/$p"
    done
  elif [ ${#selected_plugins[@]} -gt 0 ]; then
    echo "claude: install plugins from the marketplace: /plugin marketplace add amadorgabriel/amado-skills, then /plugin install <plugin>@amadorgabriel (${selected_plugins[*]})"
  fi

  mkdir -p "$dest_root"
  for s in "${selected_skills[@]}"; do
    copy_tree "${SKILL_PATHS[$s]}" "$dest_root/$s"
    echo "installed $s (${SKILL_LABELS[$s]}) -> $dest_root/$s"
  done

  for name in "${!PLUGIN_SKILLS[@]}"; do
    if [ -f "$dest_root/$name/SKILL.md" ]; then
      echo "warning: $dest_root/$name is an old loose copy of a skill now shipped by plugin '${PLUGIN_SKILLS[$name]}'. Delete it to avoid duplicates." >&2
    fi
  done
done

if [ ${#selected_plugins[@]} -gt 0 ] && [[ ",$AGENTS_CSV," == *",cursor,"* ]]; then
  echo "cursor: reload the window (Developer: Reload Window) to load local plugins"
fi
echo "done: ${#selected_plugins[@]} plugin(s), ${#selected_skills[@]} skill(s) for $AGENTS_CSV"
