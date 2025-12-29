$days = (Get-Date).AddDays(-90)

Get-ADUser -Filter {LastLogonDate -lt $days} -Properties LastLogonDate |
Select-Object Name, LastLogonDate 