# Powershell script to allow a user to run dialyzer easily.  If you run dialyzer from a powershell prompt you'll get a complaint 
# about the HOME environment variable not being set.  This script sets HOME to the most appropriate value.

# This also makes it easier to pass other variations on the standard dialyzer command in e. g. mix dialyzer.plt

# Onorio Catenacci is the developer responsible for this script. Copyright 2016.  MIT License.

param([string]$cmd="dialyzer") #default to dialyzer command

$env:HOME = $env:APPDATA
mix $cmd
Remove-Item Env:\HOME
