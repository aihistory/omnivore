#!/bin/bash

# Docker 镜像预拉取脚本 - 加速 Omnivore 部署
# 使用方法: ./pull-images.sh

set -e

echo "🚀 开始预拉取 Omnivore 镜像..."

# 定义所有镜像:
IMAGES=(
    "ankane/pgvector:v0.5.1"
    "ghcr.io/omnivore-app/sh-migrate:latest"
    "ghcr.io/omnivore-app/sh-backend:latest"
    "ghcr.io/omnivore-app/sh-queue-processor:latest"
    "ghcr.io/omnivore-app/sh-web:latest"
    "ghcr.io/omnivore-app/sh-image-proxy:latest"
    "ghcr.io/omnivore-app/sh-content-fetch:latest"
    "redis:7.2.4"
    "minio/minio:latest"
    "minio/mc:latest"
    "ghcr.io/omnivore-app/sh-local-mail-watcher:latest"
)

# 并行拉取镜像的函数
pull_image() {
    local image=$1
    echo "📥 拉取镜像: $image"
    docker pull "$image" &
}

# 并行拉取所有镜像
for image in "${IMAGES[@]}"; do
    pull_image "$image"
done

# 等待所有拉取完成
echo "⏳ 等待所有镜像拉取完成..."
wait

echo "✅ 所有镜像拉取完成！"
echo "🎉 现在可以运行 docker-compose up 了" 