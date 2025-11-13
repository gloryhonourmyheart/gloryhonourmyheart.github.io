@echo off
echo ========================================
echo     游戏中心 - 国内手机访问方案
echo ========================================
echo.
echo 检测到朋友在国内，无法访问外网服务
echo 提供以下纯国内网络解决方案：
echo.
echo 方案1: 局域网共享 (同一WiFi下使用)
echo 方案2: 微信文件传输 (发送整个项目文件夹)
echo 方案3: 国内云盘分享 (百度网盘等)
echo.
echo 正在启动局域网共享服务...
echo.

REM 检查本地服务器是否运行
curl -s http://localhost:3000 > nul 2>&1
if errorlevel 1 (
    echo [错误] 本地服务器未运行
    echo 请先运行: npm run dev
    pause
    exit /b 1
)

echo 本地服务器运行正常: http://localhost:3000
echo.

REM 获取本机IP地址
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr "IPv4"') do (
    set ip=%%i
    goto :got_ip
)

:got_ip
set ip=%ip: =%
echo 你的局域网IP地址: %ip%
echo.
echo ========================================
echo         手机访问地址:
echo     http://%ip%:3000
echo ========================================
echo.
echo 使用说明:
echo 1. 确保朋友和你连接同一WiFi
echo 2. 朋友手机浏览器输入: http://%ip%:3000
echo 3. 如果无法访问，检查防火墙设置
echo.

REM 提供防火墙设置帮助
echo 防火墙设置:
echo 1. 打开Windows Defender防火墙
echo 2. 允许Node.js通过防火墙
echo 3. 或临时关闭防火墙测试
echo.

pause