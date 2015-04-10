defmodule Pegu.GeneratorTest do
  use ExUnit.Case
  #doctest Pegu.GeneratorTest

  test "board for valid configuration builds a board with the given struct" do
    width   = 5
    height  = 7
    density = 0.5 
    board   = Pegu.Generator.board %{:width => width, :height => height, :density => density}
    a_line   = board |> hd
    a_square = board |> hd |> hd
    
    assert length(board)    == height
    assert length(hd board) == width
    assert is_number(a_square)
  end

  test "#square returns a valid square when density is smaller than one" do
    square = Pegu.Generator.square {0.5}
    assert is_number(square)

    repetitions = 50
    square_1_mean = mean(fn -> Pegu.Generator.square({0.1}) end, repetitions) 
    square_2_mean = mean(fn -> Pegu.Generator.square({0.8}) end, repetitions)

    assert square_2_mean > square_1_mean
  end

  defp mean(operation, repetitions) do
    accumulative_mean(operation, repetitions, 0)/repetitions
  end

  defp accumulative_mean(_, 0, acc) do
    acc
  end
  defp accumulative_mean(operation, repetitions, acc) do
    accumulative_mean operation, repetitions - 1, operation.() + acc
  end
end
