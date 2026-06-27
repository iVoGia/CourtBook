# Prompt 03e — Handoff + Scorecard (cuối phiên, trước hoặc sau PPTX)

```
Hoàn tất bàn giao chuẩn hóa quy trình:

1. Điền docs/QA_REPORT.md — kết quả QA (pass/fail, screenshots, verify-docs)
2. Điền docs/TRACEABILITY.md — map user story → API → screen → evidence
3. Điền docs/CLIENT_MATRIX.md — web vs mobile vs endpoint
4. Cập nhật docs/DECISIONS.md — ADR cho quyết định stack/auth/mobile
5. Điền docs/HANDOFF.md — cách chạy, demo script, known issues, next sprint
6. Điền docs/WORKFLOW_SCORECARD.md — gates + timing + retro 3 bullet
7. Copy evidence vào docs/FRAMEWORK_EVIDENCE/ (screenshots, verify-docs log)

Chạy:
bash ../scripts/verify-docs.sh app

Lưu output verify vào docs/FRAMEWORK_EVIDENCE/verify-docs.log
```
