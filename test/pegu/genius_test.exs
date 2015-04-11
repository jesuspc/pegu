defmodule Pegu.GeniusTest do
  use ExUnit.Case

  test "#tokens returns the number of tokens at the board" do
    board_1 = [
      [1,0],
      [0,0]
    ]

    board_2 = [
      [1,0],
      [0,1]
    ]

    board_3 = [
      [0,1],
      [1,1]
    ]

    assert Pegu.Genius.tokens(board_1) == 1
    assert Pegu.Genius.tokens(board_2) == 2
    assert Pegu.Genius.tokens(board_3) == 3
  end 

  test "#solve returns an empty set for board without solution" do
    board = [
      [1,0,0],
      [0,0,0],
      [0,0,1]
    ]

    solution = Pegu.Genius.solve(board)
    assert solution == {board, []}
  end

  test "#solve returns the set of solutions for a board with one solution" do
    board = [
      [0,1,0],
      [1,0,0],
      [1,0,0],
    ]

    solution = Pegu.Genius.solve(board)
    first_sol_moves = [[[3,1], [1,1]], [[1,1], [1,3]]]
    assert solution == {board, [first_sol_moves]}
  end

  test "#solve returns the set of solutions for a board with multiple solutions" do
    board = [
      [1,1,0],
      [1,0,1],
      [0,1,0]
    ]

    solution = Pegu.Genius.solve(board)

    first_sol_moves  = [[[1,1], [3,1]], [[3,1], [3,3]], [[3,3], [1,3]], [[1,3], [1,1]]]
    second_sol_moves = [[[1,1], [1,3]], [[1,3], [3,3]], [[3,3], [3,1]], [[3,1], [1,1]]]

    {sol_board, moves} = solution

    assert sol_board == board
    assert length(Enum.filter(moves, fn(em) -> em == first_sol_moves end)) == 1
    assert length(Enum.filter(moves, fn(em) -> em == second_sol_moves end)) == 1
  end
end
