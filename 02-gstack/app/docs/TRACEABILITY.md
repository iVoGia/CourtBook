# Traceability — CourtBook

| Story | API | Screen |
|-------|-----|--------|
| US1: Browse courts by sport | `GET /courts?sport=` | `/courts` |
| US2: Book court with price calc | `GET /courts/:id/slots`, `POST /bookings` | `/courts/:id/book` |
| US3: My bookings + cancel | `GET /bookings`, `DELETE /bookings/:id` | `/bookings` |

Auth (cross-cutting): `POST /auth/login` → `/login`
