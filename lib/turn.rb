class Turn
  def initialize(player, board)
    @player = player
    @board = board
    @board.print_board
    p @player.in_check?
    get_choices
    
  end

  def get_choices
    @selected_piece = @player.select_piece
    @move = @player.get_move(@selected_piece)
    test_choices
  end
#tests if move choice will result in player moving into check/checkmate
  def test_choices
    return moving_into_check if moving_into_check?
    make_move
  end
#make deep copy of board to revert to if move selection will result in player moving themselves into check
  def moving_into_check?
    tmp_board = Marshal.load(Marshal.dump(@board))
    @selected_piece.move_piece(@move, @board)
    if @player.in_check?
      @board = tmp_board
      return true
    end
  end

  def moving_into_check
    puts "You cannot put yourself into check!"
    get_choices
  end

  def make_move
    @selected_piece.move_piece(@move, @board)
  end
end