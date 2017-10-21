defmodule ElMeduzaTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ElMeduza

  test "ElMeduza.index" do
    use_cassette "index" do
      {:ok, _} = ElMeduza.index
    end
  end

  test "informers" do
    use_cassette "informers" do
      {:ok, _} = ElMeduza.informers
    end
  end

  test "stocks" do
    use_cassette "stocks" do
      {:ok, _} = ElMeduza.stocks
    end
  end

  test "search" do
    use_cassette "search" do
      {:ok, _} = ElMeduza.search("news")
    end
  end

  test "single_post" do
    use_cassette "single_post" do
      {:ok, _} = ElMeduza.single_post("feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali")
    end
  end

  test "specials" do
    use_cassette "specials" do
      {:ok, _} = ElMeduza.specials
    end
  end

  test "collection_stats" do
    use_cassette "collection_stats" do
      {:ok, _} = ElMeduza.collection_stats(["feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali"])
    end
  end

end
