class Round
  attr_reader :winner

  def initialize(players, board)
    @@players = players
    @board = board
    play_round
    @winner = get_winner
  end

  def play_round
    @@players.each { |player| Turn.new(player, @board) unless @board.game_over } until @board.game_over || is_draw?
  end

  def get_winner
    @@players.reject { |player| player == @board.loser }.first
  end

  def is_draw?
    only_king_left = 0
    king_and_bishop_or_knight = 0
    @@players.each do |player|
      pieces = player.pieces_on_board
      only_king_left += 1 if pieces.length == 1
      king_and_bishop_or_knight += 1 if king_and_bishop_or_knight?(pieces)
    end
    return true if only_king_left == 2 || (only_king_left == 1 && king_and_bishop_or_knight == 1)
    false
  end

  def king_and_bishop_or_knight?(pieces)
    pieces = pieces.map { |piece| piece.class }
    if pieces.length == 2 
      pieces.include?('Bishop') || pieces.include?('Knight')
    end
    false
  end
end
