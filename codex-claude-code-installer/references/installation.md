# Installation Reference

## Preferred path

The skill downloads `https://claude.ai/install.ps1` and runs it with `-Target latest`. That official script resolves the current Claude Code release, downloads the Windows binary, verifies the published SHA256 checksum, and installs the launcher. Running the skill again is the update operation.

The preferred commands are:

```powershell
& .\scripts\install-claude-code.ps1
& .\scripts\install-claude-code.ps1 -Update
claude --version
```

## Reproducible checks

Record these values when documenting an installation:

```powershell
$PSVersionTable.PSVersion
Get-ComputerInfo -Property WindowsProductName, WindowsVersion, OsArchitecture
claude --version
```

Do not report success from a package-list result alone. The installed executable must run and return a version.

## npm fallback diagnosis

The npm package is an alternative installation route:

```powershell
node --version
npm --version
npm install -g @anthropic-ai/claude-code --registry=https://registry.npmjs.org
claude --version
```

Current Claude Code npm releases require Node.js 22 or newer. If npm reports cache rename errors, use an isolated cache:

```powershell
$cacheDir = Join-Path $env:TEMP 'claude-code-npm-cache'
New-Item -ItemType Directory -Force -Path $cacheDir | Out-Null
npm install -g @anthropic-ai/claude-code --registry=https://registry.npmjs.org --cache $cacheDir
```

If `claude --version` reports that the executable is not valid for Windows, inspect the native package before claiming success. The Windows package is `@anthropic-ai/claude-code-win32-x64`; download its exact tarball from npm, extract `package\claude.exe`, replace the incomplete `node_modules\@anthropic-ai\claude-code\bin\claude.exe`, and rerun the version check.

The fallback is intentionally not automated by the main script because it depends on the installed npm prefix and platform architecture.
