class Piece
  attr_accessor :color, :pos, :board, :king
  attr_reader :symbol

  def initialize(pos, board, color = nil, king = false)
    self.color = color
    self.color = pos[0] == (0 || 1) ?  :black : :white unless color
  end


end

pimp = Piece.new([5,3], 1)

p pimp.color
