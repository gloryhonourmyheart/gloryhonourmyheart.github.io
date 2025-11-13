@echo off
chcp 65001 >nul
echo ========================================
echo    Game Hub - Local Network Sharing
echo ========================================
echo.

echo Starting local server...
cd /d "e:\files\gameshows\filesgameshows\game-hub"

echo.
echo [INFO] Starting development server...
echo [INFO] Server will be available at:
echo.

:: Get local IP address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do (
    set ip=%%a
    goto :found_ip
)

:found_ip
set ip=%ip: =%
echo [LOCAL] http://localhost:3000
echo [NETWORK] http://%ip%:3000
echo.
echo [INSTRUCTIONS] Share the NETWORK URL with friends on the same WiFi!
echo.
echo ========================================
echo.

:: Start the server
npm run dev

pause