defmodule Pegu.BoardTest do
  use ExUnit.Case

  test "#move when the movement is valid returns a board after performing the move" do
    board = [
      [1,0,0],
      [1,0,0],
      [0,1,0]
    ]

    expected_board = [
      [0,0,0],
      [0,0,0],
      [1,1,0]
    ]

    from = [1,1]
    to   = [3,1]
    assert Pegu.Board.move(board, [from, to]) == expected_board
  end

  test "#move when trying to move an unexistant token returns false" do
    board = [
      [1,0,0],
      [1,0,0],
      [0,1,0]
    ]

    from = [3,3]
    to   = [3,1]
    assert Pegu.Board.move(board, [from, to]) == false
  end

  test "#move when trying to move without jumping returns false" do
    board = [
      [1,0,0],
      [1,0,0],
      [0,1,0]
    ]

    from = [1,1]
    to   = [1,3]
    assert Pegu.Board.move(board, [from, to]) == false
  end

  test "#move when trying to move out of the board returns false" do
    board = [
      [0,0,0],
      [1,0,0],
      [1,1,0]
    ]

    from = [2,1]
    to   = [4,1]
    assert Pegu.Board.move(board, [from, to]) == false

    from = [3,2]
    to   = [3,0]
    assert Pegu.Board.move(board, [from, to]) == false
  end

  test "#move when trying to move farther than two squared returns false" do
    board = [
      [0,0,0],
      [1,0,0],
      [0,1,0],
      [1,0,0]
    ]

    from = [4,1]
    to   = [1,1]
    assert Pegu.Board.move(board, [from, to]) == false
  end

  test "#move when trying to move onto another token returns false" do
    board = [
      [1,1,1],
      [0,0,0],
      [0,1,0]
    ]

    from = [1,1]
    to   = [1,3]
    assert Pegu.Board.move(board, [from, to]) == false
  end
end
