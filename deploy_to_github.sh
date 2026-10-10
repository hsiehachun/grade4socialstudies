#!/usr/bin/env bash
# ======================================================================
#    🌸 國小四年級社會手繪心智圖 - GitHub 自動化部署工具 (Bash)
# ======================================================================

set -e

echo "======================================================================"
echo "   🌸 國小四年級社會手繪心智圖 - GitHub 自動化部署工具 🌸"
echo "======================================================================"
echo ""

if ! command -v git &> /dev/null; then
    echo "[錯誤] 系統未偵測到 Git 指令，請先安裝 Git: https://git-scm.com/"
    exit 1
fi

echo "[1/4] 初始化 Git 本地存放庫..."
if [ ! -d ".git" ]; then
    git init
    git branch -M main
    echo "      - 已成功初始化 Git 存放庫並設定分支為 main"
else
    echo "      - Git 本地存放庫已存在"
fi

echo ""
echo "[2/4] 新增專案檔案至暫存區..."
git add .
echo "      - 檔案已新增"

echo ""
echo "[3/4] 建立版本提交 (Commit)...
git commit -m "feat: 發布國小四年級社會手繪心智圖互動學習系統" || true

echo ""
echo "[4/4] 檢查遠端 GitHub 存放庫連線..."
if ! git remote get-url origin &> /dev/null; then
    echo "請先在 GitHub 建立一個空白 Repository (例如: grade4-social-mindmap)"
    read -p "請在此貼上您的 GitHub 存放庫網址 (如 https://github.com/用戶名/專案名.git): " REPO_URL
    if [ -n "$REPO_URL" ]; then
        git remote add origin "$REPO_URL"
        echo "已成功綁定遠端存放庫: $REPO_URL"
    else
        echo "[提醒] 未輸入遠端網址，請稍後手動執行: git remote add origin <URL>"
        exit 0
    fi
fi

echo ""
echo "正在推送到 GitHub main 分支..."
git push -u origin main

echo ""
echo "======================================================================"
echo "   🎉 部署完成！"
echo ""
echo "   接下來請前往 GitHub 專案設定開啟網頁："
echo "   1. 開啟 GitHub Repo 頁面 -> 點擊 [Settings]"
echo "   2. 左側選單點選 [Pages]"
echo "   3. Branch 選擇 [main] / 目錄選擇 [/(root)] -> 點擊 [Save]"
echo "   4. 約 1~2 分鐘後即可享有免費的公開線上網站！"
echo "======================================================================"
