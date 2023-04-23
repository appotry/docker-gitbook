# docker-gitbook-builder

A Docker Image for building ebook with [Gitbook](https://github.com/GitbookIO/gitbook) and [Noto CJK Fonts](https://www.google.com/get/noto/).

Docker Hub: [https://hub.docker.com/r/bloodstar/gitbook-builder/](https://hub.docker.com/r/bloodstar/gitbook-builder/)
Github: [docker-gitbook](https://github.com/appotry/docker-gitbook)

## debian 加速

```bash
echo "===add debian 国内源==="
sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
```

## Basic

Read the official documentation [GitbookIO/gitbook](https://github.com/GitbookIO/gitbook#how-to-use-it) first.

> Docker Pull

```bash
docker pull bloodstar/gitbook-builder
```

```bash
# run
docker run -ti --name="gitbook-builder" -v "$PWD:/gitbook" bloodstar/gitbook-builder /bin/bash
```

## Usage

Read the official [GitBook Toolchain Documentation](http://toolchain.gitbook.com/) documentation [GitbookIO/gitbook](https://github.com/GitbookIO/gitbook#how-to-use-it) first.

```bash
# init
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook init
# serve
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook serve
# build
docker run --rm -v "$PWD:/gitbook" -p 4000:4000 bloodstar/gitbook-builder gitbook build
```

For short, you can use alias for the long command line text. Place the alias statement in your `.bashrc` or `.zshrc`.

```bash
alias gitbook='docker run --rm -v "$PWD":/gitbook -p 4000:4000 bloodstar/gitbook-builder gitbook'
# init
gitbook init
# serve
gitbook serve
# build
gitbook build
# pdf output
gitbook pdf .
```

### Integrate with Gitlab CI

This docker image is originally designed for generating ebook with [Gitlab CI](https://about.gitlab.com/gitlab-ci/). You could configure your Gitlab CI as following:

```yml
before_script:
  - env
  - export LC_ALL=zh_CN.UTF-8

stages:
  - build

ebook:
  stage: build
  script:
    - gitbook pdf
  artifacts:
    paths:
      - book.pdf
  only:
    - master
  tags:
    - gitbook
  image: bloodstar/gitbook-builder:latest
  allow_failure: true
```

## Additional Features

This docker image also has [OpenJDK 11](http://openjdk.java.net) installed. The Java runtime allows you to run Gitbook [PlantUML](http://plantuml.com) plugin.

## Customization

To install your own favorite fonts, add the following RUN command in Dockerfile

```bash
## Install Fonts
RUN apt-get update && \
    apt-get install -y --no-install-recommends your-favorite-fonts && \
    rm -rf /var/lib/apt/lists/*
```

## Acknowledge

The project is sponsored under **Productivity Side Project** plan of [ECOWORK Inc.](http://www.ecowork.com/)

[ECOWORK](http://www.ecowork.com/) is a Taiwan-based software and service company and is also hiring now:

* **Cloud Architect**, Cloud Arch Team
* **Cloud Platform Engineer**, Cloud Arch Team
* **iOS/Android Engineer,** Mobile Team
* **Ruby/Go/Node Engineer**, Application Team
* **Operation Engineer**, Service Team

The working location of the above opportunities is Taipei, Taiwan. Resume and inquiry are welcome to resume@ecoworkinc.com.
