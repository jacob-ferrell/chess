class Turn
  def initialize(player, board)
    @player = player
    @board = board
    @board.print_board
    @selected_piece = select_piece
    @move = get_move
    @selected_piece.move_piece(@move, @board)
  end
  #get the location of the piece the player wishes to move.  if the space is valid, convert the input to a corresponding place on the board grid in [row, column] format.  if the piece belongs to the player, select the piece 
  def select_piece
    puts "#{@player.name}, enter the location of the piece you wish to move.\nBegin with the letter, and then the number.  Example: a2"
    input = gets.chomp
    if is_valid?(input) 
      (row, col) = get_coordinate(input)
      piece = @board.grid[row][col]
      if !piece.nil? && piece.color == @player.color
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

  def get_move
    puts "#{@player.name}, select a space to move your #{@selected_piece.class} to"
    move = gets.chomp
    coord = get_coordinate(move) if is_valid?(move)
    return coord if @selected_piece.get_moves(@board).include?(coord)
    puts "Invalid move..."
    get_move
  end

 
end