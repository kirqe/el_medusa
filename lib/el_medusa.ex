defmodule ElMedusa do
  alias ElMedusa.Medusa.{Base, Filters}
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
feature
  arguments:

  1. news, articles, shapito, razbor, games
  2. page (default 0)
  3. per_page (default 24 can't be updated)
  4. locale en, ru

  ## Examples

  ```elixir
  iex> ElMedusa.search('news', 2, 'ru')
  iex> ElMedusa.search('news')
  iex> ElMedusa.search('news', 2, 'en')
  iex> ElMedusa.search('news', 'en')
  ```

  """
  def search(post_type, page \\ 0, locale \\ 'ru') do
    "search?chrono=#{post_type}&page=#{page}&per_page=24&locale=#{locale}"
    |> Base.fetch_data
  end



  def collection do

  end


  def collection_item(url) do
    Base.fetch_data(url)
  end


  def specials do
    # https://meduza.io/api/v3/specials/under-the-sun
  end


  @doc """
  Returns a number of likes for vk, tw, ok, fb

  As well as a number of comments(reactions)

  Accespts a list of paths one or many


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
