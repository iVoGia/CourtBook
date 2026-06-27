# DESIGN.md — CourtBook (Sport Court Booking)

> Design source of truth. Generated from `/design-consultation` + BA_BRIEF.  
> Stack: Vite React + Tailwind · Mobile-first responsive.

## Visual direction

**Aesthetic:** *Athletic clarity* — fresh court-green accents on warm neutral surfaces. Feels like a premium sports club app, not a generic SaaS dashboard. Energetic but calm: big tap targets, slot grid upfront, one primary CTA per screen.

**Anti-slop:** No Inter, no purple gradients, no glassmorphism overload.

---

## Reference URLs (visual research)

| # | Source | Takeaway |
|---|--------|----------|
| 1 | [Behance — Premium Tennis Court Booking](https://www.behance.net/gallery/248345061/Premium-Tennis-Court-Booking-App-UIUX-Design) | Tactile cards, premium club feel, frictionless booking |
| 2 | [District-22 — Court Quest](https://www.district-22.com/project/mobile-app-design-for-a-tennis-application) | Dashboard home, filter by sport, coach/partner patterns (we skip social for MVP) |
| 3 | [Medium — Tennis booking case study](https://medium.com/@Channelizer/the-double-fault-of-booking-tennis-courts-a-product-design-case-study-77ce3726eb73) | **Show all slots upfront** — reduce scrolling between courts on mobile |
| 4 | [Behance — Pickleball Court Finder](https://www.behance.net/gallery/248272533/Pickleball-Court-Finder-Booking-App-UIUX) | Bold sporty palette, bottom nav, quick "Book Now" |
| 5 | [Contra — Freekick venue booking](https://contra.com/p/gQZkkFq3-freekick-a-sports-venue-booking-app) | Action-driven CTAs, unified user/owner visual language |

---

## Typography

| Role | Font | Weight | Size (mobile / desktop) |
|------|------|--------|-------------------------|
| Display / H1 | **Outfit** | 700 | 28px / 36px |
| H2 / Section | **Outfit** | 600 | 20px / 24px |
| Body | **DM Sans** | 400 | 16px / 16px |
| Label / Caption | **DM Sans** | 500 | 12px / 13px |
| Price / Emphasis | **Outfit** | 700 | 18px / 22px |

```html
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:opsz,wght@9..40,400;500;600&family=Outfit:wght@600;700&display=swap" rel="stylesheet">
```

```css
--font-display: 'Outfit', system-ui, sans-serif;
--font-body: 'DM Sans', system-ui, sans-serif;
```

---

## Color palette

| Token | Hex | Usage |
|-------|-----|-------|
| `--bg` | `#f8faf9` | Page background (light) |
| `--surface` | `#ffffff` | Cards, modals |
| `--surface-muted` | `#eef2f0` | Slot grid inactive, skeleton |
| `--border` | `#d4ddd8` | Dividers, inputs |
| `--text` | `#1a2e24` | Primary text (forest ink) |
| `--text-muted` | `#5c6f65` | Secondary copy |
| `--primary` | `#0d9488` | Teal-600 — primary CTA, active nav |
| `--primary-hover` | `#0f766e` | Teal-700 |
| `--accent` | `#ea580c` | Orange-600 — price highlights, warnings |
| `--success` | `#16a34a` | Confirmed status |
| `--warning` | `#ca8a04` | <24h cancel warning |
| `--danger` | `#dc2626` | Errors, cancelled |
| `--sport-badminton` | `#7c3aed` | Badge violet |
| `--sport-football` | `#2563eb` | Badge blue |
| `--sport-tennis` | `#059669` | Badge emerald |

**Dark mode (optional stretch):** `--bg: #0f1714`, `--surface: #1a2420`, keep primary teal.

---

## Spacing & radius

- Scale: 4 / 8 / 12 / 16 / 24 / 32 (`p-1` … `p-8`)
- Card radius: `rounded-2xl` (16px)
- Button radius: `rounded-xl` (12px)
- Slot chip: `rounded-lg` (8px)
- Section gap: `gap-6` mobile, `gap-8` desktop
- Page padding: `px-4` mobile, `px-8` desktop

---

## Layout & navigation

### Information architecture

```
/login, /register
└── (auth) App shell
    ├── /courts          — browse + filter by sport
    ├── /courts/:id/book — date → slots → form → confirm
    ├── /bookings        — upcoming | past tabs
    └── /profile         — user info + logout
```

### Desktop (≥1024px)

- **Left sidebar** (240px): logo, nav links (Courts, My Bookings), user chip + logout at bottom
- **Main content**: max-w-5xl, centered
- Courts: 3-column card grid
- Booking: 2-column — court summary left, slot grid + form right

### Tablet (768–1023px)

- Collapsible sidebar OR top bar with hamburger
- Courts: 2-column grid

### Mobile (375px)

- **Bottom tab bar** (fixed, 56px + safe-area): Courts · Bookings · Profile
- Single column, full-width cards
- Booking flow: stepped wizard (1. Date 2. Slots 3. Details 4. Confirm)
- **No horizontal scroll** — slot grid wraps 3–4 chips per row

---

## Responsive (mandatory)

| Breakpoint | Layout | Nav | Notes |
|------------|--------|-----|-------|
| **375px** | 1 col | Bottom nav | Touch ≥44px; sticky book CTA |
| **768px** | 2 col grids | Top bar or mini sidebar | |
| **1024px+** | Sidebar + main | Left sidebar | Slot grid 4–6 cols |

### Touch targets

- Buttons: min `h-11` (44px)
- Bottom nav items: 48px tap area
- Slot chips: min 44×44px

### States (every screen)

- **Loading:** skeleton cards (pulse on `--surface-muted`)
- **Empty:** illustration + "No bookings yet" + CTA "Browse courts"
- **Error:** toast (top-right desktop, top-center mobile)
- **Success:** toast + optional check animation on confirm

---

## Components

### Court card

- Image top (16:9), sport badge overlay top-left
- Title (Outfit 600), capacity icon + players, price `/hr` in accent
- Primary button: "Book now" full width on mobile

### Slot grid

- Date picker: horizontal scroll week strip (7 days) — **only this strip may scroll horizontally**
- Slots: chips — available (white border), selected (primary fill), booked (muted strikethrough), disabled (opacity 40%)
- Duration selector: 1h / 2h / 3h segmented control

### Booking summary bar (mobile)

- Sticky footer on book flow: court name, date, time, **total price** bold, "Confirm" primary

### My bookings list

- Tabs: Upcoming | Past
- Card: court name, sport badge, datetime, status pill, price right-aligned
- Cancel: secondary destructive; if <24h → modal warning (cannot cancel)

### Auth screens

- Centered card max-w-md, logo + tagline "Book your court in seconds"
- Demo accounts hint below login form (collapsible)

---

## Motion

- Page transitions: 150ms ease-out fade
- Slot select: scale 0.98 → 1.0, 100ms
- Toast: slide down 200ms
- Skeleton: `animate-pulse`

---

## Images

| Court | Unsplash URL |
|-------|--------------|
| Badminton | `https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=400&h=225&fit=crop` |
| Mini Football | `https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=400&h=225&fit=crop` |
| Tennis | `https://images.unsplash.com/photo-1554068865-24cecd4e34b8?w=400&h=225&fit=crop` |
| Fallback | `/images/placeholder.svg` |

```tsx
onError={(e) => { e.currentTarget.src = '/images/placeholder.svg'; }}
```

---

## Tailwind config snippet

```js
theme: {
  extend: {
    fontFamily: {
      display: ['Outfit', 'system-ui', 'sans-serif'],
      body: ['DM Sans', 'system-ui', 'sans-serif'],
    },
    colors: {
      court: {
        bg: '#f8faf9',
        primary: '#0d9488',
        accent: '#ea580c',
        ink: '#1a2e24',
      },
    },
  },
},
```

---

## Screen checklist (implement order)

1. Login / Register
2. Courts list (filter chips: All, Badminton, Football, Tennis)
3. Booking wizard (date → slots → form → confirm)
4. My Bookings (tabs + cancel flow)
5. Profile / logout

---

## plan-design-review score (self-gate)

| Pass | Score | Notes |
|------|-------|-------|
| Pass 1 — Information Architecture | **9/10** | Clear 4-route IA; slot-upfront pattern from research |
| Pass 2 — Visual Hierarchy | **8/10** | One CTA per screen; price emphasis |
| Pass 3 — Responsive | **9/10** | 375/768/1024 defined; bottom nav + sidebar |
| Pass 4 — AI Slop Risk | **9/10** | Outfit + DM Sans; teal/orange not purple gradient |
| **Overall** | **8.75/10** | **PASS** (≥8) — cleared for eng + scaffold |
