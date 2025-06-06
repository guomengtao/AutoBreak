#!/bin/bash

# === 必填配置项 ===
GITEE_USERNAME="rinuo"               # 你的 Gitee 用户名
GITEE_TOKEN="你的GiteeToken"         # 你的 Gitee 私人令牌
REPO_NAME=$(basename `git rev-parse --show-toplevel`)   # 当前 GitHub 仓库名
GH_REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)

# === 步骤 1: 创建 Gitee 仓库 ===
echo "📦 正在创建 Gitee 仓库：$REPO_NAME"
curl -s -X POST https://gitee.com/api/v5/user/repos \
  -H "Content-Type: application/json" \
  -d "{
    \"access_token\": \"$GITEE_TOKEN\",
    \"name\": \"$REPO_NAME\",
    \"auto_init\": true,
    \"private\": false
  }" | jq '.message // "✅ 创建成功或已存在"'

# === 步骤 2: 添加 GitHub Secret ===
echo "🔐 设置 GitHub Secret: GITEE_TOKEN"
gh secret set GITEE_TOKEN -R "$GH_REPO" --body "$GITEE_TOKEN"

# === 步骤 3: 创建同步 Workflow ===
mkdir -p .github/workflows
cat > .github/workflows/sync-to-gitee.yml <<EOF
name: Sync to Gitee

on:
  push:
    branches: [main]

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout GitHub repo
        uses: actions/checkout@v2

      - name: Push to Gitee
        uses: Yikun/hub-mirror-action@master
        with:
          src: github/guomengtao
          dst: gitee/$GITEE_USERNAME
          dst_key: \${{ secrets.GITEE_TOKEN }}
          dst_token: \${{ secrets.GITEE_TOKEN }}
          static_list: $REPO_NAME
          force_update: true
EOF

# === 步骤 4: 提交 workflow 到 GitHub ===
git add .github/workflows/sync-to-gitee.yml
git commit -m "🔄 Add GitHub to Gitee sync workflow"
git push

echo -e "\n✅ 同步设置完成！仓库 $REPO_NAME 将自动与 Gitee 同步"