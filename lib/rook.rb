require_relative 'piece'

class Rook
  include Piece
  attr_accessor :symbol, :color, :location, :has_moved

  def initialize(location, color)
    @location = location
    @color = color
    @symbol = is_black? ? '♜' : '♖'
    @has_moved = false
  end

  def move_set
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end
