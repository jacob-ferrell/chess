class Player
  attr_accessor :color, :number, :name, :input

  def initialize(color, number, board)
    @color = color
    @number = number
    @board = board
    @name = get_name
    
  end

#get player name from user
  def get_name
    puts "Player #{@number}, enter your name:"
    gets.chomp
  end

  #determine if player's king is in check
  def in_check?
    opponents_pieces = get_partitioned_pieces.last
    moves = []
    king_location = @king.location
    opponents_pieces.each { |piece| moves += piece.get_moves(@board) }
    moves.include?(king_location)
  end
  #determine if player is in checkmate by performing every possible move by the players pieces and determining if any result in no longer being in check
  def check_mate?
    player_pieces = get_partitioned_pieces.first
    tmp_board = Marshal.load(Marshal.dump(@board))
    player_pieces.each do |piece|
      piece.get_moves(@board).each do |move|
        piece.move_piece(move, @board)
        if !self.in_check?
          @board = tmp_board
          return false
        end
        @board = tmp_board
      end
    end
  end
#returns an array where the first element is all the player's own pieces on the board, and the second is all the opponents
  def get_partitioned_pieces
    players_pieces = []
    opponents_pieces = []
    partitioned_pieces = []
    @board.grid.each do |row| 
      row.each do |space|
        opponents_pieces << space if space && space.color != self.color
        players_pieces << space if space && space.color == self.color
        @king = space if space.is_a?(King) && space.color == self.color
      end
    end
    partitioned_pieces.push(players_pieces, opponents_pieces)
    partitioned_pieces
  end
end