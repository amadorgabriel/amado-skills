<#
.SYNOPSIS
Copies active skills from skills/ into Claude Code and Cursor user skills folders. Safe to re-run.

.DESCRIPTION
Discovers promoted category skills (skills/<category>/<skill>), in-progress drafts (skills/in-progress/<skill>),
and vendored external skills (skills/external/<author>/<skill>), flattening them by skill name into
~/.claude/skills and ~/.cursor/skills. Skips _/ and deprecated/. Fails on skill name collisions.

.EXAMPLE
.\scripts\install.ps1
.\scripts\install.ps1 lesson code-review
.\scripts\install.ps1 -Agents cursor lesson
#>
[CmdletBinding()]
param(
  [ValidateSet("claude", "cursor")]
  [string[]]$Agents = @("claude", "cursor"),

  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$Skills
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$SkillsRoot = Join-Path $RepoRoot "skills"

if (-not (Test-Path $SkillsRoot)) {
  throw "Skills directory not found: $SkillsRoot"
}

$Discovered = @{}

function Register-Skill {
  param(
    [string]$Name,
    [string]$Category,
    [string]$SkillPath
  )
  if ($Discovered.ContainsKey($Name)) {
    $existing = $Discovered[$Name].Path
    throw "Skill name collision for '$Name': '$existing' conflicts with '$SkillPath'. Rename or exclude one before installing."
  }
  $Discovered[$Name] = [PSCustomObject]@{
    Name     = $Name
    Category = $Category
    Path     = $SkillPath
  }
}

Get-ChildItem -Path $SkillsRoot -Directory | Where-Object { $_.Name -notin @("_", "deprecated") } | ForEach-Object {
  $category = $_.Name
  if ($category -eq "external") {
    Get-ChildItem -Path $_.FullName -Directory | Where-Object { $_.Name -ne "_" } | ForEach-Object {
      $author = $_.Name
      Get-ChildItem -Path $_.FullName -Directory | Where-Object { $_.Name -ne "_" } | ForEach-Object {
        if (Test-Path (Join-Path $_.FullName "SKILL.md")) {
          Register-Skill -Name $_.Name -Category "external/$author" -SkillPath $_.FullName
        }
      }
    }
  } else {
    Get-ChildItem -Path $_.FullName -Directory | Where-Object { $_.Name -ne "_" } | ForEach-Object {
      if (Test-Path (Join-Path $_.FullName "SKILL.md")) {
        Register-Skill -Name $_.Name -Category $category -SkillPath $_.FullName
      }
    }
  }
}

$Targets = @()
if (-not $Skills -or $Skills.Count -eq 0) {
  $Targets = $Discovered.Values | Sort-Object Name
} else {
  foreach ($requested in $Skills) {
    $key = ($requested -split "[/\\]")[-1]
    if (-not $Discovered.ContainsKey($key)) {
      throw "No active skill named '$requested'. Available: $($Discovered.Keys | Sort-Object -join ', ')"
    }
    $Targets += $Discovered[$key]
  }
}

$Destinations = @{
  claude = if ($env:CLAUDE_SKILLS_DIR) { $env:CLAUDE_SKILLS_DIR } else { Join-Path $HOME ".claude\skills" }
  cursor = if ($env:CURSOR_SKILLS_DIR) { $env:CURSOR_SKILLS_DIR } else { Join-Path $HOME ".cursor\skills" }
}

foreach ($agent in $Agents) {
  $destRoot = $Destinations[$agent]
  New-Item -ItemType Directory -Path $destRoot -Force | Out-Null
  foreach ($skill in $Targets) {
    $destSkill = Join-Path $destRoot $skill.Name
    New-Item -ItemType Directory -Path $destSkill -Force | Out-Null
    & robocopy $skill.Path $destSkill /E /NFL /NDL /NJH /NJS /NP /XD node_modules .venv __pycache__ _ output | Out-Null
    if ($LASTEXITCODE -ge 8) {
      throw "Failed to copy '$($skill.Name)' to '$destSkill' (robocopy exit code $LASTEXITCODE)"
    }
    Write-Output "installed $($skill.Name) ($($skill.Category)) -> $destSkill"
  }
}

Write-Output "done: installed $($Targets.Count) skill(s) for $($Agents -join ', ')"
$global:LASTEXITCODE = 0
exit 0
