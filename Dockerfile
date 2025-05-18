FROM debian:bookworm-slim
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

# build-essential
# Install Utilities
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends procps build-essential ca-certificates gnupg openssl openssh-client git bzip2 curl vim yarn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js
# https://github.com/nvm-sh/nvm
# RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
#     apt-get update && \
#     apt-get install -y --no-install-recommends nodejs && \
#     npm install -g npm && \
#     node -v && \
#     npm -v && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# https://github.com/nodesource/distributions?tab=readme-ov-file#installation-instructions
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    NODE_MAJOR=20 && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install -g npm && \
    node -v && \
    npm -v && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Install Gitbook
RUN npm install -g cnpm --registry=http://registry.npmmirror.com && \
    export PUPPETEER_SKIP_DOWNLOAD='true' && \
    npm install gitbook-cli -g && \
    npm install svgexport -g && \
    sed -i 's/fs.stat\ =\ statFix(fs.stat)/\/\/fs.stat\ =\ statFix(fs.stat)/g' /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js && \
    sed -i 's/fs.fstat\ =\ statFix(fs.fstat)/\/\/fs.fstat\ =\ statFix(fs.fstat)/g' /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js && \
    sed -i 's/fs.lstat\ =\ statFix(fs.lstat)/\/\/fs.lstat\ =\ statFix(fs.lstat)/g' /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js && \
    cat /usr/lib/node_modules/gitbook-cli/node_modules/npm/node_modules/graceful-fs/polyfills.js && \
    gitbook ls && \
    npm cache clean --force
# gitbook fetch && \

# ## Install OpenJDK
RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-17-jre-headless  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Install Calibre for epub、pdf
RUN apt-get update && \
    apt-get install -y --no-install-recommends calibre fonts-noto fonts-noto-cjk locales-all && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Install Graphviz for PlantUML
RUN apt-get update && \
    apt-get install -y --no-install-recommends graphviz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV BOOKDIR /gitbook

VOLUME $BOOKDIR

EXPOSE 4000

WORKDIR $BOOKDIR

COPY book.json /book.json
COPY entrypoint.sh /entrypoint.sh
COPY userRun.sh /userRun.sh

RUN chmod +x /entrypoint.sh && \
    chmod +x /userRun.sh

# ENTRYPOINT ["/entrypoint.sh"]
CMD ["gitbook", "--help"]
