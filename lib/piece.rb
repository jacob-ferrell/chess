module Piece
  def is_black?
    color == 'black'
  end

  # determines all possible paths of a given piece including spaces which include an enemy piece, exclusing spaces with player piece
  def get_moves(board)
    moves = []
    # Pawns have a variable move set due to their unique ability to take pieces diagonally even though they can only traverse the board vertically,
    # so the board needs to be passed in to their move_set method so it can detect if it's capable of attack
    move_set = is_a?(Pawn) ? self.move_set(board) : self.move_set
    start = location
    (row, col) = start
    # loop through every possible movement direction
    move_set.each do |direction|
      (r, c) = direction
      direction_moves = []
      #continue in current direction as long as next space is in bounds. stopping before hitting one of the player's own pieces or upon hitting an enemy piece. 
      #single-move pieces only progress one space in each direction
      while in_bounds?([row + r, col + c])
        row += r
        col += c
        next_space = board.grid[row][col]
        # move onto next direction if next space contains one of player's own pieces
        if next_space
          if next_space.color == color
            break
          else
            # if space contains an enemy piece, add it to possible moves unless the current piece is a pawn and the enemy piece is vertically adjacent
            direction_moves << [row, col] unless is_a?(Pawn) && c == 0
            break
          end
        else
          # if space is empty, add it to possible moves.  move on to next direction if piece is single-move
          direction_moves << [row, col]
          break if single_moves?
        end
      end
      moves << direction_moves
      (row, col) = start
    end
    moves.flatten(1)
  end

  # determine if given coordinates exist on the board
  def in_bounds?(coord)
    coord.reject { |num| (0..7).include?(num) }.empty?
  end

  # identify pieces which can only move once, such as pawn, king and knight
  def single_moves?
    is_a?(Pawn) || is_a?(King) || is_a?(Knight)
  end

  # move piece to chosen location. if a piece is being taken, add it to the graveyard
  def move_piece(move, board, _test_move = false)
    (start_row, start_col) = duplicate(location)
    (end_row, end_col) = move
    # board.graveyard << board.grid[end_row][end_col] if !test_move && board.grid[end_row][end_col]
    self.location = move
    board.grid[end_row][end_col] = self
    board.grid[start_row][start_col] = nil
  end
end
