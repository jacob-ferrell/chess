require_relative 'piece.rb'

class Knight
  include Piece
  attr_accessor :symbol, :color, :location
    def initialize(location, color)
      @location = location
      @color = color
      @symbol = is_black? ? "♞" : "♘"
    end
  
    def move_set
      [1, -1, 2, -2].permutation(2).to_a.reject { |y, x| y.abs == x.abs}
    end

  end