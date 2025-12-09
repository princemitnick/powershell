$svc = Get-Service -Name "wuauserv" -ErrorAction SilentlyContinue 
if (-not $svc) {
    Write-Host "Service 'wuauserv' not found."
}
elseif ($svc.Status -eq "Stopped") {
    Write-Host "Service 'wuauserv' is already stopped." -ForegroundColor Cyan
}
else {
    Stop-Service -InputObject $svc -PassThru -Verbose
    Write-Host "Service 'wuauserv' has been stopped." -ForegroundColor Green
}