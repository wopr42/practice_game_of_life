require 'guerilla_patch'
require 'matrix'

GuerillaPatch.patch(Matrix, 'MatrixExtensions') do
  def []=(x, y, value)
    @rows[x][y] = value
  end
end

class Board < Matrix
  def self.from_cucumber_table(table)
    rows(table.raw.map do |row|
      row.map { |cell| '.' == cell ? 0 : 1 }
    end)
  end

  def self.from_board(board)
    rows(board.to_a)
  end

  def self.neighbors_of(x,y)
    [].tap do |neighbors|
      (0..2).each do |i|
        (0..2).each do |j|
          neighbors << [x-1+i, y-1+j]
        end
      end
    end
  end

  def [](x,y)
    element(x,y) || 0
  end

  def cells_to_live
    [].tap do |to_live|
      each_with_index do |cell, x, y|
        count = living_neighbors(x,y) - cell
        to_live << [x,y] if 3 == count or (2 == count and 1 == self[x,y])
      end
    end
  end

  def center
    self[(row_size / 2).floor, (column_size / 2).floor]
  end

  def evolve!
    to_live = cells_to_live
    reset!
    to_live.each { |x,y| self[x,y] = 1 }
    self
  end

  def living_neighbors(x,y)
    Board.neighbors_of(x,y).inject(0) do |sum, coordinates|
      sum + self[coordinates[0], coordinates[1]]
    end
  end

  def reset!
    each_with_index { |cell, x, y| self[x,y] = 0 }
  end
end
