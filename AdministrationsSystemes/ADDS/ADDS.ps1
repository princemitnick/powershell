Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName "Corp.SandyNetworking01.com" `
-DomainNetbiosName "CORP" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true


Import-Module ActiveDirectory
Get-Module ActiveDirectory

Get-ADDomainController 
Get-ADDomainController -Discover
Get-ADDomainController -Discover -Service "GlobalCatalog"

Get-ADUser -Filter * -SearchBase "OU=Utilisateurs,DC=Corp,DC=SandyNetworking01,DC=com" | Select-Object Name, SamAccountName, Enabled
Get-ADUser -Filter 'Name -like "*Jean*"' | Select-Object Name, SamAccountName, Enabled
Get-ADUser -Filter {Enabled -eq $true} | Select-Object Name, SamAccountName

Get-ADUser -Identity "mpoulin"
Get-ADUser -Identity "mpoulin" -Properties * | Select-Object Name, SamAccountName, Enabled, Title, Department, EmailAddress

Get-ADOrganizationalUnit -Filter * | Select Name, DistinguishedName
Get-ADOrganizationalUnit -Filter 'Name -like "*Utilisateurs*"' | Select Name, DistinguishedName


#FSMO Roles
Get-ADForest | Select-Object SchemaMaster, DomainNamingMaster
Get-ADDomain | Select-Object PDCEmulator, RIDMaster, InfrastructureMaster

netdom query fsmo

# Active la console Active Directory Schema 
# Warning: Cette console n'est pas enregistrée par défaut.
# Une erreur peut casser Active Directory, Empecher des services de fonctionner. Il est irréversible.
regsvr32.exe schmmgmt.dll
mmc.exe schmmgmt.msc

Move-ADDirectoryOperationMasterRole -Identity DC01 -OperationMasterRole PDCEmulator,RIDMaster,InfrastructureMaster -Confirm:$false
Move-ADDirectoryOperationMasterRole -Identity DC01 -OperationMasterRole SchemaMaster,DomainNamingMaster -Confirm:$false

Restart-Computer -Force


Invoke-Command -ScriptBlock { Add-LocalGroupMember 'Remote Desktop Users' -Member Developer,NonDeveloper} -ComputerName BRAWKS1


Add-Computer -DomainName "Corp.SandyNetworking01.com" -Credential (Get-Credential) -Restart -Force

djoin.exe /provision /domaine Corp.SandyNetworking01.com /machine PC-01 /savefile C:\Temp\PC-01.txt

djoin.exe /requestodj /loadfile C:\Temp\PC-01.txt /windowspath %SystemRoot% /localos


# Ajout d'un utilisateur local au groupe des utilisateurs du bureau à distance
net localgroup "Remote Desktop Users" "CORP\PC-01$" /add

#How to enable Active Directory Recycle Bin

Import-Module ActiveDirectory
Enable-ADOptionalFeature -Identity 'Recycle Bin Feature' -Scope ForestOrConfigurationSet -Target 'Corp.SandyNetworking01.com'

