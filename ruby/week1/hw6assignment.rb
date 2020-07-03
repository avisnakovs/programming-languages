class MyPiece < Piece

  All_My_Pieces = All_Pieces + [rotations([[0, 0], [1, 0], [0, 1], [1, 1], [2, 1]]),
                                rotations([[0, 0], [1, 0], [0, 1]]),
                                rotations([[0, 0], [0, 1], [0, 2], [0, 3], [0, 4]])]

  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  def self.next_cheat_piece (board)
    MyPiece.new([[[0, 0]]], board)
  end
end

class MyBoard < Board

  def initialize (game)
    @grid = Array.new(num_rows) { Array.new(num_columns) }
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..@current_block.current_rotation.length - 1).each { |index|
      current = locations[index];
      @grid[current[1] + displacement[1]][current[0] + displacement[0]] =
          @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  def next_piece
    if @cheat
      @current_block = MyPiece.next_cheat_piece(self)
      @current_pos = nil
      @cheat = false
    else
      @current_block = MyPiece.next_piece(self)
      @current_pos = nil
    end
  end

  def cheat
    if !@cheat && @score >= 100
      @score -= 100
      @cheat = true
    end
  end
end

class MyTetris < Tetris

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
    @cheat = false
  end

  def key_bindings
    super
    @root.bind('u', proc { self.rotate })
    @root.bind('c', proc { self.cheat })
  end

  def rotate
    @board.rotate_clockwise
    @board.rotate_clockwise
  end

  def cheat
    @board.cheat
    update_score
  end
end
