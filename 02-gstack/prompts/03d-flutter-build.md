# Prompt 03d — Flutter Build (sau gate YES)

Paste sau user chọn **YES** tại Flutter gate:

```
Build Flutter mobile — production structure, cùng API đã viết cho web.

Bước 1: Scaffold
bash ../scripts/scaffold-flutter-mobile.sh app

Bước 2: Implement (mirror web MVP)
- Đọc DESIGN.md → cập nhật lib/core/theme/app_theme.dart (colors, typography gần web)
- Đọc docs/api-spec.md → implement screens qua ApiClient (không duplicate business logic server)
- Nếu có login: docs/DEMO_ACCOUNTS.md + POST /api/auth/login
- Screens tối thiểu: Home/dashboard + 1 flow chính (giống web)
- Bật _requiresAuth trong lib/app.dart nếu BA_BRIEF có auth

Bước 3: Test
- npm run dev (app root) — API :3001
- cd app/mobile && flutter pub get && flutter run
- iOS: localhost:3001 | Android emu: 10.0.2.2:3001
- Verify: health + main flow + demo login (nếu có)

Cắt nếu kẹt giờ: bỏ screen phụ, giữ login + 1 flow.

Output:
- [ ] app/mobile/ chạy được
- [ ] Gọi API thật, không mock local data
- [ ] Cập nhật docs/README.md + docs/ARCHITECTURE.md (thêm mobile client)

Sau xong → prompts/04-presentation-gstack.md (nhắc mobile trong slide sản phẩm nếu có).
```
