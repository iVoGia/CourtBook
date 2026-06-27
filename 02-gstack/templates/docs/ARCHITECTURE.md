# Architecture — {PROJECT_NAME}

## Stack

| Layer | Tech |
|-------|------|
| Frontend | Vite + React + TS + Tailwind |
| Backend | Express + TypeScript |
| Database | SQLite (better-sqlite3) |

## Flow

```
Browser (:5173)
    → Vite proxy /api
    → Express (:3001)
    → better-sqlite3 (app.db)
```

## Monorepo

```
project/
├── client/     # React UI
├── server/     # REST API + db/
├── docs/       # PRD, api-spec, ...
└── DESIGN.md   # UI source of truth
```

## Dev commands

```bash
npm install
npm run db:init
npm run dev
```
