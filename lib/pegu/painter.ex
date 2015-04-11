defmodule Pegu.Painter do
  alias Pegu.Genius, as: Genius
  
  def draw_solution(board, output_method \\ &IO.puts/1 )
  def draw_solutions({board, movements}, output_method) do
    #[_|rest] = expanded(board)

    output_method.("=== Displaying solutions for: ===\n")
    draw board, output_method
    output_method.("=== The solutions are: ===\n")

    output_method.("======================\n")
  end

  def draw(board, output_method \\ &IO.puts/1) do
    out = (border(board) ++ lines(board)) |> Enum.map fn(elm) -> "#{elm}\n" end
    out = out ++ border(board)

    output_method.(out)
  end

  def draw_multiple(boards, output_method) do
    Enum.each boards, &(draw &1, output_method)
  end

  defp draw_solution(boards, output_method) do
    output_method.("--- Solution ---\n")
    draw_multiple boards, output_method
    output_method.("----------------\n")
  end

  defp lines([last_line|[]]) do
    line(last_line)
  end
  defp lines(board) do
    [l|rest] = board
    line(l) ++ lines(rest)
  end

  defp line(length) when is_number(length) do
    line Enum.map(1..length, fn(_) -> "*" end)
  end
  defp line(line) do
    decorated_line = ["*"] ++ line ++ ["*"]
    [List.foldl(decorated_line, "", fn(elm, acc) -> acc <> " #{elm}" end)]
  end

  defp border(board) do
    line length(board)
  end
end