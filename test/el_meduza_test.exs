defmodule ElMeduzaTest do
  use ExUnit.Case
  doctest ElMeduza

  test "index" do
    assert {:ok, %{"root" => _ }} = ElMeduza.index
  end

  test "informers" do
    assert {:ok, %{"informers" => _ }} = ElMeduza.informers
  end

  test "stocks" do
    assert {:ok, %{"brent" => %{"current" => _, "prev" => _,
                "state" => _}, "btc" => _,
              "eur" => %{"current" => _, "prev" => _,
                "state" => "down"}, "intouch" => _,
              "usd" => %{"current" => _, "prev" => _,
                "state" => _}}} = ElMeduza.stocks
  end

  test "search" do
    assert {:ok,
    %{"_count" => 24, "collection" => _, "documents" => _}} =
      ElMeduza.search("news")
  end

  test "single_post" do
    assert {:ok, %{"documents" => _,
      "root" => %{"authors" => _, "content" => %{"body" => _}}}} =
      ElMeduza.single_post("feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali")
  end

  test "specials" do
    assert {:ok,
      %{"root" => [%{"title" => _, "screen_type" => _,"collection" => _}]}} =
    ElMeduza.specials
  end

  test "collection_stats" do
    assert {:ok,
      %{"feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali" => %{"stats" => _, "stats_b" => _}}} =
    ElMeduza.collection_stats(["feature/2017/10/13/zriteli-svoyu-otsenku-vyskazali"])
  end
end
