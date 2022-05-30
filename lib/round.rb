class Round
  def initialize(player_1, player_2, board)
    @@player_1 = player_1
    @@player_2 = player_2
    @board = board
    play_round
  end

  def play_round
    until @board.game_over?
      Turn.new(@@player_1, @board) unless @board.game_over?
      Turn.new(@@player_2, @board) unless @board.game_over?
    end
  end
end