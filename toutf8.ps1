# Quick and Dirty utility file to convert all CP-1252 files to UTF8 via Powershell

Get-ChildItem -File | Foreach {gc -encoding $_.fullname | Out-File -encoding UTF8 $_.fullname.utf8}
Get-ChildItem -File | Foreach {mv $_.fullname $_.fullname.cp1252}
Get-ChildItem -File | Foreach {mv $_.fullname.utf8 $_.fullname}
