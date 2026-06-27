# gstack Role Council + Full-Stack + Flutter Gate (60 phút)

> **Ngày thi:** Mở `02-gstack` → Agent mode → [`MASTER_PROMPT.md`](MASTER_PROMPT.md) + đề [`SPORT_BOOKING_SPEC.md`](SPORT_BOOKING_SPEC.md)

## Rubric map

| Tiêu chí | Điểm | Cách ăn điểm |
|----------|------|--------------|
| Sản phẩm | 40 | BA_BRIEF + DESIGN.md + responsive web + API/DB + demo |
| Framework | 15 | Role Council + gstack skills + custom pipeline |
| Thuyết trình | 25 | PPTX 3 phần: sản phẩm → gstack → custom |
| Khán giả | 20 | Demo live + persistence (+ Flutter nếu có) |

## Pipeline

```
kickoff → BA → Designer → plan-eng-review → plan-design-review
  → docs/ → scaffold → build web responsive → QA web
  → [Flutter gate YES/NO] → PPTX
```

## Timeline 60 phút

| Phút | Role | Lệnh / việc | Output |
|------|------|-------------|--------|
| 0–2 | All | MASTER_PROMPT + đề | Session |
| 2–6 | **BA** | [`01b-ba-analysis.md`](prompts/01b-ba-analysis.md) | **docs/BA_BRIEF.md** |
| 6–11 | **Designer** | [`02-design-system.md`](prompts/02-design-system.md) + search | **DESIGN.md** |
| 11–13 | Eng | `/plan-eng-review` | API + SQLite |
| 13–14 | Designer | `/plan-design-review` ≥8/10 | UI gate |
| 14–15 | Docs | [`02b-eng-and-docs.md`](prompts/02b-eng-and-docs.md) | **docs/** |
| 15–16 | Scaffold | `new-fullstack-project.sh app` | client + server |
| 16–34 | Build | [`03-build-design-led.md`](prompts/03-build-design-led.md) | Web responsive |
| 34–42 | QA | design-review → review → [`03-qa.md`](prompts/03-qa.md) | QA_REPORT + verify-docs |
| 42–48 | Handoff | [`03e-handoff-scorecard.md`](prompts/03e-handoff-scorecard.md) | HANDOFF + SCORECARD |
| 42–43 | Gate | [`03c-flutter-gate.md`](prompts/03c-flutter-gate.md) | YES/NO |
| 43–48 | Flutter* | [`03d-flutter-build.md`](prompts/03d-flutter-build.md) | `mobile/` |
| 48–55 | PPTX | [`04-presentation-gstack.md`](prompts/04-presentation-gstack.md) | output.pptx |
| 55–60 | Rehearse | [`SPEAKER_SCRIPT.md`](presentation/SPEAKER_SCRIPT.md) | 5 phút |

\*Flutter chỉ khi user chọn YES và còn ≥12 phút. Nếu NO → PPTX ngay sau QA.

## Scaffold

```bash
bash ../scripts/new-fullstack-project.sh app
cd app && npm install && npm run db:init && npm run dev
```

Flutter (sau gate YES):

```bash
bash ../scripts/scaffold-flutter-mobile.sh app
cd app/mobile && flutter pub get && flutter run
```

## Copy-paste phases

| Phase | File |
|-------|------|
| Kickoff | `prompts/01-kickoff.md` |
| BA | `prompts/01b-ba-analysis.md` |
| Design | `prompts/02-design-system.md` |
| Eng + Docs | `prompts/02b-eng-and-docs.md` |
| Build | `prompts/03-build-design-led.md` |
| QA | `prompts/03-qa.md` |
| Flutter gate | `prompts/03c-flutter-gate.md` |
| Flutter build | `prompts/03d-flutter-build.md` |
| Handoff | `prompts/03e-handoff-scorecard.md` |
| PPTX | `prompts/04-presentation-gstack.md` |

## Output bắt buộc

```
app/
├── DESIGN.md
├── docs/          # BA_BRIEF + PRD + governance (WORKFLOW_MANIFEST, TRACEABILITY, QA_REPORT, …)
├── docs/FRAMEWORK_EVIDENCE/  # verify-docs.log, screenshots
├── client/        # :5173 responsive
├── server/        # :3001 SQLite
├── mobile/        # Flutter (optional)
└── presentation/output.pptx
```

## Yêu cầu máy

- Bun, python-pptx, Node 20+
- Flutter SDK (nếu chọn nhánh mobile)

## Rehearse

[`REHEARSE.md`](REHEARSE.md)
