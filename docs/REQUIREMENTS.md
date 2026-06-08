# 需求说明

## ✅ 功能需求

| 编号 | 需求 | 对应工具 |
|------|------|----------|
| F1 | 构建 GitBook HTML 输出 | gitbook build / honkit build |
| F2 | 在 4000 端口提供预览服务 | gitbook serve / honkit serve |
| F3 | 生成 PDF 输出 | gitbook pdf / honkit pdf（基于 Calibre） |
| F4 | 生成 EPUB 输出 | gitbook epub / honkit epub（基于 Calibre） |
| F5 | 初始化 GitBook 项目 | gitbook init / honkit init |
| F6 | 渲染 PlantUML 图表 | OpenJDK 17 + Graphviz |
| F7 | PDF/EPUB 中正确显示中日韩文字 | Noto CJK 字体 |

## 🔒 非功能需求

| 编号 | 需求 | 目标 |
|------|------|------|
| N1 | 多架构支持 | linux/amd64、linux/arm/v7、linux/arm64 |
| N2 | 每周自动重建 | 每周日 01:10 UTC，通过 GitHub Actions |
| N3 | GitBook CLI 在 Node 20 上可用 | 构建时修补 graceful-fs 补丁 |
| N4 | 国内网络友好 | 支持运行时设置 NPM_CONFIG_REGISTRY 切换国内镜像源 |
| N5 | 最小化镜像层数 | 相关操作合并到同一 RUN 指令 |
