require 'duplicate'
class Turn
  def initialize(player, board)
    @player = player
    @board = board
    
    p @player.in_check?

    get_choices
    make_move
    
  end

  def get_choices
    @board.print_board
    in_check if @player.in_check?
    #return check_mate if @player.in_check? && @player.check_mate?
    @selected_piece = @player.select_piece
    @move = @player.get_move(@selected_piece)
    test_choices
  end
#if player is not in check at beginning of turn, test if they are moving themselves into check
#if player is in check at the beginning of turn, test if they are moving themselves out of check
  def test_choices
    return moving_into_check if !@player.in_check? && moving_into_check?
    return move_out_of_check if @player.in_check? && !moving_out_of_check?
    
  end
#make a deep copy of the board before making a chosen move.  if the move results in the player putting themselves into check, revert to the deep copy and prompt the user for a different move
  def moving_into_check?

    move_to = duplicate(@board.grid[@move.first][@move.last])
    move_from = duplicate(@selected_piece.location)
    @selected_piece.move_piece(@move, @board, true)
    if @player.in_check?

      return true
    end

    return false
  end

  def in_check
    puts "#{@player.name}, you are in check!  You must move yourself out of check!"
  end

  def moving_into_check
    puts "You cannot moves yourself into check!"
    get_choices
  end
#if a player is in check at the beginning of their turn, detect if they are making a move which keeps them in check
  def moving_out_of_check?

    move_to = duplicate(@board.grid[@move.first][@move.last])
    move_from = duplicate(@selected_piece.location)
    @selected_piece.move_piece(@move, @board, true)
    unless @player.in_check?

      @board.grid[@move.first][@move.last] = move_to
      @board.grid[move_from.first][move_from.last] = @selected_piece
      @selected_piece.location = move_from
      return true
    end

    @board.grid[@move.first][@move.last] = move_to
    @board.grid[move_from.first][move_from.last] = @selected_piece
    @selected_piece.location = move_from
    return false
  end

  def move_out_of_check
    puts "Your move resulted in you still being in check!"
    get_choices
  end

  def check_mate
    puts "Checkmate!"
  end

  def make_move
    @selected_piece.move_piece(@move, @board)
  end
end