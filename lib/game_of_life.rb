require 'matrix'

class Board
  def initialize(table)
    @board = Matrix[*table]
  end

  def center
    @board[@board.row_size / 2, @board.column_size / 2]
  end

  def evolve!
  end
end
