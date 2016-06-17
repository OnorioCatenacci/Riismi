defmodule Riismi.Mixfile do
  use Mix.Project

  def project do
    [app: :riismi,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :postgrex, :fs],
     mod: {Riismi, []}]
  end

  defp deps do
    [
      {:fs, git: "https://github.com/synrc/fs"},
      {:ecto, "~> 2.0.0-rc.5"},
      {:postgrex, "~> 0.11.1"},
      {:earmark, "~> 0.2.1", only: :dev},
      {:ex_doc, "~> 0.11.4", only: :dev}
    ]
  end
end
