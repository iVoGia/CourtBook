#!/usr/bin/env python3
"""Wrapper: generate presentation/output.pptx from this folder."""
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
REPO_ROOT = ROOT.parent if (ROOT.parent / "scripts" / "generate-pptx.py").exists() else ROOT

script = REPO_ROOT / "scripts" / "generate-pptx.py"
if not script.exists():
    script = Path(__file__).resolve().parent / "generate-pptx-core.py"

result = subprocess.run(
    [sys.executable, str(script), str(ROOT)],
    cwd=str(ROOT),
)
sys.exit(result.returncode)
