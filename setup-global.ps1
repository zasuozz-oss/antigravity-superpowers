# Global setup script for Superpowers in Antigravity (Windows)
# Installs skills, rules, and workflows to ~/.gemini/antigravity/
# Usage: powershell -ExecutionPolicy Bypass -File setup-global.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$GlobalDir = "$env:USERPROFILE\.gemini\antigravity"
$GeminiMd = "$env:USERPROFILE\.gemini\GEMINI.md"

Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "   Superpowers Global Setup for Antigravity (Windows)" -ForegroundColor Cyan
Write-Host "   Install skills, rules, and workflows globally" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# Check source
if (-not (Test-Path "$ScriptDir\global-config\skills")) {
    Write-Host "ERROR: global-config\skills\ not found" -ForegroundColor Red
    Write-Host "   Make sure you're running this from the repository root"
    exit 1
}

# Create global config directory
Write-Host "[1/6] Creating global config directory..."
New-Item -ItemType Directory -Path $GlobalDir -Force | Out-Null
Write-Host "   OK: $GlobalDir" -ForegroundColor Green
Write-Host ""

# Backup existing config
if ((Test-Path "$GlobalDir\skills") -or (Test-Path "$GlobalDir\rules") -or (Test-Path "$GlobalDir\workflows")) {
    $BackupDir = "$GlobalDir-backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Write-Host "[2/6] Backing up existing config..."
    Copy-Item -Path $GlobalDir -Destination $BackupDir -Recurse
    Write-Host "   OK: $BackupDir" -ForegroundColor Green
    Write-Host ""
}

# Install skills
Write-Host "[3/6] Installing skills..."
if (Test-Path "$GlobalDir\skills") { Remove-Item "$GlobalDir\skills" -Recurse -Force }
Copy-Item -Path "$ScriptDir\global-config\skills" -Destination "$GlobalDir\skills" -Recurse
$SkillCount = (Get-ChildItem "$GlobalDir\skills" -Directory).Count
Write-Host "   OK: $SkillCount skills installed" -ForegroundColor Green
Write-Host ""

# Install rules
Write-Host "[4/6] Installing rules..."
if (Test-Path "$GlobalDir\rules") { Remove-Item "$GlobalDir\rules" -Recurse -Force }
Copy-Item -Path "$ScriptDir\global-config\rules" -Destination "$GlobalDir\rules" -Recurse
$RuleCount = (Get-ChildItem "$GlobalDir\rules" -File).Count
Write-Host "   OK: $RuleCount rules installed" -ForegroundColor Green
Write-Host ""

# Install workflows
Write-Host "[5/6] Installing workflows..."
if (Test-Path "$GlobalDir\workflows") { Remove-Item "$GlobalDir\workflows" -Recurse -Force }
Copy-Item -Path "$ScriptDir\global-config\workflows" -Destination "$GlobalDir\workflows" -Recurse
$WorkflowCount = (Get-ChildItem "$GlobalDir\workflows" -File).Count
Write-Host "   OK: $WorkflowCount workflows installed" -ForegroundColor Green
Write-Host ""

# Generate global GEMINI.md
Write-Host "[6/6] Generating global GEMINI.md..."
$GeminiContent = @"
# Superpowers Global Rules

@~/.gemini/antigravity/rules/00-mandatory-skills.md
@~/.gemini/antigravity/rules/01-iron-laws.md
@~/.gemini/antigravity/rules/02-workflow-enforcement.md
@~/.gemini/antigravity/rules/03-language-convention.md
"@
New-Item -ItemType Directory -Path (Split-Path $GeminiMd) -Force | Out-Null
Set-Content -Path $GeminiMd -Value $GeminiContent -Encoding UTF8
Write-Host "   OK: $GeminiMd" -ForegroundColor Green
Write-Host ""

# Summary
Write-Host "========================================================" -ForegroundColor Green
Write-Host "   Installation Complete" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
Write-Host ""
Write-Host "   Global config : $GlobalDir"
Write-Host "   Global rules  : $GeminiMd"
Write-Host "   Skills        : $SkillCount"
Write-Host "   Rules         : $RuleCount"
Write-Host "   Workflows     : $WorkflowCount"
Write-Host ""
Write-Host "   Next: Open Antigravity in your project directory"
Write-Host ""
