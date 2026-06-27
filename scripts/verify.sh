#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0
FAIL=0

check() {
  local name="$1"
  local path="$2"
  if [[ -e "$path" ]]; then
    echo "  OK  $name"
    PASS=$((PASS + 1))
  else
    echo "  FAIL $name ($path)"
    FAIL=$((FAIL + 1))
  fi
}

check_contest() {
  local folder="$1"
  echo ""
  echo "$folder (contest)"
  check "CONTEST_WORKFLOW" "$ROOT/$folder/CONTEST_WORKFLOW.md"
  check "MASTER_PROMPT" "$ROOT/$folder/MASTER_PROMPT.md"
  check "FRAMEWORK_CHECKLIST" "$ROOT/$folder/FRAMEWORK_CHECKLIST.md"
  check "prompts/kickoff" "$ROOT/$folder/prompts/01-kickoff.md"
  check "prompts/presentation" "$ROOT/$folder/prompts/04-presentation-agent.md"
  check "ui-kit" "$ROOT/$folder/assets/ui-kit.md"
  check "pptx script" "$ROOT/$folder/scripts/generate-pptx.py"
  check "slide template" "$ROOT/$folder/presentation/template-slides.json"
}

echo "=== Verify AllIn_06 frameworks ==="
echo ""

echo "01-superpowers"
check "skills" "$ROOT/01-superpowers/.cursor/skills/brainstorming"
check "rules" "$ROOT/01-superpowers/.cursor/rules/superpowers.mdc"
check "START_HERE" "$ROOT/01-superpowers/START_HERE.md"
check_contest "01-superpowers"

echo ""
echo "02-gstack"
check "gstack source" "$ROOT/02-gstack/.cursor/skills/gstack"
check "office-hours skill" "$ROOT/02-gstack/.cursor/skills/gstack-office-hours"
check "browse binary" "$ROOT/02-gstack/.cursor/skills/gstack/browse/dist/browse"
check "START_HERE" "$ROOT/02-gstack/START_HERE.md"
check_contest "02-gstack"
echo ""
echo "02-gstack (battle pipeline)"
check "SPORT_BOOKING_SPEC" "$ROOT/02-gstack/SPORT_BOOKING_SPEC.md"
check "CUSTOM_FRAMEWORK" "$ROOT/02-gstack/CUSTOM_FRAMEWORK.md"
check "REHEARSE" "$ROOT/02-gstack/REHEARSE.md"
check "design-system prompt" "$ROOT/02-gstack/prompts/02-design-system.md"
check "build-design-led prompt" "$ROOT/02-gstack/prompts/03-build-design-led.md"
check "presentation-gstack prompt" "$ROOT/02-gstack/prompts/04-presentation-gstack.md"
check "gstack 5min template" "$ROOT/02-gstack/presentation/template-slides-gstack-5min.json"
check "SPEAKER_SCRIPT" "$ROOT/02-gstack/presentation/SPEAKER_SCRIPT.md"
check "gstack-battle rule" "$ROOT/02-gstack/.cursor/rules/gstack-battle.mdc"
check "eng-docs prompt" "$ROOT/02-gstack/prompts/02b-eng-and-docs.md"
check "ba-analysis prompt" "$ROOT/02-gstack/prompts/01b-ba-analysis.md"
check "flutter-gate prompt" "$ROOT/02-gstack/prompts/03c-flutter-gate.md"
check "flutter-build prompt" "$ROOT/02-gstack/prompts/03d-flutter-build.md"
check "designer-agent rule" "$ROOT/02-gstack/.cursor/rules/designer-agent.mdc"
check "BA_BRIEF template" "$ROOT/02-gstack/templates/docs/BA_BRIEF.md"
check "DEMO_ACCOUNTS template" "$ROOT/02-gstack/templates/docs/DEMO_ACCOUNTS.md"
check "docs templates" "$ROOT/02-gstack/templates/docs/PRD.md"
check "stack-template-full" "$ROOT/stack-template-full/package.json"
check "stack-template-flutter" "$ROOT/stack-template-flutter/pubspec.yaml"
check "new-fullstack-project" "$ROOT/scripts/new-fullstack-project.sh"
check "scaffold-flutter-mobile" "$ROOT/scripts/scaffold-flutter-mobile.sh"
check "verify-docs script" "$ROOT/scripts/verify-docs.sh"
check "handoff prompt" "$ROOT/02-gstack/prompts/03e-handoff-scorecard.md"
check "WORKFLOW_MANIFEST template" "$ROOT/02-gstack/templates/docs/WORKFLOW_MANIFEST.md"
check "TRACEABILITY template" "$ROOT/02-gstack/templates/docs/TRACEABILITY.md"
check "QA_REPORT template" "$ROOT/02-gstack/templates/docs/QA_REPORT.md"
check "HANDOFF template" "$ROOT/02-gstack/templates/docs/HANDOFF.md"
check "WORKFLOW_SCORECARD template" "$ROOT/02-gstack/templates/docs/WORKFLOW_SCORECARD.md"
check "FRAMEWORK_EVIDENCE template" "$ROOT/02-gstack/templates/docs/FRAMEWORK_EVIDENCE/README.md"

