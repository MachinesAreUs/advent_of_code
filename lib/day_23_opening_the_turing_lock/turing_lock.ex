defmodule TuringLock do

  def solve do
    Machine.run %Machine{program: challenge_program}
  end

  def challenge_program do
    [
     {:jio, :a, +19},
     {:inc, :a},
     {:tpl, :a},
     {:inc, :a},
     {:tpl, :a},
     {:inc, :a},
     {:tpl, :a},
     {:tpl, :a},
     {:inc, :a},
     {:inc, :a},
     {:tpl, :a},
     {:tpl, :a},
     {:inc, :a},
     {:inc, :a},
     {:tpl, :a},
     {:inc, :a},
     {:inc, :a},
     {:tpl, :a},
     {:jmp, +23},
     {:tpl, :a},
     {:tpl, :a},
     {:inc, :a},
     {:inc, :a},
     {:tpl, :a},
     {:inc, :a},
     {:inc, :a},
     {:tpl, :a},
     {:inc, :a},
     {:tpl, :a},
     {:inc, :a},
     {:tpl, :a},
     {:inc, :a},
     {:tpl, :a},
     {:inc, :a},
     {:inc, :a},
     {:tpl, :a},
     {:inc, :a},
     {:inc, :a},
     {:tpl, :a},
     {:tpl, :a},
     {:inc, :a},
     {:jio, :a, +8},
     {:inc, :b},
     {:jie, :a, +4},
     {:tpl, :a},
     {:inc, :a},
     {:jmp, +2},
     {:hlf, :a},
     {:jmp, -7}
    ]
  end
end
