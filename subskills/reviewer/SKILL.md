---
name: reviewer
description: 代码审查与质量检查
---
## 触发
`shared/<task_id>.json` 中 `status` 为 `"testing_passed"` 或 `"testing_failed"`

## 操作
1. 扫描 `workspace/src/`，运行静态分析（语言相关 linter）
2. 检查代码风格、安全漏洞、性能问题
3. 生成 `workspace/artifacts/<task_id>/review_notes.md`
4. 更新 `shared/<task_id>.json` 为 `"review_done"`，附加 reviewScore（0-10）
5. 触发 `deploy`（若任务要求部署）或 `notify_main`