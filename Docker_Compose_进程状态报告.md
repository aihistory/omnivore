# Docker Compose 进程状态报告

## 当前发现的Docker Compose进程

### 1. 正在运行的Docker Compose进程

**进程ID**: 30626  
**用户**: root  
**命令**: `/var/packages/ContainerManager/target/usr/bin/docker-compose -p omnivore --project-directory /volume3/docker/omnivore --progress plain up --no-start`  
**状态**: 运行中 (Sl)  
**内存使用**: 23728 KB  
**启动时间**: 20:31  

### 2. Omnivore项目配置

**项目名称**: omnivore  
**项目目录**: `/volume3/docker/omnivore`  
**配置文件**: `compose.yaml`  
**环境文件**: `.env`

## 项目服务配置

### 服务列表

| 服务名称 | 镜像 | 容器名称 | 端口映射 | 状态 |
|----------|------|----------|----------|------|
| postgres | ankane/pgvector:v0.5.1 | omnivore-postgres | - | 未运行 |
| migrate | ghcr.io/omnivore-app/sh-migrate:latest | omnivore-migrate | - | 未运行 |
| api | ghcr.io/omnivore-app/sh-backend:latest | omnivore-api | 4001:8080 | 未运行 |
| queue-processor | ghcr.io/omnivore-app/sh-queue-processor:latest | omnivore-queue-processor | - | 未运行 |
| web | ghcr.io/omnivore-app/sh-web:latest | omnivore-web | 3101:8080 | 未运行 |
| image-proxy | ghcr.io/omnivore-app/sh-image-proxy:latest | omnivore-image-proxy | 7070:8080 | 未运行 |
| content-fetch | ghcr.io/omnivore-app/sh-content-fetch:latest | omnivore-content-fetch | 9090:8080 | 未运行 |
| redis | redis:7.2.4 | omnivore-redis | 6478:6379 | 未运行 |
| minio | minio/minio | - | 1011:9000 | 未运行 |
| createbuckets | minio/mc | - | - | 未运行 |
| mail-watch-server | ghcr.io/omnivore-app/sh-local-mail-watcher:latest | omnivore-mail-watch-server | 4398:8080 | 未运行 |

### 数据卷

- **pgdata**: PostgreSQL数据存储
- **redis_data**: Redis数据存储  
- **minio_data**: MinIO对象存储数据

## 当前运行的Docker容器

### 独立容器（非Compose管理）

| 容器ID | 镜像 | 名称 | 端口映射 | 状态 |
|--------|------|------|----------|------|
| 9aa2a2995243 | neo4j:latest | neo4j | 17473:7473, 17474:7474, 17687:7687 | 运行中 |
| 1f9f6053cab8 | registry:latest | registry | 5577:5000 | 运行中 |
| 415666972c19 | cooderl/wewe-rss:latest | wewe-rss-app-1 | 4050:4000 | 运行中 |
| 6ce71fbf640a | mysql:8.3.0 | wewe-rss-db-1 | 3306, 33060 | 运行中(健康) |
| 8052d08dae1d | tindy2013/subconverter:latest | subconverter | 25600:25500 | 运行中 |
| 0e3e4e4d7048 | johngong/calibre-web:latest | calibre-web | 32769:8080, 32773:8083 | 运行中 |
| d9d5857ac74c | 9f490c123bab | hectorqin-reader | 7080:8080 | 运行中 |
| e47d0b91fd37 | couchdb:latest | couchdb | - | 运行中 |
| af575c74be73 | diygod/rsshub:chromium-bundled | rsshub | 3200:1200 | 运行中 |
| 2541e12baa49 | jlesage/firefox:latest | jlesage-firefox1 | 15800:5800, 15900:5900 | 运行中 |

## 端口占用分析

### Omnivore项目计划使用的端口
- **4001**: API服务
- **3101**: Web界面
- **7070**: 图片代理服务
- **9090**: 内容获取服务
- **6478**: Redis服务
- **1011**: MinIO对象存储
- **4398**: 邮件监控服务

### 当前端口冲突检查
- **3200**: 已被rsshub占用
- **7080**: 已被hectorqin-reader占用
- **25600**: 已被subconverter占用
- **17473/17474/17687**: 已被neo4j占用

## 建议和注意事项

### 1. 端口冲突解决
- Omnivore的content-fetch服务(9090)与现有服务无冲突
- Omnivore的web服务(3101)与现有服务无冲突
- Omnivore的api服务(4001)与现有服务无冲突

### 2. 资源使用情况
- 当前有10个独立容器在运行
- 系统资源使用情况正常
- Docker Compose进程占用约23MB内存

### 3. 启动建议
- Omnivore项目当前处于`--no-start`状态
- 需要手动启动服务：`docker-compose up -d`
- 建议先检查端口冲突，确保服务能正常启动

## 生成时间

生成时间: Sun Jul 20 08:45:46 PM CST 2025  
命令: `ps aux | grep -i docker-compose`, `docker ps`, `docker-compose ps` 