defmodule Machine do

  @do_nothing [{:jump, 0}]
  defstruct rx_a: 0, rx_b: 0, addr: 0, program: @do_nothing

  def run(m = %Machine{addr: addr, program: program}) do
    case addr < 0 or addr >= length(program) do
      true -> m.rx_b
      _    -> run(step(m))
    end
  end

  def step(m = %Machine{}), do: step m, Enum.at(m.program, m.addr)

  def step(m = %Machine{}, {:hlf, rx}) when is_atom(rx), do: rx_set(m, rx, div(rx_val(m, rx), 2)) |> inc_addr

  def step(m = %Machine{}, {:tpl, rx}) when is_atom(rx), do: rx_set(m, rx, rx_val(m, rx) * 3) |> inc_addr

  def step(m = %Machine{}, {:inc, rx}) when is_atom(rx), do: rx_set(m, rx, rx_val(m, rx) + 1) |> inc_addr

  def step(m = %Machine{}, {:jmp, ofst}) when is_integer(ofst), do: %{m | addr: m.addr + ofst}

  def step(m = %Machine{}, {:jie, rx, ofst}) when is_atom(rx) and is_integer(ofst) do
    case rem(rx_val(m, rx), 2) do
       0 -> m |> step {:jmp, ofst}
       _ -> m |> inc_addr
    end
  end

  def step(m = %Machine{}, {:jio, rx, ofst}) when is_atom(rx) and is_integer(ofst) do
    case rx_val(m, rx) do
       1 -> m |> step {:jmp, ofst}
       _ -> m |> inc_addr
    end 
  end

  defp inc_addr(m = %Machine{}), do: %{m | addr: m.addr + 1}

  defp rx_val(m, atom), do: Map.get m, real_prop(atom)

  defp rx_set(m, atom, val), do: Map.put m, real_prop(atom), val
    
  defp real_prop(atom), do: "rx_" <> Atom.to_string(atom) |> String.to_atom  

end
