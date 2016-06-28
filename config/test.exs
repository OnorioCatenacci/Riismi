use Mix.Config

config :riismi, Riismi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "riismi_test",
  username: "postgres",
  password: "postgres"

config :riismi, datafile_path: "/users/ocatenacci/riismi/test"
config :riismi,  processedfile_path: "/users/ocatenacci/riismi/test/processed"
config :riismi, to_address: "ocatenacci@riis.com"
config :riismi, from_address: "ocatenacci@riis.com"

config :logger, level: :info
