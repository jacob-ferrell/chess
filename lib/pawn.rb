require_relative 'piece'

class Pawn
  include Piece
  attr_accessor :symbol, :color, :location

  def initialize(location, color)
    @location = location
    @color = color
    @symbol = is_black? ? '♟'.black : '♟'
  end

  def move_set(board)
    moves = []
    if is_black?
      moves += [[1, 0]]
      moves += [[2, 0]] if row == 1
      moves += [[1, -1]] if can_attack?(-1, board)
      moves += [[1, 1]] if can_attack?(1, board)
    else
      moves += [[-1, 0]]
      moves += [[-2, 0]] if row == 6
      moves += [[-1, -1]] if can_attack?(-1, board)
      moves += [[-1, 1]] if can_attack?(1, board)
    end
    moves
  end

  def can_attack?(direction, board)
    if is_black?
      space = board.grid[row + 1][col + direction]
      space && space.color != 'black'
    else
      space = board.grid[row - 1][col + direction]
      space && space.color != 'white'
    end
  end

  def row
    @location.first
  end

  def col
    @location.last
  end
end
