class Player
  attr_accessor :color, :number, :name, :input

  def initialize(color, number, board)
    @color = color
    @number = number
    @board = board
    @name = get_name
  end

  # get player name from user
  def get_name
    puts "Player #{@number}, enter your name:"
    gets.chomp
  end

  # determine if player's king is in check
  def in_check?
    opponents_pieces = get_partitioned_pieces.last
    moves = []
    king_location = @king.location
    opponents_pieces.each { |piece| moves += piece.get_moves(@board) }
    moves.include?(king_location)
  end

  # determine if player is in checkmate by performing every possible move by the players pieces and determining if any result in no longer being in check
  def check_mate?
    player_pieces = get_partitioned_pieces.first
    player_pieces.each do |piece|
      piece.get_moves(@board).each do |move|
        return false if !@board.test_move(move, piece, self)
      end
    end
    @board.game_over = true
    return true
  end

  # returns an array where the first element is all the player's own pieces on the board, and the second is all the opponents
  def get_partitioned_pieces
    players_pieces = []
    opponents_pieces = []
    partitioned_pieces = []
    @board.grid.each do |row|
      row.each do |space|
        opponents_pieces << space if space && space.color != color
        players_pieces << space if space && space.color == color
        @king = space if space.is_a?(King) && space.color == color
      end
    end
    partitioned_pieces.push(players_pieces, opponents_pieces)
    partitioned_pieces
  end
end
