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

Imagem Docker para construir livros eletrônicos [GitBook](https://github.com/GitbookIO/gitbook), com [Honkit](https://github.com/honkit/honkit) (fork comunitário), fontes CJK e suporte PlantUML.

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## Início rápido

```bash
docker pull bloodstar/gitbook-builder

# iniciar
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# pré-visualizar
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# construir
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

Adicione aliases ao `.bashrc` ou `.zshrc`:

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## Recursos

| Recurso | Descrição |
|---------|-----------|
| **GitBook CLI** | Versão clássica, adaptada para Node.js 20 |
| **Honkit** | Fork comunitário, compatível com book.json |
| **PlantUML** | Diagramas com OpenJDK 17 + Graphviz |
| **PDF/EPUB** | Conversão com Calibre |
| **Fontes CJK** | Noto Sans CJK incluso |
| **Multi-arquitetura** | linux/amd64, linux/arm/v7, linux/arm64 |

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

- Imagem: `bloodstar/gitbook-builder`
- Tags: `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- [Ver tags](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## Variáveis de ambiente

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `NPM_CONFIG_REGISTRY` | (npm oficial) | Espelho npm. Usuários chineses: `https://registry.npmmirror.com` |

```bash
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## Documentos

| Documento | Conteúdo |
|-----------|----------|
| [docs/GUIDE.md](docs/GUIDE.md) | Uso detalhado e plugins |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Arquitetura e componentes |
| [docs/TESTING.md](docs/TESTING.md) | Testes e verificação |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | Histórico de versões |
