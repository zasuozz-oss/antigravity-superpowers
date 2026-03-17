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

# Step 1: Create directory
Write-Host "[1/7] Creating global config directory..."
New-Item -ItemType Directory -Path $GlobalDir -Force | Out-Null
Write-Host "   OK: $GlobalDir" -ForegroundColor Green
Write-Host ""

# Step 2: Check for duplicate skill names
Write-Host "[2/7] Checking for duplicate skills..."
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
Write-Host "[3/7] Installing skills..."
if (Test-Path "$GlobalDir\skills") { Remove-Item "$GlobalDir\skills" -Recurse -Force }
Copy-Item -Path "$ScriptDir\global-config\skills" -Destination "$GlobalDir\skills" -Recurse
$SkillCount = (Get-ChildItem "$GlobalDir\skills" -Directory).Count
Write-Host "   OK: $SkillCount skills" -ForegroundColor Green
Write-Host ""

# Step 4: Install workflows
Write-Host "[4/7] Installing workflows..."
if (Test-Path "$GlobalDir\global_workflows") { Remove-Item "$GlobalDir\global_workflows" -Recurse -Force }
$WorkflowCount = 0
if (Test-Path "$ScriptDir\global-config\workflows") {
    Copy-Item -Path "$ScriptDir\global-config\workflows" -Destination "$GlobalDir\global_workflows" -Recurse
    $WorkflowCount = (Get-ChildItem "$GlobalDir\global_workflows" -File).Count
    Write-Host "   OK: $WorkflowCount workflows" -ForegroundColor Green
} else {
    Write-Host "   SKIP: No workflows found" -ForegroundColor Yellow
}
Write-Host ""

# Step 5: Install scripts
Write-Host "[5/7] Installing scripts..."
if (Test-Path "$GlobalDir\scripts") { Remove-Item "$GlobalDir\scripts" -Recurse -Force }
Copy-Item -Path "$ScriptDir\scripts" -Destination "$GlobalDir\scripts" -Recurse
$ScriptCount = (Get-ChildItem "$GlobalDir\scripts" -File).Count
Write-Host "   OK: $ScriptCount scripts" -ForegroundColor Green
Write-Host ""

# Step 6: Update GEMINI.md
Write-Host "[6/7] Updating global GEMINI.md..."

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

# Step 7: Cleanup old legacy directories if present
if (Test-Path "$GlobalDir\rules") {
    Write-Host "[7/7] Cleaning up legacy directories..."
    Remove-Item "$GlobalDir\rules" -Recurse -Force
    Write-Host "   OK: Removed legacy rules" -ForegroundColor Green
    Write-Host ""
}

# Verify
Write-Host "Verification..." -ForegroundColor Green
Write-Host "   Skills:    $SkillCount"
Write-Host "   Workflows: $WorkflowCount"
Write-Host "   Scripts:   $ScriptCount"
Write-Host "   GEMINI.md: OK"
Write-Host ""
Write-Host "========================================================" -ForegroundColor Green
Write-Host "   Installation Complete" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
Write-Host ""
Write-Host "   Next: Open Antigravity in your project directory"
Write-Host ""
