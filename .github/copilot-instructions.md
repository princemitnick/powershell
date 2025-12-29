# Copilot instructions for this workspace

## Quick summary
- This repository contains Windows PowerShell scripts and notes (no compiled project or tests). Most scripts are one-off admin utilities grouped by purpose (e.g., `AdministrationsSystemes/`, `Course - 1/`, `AZ800/`).
- Primary runtime: **Windows PowerShell (Windows PowerShell 5.1)** (many scripts import `ActiveDirectory` and `ADDSDeployment` modules that require RSAT or a Domain Controller).

## Key files & directories (examples)
- `AdministrationsSystemes/ADDS/ADDS.ps1` — Automates AD DS forest installation and demonstrates `Import-Module ADDSDeployment` and `ActiveDirectory` usage.
- `AdministrationsSystemes/inactive-users.ps1` — AD queries for users (work with `Get-ADUser`).
- `AdministrationsSystemes/*.ps1` — GPO and update related helper scripts (`GPO-policy.ps1`, `GPO - Winupdate.ps1`, `uninstalllenovoupdate.ps1`).
- `Course - 1/` and `AZ800/` — example/learning scripts and demos (e.g., `Stop-Service.ps1`, `Module1.ps1`).
- `instructions.txt` — collection of PowerShell commands used as examples and quick references.

## Environment & how to run safely ✅
- Use Windows PowerShell **(not pwsh/PowerShell 7+)** when working with `ActiveDirectory` or `ADDSDeployment` modules unless those modules are available in PowerShell 7 on your machine.
- Run PowerShell **as Administrator** for scripts that touch system features (AD install, GPO, services).
- Recommended ephemeral execution policy for testing:

  ```powershell
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
  ```

- Prefer dry-run patterns for modifying cmdlets where possible: add `-WhatIf` or `-Confirm` when invoking `Set-*`, `Install-*`, `Remove-*` cmdlets.
- When testing, use `Start-Transcript` / `Stop-Transcript` to capture output for review.

## Patterns & conventions to follow (discoverable examples) 🔧
- Scripts are generally simple, procedural `.ps1` files that call Windows/AD cmdlets directly (e.g., `Get-Service | Where-Object Status -eq 'Stopped' | Out-File .\StoppedServices.txt`).
- AD-related scripts rely on `Import-Module ActiveDirectory` and use `Get-ADUser`, `Get-ADDomainController`, etc. Expect domain-scoped DistinguishedName filters like in `ADDS.ps1`.
- CSV usage: scripts export/import CSV for bulk operations (see `Get-Service | Export-Csv demo2.csv` and `Import-Csv demo.csv | Where-Object ...`).

## Safety & review checklist (must-haves before editing a script that changes state) ⚠️
- Confirm that the action requires Domain or elevated privileges; if so, note it at the top of the script.
- Add `-WhatIf` support or a `-Confirm` switch to any operation that can modify system state.
- Add parameterization & default `-WhatIf` behaviour when possible (helpful for safe automated edits).

## Debugging & quick checks
- For AD module availability:
  ```powershell
  Get-Module -ListAvailable ActiveDirectory
  Import-Module ActiveDirectory
  ```
- Check for AD/RSAT presence on a Dev machine or use a Domain Controller for testing.
- Useful transient debug tools: `Set-PSDebug -Trace 1`, `Write-Verbose`, and `Start-Transcript`.

## Concrete examples for Copilot to prefer when editing or adding scripts
- For AD queries, replicate the pattern: `Get-ADUser -Filter 'Name -like "*Jean*"' | Select Name,SamAccountName,Enabled`
- When constructing a destructive task, include:
  - a `-WhatIf` parameter passed to native cmdlets
  - a top comment stating required privileges and risk
  - a sample command showing safe invocation

## PR guidance for AI-generated changes
- Keep changes small and focused; add tests only if you also add a reproducible, local-safe validation script.
- Document required runtime (Windows PowerShell 5.1) and module dependencies in the edited file's header comment.

---
If anything here is unclear or you'd like stronger constraints (e.g., forbidding destructive changes by AI), tell me what to add or tighten and I’ll update the file. ✅