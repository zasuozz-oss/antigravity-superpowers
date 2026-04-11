# Update Spec-Kit templates from upstream repository
# Pulls latest templates from github/spec-kit, updates local references,
# and reports any changes to command templates (SKILL.md files)
# Usage: powershell -ExecutionPolicy Bypass -File update-speckit.ps1

$ErrorActionPreference = "Stop"

$UpstreamRepo = "https://github.com/github/spec-kit.git"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PotentialFork = Split-Path -Parent $ScriptDir
$GlobalDir = Join-Path $env:USERPROFILE ".gemini\antigravity"
$GlobalSkillsDir = Join-Path $GlobalDir "skills"

$ForkRepoDir = $null
if ($PotentialFork -ne $GlobalDir -and (Test-Path (Join-Path $PotentialFork "skills"))) {
    $ForkRepoDir = $PotentialFork
} elseif ((Get-Location).Path -ne $GlobalDir -and (Test-Path (Join-Path (Get-Location).Path "skills"))) {
    $ForkRepoDir = (Get-Location).Path
}

$SpecKitUpstreamDir = if ($ForkRepoDir) { Join-Path $ForkRepoDir "spec-kit-upstream" } else { $null }
$CacheDir = Join-Path $GlobalDir ".speckit-cache"

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════╗"
Write-Host "║     Spec-Kit Update Workflow                               ║"
Write-Host "║     Pull upstream → Update templates → Report diffs        ║"
Write-Host "╚════════════════════════════════════════════════════════════╝"
Write-Host ""

# Step 1: Fetch upstream
Write-Host "🔄 Step 1: Fetching upstream (github/spec-kit)..."
if (Test-Path $CacheDir) { Remove-Item $CacheDir -Recurse -Force }
git clone --quiet --depth 1 $UpstreamRepo $CacheDir 2>$null
Write-Host "   ✓ Cloned" -ForegroundColor Green
Write-Host ""

# Step 2: Update spec-kit-upstream reference directory
Write-Host "📦 Step 2: Updating spec-kit-upstream reference..."
$TemplateCount = 0
$CmdCount = 0

if ($ForkRepoDir) {
    New-Item -ItemType Directory -Path (Join-Path $SpecKitUpstreamDir "templates") -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $SpecKitUpstreamDir "commands") -Force | Out-Null

    # Update templates
    $Templates = @("constitution-template", "tasks-template", "spec-template", "plan-template", "checklist-template")
    foreach ($tpl in $Templates) {
        $Src = Join-Path $CacheDir "templates\${tpl}.md"
        if (Test-Path $Src) {
            Copy-Item $Src (Join-Path $SpecKitUpstreamDir "templates\${tpl}.md") -Force
            $TemplateCount++
        }
    }
    Write-Host "   ✓ $TemplateCount templates updated" -ForegroundColor Green

    # Update command references
    $Commands = @("analyze", "clarify", "constitution", "tasks")
    foreach ($cmd in $Commands) {
        $Src = Join-Path $CacheDir "templates\commands\${cmd}.md"
        if (Test-Path $Src) {
            Copy-Item $Src (Join-Path $SpecKitUpstreamDir "commands\${cmd}.md") -Force
            $CmdCount++
        }
    }
    Write-Host "   ✓ $CmdCount command references updated" -ForegroundColor Green
} else {
    Write-Host "   ⚠️  Fork repo not found. Skipping upstream reference update." -ForegroundColor Yellow
}
Write-Host ""

# Step 3: Update skill templates (overwrite directly)
Write-Host "📚 Step 3: Updating skill templates..."
$SkillTemplateUpdated = 0

# constitution-template → project-constitution
$ConstSrc = Join-Path $CacheDir "templates\constitution-template.md"
$ConstDst = Join-Path $GlobalSkillsDir "project-constitution\templates\constitution-template.md"
if ((Test-Path $ConstSrc) -and (Test-Path (Split-Path $ConstDst -Parent))) {
    Copy-Item $ConstSrc $ConstDst -Force
    $SkillTemplateUpdated++
    Write-Host "   ✓ constitution-template.md → project-constitution" -ForegroundColor Green
}