echo ""
echo "03-github-spec-kit"
check ".specify" "$ROOT/03-github-spec-kit/.specify"
check "constitution" "$ROOT/03-github-spec-kit/.specify/memory/constitution.md"
check "speckit skills" "$ROOT/03-github-spec-kit/.cursor/skills"
check "START_HERE" "$ROOT/03-github-spec-kit/START_HERE.md"
check_contest "03-github-spec-kit"

echo ""
echo "04-gsd"
check ".cursor" "$ROOT/04-gsd/.cursor"
check "START_HERE" "$ROOT/04-gsd/START_HERE.md"
check_contest "04-gsd"

echo ""
echo "05-bmad-method"
check "_bmad" "$ROOT/05-bmad-method/_bmad"
check ".agents/skills" "$ROOT/05-bmad-method/.agents/skills"
check "START_HERE" "$ROOT/05-bmad-method/START_HERE.md"
check_contest "05-bmad-method"

echo ""
echo "06-awesome-claude-code-toolkit"
check "rules" "$ROOT/06-awesome-claude-code-toolkit/.cursor/rules"
check "commands" "$ROOT/06-awesome-claude-code-toolkit/.cursor/commands/git"
check "START_HERE" "$ROOT/06-awesome-claude-code-toolkit/START_HERE.md"
check_contest "06-awesome-claude-code-toolkit"

echo ""
echo "07-ruflo"
check "mcp.json" "$ROOT/07-ruflo/.cursor/mcp.json"
check "START_HERE" "$ROOT/07-ruflo/START_HERE.md"
check_contest "07-ruflo"

echo ""
echo "final-coffeeshop"
check "spec kit" "$ROOT/final-coffeeshop/.specify"
check "BA PRD" "$ROOT/final-coffeeshop/docs/ba/PRD.md"
check "server" "$ROOT/final-coffeeshop/server/src/index.ts"
check "client" "$ROOT/final-coffeeshop/client/src/App.tsx"
check "db seed" "$ROOT/final-coffeeshop/server/src/db/seed.sql"
check "BTC submission" "$ROOT/final-coffeeshop/BTC_SUBMISSION.md"
check_contest "final-coffeeshop"

echo ""
echo "shared"
check "stack-template" "$ROOT/stack-template/package.json"
check "stack-template-full" "$ROOT/stack-template-full/package.json"
check "generate-pptx" "$ROOT/scripts/generate-pptx.py"
check "bootstrap-contest" "$ROOT/scripts/bootstrap-contest.sh"
check "new-project" "$ROOT/scripts/new-project.sh"
check "new-fullstack-project" "$ROOT/scripts/new-fullstack-project.sh"

if python3 -c "import pptx" 2>/dev/null; then
  echo "  OK  python-pptx"
  PASS=$((PASS + 1))
else
  echo "  FAIL python-pptx (run: python3 -m pip install -r requirements-pptx.txt)"
  FAIL=$((FAIL + 1))
fi

echo ""
echo "=== Summary: $PASS passed, $FAIL failed ==="
[[ "$FAIL" -eq 0 ]]
