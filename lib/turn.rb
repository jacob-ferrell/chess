class Turn
  def initialize(player, board)
    @player = player
    @board = board
    @board.print_board
    @selected_piece = @player.select_piece(@board)
    @move = get_move
    @selected_piece.move_piece(@move, @board)
  end
  #get the location of the piece the player wishes to move.  if the space is valid, convert the input to a corresponding place on the board grid in [row, column] format.  if the piece belongs to the player, select the piece 


  def get_move
    @board.print_board
    puts "#{@player.name}, select a space to move your #{@selected_piece.class}(#{@player.input}) to, or enter X to choose a different piece"
    move = gets.chomp
    coord = @player.get_coordinate(move) if @player.is_valid?(move)
    if move.downcase == 'x'
        @selected_piece = select_piece
        return @move = get_move
    end
    return coord if @selected_piece.get_moves(@board).include?(coord)
    puts "Invalid move..."
    get_move
  end

 
end