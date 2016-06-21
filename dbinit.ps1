$env:MIX_ENV = "test"
mix ecto.drop
mix ecto.create
mix ecto.migrate
Remove-Item Env:\MIX_ENV
