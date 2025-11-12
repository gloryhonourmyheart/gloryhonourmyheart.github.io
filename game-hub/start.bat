@echo off
chcp 65001 >nul
echo Starting Game Hub...
cd /d "e:\files\gameshows\filesgameshows\game-hub"

:: Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js not found. Please install Node.js first.
    echo Download from: https://nodejs.org
    echo Choose non-C drive directory during installation (e.g., D:\Program Files\nodejs\)
    pause
    exit /b 1
)

:: Check if dependencies are installed
if not exist "node_modules" (
    echo Installing project dependencies...
    npm install
    if errorlevel 1 (
        echo Dependency installation failed. Please check network connection.
        pause
        exit /b 1
    )
)

echo Starting development server...
echo After server starts, open browser and visit: http://localhost:3000
echo.
npm run dev