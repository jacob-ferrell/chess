require_relative 'piece'

class Bishop
  include Piece
  attr_accessor :symbol, :color, :location

  def initialize(location, color)
    @location = location
    @color = color
    @symbol = is_black? ? '♝'.black : '♝'
  end

  def move_set
    [1, 1, -1, -1].permutation(2).to_a.uniq
  end
end
