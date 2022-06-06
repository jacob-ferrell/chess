class ComputerChoices
  attr_reader :piece, :move, :save

  def initialize(player, board)
  @player = player
  @board = board
  @piece = select_piece
  @move = select_move
  @save = false
  end

  def get_pieces
    @player.get_partitioned_pieces.first
  end
  #keep selecting random pieces until one which is able to make a valid move is found
  def select_piece
    piece = get_pieces[rand(0..(get_pieces.length - 1))]
    return piece if can_move?(piece)
    select_piece
  end

  def can_move?(piece)
    moves = piece.get_moves(@board)
    return false if moves.empty?
    valid_moves(piece, moves).any?
  end

  def valid_moves(piece, moves)
    moves.reject { |move| @board.test_move(move, piece, @player) }
  end

  def select_move
    moves = valid_moves(@piece, @piece.get_moves(@board))
    if @player.can_castle? && @piece.is_a?(King)
        @player.get_castle_rooks.each { |rook| moves << rook.location }
    end
    moves[rand(0..(moves.length - 1))]
  end
end