defmodule ElMedusa.Medusa.BaseTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ElMeduza

  setup_all do
    HTTPoison.start
  end

  test "fetch_data" do
    use_cassette "httpoison_get" do
      {:ok, result} = ElMeduza.Meduza.Base.fetch_data("index")
      assert is_map(result)
    end
  end
end
