FROM debian:bullseye-slim
MAINTAINER appotry <andycrusoe@gmail.com>

ENV NPM_CONFIG_LOGLEVEL info

# Install Utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends procps openssh-client git bzip2 && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN apt-get update && \
    apt-get install -y --no-install-recommends npm nodejs && \
    ln -s /usr/bin/nodejs /usr/local/bin/node && \
    mkdir -p /usr/lib/node_modules && ln -s /usr/lib/node_modules /usr/local/lib && \
    rm -rf /var/lib/apt/lists/*

## Install Gitbook
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org && \
    cnpm install gitbook-cli -g && \
    cnpm install svgexport -g && \
    npm cache clean --force

# ## Install OpenJDK
RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-11-jre-headless && \
    rm -rf /var/lib/apt/lists/*

## Install Calibre
RUN apt-get update && \
    apt-get install -y --no-install-recommends calibre fonts-noto fonts-noto-cjk locales-all && \
    rm -rf /var/lib/apt/lists/*

## Install Graphviz for PlantUML
RUN apt-get update && \
    apt-get install -y --no-install-recommends graphviz && \
    rm -rf /var/lib/apt/lists/*

ENV BOOKDIR /gitbook

VOLUME $BOOKDIR

EXPOSE 4000

WORKDIR $BOOKDIR

CMD ["gitbook", "--help"]