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
  #return all player's rooks which are capable of castling
  def get_castle_rooks
    @pieces_on_board = get_partitioned_pieces.first
    king = @king
    rooks = @pieces_on_board.select { |piece| piece.is_a?(Rook) && !piece.has_moved }
    #return false if player is in check, has moved their king, or has no elligible rooks
    return [] if in_check? || king.has_moved || rooks.empty?
    castle_rooks = []
    rooks.each do |rook|
      #get spaces between given rook and king 
      spaces_between = get_spaces_between(duplicate(king.location), duplicate(rook.location))
      #determine if all spaces between are empty
      is_empty = spaces_between.select { |space| @board.grid[space.first][space.last] }.empty?
      #determine if the king would be passing through check or moving into check
      spaces_between += [duplicate(rook.location)]
      is_safe = spaces_between.select { |space| @board.test_move(space, king, self) }.empty? 
      #add rook to array if it meets previous two conditions
      castle_rooks << rook if is_empty && is_safe
    end
    #return array of rooks unless it is empty
    castle_rooks   
  end
  #return whether or not player has any rooks which can be castled with
  def can_castle?
    get_castle_rooks.any?
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
