@echo off
chcp 65001 > nul

echo ========================================
echo     Game Hub - China Public Deployment
echo ========================================
echo.
echo Detected need for China-accessible public link
echo Providing China network friendly solutions:
echo.
echo Option 1: Tencent Cloud Webify (Recommended, free quota)
echo Option 2: Alibaba Cloud Function Compute (Free quota)
echo Option 3: Gitee Pages (Chinese GitHub)
echo.

setlocal enabledelayedexpansion

:menu
echo.
echo Please choose deployment method:
echo 1. Tencent Cloud Webify (Easiest, one-click)
echo 2. Alibaba Cloud Function Compute (Stable)
echo 3. Gitee Pages (Completely free)
echo 4. View detailed deployment guide
echo 5. Exit
echo.
set /p choice=Enter choice (1-5): 

if "!choice!"=="1" goto tencent
if "!choice!"=="2" goto aliyun  
if "!choice!"=="3" goto gitee
if "!choice!"=="4" goto guide
if "!choice!"=="5" goto exit
echo Invalid choice, please re-enter
goto menu

:tencent
echo.
echo ========================================
echo         Tencent Cloud Webify Guide
echo ========================================
echo.
echo Step 1: Visit https://console.cloud.tencent.com/webify
echo Step 2: Login with WeChat scan
echo Step 3: Click "New Application"
echo Step 4: Select "Deploy from code repository"
echo Step 5: Authorize GitHub or Gitee account
echo Step 6: Select this project repository
echo Step 7: Auto build and deploy
echo.
echo Advantage: Fast China access, generous free quota
echo Expected link: https://your-app-xxx.tcloudbaseapp.com
echo.
pause
goto menu

:aliyun
echo.
echo ========================================
echo         Alibaba Cloud Function Compute
echo ========================================
echo.
echo Step 1: Visit https://fc.console.aliyun.com
echo Step 2: Login with Alipay scan
echo Step 3: Create service and application
echo Step 4: Upload this project zip file
echo Step 5: Configure static website hosting
echo Step 6: Auto generate access domain
echo.
echo Advantage: Alibaba Cloud China network, stable
echo Expected link: https://your-app.region.fc.aliyuncs.com
echo.
pause
goto menu

:gitee
echo.
echo ========================================
echo         Gitee Pages Deployment Guide
echo ========================================
echo.
echo Step 1: Visit https://gitee.com/
echo Step 2: Register account (Chinese phone)
echo Step 3: Create repository, upload project files
echo Step 4: Enable Gitee Pages service
echo Step 5: Wait for deployment completion
echo.
echo Advantage: Completely free, very fast China access
echo Expected link: https://your-name.gitee.io/your-repo
echo.
pause
goto menu

:guide
echo.
echo Opening detailed deployment guide...
if exist "CHINA_PUBLIC_GUIDE.md" (
    start "" "CHINA_PUBLIC_GUIDE.md"
) else (
    echo Error: Guide file not found
)
goto menu

:exit
echo Exiting deployment tool
echo.
pause