Import-Module GroupPolicy

gpresult /r 

#GPResult en HTML
$gpresultPath = "C:\Temp\gpresult.html"
gpresult /h $gpresultPath

Start-Process $gpresultPath 

