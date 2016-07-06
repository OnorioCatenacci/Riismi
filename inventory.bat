@echo off
NET TIME /Domain:RIIS /Set /Y
net use h: /delete
net use t: /delete
net use p: /delete
\\riis.local\NETLOGON\logonriis.vbs
cmd /c /u hostname  >> \\riis-fs2\software$\%COMPUTERNAME%.txt
cmd /c /u date /t >> \\riis-fs2\software$\%COMPUTERNAME%.txt
cmd /c /u time /t >> \\riis-fs2\software$\%COMPUTERNAME%.txt
wmic product get name, version /format:list  >> \\riis-fs2\software$\%COMPUTERNAME%.txt
