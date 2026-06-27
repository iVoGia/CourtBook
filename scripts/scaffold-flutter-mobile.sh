#!/usr/bin/env bash
# Scaffold Flutter mobile into an existing full-stack app folder.
# Usage: bash scripts/scaffold-flutter-mobile.sh [app-dir]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
APP_DIR="${1:-$PWD/app}"
MOBILE="$APP_DIR/mobile"

if [[ ! -d "$APP_DIR/client" || ! -d "$APP_DIR/server" ]]; then
  echo "Error: $APP_DIR must contain client/ and server/ — scaffold web first" >&2
  exit 1
fi

if [[ -e "$MOBILE" ]]; then
  echo "Error: $MOBILE already exists" >&2
  exit 1
fi

echo "Scaffolding Flutter → $MOBILE"
mkdir -p "$MOBILE"
cp -R "$ROOT/stack-template-flutter/." "$MOBILE/"

if command -v flutter &>/dev/null; then
  echo "Running flutter create for android/ios..."
  (cd "$MOBILE" && flutter create --org com.adaptbattle --project-name mobile . )
  (cd "$MOBILE" && flutter pub get)
else
  echo "Warning: flutter CLI not found. Install Flutter, then:"
  echo "  cd $MOBILE && flutter create --org com.adaptbattle --project-name mobile . && flutter pub get"
fi

echo ""
echo "Next:"
echo "  npm run dev   # from $APP_DIR (API :3001)"
echo "  cd $MOBILE && flutter run"
