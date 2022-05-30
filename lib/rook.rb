require_relative 'piece.rb'

class Rook
  include Piece  
  attr_accessor :symbol, :color, :location
  def initialize(location, color)
    @location = location
    @color = color
    @symbol = is_black? ? "♜" : "♖"
  end

  def move_set
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end


end