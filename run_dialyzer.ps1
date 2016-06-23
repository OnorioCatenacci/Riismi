param([string]$cmd="dialyzer") #default to dialyzer command

$env:HOME = $env:APPDATA
mix $cmd
Remove-Item Env:\HOME
