#!/bin/bash

# 自动化配置1ms-helper账号的脚本
echo "开始自动配置1ms-helper账号..."

# 创建输入文件
cat > input.txt << EOF
y
13918094086
ed\\OYH8EsH]d)Dy
EOF

# 使用输入文件运行程序
./1ms-helper config:account < input.txt

# 清理输入文件
rm -f input.txt

echo "配置完成！" 