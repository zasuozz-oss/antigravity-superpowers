$ErrorActionPreference = "Stop"

$GlobalDir = "$env:USERPROFILE\.gemini\antigravity"
$GeminiMd = "$env:USERPROFILE\.gemini\GEMINI.md"

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "   Superpowers Auto-Clean for Antigravity (Windows)" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "This will remove all installed skills, setup tools, and global rules." -ForegroundColor Yellow
Write-Host "NOTE: It will NOT delete your chat history or artifacts inside Antigravity." -ForegroundColor Yellow
Write-Host ""
$confirm = Read-Host "Are you sure you want to proceed? (yes/no)"
if ($confirm -ne "yes") {
    Write-Host "Cancelled."
    exit 0
}

Write-Host ""
Write-Host "[1/3] Removing installed skills..."
if (Test-Path "$GlobalDir\skills") { Remove-Item "$GlobalDir\skills" -Recurse -Force }
Write-Host "   OK: Removed skills" -ForegroundColor Green

Write-Host "[2/3] Removing setup utilities..."
if (Test-Path "$GlobalDir\setup") { Remove-Item "$GlobalDir\setup" -Recurse -Force }
if (Test-Path "$GlobalDir\scripts") { Remove-Item "$GlobalDir\scripts" -Recurse -Force }
if (Test-Path "$GlobalDir\.superpowers-cache") { Remove-Item "$GlobalDir\.superpowers-cache" -Recurse -Force }
Write-Host "   OK: Removed toolset" -ForegroundColor Green

Write-Host "[3/3] Removing global GEMINI.md rules..."
if (Test-Path $GeminiMd) { Remove-Item $GeminiMd -Force }
Write-Host "   OK: Removed GEMINI.md" -ForegroundColor Green
Write-Host ""
Write-Host "✅ Cleanup Complete!" -ForegroundColor Green
