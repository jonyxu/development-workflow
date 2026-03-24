# Development Workflow Skill

**Skill ID**: `development-workflow`  
**Description**: Standardized end-to-end development process for OpenClaw agents  
**Version**: 1.0.0  
**Author**: OpenClaw Team  

---

## Purpose

This skill encapsulates a complete, standardized development workflow that transforms a user request into a deployed, documented software product. It defines phases, handoffs, artifact expectations, and quality gates.

---

## Core Principles

1. **Phased Delivery** - Each phase (Plan, Design, Code, Test, Review, Deploy, Document) has clear entry/exit criteria.
2. **Artifact-Driven** - Every phase produces tangible, versioned artifacts (plans, schemas, code, tests, reviews, docs).
3. **Automated Delegation** - Subskills (planner, coder, tester, reviewer, deployer) are invoked programmatically.
4. **Quality Gates** - No phase proceeds without successful completion and approval of the previous phase.
5. **Full Traceability** - All tasks, decisions, and artifacts are logged and retrievable.

---

## Phase Definitions

| Phase | Subskill | Input | Output | Gate |
|-------|----------|-------|--------|------|
| 1. Planning | `planner` | User request | `plan_<taskId>.md` | Plan approved by user or auto-approve |
| 2. Design | `designer` | Plan | `DESIGN.md`, schemas | Design consistent with plan |
| 3. Implementation | `coder` | Design + Plan | Source code, `package.json` | All subtasks in plan implemented |
| 4. Testing | `tester` | Source code | Test report (pass/fail) | All tests pass |
| 5. Review | `reviewer` | Source + Tests | Review notes, score | Score >= threshold (e.g., 8.0) |
| 6. Deployment | `deployer` | Source + Review | Deployment scripts, config, public URL | Service accessible and functional |
| 7. Documentation | `documenter` | All above | README, USER_GUIDE, DEPLOYMENT | Docs complete and accurate |

---

## Handoff Protocol

Each phase ends by updating a shared `task_<taskId>.json` manifest located in `~/.openclaw/agents/shared/`. The manifest includes:

```json
{
  "taskId": "20260324-001",
  "title": "Feature title",
  "status": "planning|designing|coding|testing|reviewing|deploying|done",
  "progress": 0-100,
  "artifacts": {
    "plan": "/path/to/plan.md",
    "design": "/path/to/DESIGN.md",
    "code": "/path/to/repo",
    "test_report": "/path/to/report.txt",
    "review": "/path/to/review.md",
    "deployment": "/path/to/DEPLOYMENT.md",
    "user_guide": "/path/to/USER_GUIDE.md"
  },
  "subtasks": [ ... ],
  "completedAt": "ISO timestamp"
}
```

The owning agent of the next phase reads this manifest before starting work.

---

## Subskill Requirements

- **planner**: Must decompose request into atomic subtasks with estimates and order dependencies.
- **designer**: Must produce architecture diagram, data schema, API spec, and security considerations.
- **coder**: Must implement all subtasks, initialize git, commit per feature/bugfix with conventional messages.
- **tester**: Must write automated integration tests covering all CRUD operations and edge cases.
- **reviewer**: Must evaluate against rubric (code quality, security, performance, maintainability, testing, docs).
- **deployer**: Must produce deployment scripts, configuration templates, and a publicly accessible endpoint.
- **documenter**: Must generate comprehensive README, user guide, and deployment guide.

---

## Git Integration Standards

- Each implementation phase must initialize a Git repository in the project workspace.
- Commits must use [Conventional Commits](https://www.conventionalcommits.org/):
  - `feat:` for new features
  - `fix:` for bug fixes
  - `docs:` for documentation changes
  - `test:` for adding/fixing tests
  - `chore:` for build/process changes
  - `refactor:` for code restructuring
- Commit messages must include task ID in body if applicable.
- Do not commit secrets or large binaries; use `.gitignore`.
- At minimum, one commit per subtask implementation.

---

## Artifact Templates

Templates for each phase are provided in `templates/`:

- `plan_template.md` - Planning structure
- `design_template.md` - System design document
- `test_report_template.txt` - Test summary
- `review_template.md` - Code review rubric
- `deployment_guide_template.md` - Deployment instructions
- `user_guide_template.md` - End-user documentation

---

## Quality Criteria

- **Code**: Lintable, no security anti-patterns, modular structure
- **Tests**: Integration tests covering all API endpoints; all passing
- **Review**: Overall score >= 8.0; no critical issues
- **Docs**: README with quick start, API docs, feature list; user guide with tutorials
- **Deployment**: One-click or script-based deployment; publicly accessible health check

---

## Integration into Your Agent

To use this workflow in your agent:

1. Copy the entire `development-workflow` skill directory to `~/.openclaw/agents/<your-agent>/skills/`.
2. In your agent's logic, when a development request is detected:
   - Create a `task_<taskId>.json` manifest in `~/.openclaw/agents/shared/`.
   - Invoke `planner` subskill with the request.
   - After plan approval, sequentially invoke `designer`, `coder`, `tester`, `reviewer`, `deployer`, `documenter`.
   - After each phase, read the manifest and verify artifacts exist before proceeding.
3. Notify the user at each major milestone.

---

## Example Usage Flow

```markdown
User: "建一个博客系统"

Agent:
1. Create task manifest
2. Send to planner: "分解这个需求"
3. Receive plan, store in manifest, ask user approval
4. On approval, send to designer: "根据计划设计架构"
5. Store DESIGN.md, send to coder: "开始实现"
6. Coder builds repo, commits, signals completion
7. Send to tester: "运行测试"
8. Store test report, if fail → return to coder
9. Send to reviewer: "审查代码"
10. If review score < 8.0 → return to coder
11. Send to deployer: "配置发布"
12. Obtain public URL, store
13. Send to documenter: "生成文档"
14. Mark task all_done, deliver all artifacts + access URL
```

---

## customization

You may extend or modify:

- Phase order or add new phases (e.g., Security audit)
- Artifact templates (replace `templates/` contents)
- Quality thresholds (adjust review score minimum)
- Git commit style (change conventional commit rules)
- Notification hooks (send messages to user or other agents)

---

## License

This skill is provided as-is for OpenClaw agent development. Modify as needed.