# tasks-template → task-decomposition
$TasksSrc = Join-Path $CacheDir "templates\tasks-template.md"
$TasksDst = Join-Path $GlobalSkillsDir "task-decomposition\templates\tasks-template.md"
if ((Test-Path $TasksSrc) -and (Test-Path (Split-Path $TasksDst -Parent))) {
    Copy-Item $TasksSrc $TasksDst -Force
    $SkillTemplateUpdated++
    Write-Host "   ✓ tasks-template.md → task-decomposition" -ForegroundColor Green
}

Write-Host "   ✓ $SkillTemplateUpdated skill templates updated" -ForegroundColor Green
Write-Host ""

# Step 4: Diff command templates vs SKILL.md (report only, NO overwrite)
Write-Host "🔍 Step 4: Checking command template changes (report only)..."
Write-Host ""

$SkillMap = @{
    "analyze"      = "spec-analyze"
    "clarify"      = "spec-clarify"
    "constitution" = "project-constitution"
    "tasks"        = "task-decomposition"
}

$HasDiffs = $false

foreach ($entry in $SkillMap.GetEnumerator()) {
    $CmdName = $entry.Key
    $SkillName = $entry.Value
    $CmdSrc = Join-Path $CacheDir "templates\commands\${CmdName}.md"
    $SkillDir = Join-Path $GlobalSkillsDir $SkillName

    if ((Test-Path $CmdSrc) -and (Test-Path $SkillDir)) {
        $RefFile = Join-Path $SpecKitUpstreamDir "commands\${CmdName}.md"
        if (Test-Path $RefFile) {
            $DiffOutput = Compare-Object (Get-Content $RefFile) (Get-Content $CmdSrc) -SyncWindow 0
            if ($DiffOutput) {
                $HasDiffs = $true
                Write-Host "   ⚠️  ${CmdName}.md has upstream changes → affects skill: $SkillName" -ForegroundColor Yellow
            }
        }
    }
}

if (-not $HasDiffs) {
    Write-Host "   ✓ No command template changes detected" -ForegroundColor Green
}
Write-Host ""

# Step 5: Sync to fork repo
if ($ForkRepoDir -and (Test-Path (Join-Path $ForkRepoDir "skills"))) {
    Write-Host "🔄 Step 5: Syncing templates to fork repo..."

    foreach ($SkillDir in @("project-constitution", "task-decomposition")) {
        $Src = Join-Path $GlobalSkillsDir "$SkillDir\templates"
        $Dst = Join-Path $ForkRepoDir "skills\$SkillDir\templates"
        if ((Test-Path $Src) -and (Test-Path $Dst)) {
            Copy-Item -Path "$Src\*" -Destination $Dst -Force -Recurse 2>$null
        }
    }

    Write-Host "   ✓ Synced to $ForkRepoDir" -ForegroundColor Green
    Write-Host ""
    Write-Host "   📌 Remember to commit changes in the fork repo:"
    Write-Host "   cd $ForkRepoDir"
    Write-Host "   git add -A; git commit -m 'chore: update spec-kit templates from upstream'"
}

# Cleanup
Remove-Item $CacheDir -Recurse -Force -ErrorAction SilentlyContinue

# Summary
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════╗"
Write-Host "║     Spec-Kit Update Complete                               ║"
Write-Host "╚════════════════════════════════════════════════════════════╝"
Write-Host ""
Write-Host "📊 Summary:"
Write-Host "   - Upstream templates: ✓ Updated ($TemplateCount)"
Write-Host "   - Command references: ✓ Updated ($CmdCount)"
Write-Host "   - Skill templates: ✓ Updated ($SkillTemplateUpdated)"
if ($HasDiffs) {
    Write-Host "   - Command diffs: ⚠️  Changes detected (review manually)" -ForegroundColor Yellow
} else {
    Write-Host "   - Command diffs: ✓ No changes"
}
Write-Host ""
Write-Host "✅ Done!" -ForegroundColor Green
