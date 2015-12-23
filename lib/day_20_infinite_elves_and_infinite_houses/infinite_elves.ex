defmodule InfiniteElves do

  def lowest_house_number_for(n_gifts) when is_integer(n_gifts) do
    {idx, _} = 
      naturals 
        |> Stream.map(&{&1,gifts_for_house(&1)})
        |> Enum.find(fn {_idx,n} -> n >= n_gifts end) 
    idx
  end

  def gifts_for_house(n) do
    1..n 
      |> Stream.filter(&(rem(n,&1) == 0)) 
      |> Stream.map(&(&1*10)) 
      |> Enum.reduce(&(&1+&2)) 
  end

  defp naturals do
    Stream.unfold(1, fn x -> {x,x+1} end)
  end
end

