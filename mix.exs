defmodule Riismi.Mixfile do
  use Mix.Project

  def project do
    [app: :riismi,
     version: "0.9.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :postgrex, :bamboo, :ecto, :bamboo_smtp],
     mod: {Riismi, []}]
  end

  defp deps do
    [
      {:ecto, "~> 2.0.0-rc.6"},
      {:postgrex, "~> 0.11"},
      {:bamboo, "~> 0.6.0"},
      {:bamboo_smtp, "~> 1.0"},
      {:gen_smtp, "~>0.11.0", override: true},
      {:exrm, "~> 1.0"}
    ]
  end
end
