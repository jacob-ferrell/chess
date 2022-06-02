require 'duplicate'
require 'yaml'
class Turn
  def initialize(player, board, players)
    @player = player
    @players = players
    @board = board
    @board.print_board
    return @board.loser = @player if @player.check_mate?
    in_check
    return save_game if get_choices == 'save'
    test_choices
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
    return @piece if @piece == 'save'
    @move = choices.move unless @piece == 'save'
    return @move if @move == 'save'
  end

  def test_choices
    while @board.test_move(@move, @piece, @player)
      into_check
      get_choices
    end
  end

  def into_check
    return puts "\nYour move choice did not take you out of check! Move prevented!" if @player.in_check?
    puts "\nYou cannot move yourself into check!  Move prevented!"
  end

  def in_check
    puts "\n#{@player.name}, you are in check!  You must move yourself out of check!" if @player.in_check?
  end

  def make_move
    @board.move_piece(@move, @piece)
  end

  def save_game
    @board.game_over = true
    game_data = {
      'players'=>@players,
      'current_player'=>@player,
      'board'=>@board
    }
    puts "\nEnter a name for your save file:"
    Dir.mkdir('saves') unless Dir.exist?('saves')
    name = gets.chomp
    filename = "saves/#{name}.yml"
    File.open(filename, 'w') { |file| file.write game_data.to_yaml}
    File.exist?(filename) if puts "Game successfully saved!"
  end
end
