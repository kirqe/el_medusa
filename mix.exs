defmodule ElMeduza.Mixfile do
  use Mix.Project

  def project do
    [
      app: :el_meduza,
      version: "0.1.4",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      package: package(),
      deps: deps(),
      name: "ElMeduza",
      description: "Fetching json api data from some of the available endpoints of meduza.io",
      source_url: "https://github.com/kirqe/el_meduza"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ElMeduza.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:exvcr, "~> 0.8", only: :test}
    ]
  end

  defp package do
   [ maintainers: ["Kirill Beletskiy"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/kirqe/el_meduza"} ]
  end
end
