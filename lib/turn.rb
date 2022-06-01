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
  end



  def in_check
    puts "#{@player.name}, you are in check!  You must move yourself out of check!"
  end





  def make_move
    @selected_piece.move_piece(@move, @board)
  end
end