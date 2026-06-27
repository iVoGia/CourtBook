# Flutter Mobile — Contest Template

Connects to the **same Express API** as the web client (`server/`).

## Prerequisites

- Flutter SDK stable (`flutter doctor`)
- Web API running: `npm run dev` from app root (:3001)

## API base URL

| Platform | URL |
|----------|-----|
| iOS Simulator | `http://localhost:3001` |
| Android Emulator | `http://10.0.2.2:3001` |
| Physical device | `http://<LAN-IP>:3001` — edit `lib/core/config/api_config.dart` |

## Setup

```bash
cd mobile
flutter pub get
flutter run
```

## Scaffold

From project with web already built:

```bash
bash ../scripts/scaffold-flutter-mobile.sh app
```

## Implement

1. Read `../DESIGN.md` — apply colors/fonts in `lib/core/theme/app_theme.dart`
2. Read `../docs/api-spec.md` — mirror web endpoints
3. Read `../docs/DEMO_ACCOUNTS.md` — login if auth enabled
4. Screens: login (if auth) + main flow (2–3 screens max for 60 min)

## Structure

```
lib/
├── main.dart
├── app.dart
├── core/api/       # ApiClient
├── core/config/    # ApiConfig per platform
├── core/theme/     # AppTheme from DESIGN.md
└── features/       # auth, home, ...
```
