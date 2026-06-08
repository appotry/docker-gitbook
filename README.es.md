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

Imagen Docker para crear libros electrónicos [GitBook](https://github.com/GitbookIO/gitbook), con [Honkit](https://github.com/honkit/honkit) (fork comunitario), fuentes CJK y soporte PlantUML.

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## Inicio rápido

```bash
docker pull bloodstar/gitbook-builder

# iniciar
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# previsualizar
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# construir
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

Añade alias a `.bashrc` o `.zshrc`:

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## Funciones

| Función | Descripción |
|---------|-------------|
| **GitBook CLI** | Versión clásica, parcheada para Node.js 20 |
| **Honkit** | Fork comunitario, compatible con book.json |
| **PlantUML** | Diagramas con OpenJDK 17 + Graphviz |
| **PDF/EPUB** | Conversión con Calibre |
| **Fuentes CJK** | Noto Sans CJK para chino, japonés, coreano |
| **Multi-arquitectura** | linux/amd64, linux/arm/v7, linux/arm64 |

## Uso

```bash
# GitBook
gitbook serve    # http://localhost:4000
gitbook build
gitbook pdf .
gitbook epub .

# Honkit (recomendado)
honkit serve
honkit build
honkit pdf .
honkit epub .
```

## Docker Hub

- Imagen: `bloodstar/gitbook-builder`
- Etiquetas: `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- [Ver etiquetas](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## Variables de entorno

| Variable | Defecto | Descripción |
|----------|---------|-------------|
| `NPM_CONFIG_REGISTRY` | (oficial npm) | Espejo npm. Usuarios chinos: `https://registry.npmmirror.com` |

```bash
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## Documentos

| Documento | Contenido |
|-----------|-----------|
| [docs/GUIDE.md](docs/GUIDE.md) | Uso detallado y plugins |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Arquitectura y componentes |
| [docs/TESTING.md](docs/TESTING.md) | Pruebas y verificación |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | Historial de versiones |
