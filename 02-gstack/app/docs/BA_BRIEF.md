# BA Brief — Sport Court Booking

> Phân tích đề bài trước design & code. Source of truth cho Designer và Eng.  
> Nguồn: [`SPORT_BOOKING_SPEC.md`](../SPORT_BOOKING_SPEC.md) + [`MASTER_PROMPT.md`](../MASTER_PROMPT.md)

## Problem

Người chơi thể thao cần đặt sân (cầu lông, mini football, tennis) nhanh trên mobile mà không phải gọi điện hay đến trực tiếp. Họ cần thấy sân còn trống, tính giá rõ ràng, và quản lý lịch đã đặt — hủy khi cần với chính sách 24 giờ.

## User persona

| Field | Value |
|-------|-------|
| Tên | **Minh** — nhân viên văn phòng, chơi cầu lông tối 2 lần/tuần |
| Mục tiêu | Đặt sân trong &lt;2 phút, xem lịch sắp tới, hủy nếu bận việc |
| Bối cảnh | Dùng điện thoại 375px trên đường về nhà (~18h), cần UI một tay, không scroll ngang |

| Field | Value |
|-------|-------|
| Tên | **Admin Lan** — quản lý cơ sở thể thao |
| Mục tiêu | Có sân demo sẵn để user book; (stretch) quản lý sân & giờ mở cửa |
| Bối cảnh | Login role Admin để kiểm tra seed data / (optional) CRUD sân |

## User stories

1. **As a** registered user, **I want** to browse courts by sport type with name, capacity, and hourly price, **so that** I can choose the right court for my group.
2. **As a** user, **I want** to book a court by selecting date, time slot (1–3 hours), and entering my name, phone, and player count, **so that** I get a confirmed booking with total price calculated automatically.
3. **As a** user, **I want** to view my upcoming and past bookings and cancel upcoming ones (with a warning if &lt;24h remain), **so that** I can manage my schedule without calling the venue.

## MVP scope — IN

- [ ] **Auth demo:** Register, login, role User / Admin; `DEMO_ACCOUNTS.md` + seed users
- [ ] **Court list:** ≥3 seeded courts (Badminton A, Mini Football A, Tennis A) — name, sport, capacity, hourly price
- [ ] **Booking flow:** Court → date → available slots → customer form → price calc → confirm
- [ ] **Business rules:** No overlapping bookings; ≥2h advance; 1–3h duration; players ≤ capacity; operating hours default 06:00–22:00
- [ ] **My bookings:** Upcoming vs past; court, date, time, status, total price
- [ ] **Cancel booking:** Only if not started; warning UI if &lt;24h before start (policy: cannot cancel within 24h — show message)
- [ ] **Responsive web:** Mobile-first 375px + desktop layout
- [ ] **API + SQLite:** Express backend, no mock-only JSON

## MVP scope — OUT (60 phút — làm sau QA nếu còn giờ)

- Weekly calendar view (dùng slot picker trong booking flow thay thế)
- Recurring bookings (series / single occurrence cancel)
- Admin panel UI (add/edit/delete court, configure hours) — courts seeded via `db:init`
- QR check-in, Find teammates, Dashboard statistics, Mock payment
- Light/dark mode toggle (nice-to-have, không block MVP)
- Flutter mobile app (chỉ sau Flutter gate YES)

## Acceptance criteria

| # | Given | When | Then |
|---|-------|------|------|
| 1 | User đã login (demo account) | Chọn court, ngày mai, slot 2h, 4 players (capacity ≥4) | Booking confirmed; total price = hourly_rate × 2; hiện trong My Bookings upcoming |
| 2 | User mở app trên mobile 375px | Navigate courts → book → my bookings | Layout không scroll ngang; nút tap ≥44px; bottom nav hoặc drawer hoạt động |
| 3 | User refresh browser sau khi book | Mở My Bookings | Booking vẫn còn (SQLite persistence) |
| 4 | Slot đã được book bởi user khác | User chọn cùng court + overlapping time | API trả lỗi conflict; UI hiển thị slot unavailable |
| 5 | Booking còn &lt;24h trước giờ bắt đầu | User bấm Cancel | Hiển thị warning; không cho hủy (theo cancellation policy) |
| 6 | Current time 14:00 | User chọn slot hôm nay 15:00 | Slot bị disable (cần ≥2h advance → earliest 16:00) |

## Authentication

- [ ] **Không cần login** — skip DEMO_ACCOUNTS
- [x] **Cần login** → bắt buộc `docs/DEMO_ACCOUNTS.md` + seed users

**Demo accounts (seed):**

| Email | Password | Role |
|-------|----------|------|
| user@demo.com | demo123 | user |
| admin@demo.com | demo123 | admin |

## Data entities (1 dòng mỗi entity)

| Entity | Mô tả |
|--------|-------|
| `users` | id, email, password_hash, name, role (user\|admin), created_at |
| `courts` | id, name, sport_type (badminton\|mini_football\|tennis), capacity, hourly_price, enabled, created_at |
| `bookings` | id, user_id, court_id, date, start_time, end_time, customer_name, phone, player_count, total_price, status (confirmed\|cancelled\|completed), created_at |
| `settings` | id, key (operating_hours_start\|operating_hours_end), value — default 06:00 / 22:00 |

## Responsive requirements

- Breakpoints: **375px** (mobile), **768px** (tablet), **1024px+** (desktop)
- Mobile: bottom nav (Courts, Book, My Bookings, Profile/Logout); không horizontal scroll
- Desktop: sidebar nav + content area; calendar/slot grid readable
- Touch targets ≥ 44px
- Loading skeletons + toast notifications cho form submit
- Empty states cho My Bookings khi chưa có booking

## Open questions (tối đa 3)

1. ~~Có bắt buộc weekly calendar view trong 60p không?~~ → **OUT** cho MVP; slot picker trong booking flow đủ demo.
2. ~~Admin CRUD trong 60p?~~ → **OUT**; seed 3 courts qua `db:init`.
3. *(Không block)* Ngôn ngữ UI: tiếng Việt hay English? → **Default: English UI** (spec English); có thể mix label ngắn nếu demo VN.
