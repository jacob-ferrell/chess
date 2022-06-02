

class Board
  attr_accessor :grid, :graveyard, :black_king, :white_king
  
  def initialize
    @grid = build_grid
    @graveyard = []
    print_board
  end

  def build_grid
    #create all starting pieces on the chessboard and store each piece as an object within it's corresponding array element
    grid = Array.new(8) {Array.new(8)}
     #create pawns and add to grid
    grid[1] = grid[1].map.with_index { |element, ind| Pawn.new([1, ind], 'black', @grid) }
    grid[6] = grid[6].map.with_index { |element, ind| Pawn.new([6, ind], 'white', @grid) }
    #create rooks and add to grid
    grid[0] = grid[0].map.with_index { |element, ind| Rook.new([0, ind], 'black') unless (1..6).include?(ind) }
    grid[7] = grid[7].map.with_index { |element, ind| Rook.new([7, ind], 'white') unless (1..6).include?(ind) }
    #create knights and add to grid
    grid[0][1] = Knight.new([0, 1], 'black')
    grid[0][6] = Knight.new([0, 6], 'black')
    grid[7][1] = Knight.new([7, 1], 'white')
    grid[7][6] = Knight.new([7, 6], 'white')
    #create bishops and add to grid
    grid[0][2] = Bishop.new([0, 2], 'black')
    grid[0][5] = Bishop.new([0, 5], 'black')
    grid[7][2] = Bishop.new([7, 2], 'white')
    grid[7][5] = Bishop.new([7, 5], 'white')
    #create kings and add to grid
    grid[0][4] = @black_king = King.new([0, 4], 'black')
    grid[7][4] = @white_king = King.new([7, 4], 'white')
    #create queens and add to grid
    grid[0][3] = Queen.new([0, 3], 'black')
    grid[7][3] = Queen.new([7, 3], 'white')
    return grid
  end

  def game_over?
    false
  end

  def print_board
    numbers = (1..8).to_a.reverse
    letters = ('a'..'h').to_a
    puts "    #{letters.join('   ')}"
    puts "  +---+---+---+---+---+---+---+---+ #{@graveyard.map { |p| p.symbol }.join(' ')}"
    @grid.map { |e| e.map { |el| el ? el.symbol : ' '}}.each_with_index do |e, i|
        puts "#{numbers[i]} | #{e.join(' | ')} |"
        puts '  +---+---+---+---+---+---+---+---+'
    end
    puts "    #{letters.join('   ')}"
  end

  def get_coordinate(input)
    input = input.chars
    #convert letter to corresponding column
    letter_pairs = {}
    ('a'..'h').each_with_index { |char, i| letter_pairs[char] = i }
    column = letter_pairs[input.first]
    #convert number to corresponding row
    number_pairs = {}
    (1..8).to_a.reverse.each_with_index { |num, i| number_pairs[num] = i }
    row = number_pairs[input.last.to_i]
    return [row, column]
  end

  def move_piece(move, piece)
    (start_row, start_col) = duplicate(piece.location)
    (end_row, end_col) = move
    #board.graveyard << board.grid[end_row][end_col] if !test_move && board.grid[end_row][end_col]
    piece.location = move
    @grid[end_row][end_col] = piece
    grid[start_row][start_col] = nil
  end

  def test_move(move, piece, player)
    tmp_grid = duplicate(@grid)
    start_location = duplicate(piece.location)
    move_piece(move, piece)
    check = duplicate(player.in_check?)
    @grid = duplicate(tmp_grid)
    piece.location = start_location
    return check
  end
end

