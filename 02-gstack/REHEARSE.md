# Rehearse — gstack Role Council Pipeline

## Chuẩn bị

```bash
python3 -m pip install -r requirements-pptx.txt
export PATH="$HOME/.bun/bin:$PATH"
flutter doctor   # nếu rehearse nhánh Flutter
```

Mở **`02-gstack`** → Agent mode → bấm giờ **60 phút**.

## Kickoff

1. `MASTER_PROMPT.md` — đề đọc từ [`SPORT_BOOKING_SPEC.md`](SPORT_BOOKING_SPEC.md)
2. `prompts/01-kickoff.md` → `01b-ba-analysis.md`

### Đề thi

Xem [`SPORT_BOOKING_SPEC.md`](SPORT_BOOKING_SPEC.md) — Sports Court Booking (mobile-first, auth User/Admin, courts, booking flow).

## Timeline

| Phút | Lệnh |
|------|------|
| 2–6 | `01b-ba-analysis.md` |
| 6–11 | `02-design-system.md` (+ search) |
| 11–15 | `02b-eng-and-docs.md` + scaffold |
| 16–34 | `03-build-design-led.md` |
| 34–42 | design-review + review + `03-qa.md` |
| 42–48 | `03e-handoff-scorecard.md` + verify-docs |
| 42–43 | `03c-flutter-gate.md` — thử YES |
| 43–50 | `03d-flutter-build.md` (nếu YES) |
| 48–55 | `04-presentation-gstack.md` |
| 55–60 | `SPEAKER_SCRIPT.md` — 3 phần |

## Verify cuối buổi

- [ ] BA_BRIEF.md + DESIGN.md (responsive)
- [ ] Web 375px + desktop screenshots
- [ ] API + persistence
- [ ] mobile/ (nếu gate YES)
- [ ] `verify-docs.sh` pass
- [ ] QA_REPORT + HANDOFF + WORKFLOW_SCORECARD
- [ ] PPTX 3 phần: sản phẩm / gstack / custom
