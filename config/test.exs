use Mix.Config

config :riismi, Riismi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "riismi_test",
  username: "postgres",
  password: "postgres"

config :riismi, datafile_path: "/users/ocatenacci/riismi/test"
config :logger, level: :info
