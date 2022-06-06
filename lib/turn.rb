require 'duplicate'
require 'yaml'
class Turn
  def initialize(player, board, players)
    @player = player
    @players = players
    @board = board
    @board.print_board
    play_turn
  end

  def play_turn
    #end game and assign current player as loser if player is in checkmate
    return @board.loser = @player if @player.check_mate?
    test_check
    get_choices
  end
  #get player's piece and move choice and then test them, or save if player chooses
  def get_choices
    choices = PlayerChoices.new(@player, @board)
    @piece = choices.piece
    @move = choices.move 
    if choices.save
      choices.save = false
      return save_game
    end
    test_choices
  end
  #test if player's move choice will result in them being in check, alert them if so, prevent the move, and get choices again. make the move if it passes tests
  def test_choices
    while @board.test_move(@move, @piece, @player)
      into_check
      get_choices
      return if @board.game_over
    end
    make_move
    promote if can_promote? 
  end
  #alert player if they fail to move themselves out of check or if they move themselves into check
  def into_check
    return puts "\nYour move choice did not take you out of check! Move prevented!" if @player.in_check?
    puts "\nYou cannot move yourself into check!  Move prevented!"
  end
#alert player if they are in check at the beginning of their turn
  def test_check
    puts "\n#{@player.name}, you are in check!  You must move yourself out of check!" if @player.in_check?
  end
  #commit the move to the board
  def make_move
    @board.move_piece(@move, @piece)
  end
  #return true if the piece is a pawn and it is located on the first or last row
  def can_promote?
    @piece.is_a?(Pawn) && [0, 7].include?(@piece.location.first)
  end
  #prompt player to select a piece type for promotion and perform if selection is valid
  def promote
    @board.print_board
    puts "\n#{@player.name}, you are able to promote your Pawn! Type the name of the type of piece you want to promote it to:"
    type = get_type
    (row, col) = @piece.location
    new_piece = Object.const_get type.capitalize
    promoted_piece = new_piece.new([row, col], @piece.color)
    @board.grid[row][col] = promoted_piece
    @board.promoted_pieces << promoted_piece
  end
  #get type selection from player
  def get_type
    type = gets.chomp.downcase
    return type if valid_type?(type)
    puts "\nThat type of piece does not exist!"
    promote
  end
  #determien if players type selection for promotion is valid
  def valid_type?(type)
    types = ['queen', 'rook', 'bishop', 'knight', 'pawn']
    types.include?(type)
  end
  #save the game in the /saves directory under a file name of the player's choice
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
