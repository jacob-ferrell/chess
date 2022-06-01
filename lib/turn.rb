require 'duplicate'
class Turn
  def initialize(player, board)
    @player = player
    @board = board
    p @player.in_check?
    @board.print_board
    in_check
    get_choices
    #get_choices while results_in_check?
    make_move
  end
  #make a deep copy of the board
  #make the chosen move, test whether player is in check and store result as variable
  #revert to original board
  def results_in_check?
    tmp_board = duplicate(@board)
    @piece.move_piece(@move, @board, true)
    results_in_check = duplicate(@player.in_check?)
    @board = duplicate(tmp_board)
    tmp_board = nil
    return results_in_check
  end

  def get_choices
    @piece = @player.select_piece(@board)
    @move = @player.get_move(@piece)
  end

  def cant
    puts "Can't do that!"
  end

  def in_check
    puts "#{@player.name}, you are in check!  You must move yourself out of check!" if @player.in_check?
  end





  def make_move
    @piece.move_piece(@move, @board)
  end
end