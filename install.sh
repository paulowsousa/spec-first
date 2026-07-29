#!/usr/bin/env bash
# Install the spec-first skill for Claude Code.
#   ./install.sh          -> installs globally to ~/.claude/skills
#   ./install.sh --local  -> installs to ./.claude/skills in the current project

set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills/spec-first"

if [[ "${1:-}" == "--local" ]]; then
  DEST="$(pwd)/.claude/skills"
else
  DEST="$HOME/.claude/skills"
fi

if [[ ! -d "$SRC" ]]; then
  echo "error: skill source not found at $SRC" >&2
  exit 1
fi

mkdir -p "$DEST"
cp -r "$SRC" "$DEST/"

echo "Installed spec-first to $DEST/spec-first"
echo "Restart Claude Code to pick it up."
