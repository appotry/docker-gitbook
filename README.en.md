# docker-gitbook-builder

<p align="center">
  <a href="README.md">中文</a> ·
  <a href="README.en.md">English</a> ·
  <a href="README.ja.md">日本語</a> ·
  <a href="README.ko.md">한국어</a>
</p>

Docker image for building [GitBook](https://github.com/GitbookIO/gitbook) ebooks, bundled with [Honkit](https://github.com/honkit/honkit) (community-maintained GitBook fork), CJK fonts, and PlantUML support.

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## Quick Start

```bash
docker pull bloodstar/gitbook-builder

# init
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# serve
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# build
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

Add these aliases to your `.bashrc` or `.zshrc` for convenience:

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## Features

| Feature | Description |
|---------|-------------|
| **GitBook CLI** | Legacy version, patched for Node.js 20 compatibility |
| **Honkit** | Community-maintained fork, drop-in replacement with same CLI and book.json format |
| **PlantUML** | Diagram rendering via OpenJDK 17 + Graphviz |
| **PDF/EPUB** | Ebook conversion via Calibre |
| **CJK Fonts** | Noto Sans CJK for Chinese, Japanese, and Korean text |
| **Multi-arch** | linux/amd64, linux/arm/v7, linux/arm64 |
| **CN Mirror** | cnpm pre-installed; set `NPM_CONFIG_REGISTRY` to switch npm registry mirror |

## Usage

```bash
# GitBook (legacy)
gitbook init
gitbook serve    # visit http://localhost:4000
gitbook build
gitbook pdf .    # output PDF
gitbook epub .   # output EPUB

# Honkit (recommended)
honkit init
honkit serve     # visit http://localhost:4000
honkit build
honkit pdf .
honkit epub .
```

## GitLab CI Integration

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

- Image: `bloodstar/gitbook-builder`
- Auto tags: `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- Release tags (git tag push): `v<semver>` (e.g. `v0.2.0`)
- [Browse all tags](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `NPM_CONFIG_REGISTRY` | (empty, use npm official) | npm registry URL. For Chinese users, set to `https://registry.npmmirror.com` |

```bash
# Example: use Taobao npm mirror
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## Documentation

| Document | Description |
|----------|-------------|
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Components, tech stack, build flow |
| [docs/REQUIREMENTS.md](docs/REQUIREMENTS.md) | Functional and non-functional requirements |
| [docs/TESTING.md](docs/TESTING.md) | Build verification and test methods |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | Version history |
| [README.md](README.md) | 中文 |
| [README.ja.md](README.ja.md) | 日本語 |
| [README.ko.md](README.ko.md) | 한국어 |
