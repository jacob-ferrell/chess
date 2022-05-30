class Knight
  attr_reader :symbol
    def initialize(location, color)
      @location = location
      @symbol = color == 'black' ? "♞" : "♘"
    end
  
    def move_set
      [1, -1, 2, -2].permutation(2).to_a.reject { |y, x| y.abs == x.abs}
    end
  
    def is_black?
      @color == 'black'
    end
  end