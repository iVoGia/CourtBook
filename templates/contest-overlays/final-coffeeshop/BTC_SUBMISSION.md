# BTC Submission — Cafe Manager + Spec Kit

## Đề bài (Website / Web App)

**Cafe Manager MVP** — ứng dụng quản lý quán cafe nội bộ trong 60 phút.

### Pain point
Nhân viên quán cafe cần theo dõi menu, đơn hàng và bếp real-time mà không dùng giấy tờ hoặc Excel.

### MVP scope
- Dashboard tổng quan (đơn hôm nay, doanh thu)
- Menu ~20 món đồ uống (ảnh, giá, category)
- Tạo đơn hàng mới
- Kitchen kanban: Chờ → Đang làm → Xong
- Báo cáo ngày

### AI involvement (trong sản phẩm)
- Cursor Agent + Spec Kit trong quy trình build (SDD)
- (Optional) Rule-based gợi ý món bán chạy từ dữ liệu đơn

---

## Framework nộp

**GitHub Spec Kit (Spec-Driven Development)**

### Workflow checklist
```
constitution → specify → plan → tasks → implement → analyze
```

### Lệnh Spec Kit
| Bước | Lệnh | Output |
|------|------|--------|
| 1 | `/speckit.constitution` | `.specify/memory/constitution.md` |
| 2 | `/speckit.specify` | `specs/001-cafe-mvp/spec.md` |
| 3 | `/speckit.plan` | `specs/001-cafe-mvp/plan.md` |
| 4 | `/speckit.tasks` | `specs/001-cafe-mvp/tasks.md` |
| 5 | `/speckit.implement` | `client/`, `server/` |
| 6 | `/speckit.analyze` | Gap report |

### Vì sao Spec Kit?
- Checklist rõ → dễ chấm 15 điểm framework
- Spec-first → scope kiểm soát trong 60 phút
- Khớp slide POOL FRAMEWORK (SDD)

---

## Stack

- **Frontend:** Vite + React + TS + Tailwind 4 + shadcn-style
- **Backend:** Express + better-sqlite3
- **Chạy:** `npm install && npm run db:init && npm run dev`

---

## Demo

- Web: http://localhost:5173
- API: http://localhost:3001
- Reference: `final-coffeeshop/`
