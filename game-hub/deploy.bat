@echo off
chcp 65001 >nul
echo ========================================
echo    Game Hub - Online Deployment Helper
echo ========================================
echo.

echo Checking project status...
cd /d "e:\files\gameshows\filesgameshows\game-hub"

:: Check Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js not installed
    echo Please download and install Node.js from https://nodejs.org
    echo After installation, run this script again
    pause
    exit /b 1
)

echo [OK] Node.js is installed

:: Check dependencies
if not exist "node_modules" (
    echo Installing project dependencies...
    npm install
    if errorlevel 1 (
        echo [ERROR] Dependency installation failed
        echo Please check your network connection and try again
        pause
        exit /b 1
    )
    echo [OK] Dependencies installed successfully
) else (
    echo [OK] Dependencies already installed
)

echo.
echo Building project...
npm run build
if errorlevel 1 (
    echo [ERROR] Build failed
    echo Please check for code errors
    pause
    exit /b 1
)

echo [OK] Project built successfully

echo.
echo ========================================
echo           Deployment Guide
echo ========================================
echo.
echo Project is ready for deployment! Follow these steps:
echo.
echo 1. Upload project to GitHub:
echo    - Create a new repository on GitHub
echo    - Push all files to the repository
echo.
echo 2. Deploy to Vercel (Recommended):
echo    - Visit https://vercel.com
echo    - Login with your GitHub account
echo    - Import your repository
echo    - Click "Deploy"
echo.
echo 3. Get online link:
echo    - After deployment, you'll get a link like:
echo    - https://your-project.vercel.app
echo.
echo 4. Share the link:
echo    - Share this link with friends to play online!
echo.
echo For detailed instructions, see DEPLOYMENT.md file
echo.
echo ========================================
pause