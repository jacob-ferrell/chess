class Player
  attr_accessor :color, :number, :name, :input, :pieces_on_board

  def initialize(color, number, board)
    @color = color
    @number = number
    @board = board
    @name = get_name
    @pieces_on_board = get_partitioned_pieces.first
  end

  # get player name from user
  def get_name
    puts "\nPlayer #{@number}, enter your name:"
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
  #determine if player is capable of castling
  def can_castle?
    king = @pieces_on_board.select { |piece| piece.is_a?(King) && !piece.has_moved }.first
    rooks = @pieces_on_board.select { |piece| piece.is_a?(Rook) && !piece.has_moved }
    if king && rooks.any?
    rooks.each do |rook| 
      spaces = get_spaces_between(duplicate(king.location), duplicate(rook.location)) 
      spaces.select { |space| @board.grid[space.first][space.last] }.empty?
    end
    p spaces_between
    end
  end
  #get all spaces between king and given rook
  def get_spaces_between(king_location, rook_location)
    (king_row, king_col) = king_location
    (rook_row, rook_col) = rook_location
    spaces = []
    i = rook_col > king_col ? 1 : -1
    until (king_col + i) === rook_col
      king_col += i
      spaces << [king_row, king_col] 
    end
    spaces
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
    @pieces_on_board = partitioned_pieces.first
    partitioned_pieces
  end
end
