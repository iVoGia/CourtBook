# QA Report — {PROJECT_NAME}

> Điền sau phase QA (`03-qa.md`). Nguồn nghiệm thu khách quan.

**Date:** {YYYY-MM-DD}  
**Tester:** {agent / team}  
**Environment:** local — client :5173, API :3001

## Summary

| Result | Count |
|--------|-------|
| Pass | {n} |
| Fail | {n} |
| Skip | {n} |

**Overall:** [ ] PASS  [ ] FAIL (block Flutter gate / handoff)

## Functional

| # | Test | Steps | Expected | Actual | Pass |
|---|------|-------|----------|--------|------|
| 1 | Health | `GET /api/health` | 200 ok | | [ ] |
| 2 | Main flow | {steps} | {expected} | | [ ] |
| 3 | Persistence | Create → F5 | Data remains | | [ ] |
| 4 | Login demo | DEMO_ACCOUNTS | Login OK | | [ ] / N/A |

## Responsive

| Viewport | Layout | Horizontal scroll | Screenshot |
|----------|--------|-------------------|------------|
| 375px mobile | bottom nav OK | none | `02-feature.png` |
| 1280px desktop | sidebar OK | none | `01-dashboard.png` |

## Docs sync

```bash
bash ../scripts/verify-docs.sh app
```

| Check | Result |
|-------|--------|
| api-spec vs server routes | [ ] OK |
| data-dictionary vs schema | [ ] OK |

## Issues (critical only)

1. {issue or "None"}

## Sign-off

- [ ] Ready for Flutter gate
- [ ] Ready for HANDOFF.md
