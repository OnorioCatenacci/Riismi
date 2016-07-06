# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config


# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :riismi, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:riismi, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#
config :riismi, ecto_repos: [Riismi.Repo]
config :riismi, Riismi.Mailer,
    adapter: Bamboo.SMTPAdapter,
    server: "smtp.gmail.com",
    port: 465,
    username: System.get_env("RMI_MAIL_SERVERUSER"),
    password: System.get_env("RMI_MAIL_SERVERPWD"),
    tls: :if_available, # can be `:always` or `:never` or `:if_available`
    ssl: true, # can be `true`
    retries: 3
    

#Configure the Database
config :riismi, Riismi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("RMI_DATABASE"),
  username: System.get_env("RMI_DBUSER"),
  password: System.get_env("RMI_DBPWD")

config :riismi,  datafile_path: System.get_env("RMI_DATA_PATH")
config :riismi,  processedfile_path: System.get_env("RMI_PROCESSEDFILE_PATH")
config :logger, level: String.to_atom(System.get_env("RMI_LOGGER_LEVEL"))
    

#change this setting to change how often the app is run.  Right now it's set to 24 (that is, once a day)
config :riismi, run_time_in_hours: System.get_env("RMI_INTERVAL_IN_HOURS")
#This is the e-mail address from which the e-mail will come    
config :riismi, to_address: System.get_env("RMI_TO_EMAIL_ADDRESS")
#This is the e-mail address (or addresses) to which the e-mail will get sent
config :riismi, from_address: System.get_env("RMI_FROM_EMAIL_ADDRESS")


# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
import_config "#{Mix.env}.exs"
