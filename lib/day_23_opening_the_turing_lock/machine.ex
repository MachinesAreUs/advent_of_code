defmodule Machine do

  @do_nothing [{:jump, 0}]
  defstruct a: 0, b: 0, addr: 0, program: @do_nothing

  def run(m = %Machine{addr: addr, program: program}) do
    case addr < 0 or addr >= length(program) do
      true -> [a: m.a, b: m.b]
      _    -> m |> step |> run
    end
  end

  def step(m = %Machine{}), do: step m, Enum.at(m.program, m.addr)

  def step(m = %Machine{}, {:hlf, rx})   when is_atom(rx),      do: rx_set(m, rx, div(rx_val(m, rx), 2)) |> inc_addr
  def step(m = %Machine{}, {:tpl, rx})   when is_atom(rx),      do: rx_set(m, rx, rx_val(m, rx) * 3)     |> inc_addr
  def step(m = %Machine{}, {:inc, rx})   when is_atom(rx),      do: rx_set(m, rx, rx_val(m, rx) + 1)     |> inc_addr
  def step(m = %Machine{}, {:jmp, ofst}) when is_integer(ofst), do: %{m | addr: m.addr + ofst}

  def step(m = %Machine{}, {:jie, rx, ofst}) when is_atom(rx) and is_integer(ofst), 
    do: jump_if(is_even?(rx_val(m, rx)), m, ofst)

  def step(m = %Machine{}, {:jio, rx, ofst}) when is_atom(rx) and is_integer(ofst), 
    do: jump_if(rx_val(m, rx) == 1, m, ofst)

  defp jump_if(true, m, ofst), do: m |> step {:jmp, ofst}
  defp jump_if(false, m, _),   do: m |> inc_addr

  defp is_even?(x), do: rem(x, 2) == 0

  defp inc_addr(m = %Machine{}), do: %{m | addr: m.addr + 1}

  defp rx_val(m, atom),      do: Map.get m, atom
  defp rx_set(m, atom, val), do: Map.put m, atom, val
end
