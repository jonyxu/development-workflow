# Development Workflow Skill（开发工作流技能）

一套完整的、开箱即用的 OpenClaw 开发流水线。本技能将用户请求转化为可部署的应用所需的全部组件：编排器、规划、编码、测试、审查、部署和文档。

---

## 📦 包含内容

本包包含：

- **编排技能** (`development-workflow/`) – 定义阶段、移交、质量门，并提供模板。
- **子技能**（已预装）：
  - `planner` – 将需求拆解为可执行的子任务
  - `coder` – 实现功能、编写测试、生成文档
  - `tester` – 运行集成测试并生成报告
  - `reviewer` – 评估代码质量与安全性

还包括：
- 任务与计划的 JSON schemas（用于校验）
- Markdown 模板：设计、测试报告、审查、部署指南、用户指南
- 集成文档与阶段规范
- 用于自动部署子技能的安装脚本

---

## 🚀 快速开始

1. **复制整个 `development-workflow` 目录** 到你的 agent skills 文件夹：

   ```bash
   cp -r development-workflow ~/.openclaw/agents/<your-agent>/skills/
   ```

2. **运行安装脚本** 将子技能复制到上级 skills 目录：

   ```bash
   cd ~/.openclaw/agents/<your-agent>/skills/development-workflow
   ./install.sh
   ```

3. **重启 agent**（如果已运行）或依赖 autoload。

4. **验证技能已加载**：

   ```bash
   openclaw agents skills --agent <your-agent>
   ```

   应看到 `development-workflow`、`planner`、`coder`、`tester`、`reviewer`。

5. **使用**：你的 agent 现在可以处理开发请求。默认情况下，你可以设置触发器，让包含 "开发" 或 "build" 的消息路由到 `development-workflow` 技能，或修改你的 agent `AGENTS.md` 直接使用此流水线。

---

## 📖 工作原理

工作流程严格遵循分阶段方式：

```
用户请求
    ↓
[规划] → plan_<taskId>.md
    ↓
[设计]   → DESIGN.md（可选）
    ↓
[实现] → src/ + git 提交
    ↓
[测试] → test_report.txt
    ↓
[审查] → review_notes.md（得分 ≥ 8.0）
    ↓
[部署] → DEPLOYMENT.md + 公网 URL
    ↓
[文档] → README + USER_GUIDE
    ↓
✅ 完成
```

共享任务清单（`~/.openclaw/agents/shared/task_<taskId>.json`）跟踪各阶段的进度与产物。

---

## 📚 文档

- `SKILL.md` – 完整技能规范
- `docs/overview.md` – 流水线概览
- `docs/integration.md` – 分步集成指南
- `docs/phases.md` – 详细阶段说明与质量门

---

## 🔧 自定义

- 模板位于 `templates/`；可根据你的标准编辑。
- 质量阈值（如最低审查分数）可在编排器逻辑或子技能中调整。
- 可以跳过某些阶段（如设计），只需在任务清单中注明。

---

## 💡 示例

安装后，尝试一个简单请求：

> "创建一个 Hello World 服务器，在 /health 返回 OK"

Agent 将自动：
- 生成包含子任务的计划
- 实现一个 Node.js 服务器
- 编写自动化测试
- 审查代码
- 可选通过 Cloudflare Tunnel 部署
- 交付文档和公网 URL

---

## 🛠 要求

- Node.js 18+（用于 coder）
- Git（用于源码管理）
- Cloudflared（用于隧道部署；可选）
- 你的 agent 必须具备写入 `~/.openclaw/agents/shared/` 的权限，以及在使用子 agent 模式时的生成权限。

---

## 📝 License

开源，属于 OpenClaw 生态系统。
