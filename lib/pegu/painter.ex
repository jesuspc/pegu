defmodule Pegu.Painter do
  alias Pegu.Board, as: Board

  def draw_solution({board, solutions}, sol_num \\ 0, output_method \\ &IO.puts/1) do
    solution = List.to_tuple(solutions) |> elem(sol_num)
    
    output_method.("---- This is a solution ----")
    draw board, output_method
    iterative_drawing(board, solution)
    output_method.("----------------------------")
  end

  def draw(board, output_method \\ &IO.puts/1) do
    board = Board.to_list board
    out = (border(board) ++ lines(board)) |> Enum.map fn(elm) -> "#{elm}\n" end
    out = out ++ border(board)

    output_method.(out)
  end

  defp iterative_drawing(_, _, _ \\ &IO.puts/1)
  defp iterative_drawing(_, [], _) do; end
  defp iterative_drawing(board, [step|rest], output_method) do
    board = Board.move(board, step)
    draw board, output_method
    iterative_drawing board, rest
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
    line(length(board) + 1)
  end
end