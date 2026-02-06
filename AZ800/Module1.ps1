Add-Computer -DomainName "Corp.SandyNetworking01.com" -Credential (Get-Credential) -Restart -Force

djoin.exe /provision /domaine Corp.SandyNetworking01.com /machine PC-01 /savefile C:\Temp\PC-01.txt

djoin.exe /requestodj /loadfile C:\Temp\PC-01.txt /windowspath %SystemRoot% /localos


# Ajout d'un utilisateur local au groupe des utilisateurs du bureau à distance
net localgroup "Remote Desktop Users" "CORP\PC-01$" /add