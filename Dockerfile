FROM node:20-slim

LABEL maintainer="andycrusoe@gmail.com"
LABEL repository="https://github.com/appotry/docker-gitbook"
LABEL homepage="https://blog.17lai.site"

LABEL com.github.actions.name="build-gitbook"
LABEL com.github.actions.description="build or deplay your gitbook"
LABEL com.github.actions.icon="book-open"
LABEL com.github.actions.color="white"

ENV TZ=Asia/Shanghai
ENV QTWEBENGINE_DISABLE_SANDBOX=1

ENV GIT_USERNAME="" \
    GIT_USEREMAIL="" \
    GIT_TOKEN="" \
    GIT_REPO="" \
    GIT_BRANCH="gh-pages" \
    GIT_COMMIT_MESSAGE="Gitbook updated:"

ENV NPM_CONFIG_LOGLEVEL=info
ENV NPM_CONFIG_REGISTRY=""

# 系统运行时依赖：PlantUML / Calibre / CJK 字体
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl git \
    openjdk-17-jre-headless calibre graphviz \
    fonts-noto fonts-noto-cjk locales-all \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# GitBook CLI + Honkit + 工具
RUN export PUPPETEER_SKIP_DOWNLOAD='true' && \
    npm install -g gitbook-cli honkit svgexport && \
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
