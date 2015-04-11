require IEx
defmodule Pegu.Board do
  @tag timeout: 1000000000
  def tokens(board) do
    board |> to_list |> List.flatten |> Enum.filter(&(&1 == 1)) |> length
  end

  def move(board, [from, to]) do
    if valid_move(board, [from, to]) do
      toggle(board, from) |> toggle(to) |> toggle(jumped_pos [from, to])
    else
      false
    end
  end

  def position(board, [i, j]) do
    board |> to_tuple |> elem(i - 1) |> elem(j - 1)
  end

  def to_tuple(board) when is_tuple(board) do; board end
  def to_tuple(board) do
    board |> Enum.map(&(List.to_tuple &1)) |> List.to_tuple
  end

  def to_list(board) when is_list(board) do; board end
  def to_list(board)  do
    board |> Tuple.to_list |> Enum.map(&(Tuple.to_list &1))
  end

  defp jumped_pos([from, to]) do
    calc_jump = fn(a, b) ->
      cond do 
        a > b -> a - 1
        a < b -> a + 1
      end
    end

    case [from, to] do
      [[x1, y1], [x1, y2]] -> [x1, calc_jump.(y1, y2)]
      [[x1, y1], [x2, y1]] -> [calc_jump.(x1, x2), y1]
    end
  end

  defp jumps?(board, [from, to]) do
    position(board, jumped_pos([from, to])) == 1
  end

  defp toggle(board, [i, j]) do
    board         = to_tuple board
    toggled_token = position(board, [i, j]) == 1 && 0 || 1
    new_line      = elem(board, i - 1) |> replace j, toggled_token

    board |> replace(i, new_line) |> to_list
  end

  defp replace(grid, pos, content) do
    grid |> Tuple.delete_at(pos - 1) |> Tuple.insert_at(pos - 1, content)
  end

  defp valid_move(board, [from, to]) do
    [mov1, mov2, max_directional_length] = case [from, to] do
      [[x1, y1], [x1, y2]] -> [y1, y2, length(hd board)]
      [[x1, y1], [x2, y1]] -> [x1, x2, length(board)]
    end
    
    (abs(mov1 - mov2) == 2) && (mov2 > 0) && (mov2 <= max_directional_length) && 
    position(board, from) == 1 && jumps?(board, [from, to])
  end
end
