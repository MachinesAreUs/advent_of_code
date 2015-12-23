defmodule Machine do

  @do_nothing [{:jump, 0}]
  defstruct rx_a: 0, rx_b: 0, addr: 0, program: @do_nothing

  def run(m=%Machine{addr: addr, program: program}) do
    case addr < 0 or addr >= length(program) do
      true -> m.rx_b
      _    -> run(step(m))
    end
  end

  def step(m = %Machine{}), do: step m, Enum.at(m.program, m.addr)

  def step(m = %Machine{}, {:hlf, :a}), do: %{m | rx_a: div(m.rx_a, 2)} |> inc_addr
  def step(m = %Machine{}, {:hlf, :b}), do: %{m | rx_b: div(m.rx_b, 2)} |> inc_addr

  def step(m = %Machine{}, {:tpl, :a}), do: %{m | rx_a: m.rx_a * 3} |> inc_addr
  def step(m = %Machine{}, {:tpl, :b}), do: %{m | rx_b: m.rx_b * 3} |> inc_addr

  def step(m = %Machine{}, {:inc, :a}), do: %{m | rx_a: m.rx_a + 1} |> inc_addr
  def step(m = %Machine{}, {:inc, :b}), do: %{m | rx_b: m.rx_b + 1} |> inc_addr

  def step(m = %Machine{}, {:jmp, ofst}) when is_integer(ofst), do: %{m | addr: m.addr + ofst}

  def step(m = %Machine{}, {:jie, rx, ofst}) when is_atom(rx) and is_integer(ofst) do
    case rem(rx_value(m, rx), 2) do
       0 -> step(m, {:jmp, ofst})
       _ -> m |> inc_addr
    end
  end

  def step(m = %Machine{}, {:jio, rx, ofst}) when is_atom(rx) and is_integer(ofst) do
    case rx_value(m, rx) do
       1 -> step(m, {:jmp, ofst})
       _ -> m |> inc_addr
    end 
  end

  defp inc_addr(m = %Machine{}), do: %{m | addr: m.addr + 1}

  defp rx_value(m, atom) do
    real_prop = "rx_" <> Atom.to_string(atom) |> String.to_atom  
    Map.get m, real_prop
  end

end
