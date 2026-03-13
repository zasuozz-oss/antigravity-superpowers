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
Write-Host "[5/7] Installing workflows..."
if (Test-Path "$GlobalDir\workflows") { Remove-Item "$GlobalDir\workflows" -Recurse -Force }
Copy-Item -Path "$ScriptDir\global-config\workflows" -Destination "$GlobalDir\workflows" -Recurse
$WorkflowCount = (Get-ChildItem "$GlobalDir\workflows" -File).Count
Write-Host "   OK: $WorkflowCount workflows installed" -ForegroundColor Green
Write-Host ""

# Language selection
Write-Host "[6/7] Select default language for documentation/explanations"
Write-Host "   1. English (default)"
Write-Host "   2. Tieng Viet"
Write-Host "   3. Japanese"
Write-Host "   4. Chinese"
Write-Host "   5. Korean"
Write-Host ""
$langChoice = Read-Host "Choose (1-5) [1]"
if (-not $langChoice) { $langChoice = "1" }

switch ($langChoice) {
    "2" { $DocLang = "Vietnamese" }
    "3" { $DocLang = "Japanese" }
    "4" { $DocLang = "Chinese" }
    "5" { $DocLang = "Korean" }
    default { $DocLang = "English" }
}

# Generate language convention rule
$LangContent = @"
# LANGUAGE CONVENTION

## Default Language: $DocLang

All output should follow these language rules:

| Content Type | Language |
|-------------|----------|
| Code, variables, functions, classes | English (always) |
| Comments, logs, error messages | English |
| Commit messages, PR descriptions | English |
| Documentation, README, guides | $DocLang |
| User-facing explanations, responses | $DocLang |

## Override Rules

- If the user writes in a specific language, respond in that same language.
- If the user explicitly requests another language, follow the user's request.
- Code identifiers (variables, functions, classes) must ALWAYS be in English regardless of conversation language.
"@
Set-Content -Path "$GlobalDir\rules\03-language-convention.md" -Value $LangContent -Encoding UTF8
Write-Host "   OK: Language set to $DocLang" -ForegroundColor Green
Write-Host ""

# Generate global GEMINI.md
Write-Host "[7/7] Generating global GEMINI.md..."
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
Write-Host "   Language      : $DocLang"
Write-Host ""
Write-Host "   Next: Open Antigravity in your project directory"
Write-Host ""

