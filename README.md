# Codex Claude Code Installer Skill

A reusable Codex Skill for installing, updating, and verifying the latest Claude Code CLI on Windows.

The skill uses Anthropic's official installer, so the same command installs a fresh copy or updates an existing installation. It also documents the npm fallback for incomplete Windows native downloads.

## Use from a checkout

```powershell
& .\codex-claude-code-installer\scripts\install-claude-code.ps1
```

Update to the latest release:

```powershell
& .\codex-claude-code-installer\scripts\install-claude-code.ps1 -Update
```

## One-line install from GitHub

After cloning or downloading this repository, run the script from the checkout. To execute the maintained script directly from the public repository:

```powershell
$script = Join-Path $env:TEMP 'install-claude-code.ps1'
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/tttjhgan/codex-claude-code-installer/main/codex-claude-code-installer/scripts/install-claude-code.ps1' -OutFile $script
& $script
```

For an update, use `& $script -Update`.

## Skill layout

- `codex-claude-code-installer/SKILL.md`: Codex routing and operating instructions
- `codex-claude-code-installer/scripts/install-claude-code.ps1`: install/update implementation
- `codex-claude-code-installer/references/installation.md`: reproducibility and fallback notes

## Verification

```powershell
claude --version
```

The script is not considered successful unless this command returns a Claude Code version.
