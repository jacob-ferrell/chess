require_relative 'piece'

class Queen
  include Piece
  attr_accessor :symbol, :color, :location

  def initialize(location, color)
    @location = location
    @color = color
    @symbol = is_black? ? '♛'.black : '♛'
  end

  def move_set
    [1, 1, -1, -1].permutation(2).to_a.uniq + [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end
