@echo off
chcp 65001 >nul
echo ========================================
echo    Game Hub - 手机远程访问工具
echo ========================================
echo.

cd /d "e:\files\gameshows\filesgameshows\game-hub"

echo [INFO] 正在检查项目状态...
if not exist "package.json" (
    echo [ERROR] 未找到项目文件
    pause
    exit /b 1
)

echo.
echo [STEP 1] 选择内网穿透服务（免费）:
echo.
echo 1. ngrok - 最稳定，每月免费额度
echo 2. localtunnel - 完全免费
echo 3. serveo - 完全免费
echo.
set /p choice=请选择 (1/2/3): 

echo.
echo [STEP 2] 安装并启动服务...
echo.

if "%choice%"=="1" (
    echo 使用 ngrok...
    echo 请访问: https://ngrok.com/
    echo 1. 注册免费账号
    echo 2. 下载 ngrok
    echo 3. 运行: ngrok http 3000
    echo 4. 获得类似 https://abc123.ngrok.io 的链接
    echo 5. 发给朋友用手机访问
) else if "%choice%"=="2" (
    echo 使用 localtunnel...
    npm install -g localtunnel
    echo 启动本地服务器...
    start cmd /k "npm run dev"
    timeout /t 3
    echo 启动内网穿透...
    lt --port 3000
    echo 获得类似 https://abc123.loca.lt 的链接
    echo 发给朋友用手机访问
) else if "%choice%"=="3" (
    echo 使用 serveo...
    echo 启动本地服务器...
    start cmd /k "npm run dev"
    timeout /t 3
    echo 启动内网穿透...
    ssh -R 80:localhost:3000 serveo.net
    echo 获得类似 https://abc123.serveo.net 的链接
    echo 发给朋友用手机访问
) else (
    echo 无效选择
)

echo.
echo ========================================
echo [重要提示]
echo 1. 确保本地服务器在端口3000运行
echo 2. 获得的链接可以直接在手机浏览器打开
echo 3. 链接有效期通常为几小时到几天
echo 4. 免费服务可能有使用限制
echo ========================================
pause