defmodule ElMedusa.Medusa.Filters do
  @moduledoc """
  Filters for response data
  """

  @doc """
  {url, title}

  """
  def name_and_link(data) do
    data
    |> Map.get("collection")
    |> Enum.map(fn(x) -> {x, get_in(data, ["documents", x, "title"])} end)
  end

  @doc """
  Title and body for a single posting

  """
  def title_and_body(data) do
    data
    |> Map.get("root")
    |> Map.take(["title", "content"])
  end
end
