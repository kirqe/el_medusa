defmodule ElMedusa.Mixfile do
  use Mix.Project

  def project do
    [
      app: :el_medusa,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      package: package(),
      deps: deps(),

      # Docs
      name: "ElMedusa",
      description: "Fetching json api data from some of the available endpoints of medusa.io",
      source_url: "https://github.com/kirqe/el_medusa",
      docs: [main: "el_medusa", # The main page in the docs
          extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false}
    ]
  end

  defp package do
   [ maintainers: ["Kirill Beletskiy"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/kirqe/el_medusa"} ]
  end
end
