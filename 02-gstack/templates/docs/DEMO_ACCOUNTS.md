# Demo Accounts — {PROJECT_NAME}

> Chỉ dùng local demo. **Không** dùng password production.

## Accounts

| Role | Email / Username | Password | Ghi chú |
|------|------------------|----------|---------|
| Admin | `admin@demo.local` | `demo123` | Full access |
| User | `user@demo.local` | `demo123` | Standard user |

## Seed

Users được tạo trong `npm run db:init` → `server/src/db/seed.sql`.

## Login flow

1. Mở http://localhost:5173
2. Đăng nhập bằng account trên
3. Mobile Flutter (nếu có): cùng credentials

## API

```
POST /api/auth/login
{ "email": "admin@demo.local", "password": "demo123" }
→ { "token": "...", "user": { "id", "email", "role" } }
```

## Console output

Sau `db:init`, server in ra:

```
Demo login: admin@demo.local / demo123 | user@demo.local / demo123
```
