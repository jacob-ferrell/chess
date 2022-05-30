require_relative 'piece.rb'

class Pawn
  include Piece
  attr_accessor :symbol, :color, :location
  def initialize(location, color)
    @location = location
    @color = color
    @symbol = is_black? ? "♟" : "♙"
  end

  def move_set
    if is_black?
      row == 1 ? [[1, 0], [2, 0]] : [[1, 0]]
    else
      row == 6 ? [[-1, 0], [-2, 0]] : [[-1, 0]]
    end

  end

  def row
    return @location.first
  end

  def col
    return @location.last
  end
end

