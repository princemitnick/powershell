reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name NoAutoUpdate -Value 0

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name SetDisableUXWUAccess -Value 0

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name ElevateNonAdmins -Value 1


gpupdate /force 