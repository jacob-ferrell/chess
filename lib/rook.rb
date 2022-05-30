class Rook
  attr_reader :symbol, :color
  def initialize(location, color)
    @location = location
    @color = color
    @symbol = is_black? ? "♜" : "♖"
  end

  def move_set
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end

  def is_black?
    @color == 'black'
  end
end