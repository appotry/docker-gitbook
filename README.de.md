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

Docker-Image zum Erstellen von [GitBook](https://github.com/GitbookIO/gitbook)-E-Books, mit [Honkit](https://github.com/honkit/honkit) (Community-Fork), CJK-Schriftarten und PlantUML-Unterstützung.

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## Schnellstart

```bash
docker pull bloodstar/gitbook-builder

# initialisieren
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# Vorschau
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# bauen
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

Fügen Sie Aliase zu `.bashrc` oder `.zshrc` hinzu:

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## Funktionen

| Funktion | Beschreibung |
|----------|-------------|
| **GitBook CLI** | Klassische Version, für Node.js 20 gepatcht |
| **Honkit** | Community-Fork, book.json-kompatibel |
| **PlantUML** | Diagramme via OpenJDK 17 + Graphviz |
| **PDF/EPUB** | Konvertierung via Calibre |
| **CJK-Schriften** | Noto Sans CJK enthalten |
| **Multi-Architektur** | linux/amd64, linux/arm/v7, linux/arm64 |

## Verwendung

```bash
# GitBook
gitbook serve    # http://localhost:4000
gitbook build
gitbook pdf .
gitbook epub .

# Honkit (empfohlen)
honkit serve
honkit build
honkit pdf .
honkit epub .
```

## Docker Hub

- Image: `bloodstar/gitbook-builder`
- Tags: `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- [Tags anzeigen](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## Umgebungsvariablen

| Variable | Standard | Beschreibung |
|----------|----------|-------------|
| `NPM_CONFIG_REGISTRY` | (npm offiziell) | npm-Spiegel. China: `https://registry.npmmirror.com` |

```bash
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## Dokumentation

| Dokument | Inhalt |
|----------|--------|
| [docs/GUIDE.md](docs/GUIDE.md) | Detaillierte Nutzung und Plugins |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Architektur und Komponenten |
| [docs/TESTING.md](docs/TESTING.md) | Tests und Verifikation |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | Versionsverlauf |
