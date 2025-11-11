Write-Host "Starting Game Hub..." -ForegroundColor Green

# Change to project directory
Set-Location "e:\files\tutorial\game-hub"

# Check if Node.js is installed
try {
    $nodeVersion = node --version
    Write-Host "Node.js version: $nodeVersion" -ForegroundColor Cyan
} catch {
    Write-Host "ERROR: Node.js not found. Please install Node.js first." -ForegroundColor Red
    Write-Host "Download from: https://nodejs.org" -ForegroundColor Yellow
    Write-Host "Choose non-C drive directory during installation (e.g., D:\Program Files\nodejs\)" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if dependencies are installed
if (-not (Test-Path "node_modules")) {
    Write-Host "Installing project dependencies..." -ForegroundColor Yellow
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Dependency installation failed. Please check network connection." -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}

Write-Host "Starting development server..." -ForegroundColor Green
Write-Host "After server starts, open browser and visit: http://localhost:3000" -ForegroundColor Cyan
Write-Host ""

# Start development server
npm run dev