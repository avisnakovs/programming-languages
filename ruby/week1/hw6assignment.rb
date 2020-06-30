# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here

  # your enhancements here

end

class MyBoard < Board
  # your enhancements here

end

class MyTetris < Tetris
  # your enhancements here

  def key_bindings
    super
    @root.bind('u', proc {self.rotate})
  end

  def rotate
    @board.rotate_clockwise
    @board.rotate_clockwise
  end
end


