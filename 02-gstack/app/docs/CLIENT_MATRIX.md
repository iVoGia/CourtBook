# Client Matrix — {PROJECT_NAME}

> Feature coverage: Web vs Mobile vs API. API = single source of truth.

| Feature | Web (React) | Mobile (Flutter) | API endpoint | Notes |
|---------|-------------|------------------|--------------|-------|
| Health check | — | startup | `GET /api/health` | |
| {Feature 1} | ✓ | ✓ / — | `GET /api/...` | |
| {Feature 2} | ✓ | — | `POST /api/...` | mobile phase 2 |
| Login | ✓ / — | ✓ / — | `POST /api/auth/login` | see DEMO_ACCOUNTS |

## API base URL

| Client | Base URL |
|--------|----------|
| Web (Vite proxy) | `/api` → `:3001` |
| iOS Simulator | `http://localhost:3001/api` |
| Android Emulator | `http://10.0.2.2:3001/api` |

## Sync rule

Mọi thay đổi endpoint → cập nhật `api-spec.md` + `TRACEABILITY.md` + chạy `verify-docs.sh`.
