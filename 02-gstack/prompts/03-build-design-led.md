# Prompt 03 — Build design-led full-stack (phút 16–36)

Paste sau scaffold (`app/` monorepo):

```
Build full-stack MVP theo DESIGN.md + docs/BA_BRIEF.md + docs/ (source of truth).

BẮT BUỘC full-stack:
- client/ — Vite React theo DESIGN.md
- server/ — Express REST API :3001
- SQLite — better-sqlite3, npm run db:init, seed 10–20 records
- Mọi form/action gọi API thật — CẤM mock JSON-only hoặc localStorage thay DB
- Proxy /api từ client → server

Nếu BA_BRIEF có login:
- Implement auth endpoints + seed demo users (docs/DEMO_ACCOUNTS.md)
- In demo credentials khi db:init

Implement 1 flow end-to-end trước feature phụ.

UI — RESPONSIVE BẮT BUỘC (DESIGN.md + assets/ui-kit.md):
- Mobile-first Tailwind
- Desktop: sidebar + main | Mobile 375px: bottom nav — no horizontal scroll
- Touch targets ≥ 44px; test viewport 375px trước khi coi xong
- Ảnh 16:9, onError → placeholder local
- Loading/error/empty states trên API calls
- Anti-AI-slop: không purple gradient mặc định

Backend:
- Implement endpoints trong docs/api-spec.md
- Schema khớp docs/data-dictionary.md
- Cập nhật docs/ nếu API thay đổi

Chạy: npm run db:init && npm run dev
Verify: GET /api/health, flow CRUD chính, refresh giữ data, layout OK tại 375px
```
