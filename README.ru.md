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

Docker-образ для создания электронных книг [GitBook](https://github.com/GitbookIO/gitbook) с [Honkit](https://github.com/honkit/honkit) (форк сообщества), шрифтами CJK и поддержкой PlantUML.

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## Быстрый старт

```bash
docker pull bloodstar/gitbook-builder

# инициализация
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# просмотр
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# сборка
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

Добавьте алиасы в `.bashrc` или `.zshrc`:

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## Возможности

| Возможность | Описание |
|-------------|----------|
| **GitBook CLI** | Классическая версия, исправлена для Node.js 20 |
| **Honkit** | Форк сообщества, совместим с book.json |
| **PlantUML** | Диаграммы через OpenJDK 17 + Graphviz |
| **PDF/EPUB** | Конвертация через Calibre |
| **Шрифты CJK** | Noto Sans CJK в комплекте |
| **Мульти-архит.** | linux/amd64, linux/arm/v7, linux/arm64 |

## Использование

```bash
# GitBook
gitbook serve    # http://localhost:4000
gitbook build
gitbook pdf .
gitbook epub .

# Honkit (рекомендуется)
honkit serve
honkit build
honkit pdf .
honkit epub .
```

## Docker Hub

- Образ: `bloodstar/gitbook-builder`
- Теги: `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- [Все теги](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## Переменные окружения

| Переменная | По умолч. | Описание |
|------------|-----------|----------|
| `NPM_CONFIG_REGISTRY` | (офиц. npm) | Зеркало npm. Китай: `https://registry.npmmirror.com` |

```bash
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## Документация

| Документ | Содержание |
|----------|-----------|
| [docs/GUIDE.md](docs/GUIDE.md) | Подробное использование и плагины |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | Архитектура и компоненты |
| [docs/TESTING.md](docs/TESTING.md) | Тестирование и проверка |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | История версий |
