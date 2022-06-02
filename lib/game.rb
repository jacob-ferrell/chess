class Game
  attr_accessor :player_1, :player_2, :board
  
  def initialize(player_1 = nil, player_2 = nil, board = nil)
    @board = board ||= Board.new
    @board.game_over = false
    @player_1 = player_1 ||= Player.new('white', 1, @board)
    @player_2 = player_2 ||= Player.new('black', 2, @board)
    start_game
    declare_winner
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
