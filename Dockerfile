# 基础镜像说明：当前用 node:20-bookworm-slim（Debian 12）
# 升级到 node:22-trixie-slim 需先确保镜像可拉取（见 README 升级说明）
FROM node:20-bookworm-slim

LABEL maintainer="andycrusoe@gmail.com"
LABEL repository="https://github.com/appotry/docker-gitbook"
LABEL homepage="https://blog.17lai.site"

LABEL com.github.actions.name="build-gitbook"
LABEL com.github.actions.description="build or deplay your gitbook"
LABEL com.github.actions.icon="book-open"
LABEL com.github.actions.color="white"

ENV TZ=Asia/Shanghai
ENV QTWEBENGINE_DISABLE_SANDBOX=1
ENV NPM_CONFIG_LOGLEVEL=info
ENV NPM_CONFIG_REGISTRY=""
# Mermaid 渲染：mmdc 使用系统 chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV CHROME_BIN=/usr/bin/chromium

# 系统运行时依赖：PlantUML / Calibre / CJK 字体 / Mermaid 渲染
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl git \
    openjdk-17-jre-headless calibre graphviz \
    fonts-noto fonts-noto-cjk locales-all \
    chromium \
    && strip --remove-section=.note.ABI-tag \
        /usr/lib/$(dpkg-architecture -q DEB_HOST_MULTIARCH)/libQt5Core.so.5 || true \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# GitBook CLI + Honkit + 工具 + Mermaid CLI
RUN export PUPPETEER_SKIP_DOWNLOAD='true' && \
    npm install -g gitbook-cli honkit svgexport @mermaid-js/mermaid-cli && \
    if [ -f /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js ]; then \
      sed -i 's/fs.stat = statFix(fs.stat)/\/\/fs.stat = statFix(fs.stat)/g' \
        /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js && \
      sed -i 's/fs.fstat = statFix(fs.fstat)/\/\/fs.fstat = statFix(fs.fstat)/g' \
        /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js && \
      sed -i 's/fs.lstat = statFix(fs.lstat)/\/\/fs.lstat = statFix(fs.lstat)/g' \
        /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js; \
    fi && \
    gitbook --version 2>/dev/null || true && \
    honkit --version && \
    mmdc --version && \
    npm cache clean --force

ENV BOOKDIR=/gitbook

VOLUME $BOOKDIR

EXPOSE 4000

WORKDIR $BOOKDIR

COPY book.json /book.json
COPY entrypoint.sh /entrypoint.sh
COPY userRun.sh /userRun.sh

RUN chmod +x /entrypoint.sh /userRun.sh

CMD ["gitbook", "--help"]
