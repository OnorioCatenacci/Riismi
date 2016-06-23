# Powershell script to allow a user to quickly spin up a PSQL console.  
# Onorio Catenacci is the developer responsible for this script. Copyright 2016.  MIT License.

param([string]$environment="test") #default to test environment
Set-Variable psql_cp -option Constant -value 1252

# Grab the current code page
function Get-CurrentCodepage
{
    $a = iex "chcp" | %{-split $_}
    $a[-1]
}

$current_cp = Get-CurrentCodepage
iex "chcp $psql_cp"
Set-Variable repo -option Constant -value "riismi_$environment"
psql --username=postgres --dbname=$repo
iex "chcp $current_cp"
