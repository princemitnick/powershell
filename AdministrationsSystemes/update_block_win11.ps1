$ErrorActionPreference = 'SilentlyContinue'
$KBsToHide = @("KB5066128","KB5066835","KB5068331")
$LogPath = "$env:ProgramData\UPD_blocked_Log.txt"

try {
    foreach ($KB in $KBsToHide) {
        Start-Process "wusa.exe" "/uninstall /kb:$($KB.TrimStart('KB')) /quiet /norestart" -WindowStyle Hidden
    }

    $UpdateSession = New-Object -ComObject Microsoft.Update.Session
    $Searcher = $UpdateSession.CreateUpdateSearcher()
    $SearchResult = $Searcher.Search("IsInstalled=0")

    foreach ($Update in $SearchResult.Updates) {
        foreach ($KB in $KBsToHide) {
            if ($Update.Title -match $KB) {
                $Update.IsHidden = $true
            }
        }
    }

    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Hide" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Hide" -Name "BlockedKBs" -Value ($KBsToHide -join ",") -Force

    Add-Content -Path $LogPath -Value ("{0} - KBs bloquées : {1}" -f (Get-Date), ($KBsToHide -join ', '))
}
catch {
    Add-Content -Path $LogPath -Value ("{0} - Erreur : {1}" -f (Get-Date), $_.Exception.Message)
}