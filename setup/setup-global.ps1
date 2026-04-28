# Global setup script for Superpowers in Antigravity (Windows)
# Installs skills, workflows, and scripts to ~/.gemini/antigravity/
# Usage: powershell -ExecutionPolicy Bypass -File setup-global.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$GlobalDir = "$env:USERPROFILE\.gemini\antigravity"
$GeminiMd = "$env:USERPROFILE\.gemini\GEMINI.md"
$ClaudeMd = "$env:USERPROFILE\.claude\CLAUDE.md"
$CodexMd = "$env:USERPROFILE\.codex\AGENTS.md"

$BeginMarker = '<!-- AG-SUPERPOWERS:BEGIN -->'
$EndMarker = '<!-- AG-SUPERPOWERS:END -->'

# --- Upsert-Block: replace or append a marker-delimited block in a file ---
function Upsert-Block {
    param(
        [string]$TargetFile,
        [string]$RuleFile
    )

    if (-not (Test-Path $RuleFile)) {
        Write-Host "   SKIP: $RuleFile not found" -ForegroundColor Yellow
        return
    }

    $dir = Split-Path $TargetFile
    if ($dir) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }

    $blockContent = Get-Content $RuleFile -Raw

    if ((Test-Path $TargetFile) -and (Get-Content $TargetFile -Raw) -match [regex]::Escape($BeginMarker)) {
        # Replace existing block in-place
        $current = Get-Content $TargetFile -Raw
        $pattern = [regex]::Escape($BeginMarker) + '[\s\S]*?' + [regex]::Escape($EndMarker)
        $updated = [regex]::Replace($current, $pattern, $blockContent.TrimEnd())
        Set-Content -Path $TargetFile -Value $updated -Encoding UTF8 -NoNewline
        Write-Host "   OK: Updated block in $TargetFile (user content preserved)" -ForegroundColor Green
    }
    elseif ((Test-Path $TargetFile) -and (Get-Item $TargetFile).Length -gt 0) {
        # Append block
        Add-Content -Path $TargetFile -Value "`n$blockContent" -Encoding UTF8
        Write-Host "   OK: Appended block to $TargetFile (existing content preserved)" -ForegroundColor Green
    }
    else {
        # Create fresh
        Set-Content -Path $TargetFile -Value $blockContent -Encoding UTF8
        Write-Host "   OK: Created $TargetFile" -ForegroundColor Green
    }
}


Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "   Superpowers Global Setup (Windows)" -ForegroundColor Cyan
Write-Host "   Install skills & rules globally" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# Check source
$ProjectRoot = Resolve-Path "$ScriptDir\.." | Select-Object -ExpandProperty Path
if (-not (Test-Path "$ProjectRoot\skills")) {
    Write-Host "ERROR: skills\ not found" -ForegroundColor Red
    exit 1
}

Write-Host "[1/7] Creating global config directory..."
New-Item -ItemType Directory -Path $GlobalDir -Force | Out-Null
Write-Host "   OK: $GlobalDir" -ForegroundColor Green
Write-Host ""

# Step 2: Check for duplicate skill names
Write-Host "[2/7] Checking for duplicate skills..."
$SkillNames = @{}
$SkillFiles = Get-ChildItem -Path "$ProjectRoot\skills\*\SKILL.md" -ErrorAction SilentlyContinue
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
Copy-Item -Path "$ProjectRoot\skills" -Destination "$GlobalDir\skills" -Recurse

# Remove excluded skills
$ExcludesFile = "$ScriptDir\ignore-skills.txt"
if (Test-Path $ExcludesFile) {
    Get-Content $ExcludesFile | ForEach-Object {
        $excl = $_.Trim().TrimEnd('/')
        if (![string]::IsNullOrEmpty($excl)) {
            $exclPath = Join-Path "$GlobalDir\skills" $excl
            if (Test-Path $exclPath) {
                Remove-Item $exclPath -Recurse -Force
            }
        }
    }
}

$SkillCount = (Get-ChildItem "$GlobalDir\skills" -Directory).Count
Write-Host "   OK: $SkillCount skills" -ForegroundColor Green
Write-Host ""

# Step 4: Install scripts
Write-Host "[4/7] Installing setup scripts..."
if (Test-Path "$GlobalDir\setup") { Remove-Item "$GlobalDir\setup" -Recurse -Force }
Copy-Item -Path "$ProjectRoot\setup" -Destination "$GlobalDir\setup" -Recurse
$ScriptCount = (Get-ChildItem "$GlobalDir\setup" -File).Count
Write-Host "   OK: $ScriptCount setup scripts" -ForegroundColor Green
Write-Host ""

# Step 5: Update GEMINI.md (Antigravity)
Write-Host "[5/7] Updating Antigravity rules (~/.gemini/GEMINI.md)..."
Upsert-Block -TargetFile $GeminiMd -RuleFile "$ScriptDir\gemini_rule.md"
Write-Host ""

# Step 6: Update CLAUDE.md (Claude Desktop)
Write-Host "[6/7] Updating Claude Desktop rules (~/.claude/CLAUDE.md)..."
Upsert-Block -TargetFile $ClaudeMd -RuleFile "$ScriptDir\claude_rule.md"
Write-Host ""

# Step 7: Update AGENTS.md (Codex)
Write-Host "[7/7] Updating Codex rules (~/.codex/AGENTS.md)..."
Upsert-Block -TargetFile $CodexMd -RuleFile "$ScriptDir\codex_rule.md"
Write-Host ""

# Step 5.5: Install spec-kit upstream references
$SpecKitSrc = "$ProjectRoot\spec-kit-upstream"
$SpecKitDst = "$GlobalDir\spec-kit-upstream"
if (Test-Path $SpecKitSrc) {
    Write-Host "Installing spec-kit reference templates..."
    if (Test-Path $SpecKitDst) { Remove-Item $SpecKitDst -Recurse -Force }
    Copy-Item -Path $SpecKitSrc -Destination $SpecKitDst -Recurse
    $SpecKitCount = (Get-ChildItem $SpecKitDst -File -Recurse).Count
    Write-Host "   OK: $SpecKitCount spec-kit reference files" -ForegroundColor Green
    Write-Host ""
}

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
Write-Host "   GEMINI.md: $(if (Test-Path $GeminiMd) { 'OK' } else { 'MISSING' })"
Write-Host "   CLAUDE.md: $(if (Test-Path $ClaudeMd) { 'OK' } else { 'MISSING' })"
Write-Host "   AGENTS.md: $(if (Test-Path $CodexMd) { 'OK' } else { 'MISSING' })"
Write-Host ""
Write-Host "========================================================" -ForegroundColor Green
Write-Host "   Installation Complete" -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
Write-Host ""
Write-Host "   Next: Restart Antigravity / Claude Desktop / Codex"
Write-Host ""
