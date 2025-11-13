@echo off
chcp 65001 >nul
echo ========================================
echo    Game Hub - Portable Version Creator
echo ========================================
echo.

cd /d "e:\files\gameshows\filesgameshows\game-hub"

echo [STEP 1] Building project...
npm run build
if errorlevel 1 (
    echo [ERROR] Build failed
    pause
    exit /b 1
)

echo [STEP 2] Creating portable version...

:: Create portable folder
if exist "game-hub-portable" (
    rmdir /s /q "game-hub-portable"
)
mkdir "game-hub-portable"

:: Copy built files
xcopy "dist\*" "game-hub-portable\" /s /e /y

:: Create run script
echo @echo off > "game-hub-portable\run-game.bat"
echo echo Starting Game Hub... >> "game-hub-portable\run-game.bat"
echo echo. >> "game-hub-portable\run-game.bat"
echo echo Open index.html in your web browser to play! >> "game-hub-portable\run-game.bat"
echo echo. >> "game-hub-portable\run-game.bat"
echo echo Instructions: >> "game-hub-portable\run-game.bat"
echo echo 1. Double-click index.html to open in browser >> "game-hub-portable\run-game.bat"
echo echo 2. Or right-click index.html and select "Open with" >> "game-hub-portable\run-game.bat"
echo echo 3. Choose your web browser >> "game-hub-portable\run-game.bat"
echo echo. >> "game-hub-portable\run-game.bat"
echo pause >> "game-hub-portable\run-game.bat"

echo [STEP 3] Portable version created successfully!
echo.
echo [LOCATION] game-hub-portable folder created
echo.
echo [USAGE] You can now:
echo 1. Zip the "game-hub-portable" folder
echo 2. Send the zip file to friends
echo 3. Friends just need to unzip and open index.html
echo.
echo ========================================
pause