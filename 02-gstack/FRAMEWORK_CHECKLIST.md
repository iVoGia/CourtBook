# Framework Checklist — gstack Role Council Pipeline

## Phase 0 — Kickoff (phút 0–2)

- [ ] Paste MASTER_PROMPT — agent đọc `SPORT_BOOKING_SPEC.md`
- [ ] Agent mode + Bun trong PATH

## Phase 1 — CEO + BA (phút 2–6)

- [ ] `/office-hours` — Builder mode
- [ ] `01b-ba-analysis.md` → **docs/BA_BRIEF.md**
- [ ] User stories + acceptance criteria (gồm responsive 375px)
- [ ] Xác định có login không

## Phase 2 — Designer (phút 6–14)

- [ ] Đọc BA_BRIEF trước design
- [ ] `/design-consultation` + WebSearch/browse → **DESIGN.md**
- [ ] DESIGN.md có section Responsive
- [ ] `/plan-eng-review` → API + SQLite
- [ ] `/plan-design-review` — UI ≥8/10

## Phase 3 — Docs + Scaffold (phút 14–16)

- [ ] docs/ core: BA_BRIEF, PRD, api-spec, data-dictionary, ARCHITECTURE, README
- [ ] docs/ governance skeleton: WORKFLOW_MANIFEST, TRACEABILITY, DECISIONS, CLIENT_MATRIX
- [ ] DEMO_ACCOUNTS.md (nếu login)
- [ ] `bash ../scripts/new-fullstack-project.sh app`
- [ ] `npm install` + `npm run db:init`

## Phase 4 — Build web (phút 16–34)

- [ ] client + server theo DESIGN.md + docs/
- [ ] CRUD qua API thật
- [ ] Responsive: sidebar desktop + bottom nav 375px
- [ ] Demo login hoạt động (nếu có auth)
- [ ] Cập nhật TRACEABILITY + CLIENT_MATRIX khi thêm route/screen

## Phase 5 — QA web (phút 34–42)

- [ ] `/design-review` + `/review` + `/qa`
- [ ] **docs/QA_REPORT.md** điền kết quả
- [ ] `bash ../scripts/verify-docs.sh app` → lưu log vào FRAMEWORK_EVIDENCE/
- [ ] Refresh — persistence OK
- [ ] Screenshot desktop + mobile 375px

## Phase 5b — Flutter gate (optional)

- [ ] `03c-flutter-gate.md` — user chọn YES/NO
- [ ] Nếu YES: scaffold + `03d-flutter-build.md`
- [ ] Cập nhật CLIENT_MATRIX (mobile column)

## Phase 6 — Handoff (phút 42–48)

- [ ] `03e-handoff-scorecard.md`
- [ ] HANDOFF.md + WORKFLOW_SCORECARD.md + DECISIONS.md
- [ ] FRAMEWORK_EVIDENCE/ (screenshots + verify-docs.log)

## Phase 7 — Presentation (phút 48–55)

- [ ] slides-gstack.json — 3 phần: sản phẩm / gstack / custom
- [ ] `python3 scripts/generate-pptx.py` → output.pptx
- [ ] SPEAKER_SCRIPT rehearse

## Nói với BTC

`office-hours → BA → Designer → eng → docs → web → QA + verify-docs → handoff → PPTX`

Governance: [`docs/WORKFLOW_MANIFEST.md`](templates/docs/WORKFLOW_MANIFEST.md) · Custom: [`CUSTOM_FRAMEWORK.md`](CUSTOM_FRAMEWORK.md)
