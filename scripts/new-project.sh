#!/usr/bin/env bash
# Copy stack-template into a new app folder.
# Usage: bash scripts/new-project.sh [name] [target-dir]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NAME="${1:-app}"
TARGET="${2:-$PWD/$NAME}"

if [[ -e "$TARGET" ]]; then
  echo "Error: $TARGET already exists" >&2
  exit 1
fi

echo "Copying stack-template → $TARGET"
cp -R "$ROOT/stack-template" "$TARGET"

# Copy placeholder to public if assets exist in parent contest folder
if [[ -f "$PWD/assets/placeholders/placeholder.svg" ]]; then
  cp "$PWD/assets/placeholders/placeholder.svg" "$TARGET/public/images/placeholder.svg"
fi

echo "Run: cd $TARGET && npm install && npm run dev"
