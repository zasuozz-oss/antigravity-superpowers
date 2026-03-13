# Global setup script for Superpowers in Antigravity (Windows)
# Installs skills, rules, and workflows to ~/.gemini/antigravity/
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
Write-Host "[1/8] Creating global config directory..."
New-Item -ItemType Directory -Path $GlobalDir -Force | Out-Null
Write-Host "   OK: $GlobalDir" -ForegroundColor Green
Write-Host ""

# Step 2: Backup
if ((Test-Path "$GlobalDir\skills") -or (Test-Path "$GlobalDir\rules") -or (Test-Path "$GlobalDir\scripts")) {
    $BackupDir = "$GlobalDir-backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Write-Host "[2/8] Backing up existing config..."
    Copy-Item -Path $GlobalDir -Destination $BackupDir -Recurse
    Write-Host "   OK: $BackupDir" -ForegroundColor Green
    Write-Host ""
}

# Step 3: Install skills
Write-Host "[3/8] Installing skills..."
if (Test-Path "$GlobalDir\skills") { Remove-Item "$GlobalDir\skills" -Recurse -Force }
Copy-Item -Path "$ScriptDir\global-config\skills" -Destination "$GlobalDir\skills" -Recurse
$SkillCount = (Get-ChildItem "$GlobalDir\skills" -Directory).Count
Write-Host "   OK: $SkillCount skills" -ForegroundColor Green
Write-Host ""

# Step 4: Install rules
Write-Host "[4/8] Installing rules..."
if (Test-Path "$GlobalDir\rules") { Remove-Item "$GlobalDir\rules" -Recurse -Force }
Copy-Item -Path "$ScriptDir\global-config\rules" -Destination "$GlobalDir\rules" -Recurse
$RuleCount = (Get-ChildItem "$GlobalDir\rules" -File).Count
Write-Host "   OK: $RuleCount rules" -ForegroundColor Green
Write-Host ""

# Step 5: Install workflows
Write-Host "[5/8] Installing workflows..."
if (Test-Path "$GlobalDir\scripts") { Remove-Item "$GlobalDir\scripts" -Recurse -Force }
Copy-Item -Path "$ScriptDir\scripts" -Destination "$GlobalDir\scripts" -Recurse
$WorkflowCount = (Get-ChildItem "$GlobalDir\scripts" -File).Count
Write-Host "   OK: $WorkflowCount workflows" -ForegroundColor Green
Write-Host ""

# Step 6: Language selection
Write-Host "[6/8] Select default language" -ForegroundColor Yellow
Write-Host ""
Write-Host "   1.  English (default)"
Write-Host "   2.  Tieng Viet (Vietnamese)"
Write-Host "   3.  Japanese"
Write-Host "   4.  Chinese"
Write-Host "   5.  Korean"
Write-Host "   6.  Spanish"
Write-Host "   7.  French"
Write-Host "   8.  German"
Write-Host "   9.  Portuguese"
Write-Host "   10. Russian"
Write-Host "   11. Hindi"
Write-Host "   12. Arabic"
Write-Host "   13. Indonesian"
Write-Host "   14. Thai"
Write-Host "   15. Turkish"
Write-Host "   16. Italian"
Write-Host "   17. Polish"
Write-Host "   18. Dutch"
Write-Host "   19. Ukrainian"
Write-Host "   20. Filipino"
Write-Host ""
$langChoice = Read-Host "Choose (1-20) [1]"
if (-not $langChoice) { $langChoice = "1" }

$DocLang = switch ($langChoice) {
    "2"  { "Vietnamese" }
    "3"  { "Japanese" }
    "4"  { "Chinese" }
    "5"  { "Korean" }
    "6"  { "Spanish" }
    "7"  { "French" }
    "8"  { "German" }
    "9"  { "Portuguese" }
    "10" { "Russian" }
    "11" { "Hindi" }
    "12" { "Arabic" }
    "13" { "Indonesian" }
    "14" { "Thai" }
    "15" { "Turkish" }
    "16" { "Italian" }
    "17" { "Polish" }
    "18" { "Dutch" }
    "19" { "Ukrainian" }
    "20" { "Filipino" }
    default { "English" }
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
Write-Host "   OK: Language = $DocLang" -ForegroundColor Green
Write-Host ""

# Step 7: Update GEMINI.md (block-based, non-destructive)
Write-Host "[7/8] Updating global GEMINI.md..."

$SuperpowersBlock = @"
$BlockStart
@~/.gemini/antigravity/rules/00-mandatory-skills.md
@~/.gemini/antigravity/rules/01-iron-laws.md
@~/.gemini/antigravity/rules/02-workflow-enforcement.md
@~/.gemini/antigravity/rules/03-language-convention.md
$BlockEnd
"@

New-Item -ItemType Directory -Path (Split-Path $GeminiMd) -Force | Out-Null

if (Test-Path $GeminiMd) {
    $content = Get-Content $GeminiMd -Raw
    if ($content -match [regex]::Escape($BlockStart)) {
        # Replace existing block
        $pattern = [regex]::Escape($BlockStart) + "[\s\S]*?" + [regex]::Escape($BlockEnd)
        $content = [regex]::Replace($content, $pattern, $SuperpowersBlock.Trim())
        Set-Content -Path $GeminiMd -Value $content -Encoding UTF8
        Write-Host "   OK: Updated existing block" -ForegroundColor Green
    } else {
        # Append block
        Add-Content -Path $GeminiMd -Value "`n$SuperpowersBlock"
        Write-Host "   OK: Appended block" -ForegroundColor Green
    }
} else {
    # Create new file
    Set-Content -Path $GeminiMd -Value $SuperpowersBlock -Encoding UTF8
    Write-Host "   OK: Created $GeminiMd" -ForegroundColor Green
}
Write-Host ""

# Step 8: Verify
Write-Host "[8/8] Verification..." -ForegroundColor Green
Write-Host "   Skills:    $SkillCount"
Write-Host "   Rules:     $RuleCount"
Write-Host "   Workflows: $WorkflowCount"
Write-Host "   Language:  $DocLang"
Write-Host ""
Write-Host "========================================================" -ForegroundColor Green
Write-Host "   Installation Complete" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
Write-Host ""
Write-Host "   Next: Open Antigravity in your project directory"
Write-Host ""
