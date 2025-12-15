$Computername = Read-Host "Enter the computer name (or press Enter for local computer)"
if ([string]::IsNullOrWhiteSpace($Computername)) {
    $Computername = $env:COMPUTERNAME
}

$StoppedService = Get-Service -ComputerName $Computername |
    Where-Object { $_.Status -eq 'Stopped' 
} 

Write-Output "Services arrêtés sur l'ordinateur $Computername :"
$StoppedService | Select-Object Name, DisplayName, Status

if ($StoppedService.Count -eq 0) {
    Write-Output "Aucun service arrêté trouvé sur l'ordinateur $Computername."
}