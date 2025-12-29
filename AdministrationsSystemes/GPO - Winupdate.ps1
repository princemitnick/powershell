Get-ADComputer -Filter * | Select-Object Name, OperatingSystem



Get-WmiObject Win32_PnPEntity | Where-Object { $_.PNPClass -eq "Display" } | Select-Object Name, DeviceID


Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "Lenovo System Update*" } | ForEach-Object { $_.Uninstall() }
