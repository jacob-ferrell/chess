class Queen
  def initialize(location, color)
    @location = location
    @symbol = color == 'black' ? "♛" : "♕"
  end

  def is_black?
    @color == 'black'
  end
end