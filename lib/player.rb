class Player
  attr_accessor :color, :number, :name, :input

  def initialize(color, number)
    @color = color
    @number = number
    @name = get_name
  end

  def select_piece(board)
    @board = board
    input = get_piece_choice
    if is_valid?(input)
      @input = input 
      (row, col) = get_coordinate(input)
      piece = @board.grid[row][col]
      if is_own_piece?(piece)
        piece
      else 
        puts "You have selected an empty space or a piece which is not yours"
        select_piece
      end
    else
      puts "Invalid input"
      select_piece
    end
  end
  #prompt us
  def get_piece_choice
    puts "#{self.name}, enter the location of the piece you wish to move.\nBegin with the letter, and then the number.  Example: a2"
    input = gets.chomp
    input
  end
  #determine if chosen location contains a piece and if the piece belongs to the player
  def is_own_piece?(piece)
    piece && piece.color == self.color
  end
  #check if input refers to valid space on the board
  def is_valid?(input)
    input = input.downcase.chars
    input.length === 2 && ('a'..'h').include?(input.first) && (1..8).include?(input.last.to_i)
  end

  def get_coordinate(input)
    input = input.chars
    #convert letter to corresponding column
    letter_pairs = {}
    ('a'..'h').each_with_index { |char, i| letter_pairs[char] = i }
    column = letter_pairs[input.first]
    #convert number to corresponding row
    number_pairs = {}
    (1..8).to_a.reverse.each_with_index { |num, i| number_pairs[num] = i }
    row = number_pairs[input.last.to_i]
    return [row, column]
  end

  def get_name
    puts "Player #{@number}, enter your name:"
    gets.chomp
  end
end