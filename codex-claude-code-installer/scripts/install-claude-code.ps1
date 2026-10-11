param(
    [switch]$Update,
    [ValidateSet('latest', 'stable')]
    [string]$Target = 'latest'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

if ($env:OS -ne 'Windows_NT') {
    throw 'This skill supports Windows only.'
}

$installerUri = 'https://claude.ai/install.ps1'
$workDir = Join-Path ([IO.Path]::GetTempPath()) ('codex-claude-install-' + [guid]::NewGuid().ToString('N'))
$installerPath = Join-Path $workDir 'install.ps1'

New-Item -ItemType Directory -Force -Path $workDir | Out-Null

try {
    Write-Host "Downloading Anthropic's official Claude Code installer..."
    Invoke-WebRequest -Uri $installerUri -OutFile $installerPath -UseBasicParsing

    $powershell = (Get-Command powershell.exe -ErrorAction Stop).Source
    $mode = if ($Update) { 'update' } else { 'install' }
    Write-Host "Starting Claude Code $mode for the $Target release channel..."
    & $powershell -NoProfile -ExecutionPolicy Bypass -File $installerPath -Target $Target
    if ($LASTEXITCODE -ne 0) {
        throw "The official installer failed with exit code $LASTEXITCODE."
    }
}
finally {
    Remove-Item -LiteralPath $workDir -Recurse -Force -ErrorAction SilentlyContinue
}

# Installers may update PATH after this process starts; refresh it before verification.
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$machinePath = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$env:Path = "$userPath;$machinePath"

$claude = Get-Command claude -ErrorAction SilentlyContinue
if (-not $claude) {
    throw 'Installation completed without a claude command in PATH. Open a new PowerShell window and run claude --version.'
}

& $claude.Source --version
if ($LASTEXITCODE -ne 0) {
    throw "Claude Code was found at $($claude.Source), but version verification failed."
}

Write-Host 'Claude Code installation/update verified.'
