# Traceability — {PROJECT_NAME}

> User story → API → DB → Screen → Evidence. Cập nhật khi scope thay đổi.

| ID | User story | API | DB table | Screen / route | QA evidence |
|----|------------|-----|----------|----------------|-------------|
| US-01 | As a {user}, I want {action} | `GET /api/{x}` | `{table}` | `/` Dashboard | screenshot 01 |
| US-02 | As a {user}, I want {action} | `POST /api/{x}` | `{table}` | `/feature` | screenshot 02 |
| US-03 | As a {user}, I want {action} | `PATCH /api/{x}/:id` | `{table}` | flow end | screenshot 03 |

## Responsive

| Story | 375px | Desktop |
|-------|-------|---------|
| US-01 | [ ] pass | [ ] pass |

## Mobile (nếu có)

| Story | Web | Flutter screen | Same API |
|-------|-----|----------------|----------|
| US-01 | ✓ | HomeScreen | `GET /api/...` |
