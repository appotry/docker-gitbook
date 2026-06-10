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

遵循 [Karpathy 编码纪律](https://github.com/multica-ai/andrej-karpathy-skills)（思考优先 / 简约优先 / 精准修改 / 目标驱动）。编码任务中通过 `skill(name="karpathy-guidelines")` 加载。

编码完成后，对核心逻辑、安全敏感、并发代码执行 **Grill-me（对抗式审查）**：切换为挑剔审查者人格，穷举找出所有缺陷，修复后再审查，循环达标为止。详见 skill 第 5 节。

## 经验知识库

路径：`~/Work/dev-experience/`（[gateway skill](~/.agents/skills/dev-experience/SKILL.md) 自动加载）
本项目标签：`docker`、`ci-cd`、`node`、`documentation`、`ssg`
