defmodule ElMeduza do
  alias ElMeduza.Meduza.Base
  @moduledoc """
  Module for fetching different kind of information from meduza.io api
  """

  @doc """
  All available articles and other items of the site

  ## Examples

  ```elixir
  iex> ElMeduza.index
  {:ok, %{"root" => _ }} = ElMeduza.index
  ```

  """
  @spec index() :: {:ok, map} | {:error, any}
  def index do
    Base.fetch_data("index")
  end

  @doc """
  Fetch informers.

  ## Examples

  ```elixir
  iex> ElMeduza.informers
  {:ok, %{"informers" => _ }} = ElMeduza.informers
  ```

  """
  @spec informers() :: {:ok, map} | {:error, any}
  def informers do
    Base.fetch_data("informer")
  end

  @doc """
  Fetch stocks info for usd, eur, brent, etc:

  ## Examples

  ```elixir
  iex> ElMeduza.stocks
  {:ok, %{"brent" => %{"current" => _, "prev" => _,
              "state" => _}, "btc" => _,
            "eur" => %{"current" => _, "prev" => _,
              "state" => "down"}, "intouch" => _,
            "usd" => %{"current" => _, "prev" => _,
              "state" => _}}} = ElMeduza.stocks
  ```

  """
  @spec stocks() :: {:ok, map} | {:error, any}
  def stocks do
    Base.fetch_data("/stock/all")
  end

  @doc """
  Fetch page with posts for one of the following categories:

  arguments:

  1. news, articles, shapito, razbor, games
  2. list of options [page: 0, per_page: 24, locale: "en"]

  ## Examples

  ```elixir
  iex> ElMeduza.search("news")
  {:ok,
  %{"_count" => 24, "collection" => _, "documents" => _}} = ElMeduza.search("news")
  ```
  """

  @spec search(String.t, [page: integer, per_page: integer, locale: String.t])
  :: {:ok, map} | {:error, any}
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
  iex> ElMeduza.single_post("feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali")
  {:ok, %{"documents" => _,
    "root" => %{"authors" => _, "content" => %{"body" => _}}}} =
    ElMeduza.single_post("feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali")
  ```

  """
  @spec single_post(String.t) :: {:ok, map} | {:error, any}
  def single_post(path) do
    Base.fetch_data(path)
  end

  @doc """
  Featured posts?

  ## Examples

  ```elixir
  iex> ElMeduza.specials
  {:ok,
    %{"root" => [%{"title" => _, "screen_type" => _,"collection" => _}]}} =
  ElMeduza.specials
  ```

  """
  @spec specials() :: {:ok, map} | {:error, any}
  def specials do
    Base.fetch_data("specials/under-the-sun")
  end

  @doc """
  Returns a number of likes for vk, tw, ok, fb

  As well as a number of comments(reactions)

  Accepts a list of paths one or many

  ## Examples

  ```elixir
  iex> ElMeduza.collection_stats(["feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali"])
  {:ok,
    %{"feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali" => %{"stats" => _, "stats_b" => _}}} =
  ElMeduza.collection_stats(["feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali"])

  ```

  """
  @spec collection_stats([String.t]) :: {:ok, map} | {:error, any}
  def collection_stats(collections) do
    list =
      collections
      |> Enum.map(fn(x) -> "%22#{x}%22" end)
      |> Enum.join(",")

    "social?links=[" <> list <> "]"
    |> Base.fetch_data
  end

end
