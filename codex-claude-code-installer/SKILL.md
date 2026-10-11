---
name: codex-claude-code-installer
description: Install or update the latest Claude Code CLI on Windows through the official installer, verify the command, and diagnose incomplete native downloads.
---

# Codex Claude Code Installer

Use this skill when a user asks Codex to install, update, verify, or document Claude Code CLI on Windows.

## Workflow

1. Prefer `scripts/install-claude-code.ps1`. It downloads Anthropic's official installer, which resolves the current release and verifies its checksum.
2. Run the script with `-Update` when the user asks for an update. Updating intentionally repeats the official latest-release installation flow.
3. Verify with `claude --version` and report the version that actually runs.
4. If the command fails with an invalid native executable error, read [references/installation.md](references/installation.md) and use its npm tarball recovery path. Do not claim success until the executable runs.

The skill is Windows-specific. Keep the user's existing Node installation unchanged unless the npm fallback is required; the official native installer does not require Node.js.

## Direct use

From a checked-out copy:

```powershell
& .\codex-claude-code-installer\scripts\install-claude-code.ps1
& .\codex-claude-code-installer\scripts\install-claude-code.ps1 -Update
```

The supporting script is the maintained implementation. Keep troubleshooting details in the reference file instead of duplicating them here.
