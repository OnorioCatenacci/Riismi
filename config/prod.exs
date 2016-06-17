use Mix.Config

config :riismi, Riismi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "riismi",
  username: "postgres",
  password: "postgres"

config :riismi, datafile_path: System.get_env("RMI_DATA_PATH")

