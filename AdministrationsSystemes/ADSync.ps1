Get-Service ADSync  

Import-Module ADSync
Get-ADSyncScheduler 

#Forcer une synchronisation
Start-ADSyncSyncCycle -PolicyType Delta 

# Voir l'état de la dernière synchronisation
Get-ADSyncConnectorRunStatus
Get-ADSyncRunProfileResult 

Get-ADSyncScheduler | Select LastSyncCycleStartTime, LastSyncCycleEndTime


# Verifier les comptes utilises par ADSync
Get-ADSyncConnector 