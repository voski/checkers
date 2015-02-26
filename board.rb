require 'colorize'

class Board
  attr_accessor :grid

  def initialize(dim = 8)
    @dim = dim
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

  #fill board
  def add_piece(piece, pos)
    raise 'not empty' unless self[pos].nil?
    self[pos] = piece
  end
  #pawn promotion?
  #make move

  def valid_pos?(pos)
    raise 'Not a valid position' unless pos.is_a?(Array)
    pos.all? { |coord| coord.between?(0, @dim - 1) }
  end

  def info(dest)
    raise 'invalid pos' unless valid_pos?(dest)
    target = self[dest]
    if target == nil
      return :empty
    else
      return target
    end
  end
end



#
# puts 'Color This'.colorize(color: :red,  background: :light_magenta)
