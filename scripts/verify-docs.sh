#!/usr/bin/env bash
# Verify docs/api-spec.md routes match server implementation.
# Usage: bash scripts/verify-docs.sh [app-dir]
set -euo pipefail

APP_DIR="${1:-${PWD}/app}"
SPEC="$APP_DIR/docs/api-spec.md"
SERVER_ROUTES="$APP_DIR/server/src"

if [[ ! -f "$SPEC" ]]; then
  echo "FAIL: missing $SPEC" >&2
  exit 1
fi

if [[ ! -d "$SERVER_ROUTES" ]]; then
  echo "FAIL: missing server src at $SERVER_ROUTES" >&2
  exit 1
fi

PASS=0
FAIL=0
WARN=0

warn() { echo "  WARN $*"; WARN=$((WARN + 1)); }
ok()   { echo "  OK   $*"; PASS=$((PASS + 1)); }
fail() { echo "  FAIL $*"; FAIL=$((FAIL + 1)); }

SPEC_ROUTES_FILE=$(mktemp)
SERVER_ROUTES_FILE=$(mktemp)
trap 'rm -f "$SPEC_ROUTES_FILE" "$SERVER_ROUTES_FILE"' EXIT

echo "=== verify-docs: $APP_DIR ==="
echo ""

# api-spec: ### GET /path (skip {placeholders})
grep -E '^### (GET|POST|PUT|PATCH|DELETE) ' "$SPEC" 2>/dev/null \
  | awk '{print tolower($2), $3}' \
  | grep -v '{' \
  | sort -u > "$SPEC_ROUTES_FILE" || true

# server: router.get('/path'
grep -rhoE "router\.(get|post|put|patch|delete)\(['\"][^'\"]+['\"]" "$SERVER_ROUTES" 2>/dev/null \
  | sed -E "s/router\.(get|post|put|patch|delete)\(['\"]([^'\"]+)['\"]/\1 \2/" \
  | sort -u > "$SERVER_ROUTES_FILE" || true

echo "Routes in api-spec.md (concrete):"
if [[ ! -s "$SPEC_ROUTES_FILE" ]]; then
  warn "No concrete routes in api-spec — replace {placeholders}"
else
  sed 's/^/    /' "$SPEC_ROUTES_FILE"
fi
echo ""
echo "Routes in server:"
if [[ ! -s "$SERVER_ROUTES_FILE" ]]; then
  fail "No router.* routes under $SERVER_ROUTES"
else
  sed 's/^/    /' "$SERVER_ROUTES_FILE"
fi
echo ""

while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  method=$(echo "$line" | awk '{print $1}')
  path=$(echo "$line" | awk '{print $2}')
  method_up=$(echo "$method" | tr '[:lower:]' '[:upper:]')
  if grep -qFx "${method} ${path}" "$SPEC_ROUTES_FILE" 2>/dev/null; then
    ok "spec documents ${method_up} ${path}"
  else
    fail "server ${method_up} ${path} missing from api-spec.md"
  fi
done < "$SERVER_ROUTES_FILE"

while IFS= read -r line; do
  [[ -z "$line" ]] && continue
  method=$(echo "$line" | awk '{print $1}')
  path=$(echo "$line" | awk '{print $2}')
  method_up=$(echo "$method" | tr '[:lower:]' '[:upper:]')
  if ! grep -qFx "${method} ${path}" "$SERVER_ROUTES_FILE" 2>/dev/null; then
    warn "api-spec ${method_up} ${path} has no server route yet"
  fi
done < "$SPEC_ROUTES_FILE"

echo ""
echo "Governance docs:"
for f in BA_BRIEF.md PRD.md api-spec.md TRACEABILITY.md WORKFLOW_MANIFEST.md; do
  if [[ -f "$APP_DIR/docs/$f" ]]; then ok "docs/$f"; else fail "docs/$f missing"; fi
done
for f in QA_REPORT.md HANDOFF.md WORKFLOW_SCORECARD.md; do
  if [[ -f "$APP_DIR/docs/$f" ]]; then ok "docs/$f"; else warn "docs/$f missing (fill before handoff)"; fi
done

echo ""
echo "=== Summary: $PASS passed, $FAIL failed, $WARN warnings ==="
[[ "$FAIL" -eq 0 ]]
