#!/usr/bin/env bash
# Copy stack-template-full into a new full-stack app folder.
# Usage: bash scripts/new-fullstack-project.sh [name] [target-dir]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NAME="${1:-app}"
TARGET="${2:-$PWD/$NAME}"

if [[ -e "$TARGET" ]]; then
  echo "Error: $TARGET already exists" >&2
  exit 1
fi

echo "Copying stack-template-full → $TARGET"
cp -R "$ROOT/stack-template-full" "$TARGET"

# Copy docs templates if running from 02-gstack
if [[ -d "$PWD/templates/docs" ]]; then
  mkdir -p "$TARGET/docs"
  cp -R "$PWD/templates/docs/." "$TARGET/docs/"
fi

# Placeholder image
if [[ -f "$PWD/assets/placeholders/placeholder.svg" ]]; then
  cp "$PWD/assets/placeholders/placeholder.svg" "$TARGET/client/public/images/placeholder.svg"
fi

echo "Next:"
echo "  cd $TARGET && npm install && npm run db:init && npm run dev"
