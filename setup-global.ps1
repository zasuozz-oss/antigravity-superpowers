# Global setup script for Superpowers in Antigravity (Windows)
# Installs skills and scripts to ~/.gemini/antigravity/
# Usage: powershell -ExecutionPolicy Bypass -File setup-global.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$GlobalDir = "$env:USERPROFILE\.gemini\antigravity"
$GeminiMd = "$env:USERPROFILE\.gemini\GEMINI.md"

# Block markers for detect/replace
$BlockStart = "<!-- BEGIN antigravity-superpowers -->"
$BlockEnd = "<!-- END antigravity-superpowers -->"

Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "   Superpowers Global Setup for Antigravity (Windows)" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# Check source
if (-not (Test-Path "$ScriptDir\global-config\skills")) {
    Write-Host "ERROR: global-config\skills\ not found" -ForegroundColor Red
    exit 1
}

# Step 1: Create directory
Write-Host "[1/6] Creating global config directory..."
New-Item -ItemType Directory -Path $GlobalDir -Force | Out-Null
Write-Host "   OK: $GlobalDir" -ForegroundColor Green
Write-Host ""

# Step 2: Backup
if ((Test-Path "$GlobalDir\skills") -or (Test-Path "$GlobalDir\scripts")) {
    $BackupDir = "$GlobalDir-backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Write-Host "[2/6] Backing up existing config..."
    Copy-Item -Path $GlobalDir -Destination $BackupDir -Recurse
    Write-Host "   OK: $BackupDir" -ForegroundColor Green
    Write-Host ""
}

# Step 3: Install skills
Write-Host "[3/6] Installing skills..."
if (Test-Path "$GlobalDir\skills") { Remove-Item "$GlobalDir\skills" -Recurse -Force }
Copy-Item -Path "$ScriptDir\global-config\skills" -Destination "$GlobalDir\skills" -Recurse
$SkillCount = (Get-ChildItem "$GlobalDir\skills" -Directory).Count
Write-Host "   OK: $SkillCount skills" -ForegroundColor Green
Write-Host ""

# Step 4: Install scripts
Write-Host "[4/6] Installing scripts..."
if (Test-Path "$GlobalDir\scripts") { Remove-Item "$GlobalDir\scripts" -Recurse -Force }
Copy-Item -Path "$ScriptDir\scripts" -Destination "$GlobalDir\scripts" -Recurse
$ScriptCount = (Get-ChildItem "$GlobalDir\scripts" -File).Count
Write-Host "   OK: $ScriptCount scripts" -ForegroundColor Green
Write-Host ""

# Step 5: Update GEMINI.md
Write-Host "[5/6] Updating global GEMINI.md..."

$RuleFile = "$ScriptDir\global-config\gemini_rule.md"

New-Item -ItemType Directory -Path (Split-Path $GeminiMd) -Force | Out-Null

# Always overwrite — GEMINI.md is a generated file
$content = "@~/.gemini/antigravity/skills/using-superpowers/SKILL.md`n@~/.gemini/antigravity/skills/using-superpowers/references/gemini-tools.md`n"
if (Test-Path $RuleFile) {
    $content += "`n" + (Get-Content $RuleFile -Raw)
}
Set-Content -Path $GeminiMd -Value $content -Encoding UTF8
Write-Host "   OK: Written $GeminiMd" -ForegroundColor Green
Write-Host ""

# Step 6: Cleanup old rules/workflows if present
if ((Test-Path "$GlobalDir\rules") -or (Test-Path "$GlobalDir\global_workflows")) {
    Write-Host "[6/6] Cleaning up old rules/workflows..."
    if (Test-Path "$GlobalDir\rules") { Remove-Item "$GlobalDir\rules" -Recurse -Force }
    if (Test-Path "$GlobalDir\global_workflows") { Remove-Item "$GlobalDir\global_workflows" -Recurse -Force }
    Write-Host "   OK: Removed legacy rules and workflows" -ForegroundColor Green
    Write-Host ""
}

# Verify
Write-Host "Verification..." -ForegroundColor Green
Write-Host "   Skills:    $SkillCount"
Write-Host "   Scripts:   $ScriptCount"
Write-Host "   GEMINI.md: OK"
Write-Host ""
Write-Host "========================================================" -ForegroundColor Green
Write-Host "   Installation Complete" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
Write-Host ""
Write-Host "   Next: Open Antigravity in your project directory"
Write-Host ""
