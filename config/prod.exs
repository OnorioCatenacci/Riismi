use Mix.Config

config :riismi, Riismi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "riismi",
  username: "postgres",
  password: "postgres"

config :riismi, datafile_path: System.get_env("RMI_DATA_PATH")
config :riismi,  processedfile_path: System.get_env("RMI_PROCESSEDFILE_PATH")
config :riismi, to_address: "ocatenacci@riis.com"
config :riismi, from_address: "ocatenacci@riis.com"


