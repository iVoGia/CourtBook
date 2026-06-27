### Superpowers — brainstorm → TDD → subagent

| Phút | Bước | Prompt / skill |
|------|------|----------------|
| 2–10 | Brainstorm | `Brainstorm đề sau. Hỏi tối đa 5 câu. Chưa code.` |
| 10–12 | Approve design | User nói "approve" → agent viết design doc ngắn |
| 12–15 | Plan | `Viết implementation plan (writing-plans): task 2–5 phút, có file path và test.` |
| 15–40 | Build | `subagent-driven-development + TDD. Test trước, code sau.` |
| 40–45 | Verify | `verification-before-completion` — chạy test, fix UI |
| 50–57 | Presentation | `prompts/04-presentation-agent.md` |

**Skills:** `.cursor/skills/` — brainstorming, writing-plans, test-driven-development, subagent-driven-development, verification-before-completion
