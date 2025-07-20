#!/bin/bash

CDN_BASE="https://static.1ms.run/1ms-helper"
#VERSION=""  # 建议添加版本控制

# 彩色输出定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检测系统函数
detect_system() {
    case "$(uname -s)" in
        Darwin)  echo "Darwin" ;;
        Linux)   echo "Linux" ;;
        CYGWIN*|MINGW*|MSYS*) echo "Windows" ;;
        *)       echo "Unknown" ;;
    esac
}

# 检测架构函数
detect_arch() {
    case "$(uname -m)" in
        x86_64)  echo "x86_64" ;;
        i386|i686) echo "i386" ;;
        arm64|aarch64) echo "arm64" ;;
        *)       echo "unknown" ;;
    esac
}

# 安全校验函数
verify_checksum() {
    local file=$1
    echo -e "${YELLOW}⚠️ 正在验证文件完整性...${NC}"

    # 这里应该从CDN获取预计算的校验和
    local expected_checksum
    expected_checksum=$(curl -sSL "${CDN_BASE}/checksums.txt" | grep "${file}" | awk '{print $1}')

    if command -v sha256sum &> /dev/null; then
        local actual_checksum
        actual_checksum=$(sha256sum "$file" | awk '{print $1}')
        if [[ "$expected_checksum" != "$actual_checksum" ]]; then
            echo -e "${RED}❌ 文件校验失败！可能存在安全风险${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}⚠️ 跳过校验（未找到sha256sum工具）${NC}"
    fi
}

# 主安装流程
# shellcheck disable=SC2120
install() {
    local OS=$(detect_system)
    local ARCH=$(detect_arch)

    echo -e "${GREEN}🔍 检测到系统: ${OS} ${ARCH}${NC}"

    case "$OS" in
        Darwin|Linux)
            TARGET="1ms-helper_${OS}_${ARCH}.tar.gz"
            BIN_NAME="1ms-helper"
            echo "📦 下载包: $TARGET"
            curl -sSL "${CDN_BASE}/${TARGET}" -o "$TARGET" || exit 1

#            verify_checksum "$TARGET"

            echo -e "${GREEN}🚀 解压安装...${NC}"
            if ! tar -xzf "$TARGET"; then
                echo -e "${RED}❌ 解压失败！文件可能已损坏${NC}"
                exit 1
            fi
            rm -f "$TARGET"
            chmod +x "$BIN_NAME"

            echo -e "${GREEN}⚡ 启动程序 (参数: $*)...${NC}"
            if [ -t 0 ]; then
                ./"$BIN_NAME" "$@"
            else
                # 如果输入来自管道，需要特殊处理
                echo -e "${YELLOW}检测到管道输入，尝试恢复交互会话...${NC}"
                exec < /dev/tty  # 尝试恢复终端输入
                ./"$BIN_NAME" "$@"
            fi
#            rm -f "$BIN_NAME"
            ;;

        Windows)
            TARGET="1ms-helper_Windows_${ARCH}.zip"
            BIN_NAME="1ms-helper.exe"
            echo -e "${GREEN}📦 下载包: ${TARGET}${NC}"

            if ! curl -sSL "${CDN_BASE}/${TARGET}" -o "$TARGET"; then
                echo -e "${RED}❌ 下载失败！请检查网络连接${NC}"
                exit 1
            fi

#            verify_checksum "$TARGET"

            echo -e "${GREEN}🚀 解压...${NC}"
            if command -v unzip >/dev/null; then
                if ! unzip -o "$TARGET"; then
                    echo -e "${RED}❌ 解压失败！文件可能已损坏${NC}"
                    exit 1
                fi
                rm -f "$TARGET"
            else
                echo -e "${RED}❌ 需要unzip工具，请先安装:"
                echo -e "Windows: choco install unzip"
                echo -e "Linux: sudo apt-get install unzip${NC}"
                exit 1
            fi

            echo -e "${GREEN}⚡ 启动程序 (参数: $*)...${NC}"
            if [ -t 0 ]; then
                ./"$BIN_NAME" "$@"
            else
                # 如果输入来自管道，需要特殊处理
                echo -e "${YELLOW}检测到管道输入，尝试恢复交互会话...${NC}"
                exec < /dev/tty  # 尝试恢复终端输入
                ./"$BIN_NAME" "$@"
            fi
#            rm -f "$BIN_NAME"
            ;;

        *)
            echo -e "${RED}❌ 不支持的操作系统: ${OS}${NC}"
            exit 1
            ;;
    esac
}

# 显示欢迎信息
echo -e "${GREEN}
=======================================
  1ms Helper 引导助手
=======================================
${NC}"

# 执行安装并传递所有参数
install "$@"