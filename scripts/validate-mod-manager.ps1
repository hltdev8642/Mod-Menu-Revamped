<#
Smoke checks for the custom mod manager override.

This does NOT run Teardown. It verifies:
- The override file exists
- Include paths match vanilla’s current layout (script/common.lua + ui/ui_*.lua)
- The ref directory is not being modified by this script

Usage:
  pwsh -File scripts/validate-mod-manager.ps1
#>

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$modManager = Join-Path $repoRoot 'components/mod_manager.lua'

if (-not (Test-Path $modManager)) {
  throw "Missing file: $modManager"
}

$content = Get-Content -LiteralPath $modManager -Raw

$requiredIncludes = @(
  '#include "script/common.lua"',
  '#include "ui/ui_extensions.lua"',
  '#include "ui/ui_helpers.lua"',
  '#include "buttons.lua"',
  '#include "game.lua"'
)

foreach ($inc in $requiredIncludes) {
  if ($content -notmatch [regex]::Escape($inc)) {
    throw "Missing required include: $inc"
  }
}

if ($content -notmatch 'ModManager\.Sort\s*=') { throw 'Missing ModManager.Sort definition' }
if ($content -notmatch 'ModManager\.Filter\s*=') { throw 'Missing ModManager.Filter definition' }
if ($content -notmatch 'ModManager\.PlayMode\s*=') { throw 'Missing ModManager.PlayMode definition' }
if ($content -notmatch 'mods\.modmanager\.selectedmod') { throw 'Missing mods.modmanager.selectedmod usage' }

Write-Host 'OK: mod_manager.lua basic structure looks good.'
Write-Host 'Next: run the manual in-game test plan in MOD_MANAGER_UPDATE.md.'
