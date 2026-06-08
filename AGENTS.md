# AGENTS.md — docker-gitbook-builder

Single-purpose repo: **Docker image** for building GitBook ebooks. No app code, no linter.

## 📦 Build & CI

- Image: `bloodstar/gitbook-builder` (Docker Hub)
- CI: `.github/workflows/Build Image.yml` — runs on push to `main`/`master`, tag push `v*`, weekly (Sun 1:10 UTC), and `workflow_dispatch`
- Multi-arch: `linux/amd64`, `linux/arm/v7`, `linux/arm64` via QEMU + Buildx
- Secrets required: `DOCKER_USERNAME`, `DOCKER_PASSWORD`
- Tags (auto): `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- Tags (git tag push): `v<semver>` (e.g. `v0.2.0`)
- No local build shortcut; use `docker buildx build` or just `docker build .` for single-arch testing

## 🐳 Dockerfile quirks

- Base: `node:20-slim` (Debian-based with Node.js 20 pre-installed, tracks latest Debian stable)
- GitBook CLI patched at build time: three `graceful-fs/polyfills.js` lines are commented out with `sed` (prevents crash on newer Node)
- **Honkit** (community-maintained GitBook fork) also installed as `honkit` — drop-in replacement, same `book.json` format
- `PUPPETEER_SKIP_DOWNLOAD=true` set during npm installs
- OpenJDK 17 JRE (for PlantUML plugin), Calibre (for epub/pdf), Graphviz (for PlantUML diagrams)
- Noto CJK fonts included
- **npm 镜像源**（运行时）：默认使用官方源。设置 `-e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com` 切换淘宝镜像

## ⚙️ Runtime behavior

- Default `CMD`: `gitbook --help` (also `honkit` is available)
- `ENTRYPOINT` (`entrypoint.sh`) is **commented out** — not active
- `entrypoint.sh` (if enabled): sets up SSH keys, git config, runs `userRun.sh` for npm/yarn cache setup
- `volumes`: `/gitbook` (workspace); exposed port: `4000`

## 💻 Usage (from outside container)

```bash
# Aliases for convenience
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'

# GitBook (legacy, patched to work on Node 20)
gitbook init
gitbook serve   # serves on :4000
gitbook build
gitbook pdf     # requires Calibre (included)
gitbook epub    # requires Calibre (included)

# Honkit (community-maintained fork, recommended)
honkit init
honkit serve    # serves on :4000
honkit build
honkit pdf
honkit epub
```

## 🔑 Key env vars

`NPM_CONFIG_REGISTRY` (default empty, uses official npm registry)

## 📄 Notable files

- `book.json` — default GitBook config (Chinese, Prism, page-treeview, tbfed-pagefooter, favicon plugins)
- `renovate.json` — Renovate base config for dependency updates
- `entrypoint.sh` — full automation script (SSH keys, git config, user hooks); contains large commented-out `deploy`/`server` functions
- `tests/docker_test.sh` — standalone smoke test script (build + CLI verification), generates report at `tests/reports/test-report-<timestamp>.log`
- `README.en.md` / `README.ja.md` / `README.ko.md` / `README.es.md` / `README.hi.md` / `README.ar.md` / `README.pt.md` / `README.bn.md` / `README.ru.md` / `README.fr.md` / `README.de.md` — multi-language README translations (12 languages)

## 📖 文档导航

| 文档 | 内容 |
|------|------|
| `docs/GUIDE.md` | GitBook/Honkit 详细用法、插件配置、镜像加速 |
| `docs/ARCHITECTURE.md` | 组件关系、技术栈、构建流程、设计决策 |
| `docs/REQUIREMENTS.md` | 功能与非功能需求 |
| `docs/TESTING.md` | 构建验证、运行时测试、自动测试脚本用法 |
| `docs/CHANGELOG.md` | 版本变更历史 |

## 🧠 经验知识库

路径：`~/Work/dev-experience/`
本项目标签：`docker`, `ci-cd`, `node`, `documentation`, `ssg`

相关经验参考：
- `04-documentation/07-docker-image-doc-architecture.md` — Docker 镜像项目的工程化文档体系（本文档体系遵循此方案）
- `05-ci-cd/02-docker-multi-stage.md` — Docker 多阶段构建策略
- `05-ci-cd/04-docker-test-automation.md` — Docker 自动测试流水线
- `99-general/14-docker-standards.md` — Docker 编码规范（分层缓存、多阶段构建、命名）
- `99-general/17-mirror-check-automation.md` — 镜像源可用性自动检测（npm/node/PyPI 国内镜像）
