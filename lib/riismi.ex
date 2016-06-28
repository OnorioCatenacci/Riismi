defmodule Riismi do
  use Application

  def datafile_path, do: Application.get_env(:riismi, :datafile_path)
  def processedfile_path, do: Application.get_env(:riismi, :processedfile_path)
  def to_address, do: Application.get_env(:riismi, :to_address)
  def from_address, do: Application.get_env(:riismi, :from_address)

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Riismi.Repo, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Riismi.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
