require 'duplicate'
class Turn
  def initialize(player, board)
    @player = player
    @board = board
    @board.print_board
    in_check
    return if @player.check_mate?
    get_choices
    get_choices while @board.test_move(@move, @piece, @player)
    make_move
  end

  # make a deep copy of the board
  # make the chosen move, test whether player is in check and store result as variable
  # revert to original board
  def results_in_check?
    tmp_board = duplicate(@board)
    @board.move_piece(@move, @piece.location, true)
    results_in_check = duplicate(@player.in_check?)
    @board = duplicate(tmp_board)
    tmp_board = nil
    results_in_check
  end

  def get_choices
    choices = PlayerChoices.new(@player, @board)
    @piece = choices.piece
    @move = choices.move
  end

  def cant
    puts "Can't do that!"
  end

  def in_check
    puts "#{@player.name}, you are in check!  You must move yourself out of check!" if @player.in_check?
  end

  def make_move
    @board.move_piece(@move, @piece)
  end
end
