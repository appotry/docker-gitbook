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

صورة Docker لبناء كتب [GitBook](https://github.com/GitbookIO/gitbook) الإلكترونية، مع [Honkit](https://github.com/honkit/honkit) (نسخة المجتمع)، وخطوط CJK، ودعم PlantUML.

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## بدء سريع

```bash
docker pull bloodstar/gitbook-builder

# تهيئة
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# معاينة
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# بناء
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

أضف اختصارات إلى `.bashrc` أو `.zshrc`:

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## الميزات

| الميزة | الوصف |
|--------|-------|
| **GitBook CLI** | الإصدار الكلاسيكي، محدث لـ Node.js 20 |
| **Honkit** | نسخة المجتمع، متوافقة مع book.json |
| **PlantUML** | رسومات بيانية بـ OpenJDK 17 + Graphviz |
| **PDF/EPUB** | تحويل الكتب بـ Calibre |
| **خطوط CJK** | Noto Sans CJK مدمجة |
| **متعدد المعماريات** | linux/amd64, linux/arm/v7, linux/arm64 |

## الاستخدام

```bash
# GitBook
gitbook serve    # http://localhost:4000
gitbook build
gitbook pdf .
gitbook epub .

# Honkit (موصى به)
honkit serve
honkit build
honkit pdf .
honkit epub .
```

## Docker Hub

- الصورة: `bloodstar/gitbook-builder`
- الوسوم: `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- [عرض الوسوم](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## متغيرات البيئة

| المتغير | الافتراضي | الوصف |
|---------|----------|-------|
| `NPM_CONFIG_REGISTRY` | (npm الرسمي) | مرآة npm. للمستخدمين الصينيين: `https://registry.npmmirror.com` |

```bash
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## المستندات

| المستند | المحتوى |
|----------|---------|
| [docs/GUIDE.md](docs/GUIDE.md) | الاستخدام التفصيلي والإضافات |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | المعمارية والمكونات |
| [docs/TESTING.md](docs/TESTING.md) | الاختبار والتحقق |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | سجل الإصدارات |
