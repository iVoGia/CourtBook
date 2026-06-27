# AI ADAPT BATTLE — Contest Workflow (60 phút)

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

## Scaffold nhanh (phút 12–15)

Nếu đề mới cần web app từ đầu:

```bash
# Từ root AllIn_06 (nếu có):
bash ../scripts/new-project.sh app

# Hoặc copy stack-template thủ công vào folder hiện tại
```

Nếu đề tương tự cafe/CRUD: tham khảo `../final-coffeeshop` (pattern UI + API).

## Framework steps (folder này)

{{FRAMEWORK_STEPS}}

## Prompts theo phase

| Phase | File |
|-------|------|
| Kickoff | [`prompts/01-kickoff.md`](prompts/01-kickoff.md) |
| Build | [`prompts/02-build.md`](prompts/02-build.md) |
| QA | [`prompts/03-qa.md`](prompts/03-qa.md) |
| Presentation | [`prompts/04-presentation-agent.md`](prompts/04-presentation-agent.md) |

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
