# 基础镜像说明：node:22-trixie-slim（Debian 13, Node.js 22 LTS）
FROM node:22-trixie-slim

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
# 构建时可覆盖的 npm 镜像源（如 https://registry.npmmirror.com）
ARG NPM_CONFIG_REGISTRY=""
ENV NPM_CONFIG_REGISTRY=${NPM_CONFIG_REGISTRY}
# Mermaid 渲染：mmdc 使用系统 chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV CHROME_BIN=/usr/bin/chromium

# 系统运行时依赖：PlantUML / Calibre / CJK 字体 / Mermaid 渲染
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl git \
    openjdk-21-jre-headless calibre graphviz \
    fonts-noto fonts-noto-cjk locales-all \
    chromium \
    && strip --remove-section=.note.ABI-tag \
        /usr/lib/$(dpkg-architecture -q DEB_HOST_MULTIARCH)/libQt5Core.so.5 || true \
    && strip --remove-section=.note.ABI-tag \
        /usr/lib/$(dpkg-architecture -q DEB_HOST_MULTIARCH)/libQt6Core.so.6 || true \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# GitBook CLI + Honkit + 工具 + Mermaid CLI
RUN export PUPPETEER_SKIP_DOWNLOAD='true' && \
    npm install -g gitbook-cli honkit svgexport @mermaid-js/mermaid-cli && \
    for POLY in \
      /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js \
      /usr/local/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js; do \
      if [ -f "$POLY" ]; then \
        sed -i 's/fs.stat = statFix(fs.stat)/\/\/fs.stat = statFix(fs.stat)/g' "$POLY" && \
        sed -i 's/fs.fstat = statFix(fs.fstat)/\/\/fs.fstat = statFix(fs.fstat)/g' "$POLY" && \
        sed -i 's/fs.lstat = statFix(fs.lstat)/\/\/fs.lstat = statFix(fs.lstat)/g' "$POLY"; \
      fi; \
    done && \
    gitbook --version 2>/dev/null || true && \
    honkit --version && \
    mmdc --version && \
    npm cache clean --force

# PlantUML：下载官方 jar（java + graphviz 已在 apt 层安装）
RUN mkdir -p /usr/share/plantuml && \
    curl -fsSL -o /usr/share/plantuml/plantuml.jar \
      "https://github.com/plantuml/plantuml/releases/download/v1.2024.7/plantuml-1.2024.7.jar" && \
    echo '#!/bin/sh' > /usr/local/bin/plantuml && \
    echo 'exec java -jar /usr/share/plantuml/plantuml.jar "$@"' >> /usr/local/bin/plantuml && \
    chmod +x /usr/local/bin/plantuml && \
    java -jar /usr/share/plantuml/plantuml.jar -version | head -2

# Mermaid：root 用户下 Chromium 需 --no-sandbox（用户可用 -p 覆盖此配置）
RUN rm -f /usr/local/bin/mmdc && \
    echo '{"args": ["--no-sandbox"]}' > /puppeteer-config.json && \
    echo '#!/bin/sh' > /usr/local/bin/mmdc && \
    echo 'exec node /usr/local/lib/node_modules/@mermaid-js/mermaid-cli/src/cli.js -p /puppeteer-config.json "$@"' >> /usr/local/bin/mmdc && \
    chmod +x /usr/local/bin/mmdc && \
    mmdc --version

ENV BOOKDIR=/gitbook
ENV NODE_PATH=/gitbook/node_modules

VOLUME $BOOKDIR

EXPOSE 4000

WORKDIR $BOOKDIR

COPY book.json /book.json
COPY entrypoint.sh /entrypoint.sh
COPY userRun.sh /userRun.sh

RUN chmod +x /entrypoint.sh /userRun.sh

CMD ["gitbook", "--help"]
