class Round
  attr_reader :winner

  def initialize(players, board)
    @@players = players
    @board = board
    play_round
    @winner = get_winner 
  end
  #start a new turn for each player until a draw or checkmate
  def play_round
    @@players.each { |player| Turn.new(player, @board, @@players) unless end_game? } until end_game?
    draw if is_draw?
  end
  #test if there is a draw or checkmate
  def end_game?
    @board.game_over || is_draw?
  end
  #return nil if no player is in checkmate or game is a draw. otherwise return whichever player is not the loser
  def get_winner
    return nil if is_draw? || @@players.select { |player| player.check_mate? }.empty?
    @@players.reject { |player| player == @board.loser }.first
  end
  #determine if there are only kings left or one player has only a king and the other has a king and a bishop or knight
  def is_draw?
    (player1_pieces, player2_pieces) = @@players.first.get_partitioned_pieces
    total_pieces = player1_pieces.length + player2_pieces.length
    knight_or_bishop = (player1_pieces + player2_pieces).count { |x| x.is_a?(Knight) || x.is_a?(Bishop) }
    if total_pieces == 2 || (total_pieces == 3 && knight_or_bishop > 0)
      @board.game_over = true
      return true
    end
  end
  
  def draw
    @board.print_board
    puts "\nIt's a draw! Game over!"
  end
end
