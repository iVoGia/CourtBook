# UI Kit — gstack Design-First (40 điểm sản phẩm)

## Source of truth

**`DESIGN.md`** (từ `/design-consultation`) override mọi default bên dưới.

Workflow: [`GSTACK_BATTLE_WORKFLOW.md`](../GSTACK_BATTLE_WORKFLOW.md)

## Stack UI

- **Frontend:** Vite + React + TS + Tailwind + shadcn-style
- **Backend (bắt buộc):** Express + SQLite — `docs/ARCHITECTURE.md`
- **`DESIGN.md`** override theme defaults

## Theme fallback (chỉ khi DESIGN.md chưa có)

| Token | Value |
|-------|-------|
| Background | `#0c0a09` (stone-950) |
| Card | `#1c1917` (stone-900) |
| Primary | `#f59e0b` (amber-500) |

Enterprise B2B: slate-950 + blue-500.

## Anti-AI-slop checklist

- [ ] Không Inter + purple gradient mặc định (trừ khi DESIGN.md chọn)
- [ ] Typography có hierarchy rõ (h1/h2/body)
- [ ] Spacing scale 4/8 (p-4, gap-4, gap-8)
- [ ] 1 primary CTA per screen
- [ ] Real images — `assets/images.md`; onError → placeholder local
- [ ] Empty states có copy tiếng Việt
- [ ] Dark mode contrast đủ (WCAG-ish)

## Layout — Responsive (bắt buộc)

- **375px** mobile: bottom nav, single column, tap targets ≥ 44px
- **768px** tablet: 2 columns where appropriate
- **1024px+** desktop: sidebar + main content
- **No horizontal scroll** on any breakpoint
- Cards: `rounded-xl`
- QA: screenshot desktop + mobile 375 before Flutter gate

## Role Council design flow

1. BA → `docs/BA_BRIEF.md`
2. Designer → `/design-consultation` + WebSearch/browse → `DESIGN.md`
3. `/plan-eng-review` → API + DB
3. `/plan-design-review` → gate ≥8/10
4. docs/ từ `templates/docs/`
5. Build full-stack
6. `/design-review` → polish

## Docs templates

[`templates/docs/`](../templates/docs/) — copy vào `app/docs/` khi scaffold

## Prompts

- Design phase: [`prompts/02-design-system.md`](../prompts/02-design-system.md)
- Build: [`prompts/03-build-design-led.md`](../prompts/03-build-design-led.md)

## Reference

`../final-coffeeshop/client/` (pattern UI/API nếu cần)
