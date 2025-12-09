Get-Service | Where-Object { $_.Status -eq 'Stopped' }

Get-Service | Where-Object Status -EQ 'Stopped' | Select-Object DisplayName, Status


$data = Get-Service | Where-Object Status -EQ 'Stopped' | Select-Object DisplayName, Status
$data | Format-Table -AutoSize

$data | Export-Csv -Path "StoppedServices.csv" -NoTypeInformation

$data | Out-File -FilePath "StoppedServices.txt"

Get-Service | Where-Object Name -EQ 'wuauserv' 


#Arreter un service
Get-Service -Name "wuauserv" | Where-Object Status -eq "Running" | Stop-Service

#"Redemarrer un service"

Get-Service -Name "wuauserv" | Where-Object Status -eq "Running" | Restart-Service


Get-Content -Path "StoppedServices.txt"

$ImportedData = Import-Csv -Path "StoppedServices.csv"
$ImportedData | Format-Table -AutoSize