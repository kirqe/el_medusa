defmodule ElMedusa do
  alias ElMedusa.Medusa.Base
  @moduledoc """
  Module for fetching different kind of information from medusa.io api
  """

  @doc """
  All available articles and other items of the site

  ## Examples

  ```elixir
  iex> ElMedusa.index
  ```

  """
  def index do
    Base.fetch_data("index")
  end


  @doc """
  Fetch informers.

  ## Examples

  ```elixir
  iex> ElMedusa.informers
  ```

  """
  def informers do
    Base.fetch_data("informer")
  end

  @doc """
  Fetch stocks info for usd, eur, brent, etc:

  ## Examples

  ```elixir
  iex> ElMedusa.stocks
  ```

  """
  def stocks do
    Base.fetch_data("/stock/all")
  end

  @doc """
  Fetch page with posts for one of the following categories:

  arguments:

  1. news, articles, shapito, razbor, games
  2. list of options [page: 0, per_page: 24, locale: "ru"]

  ## Examples

  ```elixir
  iex> ElMedusa.search('news')
  iex> ElMedusa.search('news', page: 2)
  iex> ElMedusa.search('news', page: 2, locale: "en")
  ```

  """
  def search(post_type, params \\ []) do
    [page: 0, per_page: 24, locale: "ru"]
    |> Enum.concat(params)
    |> Map.new
    |> (&("search?chrono=#{post_type}&" <> URI.encode_query(&1))).()
    |> Base.fetch_data
  end


  @doc """
  Fetch single posting by path

  ## Examples

  ```elixir
  iex> ElMedusa.single_post("feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali")
  ```

  """
  def single_post(path) do
    Base.fetch_data(path)
  end


  @doc """
  Featured posts?

  ## Examples

  ```elixir
  iex> ElMedusa.specials
  ```

  """
  def specials do
    Base.fetch_data("specials/under-the-sun")
  end


  @doc """
  Returns a number of likes for vk, tw, ok, fb

  As well as a number of comments(reactions)

  Accepts a list of paths one or many


  ## Examples

  ```elixir
  iex> ElMedusa.collection_stats(["promo/podpiska-na-vecherku"])
  iex> ElMedusa.collection_stats(["feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali", "feature/2017/10/13/uvolen-rukovoditel-tsentra-podgotovki-kosmonavtov-vozmozhnaya-prichina-uhod-izvestnyh-kosmonavtov"])

  ```

  """
  def collection_stats(collections) do
    list =
      collections
      |> Enum.map(fn(x) -> "%22#{x}%22" end)
      |> Enum.join(",")

    "social?links=[" <> list <> "]"
    |> Base.fetch_data
  end

end
