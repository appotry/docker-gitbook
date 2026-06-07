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

[GitBook](https://github.com/GitbookIO/gitbook) ই-বুক তৈরির জন্য Docker ইমেজ। [Honkit](https://github.com/honkit/honkit) (কমিউনিটি রক্ষণাবেক্ষিত GitBook ফর্ক), CJK ফন্ট, PlantUML সমর্থন সহ।

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## দ্রুত শুরু

```bash
docker pull bloodstar/gitbook-builder

# শুরু
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# প্রিভিউ
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# বিল্ড
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

`.bashrc` বা `.zshrc`-এ alias যোগ করুন:

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## বৈশিষ্ট্য

| বৈশিষ্ট্য | বর্ণনা |
|------------|--------|
| **GitBook CLI** | ক্লাসিক সংস্করণ, Node.js 20-এর জন্য প্যাচকৃত |
| **Honkit** | কমিউনিটি ফর্ক, book.json সামঞ্জস্যপূর্ণ |
| **PlantUML** | OpenJDK 17 + Graphviz ডায়াগ্রাম |
| **PDF/EPUB** | Calibre দ্বারা রূপান্তর |
| **CJK ফন্ট** | Noto Sans CJK অন্তর্ভুক্ত |
| **মাল্টি-আর্ক** | linux/amd64, linux/arm/v7, linux/arm64 |

## ব্যবহার

```bash
# GitBook
gitbook serve    # http://localhost:4000
gitbook build
gitbook pdf .
gitbook epub .

# Honkit (সুপারিশকৃত)
honkit serve
honkit build
honkit pdf .
honkit epub .
```

## Docker Hub

- ইমেজ: `bloodstar/gitbook-builder`
- ট্যাগ: `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- [ট্যাগ দেখুন](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## এনভায়রনমেন্ট ভেরিয়েবল

| ভেরিয়েবল | ডিফল্ট | বর্ণনা |
|-----------|--------|--------|
| `NPM_CONFIG_REGISTRY` | (npm অফিসিয়াল) | npm মিরর। চীনা ব্যবহারকারী: `https://registry.npmmirror.com` |

```bash
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## ডকুমেন্টেশন

| ডকুমেন্ট | বিষয়বস্তু |
|-----------|-----------|
| [docs/GUIDE.md](docs/GUIDE.md) | বিস্তারিত ব্যবহার এবং প্লাগইন |
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | আর্কিটেকচার এবং উপাদান |
| [docs/TESTING.md](docs/TESTING.md) | টেস্টিং এবং ভেরিফিকেশন |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | সংস্করণ ইতিহাস |
