 (Get-CimInstance Win32_OperatingSystem).LastBootUpTime

wevtutil qe System /q:"*[System[(EventID=1074)]]" /f:text /c:1


eventvwr.msc /c:System


EVENTID 1074 - Source: USER32 