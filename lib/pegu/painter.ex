require IEx
defmodule Pegu.Picture do
  def draw(board, output_method \\ &IO.puts/1 ) do
    out = (border(board) ++ lines(board)) |> Enum.map fn(elm) -> "#{elm}\n" end
    out = out ++ border(board)

    output_method.(out)
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