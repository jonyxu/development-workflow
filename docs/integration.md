# Integration Guide

This guide walks you through integrating the Development Workflow Skill into your agent.

## 1. Copy the Skill

Place the `development-workflow` directory into your agent's `skills/` folder:

```
~/.openclaw/agents/<your-agent>/skills/development-workflow/
```

## 2. Verify Subskills

Ensure your agent has the following subskills available (they can be other skills with those IDs):

- `planner` - Generates a development plan
- `coder` - Implements the code
- `tester` - Runs automated tests
- `reviewer` - Performs code review
- (Optional) `designer` - Produces system design
- (Optional) `deployer` - Configures deployment
- (Optional) `documenter` - Writes user-facing docs

If any are missing, install or create them using the skill framework.

## 3. Shared Manifest Directory

The workflow expects a shared directory for task manifests:

```
~/.openclaw/agents/shared/
```

Your agent must have read/write access to this path.

## 4. Implement the Orchestrator Logic

When your agent receives a development request, it should:

### Step A: Create Task Manifest

```json
{
  "taskId": "20260324-001",
  "title": "Brief user-provided title",
  "description": "Full user request text",
  "status": "planning",
  "progress": 0,
  "requestedBy": "<user-id>",
  "createdAt": "<ISO timestamp>",
  "updatedAt": "<ISO timestamp>",
  "artifacts": {},
  "phaseModels": {
    "planning": "minimaxai/minimax-m2.5",
    "coding": "openai/gpt-4o-mini",
    "testing": "openai/gpt-4o-mini",
    "reviewing": "anthropic/claude-3-opus"
  }
}
```

Save this as `~/.openclaw/agents/shared/task_<taskId>.json`.

> **Tip**: `phaseModels` are optional. They let you assign different LLMs to each phase (e.g., cheap models for coding, expensive for design/review). Omit to use the orchestrator's default model.

### Step B: Delegate to Planner

Send a message to the `planner` subskill, including the taskId and request:

```json
{
  "taskId": "20260324-001",
  "description": "Build a todo app with Node.js and SQLite",
  "workspace": "/path/to/workspace"
}
```

### Step C: Wait for Plan Completion

The planner will:
- Generate `plan_<taskId>.md` in the specified workspace.
- Update the task manifest with `plan` artifact path and set `status` to `planning_done` or similar.

Your agent should poll the manifest or listen for a notification.

### Step D: Optional User Approval

You may send the plan to the user for approval before proceeding.

If approved, update manifest `status` to `designing` and delegate to `designer` (if used). Some workflows skip design and go straight to coding.

### Step E: Iterate Through Remaining Phases

For each subsequent subskill:

1. Read the current task manifest.
2. Verify prerequisites (e.g., plan exists before coding).
3. Send a message to the subskill with necessary context (taskId, workspace, paths to earlier artifacts).
4. Wait for completion; the subskill should write its artifact and update the manifest.
5. Check quality gates (e.g., test status, review score). If gate fails, return to the responsible phase (usually coder).

Sample message to coder:

```json
{
  "taskId": "20260324-001",
  "workspace": "/path/to/todo-app",
  "plan": "/path/to/plan_20260324-001.md",
  "design": "/path/to/DESIGN.md",
  "model": "openai/gpt-4o-mini"   // optional override for this phase
}
```

The `model` field (if provided) is passed to `sessions_spawn` to override the agent's default model for that sub-session.

### Step F: Final Notification

When `status` becomes `done`, collect all artifacts and send a final message to the user:

```
✅ Task Complete: Build a todo app
- Plan: /path/to/plan_20260324-001.md
- Code: /root/.openclaw/agents/coding-agent/workspace/todo-app/
- Tests: passed (6/6)
- Review: 8.8/10
- Deployed at: https://your-tunnel.trycloudflare.com
- Documentation: README.md, USER_GUIDE.md
```

## 5. Handle Errors

If any phase fails (e.g., tests fail, review score below threshold), your agent should:

- Update the task manifest `status` to `blocked` or `needs_revision`.
- Notify the user with details.
- Route the task back to the appropriate subskill with feedback.

## 6. Log Everything

Keep a complete transcript of decisions and actions for auditability. The skill framework may already provide session logs.

## 7. Optional: Git Automation

The `coder` subskill should follow Git conventions:

- Initialize a git repo in the project workspace if not exists.
- Commit changes per subtask with conventional commit messages.
- Do not commit secrets or large binaries.
- Optionally tag the final release: `git tag -a v1.0.0 -m "Initial release"`.

If your coder does not do this automatically, you may add a post-coder step to verify git state.

## 8. Testing the Integration

Start with a simple task:

> "Create a Hello World Node.js server that returns 'OK' on /health"

Verify:

- Plan is generated with 3-4 subtasks.
- Code is implemented and server runs.
- Tests pass (health endpoint returns 200).
- Review score is >= 8.0.
- Deployment script creates a tunnel and you can access the URL.
- All artifacts appear in the task manifest.

## Need Help?

Consult `SKILL.md` for the full specification.

---

Once integrated, your agent can autonomously deliver production-ready software from a simple user request.
