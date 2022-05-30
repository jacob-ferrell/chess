class Queen
  attr_reader :symbol
  def initialize(location, color)
    @location = location
    @symbol = color == 'black' ? "♛" : "♕"
  end

  def move_set
    [1, 1, -1, -1].permutation(2).to_a.uniq + [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end

  def is_black?
    @color == 'black'
  end
end