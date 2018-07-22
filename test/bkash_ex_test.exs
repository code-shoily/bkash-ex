defmodule BKashExTest do
  use ExUnit.Case
  doctest BKashEx

  test "greets the world" do
    assert BKashEx.hello() == :world
  end
end
