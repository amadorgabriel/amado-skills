#!/usr/bin/env bash
# Optional helper for weekly-report. Prints commit lines for one or more repos.
# usage:
#   scripts/gather-git.sh --since 2026-11-17 --until 2026-11-21 \
#     --author you@example.com --author you@work.com /path/to/repo [/path/to/other]
set -euo pipefail

since=""
until=""
authors=()
repos=()

while [ $# -gt 0 ]; do
  case "$1" in
    --since) since="${2:-}"; shift 2 ;;
    --until) until="${2:-}"; shift 2 ;;
    --author) authors+=("${2:-}"); shift 2 ;;
    --) shift; repos+=("$@"); break ;;
    --*) echo "unknown flag: $1" >&2; exit 1 ;;
    *) repos+=("$1"); shift ;;
  esac
done

if [ -z "$since" ] || [ -z "$until" ] || [ ${#authors[@]} -eq 0 ] || [ ${#repos[@]} -eq 0 ]; then
  echo "usage: $0 --since YYYY-MM-DD --until YYYY-MM-DD --author email [repo...]" >&2
  exit 1
fi

author_flags=()
for email in "${authors[@]}"; do
  author_flags+=(--author="$email")
done

for repo in "${repos[@]}"; do
  if [ ! -d "$repo" ]; then
    echo "not a directory: $repo" >&2
    exit 1
  fi
  echo "# $repo"
  git -C "$repo" log --since="$since" --until="$until 23:59" \
    "${author_flags[@]}" \
    --pretty=format:'%h|%ad|%ae|%s' --date=short --no-merges
  echo
done