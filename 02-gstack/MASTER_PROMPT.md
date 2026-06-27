# AI ADAPT BATTLE — Session thi 60 phút (gstack)

## Framework đang dùng

**gstack** + **Role Council + Full-Stack + Flutter Gate** (custom layer)

Chi tiết custom: [`CUSTOM_FRAMEWORK.md`](CUSTOM_FRAMEWORK.md)  
Workflow đầy đủ: [`GSTACK_BATTLE_WORKFLOW.md`](GSTACK_BATTLE_WORKFLOW.md)

## Đề bài

**Nguồn đề (đọc trước khi làm):** [`SPORT_BOOKING_SPEC.md`](SPORT_BOOKING_SPEC.md)

```
Đọc toàn bộ SPORT_BOOKING_SPEC.md — đó là đề BTC chính thức.
Scope 60 phút: BA phase cắt MVP (auth demo + courts + booking + my bookings tối thiểu).
Stack contest: Vite React + Express + SQLite (không bắt buộc Next/Postgres trong spec).
Bonus / recurring / QR: chỉ khi còn giờ sau web QA pass.
```

## Quy tắc bắt buộc

1. Follow [`GSTACK_BATTLE_WORKFLOW.md`](GSTACK_BATTLE_WORKFLOW.md) — không skip bước
2. **Role Council:** BA (`01b-ba-analysis`) → Designer (`02-design-system`) → Eng → Build
3. **Chưa code** cho đến khi có `BA_BRIEF.md` + `DESIGN.md` + `/plan-design-review` ≥8/10
4. **Backend bắt buộc:** Express + SQLite — cấm mock JSON-only
5. **Web responsive bắt buộc:** test 375px + desktop trước Flutter gate
6. **Docs:** core + governance templates (xem `docs/WORKFLOW_MANIFEST.md`)
7. **Login (nếu đề có):** `DEMO_ACCOUNTS.md` + seed demo users — login ngay sau db:init
8. **Flutter gate:** sau web QA PASS — hỏi user YES/NO; chỉ gen khi YES
9. QA: `/qa` + `docs/QA_REPORT.md` + `bash ../scripts/verify-docs.sh app`
10. Handoff: `03e-handoff-scorecard.md` → HANDOFF + WORKFLOW_SCORECARD
11. PPTX 3 phần: sản phẩm → gstack → custom gstack
12. Tick [`FRAMEWORK_CHECKLIST.md`](FRAMEWORK_CHECKLIST.md)

## Stack mặc định

- **Web:** `client/` Vite React + `server/` Express + SQLite
- **Mobile (optional):** `mobile/` Flutter → cùng API :3001
- **Scaffold:** `bash ../scripts/new-fullstack-project.sh app`
- **Flutter:** `bash ../scripts/scaffold-flutter-mobile.sh app`
- **Chạy:** `npm run dev` → :5173 + :3001

## Definition of Done (DoD)

- [ ] `docs/BA_BRIEF.md` + `DESIGN.md` (responsive)
- [ ] `docs/api-spec.md` khớp server (`verify-docs.sh`)
- [ ] `docs/TRACEABILITY.md` — ≥3 stories mapped
- [ ] `docs/QA_REPORT.md` — QA pass
- [ ] `docs/HANDOFF.md` + `WORKFLOW_SCORECARD.md`
- [ ] Web responsive + API + SQLite
- [ ] `mobile/` (nếu Flutter gate YES)
- [ ] `presentation/output.pptx`
- [ ] `docs/FRAMEWORK_EVIDENCE/` có verify-docs.log + screenshots

**Bắt đầu: `/office-hours` → `01b-ba-analysis.md`. KHÔNG code trước BA + design gate.**
