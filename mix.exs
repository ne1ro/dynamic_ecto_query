defmodule DynamicEctoQuery.Mixfile do
  use Mix.Project

  def project do
    [
      app: :dynamic_ecto_query,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {DynamicEctoQueryApp, []},
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(_), do: ~w(lib)

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 2.2"},
      {:ex_machina, "~> 2.1"},
      {:faker, "~> 0.9.0"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
