# Omnivore 端口冲突解决报告

## 问题分析

### 原始端口冲突情况
根据之前的端口占用分析，发现以下端口冲突：

| 服务 | 原始端口 | 冲突服务 | 冲突端口 | 状态 |
|------|----------|----------|----------|------|
| image-proxy | 7070 | hectorqin-reader | 7080 | ❌ 冲突 |
| api | 4001 | 无 | - | ✅ 无冲突 |
| web | 3101 | 无 | - | ✅ 无冲突 |
| content-fetch | 9090 | 无 | - | ✅ 无冲突 |
| redis | 6478 | 无 | - | ✅ 无冲突 |
| minio | 1011 | 无 | - | ✅ 无冲突 |
| mail-watch-server | 4398 | 无 | - | ✅ 无冲突 |

## 解决方案

### 1. 修改 compose.yaml 文件

**文件路径**: `/volume3/docker/omnivore/compose.yaml`

**修改内容**:
```yaml
# 修改前
image-proxy:
  ports:
    - "7070:8080"

# 修改后  
image-proxy:
  ports:
    - "7081:8080"
```

### 2. 修改 .env 配置文件

**文件路径**: `/volume3/docker/omnivore/.env`

**修改内容**:
```bash
# 修改前
IMAGE_PROXY_URL=http://192.168.0.199:7070

# 修改后
IMAGE_PROXY_URL=http://192.168.0.199:7081
```

## 修改后的端口配置

### Omnivore 服务端口映射

| 服务名称 | 容器端口 | 主机端口 | 访问地址 | 状态 |
|----------|----------|----------|----------|------|
| api | 8080 | 4001 | http://192.168.0.199:4001 | ✅ 可用 |
| web | 8080 | 3101 | http://192.168.0.199:3101 | ✅ 可用 |
| image-proxy | 8080 | 7081 | http://192.168.0.199:7081 | ✅ 已修改 |
| content-fetch | 8080 | 9090 | http://192.168.0.199:9090 | ✅ 可用 |
| redis | 6379 | 6478 | localhost:6478 | ✅ 可用 |
| minio | 9000 | 1011 | http://192.168.0.199:1011 | ✅ 可用 |
| mail-watch-server | 8080 | 4398 | http://192.168.0.199:4398 | ✅ 可用 |

### 端口可用性验证

```bash
# 检查所有Omnivore端口是否可用
netstat -tuln | grep -E ":(7081|4001|3101|9090|6478|1011|4398)"
# 结果: 无输出，表示所有端口都可用
```

## 启动建议

### 1. 重新启动Omnivore服务

```bash
# 停止当前服务（如果有）
sudo docker-compose -p omnivore --project-directory /volume3/docker/omnivore -f /volume3/docker/omnivore/compose.yaml down

# 启动服务
sudo docker-compose -p omnivore --project-directory /volume3/docker/omnivore -f /volume3/docker/omnivore/compose.yaml up -d
```

### 2. 验证服务状态

```bash
# 检查服务状态
sudo docker-compose -p omnivore --project-directory /volume3/docker/omnivore -f /volume3/docker/omnivore/compose.yaml ps

# 检查端口监听
netstat -tuln | grep -E ":(7081|4001|3101|9090|6478|1011|4398)"
```

### 3. 访问测试

- **Web界面**: http://192.168.0.199:3101
- **API服务**: http://192.168.0.199:4001
- **图片代理**: http://192.168.0.199:7081
- **内容获取**: http://192.168.0.199:9090
- **邮件监控**: http://192.168.0.199:4398
- **MinIO管理**: http://192.168.0.199:1011

## 注意事项

### 1. 配置更新
- 所有端口冲突已解决
- 配置文件已同步更新
- 建议重启相关服务以确保配置生效

### 2. 网络访问
- 确保防火墙允许新端口访问
- 检查网络配置是否正确
- 验证DNS解析是否正常

### 3. 服务依赖
- 服务启动顺序：postgres → migrate → api → 其他服务
- 确保所有依赖服务正常运行
- 检查健康检查状态

## 修改时间

修改时间: Sun Jul 20 08:50:46 PM CST 2025  
修改文件: 
- `/volume3/docker/omnivore/compose.yaml`
- `/volume3/docker/omnivore/.env`

## 验证命令

```bash
# 验证端口配置
grep "IMAGE_PROXY_URL" /volume3/docker/omnivore/.env
grep "7081:8080" /volume3/docker/omnivore/compose.yaml

# 检查端口占用
netstat -tuln | grep -E ":(7081|4001|3101|9090|6478|1011|4398)"
``` 