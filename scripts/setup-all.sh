#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$HOME/.bun/bin:$PATH"

log() { echo ""; echo "==> $*"; }

log "Prerequisites"
command -v node >/dev/null || { echo "Node.js required"; exit 1; }
command -v git >/dev/null || { echo "git required"; exit 1; }
command -v uvx >/dev/null || { echo "uvx required"; exit 1; }
if ! command -v bun >/dev/null 2>&1; then
  log "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  export PATH="$HOME/.bun/bin:$PATH"
fi

# --- 01 Superpowers ---
log "01-superpowers"
cd "$ROOT/01-superpowers"
mkdir -p .cursor/skills .cursor/rules vendor
if [[ ! -d vendor/superpowers/.git ]]; then
  git clone --depth 1 https://github.com/obra/superpowers.git vendor/superpowers
fi
rm -rf .cursor/skills/*
cp -R vendor/superpowers/skills/* .cursor/skills/

# --- 02 gstack ---
log "02-gstack"
cd "$ROOT/02-gstack"
mkdir -p .cursor/skills
if [[ ! -d .cursor/skills/gstack/.git ]]; then
  git clone --depth 1 https://github.com/garrytan/gstack.git .cursor/skills/gstack
fi
GSTACK="$ROOT/02-gstack/.cursor/skills/gstack"
(cd "$GSTACK" && ./setup --host claude --local --quiet)
(cd "$GSTACK" && bun run gen:skill-docs --host cursor)
PROJ_SKILLS="$ROOT/02-gstack/.cursor/skills"
if [[ -d "$GSTACK/.cursor/skills" ]]; then
  for d in "$GSTACK/.cursor/skills"/*; do
    name=$(basename "$d")
    [[ "$name" == "gstack" ]] && continue
    [[ -d "$d" ]] || continue
    rm -rf "$PROJ_SKILLS/$name"
    mv "$d" "$PROJ_SKILLS/$name"
  done
  rmdir "$GSTACK/.cursor/skills" 2>/dev/null || true
fi

# --- 03 Spec Kit ---
log "03-github-spec-kit"
cd "$ROOT/03-github-spec-kit"
uvx --from git+https://github.com/github/spec-kit.git specify init --here \
  --integration cursor-agent --force --ignore-agent-tools

# --- 04 GSD ---
log "04-gsd"
cd "$ROOT/04-gsd"
npx --yes @opengsd/gsd-core@latest --cursor --local

# --- 05 BMAD ---
log "05-bmad-method"
cd "$ROOT/05-bmad-method"
npx --yes bmad-method install --directory . --modules bmm --tools cursor --yes \
  --communication-language Vietnamese \
  --document-output-language Vietnamese \
  --output-folder _bmad-output

# --- 06 Awesome Toolkit ---
log "06-awesome-claude-code-toolkit"
cd "$ROOT/06-awesome-claude-code-toolkit"
mkdir -p .cursor/rules .cursor/commands vendor
if [[ ! -d vendor/toolkit/.git ]]; then
  git clone --depth 1 https://github.com/rohitg00/awesome-claude-code-toolkit.git vendor/toolkit
fi
cp vendor/toolkit/rules/*.md .cursor/rules/ 2>/dev/null || true
for cat in git testing architecture; do
  if [[ -d "vendor/toolkit/commands/$cat" ]]; then
    mkdir -p ".cursor/commands/$cat"
    cp -R "vendor/toolkit/commands/$cat/." ".cursor/commands/$cat/"
  fi
done

# --- 07 Ruflo ---
log "07-ruflo (MCP config in .cursor/mcp.json)"

log "Done. Run: bash scripts/verify.sh"
