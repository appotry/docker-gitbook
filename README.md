# docker-gitbook-builder

<p align="center">
  <a href="README.md">🇨🇳 中文</a> ·
  <a href="README.en.md">🇬🇧 English</a> ·
  <a href="README.ja.md">🇯🇵 日本語</a> ·
  <a href="README.ko.md">🇰🇷 한국어</a> ·
  <a href="README.es.md">🇪🇸 Español</a> ·
  <a href="README.hi.md">🇮🇳 हिन्दी</a> ·
  <a href="README.ar.md">🇸🇦 العربية</a>
  <br>
  <a href="README.pt.md">🇵🇹 Português</a> ·
  <a href="README.bn.md">🇧🇩 বাংলা</a> ·
  <a href="README.ru.md">🇷🇺 Русский</a> ·
  <a href="README.fr.md">🇫🇷 Français</a> ·
  <a href="README.de.md">🇩🇪 Deutsch</a>
</p>

用于构建 [GitBook](https://github.com/GitbookIO/gitbook) 电子书的 Docker 镜像，内置 [Honkit](https://github.com/honkit/honkit)（社区维护的 GitBook 分支）、CJK 字体、PlantUML 支持。

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## 🚀 快速开始

```bash
docker pull bloodstar/gitbook-builder

# 初始化
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# 预览
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# 构建
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

推荐添加别名到 `.bashrc` 或 `.zshrc`：

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## 功能特性

| 功能 | 说明 |
|------|------|
| **GitBook CLI** | 经典版本，已打补丁兼容 Node.js 20 |
| **Honkit** | 社区维护版本，与 GitBook CLI 命令和 book.json 完全兼容 |
| **PlantUML 图表** | 基于 OpenJDK 17 + Graphviz |
| **PDF/EPUB 输出** | 内置 Calibre 转换引擎 |
| **CJK 字体** | Noto Sans CJK，中日韩文字正确渲染 |
| **多架构** | linux/amd64, linux/arm/v7, linux/arm64 |
| **CN 加速** | 内置 cnpm 工具；设置环境变量 `NPM_CONFIG_REGISTRY` 可切换 npm 镜像源 |

## 📖 使用示例

```bash
# GitBook（经典）
gitbook init
gitbook serve    # 访问 http://localhost:4000
gitbook build
gitbook pdf .    # 输出 PDF
gitbook epub .   # 输出 EPUB

# Honkit（推荐）
honkit init
honkit serve     # 访问 http://localhost:4000
honkit build
honkit pdf .
honkit epub .
```

## GitLab CI 集成

```yaml
image: bloodstar/gitbook-builder:latest

before_script:
  - export LC_ALL=zh_CN.UTF-8

ebook:
  script: gitbook pdf
  artifacts:
    paths:
      - book.pdf
```

## Docker Hub

- 镜像：`bloodstar/gitbook-builder`
- 自动标签：`latest`、`gitbook-<版本>`、`honkit-<主版本>`、`honkit-<主>.<次>`、`honkit-<完整版本>`
- 版本标签（推送 git tag 时）：`v<语义化版本>`（如 `v0.2.0`）
- [查看所有标签](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## ⚙️ 环境变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `NPM_CONFIG_REGISTRY` | （空，使用 npm 官方源） | npm 镜像源地址。国内用户可设为 `https://registry.npmmirror.com` |

```bash
# 示例：使用淘宝 npm 镜像
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## 相关文档

| 文档 | 内容 |
|------|------|
| [docs/GUIDE.md](docs/GUIDE.md) | 详细使用指南、插件配置、镜像加速 |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | 组件关系、技术栈、构建流程 |
| [docs/REQUIREMENTS.md](docs/REQUIREMENTS.md) | 功能与非功能需求 |
| [docs/TESTING.md](docs/TESTING.md) | 构建验证与测试方法 |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | 版本变更历史 |
| [README.en.md](README.en.md) | English |
| [README.ja.md](README.ja.md) | 日本語 |
| [README.ko.md](README.ko.md) | 한국어 |
| [README.es.md](README.es.md) | Español |
| [README.hi.md](README.hi.md) | हिन्दी |
| [README.ar.md](README.ar.md) | العربية |
| [README.pt.md](README.pt.md) | Português |
| [README.bn.md](README.bn.md) | বাংলা |
| [README.ru.md](README.ru.md) | Русский |
| [README.fr.md](README.fr.md) | Français |
| [README.de.md](README.de.md) | Deutsch |
