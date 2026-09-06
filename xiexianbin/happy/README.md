# Happy (Server & Web UI All-In-One) Docker Image

[Happy](https://github.com/slopus/happy) 是面向 Claude Code 和 AI 编程 Agent 的开源移动端与 Web 客户端工具。它允许你在手机或浏览器端实时监控和远程交互正在运行的 Claude Code / AI 会话，支持端到端加密、会话同步、实时语音、推送通知等。

本镜像提供 **Happy Server** 与 **Happy Web UI** 的一体化（All-In-One）运行环境：
- **单端口运行**：服务端 API、WebSocket 以及 Web 前端页面统一监听于端口 `3005`。
- **零外部依赖**：默认内置并使用嵌入式 PGlite（PostgreSQL on WASM）数据库与本地文件上传存储，无需单独搭建 PostgreSQL、Redis 或 S3。
- **自动初始化与迁移**：容器启动时自动应用 Prisma 数据库迁移脚本。
- **自动密钥管理**：首次启动自动生成 32 字节强随机 `HANDY_MASTER_SECRET` 并持久化保存在 `/data/master-secret`，容器重启时自动复用，会话和加密状态不丢失。
- **自适应网络访问**：Web 页面自动适配当前访问的来源地址（`window.location.origin`），在局域网 IP 或独立域名下均可直接打开并自动连接后端。
- **灵活扩展**：支持通过环境变量无缝切换至外部 PostgreSQL（`DATABASE_URL`）、Redis（`REDIS_URL`）及 S3/MinIO 对象存储。

---

## 快速开始

### 1. 使用 Docker CLI

```bash
docker run -d \
  --name happy \
  -p 3005:3005 \
  -v happy-data:/data \
  --restart unless-stopped \
  ghcr.io/xiexianbin/happy:latest
```

启动完成后，打开浏览器访问：
```text
http://localhost:3005
```
或局域网/服务器地址：`http://<SERVER_IP>:3005`

### 2. 使用 Docker Compose

在当前目录或项目目录创建 `docker-compose.yml`：

```yaml
services:
  happy:
    image: ghcr.io/xiexianbin/happy:latest
    container_name: happy
    restart: unless-stopped
    ports:
      - "3005:3005"
    volumes:
      - happy-data:/data
    environment:
      - PORT=3005
      # - HAPPY_SERVER_URL=http://<SERVER_IP>:3005

volumes:
  happy-data:
```

运行：
```bash
docker compose up -d
```

---

## 客户端连接指南

### 1. Happy CLI (用于配合 Claude Code)

在安装了 Claude Code 的开发机上安装 Happy CLI 并指向自建服务：

```bash
# 全局安装 CLI
npm install -g happy

# 配置服务器地址环境变量（或写入 ~/.bashrc / ~/.zshrc）
export HAPPY_SERVER_URL=http://<SERVER_IP>:3005

# 启动 Claude 并自动关联 Happy 会话
happy claude
```

### 2. 手机端与 Web 客户端配对

1. 在浏览器中打开 `http://<SERVER_IP>:3005`。
2. 首次进入后创建账户或登录。
3. 终端运行 `happy claude` 时终端会展示配对码或二维码，在 Web 界面或手机 App 中扫码/输入配对码即可同步会话。

---

## 环境变量说明

| 环境变量 | 默认值 | 说明 |
| :--- | :--- | :--- |
| `PORT` | `3005` | 服务端与 Web UI 监听端口 |
| `HOST` | `0.0.0.0` | 监听地址 |
| `DATA_DIR` | `/data` | 数据根目录（用于存放 PGlite 数据库、文件及 master-secret） |
| `PGLITE_DIR` | `/data/pglite` | 嵌入式 PGlite 数据库存储路径 |
| `HANDY_MASTER_SECRET` | 自动生成 | 服务端鉴权与端到端加密主密钥（未指定时自动保存在 `/data/master-secret`） |
| `HAPPY_SERVER_URL` | *(空)* | 指定 Web 端连接的服务端完整地址（如 `https://happy.example.com`），缺省时前端自动使用访问来源 |
| `DATABASE_URL` | *(空)* | 外部 PostgreSQL 连接串（设置后将停用内置 PGlite 转为外部数据库） |
| `REDIS_URL` | *(空)* | 可选外部 Redis 连接串（用于多实例会话中继与扩展） |
| `S3_HOST` | *(空)* | S3 对象存储 Host（缺省时使用本地磁盘 `/data/files` 存储附件） |
| `S3_ACCESS_KEY` | *(空)* | S3 Access Key |
| `S3_SECRET_KEY` | *(空)* | S3 Secret Key |
| `S3_BUCKET` | *(空)* | S3 存储桶名称 |
| `S3_PUBLIC_URL` | *(空)* | S3 公开访问 URL |

---

## 本地构建

```bash
cd xiexianbin/happy
make docker
```
