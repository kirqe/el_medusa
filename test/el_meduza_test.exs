defmodule ElMeduzaTest do
  use ExUnit.Case
  doctest ElMeduza

  test "greets the world" do
    assert ElMeduza.hello() == :world
  end
end
