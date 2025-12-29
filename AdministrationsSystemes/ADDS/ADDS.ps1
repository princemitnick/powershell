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


