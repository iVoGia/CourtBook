# AI ADAPT BATTLE — Contest Workflow (60 phút)

> **gstack team:** Dùng [`GSTACK_BATTLE_WORKFLOW.md`](GSTACK_BATTLE_WORKFLOW.md) — **Role Council** + full-stack + Flutter gate + PPTX 3 phần.

> **Ngày thi:** Mở folder này trong Cursor → Agent mode → paste [`MASTER_PROMPT.md`](MASTER_PROMPT.md) + đề bốc thăm.

## Rubric map

| Tiêu chí | Điểm | File hỗ trợ |
|----------|------|-------------|
| Sản phẩm | 40 | `assets/ui-kit.md`, `prompts/02-build.md`, `prompts/03-qa.md` |
| Framework | 15 | `FRAMEWORK_CHECKLIST.md` |
| Thuyết trình | 25 | `prompts/04-presentation-agent.md` → `presentation/output.pptx` |
| Khán giả | 20 | Demo live + slide 4 screenshots |

## Timeline chuẩn

| Phút | Phase | Việc làm | Output |
|------|--------|----------|--------|
| 0–2 | **Kickoff** | Paste `MASTER_PROMPT.md` + đề BTC | Session bắt đầu |
| 2–12 | **Framework Phase 1** | Spec / brainstorm / constitution | Spec hoặc design doc |
| 12–15 | **Framework Phase 2** | Plan + stack + UI theme | Plan + scaffold (xem bên dưới) |
| 15–45 | **Build** | Code theo [`prompts/02-build.md`](prompts/02-build.md) | App chạy local |
| 45–50 | **QA** | [`prompts/03-qa.md`](prompts/03-qa.md) | Fix dead buttons, 3 screenshots |
| 50–57 | **Presentation** | [`prompts/04-presentation-agent.md`](prompts/04-presentation-agent.md) | `presentation/output.pptx` |
| 57–60 | **Rehearse** | 5 phút: đề → framework → demo → kết quả | Sẵn sàng trình bày |

## Scaffold nhanh (phút 14–16)

```bash
bash ../scripts/new-fullstack-project.sh app
cd app && npm install && npm run db:init
```

Full-stack bắt buộc: `client/` + `server/` + SQLite. Docs: `templates/docs/` → `app/docs/`.

## Framework steps (folder này)

> **Chi tiết design-first:** [`GSTACK_BATTLE_WORKFLOW.md`](GSTACK_BATTLE_WORKFLOW.md) · [`CUSTOM_FRAMEWORK.md`](CUSTOM_FRAMEWORK.md)

### gstack — Role Council Pipeline

| Phút | Bước | Prompt / lệnh |
|------|------|----------------|
| 2–6 | BA | `prompts/01b-ba-analysis.md` → BA_BRIEF |
| 6–11 | Designer | `prompts/02-design-system.md` (+ search) |
| 11–15 | Eng + docs | `prompts/02b-eng-and-docs.md` |
| 15–34 | Build web | `prompts/03-build-design-led.md` (responsive) |
| 34–42 | QA | `prompts/03-qa.md` |
| 42–43 | Flutter gate | `prompts/03c-flutter-gate.md` YES/NO |
| 43+ | Flutter | `prompts/03d-flutter-build.md` (nếu YES) |
| 48–55 | PPTX | `prompts/04-presentation-gstack.md` — 3 phần |
| 42–44 | Code review | `/review` |
| 44–48 | Browser QA | `/qa http://localhost:5173` |
| 48–55 | Presentation | `prompts/04-presentation-gstack.md` |

**Yêu cầu:** Bun (`~/.bun/bin`); browser QA: `.cursor/skills/gstack/browse/dist/browse`


## Prompts theo phase

| Phase | File |
|-------|------|
| Kickoff | [`prompts/01-kickoff.md`](prompts/01-kickoff.md) |
| Design | [`prompts/02-design-system.md`](prompts/02-design-system.md) |
| Build | [`prompts/03-build-design-led.md`](prompts/03-build-design-led.md) |
| QA | [`prompts/03-qa.md`](prompts/03-qa.md) |
| Presentation | [`prompts/04-presentation-gstack.md`](prompts/04-presentation-gstack.md) |

## Output bắt buộc cuối phiên

- [ ] App chạy local (`npm run dev` hoặc tương đương)
- [ ] README ngắn: cách chạy
- [ ] `FRAMEWORK_CHECKLIST.md` đã tick từng bước
- [ ] `presentation/output.pptx` (6 slide)
- [ ] 3 screenshot trong `presentation/screenshots/` (cho slide demo)

## Lưu ý thi

- **Agent mode** — không Ask mode khi build
- Session Agent **mới** khi mở folder lần đầu
- Scope MVP: 1 flow end-to-end demo được > nhiều feature dở
- Mọi button/form phải có handler thật — không dead click
