# gstack — START HERE (60 phút)

> **Ngày thi:** [`GSTACK_BATTLE_WORKFLOW.md`](GSTACK_BATTLE_WORKFLOW.md) → [`MASTER_PROMPT.md`](MASTER_PROMPT.md) + [`SPORT_BOOKING_SPEC.md`](SPORT_BOOKING_SPEC.md)  
> **Custom:** Role Council + Full-Stack + Flutter Gate · [`REHEARSE.md`](REHEARSE.md)

## Workflow

```
office-hours → BA → Designer → eng → docs → web responsive → QA
  → [Flutter gate YES/NO] → PPTX (3 phần)
```

## Stack

- **client/** Vite React :5173 (responsive 375px)
- **server/** Express :3001 + SQLite
- **mobile/** Flutter (optional, sau gate YES)
- **docs/** BA_BRIEF + PRD + api-spec + … + DEMO_ACCOUNTS (nếu login)

## Prerequisites

- Node 20+, Bun, python-pptx
- **Flutter SDK** (`flutter doctor`) — nếu dự định chọn YES tại Flutter gate

## Scaffold

```bash
bash ../scripts/new-fullstack-project.sh app
cd app && npm install && npm run db:init && npm run dev
```

Flutter (sau web QA + gate YES):

```bash
bash ../scripts/scaffold-flutter-mobile.sh app
```

## Skills

office-hours, design-consultation, plan-eng-review, plan-design-review, design-review, review, qa, browse

## Governance docs

Sau scaffold, `app/docs/` gồm WORKFLOW_MANIFEST, TRACEABILITY, QA_REPORT, HANDOFF, WORKFLOW_SCORECARD.

```bash
bash ../scripts/verify-docs.sh app   # api-spec khớp server
```
