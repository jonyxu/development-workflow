---
name: coder
description: 根据 plan 逐子任务实现代码
---
## 前置条件
`shared/<task_id>.json` 中 `status == "planning_done"` 且存在 `plan_<task_id>.md`

## 行为
- 读取 `plan_<task_id>.md`
- 逐个完成 subtask，每完成一个：
  1. 将 `[ ]` 改为 `[x]` 并记录完成时间
  2. 更新 `shared/<task_id>.json` 的 `progress`（0-100）
  3. 写入代码到 `workspace/src/`，目录结构根据技术栈自动决定
- 全部完成后更新状态 `"coding_done"`，触发 `tester`

## 错误处理
- 代码生成失败 → 记录错误到 `shared/<task_id>.error`，状态 `"error"`，立即通知 main-agent