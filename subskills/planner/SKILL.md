---
name: planner
description: 将模糊任务转化为可执行计划
---
## 输入
- 从 `sessions_send` 接收的负载（含 task_id, description）
- 读取 `~/.openclaw/agents/shared/<task_id>.json`

## 输出
1. 生成 `~/.openclaw/agents/coding-agent/workspace/plan_<task_id>.md`
2. 更新 `shared/<task_id>.json` 状态为 `"planning_done"`，包含 subtasks 列表
3. 自动触发生 `coder` skill（通过更新状态文件触发后续流程）

## Plan 格式
```markdown
# Plan: <task_id>
## Objective
<short objective>

## Subtasks
1. [ ] Setup project structure
2. [ ] Implement core logic
3. [ ] Write unit tests
...
```

## 下一步
状态文件写入后，系统会自动加载 `coder` skill。