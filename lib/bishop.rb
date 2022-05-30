class Bishop
  attr_reader :symbol, :color
  def initialize(location, color)
    @location = location
    @color = color
    @symbol = is_black? ? "♝" : "♗"
  end

  def move_set
    [1, 1, -1, -1].permutation(2).to_a.uniq
  end

  def is_black?
    @color == 'black'
  end
end
     