defmodule Pegu.Genious do
  def solve(board) do
    board = to_tuple board
    # Pending
  end

  defp position(board, i, j) do
    board |> elem(i) |> elem(j)
  end

  defp to_tuple(board) do
    board |> Enum.map(fn(elm) -> List.to_tuple(elm) end) |> List.to_tuple
  end
end