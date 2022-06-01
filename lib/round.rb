class Round
  def initialize(players, board)
    @@players = players
    @board = board
    play_round
  end

  def play_round
    @@players.each { |player| Turn.new(player, @board) unless @board.game_over? } until @board.game_over?
  end
end