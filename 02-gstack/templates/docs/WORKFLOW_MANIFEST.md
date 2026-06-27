# Workflow Manifest — {PROJECT_NAME}

> 1 trang map pipeline → artifact. Copy từ [`CUSTOM_FRAMEWORK.md`](../../CUSTOM_FRAMEWORK.md) khi điền.

## Framework

- **Base:** gstack (virtual engineering team + skills)
- **Custom:** Role Council + Full-Stack + Flutter Gate

## Pipeline

```
office-hours → BA → Designer → plan-eng-review → plan-design-review
  → docs/ → scaffold → build web → QA → [Flutter gate] → HANDOFF + PPTX
```

## Role → Output

| Phase | Role | Skill / prompt | Artifact |
|-------|------|----------------|----------|
| 0 | All | MASTER_PROMPT + kickoff | Session |
| 1 | CEO | `/office-hours` | MVP sketch |
| 2 | BA | `01b-ba-analysis` | `BA_BRIEF.md` |
| 3 | Designer | `/design-consultation` | `DESIGN.md` |
| 4 | Designer | `/plan-design-review` | UI gate ≥8/10 |
| 5 | Eng | `/plan-eng-review` | api-spec + schema |
| 6 | Docs | `02b-eng-and-docs` | `docs/*` |
| 7 | Build | `03-build-design-led` | client + server |
| 8 | QA | `03-qa` | `QA_REPORT.md` |
| 9 | Mobile* | `03d-flutter-build` | `mobile/` |
| 10 | Handoff | end of session | `HANDOFF.md` |

\*Optional after Flutter gate YES.

## Definition of Done (DoD)

- [ ] `BA_BRIEF.md` + `DESIGN.md` (responsive)
- [ ] `api-spec.md` khớp server routes (`bash ../../scripts/verify-docs.sh app`)
- [ ] `TRACEABILITY.md` — ít nhất 3 user stories mapped
- [ ] `QA_REPORT.md` — flow pass + screenshots
- [ ] `WORKFLOW_SCORECARD.md` điền xong
- [ ] Web chạy + persistence; mobile (nếu có)

## Docs index

| File | Mục đích |
|------|----------|
| BA_BRIEF | Phân tích đề |
| PRD | Product scope |
| api-spec | API contract |
| data-dictionary | SQLite schema |
| ARCHITECTURE | Client → API → DB |
| TRACEABILITY | Story → API → UI |
| CLIENT_MATRIX | Web vs mobile |
| DECISIONS | ADR lite |
| QA_REPORT | Kết quả test |
| HANDOFF | Bàn giao team |
| WORKFLOW_SCORECARD | Điểm quy trình |
