defmodule InfiniteElvesTest do
  import InfiniteElves
  use ExUnit.Case

  samples = [
    {1,10},
    {2,30},
    {3,40},
    {4,70},
    {5,60},
    {6,120},
    {7,80},
    {8,150},
    {9,130}
  ]

  for {house, gifts} <- samples do
    @house house
    @gifts gifts
    test "House #{@house} should have #{@gifts} gifts" do
      assert gifts_for_house(@house) == @gifts
    end
  end

end
