#!/usr/bin/env bash
# Bootstrap contest workflow assets into framework folders.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE="$ROOT/templates/contest-base"
OVERLAYS="$ROOT/templates/contest-overlays"

FOLDERS=(
  "01-superpowers:01-superpowers"
  "02-gstack:02-gstack"
  "03-github-spec-kit:03-github-spec-kit"
  "04-gsd:04-gsd"
  "05-bmad-method:05-bmad-method"
  "06-awesome-claude-code-toolkit:06-awesome-claude-code-toolkit"
  "07-ruflo:07-ruflo"
  "final-coffeeshop:final-coffeeshop"
)

bootstrap_folder() {
  local folder="$1"
  local overlay_key="$2"
  local dest="$ROOT/$folder"
  local overlay="$OVERLAYS/$overlay_key"

  if [[ ! -d "$dest" ]]; then
    echo "Skip $folder (not found)"
    return
  fi

  echo "→ $folder"

  for item in MASTER_PROMPT.md prompts presentation assets scripts; do
    if [[ -e "$BASE/$item" ]]; then
      cp -R "$BASE/$item" "$dest/"
    fi
  done

  # Merge CONTEST_WORKFLOW (python handles multiline framework steps)
  python3 - "$BASE" "$overlay" "$dest" <<'PY'
import sys
from pathlib import Path

base_dir, overlay_dir, dest_dir = map(Path, sys.argv[1:4])
workflow = (base_dir / "CONTEST_WORKFLOW.md").read_text(encoding="utf-8")
steps_file = overlay_dir / "framework-steps.md"
steps = steps_file.read_text(encoding="utf-8") if steps_file.exists() else ""
(dest_dir / "CONTEST_WORKFLOW.md").write_text(
    workflow.replace("{{FRAMEWORK_STEPS}}", steps), encoding="utf-8"
)
PY

  if [[ -f "$overlay/FRAMEWORK_CHECKLIST.md" ]]; then
    cp "$overlay/FRAMEWORK_CHECKLIST.md" "$dest/"
  fi

  if [[ -f "$overlay/BTC_SUBMISSION.md" ]]; then
    cp "$overlay/BTC_SUBMISSION.md" "$dest/"
  fi

  local fw_name="AI Framework"
  if [[ -f "$overlay/meta.env" ]]; then
    fw_name="$(python3 - "$overlay/meta.env" <<'PY'
import sys
from pathlib import Path
for line in Path(sys.argv[1]).read_text(encoding="utf-8").splitlines():
    if line.startswith("FRAMEWORK_NAME="):
        print(line.split("=", 1)[1].strip().strip('"').strip("'"))
        break
PY
)"
  fi

  python3 - "$dest/MASTER_PROMPT.md" "$fw_name" <<'PY'
import sys
from pathlib import Path
path, name = Path(sys.argv[1]), sys.argv[2]
path.write_text(path.read_text(encoding="utf-8").replace("{FRAMEWORK_NAME}", name), encoding="utf-8")
PY

  mkdir -p "$dest/presentation/screenshots"

  mkdir -p "$dest/scripts"
  cp "$ROOT/scripts/generate-pptx.py" "$dest/scripts/generate-pptx-core.py"
  cp "$BASE/scripts/generate-pptx.py" "$dest/scripts/generate-pptx.py"
  chmod +x "$dest/scripts/generate-pptx.py" 2>/dev/null || true
}

echo "=== Bootstrap contest workflow ==="
for entry in "${FOLDERS[@]}"; do
  folder="${entry%%:*}"
  overlay="${entry##*:}"
  bootstrap_folder "$folder" "$overlay"
done

echo ""
echo "Done. Run: bash scripts/verify.sh"
