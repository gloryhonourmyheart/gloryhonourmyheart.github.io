# 游戏中心 - 手机远程访问 PowerShell 脚本
Write-Host "========================================" -ForegroundColor Green
Write-Host "        游戏中心 - 手机一键部署" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# 检查当前目录
$currentDir = Get-Location
Write-Host "当前目录: $currentDir" -ForegroundColor Yellow

# 检查项目文件
if (-not (Test-Path "package.json")) {
    Write-Host "[错误] 未找到 package.json 文件" -ForegroundColor Red
    Write-Host "请确保在 game-hub 目录中运行此脚本" -ForegroundColor Yellow
    Read-Host "按回车键退出"
    exit
}

# 主菜单
function Show-Menu {
    do {
        Clear-Host
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "           选择部署方式" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "1. 使用 ngrok (最稳定，需要注册)" -ForegroundColor Cyan
        Write-Host "2. 使用 localtunnel (完全免费，无需注册)" -ForegroundColor Cyan
        Write-Host "3. 使用 serveo (完全免费，无需注册)" -ForegroundColor Cyan
        Write-Host "4. 查看手机访问指南" -ForegroundColor Cyan
        Write-Host "5. 退出" -ForegroundColor Cyan
        Write-Host ""
        
        $choice = Read-Host "请选择 (1-5)"
        
        switch ($choice) {
            "1" { Show-NgrokGuide }
            "2" { Start-LocalTunnel }
            "3" { Start-Serveo }
            "4" { Show-Guide }
            "5" { exit }
            default { 
                Write-Host "无效选择，请重新输入" -ForegroundColor Red
                Start-Sleep -Seconds 2
            }
        }
    } while ($true)
}

# Ngrok 指南
function Show-NgrokGuide {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "              NGROK 使用方法" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "步骤:" -ForegroundColor Yellow
    Write-Host "1. 访问 https://ngrok.com/"
    Write-Host "2. 注册免费账号"
    Write-Host "3. 下载 ngrok 客户端"
    Write-Host "4. 解压到任意目录"
    Write-Host "5. 在解压目录打开 PowerShell"
    Write-Host "6. 运行: ngrok http 3000"
    Write-Host "7. 获得类似 https://abc123.ngrok.io 的链接"
    Write-Host "8. 发给朋友用手机访问"
    Write-Host ""
    Write-Host "注意: 需要先启动本地服务器: npm run dev" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "按回车键返回菜单"
}

# LocalTunnel 启动
function Start-LocalTunnel {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "           LOCALTUNNEL 启动中" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    
    # 检查 Node.js
    try {
        $nodeVersion = node --version
        Write-Host "Node.js 版本: $nodeVersion" -ForegroundColor Green
    } catch {
        Write-Host "[错误] 未安装 Node.js" -ForegroundColor Red
        Write-Host "请先安装 Node.js: https://nodejs.org/" -ForegroundColor Yellow
        Read-Host "按回车键返回菜单"
        return
    }
    
    # 检查 localtunnel
    try {
        $ltCheck = Get-Command lt -ErrorAction Stop
        Write-Host "localtunnel 已安装" -ForegroundColor Green
    } catch {
        Write-Host "正在安装 localtunnel..." -ForegroundColor Yellow
        try {
            npm install -g localtunnel
            Write-Host "localtunnel 安装完成" -ForegroundColor Green
        } catch {
            Write-Host "[错误] 安装失败" -ForegroundColor Red
            Write-Host "请检查网络连接或使用管理员权限运行" -ForegroundColor Yellow
            Read-Host "按回车键返回菜单"
            return
        }
    }
    
    Write-Host ""
    Write-Host "启动本地服务器..." -ForegroundColor Yellow
    Start-Process -FilePath "cmd" -ArgumentList "/c npm run dev" -WindowStyle Normal
    Write-Host "等待服务器启动(5秒)..." -ForegroundColor Yellow
    Start-Sleep -Seconds 5
    
    Write-Host ""
    Write-Host "启动内网穿透服务..." -ForegroundColor Yellow
    Write-Host "注意: 下面会显示访问链接，复制发给朋友！" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Green
    
    # 运行 localtunnel
    try {
        lt --port 3000
    } catch {
        Write-Host "服务已停止" -ForegroundColor Yellow
    }
    
    Write-Host ""
    Read-Host "按回车键返回菜单"
}

# Serveo 启动
function Start-Serveo {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "             SERVEO 启动中" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "启动本地服务器..." -ForegroundColor Yellow
    Start-Process -FilePath "cmd" -ArgumentList "/c npm run dev" -WindowStyle Normal
    Write-Host "等待服务器启动(5秒)..." -ForegroundColor Yellow
    Start-Sleep -Seconds 5
    
    Write-Host ""
    Write-Host "启动内网穿透服务..." -ForegroundColor Yellow
    Write-Host "注意: 首次使用可能需要确认SSH连接" -ForegroundColor Cyan
    Write-Host "下面会显示访问链接，复制发给朋友！" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Green
    
    # 运行 serveo
    try {
        ssh -R 80:localhost:3000 serveo.net
    } catch {
        Write-Host "服务已停止" -ForegroundColor Yellow
    }
    
    Write-Host ""
    Read-Host "按回车键返回菜单"
}

# 显示指南
function Show-Guide {
    Write-Host "正在打开手机访问指南..." -ForegroundColor Yellow
    if (Test-Path "MOBILE_GUIDE.md") {
        Start-Process -FilePath "notepad" -ArgumentList "MOBILE_GUIDE.md"
        Write-Host "指南已打开" -ForegroundColor Green
    } else {
        Write-Host "[错误] 未找到指南文件" -ForegroundColor Red
    }
    Write-Host ""
    Read-Host "按回车键返回菜单"
}

# 启动主菜单
Show-Menu