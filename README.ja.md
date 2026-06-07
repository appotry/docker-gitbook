# docker-gitbook-builder

<p align="center">
  <a href="README.md">中文</a> ·
  <a href="README.en.md">English</a> ·
  <a href="README.ja.md">日本語</a> ·
  <a href="README.ko.md">한국어</a>
</p>

[GitBook](https://github.com/GitbookIO/gitbook) 電子書籍を構築するための Docker イメージ。[Honkit](https://github.com/honkit/honkit)（コミュニティ保守版 GitBook）、CJK フォント、PlantUML 対応を内蔵。

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## クイックスタート

```bash
docker pull bloodstar/gitbook-builder

# 初期化
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# プレビュー
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# ビルド
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

エイリアスを `.bashrc` または `.zshrc` に追加：

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## 機能

| 機能 | 説明 |
|------|------|
| **GitBook CLI** | レガシーバージョン、Node.js 20 対応済み |
| **Honkit** | コミュニティ保守版、互換性あり |
| **PlantUML** | OpenJDK 17 + Graphviz による図表レンダリング |
| **PDF/EPUB** | Calibre による電子書籍変換 |
| **CJK フォント** | Noto Sans CJK 搭載 |
| **マルチアーキ** | linux/amd64, linux/arm/v7, linux/arm64 |

## 使用例

```bash
# GitBook
gitbook serve    # http://localhost:4000
gitbook build
gitbook pdf .
gitbook epub .

# Honkit（推奨）
honkit serve
honkit build
honkit pdf .
honkit epub .
```

## Docker Hub

- イメージ: `bloodstar/gitbook-builder`
- 自動タグ: `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- リリースタグ（git tag push）: `v<semver>`（例: `v0.2.0`）
- [タグ一覧](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## 環境変数

| 変数 | デフォルト | 説明 |
|------|-----------|------|
| `NPM_CONFIG_REGISTRY` | （空、npm 公式を使用） | npm レジストリURL。中国ユーザーは `https://registry.npmmirror.com` に設定 |

```bash
# 例：淘宝 npm ミラーを使用
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## 関連ドキュメント

| ドキュメント | 内容 |
|---|---|
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | コンポーネント、技術スタック、ビルドフロー |
| [docs/TESTING.md](docs/TESTING.md) | ビルド検証とテスト方法 |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | バージョン履歴 |
| [README.md](README.md) | 中文 |
| [README.en.md](README.en.md) | English |
| [README.ko.md](README.ko.md) | 한국어 |
