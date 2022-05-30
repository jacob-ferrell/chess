class Rook

  def initialize(location, color)
    @location = location
    @symbol = color == 'black' ? "♜" : "♖"
  end
end