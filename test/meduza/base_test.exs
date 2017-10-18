defmodule ElMedusa.Medusa.BaseTest do
  use ExUnit.Case
  doctest ElMeduza

  test "fetch_data" do
    {:ok, result} = ElMeduza.Meduza.Base.fetch_data("index")
    assert is_map(result)
  end
end
