class PlayerChoices
  attr_reader :piece, :move

  def initialize(player, board)
    @player = player
    @board = board
    @piece = select_piece
    @move = get_move(@piece)
  end
  #return a chosen piece as long as a piece which belongs to the player exists at the given location
  def select_piece
    @board.print_board
    input = get_piece_choice
    if is_valid?(input)
      @input = input 
      (row, col) = @board.get_coordinate(input)
      piece = @board.grid[row][col]
      if is_own_piece?(piece)
        piece
      else 
        invalid_space
      end
    else
      invalid_input
    end
  end
  #print that input was invalid and get selection from user again
  def invalid_input
    puts "Invalid input"
    return select_piece
  end
#print that space is taken or does not belong to player and get selection again
  def invalid_space
    puts "You have selected an empty space or a piece which is not yours"
    select_piece
  end
  #prompt user for piece choice and return choice
  def get_piece_choice
    puts "#{@player.name}, enter the location of the piece you wish to move.\nBegin with the letter, and then the number.  Example: a2"
    input = gets.chomp
    input
  end
  #determine if chosen location contains a piece and if the piece belongs to the player
  def is_own_piece?(piece)
    piece && piece.color == @player.color
  end
  #check if input refers to valid space on the board
  def is_valid?(input)
    input = input.downcase.chars
    input.length === 2 && ('a'..'h').include?(input.first) && (1..8).include?(input.last.to_i)
  end
    #get the location of the piece the player wishes to move.  if the space is valid, convert the input to a corresponding place on the board grid in [row, column] format.  if the piece belongs to the player, select the piece 
  def get_move(selected_piece)
    puts "#{@player.name}, select a space to move your #{selected_piece.class}(#{@input}) to, or enter X to choose a different piece"
    move = gets.chomp
    coord = @board.get_coordinate(move) if is_valid?(move)
    if move.downcase == 'x'
        selected_piece = select_piece
        return get_move(selected_piece)
    end
    return coord if selected_piece.get_moves(@board).include?(coord)
    puts "Invalid move..."
    get_move(selected_piece)
      end
end