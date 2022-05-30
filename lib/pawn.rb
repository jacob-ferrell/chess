class Pawn
  attr_reader :symbol, :color
  def initialize(location, color)
    @location = location
    @color = color
    @symbol = is_black? ? "♟" : "♙"
  end

  def move_set
    if is_black?
      row == 6 ? [[1, 0], [2, 0]] : [[1, 0]]
    else
      row == 1 ? [[-1, 0], [-2, 0]] : [[-1, 0]]
    end

  end

  def is_black?
    @color == 'black'
  end

  def row
    return @location.first
  end

  def col
    return @location.last
  end
end