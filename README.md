# docker-gitbook-builder

部分实现参考 [pcit-plugins/pcit-gitbook](https://github.com/pcit-plugins/pcit-gitbook)

A Docker Image for building ebook with [Gitbook](https://github.com/GitbookIO/gitbook) and [Noto CJK Fonts](https://www.google.com/get/noto/).

Docker Hub: [https://hub.docker.com/r/bloodstar/gitbook-builder/](https://hub.docker.com/r/bloodstar/gitbook-builder/)

## Basic

Read the official documentation [GitbookIO/gitbook](https://github.com/GitbookIO/gitbook#how-to-use-it) first.

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
  - export LC_ALL=zh_TW.UTF-8

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
  image: shuoshuo/gitbook-builder:latest
  allow_failure: true
```

### Deploy

```bash
$ docker run -it --rm \
    -v $PWD:/gitbook \
    -v ~/.ssh:/gitbook/.ssh \
    -e GIT_USERNAME=username \
    -e GIT_USEREMAIL=username@domain.com \
    -e GIT_REPO=git@github.com:username/repo \
    -e GIT_BRANCH=master \
    bloodstar/gitbook-builder \
    deploy
```

有两种验证方式，第一种像上面一样挂载 ssh 文件，使用 `ssh` 方式验证，第二种方式你可以通过 `TOKEN` 验证。

```bash
$ docker run -it --rm \
    -v $PWD:/gitbook \
    -e GIT_USERNAME=username \
    -e GIT_USEREMAIL=username@domain.com \
    -e GIT_TOKEN=mytoken \
    -e GIT_REPO=github.com/username/repo \
    -e GIT_BRANCH=master \
    bloodstar/gitbook-builder \
    deploy
```

### [GitHub Actions](https://help.github.com/en/categories/automating-your-workflow-with-github-actions)

```yaml
- name: GitBook Build
  uses: docker://bloodstar/gitbook-builder
  with:
    args: 'gitbook build'
- name: GitBook Deploy
  uses: docker://bloodstar/gitbook-builder
  if: github.event_name == 'push'
  with:
    args: deploy
  env:
    GIT_USERNAME: "yourname"
    GIT_USEREMAIL: "youremail@gmail.com"
    GIT_BRANCH: "gh-pages"
    GITHUB_TOKEN: ${{ secrets.MY_GITHUB_TOKEN }}
    # 如果使用默认的 ${{ secrets.GITHUB_TOKEN }} 推送之后，pages 服务不会自动构建
    # 造成 pages 服务不能使用
    # 故请使用自己的 Token，请自行到 GitHub 页面生成 Token

    # GIT_REPO: github.com/username/repo
    # 这个变量在 GitHub Actions 中自动识别，无需传入。
    # 如果你需要将 gitbook 生成的页面推送到别的仓库，你可以传入该变量
    # GIT_TOKEN:
    # 传入了 GIT_REPO 变量，必须传入 GIT_TOKEN 变量
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
