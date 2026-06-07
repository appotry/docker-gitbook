# docker-gitbook-builder

<p align="center">
  <a href="README.md">中文</a> ·
  <a href="README.en.md">English</a> ·
  <a href="README.ja.md">日本語</a> ·
  <a href="README.ko.md">한국어</a>
</p>

[GitBook](https://github.com/GitbookIO/gitbook) 전자책을 빌드하기 위한 Docker 이미지.[Honkit](https://github.com/honkit/honkit)(커뮤니티 유지보수 GitBook 포크), CJK 폰트, PlantUML 지원을 내장.

[![Docker Image](https://img.shields.io/docker/pulls/bloodstar/gitbook-builder)](https://hub.docker.com/r/bloodstar/gitbook-builder)

## 빠른 시작

```bash
docker pull bloodstar/gitbook-builder

# 초기화
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# 미리보기
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# 빌드
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

별칭을 `.bashrc` 또는 `.zshrc`에 추가:

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
alias honkit='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder honkit'
```

## 기능

| 기능 | 설명 |
|------|------|
| **GitBook CLI** | 레거시 버전, Node.js 20 호환 패치 적용 |
| **Honkit** | 커뮤니티 유지보수 버전, 완전 호환 |
| **PlantUML** | OpenJDK 17 + Graphviz 다이어그램 렌더링 |
| **PDF/EPUB** | Calibre 전자책 변환 |
| **CJK 폰트** | Noto Sans CJK 지원 |
| **멀티 아키텍처** | linux/amd64, linux/arm/v7, linux/arm64 |

## 사용 예시

```bash
# GitBook
gitbook serve    # http://localhost:4000
gitbook build
gitbook pdf .
gitbook epub .

# Honkit（권장）
honkit serve
honkit build
honkit pdf .
honkit epub .
```

## Docker Hub

- 이미지: `bloodstar/gitbook-builder`
- 자동 태그: `latest`, `gitbook-<version>`, `honkit-<major>`, `honkit-<major>.<minor>`, `honkit-<full>`
- 릴리스 태그（git tag push）: `v<semver>`（예: `v0.2.0`）
- [태그 목록](https://hub.docker.com/r/bloodstar/gitbook-builder/tags)

## 환경 변수

| 변수 | 기본값 | 설명 |
|------|--------|------|
| `NPM_CONFIG_REGISTRY` | （비어 있음, npm 공식 사용） | npm 레지스트리 URL. 중국 사용자는 `https://registry.npmmirror.com` 설정 |

```bash
# 예시: Taobao npm 미러 사용
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder honkit install
```

## 관련 문서

| 문서 | 내용 |
|---|---|
| [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) | 구성 요소, 기술 스택, 빌드 흐름 |
| [docs/TESTING.md](docs/TESTING.md) | 빌드 검증 및 테스트 방법 |
| [docs/CHANGELOG.md](docs/CHANGELOG.md) | 버전 기록 |
| [README.md](README.md) | 中文 |
| [README.en.md](README.en.md) | English |
| [README.ja.md](README.ja.md) | 日本語 |
