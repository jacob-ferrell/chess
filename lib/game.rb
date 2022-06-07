class Game
  attr_accessor :player_1, :player_2, :board
  
  def initialize(player_1 = nil, player_2 = nil, board = nil)
    @board = board ||= Board.new
    @board.game_over = false
    @choice = get_choice
    @player_1 = player_1 ||= Player.new('white', 1, @board)
    @player_2 = player_2 ||= Player.new('black', 2, @board, against_computer?)
    start_game
    declare_winner
  end
  
  def against_computer?
    return @choice == 2
  end

  def get_choice
    puts "\nPress 1 to play against another player.  Press 2 to play against the computer"
    choice = gets.chomp.to_i
    invalid_choice unless [1, 2].include?(choice)
    choice
  end

  def invalid_choice
    puts "Invalid choice"
    get_choice
  end
  #start a new round as long as the game is not over
  def start_game
    @round = Round.new([@player_1, @player_2], @board) until @board.game_over
  end
  #declare a winner once the game is over
  def declare_winner
    puts "Checkmate! #{@round.winner.name} wins!" if @round.winner && @board.game_over
  end

end
