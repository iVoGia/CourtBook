# UI Kit — Chuẩn thi (40 điểm sản phẩm)

## Stack UI cố định

```
Vite + React + TypeScript
Tailwind CSS 4 (@tailwindcss/vite)
Components: Button, Card, Badge, Dialog (shadcn-style)
Icons: lucide-react
Font: DM Sans (Google Fonts hoặc system-ui fallback)
Router: react-router-dom (nếu multi-page)
```

## Theme mặc định (cafe / product)

| Token | Value |
|-------|-------|
| Background | `#0c0a09` (stone-950) |
| Card | `#1c1917` (stone-900) |
| Primary / Accent | `#f59e0b` (amber-500) |
| Muted text | `#a8a29e` (stone-400) |
| Border | `#292524` (stone-800) |

Theme enterprise (nếu đề B2B): slate-950 + blue-500.

## Layout

- **Desktop:** sidebar trái (nav) + main content
- **Mobile (375px):** bottom nav hoặc hamburger — không overflow ngang
- **Spacing:** `p-4`, `gap-4`, cards `rounded-xl`

## Component checklist

- [ ] `Button` — variants: default, outline, ghost; disabled state
- [ ] `Card` — CardHeader, CardTitle, CardContent
- [ ] `Badge` — status colors (waiting, active, done)
- [ ] Loading state trên async actions
- [ ] Empty state với text hướng dẫn

## Ảnh

- Aspect ratio **16:9** trên card/list item
- `rounded-xl object-cover`
- `onError` → `/images/placeholder.svg` local
- Không dùng `via.placeholder.com` (hay chết mạng thi)

## Prompt UI (copy sau plan)

Xem [`prompts/02-build.md`](../prompts/02-build.md).

## Reference

Pattern đầy đủ: `../final-coffeeshop/client/` (nếu mở từ AllIn_06 root).
