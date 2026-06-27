# Prompt 04 — Presentation Agent (phút 50–57)

```
Bạn là Presentation Agent cho AI ADAPT BATTLE.

Đọc toàn bộ project vừa build + FRAMEWORK_CHECKLIST.md + CONTEST_WORKFLOW.md.

Bước 1: Tạo presentation/slides.json theo schema trong presentation/template-slides.json.
Điền ĐÚNG 6 slide với nội dung thật từ project:

1. de_bai_pain — 1 câu problem + đối tượng user
2. giai_phap_mvp — 3 bullet tính năng demo được
3. framework — bảng: Bước | Lệnh/Framework | Thời gian (từ checklist đã tick)
4. kien_truc_demo — stack + screenshots (path trong presentation/screenshots/)
5. ket_qua_60_phut — đã làm được gì, metric (số màn, API, v.v.)
6. bai_hoc — 2 lesson learned + next step

Bước 2: Verify python-pptx (nếu chưa cài):
python3 -c "import pptx" || python3 -m pip install -r requirements-pptx.txt

Chạy script tạo PPTX:
python3 scripts/generate-pptx.py

Bước 3: Verify presentation/output.pptx tồn tại và có 6 slide.

Slide phải cover rubric thuyết trình:
- Process/Workflow rõ (slide 3)
- Phân tích hiệu quả 60 phút → MVP (slide 5)
- Highlight thành tựu + demo path (slide 4)
```
