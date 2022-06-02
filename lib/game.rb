class Game
  attr_accessor :player_1, :player_2, :board

  def initialize
    @board = Board.new
    @player_1 = Player.new('white', 1, @board)
    @player_2 = Player.new('black', 2, @board)
    start_game
    declare_winner
  end

  def start_game
    @round = Round.new([@player_1, @player_2], @board) until @board.game_over
  end

  def declare_winner
    puts "Checkmate! #{@round.winner.name} wins!"
  end

end
