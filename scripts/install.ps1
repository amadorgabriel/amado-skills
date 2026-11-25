<#
.SYNOPSIS
Installs this repo's plugins and loose skills for Claude Code and Cursor. Safe to re-run.

.DESCRIPTION
Plugins (plugins/<plugin>/) are copied to ~/.cursor/plugins/local/<plugin> for Cursor. Claude Code installs
plugins from the marketplace instead (/plugin marketplace add amadorgabriel/amado-skills), so the script only
prints that hint.

Loose skills (skills/in-progress/<skill> and skills/external/<author>/<skill>) are flattened by skill name into
~/.claude/skills and ~/.cursor/skills. Skips _/ and deprecated/. Fails on skill name collisions, including
skills shipped inside plugins.

.EXAMPLE
.\scripts\install.ps1
.\scripts\install.ps1 diary lesson
.\scripts\install.ps1 -Agents cursor job
#>
[CmdletBinding(PositionalBinding = $false)]
param(
  [ValidateSet("claude", "cursor")]
  [string[]]$Agents = @("claude", "cursor"),

  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$Names
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot
$SkillsRoot = Join-Path $RepoRoot "skills"
$PluginsRoot = Join-Path $RepoRoot "plugins"

$Skills = @{}
$Plugins = @{}
$PluginSkills = @{}

function Register-Skill {
  param([string]$Name, [string]$Label, [string]$SkillPath)
  if ($Skills.ContainsKey($Name) -or $PluginSkills.ContainsKey($Name)) {
    $existing = if ($Skills.ContainsKey($Name)) { $Skills[$Name].Path } else { "plugin $($PluginSkills[$Name])" }
    throw "Skill name collision for '$Name': '$existing' conflicts with '$SkillPath'. Rename or exclude one before installing."
  }
  $Skills[$Name] = [PSCustomObject]@{ Name = $Name; Label = $Label; Path = $SkillPath }
}

if (Test-Path $PluginsRoot) {
  Get-ChildItem -Path $PluginsRoot -Directory | Where-Object { Test-Path (Join-Path $_.FullName ".cursor-plugin\plugin.json") } | ForEach-Object {
    $Plugins[$_.Name] = $_.FullName
    $pluginName = $_.Name
    Get-ChildItem -Path (Join-Path $_.FullName "skills") -Directory -ErrorAction SilentlyContinue | Where-Object { Test-Path (Join-Path $_.FullName "SKILL.md") } | ForEach-Object {
      if ($PluginSkills.ContainsKey($_.Name)) {
        throw "Skill name collision for '$($_.Name)': plugins '$($PluginSkills[$_.Name])' and '$pluginName' both ship it."
      }
      $PluginSkills[$_.Name] = $pluginName
    }
  }
}

Get-ChildItem -Path $SkillsRoot -Directory | Where-Object { $_.Name -notin @("_", "deprecated") } | ForEach-Object {
  $bucket = $_.Name
  if ($bucket -eq "external") {
    Get-ChildItem -Path $_.FullName -Directory | Where-Object { $_.Name -ne "_" } | ForEach-Object {
      $author = $_.Name
      Get-ChildItem -Path $_.FullName -Directory | Where-Object { $_.Name -ne "_" } | ForEach-Object {
        if (Test-Path (Join-Path $_.FullName "SKILL.md")) {
          Register-Skill -Name $_.Name -Label "external/$author" -SkillPath $_.FullName
        }
      }
    }
  } else {
    Get-ChildItem -Path $_.FullName -Directory | Where-Object { $_.Name -ne "_" } | ForEach-Object {
      if (Test-Path (Join-Path $_.FullName "SKILL.md")) {
        Register-Skill -Name $_.Name -Label $bucket -SkillPath $_.FullName
      }
    }
  }
}

$SelectedPlugins = @()
$SelectedSkills = @()
if (-not $Names -or $Names.Count -eq 0) {
  $SelectedPlugins = $Plugins.Keys | Sort-Object
  $SelectedSkills = $Skills.Values | Sort-Object Name
} else {
  foreach ($requested in $Names) {
    $key = ($requested -split "[/\\]")[-1]
    if ($Plugins.ContainsKey($key)) {
      $SelectedPlugins += $key
    } elseif ($Skills.ContainsKey($key)) {
      $SelectedSkills += $Skills[$key]
    } elseif ($PluginSkills.ContainsKey($key)) {
      throw "'$key' ships inside plugin '$($PluginSkills[$key])'. Install the plugin instead: .\scripts\install.ps1 $($PluginSkills[$key])"
    } else {
      $available = (@($Plugins.Keys) + @($Skills.Keys) | Sort-Object) -join ", "
      throw "No plugin or skill named '$requested'. Available: $available"
    }
  }
}

$SkillDestinations = @{
  claude = if ($env:CLAUDE_SKILLS_DIR) { $env:CLAUDE_SKILLS_DIR } else { Join-Path $HOME ".claude\skills" }
  cursor = if ($env:CURSOR_SKILLS_DIR) { $env:CURSOR_SKILLS_DIR } else { Join-Path $HOME ".cursor\skills" }
}
$CursorPluginsDir = if ($env:CURSOR_PLUGINS_DIR) { $env:CURSOR_PLUGINS_DIR } else { Join-Path $HOME ".cursor\plugins\local" }
$Exclude = @("node_modules", ".venv", "__pycache__", "_", "output")

function Copy-Tree {
  param([string]$Source, [string]$Destination, [switch]$Mirror)
  New-Item -ItemType Directory -Path $Destination -Force | Out-Null
  $mode = if ($Mirror) { "/MIR" } else { "/E" }
  & robocopy $Source $Destination $mode /NFL /NDL /NJH /NJS /NP /XD @Exclude | Out-Null
  if ($LASTEXITCODE -ge 8) { throw "Failed to copy '$Source' to '$Destination' (robocopy exit code $LASTEXITCODE)" }
}

foreach ($agent in $Agents) {
  if ($agent -eq "cursor") {
    foreach ($plugin in $SelectedPlugins) {
      $dest = Join-Path $CursorPluginsDir $plugin
      Copy-Tree -Source $Plugins[$plugin] -Destination $dest -Mirror
      Write-Output "installed plugin $plugin -> $dest"
    }
  } elseif ($SelectedPlugins.Count -gt 0) {
    Write-Output "claude: install plugins from the marketplace: /plugin marketplace add amadorgabriel/amado-skills, then /plugin install <plugin>@amadorgabriel ($($SelectedPlugins -join ', '))"
  }

  $destRoot = $SkillDestinations[$agent]
  foreach ($skill in $SelectedSkills) {
    $dest = Join-Path $destRoot $skill.Name
    Copy-Tree -Source $skill.Path -Destination $dest
    Write-Output "installed $($skill.Name) ($($skill.Label)) -> $dest"
  }

  foreach ($name in $PluginSkills.Keys | Sort-Object) {
    $stale = Join-Path $destRoot $name
    if (Test-Path (Join-Path $stale "SKILL.md")) {
      Write-Warning "$stale is an old loose copy of a skill now shipped by plugin '$($PluginSkills[$name])'. Delete it to avoid duplicates."
    }
  }
}

if ($SelectedPlugins.Count -gt 0 -and $Agents -contains "cursor") {
  Write-Output "cursor: reload the window (Developer: Reload Window) to load local plugins"
}
Write-Output "done: $($SelectedPlugins.Count) plugin(s), $($SelectedSkills.Count) skill(s) for $($Agents -join ', ')"
$global:LASTEXITCODE = 0
exit 0
