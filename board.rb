class Board
  attr_accessor :grid

  def initialize(dim = 8)
    self.grid = Array.new(dim) { Array.new(dim) }
  end

  def [](pos)
    x, y = pos
    self.grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    self.grid[x][y] = piece
  end

end
