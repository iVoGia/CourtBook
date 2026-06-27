# {PROJECT_NAME} — Run locally

## Prerequisites

- Node 20+
- `npm install` at project root

## Setup

```bash
npm install
npm run db:init
npm run dev
```

## URLs

| Service | URL |
|---------|-----|
| Web app | http://localhost:5173 |
| API | http://localhost:3001/api |
| Health | http://localhost:3001/api/health |

## Project docs

- [`WORKFLOW_MANIFEST.md`](WORKFLOW_MANIFEST.md) — pipeline + DoD
- [`BA_BRIEF.md`](BA_BRIEF.md) — phân tích đề (BA)
- [`PRD.md`](PRD.md)
- [`api-spec.md`](api-spec.md)
- [`data-dictionary.md`](data-dictionary.md)
- [`ARCHITECTURE.md`](ARCHITECTURE.md)
- [`TRACEABILITY.md`](TRACEABILITY.md) — story → API → UI
- [`CLIENT_MATRIX.md`](CLIENT_MATRIX.md) — web vs mobile
- [`DECISIONS.md`](DECISIONS.md) — ADR lite
- [`QA_REPORT.md`](QA_REPORT.md) — kết quả QA
- [`HANDOFF.md`](HANDOFF.md) — bàn giao
- [`WORKFLOW_SCORECARD.md`](WORKFLOW_SCORECARD.md) — điểm quy trình
- [`DEMO_ACCOUNTS.md`](DEMO_ACCOUNTS.md) — nếu có login
- [`FRAMEWORK_EVIDENCE/`](FRAMEWORK_EVIDENCE/) — bằng chứng BTC
- [`../DESIGN.md`](../DESIGN.md) — UI design system

## Verify docs sync

```bash
bash ../scripts/verify-docs.sh app
```

## Demo login (nếu có auth)

Xem [`DEMO_ACCOUNTS.md`](DEMO_ACCOUNTS.md). Sau `npm run db:init`, server in credentials ra console.

## Mobile (optional)

Nếu có `mobile/` Flutter: xem [`../mobile/README.md`](../mobile/README.md)

## Demo flow

{1–2 câu mô tả flow chính để BTC demo}
