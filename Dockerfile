FROM debian:bullseye-slim
MAINTAINER appotry <andycrusoe@gmail.com>

ENV NPM_CONFIG_LOGLEVEL info

# Install Utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends procps openssh-client git bzip2 curl && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js
# https://github.com/nvm-sh/nvm
RUN apt-get update && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
    nvm install node && \
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