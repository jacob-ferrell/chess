require_relative 'piece'

class King
  include Piece
  attr_accessor :symbol, :color, :location, :has_moved

  def initialize(location, color)
    @location = location
    @color = color
    @symbol = is_black? ? '♚'.black : '♚'
    @has_moved = false
  end

  def move_set
    [1, 1, -1, -1].permutation(2).to_a.uniq + [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end
