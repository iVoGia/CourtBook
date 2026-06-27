# Prompt 02b — Eng review + Docs (phút 11–15)

Paste sau `/plan-design-review` pass, **trước scaffold**:

```
Engineering + Documentation (BẮT BUỘC — full-stack + docs + governance):

Bước 1: Chạy /plan-eng-review
- Lock architecture: client (:5173) + Express API (:3001) + SQLite
- Tối đa 3–5 REST endpoints cho MVP
- 1–2 bảng SQLite, seed 10–20 records
- Không mock JSON — persistence thật qua API + DB

Bước 2: Tạo docs/ (copy từ templates/docs/ nếu chưa có):

Core:
- docs/BA_BRIEF.md — từ phase BA
- docs/PRD.md, api-spec.md, data-dictionary.md, ARCHITECTURE.md, README.md
- docs/DEMO_ACCOUNTS.md — nếu BA_BRIEF có login

Governance (điền skeleton — hoàn thiện sau QA/handoff):
- docs/WORKFLOW_MANIFEST.md — pipeline + DoD
- docs/TRACEABILITY.md — map user stories → API → screen
- docs/CLIENT_MATRIX.md — web vs mobile vs endpoint
- docs/DECISIONS.md — ADR-001 stack
- docs/QA_REPORT.md, HANDOFF.md, WORKFLOW_SCORECARD.md — để trống, điền sau
- docs/FRAMEWORK_EVIDENCE/ — folder evidence

api-spec.md: dùng path THẬT (vd /items) — không để {placeholder} nếu đã biết resource.

Bước 3: Scaffold:
bash ../scripts/new-fullstack-project.sh app

Output bắt buộc trước build:
- [ ] docs/ core + governance skeleton
- [ ] API lock trong api-spec + data-dictionary

Cập nhật docs/ + TRACEABILITY khi API/screen thay đổi.
Sau QA: bash ../scripts/verify-docs.sh app
```
