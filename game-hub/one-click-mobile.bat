@echo off
chcp 65001 >nul
title Game Hub - 手机一键部署

:: 设置错误处理
if "%errorlevel%" neq "0" (
    echo 检测到错误，重新启动...
    timeout /t 2 >nul
)

:restart
echo.
echo ========================================
echo           游戏中心 - 手机一键部署
echo ========================================
echo.
echo 正在检查系统环境...

:: 检查是否在正确目录
cd /d "e:\files\gameshows\filesgameshows\game-hub" 2>nul
if errorlevel 1 (
    echo [错误] 无法切换到项目目录
    echo 请确保脚本在正确位置运行
    pause
    exit /b 1
)

:: 检查项目文件
if not exist "package.json" (
    echo [错误] 未找到项目文件 package.json
    echo 请确保在 game-hub 目录中运行此脚本
    pause
    exit /b 1
)

:menu
echo.
echo [1] 使用 ngrok (最稳定，需要注册)
echo [2] 使用 localtunnel (完全免费，无需注册)
echo [3] 使用 serveo (完全免费，无需注册)
echo [4] 查看手机访问指南
echo [5] 退出
echo.
set /p "choice=请选择 (1-5): "

if "%choice%"=="" goto menu
if "%choice%"=="1" goto ngrok
if "%choice%"=="2" goto localtunnel  
if "%choice%"=="3" goto serveo
if "%choice%"=="4" goto guide
if "%choice%"=="5" goto exit

echo 无效选择: %choice%
echo 请重新输入
timeout /t 2 >nul
goto menu

:ngrok
echo.
echo ========================================
echo              NGROK 使用方法
echo ========================================
echo.
echo 步骤:
echo 1. 访问 https://ngrok.com/
echo 2. 注册免费账号
echo 3. 下载 ngrok 客户端
echo 4. 解压到任意目录
echo 5. 在解压目录打开命令行
echo 6. 运行: ngrok http 3000
echo 7. 获得类似 https://abc123.ngrok.io 的链接
echo 8. 发给朋友用手机访问
echo.
echo 注意: 需要先启动本地服务器: npm run dev
echo.
set /p "=按任意键返回菜单..." <nul
pause >nul
goto menu

:localtunnel
echo.
echo ========================================
echo           LOCALTUNNEL 启动中
echo ========================================
echo.

:: 检查是否安装 Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未安装 Node.js
    echo 请先安装 Node.js: https://nodejs.org/
    pause
    goto menu
)

echo 检查 localtunnel 安装...
where lt >nul 2>&1
if errorlevel 1 (
    echo 正在安装 localtunnel...
    npm install -g localtunnel
    if errorlevel 1 (
        echo [错误] 安装失败
        echo 请检查网络连接或使用管理员权限运行
        pause
        goto menu
    )
    echo [成功] localtunnel 安装完成
)

echo.
echo 启动本地服务器...
start "" cmd /c "npm run dev"
echo 等待服务器启动(5秒)...
timeout /t 5 >nul

echo.
echo 启动内网穿透服务...
echo 注意: 下面会显示访问链接，复制发给朋友！
echo ========================================
lt --port 3000

echo.
echo ========================================
echo [重要] 服务已停止
echo 按任意键返回菜单...
pause >nul
goto menu

:serveo
echo.
echo ========================================
echo             SERVEO 启动中
echo ========================================
echo.

echo 启动本地服务器...
start "" cmd /c "npm run dev"
echo 等待服务器启动(5秒)...
timeout /t 5 >nul

echo.
echo 启动内网穿透服务...
echo 注意: 首次使用可能需要确认SSH连接
echo 下面会显示访问链接，复制发给朋友！
echo ========================================
ssh -R 80:localhost:3000 serveo.net

echo.
echo ========================================
echo [重要] 服务已停止
echo 按任意键返回菜单...
pause >nul
goto menu

:guide
echo.
echo 正在打开手机访问指南...
start "" "MOBILE_GUIDE.md"
echo 指南已打开
echo 按任意键返回菜单...
pause >nul
goto menu

:exit
echo.
echo 感谢使用！再见！
timeout /t 2 >nul
exit