# Development Workflow Skill - Overview

This skill provides a standardized, end-to-end process for developing and deploying software projects using OpenClaw agents.

## Why This Skill?

Manual coordination between multiple subskills (planner, coder, tester, reviewer, etc.) is error-prone. This skill defines a repeatable, auditable pipeline with:

- Clear phase boundaries
- Artifact handoffs
- Quality gates
- Manifest tracking

## The Pipeline

```
User Request
     │
     ▼
[Planning] ──► plan_<id>.md
     │
     ▼
[Design] ──► DESIGN.md + schemas
     │
     ▼
[Implementation] ──► src/ + git commits
     │
     ▼
[Testing] ──► test_report.txt
     │
     ▼
[Review] ──► review_notes.md
     │
     ▼
[Deployment] ──► DEPLOYMENT.md + public URL
     │
     ▼
[Documentation] ──► README + USER_GUIDE
     │
     ▼
All Done ✅
```

## Usage Pattern

Your agent should:

1. Detect a development request (e.g., "build a todo app").
2. Create a task manifest in `~/.openclaw/agents/shared/task_<id>.json`.
3. Send the request to the `planner` subskill.
4. Wait for plan completion; update manifest; optionally get user approval.
5. Iterate through the remaining subskills (`designer`, `coder`, `tester`, `reviewer`, `deployer`, `documenter`), ensuring each phase's artifacts are present before proceeding.
6. Notify the user upon completion, providing artifact links and access URL.

## Customization

You can customize:
- The set of phases (add security audit, performance testing, etc.)
- The templates used for artifacts (located in `templates/`)
- Quality thresholds (e.g., minimum review score)
- Commit message conventions
- Notification preferences

## Integration Checklist

- [ ] Copy `development-workflow` skill to your agent.
- [ ] Ensure required subskills exist (`planner`, `coder`, `tester`, `reviewer`).
- [ ] Configure your agent to use the shared task manifest path.
- [ ] Test with a simple project (e.g., "hello world" server).

## See Also

- [Integration Guide](integration.md)
- [Phase Details](phases.md)
