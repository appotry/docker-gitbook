# docker-gitbook-builder

<p align="center">
  <a href="README.md">中文</a> ·
  <a href="README.en.md">English</a> ·
  <a href="README.ja.md">日本語</a> ·
  <a href="README.ko.md">한국어</a> ·
  <a href="README.es.md">Español</a> ·
  <a href="README.hi.md">हिन्दी</a> ·
  <a href="README.ar.md">العربية</a>
  <br>
  <a href="README.pt.md">Português</a> ·
  <a href="README.bn.md">বাংলা</a> ·
  <a href="README.ru.md">Русский</a> ·
  <a href="README.fr.md">Français</a> ·
  <a href="README.de.md">Deutsch</a>
</p>

Image Docker pour créer des livres électroniques [GitBook](https://github.com/GitbookIO/gitbook), avec [Honkit](https://github.com/honkit/honkit) (fork maintenu par la communauté), polices CJK et support PlantUML.

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## Démarrage rapide

```bash
docker pull bloodstar/gitbook-builder

# initialiser
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# prévisualiser
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# construire
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

Ajoutez des alias à `.bashrc` ou `.zshrc` :

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## Fonctionnalités

| Fonction | Description |
|----------|-------------|
| **GitBook CLI** | Version classique, patchée pour Node.js 20 |
| **Honkit** | Fork communautaire, compatible book.json |
| **PlantUML** | Diagrammes via OpenJDK 17 + Graphviz |
| **PDF/EPUB** | Conversion via Calibre |
| **Polices CJK** | Noto Sans CJK inclus |
| **Multi-architecture** | linux/amd64, linux/arm/v7, linux/arm64 |

## Utilisation

```bash
# GitBook
gitbook serve    # http://localhost:4000
gitbook build
gitbook pdf .
gitbook epub .

# Honkit (recommandé)
honkit serve
honkit build
honkit pdf .
honkit epub .
```

## Docker Hub

- Image : `bloodstar/gitbook-builder`
- Tags : `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- [Voir les tags](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## Variables d'environnement

| Variable | Défaut | Description |
|----------|--------|-------------|
| `NPM_CONFIG_REGISTRY` | (npm officiel) | Miroir npm. Chine : `https://registry.npmmirror.com` |

```bash
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## Documents

| Document | Contenu |
|----------|---------|
| [docs/GUIDE.md](docs/GUIDE.md) | Utilisation détaillée et plugins |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Architecture et composants |
| [docs/TESTING.md](docs/TESTING.md) | Tests et vérification |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | Historique des versions |
