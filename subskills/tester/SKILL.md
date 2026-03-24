---
name: tester
description: 运行测试并生成报告
---
## 触发
`shared/<task_id>.json` 中 `status == "coding_done"`

## 操作
1. 定位代码：`workspace/src/`
2. 根据项目类型自动选择测试框架（如 pytest、jest、go test）
3. 运行测试，捕获 stdout/stderr
4. 生成 `workspace/artifacts/<task_id>/test_report.txt`
5. 若测试通过，更新状态为 `"testing_passed"`，触发 `reviewer`
6. 若失败，更新状态为 `"testing_failed"`，记录失败详情，仍触发 `reviewer`（以便审查问题）