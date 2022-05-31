class Turn
  def initialize(player, board)
    @player = player
    @board = board
    @board.print_board
    @selected_piece = @player.select_piece
    @move = @player.get_move(@selected_piece)
    @selected_piece.move_piece(@move, @board)
  end
  #get the location of the piece the player wishes to move.  if the space is valid, convert the input to a corresponding place on the board grid in [row, column] format.  if the piece belongs to the player, select the piece 


  

 
end