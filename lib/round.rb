class Round
  def initialize(players, board)
    @@players = players
    @board = board
    play_round
  end

  def play_round
    until @board.game_over?
      @@players.each { |player| Turn.new(player, @board) unless @board.game_over? }
    end
  end
end