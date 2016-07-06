$env:RELX_REPLACE_OS_VARS="true"
$env:MIX_ENV="prod"

mix compile
mix release
