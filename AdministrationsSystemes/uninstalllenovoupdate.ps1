$services = @(
    "ImControllerService",
    "Lenovo Vantage Service",
    "LSUService"
)

foreach ($s in $services) {
    if (Get-Service -Name $s -ErrorAction SilentlyContinue) {
        Stop-Service $s -Force -ErrorAction SilentlyContinue
        Set-Service $s -StartupType Disabled
        Write-Host "$s désactivé."
    } else {
        Write-Host "$s non trouvé."
    }
}


Get-Package -Name "Lenovo System Update" | Uninstall-Package -Force