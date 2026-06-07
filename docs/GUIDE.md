# GitBook / Honkit 使用指南

## 基本命令

```bash
# 初始化项目
gitbook init
# 或
honkit init

# 本地预览（访问 http://localhost:4000）
gitbook serve
honkit serve

# 构建静态网站
gitbook build
honkit build

# 输出 PDF / EPUB（需 Calibre）
gitbook pdf .
gitbook epub .
honkit pdf .
honkit epub .
```

## 插件系统

GitBook 和 Honkit 通过 `book.json` 配置插件。

### 配置插件

```json
{
  "plugins": ["prism", "-highlight", "favicon"],
  "pluginsConfig": {
    "prism": {
      "css": ["prismjs/themes/prism-solarizedlight.css"]
    }
  }
}
```

插件名前加 `-` 表示禁用默认插件。例如 `"-highlight"` 禁用默认高亮插件，改用 `prism`。

### 安装插件

插件通常在构建时自动安装。如需手动安装：

```bash
# 进入容器手动安装
docker run --rm -v "$PWD":/gitbook bloodstar/gitbook-builder npm install gitbook-plugin-prism

# 或使用 cnpm（淘宝镜像加速）
docker run --rm -v "$PWD":/gitbook bloodstar/gitbook-builder cnpm install gitbook-plugin-prism
```

### 常用插件

| 插件 | 用途 | 说明 |
|------|------|------|
| `prism` | 代码高亮 | 替代默认 highlight，支持更多语言 |
| `favicon` | 自定义网站图标 | 设置浏览器标签页图标 |
| `page-treeview` | 页面目录树 | 侧边栏展示页面层级 |
| `tbfed-pagefooter` | 页脚信息 | 显示版权和修订时间 |
| `expandable-chapters` | 可折叠章节 | 侧边栏章节可展开/收起 |
| `github-buttons` | GitHub 按钮 | 添加 Star/Fork 按钮 |
| `mermaid` | 流程图/时序图 | 基于 Mermaid 的图表渲染 |
| `mathjax` | 数学公式 | LaTeX 公式渲染 |
| `anchor-navigation` | 锚点导航 | 页面内锚点跳转导航 |
| `search-pro` | 增强搜索 | 中文友好搜索插件 |

### 从 GitBook 迁移到 Honkit

`book.json` 和目录结构完全兼容，直接切换命令即可：

```bash
# 原 GitBook 命令
gitbook serve

# 迁移后
honkit serve
```

无需修改任何配置文件。

## 镜像加速

### 方式一：环境变量（推荐）

运行时设置 npm 镜像源：

```bash
docker run --rm -v "$PWD":/gitbook \
  -e NPM_CONFIG_REGISTRY=https://registry.npmmirror.com \
  bloodstar/gitbook-builder npm install
```

### 方式二：使用 cnpm

镜像内置 `cnpm`（淘宝镜像专用）：

```bash
docker run --rm -v "$PWD":/gitbook bloodstar/gitbook-builder cnpm install gitbook-plugin-prism
```

### 方式三：持久化缓存

挂载缓存目录可加速多次构建：

```bash
docker run --rm -v "$PWD":/gitbook \
  -v npm-cache:/root/.npm \
  bloodstar/gitbook-builder npm install
```

## 常见问题

### 构建报错 `cb() never called`

GitBook CLI 在 Node.js 20 上的已知问题，此镜像已通过补丁修复。如果遇到，尝试使用 Honkit：

```bash
honkit build
```

### 中文显示为方框

此镜像已安装 Noto CJK 字体，中文显示正常。如果自定义字体，在 Dockerfile 中添加：

```dockerfile
RUN apt-get install -y fonts-noto-cjk
```

### PlantUML 不渲染

确认在 `book.json` 中正确配置了 PlantUML 插件：

```json
{
  "plugins": ["plantuml"]
}
```

PlantUML 需要 Java 和 Graphviz，均已预装在此镜像中。
