defmodule InfiniteElvesProfile do
  import ExProf.Macro
  import InfiniteElves

  def do_analyze do
    profile do
      InfiniteElves.lowest_house_number_for 500_000
    end
  end

  def run do
    records = do_analyze
    total_percent = Enum.reduce(records, 0.0, &(&1.percent + &2))
    IO.inspect "total = #{total_percent}"
  end
end
