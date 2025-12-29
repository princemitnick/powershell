# Doit être exécuté en Admin
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
    Write-Host "ERREUR: Lance PowerShell en tant qu'administrateur." -ForegroundColor Red
    exit 1
}

Write-Host "Avant:" -ForegroundColor Cyan
powercfg /list

# Force la création des plans standards (ignore si déjà présents)
powercfg -duplicatescheme SCHEME_MIN  | Out-Null   # Power Saver
powercfg -duplicatescheme SCHEME_MAX  | Out-Null   # High Performance

# Laisser Balanced actif (optionnel)
powercfg -setactive SCHEME_BALANCED  | Out-Null

Write-Host "`nAprès:" -ForegroundColor Cyan
powercfg /list



 powercfg /a 