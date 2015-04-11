defmodule Pegu.Genius do
  alias Pegu.Board, as: Board

  def solve(board) do
    { board, explore(board, valid_movements(board)) }
  end

  def tokens(board) do
    board |> Board.to_list |> List.flatten |> Enum.filter(&(&1 == 1)) |> length
  end

  defp explore(_, _, path \\ [])
  defp explore(board, [], path) do; [] end
  defp explore(board, [movement | rest], path) do
    explore_movement(board, movement, path ++ [movement]) ++ explore(board, rest, path)
  end

  defp explore_movement(board, movement, path) do
    board = Board.move board, movement
    
    cond do
      tokens(board) == 1 -> [path]
      true -> explore board, valid_movements(board), path
    end
  end

  defp combine(_, []) do; [] end
  defp combine([], _) do; [] end
  defp combine([elm|rest], list) do
    combine(elm, list) ++ combine(rest, list)
  end
  defp combine(x, [elm|rest]) do
    [[x, elm]] ++ combine(x, rest)
  end

  defp movements([x, y]) do
    [
      [[x, y], [x + 2, y]], 
      [[x, y], [x - 2, y]], 
      [[x, y], [x, y + 2]], 
      [[x, y], [x, y - 2]]
    ]
  end

  defp valid_movements(board) do
    all_positions = combine Enum.to_list(1..Board.height(board)), Enum.to_list(1..Board.width(board))

    Enum.map(all_positions, &(valid_movements_from board, &1)) |> 
    Enum.reduce([], &(&2 ++ &1))
  end

  defp valid_movements_from(board, pos) do
    movements(pos) |> Enum.filter &(Board.valid_move?(board, &1))
  end
end
