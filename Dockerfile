FROM debian:bullseye-slim
MAINTAINER appotry <andycrusoe@gmail.com>

LABEL maintainer="andycrusoe@gmail.com"
LABEL repository="https://github.com/appotry/docker-gitbook"
LABEL homepage="https://blog.17lai.site"

LABEL com.github.actions.name="build-gitbook"
LABEL com.github.actions.description="build or deplay your gitbook"
LABEL com.github.actions.icon="book-open"
LABEL com.github.actions.color="white"

ENV TZ=Asia/Shanghai

ENV GIT_USERNAME="" \
    GIT_USEREMAIL="" \
    GIT_TOKEN="" \
    GIT_REPO="" \
    GIT_BRANCH="gh-pages" \
    GIT_COMMIT_MESSAGE="Gitbook updated:"

ENV NPM_CONFIG_LOGLEVEL info

# Install Utilities
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install build-essential -y && \
    apt-get install -y --no-install-recommends procps ca-certificates openssl openssh-client git bzip2 curl vim yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js
# https://github.com/nvm-sh/nvm
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash && \
    apt-get update && \
    apt-get install -y nodejs && \
    node -v && \
    npm -v && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Install Gitbook
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org && \
    npm install gitbook-cli -g && \
    npm install svgexport -g && \
    gitbook ls && \
    sed -i 's/fs.stat\ =\ statFix(fs.stat)/\/\/fs.stat\ =\ statFix(fs.stat)/g' /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js && \
    sed -i 's/fs.fstat\ =\ statFix(fs.fstat)/\/\/fs.fstat\ =\ statFix(fs.fstat)/g' /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js && \
    sed -i 's/fs.lstat\ =\ statFix(fs.lstat)/\/\/fs.lstat\ =\ statFix(fs.lstat)/g' /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js && \
    cat /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js && \
    gitbook -V && \
    npm cache clean --force

# ## Install OpenJDK
RUN apt-get install -y --no-install-recommends openjdk-11-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Install Calibre
RUN apt-get install -y --no-install-recommends calibre fonts-noto fonts-noto-cjk locales-all && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Install Graphviz for PlantUML
RUN apt-get install -y --no-install-recommends graphviz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV BOOKDIR /gitbook

VOLUME $BOOKDIR

EXPOSE 4000

WORKDIR $BOOKDIR

COPY book.json book.json
COPY entrypoint.sh /entrypoint.sh
COPY userRun.sh /userRun.sh

RUN chmod +x /entrypoint.sh && \
    chmod +x /userRun.sh

# ENTRYPOINT ["/entrypoint.sh"]
CMD ["gitbook", "--help"]