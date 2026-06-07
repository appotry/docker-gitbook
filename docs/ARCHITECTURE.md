# 架构说明

## 概述

这是一个单一用途的 Docker 镜像，提供构建 GitBook 电子书的完整环境。本仓库不含应用程序代码——"产品"就是 Docker 镜像本身，发布到 Docker Hub 的 `bloodstar/gitbook-builder`。

## 技术栈

```
debian:bookworm-slim
├── Node.js 20          # 通过 NodeSource 安装，非 nvm
├── GitBook CLI         # 经典版本，已打补丁兼容 Node.js 20
├── Honkit              # 社区维护版本，与 GitBook 完全兼容
├── OpenJDK 17 JRE      # 用于 PlantUML 插件
├── Calibre             # 电子书格式转换（epub、pdf）
├── Graphviz            # PlantUML 图表渲染
├── Noto CJK 字体       # 中日韩文字排版
└── cnpm                # 国内 npm 镜像源
```

## 构建流程

1. Debian 基础镜像 → 安装系统包（build-essential、git、curl、yarn）
2. 添加 NodeSource 仓库 → 安装 Node.js 20
3. 安装 npm 全局包：gitbook-cli、honkit、svgexport、cnpm
4. 修补 gitbook-cli 自带的 graceful-fs（注释 3 处 statFix 代码）
5. 安装 OpenJDK 17 JRE
6. 安装 Calibre + Noto CJK 字体
7. 安装 Graphviz
8. 复制 book.json、entrypoint.sh、userRun.sh
9. 设置工作目录为 `/gitbook`

## CI/CD 流水线

GitHub Actions 构建镜像工作流：

- **触发条件**：推送 main/master、推送 `v*` 标签、每周日 01:10 UTC、手动触发
- **多架构构建**：linux/amd64、linux/arm/v7、linux/arm64，通过 QEMU + Buildx
- **推送目标**：Docker Hub `bloodstar/gitbook-builder`
- **自动标签**：`latest`、`gitbook-<版本>`、`honkit-<主版本>`、`honkit-<主>.<次>`、`honkit-<完整版本>`
- **版本标签**：推送 git tag 时额外生成 `v<语义化版本>`
- **版本来源**：gitbook-cli 和 honkit 版本从 npm registry 自动获取（`npm view gitbook-cli version` + `npm view honkit version`）
- **认证**：DOCKER_USERNAME + DOCKER_PASSWORD 密钥

## 运行时

- 默认命令：`gitbook --help`（`honkit` 也可用）
- 入口脚本 `entrypoint.sh` 存在但**已禁用**（ENTRYPOINT 被注释）
- 挂载卷：`/gitbook`（工作区）
- 暴露端口：4000（用于 `gitbook serve` / `honkit serve`）
- 关键环境变量：`GIT_USERNAME`、`GIT_USEREMAIL`、`GIT_TOKEN`、`GIT_REPO`、`GIT_BRANCH`（默认 gh-pages）、`GIT_COMMIT_MESSAGE`
- **npm 镜像源**：默认使用官方源。设置 `NPM_CONFIG_REGISTRY=https://registry.npmmirror.com` 可切换为国内淘宝镜像

## 设计决策

| 决策 | 理由 |
|------|------|
| 选用 Debian 而非 Alpine | Calibre 包可用性要求；兼容性更好 |
| 使用 NodeSource 而非 nvm | Dockerfile 更简洁，无需版本管理器 |
| 同时保留 gitbook + honkit | 向后兼容 + 现代替代方案 |
| graceful-fs 补丁 | GitBook CLI 在 Node 20 上会崩溃 |
| 入口脚本禁用 | 保持镜像简洁，多数用户直接使用 docker run |
| `cnpm` 从默认源安装 | 不再硬编码淘宝源，用户可按需配置 |
| Entrypoint disabled | Keeps the image simple; most users use docker run directly |
