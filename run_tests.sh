#!/bin/bash

# 设置颜色输出
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "开始运行测试..."

# 编译并运行测试
swift CountdownLockScreenTests/ScreenLockTests.swift

# 检查测试结果
if [ $? -eq 0 ]; then
    echo -e "${GREEN}所有测试通过！${NC}"
else
    echo -e "${RED}测试失败，请检查错误信息${NC}"
fi 