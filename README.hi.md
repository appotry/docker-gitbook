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

[GitBook](https://github.com/GitbookIO/gitbook) ई-पुस्तकें बनाने के लिए Docker इमेज। [Honkit](https://github.com/honkit/honkit) (सामुदायिक अनुरक्षित GitBook फ़ोर्क), CJK फ़ॉन्ट, PlantUML समर्थन के साथ।

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## त्वरित आरंभ

```bash
docker pull bloodstar/gitbook-builder

# आरंभ करें
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# पूर्वावलोकन
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# निर्माण
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

`.bashrc` या `.zshrc` में alias जोड़ें:

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## सुविधाएँ

| सुविधा | विवरण |
|---------|--------|
| **GitBook CLI** | क्लासिक संस्करण, Node.js 20 के लिए पैच किया गया |
| **Honkit** | सामुदायिक फ़ोर्क, book.json संगत |
| **PlantUML** | OpenJDK 17 + Graphviz आरेख |
| **PDF/EPUB** | Calibre द्वारा रूपांतरण |
| **CJK फ़ॉन्ट** | Noto Sans CJK शामिल |
| **मल्टी-आर्क** | linux/amd64, linux/arm/v7, linux/arm64 |

## उपयोग

```bash
# GitBook
gitbook serve    # http://localhost:4000
gitbook build
gitbook pdf .
gitbook epub .

# Honkit (अनुशंसित)
honkit serve
honkit build
honkit pdf .
honkit epub .
```

## Docker Hub

- इमेज: `bloodstar/gitbook-builder`
- टैग: `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- [टैग देखें](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## पर्यावरण चर

| चर | डिफ़ॉल्ट | विवरण |
|-----|----------|--------|
| `NPM_CONFIG_REGISTRY` | (npm आधिकारिक) | npm मिरर। चीनी उपयोगकर्ता: `https://registry.npmmirror.com` |

```bash
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## दस्तावेज़

| दस्तावेज़ | सामग्री |
|------------|---------|
| [docs/GUIDE.md](docs/GUIDE.md) | विस्तृत उपयोग और प्लगइन्स |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | आर्किटेक्चर और घटक |
| [docs/TESTING.md](docs/TESTING.md) | परीक्षण और सत्यापन |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | संस्करण इतिहास |
