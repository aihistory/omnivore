# Omnivore

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/omnivore-app/omnivore/run-tests.yaml?branch=main)](https://github.com/omnivore-app/omnivore/actions/workflows/run-tests.yaml)
[![Discord](https://img.shields.io/discord/844965259462311966?label=加入我们的Discord)](https://discord.gg/h2z5rppzz9)
[![Mastodon Follow](https://img.shields.io/mastodon/follow/109458738600914558?domain=https%3A%2F%2Fpkm.social)](https://pkm.social/@omnivore)
[![Twitter Follow](https://img.shields.io/twitter/follow/omnivoreapp)](https://twitter.com/OmnivoreApp)
![GitHub](https://img.shields.io/github/license/omnivore-app/omnivore)

<img align="right" src="https://avatars.githubusercontent.com/u/70113176?s=400&u=506b21d9f019f3160963c010ef363667fb24c7c9&v=4" height="150px" alt="Omnivore Logo">

[Omnivore](https://omnivore.app) 是一个完整的、开源的稍后阅读解决方案，专为喜欢文本阅读的用户而设计。

我们构建 Omnivore 是因为我们热爱阅读，并希望它更加社交化。加入我们吧！

## 🌟 主要功能

- 高亮、笔记、搜索和分享
- 完整的键盘导航
- 自动保存长文章的阅读进度
- 通过邮件添加新闻通讯文章（支持 Substack！）
- PDF 支持
- [Web 应用](https://omnivore.app/) 使用 Node.js 和 TypeScript 构建
- [原生 iOS 应用](https://omnivore.app/install/ios) ([源码](https://github.com/omnivore-app/omnivore/tree/main/apple))
- [Android 应用](https://omnivore.app/install/android) ([源码](https://github.com/omnivore-app/omnivore/tree/main/android/Omnivore))
- Android 用户的渐进式 Web 应用
- 浏览器扩展：[Chrome](https://omnivore.app/install/chrome)、[Safari](https://omnivore.app/install/safari)、[Firefox](https://omnivore.app/install/firefox) 和 [Edge](https://omnivore.app/install/edge)
- 标签（标签分类）
- 离线支持
- 文本转语音（仅限 iOS）
- [Logseq](https://logseq.com/) 支持，通过我们的 [Logseq 插件](https://github.com/omnivore-app/logseq-omnivore)
- [Obsidian](https://obsidian.md/) 支持，通过我们的 [Obsidian 插件](https://github.com/omnivore-app/obsidian-omnivore)

每个部分都是完全开源的！您可以分叉、扩展或部署到自己的服务器。

自托管服务器运行指南可以在[这里](./self-hosting/GUIDE.md)找到

<img width="981" alt="web-screenshot-listview" src="https://github.com/omnivore-app/omnivore/assets/75189/df7c797a-4255-42f4-a686-ad94866cb580">

## 加入我们的 Discord！💬

我们在 Discord 上建立社区。[加入我们！](https://discord.gg/h2z5rppzz9)

在我们的博客上了解更多关于 Omnivore 的信息：<https://blog.omnivore.app/p/getting-started-with-omnivore>

## 致谢 🎉

Omnivore 利用了以下优秀的开源软件：

- [TypeScript](https://www.typescriptlang.org/) - 我们的大部分后端和前端都是用 TypeScript 编写的。
- [Next.js](https://nextjs.org/) - 我们的前端是一个 Next.JS 应用，托管在 [Vercel](https://vercel.com/) 上。
- [SWR](https://swr.vercel.app/) - 我们在 Web 上使用 SWR 进行所有数据获取。
- [Stitches](https://stitches.dev/) - 我们在前端使用 Stitches 来设计组件样式。
- [Mozilla Readability](https://github.com/mozilla/readability) - 我们使用 Mozilla 的 Readability 库来让页面更易于阅读。
- [Swift GraphQL](https://www.swift-graphql.com/) - 我们使用 Swift GraphQL 在 iOS 上生成 GraphQL 查询。
- [Apollo GraphQL](https://www.apollographql.com/) - 我们使用 Apollo GraphQL 在 Android 上生成 GraphQL 查询。
- [Radix](https://www.radix-ui.com/) - 我们在前端使用 Radix UI 的组件。
- [PDF.js](https://github.com/mozilla/pdf.js) - PDF.js 用于提供开源的 PDF 功能。
- 以及更多优秀的库，请查看我们的包文件以了解我们正在使用的内容。

## 导入库

查看我们的[文档](https://docs.omnivore.app/using/importing.html)了解如何从其他应用导入数据。

## 如何设置本地开发 💻

开始本地开发最简单的方法是使用 `docker compose up`。这将启动一个 postgres 容器、我们的 Web 前端、API 服务器和内容获取微服务。

### 开发要求

Omnivore 使用 TypeScript 和 JavaScript 编写。

- [Node.js](https://nodejs.org/) (v18.16) 和 [Yarn](https://classic.yarnpkg.com/lang/en/) -- 版本由 [Volta](https://docs.volta.sh/guide/getting-started) 管理。
- [Chromium](https://www.chromium.org/chromium-projects/) -- 请参阅下面的安装信息。

### 运行 Web 和 API 服务

#### 1. 启动 docker compose

```bash
git clone https://github.com/omnivore-app/omnivore
cd omnivore
docker compose up
```

这将启动 postgres，初始化数据库，并启动 Web 和 API 服务。

#### 2. 打开浏览器

打开 <http://localhost:3000> 并确认 Omnivore 正在运行

#### 3. 使用测试账户登录

在数据库设置期间，docker compose 会创建一个账户 `demo@omnivore.app`，密码：`demo_password`。

在浏览器中访问 <http://localhost:3000/> 并选择 `Continue with Email` 登录。

### 前端开发

如果您只想处理 Omnivore 的前端，可以使用 docker compose 运行后端服务，并在本地运行前端：

```bash
docker compose up api content-fetch
cd packages/web
cp .env.template .env.local
yarn dev
```

您需要在新的 `.env.local` 文件中配置一些值。这些是直接在主机机器上运行 `web` 服务并在 docker 内运行 `api` 和 `content-fetch` 的值：

```sh
NEXT_PUBLIC_BASE_URL=http://localhost:3000
NEXT_PUBLIC_HIGHLIGHTS_BASE_URL=http://localhost:3000
NEXT_PUBLIC_LOCAL_BASE_URL=http://localhost:3000
NEXT_PUBLIC_SERVER_BASE_URL=http://localhost:4000
NEXT_PUBLIC_LOCAL_SERVER_BASE_URL=http://localhost:4000
```

### 在 Docker 外运行 puppeteer-parse 服务

要保存页面，您需要运行 `puppeteer-parse` 服务。

#### 1. 安装和配置 Chromium

```bash
brew install chromium --no-quarantine
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export CHROMIUM_PATH=`which chromium`
```

#### 2. 导航到服务目录，设置环境文件并安装依赖项

```bash
cd packages/puppeteer-parse
cp .env.example .env
yarn
```

#### 3. 启动服务

```bash
yarn start
```

这将在端口 9090 上启动 puppeteer-parse 服务。

在浏览器中访问 <http://localhost:3000/home>，点击 `Add Link` 按钮，并输入一个 URL，例如 `https://blog.omnivore.app/p/getting-started-with-omnivore`。

您应该会看到一个 Chromium 窗口打开并导航到您的链接。当服务完成获取您的内容时，您将在库中看到它。

## 如何部署到您自己的服务器

自托管服务器运行指南可以在[这里](./self-hosting/GUIDE.md)找到

### Docker Compose 快速启动

使用 Docker Compose 进行快速部署，请按照以下步骤操作：

#### 1. 克隆仓库并导航到 docker-compose 目录

```bash
git clone https://github.com/omnivore-app/omnivore
cd omnivore/self-hosting/docker-compose
```

#### 2. 创建并配置环境文件

```bash
cp env.example .env
```

编辑 `.env` 文件并更新以下配置：

```bash
# 更新您的服务器 IP 地址（将 192.168.0.157 替换为您的实际 IP）
IMAGE_PROXY_URL=http://YOUR_SERVER_IP:7070
CLIENT_URL=http://YOUR_SERVER_IP:3101
LOCAL_MINIO_URL=http://YOUR_SERVER_IP:1011
BASE_URL=http://YOUR_SERVER_IP:3101
SERVER_BASE_URL=http://YOUR_SERVER_IP:4001
HIGHLIGHTS_BASE_URL=http://YOUR_SERVER_IP:3101

# 数据库配置（首次部署时保持这些默认值）
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=omnivore
PG_HOST=postgres
PG_PASSWORD=postgres
PG_DB=omnivore
PG_USER=app_user
PG_PORT=5432
```

#### 3. 启动服务

```bash
sudo docker-compose up -d
```

#### 4. 访问 Omnivore

打开浏览器并导航到 `http://YOUR_SERVER_IP:3101`

**演示账户**：`demo@omnivore.app` / `demo_password`

### 服务端口

| 服务 | 端口 | 描述 |
|------|------|------|
| Web 界面 | 3101 | 主 Web 应用程序 |
| API 服务器 | 4001 | 后端 API 服务 |
| PostgreSQL | 5432 | 数据库（内部） |
| Redis | 6478 | 缓存（内部） |
| MinIO | 1011 | 对象存储 |
| 图片代理 | 7070 | 图片处理服务 |
| 内容获取 | 9090 | 内容获取服务 |
| 邮件监控 | 4398 | 邮件处理服务 |

### 常见问题和解决方案

#### 数据库认证失败

如果遇到 `password authentication failed for user "app_user"`：

1. **检查 .env 文件是否存在**：
   ```bash
   ls -la .env
   ```

2. **验证数据库用户创建**：
   ```bash
   sudo docker exec omnivore-postgres psql -U postgres -c "\du"
   ```

3. **如果缺少 app_user，手动创建**：
   ```bash
   sudo docker exec omnivore-postgres psql -U postgres -c "CREATE USER app_user WITH PASSWORD 'postgres';"
   sudo docker exec omnivore-postgres psql -U postgres -c "GRANT omnivore_user TO app_user;"
   sudo docker exec omnivore-postgres psql -U postgres -c "GRANT CONNECT ON DATABASE omnivore TO app_user;"
   ```

#### 服务无法启动

1. **检查服务状态**：
   ```bash
   sudo docker-compose ps
   ```

2. **查看服务日志**：
   ```bash
   sudo docker logs omnivore-api
   sudo docker logs omnivore-web
   ```

3. **重启特定服务**：
   ```bash
   sudo docker-compose restart api
   sudo docker-compose restart web
   ```

#### 停止服务

要正确停止所有服务：

```bash
# 使用正确的项目名称
sudo docker-compose -p docker-compose down

# 或停止并删除卷（这将删除数据）
sudo docker-compose -p docker-compose down -v
```

#### 网络配置问题

如果服务无法通信：

1. **检查网络连接**：
   ```bash
   sudo docker network ls
   sudo docker network inspect docker-compose_default
   ```

2. **验证容器网络**：
   ```bash
   sudo docker exec omnivore-api ping postgres
   sudo docker exec omnivore-api ping redis
   ```

### 高级配置

#### 自定义域名设置

要使用自定义域名而不是 IP 地址：

1. 在 `.env` 文件中更新您的域名：
   ```bash
   BASE_URL=https://your-domain.com
   SERVER_BASE_URL=https://your-domain.com/api
   ```

2. 配置反向代理（nginx/traefik）将请求转发到适当的端口。

#### SSL/HTTPS 配置

对于生产部署，请考虑使用：

- **Traefik** 作为带有 Let's Encrypt 的反向代理
- **Nginx** 配合 SSL 证书
- **Cloudflare** 用于 SSL 终止

#### 备份和数据持久化

重要数据存储在 Docker 卷中：

- `docker-compose_pgdata`：PostgreSQL 数据库
- `docker-compose_redis_data`：Redis 缓存
- `docker-compose_minio_data`：文件存储

要备份您的数据：

```bash
# 备份数据库
sudo docker exec omnivore-postgres pg_dump -U postgres omnivore > backup.sql

# 备份卷
sudo docker run --rm -v docker-compose_pgdata:/data -v $(pwd):/backup alpine tar czf /backup/pgdata-backup.tar.gz -C /data .
```

### 监控和维护

#### 健康检查

监控服务健康状态：

```bash
# 检查所有服务
sudo docker-compose ps

# 检查特定服务健康状态
sudo docker inspect omnivore-api --format='{{.State.Health.Status}}'
```

#### 日志管理

查看和管理日志：

```bash
# 查看所有日志
sudo docker-compose logs

# 跟踪特定服务日志
sudo docker-compose logs -f api

# 查看最近的日志
sudo docker logs --tail 100 omnivore-api
```

#### 更新

要更新到最新版本：

```bash
# 拉取最新镜像
sudo docker-compose pull

# 重启服务
sudo docker-compose up -d
```

### 故障排除清单

- [ ] `.env` 文件存在且配置正确
- [ ] 服务器 IP 地址在 `.env` 中正确设置
- [ ] 数据库端口设置为 `5432`（不是 `5532`）
- [ ] `app_user` 数据库用户存在且具有正确权限
- [ ] 所有必需端口都可访问
- [ ] Docker 和 Docker Compose 正确安装
- [ ] 有足够的磁盘空间和内存

如需更详细的故障排除，请查看[自托管指南](./self-hosting/GUIDE.md)或加入我们的 [Discord 社区](https://discord.gg/h2z5rppzz9)。

## 许可证

Omnivore 和我们对 Readability.js 的扩展采用 AGPL-3.0 许可证。

---

## 语言版本

- [English](README.md) - 英文版本
- [中文](README_CN.md) - 中文版本（当前页面） 