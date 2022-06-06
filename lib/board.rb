class Board
  attr_accessor :grid, :promoted_pieces, :black_king, :white_king, :game_over, :loser

  def initialize
    @grid = build_grid
    @promoted_pieces = []
    @game_over = false
    @loser = nil
  end

  def build_grid
    # create all starting pieces on the chessboard and store each piece as an object within it's corresponding array element
    grid = Array.new(8) { Array.new(8) }
    # create pawns and add to grid
    grid[1] = grid[1].map.with_index { |_element, ind| Pawn.new([1, ind], 'black') }
    grid[6] = grid[6].map.with_index { |_element, ind| Pawn.new([6, ind], 'white') }
    # create rooks and add to grid
    grid[0] = grid[0].map.with_index { |_element, ind| Rook.new([0, ind], 'black') unless (1..6).include?(ind) }
    grid[7] = grid[7].map.with_index { |_element, ind| Rook.new([7, ind], 'white') unless (1..6).include?(ind) }
    # create knights and add to grid
    grid[0][1] = Knight.new([0, 1], 'black')
    grid[0][6] = Knight.new([0, 6], 'black')
    grid[7][1] = Knight.new([7, 1], 'white')
    grid[7][6] = Knight.new([7, 6], 'white')
    # create bishops and add to grid
    grid[0][2] = Bishop.new([0, 2], 'black')
    grid[0][5] = Bishop.new([0, 5], 'black')
    grid[7][2] = Bishop.new([7, 2], 'white')
    grid[7][5] = Bishop.new([7, 5], 'white')
    # create kings and add to grid
    grid[0][4] = @black_king = King.new([0, 4], 'black')
    grid[7][4] = @white_king = King.new([7, 4], 'white')
    # create queens and add to grid
    grid[0][3] = Queen.new([0, 3], 'black')
    grid[7][3] = Queen.new([7, 3], 'white')
    grid
  end

  #give board a visually appealing representation on the command line from which users can play
  def print_board
    numbers = (1..8).to_a.reverse
    letters = ('a'..'h').to_a
    puts "    #{letters.join('   ')}     #{get_graveyard('black')}"
    puts "  +---+---+---+---+---+---+---+---+ #{@graveyard.map { |p| p.symbol }.join(' ')}"
    @grid.map { |e| e.map { |el| el ? el.symbol : ' ' } }.each_with_index do |e, i|
      puts "#{numbers[i]} | #{e.join(' | ')} |"
      puts '  +---+---+---+---+---+---+---+---+'
    end
    puts "    #{letters.join('   ')}     #{get_graveyard('white')}"
  end
  #covert coordinate from letter-number format to row-column
  def get_coordinate(input)
    input = input.chars
    # convert letter to corresponding column
    letter_pairs = {}
    ('a'..'h').each_with_index { |char, i| letter_pairs[char] = i }
    column = letter_pairs[input.first]
    # convert number to corresponding row
    number_pairs = {}
    (1..8).to_a.reverse.each_with_index { |num, i| number_pairs[num] = i }
    row = number_pairs[input.last.to_i]
    [row, column]
  end
  #move piece to chosen location on grid and remove its presence from it's old space
  def move_piece(move, piece)
    return if move == piece.location
    return castle(move, piece) if is_castle?(move, piece)
    (start_row, start_col) = duplicate(piece.location)
    (end_row, end_col) = move
    @grid[end_row][end_col] = piece
    piece.location = move
    @grid[start_row][start_col] = nil 
    piece.has_moved = true if piece.is_a?(King) || piece.is_a?(Rook)
  end
  # make a deep copy of the board and starting location of selected piece
  # make the chosen move, test whether player is in check and store result as variable
  # revert to original grid and revert piece's location. return variable.
  def test_move(move, piece, player)
    tmp_has_moved = duplicate(piece.has_moved) if piece.is_a?(King) || piece.is_a?(Rook)
    tmp_grid = duplicate(@grid)
    start_location = duplicate(piece.location)
    move_piece(move, piece)
    check = duplicate(player.in_check?)
    @grid = duplicate(tmp_grid)
    piece.location = start_location
    piece.has_moved = tmp_has_moved if piece.is_a?(King) || piece.is_a?(Rook)
    check
  end
  #determine if a move is a castle by determing if their chosen piece is a king and their chosen move location is their own rook
  def is_castle?(move, piece)
    end_piece = @grid[move.first][move.last]
    piece.is_a?(King) && end_piece.is_a?(Rook) && piece.color == end_piece.color
  end
  #perform a castle by moving the pieces on the board
  def castle(move, piece)
    rook = @grid[move.first][move.last]
    king = piece
    rook.location = duplicate(king.location)
    @grid[move.first][move.last] = king
    @grid[king.location.first][king.location.last] = rook
    king.location = move
    rook.has_moved = true
    king.has_moved = true
  end
  #get each players graveyard by returning whichever pieces have been taken off the board
  def get_graveyard(color)
    original = get_original_pieces(color)
    current = get_current_pieces(color)
    current.each { |x| original.delete_at original.index(x) }
    original.join(' ')
  end
  #return all the pieces that a player starts with
  def get_original_pieces(color)
    original_pieces = []
    promoted_pieces = @promoted_pieces.select { |piece| piece.color == color }
    promoted_pieces.each { |piece| original_pieces << piece } 
    (8 - promoted_pieces.length).times { original_pieces << Pawn.new([], color) }
    2.times do
      original_pieces.push(Rook.new([], color), Knight.new([], color), Bishop.new([], color))
    end
    original_pieces.push(King.new([], color), Queen.new([], color))
    original_pieces.map { |piece| piece.symbol }
  end
  #get all player's pieces that are currently on the board
  def get_current_pieces(color)
    current_pieces = []
    @grid.each do |row|
      row.each do |space|
        current_pieces << space if space && space.color == color
      end
    end
    current_pieces.map { |piece| piece.symbol}
  end
end
