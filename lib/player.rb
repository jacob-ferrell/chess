class Player
  attr_accessor :color, :number, :name

  def initialize(color, number)
    @color = color
    @number = number
    @name = get_name
  end

  def get_name
    puts "Player #{@number}, enter your name:"
    gets.chomp
  end
end