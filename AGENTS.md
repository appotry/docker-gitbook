# AGENTS.md — docker-gitbook-builder

单一职责仓库：**Docker 镜像**，用于构建 GitBook 电子书。无应用代码，无 linter。

## 📦 构建 & CI

- 镜像：`bloodstar/gitbook-builder`（Docker Hub）
- CI：`.github/workflows/Build Image.yml` — 推送 `main`/`master`（含 Dependabot 自动合并）、推送 `v*` 标签、和 `workflow_dispatch` 时触发
- 构建触发器：`package.json` 中的 `gitbook-cli` + `honkit` 依赖 + Dependabot 新版本自动 PR
- 多架构：`linux/amd64`、`linux/arm/v7`、`linux/arm64`（通过 QEMU + Buildx）
- 必要 Secret：`DOCKER_USERNAME`、`DOCKER_PASSWORD`
- 自动标签：`latest`、`gitbook-<version>`、`honkit-<major>`、`honkit-<major>.<minor>`、`honkit-<full>`
- Git 标签推送：`v<semver>`（如 `v0.2.0`）
- 无本地构建快捷命令；单架构测试请用 `docker buildx build` 或直接 `docker build .`

## 🐳 Dockerfile 要点

- 基础镜像：`node:20-slim`（基于 Debian，预装 Node.js 20，追踪最新 Debian 稳定版）
- 构建时修补 GitBook CLI：用 `sed` 注释掉 `graceful-fs/polyfills.js` 中的三行（防止新版 Node 崩溃）
- **Honkit**（社区维护的 GitBook 分支）也以 `honkit` 名称安装 — 即插即用，兼容 `book.json` 格式
- npm install 期间设置 `PUPPETEER_SKIP_DOWNLOAD=true`
- 包含 OpenJDK 17 JRE（用于 PlantUML 插件）、Calibre（用于 epub/pdf）、Graphviz（用于 PlantUML 图表）
- 包含 Noto CJK 字体
- **npm 镜像源**（运行时）：默认使用官方源。设置 `-e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com` 切换淘宝镜像

## ⚙️ 运行时行为

- 默认 `CMD`：`gitbook --help`（`honkit` 也可用）
- `ENTRYPOINT`（`entrypoint.sh`）**已注释掉** — 未启用
- `entrypoint.sh`（如启用）：设置 SSH 密钥、git 配置、运行 `userRun.sh` 用于 npm/yarn 缓存设置
- `volumes`：`/gitbook`（工作区）；暴露端口：`4000`

## 💻 使用方式（容器外）

```bash
# 便捷别名
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'

# GitBook（旧版，已修补可在 Node 20 上运行）
gitbook init
gitbook serve   # 在 :4000 提供访问
gitbook build
gitbook pdf     # 需要 Calibre（已包含）
gitbook epub    # 需要 Calibre（已包含）

# Honkit（社区维护分支，推荐）
honkit init
honkit serve    # 在 :4000 提供访问
honkit build
honkit pdf
honkit epub
```

## 🔑 关键环境变量

`NPM_CONFIG_REGISTRY`（默认空，使用官方 npm 源）

## 📄 重要文件

- `book.json` — 默认 GitBook 配置（中文、Prism、page-treeview、tbfed-pagefooter、favicon 插件）
- `package.json` — Dependabot 触发器清单（监控 `gitbook-cli` + `honkit` 版本）
- `.github/dependabot.yml` — Dependabot 配置，每周检查 npm 更新，新版本自动 PR
- `entrypoint.sh` — 完整自动化脚本（SSH 密钥、git 配置、用户钩子）；包含大量已注释掉的 `deploy`/`server` 函数
- `tests/docker_test.sh` — 独立冒烟测试脚本（构建 + CLI 验证），在 `tests/reports/test-report-<timestamp>.log` 生成报告
- `README.en.md` / `README.ja.md` / `README.ko.md` / `README.es.md` / `README.hi.md` / `README.ar.md` / `README.pt.md` / `README.bn.md` / `README.ru.md` / `README.fr.md` / `README.de.md` — 多语言 README 翻译（12 种语言）

## 📖 文档导航

| 文档 | 内容 |
|------|------|
| `docs/GUIDE.md` | GitBook/Honkit 详细用法、插件配置、镜像加速 |
| `docs/ARCHITECTURE.md` | 组件关系、技术栈、构建流程、设计决策 |
| `docs/REQUIREMENTS.md` | 功能与非功能需求 |
| `docs/TESTING.md` | 构建验证、运行时测试、自动测试脚本用法 |
| `docs/CHANGELOG.md` | 版本变更历史 |

## 编码纪律

> 以下四项核心纪律约束所有编码行为，AI 和人类开发者共同遵守。

### 1. 编程前先思考（Think Before Coding）

不要臆测，不要隐藏困惑，暴露权衡。在开始实现之前：
- **明确说明你的假设**。如果不确定，请提问。
- **如果存在多种解释**，请展示出来——不要默默选择其中一个。
- **如果存在更简单的方案**，请告知。在必要时提出质疑。
- **如果某些内容不清晰**，请停止。指出令人困惑的地方。提问。

### 2. 简约优先（Simplicity First）

以解决问题为目的的最简代码。不要任何推测性内容。
- 不要包含任何超出要求的额外功能。
- 不要为仅使用一次的代码编写抽象。
- 不要包含未要求的"灵活性"或"可配置性"。
- 不要为不可能发生的场景编写错误处理。
- 如果你写了 200 行代码但本可以只用 50 行，请重写。

**自问：** "资深工程师会觉得这太复杂了吗？"如果是，请简化。

### 3. 外科手术式的精准修改（Surgical Changes）

只修改必须修改的部分。只清理你自己的"烂摊子"。
- 不要"改进"相邻的代码、注释或格式。
- 不要重构没有损坏的部分。
- 遵循现有的风格，即使你会有不同的做法。
- 如果你注意到无关的废弃代码，请提出来——**不要删除它**。

当你的更改产生"孤儿"内容时：
- **删除**因为**你的修改**而变得不再使用的导入/变量/函数。
- 除非被要求，否则**不要删除**预先存在的废弃代码。

**测试标准**：每一行修改都应能直接追溯到用户的请求。

### 4. 目标驱动的执行（Goal-Driven Execution）

定义成功标准。循环直到验证通过。
- "添加验证" → "为无效输入编写测试，然后使它们通过"
- "修复 Bug" → "编写一个能复现该 Bug 的测试，然后使它通过"
- "重构 X" → "确保在重构前后的测试都通过"

对于多步骤任务，陈述一个简要计划：
`[步骤] → 验证：[检查]`
`[步骤] → 验证：[检查]`

**这些准则生效的标志是：**
1. Diff 中的不必要变动减少；
2. 由于过度复杂导致的重写次数减少；
3. 在出错之前，先提出澄清问题。

## 经验知识库

路径：`~/Work/dev-experience/`（[gateway skill](~/.agents/skills/dev-experience/SKILL.md) 自动加载）
本项目标签：`docker`、`ci-cd`、`node`、`documentation`、`ssg`
