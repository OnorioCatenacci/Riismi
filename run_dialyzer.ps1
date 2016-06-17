$env:HOME = $env:APPDATA
mix dialyzer
Remove-Item Env:\HOME
