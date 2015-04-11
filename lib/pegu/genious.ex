defmodule Pegu.Genious do
  alias Pegu.Board, as: Board

  def solve(board, acc \\ []) do
    # Pending
  end
 
  defp path(board, acc \\ []) do
    if Board.tokens(board) == 1 do
      acc
    else
    end
  end
end
