# Architecture Decisions — {PROJECT_NAME}

> ADR lite. Ghi quyết định quan trọng trong phiên build.

## Template

### ADR-{NNN}: {title}

| Field | Value |
|-------|-------|
| **Date** | {date} |
| **Status** | accepted |
| **Context** | {vấn đề cần quyết định} |
| **Decision** | {đã chọn gì} |
| **Consequences** | {trade-off, ảnh hưởng web/mobile} |

---

### ADR-001: Stack monorepo client + Express + SQLite

| Field | Value |
|-------|-------|
| **Context** | Cần full-stack thật trong 60 phút |
| **Decision** | Vite React + Express + better-sqlite3 |
| **Consequences** | Single API cho web + Flutter; seed qua `db:init` |

### ADR-002: {next decision}

| Field | Value |
|-------|-------|
| **Context** | |
| **Decision** | |
| **Consequences** | |
