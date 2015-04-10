defmodule Pegu.Generator do
  def board(%{:width => width, :height => height, :density => density}) do
    line_fn   = { &square/1, { density } }
    column_fn = { &add_elements/1, { line_fn, width, [] } }
    add_elements { column_fn, height, [] }
  end

  def square({density}) when density <= 1 do
    :random.uniform < density && 1 || 0
  end

  defp add_elements({_, constraint, acc}) when length(acc) == constraint do
    acc
  end
  defp add_elements({fun_invocation, constraint, acc}) do
    { fun, args } = fun_invocation
    add_elements {fun_invocation, constraint, acc ++ [fun.(args)]}
  end
end