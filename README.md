# Development Workflow Skill

A complete, ready-to-use development pipeline for OpenClaw. This skill bundles everything you need to turn a user request into a deployed application: orchestrator, planning, coding, testing, review, deployment, and documentation.

## 📦 What's included

This package contains:

- **Orchestrator skill** (`development-workflow/`) – Defines phases, handoffs, quality gates, and provides templates.
- **Subskills** (pre-installed):
  - `planner` – Breaks down requests into actionable subtasks
  - `coder` – Implements features, writes tests, generates docs
  - `tester` – Runs integration tests and produces reports
  - `reviewer` – Evaluates code quality and security

Also included:
- JSON schemas for task and plan validation
- Markdown templates for design, test reports, reviews, deployment guides, user guides
- Integration docs and phase specifications
- Install script to deploy subskills automatically

## 🚀 Quick Start

1. **Copy the whole `development-workflow` directory** into your agent's skills folder:

   ```bash
   cp -r development-workflow ~/.openclaw/agents/<your-agent>/skills/
   ```

2. **Run the installer** to make subskills available:

   ```bash
   cd ~/.openclaw/agents/<your-agent>/skills/development-workflow
   ./install.sh
   ```

3. **Restart your agent** (if running) or rely on autoload.

4. **Verify skills loaded**:

   ```bash
   openclaw agents skills --agent <your-agent>
   ```

   You should see `development-workflow`, `planner`, `coder`, `tester`, `reviewer`.

5. **Use it**: Your agent can now handle development requests. By default, you can set up a trigger such that messages containing "开发" or "build" are routed to the `development-workflow` skill, or you can modify your agent's `AGENTS.md` to use this pipeline directly.

## 📖 How It Works

The workflow follows a strict phased approach:

```
User Request
    ↓
[Planning] → plan_<taskId>.md
    ↓
[Design]   → DESIGN.md (optional)
    ↓
[Implementation] → src/ + git commits
    ↓
[Testing] → test_report.txt
    ↓
[Review]  → review_notes.md (score ≥ 8.0)
    ↓
[Deployment] → DEPLOYMENT.md + public URL
    ↓
[Documentation] → README + USER_GUIDE
    ↓
✅ Done
```

A shared task manifest (`~/.openclaw/agents/shared/task_<taskId>.json`) tracks progress and artifacts across phases.

## 📚 Documentation

- `SKILL.md` – Full skill specification
- `docs/overview.md` – Pipeline overview
- `docs/integration.md` – Step-by-step integration guide
- `docs/phases.md` – Detailed phase descriptions and quality gates

## 💰 Cost Optimization: Per-Phase LLMs

You can assign different LLMs to each phase via `phaseModels` in the task manifest to balance quality and cost. Example:

```json
{
  "phaseModels": {
    "planning": "minimaxai/minimax-m2.5",
    "coding": "openai/gpt-4o-mini",
    "testing": "openai/gpt-4o-mini",
    "reviewing": "anthropic/claude-3-opus"
  }
}
```

Recommended mapping:

- **Planning, Review**: GPT-4 Turbo / Claude 3 Opus (high reasoning)
- **Implementation, Testing, Deployment, Documentation**: GPT-4o-mini / Claude 3 Haiku (cost-effective)

The orchestrator will automatically use these models via `sessions_spawn(model=...)`.

## 🔧 Customization

- Templates are in `templates/`; edit to match your standards.
- Quality thresholds (e.g., minimum review score) can be adjusted in the orchestrator's logic or in the subskills themselves.
- You can skip phases (e.g., design) if appropriate; just note it in the manifest.

## 💡 Example

After installation, try a simple request:

> "Create a Hello World server that returns OK on /health"

The agent will automatically:

- Generate a plan with subtasks
- Implement a Node.js server
- Write automated tests
- Review the code
- Optionally deploy via Cloudflare Tunnel
- Deliver docs and a public URL

## 🛠 Requirements

- Node.js 18+ (for coder)
- Git (for source control)
- Cloudflared (for tunnel deployment; optional)
- Your agent must have permission to write to `~/.openclaw/agents/shared/` and to spawn subagents if using that pattern.

## 📝 License

Open source, part of the OpenClaw ecosystem.

