[![Docker Pulls](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)
[![Build Status](https://github.com/appotry/docker-gitbook/actions/workflows/Build%20Image.yml/badge.svg)](https://github.com/appotry/docker-gitbook/actions/workflows/Build%20Image.yml)

# bloodstar/gitbook-builder

Docker 镜像，用于构建 GitBook / Honkit 电子书。内置 Calibre、PlantUML、CJK 字体支持。

源码仓库：[github.com/appotry/docker-gitbook](https://github.com/appotry/docker-gitbook)

---

## 🚀 Quick Start

```bash
docker pull bloodstar/gitbook-builder

# 初始化项目
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init

# 本地预览
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve

# 构建
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

推荐使用别名：

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## ⚙️ Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `NPM_CONFIG_REGISTRY` | (npm official) | npm registry mirror. Set to `https://registry.npmmirror.com` for Chinese users |

```bash
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder npm install
```

## ✨ Features

- **GitBook CLI** — Classic version, patched for Node.js 20
- **Honkit** — Community-maintained fork, drop-in replacement
- **PlantUML** — Diagram rendering via OpenJDK 17 + Graphviz
- **PDF / EPUB** — Ebook conversion via Calibre
- **CJK Fonts** — Noto Sans CJK for Chinese, Japanese, Korean
- **Multi-arch** — linux/amd64, linux/arm/v7, linux/arm64
- **cnpm** — Pre-installed for Chinese mirror users

## 🏷️ Tags

| Tag | Description |
|-----|-------------|
| `latest` | Most recent build |
| `honkit-<version>` | Honkit version (e.g. `honkit-6.2.1`) |
| `honkit-<major>.<minor>` | Honkit major.minor (e.g. `honkit-6.2`) |
| `honkit-<major>` | Honkit major only (e.g. `honkit-6`) |
| `gitbook-<version>` | GitBook CLI version (e.g. `gitbook-2.3.2`) |
| `v<semver>` | Release tag on git tag push (e.g. `v0.2.0`) |

## 📚 Documentation

| Document | Link |
|----------|------|
| Usage Guide | [docs/GUIDE.md](https://github.com/appotry/docker-gitbook/blob/master/docs/GUIDE.md) |
| Architecture | [docs/ARCHITECTURE.md](https://github.com/appotry/docker-gitbook/blob/master/docs/ARCHITECTURE.md) |
| Requirements | [docs/REQUIREMENTS.md](https://github.com/appotry/docker-gitbook/blob/master/docs/REQUIREMENTS.md) |
| Testing | [docs/TESTING.md](https://github.com/appotry/docker-gitbook/blob/master/docs/TESTING.md) |
| Changelog | [docs/CHANGELOG.md](https://github.com/appotry/docker-gitbook/blob/master/docs/CHANGELOG.md) |
| 中文 | [README.md](https://github.com/appotry/docker-gitbook/blob/master/README.md) |
| English | [README.en.md](https://github.com/appotry/docker-gitbook/blob/master/README.en.md) |
| 日本語 | [README.ja.md](https://github.com/appotry/docker-gitbook/blob/master/README.ja.md) |
| 한국어 | [README.ko.md](https://github.com/appotry/docker-gitbook/blob/master/README.ko.md) |
| Español | [README.es.md](https://github.com/appotry/docker-gitbook/blob/master/README.es.md) |
| हिन्दी | [README.hi.md](https://github.com/appotry/docker-gitbook/blob/master/README.hi.md) |
| العربية | [README.ar.md](https://github.com/appotry/docker-gitbook/blob/master/README.ar.md) |
| Português | [README.pt.md](https://github.com/appotry/docker-gitbook/blob/master/README.pt.md) |
| বাংলা | [README.bn.md](https://github.com/appotry/docker-gitbook/blob/master/README.bn.md) |
| Русский | [README.ru.md](https://github.com/appotry/docker-gitbook/blob/master/README.ru.md) |
| Français | [README.fr.md](https://github.com/appotry/docker-gitbook/blob/master/README.fr.md) |
| Deutsch | [README.de.md](https://github.com/appotry/docker-gitbook/blob/master/README.de.md) |

## 🔗 Resources

- [GitHub Repository](https://github.com/appotry/docker-gitbook)
- [Docker Hub Tags](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)
- [GitBook Documentation](https://github.com/GitbookIO/gitbook)
- [Honkit Documentation](https://github.com/honkit/honkit)
