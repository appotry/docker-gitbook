# Changelog

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
