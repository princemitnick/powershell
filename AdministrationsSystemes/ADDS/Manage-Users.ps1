Import-MOdule ActiveDirectory

New-ADUser -Name "Alice Martin" -SamAccountName "alice" -UserPrincipalName alice@corp.local `
-AccountPassword (Read-Host -AsSecureString) `
-Enabled $true 


New-ADUser -Name "Bob Pierre" -SamAccountName "bob" -UserPrincipalName bob@corp.local `
-AccountPassword (Read-Host -AsSecureString) -Enabled $true 

New-ADUser -Name "Claire Dupont" -SamAccountName "claire" -UserPrincipalName claire@corp.local `
-AccountPassword (Read-Host -AsSecureString) -Enabled $true 

# Creation de Groupe Global 

New-ADGroup -Name "GG_Finance_Users" -GroupScope Global -GroupCategory Security 

Add-ADGroupMember -Identity "GG_Finance_Users" -Members alice, bob, claire 


New-ADGroup -Name "DL_FS1_Finance_RW" -GroupScope DomainLocal -GroupCategory Security 

Add-ADGroupMember -Identity "DL_FS1_Finance_RW" -Members "GG_Finance_Users"


New-Item -Path "C:\Shares\Finance" -ItemType Directory 

New-SmbShare -Name "Finance" -Path "C:\Shares\Finance" -FullAccess "Administrators"

# Manager gsma

Add-KdsRootKey -EffectiveImmediately

Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))

New-ADServiceAccount piposvc -DNSHostName piposvc.corp.local -PrincipalAllowedToRetrieveManagedPassword "CORP\pipodc01$"

