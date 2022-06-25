defmodule ElixirPrecompiledDeployer.MixProject do
  use Mix.Project

  @app :elixir_precompiled_deployer
  @version "0.1.0"
  @github_url "https://github.com/cocoa-xu/precompiled_deployer"

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: @github_url,
      description: description(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.28", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test, runtime: false},
    ]
  end

  defp description() do
    "Deploy precompiled binaries using Elixir scripts."
  end

  defp package() do
    [
      name: to_string(@app),
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @github_url}
    ]
  end
end
