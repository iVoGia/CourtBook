# Data Dictionary — {PROJECT_NAME}

Database: SQLite (`server/data/app.db`)

## Tables

### {table_name}

| Column | Type | Notes |
|--------|------|-------|
| id | INTEGER PK | auto increment |
| name | TEXT NOT NULL | |
| description | TEXT | nullable |
| image_url | TEXT | Unsplash URL |
| created_at | TEXT | datetime default now |

## Relationships

{Mô tả FK nếu có — giữ đơn giản 1–2 bảng cho 60p}

## Seed data

- Target: 10–20 records
- Source: `server/src/db/seed.sql`
- Init: `npm run db:init`
