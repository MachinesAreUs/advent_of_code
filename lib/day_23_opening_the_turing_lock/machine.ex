defmodule Machine do

  @do_nothing [{:jump, 0}]
  defstruct reg_a: 0, reg_b: 0, addr: 0, program: @do_nothing

  def run(m=%Machine{addr: addr, program: program}) do
    if addr < 0 or addr >= length(program) do
      m.reg_b
    else
      run(step(m))
    end
  end

  def step(m = %Machine{}), do: step m, Enum.at(m.program, m.addr)

  def step(m = %Machine{}, {:hlf, :a}), do: %{m | reg_a: div(m.reg_a, 2)} |> inc_addr
  def step(m = %Machine{}, {:hlf, :b}), do: %{m | reg_b: div(m.reg_b, 2)} |> inc_addr

  def step(m = %Machine{}, {:tpl, :a}), do: %{m | reg_a: m.reg_a * 3} |> inc_addr
  def step(m = %Machine{}, {:tpl, :b}), do: %{m | reg_b: m.reg_b * 3} |> inc_addr

  def step(m = %Machine{}, {:inc, :a}), do: %{m | reg_a: m.reg_a + 1} |> inc_addr
  def step(m = %Machine{}, {:inc, :b}), do: %{m | reg_b: m.reg_b + 1} |> inc_addr

  def step(m = %Machine{}, {:jmp, x}) when is_integer(x), do: %{m | addr: m.addr + x}

  def step(m = %Machine{}, {:jie, :a, offset}) when is_integer(offset) do
    case rem(m.reg_a, 2) do
       0 -> step(m, {:jmp, offset})
       _ -> m |> inc_addr
    end
  end

  def step(m = %Machine{}, {:jie, :b, offset}) when is_integer(offset) do
    case rem(m.reg_b, 2) do
       0 -> step(m, {:jmp, offset})
       _ -> m |> inc_addr
    end
  end

  def step(m = %Machine{}, {:jio, :a, offset}) when is_integer(offset) do
    case m.reg_a do
       1 -> step(m, {:jmp, offset})
       _ -> m |> inc_addr
    end 
  end

  def step(m = %Machine{}, {:jio, :b, offset}) when is_integer(offset) do
    case m.reg_b do
       1 -> step(m, {:jmp, offset})
       _ -> m |> inc_addr
    end 
  end

  def inc_addr(m = %Machine{}), do: %{m | addr: m.addr + 1}

end
