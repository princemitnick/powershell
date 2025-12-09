Get-ADComputer -Filter * | Select-Object Name, OperatingSystem



Get-WmiObject Win32_PnPEntity | Where-Object { $_.PNPClass -eq "Display" } | Select-Object Name, DeviceID


