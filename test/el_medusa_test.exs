defmodule ElMedusaTest do
  use ExUnit.Case
  doctest ElMedusa

  test "greets the world" do
    assert ElMedusa.hello() == :world
  end
end
