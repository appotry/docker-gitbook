# 📝 Changelog

## [0.3.0] — 2026-06-08

### Added

- 📄 PDF 目录页码深度配置支持（book.json 新增 `pdf.tocDepth` / `pdf.tocTitle`）
- 🌍 多语言 README 选择器添加国旗 emoji
- 🎨 全文档体系添加 emoji 装饰（README、docs/*、AGENTS、DOCKER_README）

### Changed

- 🧹 移除 6 个冗余 GIT_* ENV 变量（GIT_USERNAME、GIT_USEREMAIL、GIT_TOKEN、GIT_REPO、GIT_BRANCH、GIT_COMMIT_MESSAGE），entrypoint.sh 清理对应死代码
- 📝 ARCHITECTURE.md：更新技术栈为 node:20-slim，移除已删除环境变量引用，同步 cnpm 移除
- 📝 AGENTS.md：同步移除已删除环境变量
- 📝 REQUIRMENTS.md：N4 需求改为 NPM_CONFIG_REGISTRY

## [0.2.0] — 2026-06-08

### Added

- Honkit (community-maintained GitBook fork) installed alongside gitbook-cli
- Engineering documentation system: docs/ARCHITECTURE.md, docs/REQUIREMENTS.md, docs/TESTING.md, docs/CHANGELOG.md
- Automated test script: tests/docker_test.sh
- Infrastructure: .gitignore, .editorconfig, .gitattributes
- AGENTS.md references to cross-project experience knowledge base
- Multi-language README (Chinese primary + English)

### Changed

- **Docker 镜像标签策略优化**：废弃 `stable-<YY-MM-DD>` 日期标签，改为基于 honkit 版本的语义化标签体系：
  - `honkit-<major>`（如 `honkit-4`）
  - `honkit-<major>.<minor>`（如 `honkit-4.0`）
  - `honkit-<full>`（如 `honkit-4.0.4`）
  - 推送 git tag `v*` 时额外生成 `v<semver>` 标签
  - 版本号从 npm registry 自动获取

## [0.1.0] — Initial version

- Docker image with GitBook CLI (patched for Node 20), Honkit, OpenJDK 17, Calibre, Graphviz, Noto CJK fonts
- Multi-arch CI: linux/amd64, linux/arm/v7, linux/arm64
- Published to Docker Hub as bloodstar/gitbook-builder
- Tagged with `latest` and `stable-<YY-MM-DD>`
- entrypoint.sh (disabled), userRun.sh, book.json
