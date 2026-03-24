# Development Workflow Skill

A standardized, end-to-end development process for OpenClaw agents.

## Overview

This skill defines a complete pipeline from user request to deployed product, with clear phases, handoffs, and quality gates.

## Phases

1. **Planning** - Decompose request into subtasks
2. **Design** - Architecture, schemas, API spec
3. **Implementation** - Code the features
4. **Testing** - Automated integration tests
5. **Review** - Quality and security evaluation
6. **Deployment** - Publish to production
7. **Documentation** - User and deployment guides

Each phase produces versioned artifacts and updates a shared task manifest.

## Usage

1. Copy this skill to your agent's `skills/` directory.
2. On detecting a development request, create a task manifest in `~/.openclaw/agents/shared/task_<id>.json`.
3. Sequentially invoke the subskills: `planner`, `designer`, `coder`, `tester`, `reviewer`, `deployer`, `documenter`.
4. After each phase, verify the manifest and artifacts before proceeding.
5. Notify the user on completion with the final access URL.

## Requirements

- Subskills: `planner`, `coder`, `tester`, `reviewer` (and optionally `designer`, `deployer`, `documenter`).
- Shared directory for task manifest: `~/.openclaw/agents/shared/`.
- Git must be available in the coder's workspace.

## Customization

- Modify templates in `templates/`.
- Adjust quality thresholds in `SKILL.md`.
- Extend phases or add new ones as needed.

## License

Open source, for OpenClaw ecosystem.
