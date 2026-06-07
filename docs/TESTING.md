# 测试说明

本项目是一个 Docker 镜像——没有应用程序代码。测试重点在于构建成功和 CLI 工具可用性。

## 构建验证

```bash
docker build -t gitbook-builder:test .
```

预期结果：退出码 0，无报错。

## 运行时冒烟测试

### 验证 CLI 工具

```bash
# GitBook CLI
docker run --rm gitbook-builder:test gitbook --help

# Honkit
docker run --rm gitbook-builder:test honkit --help

# Node.js 和 npm
docker run --rm gitbook-builder:test node --version
docker run --rm gitbook-builder:test npm --version

# Java（供 PlantUML 使用）
docker run --rm gitbook-builder:test java --version

# Calibre（ebook-convert）
docker run --rm gitbook-builder:test ebook-convert --version
```

### 完整电子书构建测试

```bash
# 初始化测试书籍并构建所有格式
docker run --rm -v "$PWD":/gitbook gitbook-builder:test honkit init
docker run --rm -v "$PWD":/gitbook gitbook-builder:test honkit build
docker run --rm -v "$PWD":/gitbook gitbook-builder:test honkit pdf .
docker run --rm -v "$PWD":/gitbook gitbook-builder:test honkit epub .
```

## 自动化测试脚本

`tests/docker_test.sh` 自动执行构建 + CLI 冒烟测试。在项目根目录运行：

```bash
bash tests/docker_test.sh
```

该脚本独立运行，不依赖 CI 环境。

## 测试报告

每次运行自动生成测试报告到 `tests/reports/test-report-<时间戳>.log`，包含：

- 构建结果
- 每个 CLI 工具的 PASS / FAIL 状态
- 容器运行时验证（文件存在性、可执行权限）
- 通过/失败计数汇总

报告示例：

```
============================================
  docker-gitbook-builder 测试报告
============================================
  镜像:       gitbook-builder:test
  时间:       2026-06-08 12:30:00
============================================

============================================
  Step 1: 构建镜像
============================================
  docker build -t gitbook-builder:test          PASS

============================================
  Step 2: CLI 工具验证
============================================
  gitbook --help                                PASS
  honkit --help                                 PASS
  ...

============================================
  测试结果汇总
============================================
  通过:  10
  失败:  0
  总计:  10
  报告:  tests/reports/test-report-20260608-123000.log
============================================
```
