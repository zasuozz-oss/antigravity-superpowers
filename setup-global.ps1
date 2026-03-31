# Global setup script for Superpowers in Antigravity (Windows)
# Installs skills, workflows, and scripts to ~/.gemini/antigravity/
# Usage: powershell -ExecutionPolicy Bypass -File setup-global.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$GlobalDir = "$env:USERPROFILE\.gemini\antigravity"
$GeminiMd = "$env:USERPROFILE\.gemini\GEMINI.md"


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

Write-Host "[1/5] Creating global config directory..."
New-Item -ItemType Directory -Path $GlobalDir -Force | Out-Null
Write-Host "   OK: $GlobalDir" -ForegroundColor Green
Write-Host ""

# Step 2: Check for duplicate skill names
Write-Host "[2/5] Checking for duplicate skills..."
$SkillNames = @{}
$SkillFiles = Get-ChildItem -Path "$ScriptDir\global-config\skills\*\SKILL.md" -ErrorAction SilentlyContinue
foreach ($file in $SkillFiles) {
    $nameMatch = Select-String -Path $file -Pattern '^name:\s*(.+)$' | Select-Object -First 1
    if ($nameMatch) {
        $skillName = $nameMatch.Matches[0].Groups[1].Value.Trim()
        if ($SkillNames.ContainsKey($skillName)) {
            Write-Host "   ERROR: Duplicate skill name '$skillName' found in:" -ForegroundColor Red
            Write-Host "      - $($SkillNames[$skillName])" -ForegroundColor Red
            Write-Host "      - $($file.FullName)" -ForegroundColor Red
            exit 1
        }
        $SkillNames[$skillName] = $file.FullName
    }
}
Write-Host "   OK: $($SkillNames.Count) skills checked, no duplicates" -ForegroundColor Green
Write-Host ""

# Step 3: Install skills
Write-Host "[3/5] Installing skills..."
if (Test-Path "$GlobalDir\skills") { Remove-Item "$GlobalDir\skills" -Recurse -Force }
Copy-Item -Path "$ScriptDir\global-config\skills" -Destination "$GlobalDir\skills" -Recurse
$SkillCount = (Get-ChildItem "$GlobalDir\skills" -Directory).Count
Write-Host "   OK: $SkillCount skills" -ForegroundColor Green
Write-Host ""

# Step 4: Install scripts
Write-Host "[4/5] Installing scripts..."
if (Test-Path "$GlobalDir\scripts") { Remove-Item "$GlobalDir\scripts" -Recurse -Force }
Copy-Item -Path "$ScriptDir\scripts" -Destination "$GlobalDir\scripts" -Recurse
$ScriptCount = (Get-ChildItem "$GlobalDir\scripts" -File).Count
Write-Host "   OK: $ScriptCount scripts" -ForegroundColor Green
Write-Host ""

# Step 5: Update GEMINI.md
Write-Host "[5/5] Updating global GEMINI.md..."

$RuleFile = "$ScriptDir\global-config\gemini_rule.md"

New-Item -ItemType Directory -Path (Split-Path $GeminiMd) -Force | Out-Null

# Always overwrite — GEMINI.md is a generated file
$content = ""
if (Test-Path $RuleFile) {
    $content = Get-Content $RuleFile -Raw
}
Set-Content -Path $GeminiMd -Value $content -Encoding UTF8
Write-Host "   OK: Written $GeminiMd" -ForegroundColor Green
Write-Host ""

# Cleanup old legacy directories if present
$needsCleanup = (Test-Path "$GlobalDir\rules") -or (Test-Path "$GlobalDir\global_workflows")
if ($needsCleanup) {
    Write-Host "Cleaning up legacy directories..."
    if (Test-Path "$GlobalDir\rules") { Remove-Item "$GlobalDir\rules" -Recurse -Force }
    if (Test-Path "$GlobalDir\global_workflows") { Remove-Item "$GlobalDir\global_workflows" -Recurse -Force }
    Write-Host "   OK: Removed legacy directories" -ForegroundColor Green
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
